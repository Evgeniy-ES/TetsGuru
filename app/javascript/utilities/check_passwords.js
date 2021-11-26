document.addEventListener('turbolinks:load', function() {

  var password_confirmation_value = document.querySelector('.password_confirmation')

  if (password_confirmation_value) { password_confirmation_value.addEventListener('keyup', function_check_password) }

})

function function_check_password() {

  var passwordConfirmation = document.querySelector('.password_confirmation').value;
  var password = document.querySelector('.password').value;

  var password_for_icon = document.querySelector('.text-valid')
  var password_conf_for_icon = document.querySelector('.text-valid-conf')

  var password_for_icon_ivalid = document.querySelector('.text-invalid')
  var password_conf_for_icon_invalid = document.querySelector('.text-invalid-conf')

  if (passwordConfirmation == password) {
    password_for_icon.classList.remove('hide')
    password_conf_for_icon.classList.remove('hide')
    password_for_icon_ivalid.classList.add('hide')
    password_conf_for_icon_invalid.classList.add('hide')
  } else if (passwordConfirmation.length == 0) {
    password_for_icon_ivalid.classList.add('hide')
    password_conf_for_icon_invalid.classList.add('hide')
  } else {
    password_for_icon_ivalid.classList.remove('hide')
    password_conf_for_icon_invalid.classList.remove('hide')
    password_for_icon.classList.add('hide')
    password_conf_for_icon.classList.add('hide')
  }


}
