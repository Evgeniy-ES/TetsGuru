document.addEventListener('turbolinks:load', function() {

  var password_confirmation_value = document.querySelector('.password_confirmation')

  if (password_confirmation_value) { password_confirmation_value.addEventListener('keyup', function_check_password) }

})

function function_check_password() {

  var passwordConfirmation = document.querySelector('.password_confirmation').value;
  var password = document.querySelector('.password').value;

  var password_for_icon = document.querySelectorAll('input#user_password')

  console.log(passwordConfirmation)
  console.log(password)

  if (passwordConfirmation == password) {
    console.log('!!!')
    password_for_icon('.octicon-arrow-up').classList.remove('hide')
  }


}
