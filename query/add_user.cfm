<cfquery name="add_user" datasource="test">
    INSERT INTO USERS
    (
        NAME,
        SURNAME,
        EMAIL,
        RECORD_DATE,
        RECORD_EMP
    )
    VALUES
    (
        <cfqueryparam value="#form.NAME#" cfsqltype="cf_sql_varchar">,
        <cfqueryparam value="#form.SURNAME#" cfsqltype="cf_sql_varchar">,
        <cfqueryparam value="#form.EMAIL#" cfsqltype="cf_sql_varchar">,
        <cfqueryparam value="#now()#" cfsqltype="cf_sql_timestamp">,
        <cfqueryparam value="1" cfsqltype="cf_sql_integer">
    )
</cfquery>
<cflocation  url="../display/user.cfm">