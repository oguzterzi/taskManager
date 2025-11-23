<cfquery name="add_task" datasource="test">
    INSERT INTO TASKS
    (
        TITLE,
        DESCRIPTION,
        USER_ID,
        STATUS_ID,
        RECORD_DATE,
        RECORD_EMP
    )
    VALUES
    (
        <cfqueryparam value="#form.TITLE#" cfsqltype="cf_sql_varchar">,
        <cfqueryparam value="#form.DESCRIPTION#" cfsqltype="cf_sql_varchar">,
        <cfqueryparam value="#form.USER_ID#" cfsqltype="cf_sql_integer">,
        <cfqueryparam value="#form.STATUS_ID#" cfsqltype="cf_sql_integer">,
        <cfqueryparam value="#now()#" cfsqltype="cf_sql_timestamp">,
        <cfqueryparam value="1" cfsqltype="cf_sql_integer">
    )
</cfquery>
<cflocation  url="../display/task.cfm">