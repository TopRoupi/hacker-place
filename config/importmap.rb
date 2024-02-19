# Pin npm packages by running ./bin/importmap

pin "@hotwired/turbo-rails", to: "@hotwired--turbo-rails.js" # @8.0.2
pin "@hotwired/turbo", to: "@hotwired--turbo.js" # @8.0.2
pin "@rails/actioncable/src", to: "@rails--actioncable--src.js" # @7.1.3

pin "@hotwired/stimulus", to: "@hotwired--stimulus.js" # @3.2.2
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"

pin "@rails/actioncable", to: "@rails--actioncable.js" # @7.1.3
pin "@rails/activestorage", to: "activestorage.esm.js"
pin "@rails/actiontext", to: "actiontext.esm.js"
pin "@rails/request.js", to: "actiontext.esm.js"

pin "highlight.js", to: "https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.9.0/es/highlight.min.js"
pin "stimulus_reflex" # @3.5.0
pin "cable_ready" # @5.0.3
pin "morphdom" # @2.6.1
pin "codejar" # @4.2.0

pin_all_from "app/javascript/config", under: "config"
pin_all_from "app/javascript/controllers", under: "controllers"
pin_all_from "app/javascript/channels", under: "channels"

pin "application"
