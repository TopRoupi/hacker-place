// Configure your import map in config/importmap.rb.
// Read more: https://github.com/rails/importmap-rails

import "controllers"
import "channels"
import "config"

import * as Turbo from '@hotwired/turbo'
Turbo.start()

window.Turbo = Turbo

import hljs from "highlight.js"
window.hljs = hljs
