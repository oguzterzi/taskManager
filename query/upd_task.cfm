<cfquery name="upd_task" datasource="test">
    UPDATE TASKS
    SET TITLE = <cfqueryparam value="#form.TITLE#" cfsqltype="cf_sql_varchar">,
    DESCRIPTION = <cfqueryparam value="#form.DESCRIPTION#" cfsqltype="cf_sql_varchar">,
    USER_ID = <cfqueryparam value="#form.USER_ID#" cfsqltype="cf_sql_integer">,
    STATUS_ID = <cfqueryparam value="#form.STATUS_ID#" cfsqltype="cf_sql_integer">,
    UPDATE_DATE = <cfqueryparam value="#now()#" cfsqltype="cf_sql_timestamp">,
    UPDATE_EMP = <cfqueryparam value="1" cfsqltype="cf_sql_integer">
    WHERE ID = <cfqueryparam value="#form.ID#" cfsqltype="cf_sql_integer">
</cfquery>
<cflocation  url="../display/task.cfm"> 