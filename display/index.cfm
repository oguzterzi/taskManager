<cfprocessingdirective pageencoding="utf-8">

<!--- 1) ÇALIŞAN SAYISI --->
<cfquery name="countUsers" datasource="test">
    SELECT COUNT(*) AS totalUsers FROM USERS
</cfquery>

<!--- 2) TOPLAM GÖREV SAYISI --->
<cfquery name="countTasks" datasource="test">
    SELECT COUNT(*) AS totalTasks FROM TASKS
</cfquery>

<!--- 3) TAMAMLANAN GÖREV SAYISI (STATUS_ID = 3) --->
<cfquery name="doneTasks" datasource="test">
    SELECT COUNT(*) AS totalDone FROM TASKS WHERE STATUS_ID = 3
</cfquery>

<!--- 4) DEVAM EDEN GÖREV SAYISI (STATUS_ID = 2) --->
<cfquery name="activeTasks" datasource="test">
    SELECT COUNT(*) AS totalActive FROM TASKS WHERE STATUS_ID = 2
</cfquery>

<!--- 5) PIE CHART: Görev durumlarına göre toplam dağılım --->
<cfquery name="taskStatusCount" datasource="test">
    SELECT STATUS_ID, COUNT(*) AS countVal
    FROM TASKS
    GROUP BY STATUS_ID
</cfquery>

<!--- 6) COLUMN CHART: Aylık görev sayıları --->
<cfquery name="tasksByMonth" datasource="test">
    SELECT 
        MONTH(RECORD_DATE) AS MonthNumber,
        COUNT(*) AS TaskCount
    FROM TASKS
    GROUP BY MONTH(RECORD_DATE)
    ORDER BY MONTH(RECORD_DATE)
</cfquery>


<!DOCTYPE html>
<html lang="tr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard</title>

    <!--- ApexCharts --->
    <script src="https://cdn.jsdelivr.net/npm/apexcharts"></script>

    <!--- Bootstrap --->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

</head>

<body>

<cfinclude template="../navbar.cfm">

<div class="container mt-5">

    <h1 class="text-center mb-4">Dashboard</h1>

    <!--- KARTLAR --->
    <div class="row text-center">
        <cfoutput query="countUsers">
            <!--- Toplam Çalışan --->
            <div class="col-md-3">
                <div class="card shadow p-3">
                    <h5>Çalışan Sayısı</h5>
                    <h2>#countUsers.totalUsers#</h2>
                </div>
            </div>
        </cfoutput>
        <cfoutput query="countTasks">
        
        <!--- Toplam Görev --->
        <div class="col-md-3">
            <div class="card shadow p-3">
                <h5>Görev Sayısı</h5>
                <h2>#countTasks.totalTasks#</h2>
            </div>
        </div>
</cfoutput>
<cfoutput query="doneTasks">

        <!--- Tamamlanan Görev --->
        <div class="col-md-3">
            <div class="card shadow p-3">
                <h5>Tamamlanan Görev</h5>
                <h2>#doneTasks.totalDone#</h2>
            </div>
        </div>
</cfoutput>
<cfoutput query="activeTasks">

        <!--- Devam Eden Görev --->
        <div class="col-md-3">
            <div class="card shadow p-3">
                <h5>Devam Ediyor</h5>
                <h2>#activeTasks.totalActive#</h2>
            </div>
        </div>
</cfoutput>
    </div>


    <!--- PIE CHART --->
    <div class="card mt-5 p-3 shadow">
        <h4 class="text-center">Görev Durumu Dağılımı</h4>
        <div id="pieChart"></div>
    </div>

    <!--- COLUMN CHART --->
    <div class="card mt-5 p-3 shadow">
        <h4 class="text-center">Aylara Göre Görev Sayısı</h4>
        <div id="columnChart"></div>
    </div>

</div>


<!--- JS VERİ AKTARIMI --->

<script>
    /* ----------------------------------------------
       PIE CHART VERİLERİ
       CFQUERY sonuçlarını JS içinde kullanıyoruz
    ------------------------------------------------*/

    var pieSeries = [
        <cfoutput query="taskStatusCount">#countVal#,</cfoutput>
    ];

    var pieLabels = ["Yapılacak", "Devam Ediyor", "Tamamlandı"];

    var pieOptions = {
        chart: { type: 'pie', height: 350 },
        labels: pieLabels,
        series: pieSeries,
        colors: ['#0d6efd', '#ffc107', '#198754']
    };

    var pieChart = new ApexCharts(document.querySelector("#pieChart"), pieOptions);
    pieChart.render();

    var monthCategories = [
        <cfoutput query="tasksByMonth">"#MonthNumber#",</cfoutput>
    ];

    var monthData = [
        <cfoutput query="tasksByMonth">#TaskCount#,</cfoutput>
    ];

    var columnOptions = {
        chart: { type: 'bar', height: 350 },
        series: [{
            name: 'Görev Sayısı',
            data: monthData
        }],
        xaxis: {
            categories: monthCategories,
            title: { text: 'Ay' }
        },
        colors: ['#6610f2']
    };

    var columnChart = new ApexCharts(document.querySelector("#columnChart"), columnOptions);
    columnChart.render();
</script>
</body>
</html>