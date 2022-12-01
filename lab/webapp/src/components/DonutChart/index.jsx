/* ~This file is part of the Aliro library~

Copyright (C) 2017 Epistasis Lab, University of Pennsylvania

Aliro is maintained by:
    - Heather Williams (hwilli@upenn.edu)
    - Weixuan Fu (weixuanf@upenn.edu)
    - William La Cava (lacava@upenn.edu)
    - Michael Stauffer (stauffer@upenn.edu)
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
class DonutChart extends Component {
  componentDidMount() {
    const { expList, chartKey, chartColor, min, max, dataname } = this.props;
    expList && dataname && this.renderChart(expList, chartKey, chartColor, min, max, dataname);
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

  renderChart(expList, chartKey, chartColor, min, max, dataname) {
    // window.console.log('exp list: ');
    window.console.log('expList: ', expList);
    // print d3 version
    window.console.log('d3 version: ', d3.version);
    // print c3 version
    window.console.log('c3 version: ', c3.version);

    window.console.log('dataname', dataname);

    // for each row in expList, get the key value pair

    const data = expList.map((exp) => 
    {
     

      if (exp[0].includes('class') === false) {
        
        // window.console.log('exp[0]: ', exp[0]);
        // exp[0] = `class_${exp[0]}`;

        
        
      

        // get class_and_file from session storage
        const class_and_file = sessionStorage.getItem('class_and_file')

        // split class_and_file with *
        const class_and_file_split_star = class_and_file.split('*')

        // remove elements which has null
        

        // find element which has dataname
        const class_and_file_split_star_find = class_and_file_split_star.find((element) => element.includes(dataname))


        console.log("class_and_file_split_star_find", class_and_file_split_star_find)




        const class_and_file_split = class_and_file_split_star_find.split('&')

        window.console.log('class_and_file_split-donut: ', class_and_file_split);
        console.log('class_and_file_split[1]', class_and_file_split[1])

        if (class_and_file_split[1] === dataname) {
          // exp[0] = class_and_file_split[1];
          console.log("class_and_file_split[1] === dataname ");
        
          // calculate the length of class_and_file_split
          const class_and_file_split_length = class_and_file_split.length
          // get the last element of class_and_file_split
          const dataname_from_session_storage = class_and_file_split[class_and_file_split_length - 1]
          console.log('dataname_from_session_storage: ', dataname_from_session_storage)

          // console.log('dataname in ', dataname)
          
          const class_and_file_split_without_last_element = class_and_file_split.slice(0, class_and_file_split_length - 1)
          console.log('class_and_file_split_without_last_element',class_and_file_split_without_last_element)

          // slipt class_and_file_split_without_last_element with ,
          const class_and_file_split_without_last_element_split = class_and_file_split_without_last_element.join(',').split(',')

          // console.log('class_and_file_split_without_last_element_split',class_and_file_split_without_last_element_split)
          
          console.log('class_and_file_split_without_last_element_split',class_and_file_split_without_last_element_split)

          // make key value pair using class_and_file_split_without_last_element_split


          // class_and_file_split_without_last_element_split 
          for (let i = 0; i < class_and_file_split_without_last_element_split.length; i++) {
            

            // exp[0] to string
            const exp0 = exp[0].toString()
            // console.log('exp0', exp0)

            // class_and_file_split_without_last_element_split[i]
            // console.log('class_and_file_split_without_last_element_split[i]', class_and_file_split_without_last_element_split[i])



            console.log('class_and_file_split_without_last_element_split[i] and exp0:', class_and_file_split_without_last_element_split[i], exp0)

            // spilit class_and_file_split_without_last_element_split[i] with :
            const class_and_file_split_without_last_element_split_split = class_and_file_split_without_last_element_split[i].split(':')

            console.log('class_and_file_split_without_last_element_split_split', class_and_file_split_without_last_element_split_split)

            console.log('class_and_file_split_without_last_element_split_split[0]', class_and_file_split_without_last_element_split_split[0])

            // remove any space in class_and_file_split_without_last_element_split_split[0]
            const class_and_file_split_without_last_element_split_split_0 = class_and_file_split_without_last_element_split_split[0].replace(/\s/g, '')

            // if (class_and_file_split_without_last_element_split[i].includes(exp0)) {
            if (class_and_file_split_without_last_element_split_split_0 === exp0) {

              console.log('class_and_file_split_without_last_element_split_split_0 === exp0:', class_and_file_split_without_last_element_split_split_0, exp0)


              // split with :
              // const class_and_file_split_without_last_element_split_split = class_and_file_split_without_last_element_split[i].split(':')
              // console.log('class_and_file_split_without_last_element_split_split',class_and_file_split_without_last_element_split_split)
              // console.log('class_and_file_split_without_last_element_split_split[1]',class_and_file_split_without_last_element_split_split[1])
            
              // class_and_file_split_without_last_element_split_split[1]
              exp[0] = `class_${class_and_file_split_without_last_element_split_split[1]}`;
            }
            }

        }

       
      
      }
    





    });

    // window.console.log("data:",data)





    // make expList like[['1',0.2],['2',0.3],['3',0.5]]
    // expList = [['1',0.2],['2',0.3],['3',0.5]];

    // // print expList
    // window.console.log('expList: ', expList);

    // make expList [['class_1',0.2],['class_2',0.3],['class_3',0.5]];
    // var testList = expList.map((exp) => {
    //   // add class_ to each element
    //   exp[0] = `class_${exp[0]}`;
    //   return [exp[0], exp[1]];
    // });

    // window.console.log('testList: ', testList);


  

    // print chartKey
    window.console.log('chartKey: ', chartKey);

    var chart = c3.generate({
      bindto: `.${chartKey}`,
      data: {
          

          columns:expList
          ,
          
          type : 'donut',
          // colors: {
          //   columns[0][0]: '#ff0000',
          //   columns[1][0]: '#00ff00'
          // }
          // ,
          onclick: function (d, i) { console.log("onclick", d, i); },
          onmouseover: function (d, i) { console.log("onmouseover", d, i); },
          onmouseout: function (d, i) { console.log("onmouseout", d, i); }
      },
      donut: {
          // title: "Iris Petal Width"
          title: ""
          // title: expList
      },
      legend: {
        item: { onclick: function () {} }
      }
      ,
      // tooltip: {
      //   format: {

    });

    // if document element has testuser text, then make it unvisiable 


    



  }

  render() {
    return (
      <div className={`donut ${this.props.chartKey}` } />
    );
  }
}

DonutChart.defaultProps = {
  chartColor: '#60B044'
};

export default DonutChart;











// test version
// class DonutChart extends Component {
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
          
//     //       type : 'donut',
//     //       // colors: {
//     //       //   columns[0][0]: '#ff0000',
//     //       //   columns[1][0]: '#00ff00'
//     //       // }
//     //       // ,
//     //       onclick: function (d, i) { console.log("onclick", d, i); },
//     //       onmouseover: function (d, i) { console.log("onmouseover", d, i); },
//     //       onmouseout: function (d, i) { console.log("onmouseout", d, i); }
//     //   },
//     //   donut: {
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
//       <div className={`donut ${this.props.chartKey}`} />
//     );
//   }
// }

// DonutChart.defaultProps = {
//   chartColor: '#60B044'
// };

// export default DonutChart;







