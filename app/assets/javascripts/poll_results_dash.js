$(function () {
    $.getJSON("/dashboard", function(data){
        console.log(data);
        build_chart(data[0], data[1])
    });
});

function build_chart(A, B, C, D){
    var chart2 = new Highcharts.Chart({
            chart: {
                type: 'column',
                margin: [ 30, 30, 50, 80]
            },
            title: {
                text: 'Poll Response'
            },
            xAxis: {
                categories: [
                    'A',
                    'B',
                    'C',
                    'D'
                ],
                labels: {
                    rotation: -45,
                    align: 'right',
                    style: {
                        fontSize: '13px',
                        fontFamily: 'Verdana, sans-serif'
                    }
                }
            },
            yAxis: {
                min: 0,
                title: {
                    text: 'Text Response'
                }
            },
            legend: {
                enabled: false
            },
            tooltip: {
                formatter: function() {
                    return '<b>'+ this.x
                }
            },
            series: [{
                name: 'Reponses',
                data: [A, B, C, D],
                dataLabels: {
                    enabled: true,
                    rotation: -90,
                    color: '#FFFFFF',
                    align: 'right',
                    x: 4,
                    y: 10,
                    style: {
                        fontSize: '13px',
                        fontFamily: 'Verdana, sans-serif'
                    }
                }
            }]
        });
    });
}


