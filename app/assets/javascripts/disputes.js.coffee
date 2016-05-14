jQuery ->

  $(document).ready ->
    Stripe.setPublishableKey($('meta[name="stripe-key"]').attr('content'))
    subscription.setupForm()



  subscription =
    setupForm: ->
      $('#new_subscription').submit ->
        $('input[type=submit]').attr('disabled', true)
        subscription.processCard()
        false
        
        
    
    processCard: ->
      card =
        number: $('#card_number').val()
        cvc: $('#card_code').val()
        expMonth: $('#card_month').val()
        expYear: $('#card_year').val()
      Stripe.createToken(card, subscription.handleStripeResponse)
      
      
    
    handleStripeResponse: (status, response) ->
      if status == 200
        $('#subscription_stripe_card_token').val(response.id)
        $('#new_subscription')[0].submit()
      else
           alert(response.error.message)
		    $('input[type=submit]').attr('disabled', false)
     	



