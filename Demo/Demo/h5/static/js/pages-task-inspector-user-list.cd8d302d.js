(window["webpackJsonp"]=window["webpackJsonp"]||[]).push([["pages-task-inspector-user-list"],{"0be8":function(t,n,i){"use strict";i.r(n);var e=i("f417"),u=i.n(e);for(var a in e)"default"!==a&&function(t){i.d(n,t,(function(){return e[t]}))}(a);n["default"]=u.a},"97c5":function(t,n,i){"use strict";var e={"uni-section":i("9ff0").default,"uni-list":i("b370").default,"uni-list-item":i("897a").default},u=function(){var t=this,n=t.$createElement,i=t._self._c||n;return i("v-uni-view",{staticClass:"ok_main"},[i("uni-section",{attrs:{title:"任务列表",type:"line"}}),i("uni-list",t._l(t.taskList,(function(n,e){return i("uni-list-item",{key:e,attrs:{title:n.taskTitle,rightText:t.$ok.v.getTaskStatus(n.taskStatus)},on:{click:function(i){arguments[0]=i=t.$handleEvent(i),t.view(n)}}})})),1)],1)},a=[];i.d(n,"b",(function(){return u})),i.d(n,"c",(function(){return a})),i.d(n,"a",(function(){return e}))},b67d:function(t,n,i){"use strict";i.r(n);var e=i("97c5"),u=i("0be8");for(var a in u)"default"!==a&&function(t){i.d(n,t,(function(){return u[t]}))}(a);var s,r=i("f0c5"),o=Object(r["a"])(u["default"],e["b"],e["c"],!1,null,"5ae66759",null,!1,e["a"],s);n["default"]=o.exports},f417:function(t,n,i){"use strict";Object.defineProperty(n,"__esModule",{value:!0}),n.default=void 0;var e={data:function(){return{taskList:[]}},onShow:function(){this.loadData()},methods:{view:function(t){uni.navigateTo({url:"view?uuid="+t.taskUuid})},loadData:function(){var t=this;this.$api.task.task_receiver_list(this.$ok.url.getPra("status")).then((function(n){t.taskList=n.result.list})).catch((function(t){console.info(t)}))}}};n.default=e}}]);