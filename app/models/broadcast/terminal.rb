module Broadcast
  class Terminal
    include Rails.application.routes.url_helpers
    include ActionView::RecordIdentifier
    include CableReady::Broadcaster

    attr_reader :lgo

    def clear_terminal
      cable_ready[TerminalChannel]
        .inner_html(
          selector: "#run_stdout",
          html: ""
        )
        .broadcast_to("test")
    end

    # input_text is the string passed to the lua input() method
    def enable_input(input_text)
      cable_ready[TerminalChannel]
        .append(
          selector: "#run_stdout",
          html: input_text
        )
        .inner_html(
          selector: "#stdin_status",
          html: "waiting for input: "
        )
        .remove_attribute(
          name: "disabled",
          selector: "#run_stdin"
        )
        .remove_attribute(
          name: "disabled",
          selector: "#run_stdin_btn"
        )
        .broadcast_to("test")
    end

    # inputed_text is the value the user typed
    def disable_input(inputed_text)
      cable_ready[TerminalChannel]
        .append(
          selector: "#run_stdout",
          html: "#{inputed_text}\n"
        )
        .inner_html(
          selector: "#stdin_status",
          html: ""
        )
        .set_attribute(
          name: "disabled",
          value: "",
          selector: "#run_stdin"
        )
        .set_value(
          name: "disabled",
          value: "",
          selector: "#run_stdin"
        )
        .set_attribute(
          name: "disabled",
          value: "",
          selector: "#run_stdin_btn"
        )
        .broadcast_to("test")
    end
  end
end
