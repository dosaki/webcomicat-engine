<html>
    <head>
        <meta name="layout" content="main">
        <asset:stylesheet href="webcomicat.css"/>
        <asset:javascript src="webcomicat_mgmt.js"/>
        <asset:javascript src="libs/bootstrap/bootstrap.min.js"/>
    </head>

    <body>
        <div ng-app="webcomicat" ng-controller="AdminController">
            <div class="side-container">
                <ul class="nav nav-pills nav-stacked" role="tablist">
                    <li role="presentation"><a href="/manageComic">Comic Pages</a></li>
                    <li role="presentation"><a href="/manageComic/settings">Settings</a></li>
                    <li role="presentation" class="active"><a href="#">User Management</a></li>
                </ul>
            </div>
            <div class="main-container">
                <div id="errorMessages" class="{{feedbackMsg.type}}">
                    <button type="button" class="close" data-dismiss="alert">
                        <span aria-hidden="true">&times;</span>
                        <span class="sr-only">Close</span>
                    </button>
                    {{feedbackMsg.text}}
                </div>

                <div id="userList" class="content">
                    <table class="table">
                        <thead>
                            <th>
                                <a href="javascript:void(0)" ng-click="listOrderBy='username'; listOrder=!listOrder">
                                    Username
                                    <span ng-if="listOrderBy=='username'">
                                        <span ng-if="listOrder" class="glyphicon glyphicon-chevron-up"></span>
                                        <span ng-if="!listOrder" class="glyphicon glyphicon-chevron-down"></span>
                                    </span>
                                </a>
                            </th>
                            <th>
                                Roles
                            </th>
                            <th></th>
                        </thead>
                        <tbody>
                            <tr ng-repeat="user in users | orderBy : listOrderBy : listOrder">
                                <td>{{user.username}}</td>
                                <td>{{user.isAdmin ? "Administrator" : ""}} {{user.isUser ? "Normal User" : ""}}</td>
                                <td>
                                    <button class="btn btn-primary" data-toggle="modal" ng-click="editUser(user)" data-target="#editUserModal">
                                        <span class="glyphicon glyphicon-edit" aria-hidden="true"></span>
                                    </button>
                                    <button ng-if="user.username != 'admin'" class="btn btn-danger" ng-click="deleteUser(user)">
                                        <span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
                                    </button>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                    <button class="btn btn-primary" data-toggle="modal" ng-click="newUser(user)" data-target="#editUserModal">
                        <span class="glyphicon glyphicon-plus" aria-hidden="true"></span> New User
                    </button>
                </div>
            </div>

            <!-- User Modal -->
            <div class="modal fade" id="editUserModal" tabindex="-1" role="dialog" aria-labelledby="editUserTitle" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal">
                                <span aria-hidden="true">&times;</span>
                                <span class="sr-only">Close</span>
                            </button>
                            <h4 class="modal-title" id="editUserTitle">
                                Editing {{editingUser.username}}
                            </h4>
                        </div>
                        <form>
                            <div class="modal-body">
                                    <h3>Login Information</h3>
                                    <div class="input-group">
                                        <span class="input-group-addon form-label">Username</span>
                                        <input type="text" name="username" {{editingUser.username == "" ? 'disabled' : ''}} class="form-control form-item" ng-model="editingUser.username" placeholder="Username">
                                    </div>
                                    <div class="input-group">
                                        <span class="input-group-addon form-label">Password*</span>
                                        <input type="password" name="password" class="form-control form-item"
                                            ng-model="editingUser.password" placeholder="">
                                    </div>
                                        <small>*Fill field to change</small>

                                    <h3>Roles</h3>
                                    <div class="input-group">
                                        <div class="box horizontal paddedbox-large text-center">
                                            <div>Admin</div>
                                            <input type="checkbox" name="admin" ng-model="editingUser.isAdmin" placeholder="">
                                        </div>
                                        <div class="box horizontal paddedbox-large text-center">
                                            <div>User</div>
                                            <input type="checkbox" name="admin" ng-model="editingUser.isUser" placeholder="">
                                        </div>
                                    </div>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-primary" ng-click="saveUser(editingUser)" data-dismiss="modal">
                                    <span class="glyphicon glyphicon-floppy-disk"></span> Save
                                </button>
                                <button type="button" class="btn btn-default" data-dismiss="modal">
                                    Close
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

        </div>
    </body>
</html>
