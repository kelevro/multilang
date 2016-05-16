$ ->
  $(document).on 'click', '.update-control', (e)->
    e.preventDefault()
    $edit_block = $(this)
      .closest('.translation-container')
      .find('.edit-block')
    l = Ladda.create(this)
    l.start()
    $.ajax
      url: $(this).data('action')
      data: {value: $edit_block.find('textarea').val()}
      type: 'patch'
      dataType: 'script',
      success: (response) ->
        l.stop()
        recount_changed_translations()
      error: ->
        l.stop()

  $(document).on 'keyup', '.edit-block textarea', (e) ->
    unless ($(this).val() == $(this).closest('.edit-block').data('value').toString())
      $(this).closest('.translation-container')
        .find('.check').addClass('hide')
      $(this).closest('.translation-container')
        .find('.exchange').removeClass('hide')
      $(this).closest('.translation-container')
        .find('.edit-block').addClass('dirty')
      recount_changed_translations()

  $(document).on 'click', '.state_change', (e)->
    e.preventDefault()
    $this = $(this)
    $.ajax
      url: $this.data('action')
      dataType: 'script',
      type: 'patch',
      success: (response) ->
      error: ->

  $(document).on 'click', '.save-all-translations', (e) ->
    Ladda.create(this).start()
    e.preventDefault()
    data = {}

    $('.dirty').each (idx, item) ->
      $item = $(item)
      data[$item.data('id')] = $item.find('textarea').val()

    $.ajax
      url: $(this).data('action')
      data: {translations: data}
      type: 'patch'
      dataType: 'script',
      success: (response) ->
        location.reload()
      error: ->
        location.reload()

recount_changed_translations = () ->
  count = $('.dirty').length
  if count > 0
    $('.save-all-container').removeClass('hide')
    $('.save-all-translations .count').html(count)
  else
    $('.save-all-container').addClass('hide')