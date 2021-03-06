$(function () {
    $.getJSON("/dashboard", function(data){
        console.log(data);
        build_chart(data[0], data[1])
    });
});

function build_chart(inbound, all){
    var chart = new Highcharts.Chart({
            chart: {
                renderTo: 'container',
                type: 'line',
                marginRight: 130,
                marginBottom: 25
            },
            title: {
                text: 'Total Texts Sent',
                x: -20 //center
            },
            subtitle: {
                text: '503 Taco Leg',
                x: -20
            },
            xAxis: {
            },
            yAxis: {
                title: {
                    text: 'Texts Send'
                },
                plotLines: [{
                    value: 0,
                    width: 1,
                    color: '#808080'
                }]
            },
            legend: {
                layout: 'vertical',
                align: 'right',
                verticalAlign: 'top',
                x: -10,
                y: 100,
                borderWidth: 0
            },
            series: [{
                name: 'Total',
                data: all
                // data: [10.0, 15.0, 20.0, 25.0, 30.0, 35.0, 40.0]
            }, {
                name: 'Inbound',
                data: inbound
                // data: [1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0]
            }]
        });
}

