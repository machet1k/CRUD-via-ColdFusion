<cfcomponent>
	
	<cffunction name="add" access="remote">
		<cfargument name="firstName"   type="string" required="true" />
		<cfargument name="middleName"  type="string" required="true" />
		<cfargument name="lastName"    type="string" required="true" />
		<cfargument name="phoneNumber" type="string" required="true" />
		
		<cfset errArray = ArrayNew(1)>
		
		<cfif len(trim(arguments.firstName)) eq 0>
		    <cfset ArrayAppend(errArray, "First name is required.")>
		</cfif>
		<cfif len(trim(arguments.middleName)) eq 0>
		    <cfset ArrayAppend(errArray, "Middle name is required.")>
		</cfif>
		<cfif len(trim(arguments.lastName)) eq 0>
		    <cfset ArrayAppend(errArray, "Last name is required.")>
		</cfif>
		<cfif len(trim(arguments.phoneNumber)) eq 0>
		    <cfset ArrayAppend(errArray, "Phone number is required.")>
		</cfif>
		
		<cfif ArrayLen(errArray) eq 0>
            <cfquery datasource="dsnYumasoft" username="root" password="root">
                insert into users(firstName,middleName,lastName,phoneNumber,email,password)
                values (
                    <cfqueryparam maxLength="45" cfsqltype="cf_sql_varchar" value="#arguments.firstName#">,
                    <cfqueryparam maxLength="45" cfsqltype="cf_sql_varchar" value="#arguments.middleName#">,
                    <cfqueryparam maxLength="45" cfsqltype="cf_sql_varchar" value="#arguments.lastName#">,
                    <cfqueryparam maxLength="45" cfsqltype="cf_sql_varchar" value="#arguments.phoneNumber#">,
                    '','')
            </cfquery>
        <cfelse>
            <cfloop array="#errArray#" item="i">
                <cfoutput>#i#</cfoutput>
            </cfloop> 
        </cfif>
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
		
	<cffunction name="firstName_asc" access="remote" returnformat="JSON">	
		<cfquery name="selectAll" datasource="dsnYumasoft" username="root" password="root">
            select *
            from users
            order by firstName asc;
        </cfquery>
        <cfreturn selectAll />
	</cffunction>
	
	<cffunction name="middleName_asc" access="remote" returnformat="JSON">	
		<cfquery name="selectAll" datasource="dsnYumasoft" username="root" password="root">
            select *
            from users
            order by middleName asc;
        </cfquery>
        <cfreturn selectAll />
	</cffunction>
	
	<cffunction name="lastName_asc" access="remote" returnformat="JSON">	
		<cfquery name="selectAll" datasource="dsnYumasoft" username="root" password="root">
            select *
            from users
            order by lastName asc;
        </cfquery>
        <cfreturn selectAll />
	</cffunction>
	
	<cffunction name="phoneNumber_asc" access="remote" returnformat="JSON">	
		<cfquery name="selectAll" datasource="dsnYumasoft" username="root" password="root">
            select *
            from users
            order by phoneNumber asc;
        </cfquery>
        <cfreturn selectAll />
	</cffunction>
	
	<cffunction name="regDate_asc" access="remote" returnformat="JSON">	
		<cfquery name="selectAll" datasource="dsnYumasoft" username="root" password="root">
            select *
            from users
            order by regDate asc;
        </cfquery>
        <cfreturn selectAll />
	</cffunction>
	
	<cffunction name="firstName_desc" access="remote" returnformat="JSON">	
		<cfquery name="selectAll" datasource="dsnYumasoft" username="root" password="root">
            select *
            from users
            order by firstName desc;
        </cfquery>
        <cfreturn selectAll />
	</cffunction>
	
	<cffunction name="middleName_desc" access="remote" returnformat="JSON">	
		<cfquery name="selectAll" datasource="dsnYumasoft" username="root" password="root">
            select *
            from users
            order by middleName desc;
        </cfquery>
        <cfreturn selectAll />
	</cffunction>
	
	<cffunction name="lastName_desc" access="remote" returnformat="JSON">	
		<cfquery name="selectAll" datasource="dsnYumasoft" username="root" password="root">
            select *
            from users
            order by lastName desc;
        </cfquery>
        <cfreturn selectAll />
	</cffunction>
	
	<cffunction name="phoneNumber_desc" access="remote" returnformat="JSON">	
		<cfquery name="selectAll" datasource="dsnYumasoft" username="root" password="root">
            select *
            from users
            order by phoneNumber desc;
        </cfquery>
        <cfreturn selectAll />
	</cffunction>
	
	<cffunction name="regDate_desc" access="remote" returnformat="JSON">	
		<cfquery name="selectAll" datasource="dsnYumasoft" username="root" password="root">
            select *
            from users
            order by regDate desc;
        </cfquery>
        <cfreturn selectAll />
	</cffunction>
	
</cfcomponent>