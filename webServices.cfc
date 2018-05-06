<cfcomponent>
	
	<cffunction name="add" access="remote">
		<cfargument name="firstName"   type="string" required="true" />
		<cfargument name="middleName"  type="string" required="true" />
		<cfargument name="lastName"    type="string" required="true" />
		<cfargument name="phoneNumber" type="string" required="true" />
		<!---cfargument name="email"       type="string" required="true" />
		<cfargument name="password"    type="string" required="true" /--->
		
		<cfquery datasource="dsnYumasoft" username="root" password="root">
            insert into users(firstName,middleName,lastName,phoneNumber,email,password)
            values (
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.firstName#">,
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.middleName#">,
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.lastName#">,
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.phoneNumber#">,
                '',''
                <!---cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.email#">,
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.password#"--->
            )
        </cfquery>
	</cffunction>
	
	<cffunction name="print" access="remote" returnformat="JSON">	
		<cfquery name="selectAll" datasource="dsnYumasoft" username="root" password="root">
            select *
            from users;
        </cfquery>
        <cfreturn selectAll />
	</cffunction>
	
	<cffunction name="delete" access="remote">	
	    <cfargument name="del_id" type="numeric" required="true"/>
		<cfquery datasource="dsnYumasoft" username="root" password="root">
            delete from users
            where id = <cfqueryparam cfsqltype="cf_sql_bigint" value="#arguments.del_id#">
        </cfquery>
	</cffunction>
	
	<cffunction name="get" access="remote" returnformat="JSON">	
	    <cfargument type="numeric" required="true" name="get_id" />
	    
	    <cfquery name="info" datasource="dsnYumasoft" username="root" password="root">
            select * 
            from users
            where id = <cfqueryparam cfsqltype="cf_sql_bigint" value="#arguments.get_id#">
        </cfquery>
        <cfreturn info />
	</cffunction>
	
	<cffunction name="edit" access="remote">	
	    <cfargument type="numeric" required="true" name="edit_id" />
	    <cfargument type="string" required="true" name="firstName" />
	    <cfargument type="string" required="true" name="middleName" />
	    <cfargument type="string" required="true" name="lastName" />
	    <cfargument type="string" required="true" name="phoneNumber" />
	    <cfargument type="string" required="true" name="email" />
	    <cfargument type="string" required="true" name="password" />
	    
        <cfquery datasource="dsnYumasoft" username="root" password="root">
            update users  
            set firstName    = <cfqueryparam cfsqltype="cf_sql_char"   value="#arguments.firstName#">,
                middleName   = <cfqueryparam cfsqltype="cf_sql_char"   value="#arguments.middleName#">,
                lastName     = <cfqueryparam cfsqltype="cf_sql_char"   value="#arguments.lastName#">,
                phoneNumber  = <cfqueryparam cfsqltype="cf_sql_char"   value="#arguments.phoneNumber#">,
                email        = <cfqueryparam cfsqltype="cf_sql_char"   value="#arguments.email#">,
                password     = <cfqueryparam cfsqltype="cf_sql_char"   value="#arguments.password#">
            where id = <cfqueryparam cfsqltype="cf_sql_bigint" value="#arguments.edit_id#">
        </cfquery>
        
	</cffunction>
	
</cfcomponent>