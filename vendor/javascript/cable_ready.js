import e from"morphdom";var t="cable_ready";var n="5.0.3";var r="CableReady helps you create great real-time user experiences by making it simple to trigger client-side DOM changes from server-side Ruby.";var s=["ruby","rails","websockets","actioncable","cable","ssr","stimulus_reflex","client-side","dom"];var a="https://cableready.stimulusreflex.com";var o="https://github.com/stimulusreflex/cable_ready/issues";var i="https://github.com/stimulusreflex/cable_ready";var l="MIT";var c="Nathan Hopkins <natehop@gmail.com>";var u=["Andrew Mason <andrewmcodes@protonmail.com>","Julian Rubisch <julian@julianrubisch.at>","Marco Roth <marco.roth@intergga.ch>","Nathan Hopkins <natehop@gmail.com>"];var d="./dist/cable_ready.js";var m="./dist/cable_ready.js";var h="./dist/cable_ready.js";var p="./dist/cable_ready.umd.js";var f="./dist/cable_ready.umd.js";var b=["dist/*","javascript/*"];var g={lint:"yarn run format --check",format:"yarn run prettier-standard ./javascript/**/*.js rollup.config.mjs",build:"yarn rollup -c",watch:"yarn rollup -wc",test:"web-test-runner javascript/test/**/*.test.js","docs:dev":"vitepress dev docs","docs:build":"vitepress build docs && cp ./docs/_redirects ./docs/.vitepress/dist","docs:preview":"vitepress preview docs"};var y={morphdom:"2.6.1"};var v={"@open-wc/testing":"^3.1.7","@rollup/plugin-json":"^6.0.0","@rollup/plugin-node-resolve":"^15.0.1","@rollup/plugin-terser":"^0.4.0","@web/dev-server-esbuild":"^0.3.3","@web/dev-server-rollup":"^0.3.21","@web/test-runner":"^0.15.1","prettier-standard":"^16.4.1",rollup:"^3.19.1",sinon:"^15.0.2",vite:"^4.1.4",vitepress:"^1.0.0-beta.1","vitepress-plugin-search":"^1.0.4-alpha.19"};var w={name:t,version:n,description:r,keywords:s,homepage:a,bugs:o,repository:i,license:l,author:c,contributors:u,main:d,module:m,browser:h,import:"./dist/cable_ready.js",unpkg:p,umd:f,files:b,scripts:g,dependencies:y,devDependencies:v};const S={INPUT:true,TEXTAREA:true,SELECT:true};const E={INPUT:true,TEXTAREA:true,OPTION:true};const A={"datetime-local":true,"select-multiple":true,"select-one":true,color:true,date:true,datetime:true,email:true,month:true,number:true,password:true,range:true,search:true,tel:true,text:true,textarea:true,time:true,url:true,week:true};let T;var C={get element(){return T},set(e){T=e}};const isTextInput=e=>S[e.tagName]&&A[e.type];const assignFocus=e=>{const t=e&&e.nodeType===Node.ELEMENT_NODE?e:document.querySelector(e);const n=t||C.element;n&&n.focus&&n.focus()};const dispatch=(e,t,n={})=>{const r={bubbles:true,cancelable:true,detail:n};const s=new CustomEvent(t,r);e.dispatchEvent(s);window.jQuery&&window.jQuery(e).trigger(t,n)};const xpathToElement=e=>document.evaluate(e,document,null,XPathResult.FIRST_ORDERED_NODE_TYPE,null).singleNodeValue;const xpathToElementArray=(e,t=false)=>{const n=document.evaluate(e,document,null,XPathResult.ORDERED_NODE_SNAPSHOT_TYPE,null);const r=[];for(let e=0;e<n.snapshotLength;e++)r.push(n.snapshotItem(e));return t?r.reverse():r};const getClassNames=e=>Array.from(e).flat();const processElements=(e,t)=>{Array.from(e.selectAll?e.element:[e.element]).forEach(t)};const O=createCompounder((function(e,t,n){return e+(n?"-":"")+t.toLowerCase()}));function createCompounder(e){return function(t){return words(t).reduce(e,"")}}const words=e=>{e=e==null?"":e;return e.match(/([A-Z]{2,}|[0-9]+|[A-Z]?[a-z]+|[A-Z])/g)||[]};const operate=(e,t)=>{if(!e.cancel){e.delay?setTimeout(t,e.delay):t();return true}return false};const before=(e,t)=>dispatch(e,`cable-ready:before-${O(t.operation)}`,t);const after=(e,t)=>dispatch(e,`cable-ready:after-${O(t.operation)}`,t);function debounce(e,t=250){let n;return(...r)=>{const callback=()=>e.apply(this,r);n&&clearTimeout(n);n=setTimeout(callback,t)}}function handleErrors(e){if(!e.ok)throw Error(e.statusText);return e}function safeScalar(e){e===void 0||["string","number","boolean"].includes(typeof e)||console.warn(`Operation expects a string, number or boolean, but got ${e} (${typeof e})`);return e!=null?e:""}function safeString(e){e!==void 0&&typeof e!=="string"&&console.warn(`Operation expects a string, but got ${e} (${typeof e})`);return e!=null?String(e):""}function safeArray(e){e===void 0||Array.isArray(e)||console.warn(`Operation expects an array, but got ${e} (${typeof e})`);return e!=null?Array.from(e):[]}function safeObject(e){e!==void 0&&typeof e!=="object"&&console.warn(`Operation expects an object, but got ${e} (${typeof e})`);return e!=null?Object(e):{}}function safeStringOrArray(e){e===void 0||Array.isArray(e)||typeof e==="string"||console.warn(`Operation expects an Array or a String, but got ${e} (${typeof e})`);return e==null?"":Array.isArray(e)?Array.from(e):String(e)}function fragmentToString(e){return(new XMLSerializer).serializeToString(e)}async function graciouslyFetch(e,t){try{const n=await fetch(e,{headers:{"X-REQUESTED-WITH":"XmlHttpRequest",...t}});if(n==void 0)return;handleErrors(n);return n}catch(t){console.error(`Could not fetch ${e}`)}}class BoundedQueue{constructor(e){this.maxSize=e;this.queue=[]}push(e){this.isFull()&&this.shift();this.queue.push(e)}shift(){return this.queue.shift()}isFull(){return this.queue.length===this.maxSize}}var L=Object.freeze({__proto__:null,BoundedQueue:BoundedQueue,after:after,assignFocus:assignFocus,before:before,debounce:debounce,dispatch:dispatch,fragmentToString:fragmentToString,getClassNames:getClassNames,graciouslyFetch:graciouslyFetch,handleErrors:handleErrors,isTextInput:isTextInput,kebabize:O,operate:operate,processElements:processElements,safeArray:safeArray,safeObject:safeObject,safeScalar:safeScalar,safeString:safeString,safeStringOrArray:safeStringOrArray,xpathToElement:xpathToElement,xpathToElementArray:xpathToElementArray});const shouldMorph=e=>(t,n)=>!x.map((r=>typeof r!=="function"||r(e,t,n))).includes(false);const didMorph=e=>t=>{M.forEach((n=>{typeof n==="function"&&n(e,t)}))};const verifyNotMutable=(e,t,n)=>!(!E[t.tagName]&&t.isEqualNode(n));const verifyNotContentEditable=(e,t,n)=>t!==C.element||!t.isContentEditable;const verifyNotPermanent=(e,t,n)=>{const{permanentAttributeName:r}=e;if(!r)return true;const s=t.closest(`[${r}]`);if(!s&&t===C.element&&isTextInput(t)){const e={value:true};Array.from(n.attributes).forEach((n=>{e[n.name]||t.setAttribute(n.name,n.value)}));return false}return!s};const x=[verifyNotMutable,verifyNotPermanent,verifyNotContentEditable];const M=[];var $=Object.freeze({__proto__:null,didMorph:didMorph,didMorphCallbacks:M,shouldMorph:shouldMorph,shouldMorphCallbacks:x,verifyNotContentEditable:verifyNotContentEditable,verifyNotMutable:verifyNotMutable,verifyNotPermanent:verifyNotPermanent});var j={append:e=>{processElements(e,(t=>{before(t,e);operate(e,(()=>{const{html:n,focusSelector:r}=e;t.insertAdjacentHTML("beforeend",safeScalar(n));assignFocus(r)}));after(t,e)}))},graft:e=>{processElements(e,(t=>{before(t,e);operate(e,(()=>{const{parent:n,focusSelector:r}=e;const s=document.querySelector(n);if(s){s.appendChild(t);assignFocus(r)}}));after(t,e)}))},innerHtml:e=>{processElements(e,(t=>{before(t,e);operate(e,(()=>{const{html:n,focusSelector:r}=e;t.innerHTML=safeScalar(n);assignFocus(r)}));after(t,e)}))},insertAdjacentHtml:e=>{processElements(e,(t=>{before(t,e);operate(e,(()=>{const{html:n,position:r,focusSelector:s}=e;t.insertAdjacentHTML(r||"beforeend",safeScalar(n));assignFocus(s)}));after(t,e)}))},insertAdjacentText:e=>{processElements(e,(t=>{before(t,e);operate(e,(()=>{const{text:n,position:r,focusSelector:s}=e;t.insertAdjacentText(r||"beforeend",safeScalar(n));assignFocus(s)}));after(t,e)}))},outerHtml:e=>{processElements(e,(t=>{const n=t.parentElement;const r=n&&Array.from(n.children).indexOf(t);before(t,e);operate(e,(()=>{const{html:n,focusSelector:r}=e;t.outerHTML=safeScalar(n);assignFocus(r)}));after(n?n.children[r]:document.documentElement,e)}))},prepend:e=>{processElements(e,(t=>{before(t,e);operate(e,(()=>{const{html:n,focusSelector:r}=e;t.insertAdjacentHTML("afterbegin",safeScalar(n));assignFocus(r)}));after(t,e)}))},remove:e=>{processElements(e,(t=>{before(t,e);operate(e,(()=>{const{focusSelector:n}=e;t.remove();assignFocus(n)}));after(document,e)}))},replace:e=>{processElements(e,(t=>{const n=t.parentElement;const r=n&&Array.from(n.children).indexOf(t);before(t,e);operate(e,(()=>{const{html:n,focusSelector:r}=e;t.outerHTML=safeScalar(n);assignFocus(r)}));after(n?n.children[r]:document.documentElement,e)}))},textContent:e=>{processElements(e,(t=>{before(t,e);operate(e,(()=>{const{text:n,focusSelector:r}=e;t.textContent=safeScalar(n);assignFocus(r)}));after(t,e)}))},addCssClass:e=>{processElements(e,(t=>{before(t,e);operate(e,(()=>{const{name:n}=e;t.classList.add(...getClassNames([safeStringOrArray(n)]))}));after(t,e)}))},removeAttribute:e=>{processElements(e,(t=>{before(t,e);operate(e,(()=>{const{name:n}=e;t.removeAttribute(safeString(n))}));after(t,e)}))},removeCssClass:e=>{processElements(e,(t=>{before(t,e);operate(e,(()=>{const{name:n}=e;t.classList.remove(...getClassNames([safeStringOrArray(n)]));t.classList.length===0&&t.removeAttribute("class")}));after(t,e)}))},setAttribute:e=>{processElements(e,(t=>{before(t,e);operate(e,(()=>{const{name:n,value:r}=e;t.setAttribute(safeString(n),safeScalar(r))}));after(t,e)}))},setDatasetProperty:e=>{processElements(e,(t=>{before(t,e);operate(e,(()=>{const{name:n,value:r}=e;t.dataset[safeString(n)]=safeScalar(r)}));after(t,e)}))},setProperty:e=>{processElements(e,(t=>{before(t,e);operate(e,(()=>{const{name:n,value:r}=e;n in t&&(t[safeString(n)]=safeScalar(r))}));after(t,e)}))},setStyle:e=>{processElements(e,(t=>{before(t,e);operate(e,(()=>{const{name:n,value:r}=e;t.style[safeString(n)]=safeScalar(r)}));after(t,e)}))},setStyles:e=>{processElements(e,(t=>{before(t,e);operate(e,(()=>{const{styles:n}=e;for(let[e,r]of Object.entries(n))t.style[safeString(e)]=safeScalar(r)}));after(t,e)}))},setValue:e=>{processElements(e,(t=>{before(t,e);operate(e,(()=>{const{value:n}=e;t.value=safeScalar(n)}));after(t,e)}))},dispatchEvent:e=>{processElements(e,(t=>{before(t,e);operate(e,(()=>{const{name:n,detail:r}=e;dispatch(t,safeString(n),safeObject(r))}));after(t,e)}))},setMeta:e=>{before(document,e);operate(e,(()=>{const{name:t,content:n}=e;let r=document.head.querySelector(`meta[name='${t}']`);if(!r){r=document.createElement("meta");r.name=safeString(t);document.head.appendChild(r)}r.content=safeScalar(n)}));after(document,e)},setTitle:e=>{before(document,e);operate(e,(()=>{const{title:t}=e;document.title=safeScalar(t)}));after(document,e)},clearStorage:e=>{before(document,e);operate(e,(()=>{const{type:t}=e;const n=t==="session"?sessionStorage:localStorage;n.clear()}));after(document,e)},go:e=>{before(window,e);operate(e,(()=>{const{delta:t}=e;history.go(t)}));after(window,e)},pushState:e=>{before(window,e);operate(e,(()=>{const{state:t,title:n,url:r}=e;history.pushState(safeObject(t),safeString(n),safeString(r))}));after(window,e)},redirectTo:e=>{before(window,e);operate(e,(()=>{let{url:t,action:n,turbo:r}=e;n=n||"advance";t=safeString(t);r===void 0&&(r=true);if(r){window.Turbo&&window.Turbo.visit(t,{action:n});window.Turbolinks&&window.Turbolinks.visit(t,{action:n});window.Turbo||window.Turbolinks||(window.location.href=t)}else window.location.href=t}));after(window,e)},reload:e=>{before(window,e);operate(e,(()=>{window.location.reload()}));after(window,e)},removeStorageItem:e=>{before(document,e);operate(e,(()=>{const{key:t,type:n}=e;const r=n==="session"?sessionStorage:localStorage;r.removeItem(safeString(t))}));after(document,e)},replaceState:e=>{before(window,e);operate(e,(()=>{const{state:t,title:n,url:r}=e;history.replaceState(safeObject(t),safeString(n),safeString(r))}));after(window,e)},scrollIntoView:e=>{const{element:t}=e;before(t,e);operate(e,(()=>{t.scrollIntoView(e)}));after(t,e)},setCookie:e=>{before(document,e);operate(e,(()=>{const{cookie:t}=e;document.cookie=safeScalar(t)}));after(document,e)},setFocus:e=>{const{element:t}=e;before(t,e);operate(e,(()=>{assignFocus(t)}));after(t,e)},setStorageItem:e=>{before(document,e);operate(e,(()=>{const{key:t,value:n,type:r}=e;const s=r==="session"?sessionStorage:localStorage;s.setItem(safeString(t),safeScalar(n))}));after(document,e)},consoleLog:e=>{before(document,e);operate(e,(()=>{const{message:t,level:n}=e;n&&["warn","info","error"].includes(n)?console[n](t):console.log(t)}));after(document,e)},consoleTable:e=>{before(document,e);operate(e,(()=>{const{data:t,columns:n}=e;console.table(t,safeArray(n))}));after(document,e)},notification:e=>{before(document,e);operate(e,(()=>{const{title:t,options:n}=e;Notification.requestPermission().then((r=>{e.permission=r;r==="granted"&&new Notification(safeString(t),safeObject(n))}))}));after(document,e)},morph:t=>{processElements(t,(n=>{const{html:r}=t;const s=document.createElement("template");s.innerHTML=String(safeScalar(r)).trim();t.content=s.content;const a=n.parentElement;const o=a&&Array.from(a.children).indexOf(n);before(n,t);operate(t,(()=>{const{childrenOnly:r,focusSelector:a}=t;e(n,r?s.content:s.innerHTML,{childrenOnly:!!r,onBeforeElUpdated:shouldMorph(t),onElUpdated:didMorph(t)});assignFocus(a)}));after(a?a.children[o]:document.documentElement,t)}))}};let k=j;const add=e=>{k={...k,...e}};const addOperations=e=>{add(e)};const addOperation=(e,t)=>{const n={};n[e]=t;add(n)};var R={get all(){return k}};let _="warn";var N={get behavior(){return _},set(e){["warn","ignore","event","exception"].includes(e)?_=e:console.warn("Invalid 'onMissingElement' option. Defaulting to 'warn'.")}};const perform=(e,t={onMissingElement:N.behavior})=>{const n={};e.forEach((e=>{!e.batch||(n[e.batch]=n[e.batch]?++n[e.batch]:1)}));e.forEach((e=>{const r=e.operation;try{e.selector?e.xpath?e.element=e.selectAll?xpathToElementArray(e.selector):xpathToElement(e.selector):e.element=e.selectAll?document.querySelectorAll(e.selector):document.querySelector(e.selector):e.element=document;if(e.element||t.onMissingElement!=="ignore"){C.set(document.activeElement);const t=R.all[r];if(t){t(e);!e.batch||--n[e.batch]!==0||dispatch(document,"cable-ready:batch-complete",{batch:e.batch})}else console.error(`CableReady couldn't find the "${r}" operation. Make sure you use the camelized form when calling an operation method.`)}}catch(n){if(e.element){console.error(`CableReady detected an error in ${r||"operation"}: ${n.message}. If you need to support older browsers make sure you've included the corresponding polyfills. https://docs.stimulusreflex.com/setup#polyfills-for-ie11.`);console.error(n)}else{const n=`CableReady ${r||""} operation failed due to missing DOM element for selector: '${e.selector}'`;switch(t.onMissingElement){case"ignore":break;case"event":dispatch(document,"cable-ready:missing-element",{warning:n,operation:e});break;case"exception":throw n;default:console.warn(n)}}}}))};const performAsync=(e,t={onMissingElement:N.behavior})=>new Promise(((n,r)=>{try{n(perform(e,t))}catch(e){r(e)}}));class SubscribingElement extends HTMLElement{static get tagName(){throw new Error("Implement the tagName() getter in the inheriting class")}static define(){customElements.get(this.tagName)||customElements.define(this.tagName,this)}disconnectedCallback(){this.channel&&this.channel.unsubscribe()}createSubscription(e,t,n){this.channel=e.subscriptions.create({channel:t,identifier:this.identifier},{received:n})}get preview(){return document.documentElement.hasAttribute("data-turbolinks-preview")||document.documentElement.hasAttribute("data-turbo-preview")}get identifier(){return this.getAttribute("identifier")}}let U;const D=[25,50,75,100,200,250,500,800,1e3,2e3];const wait=e=>new Promise((t=>setTimeout(t,e)));const getConsumerWithRetry=async(e=0)=>{if(U)return U;if(e>=D.length)throw new Error("Couldn't obtain a Action Cable consumer within 5s");await wait(D[e]);return await getConsumerWithRetry(e+1)};var q={setConsumer(e){U=e},get consumer(){return U},async getConsumer(){return await getConsumerWithRetry()}};class StreamFromElement extends SubscribingElement{static get tagName(){return"cable-ready-stream-from"}async connectedCallback(){if(this.preview)return;const e=await q.getConsumer();e?this.createSubscription(e,"CableReady::Stream",this.performOperations.bind(this)):console.error("The `cable_ready_stream_from` helper cannot connect. You must initialize CableReady with an Action Cable consumer.")}performOperations(e){e.cableReady&&perform(e.operations,{onMissingElement:this.onMissingElement})}get onMissingElement(){const e=this.getAttribute("missing")||N.behavior;if(["warn","ignore","event"].includes(e))return e;console.warn("Invalid 'missing' attribute. Defaulting to 'warn'.");return"warn"}}let I=false;var F={get enabled(){return I},get disabled(){return!I},get value(){return I},set(e){I=!!e},set debug(e){I=!!e}};const request=(e,t)=>{if(F.disabled)return;const n=`↑ Updatable request affecting ${t.length} element(s): `;console.log(n,{elements:t.map((e=>e.element)),identifiers:t.map((e=>e.element.getAttribute("identifier"))),data:e});return n};const cancel=(e,t)=>{if(F.disabled)return;const n=new Date-e;const r=`❌ Updatable request canceled after ${n}ms: ${t}`;console.log(r);return r};const response=(e,t,n)=>{if(F.disabled)return;const r=new Date-e;const s=`↓ Updatable response: All URLs fetched in ${r}ms`;console.log(s,{element:t,urls:n});return s};const morphStart=(e,t)=>{if(F.disabled)return;const n=new Date-e;const r=`↻ Updatable morph: starting after ${n}ms`;console.log(r,{element:t});return r};const morphEnd=(e,t)=>{if(F.disabled)return;const n=new Date-e;const r=`↺ Updatable morph: completed after ${n}ms`;console.log(r,{element:t});return r};var H={request:request,cancel:cancel,response:response,morphStart:morphStart,morphEnd:morphEnd};class AppearanceObserver{constructor(e,t=null){this.delegate=e;this.element=t||e;this.started=false;this.intersecting=false;this.intersectionObserver=new IntersectionObserver(this.intersect)}start(){if(!this.started){this.started=true;this.intersectionObserver.observe(this.element);this.observeVisibility()}}stop(){if(this.started){this.started=false;this.intersectionObserver.unobserve(this.element);this.unobserveVisibility()}}observeVisibility=()=>{document.addEventListener("visibilitychange",this.handleVisibilityChange)};unobserveVisibility=()=>{document.removeEventListener("visibilitychange",this.handleVisibilityChange)};intersect=e=>{e.forEach((e=>{if(e.target===this.element)if(e.isIntersecting&&document.visibilityState==="visible"){this.intersecting=true;this.delegate.appearedInViewport()}else{this.intersecting=false;this.delegate.disappearedFromViewport()}}))};handleVisibilityChange=e=>{document.visibilityState==="visible"&&this.intersecting?this.delegate.appearedInViewport():this.delegate.disappearedFromViewport()}}const P="\n<style>\n  :host {\n    display: block;\n  }\n</style>\n<slot></slot>\n";class UpdatesForElement extends SubscribingElement{static get tagName(){return"cable-ready-updates-for"}constructor(){super();const e=this.attachShadow({mode:"open"});e.innerHTML=P;this.triggerElementLog=new BoundedQueue(10);this.targetElementLog=new BoundedQueue(10);this.appearanceObserver=new AppearanceObserver(this);this.visible=false;this.didTransitionToVisible=false}async connectedCallback(){if(this.preview)return;this.update=debounce(this.update.bind(this),this.debounce);const e=await q.getConsumer();e?this.createSubscription(e,"CableReady::Stream",this.update):console.error("The `cable_ready_updates_for` helper cannot connect. You must initialize CableReady with an Action Cable consumer.");this.observeAppearance&&this.appearanceObserver.start()}disconnectedCallback(){this.observeAppearance&&this.appearanceObserver.stop()}async update(e){this.lastUpdateTimestamp=new Date;const t=Array.from(document.querySelectorAll(this.query),(e=>new Block(e))).filter((t=>t.shouldUpdate(e)));this.triggerElementLog.push(`${(new Date).toLocaleString()}: ${H.request(e,t)}`);if(t.length===0){this.triggerElementLog.push(`${(new Date).toLocaleString()}: ${H.cancel(this.lastUpdateTimestamp,"All elements filtered out")}`);return}if(t[0].element!==this&&!this.didTransitionToVisible){this.triggerElementLog.push(`${(new Date).toLocaleString()}: ${H.cancel(this.lastUpdateTimestamp,"Update already requested")}`);return}C.set(document.activeElement);this.html={};const n=[...new Set(t.map((e=>e.url)))];await Promise.all(n.map((async e=>{if(!this.html.hasOwnProperty(e)){const t=await graciouslyFetch(e,{"X-Cable-Ready":"update"});this.html[e]=await t.text()}})));this.triggerElementLog.push(`${(new Date).toLocaleString()}: ${H.response(this.lastUpdateTimestamp,this,n)}`);this.index={};t.forEach((t=>{this.index.hasOwnProperty(t.url)?this.index[t.url]++:this.index[t.url]=0;t.process(e,this.html,this.index,this.lastUpdateTimestamp)}))}appearedInViewport(){if(!this.visible){this.didTransitionToVisible=true;this.update({})}this.visible=true}disappearedFromViewport(){this.visible=false}get query(){return`${this.tagName}[identifier="${this.identifier}"]`}get identifier(){return this.getAttribute("identifier")}get debounce(){return this.hasAttribute("debounce")?parseInt(this.getAttribute("debounce")):20}get observeAppearance(){return this.hasAttribute("observe-appearance")}}class Block{constructor(e){this.element=e}async process(t,n,r,s){const a=r[this.url];const o=document.createElement("template");this.element.setAttribute("updating","updating");o.innerHTML=String(n[this.url]).trim();await this.resolveTurboFrames(o.content);const i=o.content.querySelectorAll(this.query);if(i.length<=a){console.warn(`Update aborted due to insufficient number of elements. The offending url is ${this.url}, the offending element is:`,this.element);return}const l={element:this.element,html:i[a],permanentAttributeName:"data-ignore-updates"};dispatch(this.element,"cable-ready:before-update",l);this.element.targetElementLog.push(`${(new Date).toLocaleString()}: ${H.morphStart(s,this.element)}`);e(this.element,i[a],{childrenOnly:true,onBeforeElUpdated:shouldMorph(l),onElUpdated:e=>{this.element.removeAttribute("updating");this.element.didTransitionToVisible=false;dispatch(this.element,"cable-ready:after-update",l);assignFocus(l.focusSelector)}});this.element.targetElementLog.push(`${(new Date).toLocaleString()}: ${H.morphEnd(s,this.element)}`)}async resolveTurboFrames(e){const t=[...e.querySelectorAll('turbo-frame[src]:not([loading="lazy"])')];return Promise.all(t.map((t=>new Promise((async n=>{const r=await graciouslyFetch(t.getAttribute("src"),{"Turbo-Frame":t.id,"X-Cable-Ready":"update"});const s=document.createElement("template");s.innerHTML=await r.text();await this.resolveTurboFrames(s.content);const a=`turbo-frame#${t.id}`;const o=s.content.querySelector(a);const i=o?o.innerHTML.trim():"";e.querySelector(a).innerHTML=i;n()})))))}shouldUpdate(e){return!this.ignoresInnerUpdates&&this.hasChangesSelectedForUpdate(e)&&(!this.observeAppearance||this.visible)}hasChangesSelectedForUpdate(e){const t=this.element.getAttribute("only");return!(t&&e.changed&&!t.split(" ").some((t=>e.changed.includes(t))))}get ignoresInnerUpdates(){return this.element.hasAttribute("ignore-inner-updates")&&this.element.hasAttribute("performing-inner-update")}get url(){return this.element.hasAttribute("url")?this.element.getAttribute("url"):location.href}get identifier(){return this.element.identifier}get query(){return this.element.query}get visible(){return this.element.visible}get observeAppearance(){return this.element.observeAppearance}}const registerInnerUpdates=()=>{document.addEventListener("stimulus-reflex:before",(e=>{recursiveMarkUpdatesForElements(e.detail.element)}));document.addEventListener("stimulus-reflex:after",(e=>{setTimeout((()=>{recursiveUnmarkUpdatesForElements(e.detail.element)}))}));document.addEventListener("turbo:submit-start",(e=>{recursiveMarkUpdatesForElements(e.target)}));document.addEventListener("turbo:submit-end",(e=>{setTimeout((()=>{recursiveUnmarkUpdatesForElements(e.target)}))}));document.addEventListener("turbo-boost:command:start",(e=>{recursiveMarkUpdatesForElements(e.target)}));document.addEventListener("turbo-boost:command:finish",(e=>{setTimeout((()=>{recursiveUnmarkUpdatesForElements(e.target)}))}));document.addEventListener("turbo-boost:command:error",(e=>{setTimeout((()=>{recursiveUnmarkUpdatesForElements(e.target)}))}))};const recursiveMarkUpdatesForElements=e=>{const t=e&&e.parentElement&&e.parentElement.closest("cable-ready-updates-for");if(t){t.setAttribute("performing-inner-update","");recursiveMarkUpdatesForElements(t)}};const recursiveUnmarkUpdatesForElements=e=>{const t=e&&e.parentElement&&e.parentElement.closest("cable-ready-updates-for");if(t){t.removeAttribute("performing-inner-update");recursiveUnmarkUpdatesForElements(t)}};const defineElements=()=>{registerInnerUpdates();StreamFromElement.define();UpdatesForElement.define()};const initialize=(e={})=>{const{consumer:t,onMissingElement:n,debug:r}=e;F.set(!!r);t?q.setConsumer(t):console.error("CableReady requires a reference to your Action Cable `consumer` for its helpers to function.\nEnsure that you have imported the `CableReady` package as well as `consumer` from your `channels` folder, then call `CableReady.initialize({ consumer })`.");n&&MissingElement.set(n);defineElements()};const V={perform:perform,performAsync:performAsync,shouldMorphCallbacks:x,didMorphCallbacks:M,initialize:initialize,addOperation:addOperation,addOperations:addOperations,version:w.version,cable:q,get DOMOperations(){console.warn("DEPRECATED: Please use `CableReady.operations` instead of `CableReady.DOMOperations`");return R.all},get operations(){return R.all},get consumer(){return q.consumer}};window.CableReady=V;export{$ as MorphCallbacks,StreamFromElement,SubscribingElement,UpdatesForElement,L as Utils,V as default};

