<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8" />
	<title>Test application</title>
	<link href="./style.css" rel="stylesheet" />
	<link href="https://fonts.googleapis.com/css?family=Caveat|Philosopher" rel="stylesheet">
	<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
</head>
<body>
   
    <header>Header</header>
    
    <div id='content'>
        <!--- 
             Блок переменных 
        --->
        <cfset request.dsn = "dsnYumasoft">
        <cfset request.un = "root">
        <cfset request.pw = "root">
        <cfset firstName = "">
        <cfset middleName = "">
        <cfset lastName = "">
        <cfset phoneNumber = "">
        <cfset email = "">
        <cfset password = "">
        
        <form method="post" action="/Test/index.cfm">
            <!--- 
                Если URL содержит id (и id является числом)
                то выполняем запрос в БД (userById): подтягиваем данные по id
            --->     
            <cfif IsDefined("url.id") and IsNumeric(url.id)>
                <cfquery name="userById" datasource="#request.dsn#" username="#request.un#" password="#request.pw#">
                    select * 
                    from users
                    where id = <cfqueryparam cfsqltype="cf_sql_bigint" value="#url.id#">                
                </cfquery>
                <!--- 
                     Сохранение данных вытянутого пользователя в переменные 
                --->
                <cfset firstName   = userById.firstName>
                <cfset middleName  = userById.middleName>
                <cfset lastName    = userById.lastName>
                <cfset phoneNumber = userById.phoneNumber>
                <cfset email       = userById.email>
                <cfset password    = userById.password>
                <!--- 
                     Добавляем в форму скрытый параметр id со значением url.id  
                --->
                <input type="hidden" name="id" value="<cfoutput>#url.id#</cfoutput>">
            </cfif>
            <!---
                 Если в форме имеется скрытый параметр id
                 то выполняем запрос в БД на ИЗМЕНЕНИЕ данных 
                 пользователя с id = form.id на данные, которые содержатся в форме 
            --->
            <cfif IsDefined("form.id")>
                <cfquery datasource="#request.dsn#" username="#request.un#" password="#request.pw#">
                    update users  
                    set firstName    = <cfqueryparam cfsqltype="cf_sql_char" value="#form.firstName#">,
                        middleName   = <cfqueryparam cfsqltype="cf_sql_char" value="#form.middleName#">,
                        lastName     = <cfqueryparam cfsqltype="cf_sql_char" value="#form.lastName#">,
                        phoneNumber  = <cfqueryparam cfsqltype="cf_sql_char" value="#form.phoneNumber#">,
                        email        = <cfqueryparam cfsqltype="cf_sql_char" value="#form.email#">,
                        password     = <cfqueryparam cfsqltype="cf_sql_char" value="#form.password#">
                    where id = <cfqueryparam cfsqltype="cf_sql_bigint" value="#form.id#">
                </cfquery>
            <!--- 
                 Иначе (если в форме нет скрытого параметра id) 
                 если переменные формы определены (существуют) 
            --->
            <cfelseif IsDefined("form.firstName") and IsDefined("form.middleName") and IsDefined("form.lastName") and IsDefined("form.phoneNumber") and IsDefined("form.email") and IsDefined("form.password")>
                <!--- 
                     то выполняем запрос в БД на добавление нового пользователя с данными из формы
                --->
                <cfquery datasource="#request.dsn#" username="#request.un#" password="#request.pw#">
                    insert into users(firstName,middleName,lastName,phoneNumber,email,password)
                    values (
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.firstName#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.middleName#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.lastName#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.phoneNumber#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.email#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.password#">
                    )
                </cfquery>
            </cfif>
            <!--- 
                 Если URL содержит did (и did является числом)  
                 Выполняем запрос в БД на УДАЛЕНИЕ пользователя с id = url.did
            --->
            <cfif IsDefined("url.did") and IsNumeric(url.did)>
                <cfquery name="userById" datasource="#request.dsn#" username="#request.un#" password="#request.pw#">
                    delete 
                    from users
                    where id = <cfqueryparam cfsqltype="cf_sql_bigint" value="#url.did#"> 
                </cfquery>
            </cfif>   

            <table class='tableUsers'>
                <tr>
                    <!--- Заголовки таблицы --->
                    <th>First name</th>
                    <th>Middle name</th>
                    <th>Last name</th>
                    <th>Phone number</th>
                    <th>Reg. date</th>
                    <th>Email</th>
                    <th>Password</th>
                    <th colspan="2">Actions</th>
                </tr>
                <!--- 
                     Запрос на ВЫГРУЗКУ всех пользователей из БД 
                     и сохранение в selectAll 
                --->
                <cfquery name="selectAll" datasource="#request.dsn#" username="#request.un#" password="#request.pw#">
                    select *
                    from users;
                </cfquery>
                <!--- 
                     ВЫВОД пользователей на экран 
                --->
                <cfloop index="row" from="1" to="#selectAll.RecordCount#">  
                    <tr>
                        <td><cfoutput>#selectAll["firstName"][row]#</cfoutput></td>
                        <td><cfoutput>#selectAll["middleName"][row]#</cfoutput></td>
                        <td><cfoutput>#selectAll["lastName"][row]#</cfoutput></td>
                        <td><cfoutput>#selectAll["phoneNumber"][row]#</cfoutput></td>
                        <td><cfoutput>#selectAll["regDate"][row]#</cfoutput></td>
                        <td><cfoutput>#selectAll["email"][row]#</cfoutput></td>
                        <td><cfoutput>#selectAll["password"][row]#</cfoutput></td>
                        <td style="width: 50px">
                            <!--- Параметр для редактирования ?id=some_id --->
                            <a href="/Test/index.cfm?id=<cfoutput>#selectAll['id'][row]#</cfoutput>">
                                <img src="https://cdn4.iconfinder.com/data/icons/48-bubbles/48/15.Pencil-20.png" alt="">
                            </a>
                        </td>
                        <td style="width: 50px">
                           <!--- Параметр для удаления ?did=some_id --->
                            <a href="/Test/index.cfm?did=<cfoutput>#selectAll['id'][row]#</cfoutput>">
                                <img src="https://cdn4.iconfinder.com/data/icons/e-commerce-icon-set/48/Remove_2-20.png" alt="">
                            </a>
                        </td>
                    </tr>
                </cfloop>            
                <!--- 
                     Строка с формой для ДОБАВЛЕНИЯ новых и РЕДАКТИРОВАНИЯ имеющихся пользователей webServices.cfc 
                --->
                <tr>
                    <td><input type="text"     name="firstName"   value="<cfoutput>#firstName#</cfoutput>"></td>
                    <td><input type="text"     name="middleName"  value="<cfoutput>#middleName#</cfoutput>"></td>
                    <td><input type="text"     name="lastName"    value="<cfoutput>#lastName#</cfoutput>"></td>
                    <td><input type="text"     name="phoneNumber" value="<cfoutput>#phoneNumber#</cfoutput>"></td>
                    <td><input type="text"     name="regDate"     value="Not yet registered" disabled></td>
                    <td><input type="email"    name="email"       value="<cfoutput>#email#</cfoutput>"></td>
                    <td><input type="password" name="password"    value="<cfoutput>#password#</cfoutput>"></td>
                    <td colspan="2">
                        <input type="submit"   name="submit"      value=" Add / Edit " id="add_btn">
                    </td>
                </tr>
            </table>
        </form> 
    </div>
    
    <footer>Footer</footer>
    
</body>
</html>