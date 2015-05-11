$(document).ready(function() {
  // This is called after the document has loaded in its entirety
  // This guarantees that any elements we bind to will exist on the page
  // when we try to bind to them

  // See: http://docs.jquery.com/Tutorials:Introducing_$(document).ready()

  $('#new_question').on('submit', function(e){
    e.preventDefault();

    var number = $(this).find('input[name="survey_id"]').val();
    JSON.stringify(number);
    var input = $(this).find('input[name="content"]');
    var value = input.val();
    input.val('');

    $.ajax({
      method: 'post',
      url: '/question',
      data: {survey_id: number, content: value},
      success: function(response){
        question = JSON.parse(response)
        new_question = buildQuestion(question.content);
        $('#question_list ol').append(new_question);
      },
    });
  });

  $('.new_choice').on('submit', function(e){
    e.preventDefault();

    var $ul = $(this).parent().find('ul');

    var number = $(this).find('input[name="question_id"]').val();
    JSON.stringify(number);
    var input = $(this).find('input[name="content"]');
    var value = input.val();
    input.val('');

    $.ajax({
        method: 'post',
        url: '/choices',
        data: {question_id: number, content: value},
        success: function(response){
          choice = JSON.parse(response)
          var li = $('<li></li>').text(choice.content);
          $ul.append(li)
        },
      });

  });

  function buildQuestion(questionContent) {
    var questionTemplate = $.trim($('#question_template').html());
    var $question = $(questionTemplate);
    $question.closest('li').text(questionContent);
    return $question;
  };

});
