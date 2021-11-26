document.addEventListener('turbolinks:load', function() {

  var password = document.querySelector('.password');
  var passwordConfirmation = document.querySelector('.password_confirmation');

  if (!(password.length > 0 && passwordConfirmation.length > 0)) {
    console.log('password')
    console.log(password);
    console.log('passwordConfirmation')
    console.log(passwordConfirmation);
  }

  if (password.value == passwordConfirmation.value) {
    console.log('!!!password')
    console.log(password);
    console.log('!!! passwordConfirmation')
    console.log(passwordConfirmation);
  }


console.log('!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!')


  //var password_confirmation_value = document.querySelector('.password_confirmation')

  //if (password_confirmation_value) { password_confirmation_value.addEventListener('keydown', function_check_password) }

})

function function_check_password() {

  var password = document.querySelector('.password');
  var passwordConfirmation = document.querySelector('.password_confirmation');

  let input = document.querySelectorAll('input');
  let input_password = document.querySelectorAll('input#user_password');

  console.log('password')
  console.log(password);
  console.log('input_password')
  console.log(input_password);

  //console.log(password_confirmation_value.length)
}
