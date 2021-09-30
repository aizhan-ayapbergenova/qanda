$ ->
  $('.edit-answer-link').click (e) ->
    e.preventDefault();
    $(this).hide();
    answer_id = $(this).data('answerId')
    console.log($(this).data());
    $('form#edit-answer-' + answer_id).show() 
  
  $('form.new_answer').bind 'ajax:success', (e, data,status,xhr) ->
    answer = $.parseJSON(xhr.responseText)
    $('.answers').append('<p>' + answer.body + '</p>')
  .bind 'ajax:error', (e, xhr, status, error) ->
    $('.answer-errors').html(xhr.responseText)
