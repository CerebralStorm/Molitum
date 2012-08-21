# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  $('#invoice_billing_start').datepicker
    dateFormat: 'yy-mm-dd'

  $('#invoice_billing_end').datepicker
    dateFormat: 'yy-mm-dd'