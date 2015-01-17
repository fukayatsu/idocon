alertMessage = (text, type) ->
  type = "success"  unless type
  $("#alert_message").text text
  $("#alert").attr "class", "alert fade in alert-" + type
  setTimeout (->
    $("#alert").removeClass "in"
    return
  ), 3000
  return

$(document).on "click", "[data-remote]", (event) ->
  command = $(this).data("remote")
  $.ajax
    type: "POST"
    url: "/remote"
    data:
      command: command

    success: (res) ->
      alertMessage "[sent] " + command
      return

    error: (res) ->
      alertMessage "[failure] " + command, "danger"
      return

  return
