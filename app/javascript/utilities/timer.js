document.addEventListener('turbolinks:load', function() {
  var elem = document.getElementById("timer");

  if (elem) {

    var remaining_time = document.querySelector('.remaining-time').dataset.remainingTime;

    startTimer(remaining_time)

  }

  function startTimer(timer) {
      let timePassed = 0;
      let timeLeft = timer;

      let timerInterval = setInterval(() => {

          timePassed += 1;
          timeLeft = timer - timePassed;
          console.log(timeLeft)
          if (!timeLeft) {
              clearInterval(timerInterval);
              document.getElementById("submit-form").click()
          }
          document.getElementById("timer").innerHTML = timeLeft;
      }, 1000);
  }


})
