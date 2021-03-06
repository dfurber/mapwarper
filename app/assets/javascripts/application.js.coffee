#= require jquery-ui
#= require rails-ujs

#= require jquery-bramus-progressbar/jquery-bramus-progressbar
#= require general
#= require jquery.history
#= require jquery-warper
#= require layers
#= require unwarped
#= require SelectFeatureNoClick
#= require alertify.min
#= require advanced_search
#= require census_form

#querystring = require('querystring-component')

pageLoad = ->
  window.alerts or= []
  window.alertifyInit()
  alertify.set delay: 10000
  for alert in window.alerts
    alertify[alert[0]](alert[1])
  window.alerts = []
  return

jQuery(document).ready ->
  window.alertifyInit = alertify.init
  do pageLoad

jQuery(document).on 'click', '#search-map', ->
  $form = jQuery(this).closest('form')
  if document.location.toString().match(/building/)
    $form.append "<input type=\"hidden\" name=\"buildings\" value=\"1\">"
  else
    year = jQuery(this).data('year')
    $form.append "<input type=\"hidden\" name=\"people\" value=\"#{year}\">"
  $form.attr 'action', '/forge'
  $form.submit()

jQuery(document).on 'blur', '#city, #street_name', ->
  city = jQuery('#city').val()
  city = null if city is ''
  street = jQuery('#street_name').val()
  street = null if street is ''
  if city and street
    params = city: city, street: street
    jQuery.getJSON '/census/1910/building_autocomplete', params, (json) ->
      building = jQuery('#building_id')
      current_value = building.val()
      html = '<option value="">Select a building</option>'
      for item in json
        html += "<option value=\"#{item.id}\">#{item.name}</option>"
      building.html html
      building.val current_value

buildingNamed = no
jQuery(document).on 'ready', ->
  buildingNamed = jQuery('#building_name').val()
jQuery(document).on 'change', '#building_address_house_number, #building_address_street_prefix, #building_address_street_name, #building_address_street_suffix', ->
  unless buildingNamed
    buildingName = [jQuery('#building_address_house_number').val(), jQuery('#building_address_street_prefix').val(), jQuery('#building_address_street_name').val(), jQuery('#building_address_street_suffix').val()].join(' ')
    jQuery('#building_name').val(buildingName)
