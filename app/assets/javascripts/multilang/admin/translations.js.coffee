$ ->
  $(document).on 'focus', '.edit-block', (e) ->
    $(this).find('.translate-control').removeClass('hide')

  $(document).on 'focusout', '.edit-block', (e) ->
    $target = $(e.relatedTarget)
    $edit_block = $(this)
    text_area = $edit_block.find('textarea')
    if $target? && $target.hasClass('cancel-control')
      text_area.val($edit_block.data('value'))
    else if $target? && $target.hasClass('update-control')
      l = Ladda.create($target.get(0))
      l.start()
      $.ajax
        url: $target.data('action')
        data: {value: text_area.val()}
        type: 'patch'
        dataType: 'script',
        success: (response) ->
          l.stop()
        error: ->
          l.stop()
    else
      $(this).find('.translate-control').addClass('hide')


  $(document).on 'click', '.state_change', (e)->
    e.preventDefault()
    $this = $(this)
    console.log $this.data('action')
    l = Ladda.create($this.parents('.state').find('.ladda-button').get(0))
    l.start()
    $.ajax
      url: $this.data('action')
      dataType: 'script',
      type: 'patch',
      success: (response) ->
        l.stop()
      error: ->
        l.stop()