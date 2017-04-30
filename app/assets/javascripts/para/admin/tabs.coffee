# Tabs hash management adapted from SO answer :
#   http://stackoverflow.com/a/21443271/685925
#
class Para.Tabs extends Vertebra.View
  events:
    'shown.bs.tab a[data-toggle="tab"]': 'onTabShown'
    'change .tab-pane': 'onFormInputUpdate'

  initialize: (options = {}) ->
    @$anchorInput = options.$anchorInput
    @showActiveTab()
    @refreshTabsErrors()

  showActiveTab: ->
    if (hash = (location.hash or @$anchorInput?.val()))
      @findTab(hash).tab('show')

    console.log 'tab', hash, @findTab(hash)

  onTabShown: (e) =>
    tabHash = $(e.target).attr('href')
    history.pushState(null, null, tabHash)
    @updateAnchorInput()

  updateAnchorInput: ->
    @$anchorInput.val(location.hash) if @$anchorInput.length

  refreshTabsErrors: ->
    @$('[data-toggle="tab"]').each (i, tab) =>
      @refreshTabErrors($(tab))

  refreshTabErrors: ($tab) ->
    $panel = @$($tab.attr('href'))
    $tab.addClass('has-error') if $panel.find('.has-error').length

  onFormInputUpdate: (e) ->
    $tab = @findTab($(e.currentTarget).attr('id'))
    @refreshTabErrors($tab)

  findTab: (id) ->
    id = "##{ id }" unless id.indexOf('#') >= 0
    @$('a[href="' + id + '"]')

$(document).on 'page:change turbolinks:load', ->
  $('[data-form-tabs]').each (i, el) ->
    new Para.Tabs(el: el, $anchorInput: $('[data-current-anchor]'))
