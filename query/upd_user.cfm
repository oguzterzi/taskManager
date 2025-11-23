<cfquery name="upd_user" datasource="test">
    UPDATE USERS
    SET NAME = <cfqueryparam value="#form.NAME#" cfsqltype="cf_sql_varchar">,
    SURNAME = <cfqueryparam value="#form.SURNAME#" cfsqltype="cf_sql_varchar">,
    UPDATE_DATE = <cfqueryparam value="#now()#" cfsqltype="cf_sql_timestamp">,
    UPDATE_EMP = <cfqueryparam value="1" cfsqltype="cf_sql_integer">
    WHERE ID = <cfqueryparam value="#form.ID#" cfsqltype="cf_sql_integer">
</cfquery>
<cflocation  url="../display/user.cfm"> 