/* ~This file is part of the Aliro library~

Copyright (C) 2023 Epistasis Lab, 
Center for Artificial Intelligence Research and Education (CAIRE),
Department of Computational Biomedicine (CBM),
Cedars-Sinai Medical Center.

Aliro is maintained by:
    - Hyunjun Choi (hyunjun.choi@cshs.org)
    - Miguel Hernandez (miguel.e.hernandez@cshs.org)
    - Nick Matsumoto (nicholas.matsumoto@cshs.org)
    - Jay Moran (jay.moran@cshs.org)
    - and many other generous open source contributors

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <https://www.gnu.org/licenses/>.

(Autogenerated header, do not modify)

*/
var db = require("../db").db;
var api = require("./default");

//return a list of datasets for each user
exports.responder = function(req, res) {
    var params = api.params(req);
    var query = {};
    if (params['filter_on_user']) {
        query['username'] = params['username'];
    }
    if (params['id']) {
        query['_id'] = db.ObjectID(params['id']);
    }
    if (params['date_start']) {
        query['_finished'] = {
            "$gte": new Date(params['date_start'])
        }
    }

    db.users.aggregate(
        [{
            $match: query
        }, {
                "$unwind": {
                    path: "$algorithms",
                    preserveNullAndEmptyArrays: true
                }

        }, {
            $lookup: {
                from: "projects",
                localField: "algorithms",
                foreignField: "name",
                as: "algorithms"
            }
        }, {
                "$unwind": {
                    path: "$algorithms",
                    preserveNullAndEmptyArrays: true
                }

        }, {
            $group: {
                _id: "$_id",
                username: {
                    $first: '$username'
                },
                firstname: {
                    $first: '$firstname'
                },
                lastname: {
                    $first: '$lastname'
                },
                algorithms: {
                    $push: "$algorithms"
                },
            }
        }],
        function(err, result) {
            res.send(result)

        }
    );
}
