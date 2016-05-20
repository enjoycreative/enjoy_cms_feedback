window.enjoy_cms.feedback.create_ajax_form = (form_selector = "#new_enjoy_feedback_contact_message", wrapper_selector = "#enjoy_feedback_contact_form" )->

  $(document).delegate form_selector, "ajax:complete", (event, xhr, status)->
    $(event.currentTarget).closest(wrapper_selector).html(xhr.responseText)

  $(document).delegate form_selector + " .input", 'click', (e) ->
    e.preventDefault()
    $(e.currentTarget).removeClass("field_with_errors").find('span.error').hide()
    return false
