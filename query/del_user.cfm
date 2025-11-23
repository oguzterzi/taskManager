<cfquery name="del_user" datasource="test">
    DELETE FROM USERS
    WHERE ID = <cfqueryparam value="#url.ID#" cfsqltype="cf_sql_integer">
</cfquery>
<cflocation  url="../display/user.cfm">