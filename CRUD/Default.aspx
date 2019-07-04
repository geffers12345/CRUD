<%@ Page Title="Home Page" Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="CRUD._Default" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <title>CRUD</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
        <style>
            .modal .col-md-12 {
                margin-bottom: 2%;
            }

            #tbody td button {
                margin-left: 2%;
            }
        </style>
    </head>
<body>
    <div class="container">
        <h2>Basic CRUD</h2>
        <p>The .table class adds basic styling (light padding and only horizontal dividers) to a table:</p> 
        <div class="row">
            <div class="col-md-12">
                <!-- Trigger the modal with a button -->
                <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#myModal">Add New User</button>
            </div>
            <div class="col-md-12">
                <table class="table table-bordered" style="margin-top: 3%">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Firstname</th>
                            <th>Lastname</th>
                            <th>Email</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody id="tbody">
                        <tr>
                            <td>John</td>
                            <td>Doe</td>
                            <td>john@example.com</td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
        <!-- Modal -->
        <div class="modal fade" id="myModal" role="dialog">
            <div class="modal-dialog modal-md">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Modal Header</h4>
                    </div>
                    <div class="modal-body">
                        <div class="col-md-12">
                            <label>Firstname</label>
                            <input type="text" class="form-control" placeholder="Firstname" id="fname" />
                        </div>
                        <div class="col-md-12">
                            <label>Lastname</label>
                            <input type="text" class="form-control" placeholder="Lastname" id="lname" />
                        </div>
                        <div class="col-md-12">
                            <label>Email Address</label>
                            <input type="text" class="form-control" placeholder="Email" id="email" />
                        </div>
                    </div>
                    <div class="modal-footer" style="margin-top: 1%">
                        <div class="col-md-12">
                            <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
                            <button type="button" class="btn btn-success" id="save">Save</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="modal fade" id="viewModal" role="dialog">
            <div class="modal-dialog modal-md">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">User Info</h4>
                    </div>
                    <div class="modal-body">
                        <div class="col-md-12">
                            <label>Firstname</label>
                            <input type="text" class="form-control" placeholder="Firstname" id="fnameView" />
                        </div>
                        <div class="col-md-12">
                            <label>Lastname</label>
                            <input type="text" class="form-control" placeholder="Lastname" id="lnameView" />
                        </div>
                        <div class="col-md-12">
                            <label>Email Address</label>
                            <input type="text" class="form-control" placeholder="Email" id="emailView" />
                        </div>
                    </div>
                    <div class="modal-footer" style="margin-top: 1%">
                        <div class="col-md-12">
                            <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="modal fade" id="editModal" role="dialog">
            <div class="modal-dialog modal-md">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Modify User</h4>
                    </div>
                    <div class="modal-body">
                        <div class="col-md-12">
                            <label>Firstname</label>
                            <input type="text" class="form-control" placeholder="Firstname" id="fnameEdit" />
                        </div>
                        <div class="col-md-12">
                            <label>Lastname</label>
                            <input type="text" class="form-control" placeholder="Lastname" id="lnameEdit" />
                        </div>
                        <div class="col-md-12">
                            <label>Email Address</label>
                            <input type="text" class="form-control" placeholder="Email" id="emailEdit" />
                        </div>
                    </div>
                    <div class="modal-footer" style="margin-top: 1%">
                        <div class="col-md-12">
                            <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
                            <button type="button" class="btn btn-success" id="saveChanges">Save Changes</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </div>
</body>
<script>
    var id = 0;

    $(document).ready(function () {
        get();
    });

    function get() {
        $('#tbody').text('');
        $.ajax({
            type: "POST",
            url: "Default.aspx/get",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (data) {
                $('#tbody').append(data.d);
            },
            error: function () { alert("Ajax Error"); }
        });
    }

    $(document).on('click', '#save', function (e) {
        e.preventDefault();

        $.ajax({
            type: "POST",
            dataType: "json",
            contentType: "application/json; charset=utf-8",
            data: "{'fname':'" + $('#fname').val() + "', 'lname':'" + $('#lname').val() + "', 'email':'" + $('#email').val() + "'}",
            url: "Default.aspx/insert",
            success: function (data) {
                alert("added!");
                get();
                $('.close').trigger('click');
            },
            error: function (error) {
                console.log(error);
            }
        });

    });

    $(document).on('click', '.view', function () {
        id = $(this).data('id');

        $.ajax({
            type: "POST",
            url: "Default.aspx/find",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            data: "{'id':'" + id + "'}",
            success: function (data) {
                $('#fnameView').val(data.d[1]);
                $('#lnameView').val(data.d[2]);
                $('#emailView').val(data.d[3]);

                $('#viewModal .form-control').prop("disabled", true);
            },
            error: function () { alert("Ajax Error"); }
        });
    });

    $(document).on('click', '.edit', function () {
        id = $(this).data('id');

        $.ajax({
            type: "POST",
            url: "Default.aspx/find",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            data: "{'id':'" + id + "'}",
            success: function (data) {
                $('#fnameEdit').val(data.d[1]);
                $('#lnameEdit').val(data.d[2]);
                $('#emailEdit').val(data.d[3]);
            },
            error: function () { alert("Ajax Error"); }
        });
    });

    $(document).on('click', '#saveChanges', function (e) {
        e.preventDefault();

        $.ajax({
            type: "POST",
            dataType: "json",
            contentType: "application/json; charset=utf-8",
            data: "{'id': '" + id + "', 'fname':'" + $('#fnameEdit').val() + "', 'lname':'" + $('#lnameEdit').val() + "', 'email':'" + $('#emailEdit').val() + "'}",
            url: "Default.aspx/update",
            success: function (data) {
                alert("updated!");
                $('.close').trigger('click');
                get();
            },
            error: function (error) {
                console.log(error);
            }
        });

    });

    $(document).on('click', '.remove', function () {
        id = $(this).data('id');
        $.ajax({
            type: "POST",
            dataType: "json",
            contentType: "application/json; charset=utf-8",
            data: "{'id': '" + id + "'}",
            url: "Default.aspx/delete",
            success: function (data) {
                alert("deleted!");
                $('.close').trigger('click');
                get();
            },
            error: function (error) {
                console.log(error);
            }
        });
    });
</script>
</html>
