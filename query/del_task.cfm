<cfquery name="del_task" datasource="test">
    DELETE FROM TASKS
    WHERE ID = <cfqueryparam value="#url.ID#" cfsqltype="cf_sql_integer">
</cfquery>
<cflocation  url="../display/task.cfm">