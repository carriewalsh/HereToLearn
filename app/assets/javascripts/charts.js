function buildChart(data, labels, element, title) {
  var ctx = document.getElementById(element).getContext('2d');
  return new Chart(ctx, {
    type: 'bar',
    data: {
      labels: labels,
      datasets: [{
        data: data,
        backgroundColor: [
        'rgba(255, 99, 132, 0.2)',
        'rgba(54, 162, 235, 0.2)',
        'rgba(255, 206, 86, 0.2)',
        'rgba(75, 192, 192, 0.2)',
        'rgba(153, 102, 255, 0.2)',
        'rgba(255, 159, 64, 0.2)'
        ],
        borderColor: [
        'rgba(255, 99, 132, 1)',
        'rgba(54, 162, 235, 1)',
        'rgba(255, 206, 86, 1)',
        'rgba(75, 192, 192, 1)',
        'rgba(153, 102, 255, 1)',
        'rgba(255, 159, 64, 1)'
        ],
        borderWidth: 1
      }]
    },
    options: {
      legend: {
        display: false
      },
      title: {
        display: true,
        text: title
      },
      responsive: true,
      maintainAspectRatio: false,
      scales: {
        yAxes: [{
          ticks: {
            beginAtZero: true,
            max: 100,
            stepSize: 20
          }
        }],
        xAxes: [{
          ticks: {
            autoSkip: false,
            maxRotation: 45,
            minRotation: 45
          }
        }]
      }
    }
  });
}

function getStudentData(student_id) {
  var url = `https://lit-fortress-28598.herokuapp.com/machinelearning/results/?student_id=${student_id}`
  fetch(url)
  .then(function(response) {
    return response.json();
  })
  .then(function(myJson) {
    return myJson;
  })
  .then(function(json) {
    var data = Object.values(json.meals);
    var labels = Object.keys(json.meals);
    buildChart(data, labels, `foodchart-${student_id}`, 'Weekly Food (%)');
    return json
  })
  .then(function(json) {
    var data = Object.values(json.sleep_quality);
    var labels = Object.keys(json.sleep_quality);
    var ctx = document.getElementById(`predicted-score-${student_id}`);
    ctx.appendChild(document.createTextNode(json.score));
    buildChart(data, labels, `sleepchart-${student_id}`, 'Weekly Sleep (%)');
  });
}
