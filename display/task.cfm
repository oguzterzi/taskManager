<cfprocessingdirective pageencoding="utf-8">

<cfquery name="listTasks" datasource="test">
    SELECT 
        T.ID,
        T.TITLE,
        T.DESCRIPTION,
        T.USER_ID,
        U.NAME AS USER_NAME,
        U.SURNAME AS USER_SURNAME,
        T.STATUS_ID,
        T.RECORD_DATE,
        T.UPDATE_DATE,
        S.STATUS_NAME,
        S.STATUS_COLOR
    FROM TASKS T
    LEFT JOIN STATUS S ON T.STATUS_ID = S.ID
    LEFT JOIN USERS U ON T.USER_ID = U.ID
</cfquery>

<cfquery name="listStatus" datasource="test">
    SELECT ID, STATUS_NAME, STATUS_COLOR FROM STATUS
</cfquery>

<cfquery name="listUsers" datasource="test">
    SELECT ID, NAME, SURNAME FROM USERS
</cfquery>

<!DOCTYPE html>
<html lang="tr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Görevler</title>
    <link rel="stylesheet" href="https://cdn.datatables.net/2.3.5/css/dataTables.dataTables.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body>

<cfinclude template="../navbar.cfm">

<div class="card mx-5 mt-5">
    <div class="card-body">

        <h1 class="card-title text-center">Görevler</h1>

        <button type="button" class="btn btn-primary mb-3" data-bs-toggle="modal" data-bs-target="#addTaskModal">
            Görev Ekle
        </button>

        <table id="example" class="display">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Başlık</th>
                    <th>Açıklama</th>
                    <th>Kişi</th>
                    <th>Durum</th>
                    <th>Kayıt Tarihi</th>
                    <th>Güncelleme Tarihi</th>
                    <th>Güncelle</th>
                    <th>Sil</th>
                </tr>
            </thead>

            <tbody>
                <cfoutput query="listTasks">
                    <tr>
                        <td>#ID#</td>
                        <td>#TITLE#</td>
                        <td>#DESCRIPTION#</td>
                        <td>#USER_NAME# #USER_SURNAME#</td>
                        <td>
                            <span class="badge" style="background:#STATUS_COLOR#;">#STATUS_NAME#</span>
                        </td>
                        <td>#dateFormat(RECORD_DATE,"dd/mm/yyyy")# #timeFormat(RECORD_DATE,"HH:mm")#</td>
                        <td>#dateFormat(UPDATE_DATE,"dd/mm/yyyy")# #timeFormat(UPDATE_DATE,"HH:mm")#</td>

                        <td>
                            <button 
                                type="button" 
                                class="btn btn-warning"
                                data-bs-toggle="modal" 
                                data-bs-target="##updTaskModal"
                                data-id="#ID#"
                                data-title="#TITLE#"
                                data-desc="#DESCRIPTION#"
                                data-user="#USER_ID#"
                                data-status="#STATUS_ID#"
                            >
                                Güncelle
                            </button>
                        </td>

                        <td>
                            <button class="btn btn-danger" onclick="deleteTask(#ID#)">Sil</button>
                        </td>
                    </tr>
                </cfoutput>
            </tbody>
        </table>

    </div>
</div>

<div class="modal fade" id="addTaskModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">

            <div class="modal-header">
                <h5 class="modal-title">Görev Ekle</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>

            <form method="post" action="../query/add_task.cfm">
                <div class="modal-body">

                    <div class="mb-3">
                        <label class="form-label">Başlık</label>
                        <input type="text" name="TITLE" class="form-control" required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Açıklama</label>
                        <textarea name="DESCRIPTION" class="form-control" required></textarea>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Göreve Atanan Kişi</label>
                        <select name="USER_ID" class="form-control" required>
                            <cfoutput query="listUsers">
                                <option value="#ID#">#NAME# #SURNAME#</option>
                            </cfoutput>
                        </select>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Durum</label>
                        <select name="STATUS_ID" class="form-control" required>
                            <cfoutput query="listStatus">
                                <option value="#ID#">#STATUS_NAME#</option>
                            </cfoutput>
                        </select>
                    </div>

                </div>

                <div class="modal-footer">
                    <button type="submit" class="btn btn-primary">Kaydet</button>
                </div>

            </form>

        </div>
    </div>
</div>

<div class="modal fade" id="updTaskModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">

            <div class="modal-header">
                <h5 class="modal-title">Görevi Güncelle</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>

            <form method="post" action="../query/upd_task.cfm">
                <div class="modal-body">

                    <input type="hidden" name="ID" id="upd_id">

                    <div class="mb-3">
                        <label class="form-label">Başlık</label>
                        <input type="text" name="TITLE" id="upd_title" class="form-control" required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Açıklama</label>
                        <textarea name="DESCRIPTION" id="upd_desc" class="form-control" required></textarea>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Göreve Atanan Kişi</label>
                        <select name="USER_ID" id="upd_user" class="form-control">
                            <cfoutput query="listUsers">
                                <option value="#ID#">#NAME# #SURNAME#</option>
                            </cfoutput>
                        </select>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Durum</label>
                        <select name="STATUS_ID" id="upd_status" class="form-control">
                            <cfoutput query="listStatus">
                                <option value="#ID#">#STATUS_NAME#</option>
                            </cfoutput>
                        </select>
                    </div>

                </div>

                <div class="modal-footer">
                    <button type="submit" class="btn btn-primary">Güncelle</button>
                </div>

            </form>

        </div>
    </div>
</div>

</body>
</html>

<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<script src="https://cdn.datatables.net/2.3.5/js/dataTables.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<script>
    new DataTable('#example');

    document.getElementById('updTaskModal').addEventListener('show.bs.modal', function(event) {
        var b = event.relatedTarget;
        document.getElementById('upd_id').value      = b.getAttribute('data-id');
        document.getElementById('upd_title').value   = b.getAttribute('data-title');
        document.getElementById('upd_desc').value    = b.getAttribute('data-desc');
        document.getElementById('upd_user').value    = b.getAttribute('data-user');
        document.getElementById('upd_status').value  = b.getAttribute('data-status');
    });

    function deleteTask(ID) {
        Swal.fire({
            title: "Emin misiniz?",
            text: "Görev kalıcı olarak silinecek!",
            icon: "warning",
            showCancelButton: true,
            confirmButtonColor: "#4ec24e",
            cancelButtonColor: "#d33",
            confirmButtonText: "Evet, Sil",
            cancelButtonText: "İptal"
        }).then((result) => {
            if (result.isConfirmed) {
                Swal.fire({
                    title: "Silindi!",
                    text: "Görev başarıyla silindi.",
                    icon: "success"
                }).then(() => {
                    window.location.assign("../query/del_task.cfm?ID=" + ID);
                });
            }
        });
    }
</script>
