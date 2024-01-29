import "../controllers"
import "../config"
import "../channels"
import "~/index.css"
// import ActiveStorage from '@rails/activestorage'
// ActiveStorage.start()

import * as Turbo from '@hotwired/turbo'
Turbo.start()

import hljs from "highlight.js/lib/core"
import hljsDefineLua from 'highlight.js/lib/languages/lua'

import "highlight.js/styles/base16/brewer.css"

hljs.registerLanguage('lua', hljsDefineLua);

window.hljs = hljs
