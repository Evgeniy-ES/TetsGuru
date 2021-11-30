document.addEventListener('turbolinks:load', function() {
  var elem = document.getElementById("progress");

  if (elem) {
    var elem = document.getElementById("progress-bar");

    var element_question = document.querySelector('.count-questions');
    var element_all_questions = document.querySelector('.all-count-questions');

    current_question = element_question.dataset.countQuestions - 1
    all_questions = element_all_questions.dataset.allCountQuestions

    percent_progress = Math.round(current_question*100/all_questions)

    elem.style.width = percent_progress + "%";
    elem.innerHTML = percent_progress + "%";


  }
})
