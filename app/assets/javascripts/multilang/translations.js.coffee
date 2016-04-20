$ ->
  $(document).on 'focus', '.edit-block', (e) ->
    $('.translate-control').addClass('hide')
    $(this).find('.translate-control').removeClass('hide')

  $(document).on 'click', '.update-control', (e)->
    e.preventDefault()
    $edit_block = $(this).closest('.edit-block')
    l = Ladda.create(this)
    l.start()
    $.ajax
      url: $(this).data('action')
      data: {value: $edit_block.find('textarea').val()}
      type: 'patch'
      dataType: 'script',
      success: (response) ->
        l.stop()
      error: ->
        l.stop()

  $(document).on 'keyup', '.edit-block textarea', (e) ->
    if ($(this).val() == $(this).closest('.edit-block').data('value').toString())
      $(this).closest('.translation-container').find('.check').removeClass('hide')
      $(this).closest('.translation-container').find('.exchange').addClass('hide')
    else
      $(this).closest('.translation-container').find('.check').addClass('hide')
      $(this).closest('.translation-container').find('.exchange').removeClass('hide')

  $(document).on 'click', '.state_change', (e)->
    e.preventDefault()
    $this = $(this)
    $.ajax
      url: $this.data('action')
      dataType: 'script',
      type: 'patch',
      success: (response) ->
      error: ->
