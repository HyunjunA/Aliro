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
//Generate a list of projects based on machine_config.json
var getProjects = function(algorithms) {
    var project_list = [];
    for (var i in algorithms) {
        var algo = algorithms[i];
        console.log("Register algorithm " + algo)
        var project = {
            name: algo,
            command: "python",
            cwd: "machine/learn/",
            args: ["driver.py",  algo],
            options: "double-dash",
            capacity: "1",
            results: "machine/learn/tmp/" + algo
        }
        project_list.push(project);
    }
    return project_list;
}

//Return the residual capacity in machine
var getCapacity = function(projId, maxCapacity, projects) {
    var capacity = 0;
    if (projects[projId]) {
        capacity = Math.floor(maxCapacity / projects[projId].capacity);
    }
    return capacity;
};


//Check capacity in machine
var checkCapacity = function(projId, maxCapacity, projects) {
    var error_msg = {};
    var capacity = 0;
    if(typeof projects[projId] === 'undefined') {
        error_msg = {
            error: "Project '" + projId + "' does not exist"
        };
    } else {
        var capacity = getCapacity(projId, maxCapacity, projects);
        if (capacity === 0) {
            error_msg = {
                error: "No machine capacity available"
            };
        }
    }
    return {
      error_msg: error_msg,
      capacity: capacity
    };
};





exports.getProjects = getProjects;
exports.getCapacity = getCapacity;
exports.checkCapacity = checkCapacity;
