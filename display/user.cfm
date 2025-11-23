<cfprocessingdirective pageencoding="utf-8">
<cfquery name="listUser" datasource="test">
    SELECT * FROM USERS
</cfquery>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Çalışanlar</title>
    <link rel="stylesheet" href="https://cdn.datatables.net/2.3.5/css/dataTables.dataTables.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <cfinclude template="../navbar.cfm">
    <div class="card mx-5 mt-5" style="margin: 10px 10px 10px 10px">
        <div class="card-body">

            <h1 class="card-title text-center">Çalışanlar</h1>

            <button type="button" class="btn btn-primary mb-3" data-bs-toggle="modal" data-bs-target="#add_userModal">
                Çalışan Ekle
            </button>

            <table id="example" class="display">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Ad</th>
                        <th>Soyad</th>
                        <th>Email</th>
                        <th>Kayıt Tarihi</th>
                        <th>Güncelleme Tarihi</th>
                        <th>Güncelle</th>
                        <th>Sil</th>
                    </tr>
                </thead>

                <tbody>
                    <cfoutput query="listUser">
                        <tr>
                            <td>#ID#</td>
                            <td>#NAME#</td>
                            <td>#SURNAME#</td>
                            <td>#EMAIL#</td>
                            <td>#dateformat(RECORD_DATE, "dd/mm/yyyy")# #timeFormat(RECORD_DATE, 'HH:mm')#</td>
                            <td>#dateformat(UPDATE_DATE, "dd/mm/yyyy")# #timeFormat(UPDATE_DATE, 'HH:mm')#</td>
                            <td>
                                <button type="button" class="btn btn-warning"data-bs-toggle="modal" data-bs-target="##upd_userModal" data-id="#ID#" data-name="#NAME#" data-surname="#SURNAME#" data-email="#EMAIL#">
                                    Güncelle
                                </button>
                            </td>
                            <td>
                                <button class="btn btn-danger" onclick="deleteButton(#ID#)" data-id="#ID#">
                                    Sil
                                </button>
                            </td>
                        </tr>
                    </cfoutput>
                </tbody>
            </table>
        </div>
    </div>
    <!---Ekle Modal--->
    <div class="modal fade" id="add_userModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Çalışan Ekle</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <form method="post" action="../query/add_user.cfm">
                    <div class="modal-body">
                        <div class="mb-3">
                            <label class="form-label">Ad</label>
                            <input type="text" name="NAME" class="form-control" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Soyad</label>
                            <input type="text" name="SURNAME" class="form-control" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Email</label>
                            <input type="email" name="EMAIL" class="form-control" required>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="submit" class="btn btn-primary">Kaydet</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    
    <!---Güncelle Modal--->
    <div class="modal fade" id="upd_userModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Çalışanı Güncelle</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <form method="post" action="../query/upd_user.cfm">
                    <div class="modal-body">
                        <input type="hidden" name="ID" id="upd_id">
                        <div class="mb-3">
                            <label class="form-label">Ad</label>
                            <input type="text" name="NAME" id="upd_name" class="form-control" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Soyad</label>
                            <input type="text" name="SURNAME" id="upd_surname" class="form-control" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Email</label>
                            <input type="email" name="EMAIL" id="upd_email" class="form-control" required>
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

    document.getElementById('upd_userModal').addEventListener('show.bs.modal', function(event) {
        var button = event.relatedTarget;
        var id = button.getAttribute('data-id');
        var name = button.getAttribute('data-name');
        var surname = button.getAttribute('data-surname');
        var email = button.getAttribute('data-email');

        document.getElementById('upd_id').value = id;
        document.getElementById('upd_name').value = name;
        document.getElementById('upd_surname').value = surname;
        document.getElementById('upd_email').value = email;
    });

    function deleteButton(ID) {
        Swal.fire({
            title: "Silmek istediğinize emin misiniz?",
            text: "Çalışan kalıcı olarak silinecek!",
            icon: "warning",
            showCancelButton: true,
            confirmButtonColor: "#4ec24eff",
            cancelButtonColor: "#d33",
            confirmButtonText: "Evet, Sil!",
            cancelButtonText: "İptal"
        }).then((result) => {
            if (result.isConfirmed) {
                Swal.fire({
                    title: "Silindi!",
                    text: "Çalışan başarıyla silindi.",
                    icon: "success"
                }).then(() => {
                    window.location.assign("../query/del_user.cfm?ID=" + ID);
                })
            }
        })
    }
</script>