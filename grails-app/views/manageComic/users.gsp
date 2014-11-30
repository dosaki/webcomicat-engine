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
                                    <button class="btn btn-primary" ng-click="editUser(user.id)">
                                        <span class="glyphicon glyphicon-edit" aria-hidden="true"></span>
                                    </button>
                                    <button class="btn btn-danger" ng-click="deleteUser(user.id)">
                                        <span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
                                    </button>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </body>
</html>
