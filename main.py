from flask import Flask, render_template, request, session, redirect, json
import mysql.connector as c
import os

from werkzeug.utils import secure_filename

from datetime import datetime
now = datetime.now()
import jsonpickle
app = Flask(__name__)
con = c.connect(host='localhost', password='Ankit@123', user='root', database='onemeal')
app.secret_key = "Ankitsuper secret key"

app.config['location'] = "C:\\Users\\ankit\\PycharmProjects\\OneMeal\\static\\img"

#home
@app.route("/index")
@app.route("/")
def home():

    return render_template('index.html')



#login
@app.route("/login",methods=['GET','POST'])
def login():
    if request.method == 'POST' and 'email' in request.form and 'pass' in request.form:
        email = request.form['email']
        password = request.form['pass']
        cursor = con.cursor()
        # user login
        cursor.execute("select * from regc where email = '"+email+"' and pass = '"+password+"' ")
        user = cursor.fetchone()


        # Mess login
        cursor.execute("select * from regm where email = '" + email + "' and pass = '" + password + "' ")
        mess = cursor.fetchone()


        # admin login
        cursor.execute("select * from admin where username = '" + email + "' and pass = '" + password + "' ")
        admin = cursor.fetchone()


        # delivery login
        cursor.execute("select * from delivery where email = '" + email + "' and pass = '" + password + "' ")
        delivery = cursor.fetchone()
        cursor.close()


        if user:
            m = user
            session['name'] = m[1]
            session['email'] = m[3]
            return redirect('/ulogged')
        elif mess:
            m = mess
            session['mname'] = m[1]
            session['memail'] = m[3]

            return redirect('/mlogged')
        elif admin:
            session['aemail'] = admin[0]
            return redirect('/getliveorder')
        elif delivery:
            m = delivery
            session['delname'] = m[0]
            session['delemail'] = m[2]
            cursor = con.cursor()
            cursor.execute("update delivery set status='Active' where  email = '" + m[2] + "'")
            con.commit()


            return redirect('/delivery')
        else:
            message = 'Please enter correct email / password !'
            return render_template('login.html', message=message)

    return render_template('login.html')


#register
@app.route("/register",methods=['GET','POST'])
def register():

    if request.method == 'POST':
        registertype = request.form["registerType"]
        fname = request.form["fname"]
        lname = request.form["lname"]
        email = request.form["email"]
        passw = request.form["pass"]
        adds = request.form["adds"]
        mobno = request.form["mobno"]
        city = request.form["city"]
        state = request.form["state"]
        country = request.form["country"]
        if request.form["registerType"] == 'Customer':

            cursor = con.cursor()
            qry = "insert into regc values('{}','{}','{}','{}','{}','{}','{}','{}','{}','{}')".format(registertype,fname.capitalize(),lname.capitalize(),email,passw,adds,mobno,city,state,country)
            cursor.execute(qry)
            con.commit()
            cursor.close()
            return render_template('login.html')
        elif request.form["registerType"] == 'Mess':

            cursor = con.cursor()
            qry = "insert into regm values('{}','{}','{}','{}','{}','{}','{}','{}','{}','{}')".format(registertype,fname.capitalize(),lname.capitalize(),email,passw,adds,mobno,city,state,country)
            cursor.execute(qry)
            con.commit()
            cursor.close()

        return render_template('login.html')
    else:
        return render_template('register.html')

#contact page
@app.route("/contact" ,methods=['GET','POST'])
def contact():
    return render_template('contact.html')

#about page
@app.route("/about")
def about():
    return render_template('about.html')


#User Login
@app.route("/ulogged")
def ulogged():
    if not session.get("email") :
        redirect('/')
    else:

        cursor = con.cursor()
        cursor.execute("SELECT * from dailymenu")
        row = cursor.fetchall()
        cursor.execute("SELECT * from menu")
        data1 = cursor.fetchall()
        cursor.close()
        import json as json1

        return render_template('ulogged.html', data=row, module=json1, data1=data1)
    return redirect('/')



#User  edit profile
@app.route("/ueditprofile", methods=['GET','POST'] )
def ueditprofile():
    if not session.get("email") :
        redirect('/')
    else:
        cursor = con.cursor()
        e = session['email']
        cursor.execute("select * from regc where email= '"+e+"' ")
        m = cursor.fetchone()
        if request.method == 'POST':
            fname = request.form["fname"]
            lname = request.form["lname"]
            adds = request.form["adds"]
            mobno = request.form["mobno"]
            cursor = con.cursor()
            cursor.execute(" update regc set fname='"+fname.capitalize()+"' , lname='"+lname.capitalize()+"' ,adds='"+adds+"' , mob='"+mobno+"' where email='"+e+"'")
            con.commit()
            cursor.close()
            msg = "Data updated Successfully..!"
            return render_template('ueditprofile.html', msg=msg, data=m)
        return render_template('ueditprofile.html', data=m)
    return redirect('/')
#User insert into  Cart
@app.route("/uicart/<string:id1>/<string:memail>", methods=['GET','POST'] )
def uicart(id1,memail):
    if not session.get("email") :
        redirect('/')
    else:
        cursor = con.cursor()
        e = session['email']
        cursor.execute("insert into ucart values('{}','{}','{}')".format(id1, e, memail))
        con.commit()
        cursor.close()

        return redirect('/ucart')
    return redirect('/')

#User  Cart
@app.route("/ucart", methods=['GET','POST'] )
def ucart():
    if not session.get("email") :
        redirect('/')
    else:
        cursor = con.cursor()
        e = session['email']
        cursor.execute("select * from ucart where uemaill='"+e+"'")
        d = cursor.fetchall()

        cursor.execute("select * from dailymenu")
        d1 = cursor.fetchall()

        cursor.execute("SELECT * from menu")
        data1 = cursor.fetchall()

        total=0
        import json as json1


        for x in d:
            for i in d1:

                if x[0] == i[0]:

                    total +=i[6]
        return render_template("/ucart.html",data=d1,d=d,data1=data1,total=total,module=json1)
    return redirect('/')
# remove items from User  Cart
@app.route("/uremovecart/<string:id1>", methods=['GET','POST'] )
def uremovecart(id1):
    if not session.get("email") :
        redirect('/')
    else:
        cursor = con.cursor()
        cursor.execute("delete from ucart where id='"+id1+"'")
        con.commit()
        cursor.close()
        return redirect('/ucart')
    return redirect('/')

#Place  Order
@app.route("/liveorder/<string:total>",methods=['GET','POST'])
def liveorder(total):
    if not session.get("email") :
        redirect('/')
    else:
        menuog = " "
        cursor = con.cursor()
        e = session['email']
        cursor.execute("select * from regc where email= '" + e + "' ")
        u = cursor.fetchone()
        mob = u[6]
        adds = u[5]


        cursor.execute("select * from ucart where uemaill= '"+e+"' ")
        ucart1 = cursor.fetchall()

        cursor.execute("select * from menu ")
        menu = cursor.fetchall()

        cursor.execute("select * from dailymenu ")
        dailymenu = cursor.fetchall()


        for x in ucart1:
            for z in dailymenu:
                if x[0] == z[0]:
                    m = z[2]
                    result = ''.join(m).replace(',', '')

                    result = ''.join(result).replace('[', '')

                    result = ''.join(result).replace(']', '')

                    result = ''.join(result).replace(' ', '')

                    for v in menu:

                        for i in range(1, len(result)-1):

                            if str(v[0]) == str(result[i]):
                                menuog += str(v[1]) + ", "
            # live date and time
            date =now.strftime("%d/%m/%Y %H:%M:%S")
            cursor.execute("select * from regc where email= '" + e + "' ")
            u = cursor.fetchone()
            name = str(u[1]) +" " +str(u[2])


            memail = x[2]
            cursor.execute(
            "insert into liveorder(date,uemail,name,memail,menu,price,mstatus,dstatus,demail,umobile,adds) values('{}','{}','{}','{}','{}','{}','{}','{}','{}','{}','{}') ".format(date, e, name, memail, menuog,
                                                                                         total,"None","None","None",mob,adds))
        con.commit()
        cursor.execute("delete from ucart where uemaill= '"+e+"'")
        con.commit()
        cursor.close()
        return redirect("/uorderhistory")
    return redirect('/')
#User order History
@app.route("/uorderhistory" )
def uorderhistory():
    if not session.get("email") :
        redirect('/')
    else:
        cursor = con.cursor()
        e = session['email']
        cursor.execute("select * from orders where email='" + e + "'  ")
        m1 = cursor.fetchall()


        cursor.execute("select * from liveorder where uemail='"+e+"'  ")
        m = cursor.fetchall()
        if m:
            return render_template('uorderhistory.html', data=m1,data1=m)

        return render_template('uorderhistory.html',data=m1)
    return redirect('/')

#Cancel order
@app.route("/cancel/<string:id1>")
def cancel(id1):
    if not session.get("email") :
        redirect('/')
    else:
        cursor = con.cursor()

        cursor.execute("update liveorder set ustatus='Reject' where id='" + id1 + "' ")
        con.commit()
        cursor.execute("select * from liveorder  where id='" + id1 + "' ")
        d = cursor.fetchone()
        id2 = d[0]
        date = d[1]
        uemail = d[2]
        name = d[3]

        memail = d[4]
        menu = d[5]
        price = d[6]
        mstatus = d[7]
        dstatus = d[8]
        demail = d[9]
        ustatus = d[10]
        mob = d[11]
        adds = d[12]


        cursor.execute("insert into orders values('{}','{}','{}','{}','{}','{}','{}','{}','{}','{}','{}','{}','{}')".format(id2,date,uemail,name,memail,menu,price,mstatus,dstatus,demail,ustatus,mob,adds))
        con.commit()

        cursor.execute("delete from liveorder  where id='" + id1 + "' ")
        con.commit()
        return redirect('/uorderhistory')
    return redirect('/')
# User logout
@app.route("/logout" )
def logout():
    if not session.get("email") :
        redirect('/')
    else:
        session.pop('name', None)
        session.pop('email', None)
        return redirect('/')

    return redirect('/')

#Add Admin
@app.route("/addadmin", methods=['GET','POST'])
def addadmin():
    if not session.get("aemail") :
        redirect('/')
    else:
        cursor = con.cursor()
        cursor.execute("select * from admin ")
        a1 = cursor.fetchall()
        cursor.close()
        if request.method == 'POST':
            u = request.form['username']
            p= request.form['pass']
            cursor = con.cursor()
            cursor.execute("insert into admin values('{}','{}')".format(u,p))
            con.commit()
            cursor.close()
            cursor = con.cursor()
            cursor.execute("select * from admin ")
            a = cursor.fetchall()
            cursor.close()
            return render_template('addadmin.html', data=a)
        return render_template('addadmin.html', data=a1)
    return redirect('/')
#Add menu
@app.route("/amenu", methods=['GET','POST'])
def amenu():
    if not session.get("aemail") :
        redirect('/')
    else:
        cursor = con.cursor()
        cursor.execute("select * from menu ")
        c1 = cursor.fetchall()

        if request.method == 'POST':
            name = request.form['name']
            file = request.files['file1']
            file.save(os.path.join(app.config['location'], secure_filename(file.filename)))
            cat = request.form['cat']
            cursor.execute("insert into menu(name,cat,img) values('{}','{}','{}')".format(name.capitalize(), cat, file.filename))
            con.commit()
            cursor.execute("select * from menu ")
            c1 = cursor.fetchall()
            cursor.close()
            return render_template('amenu.html', data=c1)
        cursor.close()
        return render_template('amenu.html', data=c1)
    return redirect('/')

#update menu
@app.route("/umenu",methods=['GET','POST'])
def umenu():
    if not session.get("aemail") :
        redirect('/')
    else:
        cursor = con.cursor()
        cursor.execute("select * from menu ")
        c1 = cursor.fetchall()

        if request.method == 'POST':
            id1 = request.form['id']
            name = request.form['name']
            file = request.files['file1']
            file.save(os.path.join(app.config['location'], secure_filename(file.filename)))
            cat = request.form['cat']
            cursor.execute("update  menu set name='"+name.capitalize()+"', cat='"+cat+"',img='"+file.filename+"' where id='"+id1+"'")
            con.commit()
            cursor.execute("select * from menu ")
            c1 = cursor.fetchall()
            cursor.close()
            return redirect('/amenu')
        cursor.close()
        return redirect('/amenu')

    return redirect('/')
#remove menu
@app.route("/aremove/<string:id1>",methods=['GET','POST'])
def aremove(id1):
    if not session.get("aemail") :
        redirect('/')
    else:
        cursor = con.cursor()
        cursor.execute("delete from menu  where id='"+id1+"'")
        con.commit()
        cursor.close()
        return redirect('/amenu')
    return redirect('/')
#Add Delivery Boy


@app.route("/adddelivery", methods=['GET','POST'])
def adddelivery():
    if not session.get("aemail") :
        redirect('/')
    else:

        if request.method == 'POST':

            fname = request.form["fname"]
            lname = request.form["lname"]
            email = request.form["email"]
            passw = request.form["pass"]
            adds = request.form["adds"]
            mobno = request.form["mobno"]
            city = request.form["city"]
            state = request.form["state"]
            country = request.form["country"]
            status = "None"
            cursor = con.cursor()
            qry = "insert into delivery values('{}','{}','{}','{}','{}','{}','{}','{}','{}','{}')".format(fname.capitalize(),lname.capitalize(),email,passw,adds,mobno,city,state,country,status)
            cursor.execute(qry)
            con.commit()
            cursor.close()
            return render_template('adddelivery.html')

        return render_template('adddelivery.html')
    return redirect('/')


#Register customer data
@app.route("/cdata")
def cdata():
    if not session.get("aemail") :
        redirect('/')
    else:
        cursor = con.cursor()
        cursor.execute("select * from regc ")
        c = cursor.fetchall()
        cursor.close()
        return render_template('cdata.html', data=c)
    return redirect('/')
#Register Mess data
@app.route("/mdata")
def mdata():
    if not session.get("aemail") :
        redirect('/')
    else:
        cursor = con.cursor()
        cursor.execute("select * from regm ")
        c = cursor.fetchall()
        cursor.close()
        return render_template('mdata.html', data=c)
    return redirect('/')

#Live orders feaching for admin
@app.route("/getliveorder")
def getliveorder():
    if not session.get("aemail") :
        redirect('/')
    else:
        cursor = con.cursor()

        cursor.execute("select * from liveorder where mstatus= 'Accepted' ")
        a = cursor.fetchall()

        cursor.close()
        return render_template('liveorder.html', data=a)
    return redirect('/')


#avl delivery
@app.route("/avldelivery/<string:id1>")
def avldelivery(id1):
    if not session.get("aemail") :
        redirect('/')
    else:
        cursor = con.cursor()

        cursor.execute("select * from delivery where status= 'Active' ")
        a = cursor.fetchall()
        cursor.execute("select * from delivery where status= 'Assigned' ")
        b = cursor.fetchall()
        cursor.close()
        return render_template('avldelivery.html', adata=a,bdata=b,id1=id1)
    return redirect('/')

#Assigning Delivery Boy
@app.route("/assign/<string:id1>/<string:email>")
def assign(id1,email):
    if not session.get("aemail") :
        redirect('/')
    else:
        cursor = con.cursor()

        cursor.execute("update delivery set status= 'Assigned' where email='"+email+"' ")
        con.commit()
        cursor.execute("update liveorder set demail= '"+email+"' where id='" + id1 + "' ")
        con.commit()
        cursor.close()
        return redirect('/getliveorder')
    return redirect('/')
#Admin logout
@app.route("/alogout" )
def alogout():
    if not session.get("aemail") :
        redirect('/')
    else:
        session.pop('aemail', None)
        return redirect('/')
    return redirect('/')

#mess login
@app.route("/mlogged" )
def mlogged():
    if not session.get("memail") :
        redirect('/')
    else:

        cursor = con.cursor()
        e = session['memail']
        cursor.execute("select * from liveorder where memail='"+e+"'")
        m = cursor.fetchall()
        return render_template('mlogged.html',data=m)
    return redirect('/')







#mess  edit profile
@app.route("/meditprofile", methods=['GET','POST'] )
def meditprofile():
    if not session.get("memail") :
        redirect('/')
    else:
        cursor = con.cursor()
        e = session['memail']
        cursor.execute("select * from regm where email= '"+e+"' ")
        m = cursor.fetchone()
        if request.method == 'POST':
            fname = request.form["fname"]
            lname = request.form["lname"]
            adds = request.form["adds"]
            mobno = request.form["mobno"]
            cursor = con.cursor()
            cursor.execute(" update regm set fname='"+fname.capitalize()+"' , lname='"+lname.capitalize()+"' ,adds='"+adds+"' , mob='"+mobno+"' where email='"+e+"'")
            con.commit()
            cursor.close()
            msg = "Data updated Successfully..!"
            return render_template('meditprofile.html', msg=msg, data=m)
        return render_template('meditprofile.html', data=m)
    return redirect('/')

#mess Upload
@app.route("/uploadmenu" )
def uploadmenu():
    if not session.get("memail") :
        redirect('/')
    else:
        cursor = con.cursor()
        e = session['memail']
        cursor.execute("select * from menu where cat ='Bread'")
        m = cursor.fetchall()

        cursor.execute("select * from menu where cat ='Gravy'")
        m1 = cursor.fetchall()

        cursor.execute("select * from menu where cat ='Dry'")
        m2 = cursor.fetchall()

        cursor.execute("select * from menu where cat ='Sweets'")
        m3 = cursor.fetchall()

        cursor.execute("select * from menu where cat ='Salad'")
        m4 = cursor.fetchall()

        cursor.execute("select * from menu where cat ='Pickle'")
        m5 = cursor.fetchall()

        if m:
            return render_template('uploadmenu.html', data=m,data1=m1,data2=m2,data3=m3,data4=m4,data5=m5)

        return render_template('uploadmenu.html')
    return redirect('/')

#mess add to cart
@app.route("/macart/<string:id1>",methods=['GET','POST'])
def macart(id1):
    if not session.get("memail") :
        redirect('/')
    else:
        cursor = con.cursor()
        s = session['memail']
        cursor.execute("insert into cart values('{}','{}')".format(s,id1))
        con.commit()
        cursor.close()
        return redirect("/uploadmenu")

    return redirect('/')

#Mess Add New menu
@app.route("/mnewmenu", methods=['GET','POST'])
def mnewmenu():
    if not session.get("memail") :
        redirect('/')
    else:
        cursor = con.cursor()

        if request.method == 'POST':
            name = request.form['name']
            file = request.files['file1']
            file.save(os.path.join(app.config['location'], secure_filename(file.filename)))
            cat = request.form['cat']
            cursor.execute("insert into menu(name,cat,img) values('{}','{}','{}')".format(name.capitalize(), cat, file.filename))
            con.commit()

            cursor.close()
            return redirect("/uploadmenu")
        cursor.close()
        return redirect("/uploadmenu")
    return redirect('/')


#mess feaching data for  cart
@app.route("/mcart",methods=['GET','POST'])
def mcart():
    if not session.get("memail") :
        redirect('/')
    else:
        cursor = con.cursor()
        s = session['memail']
        cursor.execute("select * from cart where email='"+s+"'")
        data = cursor.fetchall()
        cursor.execute("select * from menu ")
        data1 = cursor.fetchall()

        cursor.close()
        return render_template("mcart.html", data=data,data1=data1)
    return redirect('/')
# mess remove cart
@app.route("/mcremove/<string:id1>",methods=['GET','POST'])
def mcremove(id1):
    if not session.get("memail") :
        redirect('/')
    else:
        cursor = con.cursor()
        s = session['memail']
        cursor.execute("delete from cart  where id='"+id1+"' and email='"+s+"'")
        con.commit()
        cursor.close()
        return redirect('/mcart')
    return redirect('/')

#mess order History
@app.route("/morderhistory" )
def morderhistory():
    if not session.get("memail") :
        redirect('/')
    else:
        cursor = con.cursor()
        e = session['memail']
        cursor.execute("select * from orders where memail='"+e+"'  ")
        m = cursor.fetchall()
        if m:
            return render_template('morderhistory.html', data=m)

        return render_template('morderhistory.html',msg="No Order Yet")
    return redirect('/')



# inserting dailymenu of mess into database
@app.route("/data", methods=['GET', 'POST'])
def data():
    if not session.get("memail") :
        redirect('/')
    else:
        if 'input_name' in request.form :

            cursor = con.cursor()
            me = session['memail']

            qtydict = request.form.to_dict()
            qty = list(qtydict.values())
            serialized_list_qty = json.dumps(qty)

            cart = request.form['cart']
            title = request.form['title']
            serialized_list_cart = json.dumps(cart)
            file = request.files['file1']

            file.save(os.path.join(app.config['location'], secure_filename(file.filename)))
            price = request.form['price']

            cursor.execute("insert into dailymenu(memail,cart,qty,poster,title,price) values('{}','{}','{}','{}','{}','{}')".format(me, serialized_list_cart, serialized_list_qty, file.filename,title,price))
            con.commit()
            cursor.execute("delete from cart where email ='"+me+"'")
            con.commit()
            cursor.close()

            return redirect('/mlogged')
        else:
            cursor = con.cursor()
            s = session['memail']
            cursor.execute("select * from cart where email='" + s + "'")
            data = cursor.fetchall()
            cursor.execute("select * from menu ")
            data1 = cursor.fetchall()

            cursor.close()

            msg = "Select Items  Menu First"
            return render_template("mcart.html", data=data, data1=data1,msg=msg)
    return redirect('/')

#mess accept order
@app.route("/maccept/<string:id1>" )
def maccept(id1):
    if not session.get("memail") :
        redirect('/')
    else:

        cursor = con.cursor()

        cursor.execute("update liveorder set mstatus='Accepted' where id='"+id1+"' ")
        con.commit()
        return redirect('/mlogged')
    return redirect('/')

# mess reject order
@app.route("/mreject/<string:id1>")
def mreject(id1):
    if not session.get("memail") :
        redirect('/')
    else:
        cursor = con.cursor()

        cursor.execute("update liveorder set mstatus='Reject' where id='" + id1 + "' ")
        con.commit()
        cursor.execute("select * from liveorder  where id='" + id1 + "' ")
        d = cursor.fetchone()
        id2 = d[0]
        date = d[1]
        uemail = d[2]
        name = d[3]

        memail = d[4]
        menu = d[5]
        price = d[6]
        mstatus = d[7]
        dstatus = d[8]
        demail = d[9]
        ustatus = "None"


        cursor.execute("insert into orders values('{}','{}','{}','{}','{}','{}','{}','{}','{}','{}','{}')".format(id2,date,uemail,name,memail,menu,price,mstatus,dstatus,demail,ustatus))
        con.commit()

        cursor.execute("delete from liveorder  where id='" + id1 + "' ")
        con.commit()
        return redirect('/mlogged')
    return redirect('/')

#Mess logout
@app.route("/mlogout" )
def mlogout():
    if not session.get("memail") :
        redirect('/')
    else:
        session.pop('mname', None)
        session.pop('memail', None)
        return redirect('/')
    return redirect('/')



#Delivery Login
@app.route("/delivery" )
def delivery():
    if not session.get("delemail") :
        redirect('/')
    else:
        cursor = con.cursor()
        email = session['delemail']

        cursor.execute("select * from liveorder where demail='"+email+"' ")
        data1 = cursor.fetchone()
        cursor.close()
        return  render_template('delivery.html', data=data1)
    return redirect('/')

# Delivery Partner Canceled Order
@app.route("/dcancel/<string:id1>")
def dcancel(id1):
    if not session.get("delemail") :
        redirect('/')
    else:
        cursor = con.cursor()

        cursor.execute("update liveorder set dstatus='Reject' where id='" + id1 + "' ")
        con.commit()
        cursor.execute("select * from liveorder  where id='" + id1 + "' ")
        d = cursor.fetchone()
        id2 = d[0]
        date = d[1]
        uemail = d[2]
        name = d[3]

        memail = d[4]
        menu = d[5]
        price = d[6]
        mstatus = d[7]
        dstatus = d[8]
        demail = d[9]
        ustatus = "None"
        umobile = d[11]
        adds = d[12]


        cursor.execute("insert into orders values('{}','{}','{}','{}','{}','{}','{}','{}','{}','{}','{}','{}','{}')".format(id2,date,uemail,name,memail,menu,price,mstatus,dstatus,demail,ustatus,umobile,adds))
        con.commit()

        cursor.execute("delete from liveorder  where id='" + id1 + "' ")
        con.commit()
        return redirect('/delivery')
    return redirect('/')

#delivery Partner Reached To mess
@app.route("/dreach/<string:id1>")
def dreach(id1):
    if not session.get("delemail") :
        redirect('/')
    else:
        cursor = con.cursor()

        cursor.execute("update liveorder set dstatus='Reached' where id='" + id1 + "' ")
        con.commit()
        return redirect('/delivery')
    return redirect('/')

#delivery Partner collected To order
@app.route("/dcollect/<string:id1>")
def dcollect(id1):
    if not session.get("delemail") :
        redirect('/')
    else:
        cursor = con.cursor()

        cursor.execute("update liveorder set dstatus='Collect' where id='" + id1 + "' ")
        con.commit()
        return redirect('/delivery')
    return redirect('/')

# Delivery Partner Deliverd Order
@app.route("/ddelivered/<string:id1>")
def ddelivered(id1):
    if not session.get("delemail") :
        redirect('/')
    else:
        email = session['delemail']
        cursor = con.cursor()

        cursor.execute("update liveorder set dstatus='Delivered' where id='" + id1 + "' ")
        con.commit()
        cursor.execute("select * from liveorder  where id='" + id1 + "' ")
        d = cursor.fetchone()
        id2 = d[0]
        date = d[1]
        uemail = d[2]
        name = d[3]

        memail = d[4]
        menu = d[5]
        price = d[6]
        mstatus = d[7]
        dstatus = d[8]
        demail = d[9]
        ustatus = "None"
        umobile = d[11]
        adds = d[12]


        cursor.execute("insert into orders values('{}','{}','{}','{}','{}','{}','{}','{}','{}','{}','{}','{}','{}')".format(id2,date,uemail,name,memail,menu,price,mstatus,dstatus,demail,ustatus,umobile,adds))
        con.commit()

        cursor.execute("delete from liveorder  where id='" + id1 + "' ")
        con.commit()
        cursor.execute("update delivery set status= 'Active' where email='" + email + "' ")
        con.commit()
        return redirect('/delivery')
    return redirect('/')
#delivery logout
@app.route("/dlogout")
def dlogout():
    if not session.get("delemail") :
        redirect('/')
    else:
        em = session['delemail']
        cursor = con.cursor()
        cursor.execute("update delivery set status='offline' where email='"+em+"'")
        session.pop('delname', None)
        session.pop('delemail', None)
        return redirect('/')
    return redirect('/')


app.run(debug=True)


