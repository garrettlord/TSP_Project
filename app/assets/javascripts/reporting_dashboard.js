$(function () {
        $('#container').highcharts({
            chart: {
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
                categories: ['Mon', 'Tue', 'Wed', 'Thur', 'Fri', 'Jun',
                    'Sat', 'Sun']
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
            tooltip: {
                valueSuffix: '°C'
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
                //data: [10.0, 15.0, 20.0, 25.0, 30.0, 35.0, 40.0]
                data: @allTextsCount
            }, {
                name: 'Inbound',
                data: @inboundCount
               // data: [1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0]
            }]
        });
    });
    
