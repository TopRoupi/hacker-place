module Broadcast
  class Terminal < ApplicationBroadcast
    attr_reader :id

    def initialize(id, terminal_id)
      @id = id
      @terminal_id = terminal_id
    end

    def print(text)
      cable_ready[TerminalChannel]
        .append(
          selector: "##{@terminal_id}-run_stdout",
          html: "#{text}\n"
        )
        .broadcast_to(id)
    end

    def print_error(error)
      cable_ready[TerminalChannel]
        .append(
          selector: "##{@terminal_id}-run_stdout",
          html: "<span style='color: red'>#{error}</span>\n"
        )
        .broadcast_to(id)
    end

    def clear_terminal
      cable_ready[TerminalChannel]
        .inner_html(
          selector: "##{@terminal_id}-run_stdout",
          html: ""
        )
        .broadcast_to(id)
    end

    # input_text is the string passed to the lua input() method
    def enable_input(input_text)
      cable_ready[TerminalChannel]
        .append(
          selector: "##{@terminal_id}-run_stdout",
          html: input_text
        )
        .inner_html(
          selector: "##{@terminal_id}-stdin_status",
          html: "waiting for input: "
        )
        .remove_attribute(
          name: "disabled",
          selector: "##{@terminal_id}-run-stdin-input"
        )
        .remove_attribute(
          name: "disabled",
          selector: "##{@terminal_id}-run_stdin_btn"
        )
        .broadcast_to(id)
    end

    # inputed_text is the value the user typed
    def disable_input(inputed_text)
      cable_ready[TerminalChannel]
        .append(
          selector: "##{@terminal_id}-run_stdout",
          html: "#{inputed_text}\n"
        )
        .inner_html(
          selector: "##{@terminal_id}-stdin_status",
          html: ""
        )
        .set_attribute(
          name: "disabled",
          value: "",
          selector: "##{@terminal_id}-run-stdin-input"
        )
        .set_value(
          name: "disabled",
          value: "",
          selector: "##{@terminal_id}-run-stdin-input"
        )
        .set_attribute(
          name: "disabled",
          value: "",
          selector: "##{@terminal_id}-run_stdin_btn"
        )
        .broadcast_to(id)
    end
  end
end
