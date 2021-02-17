$(document).on('turbolinks:load', function() {
  $("#new_task_form").validationEngine({
    promptPosition: "inline"
  });
});
