/* ~This file is part of the Aliro library~

Copyright (C) 2023 Epistasis Lab, Cedars-Sinai Medical Center

Aliro is maintained by:
    - Jun Choi (hyunjun.choi@cshs.org)
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

import c3 from 'c3';

import d3 from 'd3';



// working version
class ScatterPlot extends Component {


  // Points={Points}
  // Labels ={Labels}
  // chartKey={chartKey}
  // chartColor={chartColor}

  componentDidMount() {
    const { Points, Labels, chartKey, chartColor } = this.props;
    Points && Labels && this.renderChart(Points, Labels, chartKey, chartColor);
  }
/*
colors: {
  'test_score': '#0072b2',  ---- light blue
  'train_score': '#f0e442'  ---- light yellow
  '#55D6BE' ----- light sea green
}

use anonymous function to 'disable' interaction
look here - https://github.com/c3js/c3/issues/493#issuecomment-456686654
*/

  // renderChart(expList, chartKey, chartColor, min, max) {
  renderChart(Points, Labels, chartKey, chartColor) {

    // window.console.log('here in renderChart for ScatterPlot');
    // window.console.log('Points: ', Points);
    // window.console.log('Labels: ', Labels);
    // window.console.log('chartKey: ', chartKey);



     // if chartKey includes pca, then 
     if (chartKey.includes('pca')) {
      var axis= {
        x: {
            label: 'PC1',
            tick: {
                fit: false
            }
        },
        y: {
            label: 'PC2'
        }
      }
      // else if chartKey includes tsne, then
    } 
    else if (chartKey.includes('tsne')) {
      var axis= {
        x: {
            label: 'Comp 1',
            tick: {
                fit: false
            }
        },
        y: {
            label: 'Comp 2'
        }
      }
    }

    

  
    // calculate how many kinds of labels are there in Labels
    var labelSet = new Set(Labels);

    // convert labelSet to array
    var labelSet = Array.from(labelSet);

 
    var labelSetLength = labelSet.length;

   
    var columns =[];
    var xs = {};

    for (var i = 0; i < labelSetLength; i++) {
      // create x and y array for each label
      var xArray = [];
      var yArray = [];
      // add labelSet[i] to xArray and yArray

      // convert labelSet[i] to string


      xArray.push(labelSet[i].toString()+'_x');
      // yArray.push(labelSet[i].toString()+'_y');
      // yArray.push(labelSet[i].toString());
      yArray.push('class_'+labelSet[i].toString());


      // xs[labelSet[i].toString()+'_y'] = labelSet[i].toString()+'_x';
      // xs[labelSet[i].toString()] = labelSet[i].toString()+'_x';
      xs['class_'+labelSet[i].toString()] = labelSet[i].toString()+'_x';
      // xs[labelSet[i]] = labelSet[i]+'_x';

      for (var j = 0; j < Points.length; j++) {
        if (Labels[j] == labelSet[i]) {
          xArray.push(Points[j][0]);
          yArray.push(Points[j][1]);
        }
      }

      columns.push(xArray);
      columns.push(yArray);
    }

    // console.log('xs: ', xs);
    // Sort xs by the key
    var xsSorted = {};
    Object.keys(xs).sort().forEach(function(key) {
      xsSorted[key] = xs[key];
    });

    // console.log('xsSorted: ', xsSorted);

    xs = xsSorted;


    // console.log('xs: ', xs);
    // console.log('columns: ', columns);


    




    

    // var tempColumns= [
    //   ["setosa_x", 3.5, 3.0, 3.2, 3.1, 3.6, 3.9, 3.4, 3.4, 2.9, 3.1, 3.7, 3.4, 3.0, 3.0, 4.0, 4.4, 3.9, 3.5, 3.8, 3.8, 3.4, 3.7, 3.6, 3.3, 3.4, 3.0, 3.4, 3.5, 3.4, 3.2, 3.1, 3.4, 4.1, 4.2, 3.1, 3.2, 3.5, 3.6, 3.0, 3.4, 3.5, 2.3, 3.2, 3.5, 3.8, 3.0, 3.8, 3.2, 3.7, 3.3],
    //   ["versicolor_x", 3.2, 3.2, 3.1, 2.3, 2.8, 2.8, 3.3, 2.4, 2.9, 2.7, 2.0, 3.0, 2.2, 2.9, 2.9, 3.1, 3.0, 2.7, 2.2, 2.5, 3.2, 2.8, 2.5, 2.8, 2.9, 3.0, 2.8, 3.0, 2.9, 2.6, 2.4, 2.4, 2.7, 2.7, 3.0, 3.4, 3.1, 2.3, 3.0, 2.5, 2.6, 3.0, 2.6, 2.3, 2.7, 3.0, 2.9, 2.9, 2.5, 2.8],
    //   ["setosa", 0.2, 0.2, 0.2, 0.2, 0.2, 0.4, 0.3, 0.2, 0.2, 0.1, 0.2, 0.2, 0.1, 0.1, 0.2, 0.4, 0.4, 0.3, 0.3, 0.3, 0.2, 0.4, 0.2, 0.5, 0.2, 0.2, 0.4, 0.2, 0.2, 0.2, 0.2, 0.4, 0.1, 0.2, 0.2, 0.2, 0.2, 0.1, 0.2, 0.2, 0.3, 0.3, 0.2, 0.6, 0.4, 0.3, 0.2, 0.2, 0.2, 0.2],
    //   ["versicolor", 1.4, 1.5, 1.5, 1.3, 1.5, 1.3, 1.6, 1.0, 1.3, 1.4, 1.0, 1.5, 1.0, 1.4, 1.3, 1.4, 1.5, 1.0, 1.5, 1.1, 1.8, 1.3, 1.5, 1.2, 1.3, 1.4, 1.4, 1.7, 1.5, 1.0, 1.1, 1.0, 1.2, 1.6, 1.5, 1.6, 1.5, 1.3, 1.3, 1.3, 1.2, 1.4, 1.2, 1.0, 1.3, 1.2, 1.3, 1.3, 1.1, 1.3]]

    //   console.log('tempColumns: ', tempColumns);





  var chart = c3.generate({
    bindto: `.${chartKey}`,
    data: {
        
        xs: xsSorted,

      
        columns: columns,
        type: 'scatter'
    },
    axis: axis,
    // set tooltip based on your setting 
    tooltip: {
      // format: {
      //   title: function (d,name) { return  d,name; },
        
        

        
      // }
      // do not show tooltip
      show: false
    }
  });

   

    



  }

  render() {
    return (
      <div className={`ScatterPlot ${this.props.chartKey}`} />
    );
  }
}

ScatterPlot.defaultProps = {
  chartColor: '#60B044'
};

export default ScatterPlot;











// test version
// class ScatterPlot extends Component {
//   componentDidMount() {
//     const { expList, chartKey, chartColor, min, max } = this.props;
//     expList && this.renderChart(expList, chartKey, chartColor, min, max);
//   }
// /*
// colors: {
//   'test_score': '#0072b2',  ---- light blue
//   'train_score': '#f0e442'  ---- light yellow
//   '#55D6BE' ----- light sea green
// }

// use anonymous function to 'disable' interaction
// look here - https://github.com/c3js/c3/issues/493#issuecomment-456686654
// */

//   renderChart(expList, chartKey, chartColor, min, max) {
//     // window.console.log('exp list: ');
//     // window.console.log('exp list: ', expList);
//     // print d3 version
//     window.console.log('d3 version: ', d3.version);
//     // print c3 version
//     window.console.log('c3 version: ', c3.version);



//     // make expList like[['1',0.2],['2',0.3],['3',0.5]]
//     // expList = [['1',0.2],['2',0.3],['3',0.5]];

//     // print expList
//     window.console.log('expList: ', expList);

//     // print chartKey
//     window.console.log('chartKey: ', chartKey);

//     // var chart = c3.generate({
//     //   bindto: `.${chartKey}`,
//     //   data: {
          

//     //       columns:expList
//     //       ,
          
//     //       type : 'ScatterPlot',
//     //       // colors: {
//     //       //   columns[0][0]: '#ff0000',
//     //       //   columns[1][0]: '#00ff00'
//     //       // }
//     //       // ,
//     //       onclick: function (d, i) { console.log("onclick", d, i); },
//     //       onmouseover: function (d, i) { console.log("onmouseover", d, i); },
//     //       onmouseout: function (d, i) { console.log("onmouseout", d, i); }
//     //   },
//     //   ScatterPlot: {
//     //       // title: "Iris Petal Width"
//     //       title: ""
//     //       // title: expList
//     //   }
//     // });




//      // make confusion matrix [[10,20],[30,40]] using d3.js
//     var matrix = [[10,20],[30,40]];
   


//     // print curreht class name
//     window.console.log('current class name: ', `.${chartKey}`);

    

//       var div = d3.select(`.${chartKey}`)
//       // add svg to div 
//       var svg = div.append("svg")

//       var rect = svg.selectAll("rect")
//       .data(matrix)
//       .enter()
//       .append("rect")
//       .attr("width", 100)
//       .attr("height", 100)
//       // make width and height related to current div size
//       // .attr("width", function(d, i) {
//       //   return d3.select(`.${chartKey}`).node().getBoundingClientRect().width/10;
//       // })
//       // .attr("height", function(d, i) {
//       //   return d3.select(`.${chartKey}`).node().getBoundingClientRect().height/10;
//       // })
//       .attr("x", function(d, i) {
//         return i * 50;
//       } )
//       .attr("y", function(d, i) {
//         return i * 50;
//       }
//       )
//       .attr('id', function(d, i) {
//         return 'rect_' + i;
//       }
//       )
//       .attr('fill', function(d, i) {
//         return 'red';
//       } 
//       )
//       // make it show more than background color
//       .attr('opacity', 0.5)
//       // add mouseover event
//       .on("mouseover", function(d, i) {
//         // change color
//         d3.select(this).attr('fill', 'blue');
//         console.log('number',d)
//         // show this d as string on the rect
//         d3.select(this).text(d);
//         // make the text color white
//         d3.select(this).attr('fill', 'white');

//         d3.select(this).text('This is some information about whatever')
//                 .attr('x', 50)
//                 .attr('y', 150)
//                 .attr('fill', 'white')

//       })
//       .append('text').text('test');
//       // add data value to each rect text


//       // matrix 
//       //  20  30
//       //  40  50

//       // add the matrix value to rect 

//       // var text = svg.selectAll("text")
//       // .data(matrix)
//       // .enter()
//       // .append("text")


  

//   }

//   render() {
//     return (
//       <div className={`ScatterPlot ${this.props.chartKey}`} />
//     );
//   }
// }

// ScatterPlot.defaultProps = {
//   chartColor: '#60B044'
// };

// export default ScatterPlot;







