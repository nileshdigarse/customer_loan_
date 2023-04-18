module ApplicationHelper
  def show_error_message(model_name, attr)
    error_messages = ""
    model_name.errors.full_messages_for(:"#{attr}").each do |message|
      error_messages += "<div class='text-red-500 text-xs italic'>" + message + "</div>"
    end
    error_messages.html_safe
  end
end
