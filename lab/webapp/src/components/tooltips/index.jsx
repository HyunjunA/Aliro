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
import React, { Component } from 'react';
// import ReactDOM
// import ReactDOM from 'react-dom';
// import './tooltip.css';



class ToolTip extends Component
{
	constructor(props)
  {
  	super(props);
  }
  render()
  {
  	let {state} = this;

    // const myElement = <h1>I Love JSX!</h1>;
    var div = document.createElement("div");
    div.style.width = "100px";
    div.style.height = "100px";
    div.innerHTML = "Hello";
    div.className = "side_panel";
    // add mouse over event to the div
    div.onmouseover = function() {
      div.style.backgroundColor = "red";
    };
    // append myElement to the app div using document instead of using ReactDOM
    document.getElementById('app').appendChild(div);
    
   
    return <div id="tooltip" className="on right">
            <div className="tooltip-arrow"></div><div className="tooltip-inner">Hey!!!!!ToolTip Component</div>
           </div>;
  }
  componentDidMount()
  {
  	
  }
  componentWillUnmount()
  {
  	
	}
}


export default ToolTip;