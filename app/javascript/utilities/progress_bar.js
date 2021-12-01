document.addEventListener('turbolinks:load', function() {
  var elem = document.getElementById("progress");

  if (elem) {
    var elem = document.getElementById("progress-bar");

    var current_question = document.querySelector('.count-questions').dataset.countQuestions - 1;
    var all_questions = document.querySelector('.all-count-questions').dataset.allCountQuestions;

    if (all_questions > 0) {
      percent_progress = Math.round(current_question*100/all_questions)

      elem.style.width = percent_progress + "%";
      elem.innerHTML = percent_progress + "%";
    }

  }
})
