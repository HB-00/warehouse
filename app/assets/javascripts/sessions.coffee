$(document).on 'turbolinks:load', ->
  if $('.sessions').length || $('.users').length
    $('.email-input').on 'change', ->
      clearError($(this))

    checkPassword = (obj) ->
      if obj.length < 1
        return true
      pwd = obj.val().trim()
      if pwd.length < 6 || pwd.length > 20
        obj.val('')
        displayError(obj, 'Incorrect password(length must in 6 and 20) ')
        return false
      true

    $('.password-input').on 'change', ->
      clearError($(this))
      checkPassword($(this))

    checkPasswordConfirmation = (pwdObj, pwdConfirmObj) ->
      if pwdConfirmObj.length < 1
        return true
      pwd = pwdObj.val().trim()
      pwdConfirm = pwdConfirmObj.val().trim()
      if pwd != pwdConfirm
        pwdConfirmObj.val('')
        displayError(pwdConfirmObj, 'Identical password')
        return
      true

    $('.password-confirmation-input').on 'change', ->
      clearError($(this))
      pwdObj = $(this).parents('form').find('.password-input')
      checkPasswordConfirmation(pwdObj, $(this))


    $('input[placeholder]').on 'keyup', ->
      clearError($(this))

    # Submit the form
    $('.submit-button').on 'click', (e) ->
      that = $(this)
      form = that.parents('form')
      console.log('cvxvv')

      # Check input value
      p = checkPassword(form.find('.password-input'))
      c = checkPasswordConfirmation(form.find('.password-input'), form.find('.password-confirmation-input'))
      if  p && c
        console.log form.find('.hidden-submit-button')
#        form.find('.hidden-submit-button').click()
        $('form').submit()
      else
        console.log 'failed'

    # switch login box
    $('.switch-login').on 'click', ->
      box = $(this).parents('.login-box')
      box.fadeOut('slow', ->
        box.siblings('.login-box').fadeIn('slow')
      )

    # Switch to sign up
    $('.register').on 'click', ->
      box = $(this).parents('.login-box')
      box.fadeOut('slow', ->
        box.siblings('#register-box').fadeIn('slow')
      )

    # Switch to sign in
    $('.login-link').on 'click', ->
      box = $(this).parents('#register-box')
      box.fadeOut('slow', ->
        box.siblings('.login-box:first').fadeIn('slow')
      )

displayError = (obj, message) ->
  obj.parents('.form-item').addClass('form-item-error')
  obj.parents('.form-item').next().removeClass('hidden')
  obj.parents('.form-item').next().find('.error-message').text(message)

clearError = (obj) ->
  obj.parents('.form-item').removeClass('form-item-error')
  obj.parents('.form-item').next().addClass('hidden')
  obj.parents('.form-item').next().find('.error-message').text('')


