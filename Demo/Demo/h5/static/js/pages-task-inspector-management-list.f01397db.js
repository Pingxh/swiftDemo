(window["webpackJsonp"]=window["webpackJsonp"]||[]).push([["pages-task-inspector-management-list"],{8688:function(t,n,i){"use strict";Object.defineProperty(n,"__esModule",{value:!0}),n.default=void 0;var e={data:function(){return{taskList:[]}},onShow:function(){var t=this;this.$api.task.task_sponsor_list().then((function(n){t.taskList=n.result.list})).catch((function(t){console.info(t)}))},methods:{view:function(t){uni.navigateTo({url:"view?uuid="+t.taskUuid})}}};n.default=e},e103:function(t,n,i){"use strict";var e={"uni-section":i("9ff0").default,"uni-list":i("b370").default,"uni-list-item":i("897a").default},u=function(){var t=this,n=t.$createElement,i=t._self._c||n;return i("v-uni-view",{staticClass:"ok_main"},[i("uni-section",{attrs:{title:"任务列表",type:"line"}}),i("uni-list",t._l(t.taskList,(function(n,e){return i("uni-list-item",{key:e,attrs:{title:n.taskTitle,rightText:t.$ok.v.getTaskStatus(n.taskStatus)},on:{click:function(i){arguments[0]=i=t.$handleEvent(i),t.view(n)}}})})),1)],1)},a=[];i.d(n,"b",(function(){return u})),i.d(n,"c",(function(){return a})),i.d(n,"a",(function(){return e}))},e338:function(t,n,i){"use strict";i.r(n);var e=i("8688"),u=i.n(e);for(var a in e)"default"!==a&&function(t){i.d(n,t,(function(){return e[t]}))}(a);n["default"]=u.a},e672:function(t,n,i){"use strict";i.r(n);var e=i("e103"),u=i("e338");for(var a in u)"default"!==a&&function(t){i.d(n,t,(function(){return u[t]}))}(a);var s,o=i("f0c5"),r=Object(o["a"])(u["default"],e["b"],e["c"],!1,null,"03cfcbb1",null,!1,e["a"],s);n["default"]=r.exports}}]);