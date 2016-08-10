jQuery ->

$(window).load ->
  $('.indexModalFade').modal 'show'
  return

$(window).load ->
  $('.index-image').click ->
    $('.indexModalFade').modal 'show'
    return
  return


$(document).ready ->
    console.log("Hello?")
    Stripe.setPublishableKey($('meta[name="stripe-key"]').attr('content'))
    subscription.setupForm()



  subscription =
    setupForm: ->
      $('#new_charge').submit ->
        $('input[type=submit]').attr('disabled', true)
        subscription.processCard()
        false
        
        
    
    processCard: ->
      card =
        number: $('#the_card_number').val()
        cvc: $('#the_card_code').val()
        expMonth: $('#the_card_month').val()
        expYear: $('#the_card_year').val()
      Stripe.createToken(card, subscription.handleStripeResponse)
      
      
    
    handleStripeResponse: (status, response) ->
      if status == 200
        $('#the_stripe_card_token').val(response.id)
        $('#new_charge')[0].submit()
      else
           alert(response.error.message)
		    $('input[type=submit]').attr('disabled', false)
     	



