(window["webpackJsonp"]=window["webpackJsonp"]||[]).push([["pages-party-management-branch-view"],{"02c0":function(t,i,n){"use strict";var a=n("e72f"),e=n.n(a);e.a},"0b3e":function(t,i,n){"use strict";n.r(i);var a=n("c87b"),e=n("8ebd");for(var o in e)"default"!==o&&function(t){n.d(i,t,(function(){return e[t]}))}(o);n("a7ad");var r,s=n("f0c5"),c=Object(s["a"])(e["default"],a["b"],a["c"],!1,null,"71cf0d6f",null,!1,a["a"],r);i["default"]=c.exports},"15dd":function(t,i,n){"use strict";n.r(i);var a=n("b7e2"),e=n("2fdd");for(var o in e)"default"!==o&&function(t){n.d(i,t,(function(){return e[t]}))}(o);var r,s=n("f0c5"),c=Object(s["a"])(e["default"],a["b"],a["c"],!1,null,"028420d0",null,!1,a["a"],r);i["default"]=c.exports},"2fdd":function(t,i,n){"use strict";n.r(i);var a=n("9732"),e=n.n(a);for(var o in a)"default"!==o&&function(t){n.d(i,t,(function(){return a[t]}))}(o);i["default"]=e.a},"3efe":function(t,i,n){"use strict";var a=n("ee27");Object.defineProperty(i,"__esModule",{value:!0}),i.default=void 0;var e=a(n("0b3e")),o={name:"UniPopup",components:{uniTransition:e.default},props:{animation:{type:Boolean,default:!0},type:{type:String,default:"center"},maskClick:{type:Boolean,default:!0}},data:function(){return{duration:300,ani:[],showPopup:!1,showTrans:!1,maskClass:{position:"fixed",bottom:0,top:0,left:0,right:0,backgroundColor:"rgba(0, 0, 0, 0.4)"},transClass:{position:"fixed",left:0,right:0}}},watch:{type:{handler:function(t){switch(this.type){case"top":this.ani=["slide-top"],this.transClass={position:"fixed",left:0,right:0};break;case"bottom":this.ani=["slide-bottom"],this.transClass={position:"fixed",left:0,right:0,bottom:0};break;case"center":this.ani=["zoom-out","fade"],this.transClass={position:"fixed",display:"flex",flexDirection:"column",bottom:0,left:0,right:0,top:0,justifyContent:"center",alignItems:"center"};break}},immediate:!0}},created:function(){this.animation?this.duration=300:this.duration=0},methods:{clear:function(t){t.stopPropagation()},open:function(){var t=this;this.showPopup=!0,this.$nextTick((function(){clearTimeout(t.timer),t.timer=setTimeout((function(){t.showTrans=!0}),50)})),this.$emit("change",{show:!0})},close:function(t){var i=this;this.showTrans=!1,this.$nextTick((function(){clearTimeout(i.timer),i.timer=setTimeout((function(){i.$emit("change",{show:!1}),i.showPopup=!1}),300)}))},onTap:function(){this.maskClick&&this.close()}}};i.default=o},"8ebd":function(t,i,n){"use strict";n.r(i);var a=n("f4b7"),e=n.n(a);for(var o in a)"default"!==o&&function(t){n.d(i,t,(function(){return a[t]}))}(o);i["default"]=e.a},9732:function(t,i,n){"use strict";var a=n("ee27");Object.defineProperty(i,"__esModule",{value:!0}),i.default=void 0;var e=a(n("fc11")),o={data:function(){return{editId:0,editType:"",editValue:"",branch:{},memberList:[],leaderList:[]}},onShow:function(){this.getInfo()},methods:{getInfo:function(){var t=this;this.$api.party.party_admin_branch_info(this.$ok.url.getPra("id")).then((function(i){t.branch=i.result,t.$api.party.party_admin_branch_leader(t.$ok.url.getPra("id")).then((function(i){t.leaderList=i.result})),t.$api.party.party_admin_branch_user_list(t.$ok.url.getPra("id")).then((function(i){t.memberList=i.result}))}))},branchUser:function(t){var i=this;uni.showActionSheet({itemList:this.$ok.v.party_post,success:function(n){var a=n.tapIndex,e=i.$ok.v.party_post[a];"书记"===e?i.$api.party.party_admin_branch_edit_secretary(t.partyUserId).then((function(t){i.getInfo()})):"联系人"===e?i.$api.party.party_admin_branch_edit_contact(t.partyUserId).then((function(t){i.getInfo()})):"普通党员"===e?i.$api.party.party_admin_user_edit_post_none(t.partyUserId).then((function(t){i.getInfo()})):(i.editId=t.partyUserId,i.editType="partyPost",i.editValue=e,i.editPartyInfo())}})},togglePopup:function(t){var i=this;this.editType=t,this.$nextTick((function(){i.$refs["editBox"].open()}))},editInfoValue:function(t){this.editValue=t.detail.value},editInfo:function(){var t=this,i=(0,e.default)({branchId:this.branch.branchId},this.editType,this.editValue);this.$api.party.party_admin_branch_edit_info(i).then((function(i){t.getInfo(),t.$refs["editBox"].close(),t.editType=""}))},editPartyInfo:function(){var t=this,i=(0,e.default)({partyUserId:this.editId},this.editType,this.editValue);this.$api.party.party_admin_user_edit_info(i).then((function(i){t.getInfo()}))},editActionSheet:function(t,i){var n=this;uni.showActionSheet({itemList:i,success:function(a){n.editType=t,n.branch[t]=i[a.tapIndex],n.editValue=i[a.tapIndex],n.editInfo()}})}}};i.default=o},a7ad:function(t,i,n){"use strict";var a=n("ef82"),e=n.n(a);e.a},b7e2:function(t,i,n){"use strict";var a={"uni-section":n("9ff0").default,"uni-list":n("b370").default,"uni-list-item":n("897a").default,"uni-popup":n("fd74").default},e=function(){var t=this,i=t.$createElement,n=t._self._c||i;return n("v-uni-view",{staticClass:"ok_main"},[n("v-uni-view",{staticClass:"ok-form-view",staticStyle:{"margin-top":"20px"}},[n("v-uni-view",{staticClass:"uni-flex uni-row",on:{click:function(i){arguments[0]=i=t.$handleEvent(i),t.togglePopup("branchName")}}},[n("v-uni-view",{staticClass:"ok-form-view-left"},[t._v("党支部")]),n("v-uni-view",{staticClass:"ok-form-view-right"},[t._v(t._s(t.branch.branchName))])],1)],1),n("v-uni-view",{staticClass:"ok-form-view"},[n("v-uni-view",{staticClass:"uni-flex uni-row",on:{click:function(i){arguments[0]=i=t.$handleEvent(i),t.editActionSheet("branchType",t.$ok.v.party_branch_type)}}},[n("v-uni-view",{staticClass:"ok-form-view-left"},[t._v("组织类别")]),n("v-uni-view",{staticClass:"ok-form-view-right"},[t._v(t._s(t.branch.branchType))])],1)],1),n("v-uni-view",{staticClass:"ok-form-view"},[n("v-uni-view",{staticClass:"uni-flex uni-row",on:{click:function(i){arguments[0]=i=t.$handleEvent(i),t.togglePopup("branchCode")}}},[n("v-uni-view",{staticClass:"ok-form-view-left"},[t._v("党组织代码")]),n("v-uni-view",{staticClass:"ok-form-view-right"},[t._v(t._s(t.branch.branchCode))])],1)],1),n("v-uni-view",{staticClass:"ok-form-view"},[n("v-uni-view",{staticClass:"uni-flex uni-row",on:{click:function(i){arguments[0]=i=t.$handleEvent(i),t.editActionSheet("branchUnit",t.$ok.v.party_branch_unit)}}},[n("v-uni-view",{staticClass:"ok-form-view-left"},[t._v("党组织所在单位")]),n("v-uni-view",{staticClass:"ok-form-view-right"},[t._v(t._s(t.branch.branchUnit))])],1)],1),n("v-uni-view",{staticClass:"ok-form-view"},[n("v-uni-view",{staticClass:"uni-flex uni-row",on:{click:function(i){arguments[0]=i=t.$handleEvent(i),t.editActionSheet("branchStatus",t.$ok.v.party_branch_status)}}},[n("v-uni-view",{staticClass:"ok-form-view-left"},[t._v("党组织所状态")]),n("v-uni-view",{staticClass:"ok-form-view-right"},[t._v(t._s(t.branch.branchStatus))])],1)],1),n("v-uni-view",{staticClass:"line-10"}),n("v-uni-view",{staticClass:"ok-form-view"},[n("v-uni-view",{staticClass:"uni-flex uni-row"},[n("v-uni-view",{staticClass:"ok-form-view-left"},[t._v("单位名称")]),n("v-uni-view",{staticClass:"ok-form-view-right"},[t._v(t._s(t.branch.branchCompany))])],1)],1),n("v-uni-view",{staticClass:"ok-form-view"},[n("v-uni-view",{staticClass:"uni-flex uni-row"},[n("v-uni-view",{staticClass:"ok-form-view-left"},[t._v("单位代码")]),n("v-uni-view",{staticClass:"ok-form-view-right"},[t._v(t._s(t.branch.branchCompanyCode))])],1)],1),n("v-uni-view",{staticClass:"ok-form-view"},[n("v-uni-view",{staticClass:"uni-flex uni-row"},[n("v-uni-view",{staticClass:"ok-form-view-left"},[t._v("单位类型")]),n("v-uni-view",{staticClass:"ok-form-view-right"},[t._v(t._s(t.branch.branchCompanyType))])],1)],1),n("v-uni-view",{staticClass:"ok-form-view"},[n("v-uni-view",{staticClass:"uni-flex uni-row"},[n("v-uni-view",{staticClass:"ok-form-view-left"},[t._v("党组织情况")]),n("v-uni-view",{staticClass:"ok-form-view-right"},[t._v(t._s(t.branch.branchCompanyParty))])],1)],1),n("v-uni-view",{staticClass:"line-10"}),n("v-uni-view",{staticClass:"ok-form-view"},[n("v-uni-view",{staticClass:"uni-flex uni-row",on:{click:function(i){arguments[0]=i=t.$handleEvent(i),t.togglePopup("branchSecretary")}}},[n("v-uni-view",{staticClass:"ok-form-view-left"},[t._v("党组织书记")]),n("v-uni-view",{staticClass:"ok-form-view-right"},[t._v(t._s(t.branch.branchSecretary))])],1)],1),n("v-uni-view",{staticClass:"ok-form-view"},[n("v-uni-view",{staticClass:"uni-flex uni-row",on:{click:function(i){arguments[0]=i=t.$handleEvent(i),t.togglePopup("branchContact")}}},[n("v-uni-view",{staticClass:"ok-form-view-left"},[t._v("联系人")]),n("v-uni-view",{staticClass:"ok-form-view-right"},[t._v(t._s(t.branch.branchContact))])],1)],1),n("v-uni-view",{staticClass:"ok-form-view"},[n("v-uni-view",{staticClass:"uni-flex uni-row",on:{click:function(i){arguments[0]=i=t.$handleEvent(i),t.togglePopup("branchPhone")}}},[n("v-uni-view",{staticClass:"ok-form-view-left"},[t._v("联系电话")]),n("v-uni-view",{staticClass:"ok-form-view-right"},[t._v(t._s(t.branch.branchPhone))])],1)],1),n("uni-section",{attrs:{title:"委员",type:"line"}}),n("uni-list",t._l(t.leaderList,(function(i,a){return n("uni-list-item",{key:a,attrs:{title:i.idName,rightText:i.partyPost},on:{click:function(n){arguments[0]=n=t.$handleEvent(n),t.branchUser(i)}}})})),1),n("uni-section",{attrs:{title:"党员",type:"line"}}),n("uni-list",t._l(t.memberList,(function(i,a){return n("uni-list-item",{key:a,attrs:{title:i.idName,rightText:i.partyPost},on:{click:function(n){arguments[0]=n=t.$handleEvent(n),t.branchUser(i)}}})})),1),n("uni-popup",{ref:"editBox",attrs:{type:"bottom"}},[n("v-uni-view",{staticClass:"uni-tip"},[n("v-uni-text",{staticClass:"uni-tip-title"},[t._v("修改信息")]),n("v-uni-input",{staticClass:"ok-input1",attrs:{focus:!0,value:t.branch[this.editType]},on:{blur:function(i){arguments[0]=i=t.$handleEvent(i),t.editInfoValue.apply(void 0,arguments)}}}),n("v-uni-view",{staticClass:"uni-tip-group-button"},[n("v-uni-text",{staticClass:"uni-tip-button",on:{click:function(i){arguments[0]=i=t.$handleEvent(i),t.$refs["editBox"].close()}}},[t._v("取消")]),n("v-uni-text",{staticClass:"uni-tip-button",on:{click:function(i){arguments[0]=i=t.$handleEvent(i),t.editInfo()}}},[t._v("确定")])],1)],1)],1)],1)},o=[];n.d(i,"b",(function(){return e})),n.d(i,"c",(function(){return o})),n.d(i,"a",(function(){return a}))},c4de:function(t,i,n){var a=n("24fb");i=a(!1),i.push([t.i,".uni-transition[data-v-71cf0d6f]{-webkit-transition-timing-function:ease;transition-timing-function:ease;-webkit-transition-duration:.3s;transition-duration:.3s;-webkit-transition-property:opacity,-webkit-transform;transition-property:opacity,-webkit-transform;transition-property:transform,opacity;transition-property:transform,opacity,-webkit-transform}.fade-in[data-v-71cf0d6f]{opacity:0}.fade-active[data-v-71cf0d6f]{opacity:1}.slide-top-in[data-v-71cf0d6f]{\n\t/* transition-property: transform, opacity; */-webkit-transform:translateY(-100%);transform:translateY(-100%)}.slide-top-active[data-v-71cf0d6f]{-webkit-transform:translateY(0);transform:translateY(0)\n\t/* opacity: 1; */}.slide-right-in[data-v-71cf0d6f]{-webkit-transform:translateX(100%);transform:translateX(100%)}.slide-right-active[data-v-71cf0d6f]{-webkit-transform:translateX(0);transform:translateX(0)}.slide-bottom-in[data-v-71cf0d6f]{-webkit-transform:translateY(100%);transform:translateY(100%)}.slide-bottom-active[data-v-71cf0d6f]{-webkit-transform:translateY(0);transform:translateY(0)}.slide-left-in[data-v-71cf0d6f]{-webkit-transform:translateX(-100%);transform:translateX(-100%)}.slide-left-active[data-v-71cf0d6f]{-webkit-transform:translateX(0);transform:translateX(0);opacity:1}.zoom-in-in[data-v-71cf0d6f]{-webkit-transform:scale(.8);transform:scale(.8)}.zoom-out-active[data-v-71cf0d6f]{-webkit-transform:scale(1);transform:scale(1)}.zoom-out-in[data-v-71cf0d6f]{-webkit-transform:scale(1.2);transform:scale(1.2)}",""]),t.exports=i},c87b:function(t,i,n){"use strict";var a,e=function(){var t=this,i=t.$createElement,n=t._self._c||i;return t.isShow?n("v-uni-view",{ref:"ani",staticClass:"uni-transition",class:[t.ani.in],style:"transform:"+t.transform+";"+t.stylesObject,on:{click:function(i){arguments[0]=i=t.$handleEvent(i),t.change.apply(void 0,arguments)}}},[t._t("default")],2):t._e()},o=[];n.d(i,"b",(function(){return e})),n.d(i,"c",(function(){return o})),n.d(i,"a",(function(){return a}))},ca11:function(t,i,n){"use strict";n.r(i);var a=n("3efe"),e=n.n(a);for(var o in a)"default"!==o&&function(t){n.d(i,t,(function(){return a[t]}))}(o);i["default"]=e.a},cddc:function(t,i,n){var a=n("24fb");i=a(!1),i.push([t.i,".uni-popup[data-v-73ab000a]{position:fixed;\n\t\ttop:var(--window-top);\n\t\t\n\t\tbottom:0;left:0;right:0;\n\t\tz-index:99\n\t\t}.uni-popup__mask[data-v-73ab000a]{position:absolute;top:0;bottom:0;left:0;right:0;background-color:rgba(0,0,0,.4);opacity:0}.mask-ani[data-v-73ab000a]{-webkit-transition-property:opacity;transition-property:opacity;-webkit-transition-duration:.2s;transition-duration:.2s}.uni-top-mask[data-v-73ab000a]{opacity:1}.uni-bottom-mask[data-v-73ab000a]{opacity:1}.uni-center-mask[data-v-73ab000a]{opacity:1}.uni-popup__wrapper[data-v-73ab000a]{\n\t\tdisplay:block;\n\t\tposition:absolute}.top[data-v-73ab000a]{top:0;left:0;right:0;-webkit-transform:translateY(-500px);transform:translateY(-500px)}.bottom[data-v-73ab000a]{bottom:0;left:0;right:0;-webkit-transform:translateY(500px);transform:translateY(500px)}.center[data-v-73ab000a]{\n\t\tdisplay:-webkit-box;display:-webkit-flex;display:flex;-webkit-box-orient:vertical;-webkit-box-direction:normal;-webkit-flex-direction:column;flex-direction:column;\n\t\tbottom:0;left:0;right:0;top:0;-webkit-box-pack:center;-webkit-justify-content:center;justify-content:center;-webkit-box-align:center;-webkit-align-items:center;align-items:center;-webkit-transform:scale(1.2);transform:scale(1.2);opacity:0}.uni-popup__wrapper-box[data-v-73ab000a]{\n\t\tdisplay:block;\n\t\tposition:relative}.content-ani[data-v-73ab000a]{\n\t\t/* transition: transform 0.3s;\n */-webkit-transition-property:opacity,-webkit-transform;transition-property:opacity,-webkit-transform;transition-property:transform,opacity;transition-property:transform,opacity,-webkit-transform;-webkit-transition-duration:.2s;transition-duration:.2s}.uni-top-content[data-v-73ab000a]{-webkit-transform:translateY(0);transform:translateY(0)}.uni-bottom-content[data-v-73ab000a]{-webkit-transform:translateY(0);transform:translateY(0)}.uni-center-content[data-v-73ab000a]{-webkit-transform:scale(1);transform:scale(1);opacity:1}",""]),t.exports=i},e72f:function(t,i,n){var a=n("cddc");"string"===typeof a&&(a=[[t.i,a,""]]),a.locals&&(t.exports=a.locals);var e=n("4f06").default;e("7f7a25c3",a,!0,{sourceMap:!1,shadowMode:!1})},ec15:function(t,i,n){"use strict";var a={"uni-transition":n("0b3e").default},e=function(){var t=this,i=t.$createElement,n=t._self._c||i;return t.showPopup?n("v-uni-view",{staticClass:"uni-popup",on:{touchmove:function(i){i.stopPropagation(),i.preventDefault(),arguments[0]=i=t.$handleEvent(i),t.clear.apply(void 0,arguments)}}},[n("uni-transition",{attrs:{"mode-class":["fade"],styles:t.maskClass,duration:t.duration,show:t.showTrans},on:{click:function(i){arguments[0]=i=t.$handleEvent(i),t.onTap.apply(void 0,arguments)}}}),n("uni-transition",{attrs:{"mode-class":t.ani,styles:t.transClass,duration:t.duration,show:t.showTrans},on:{click:function(i){arguments[0]=i=t.$handleEvent(i),t.onTap.apply(void 0,arguments)}}},[n("v-uni-view",{staticClass:"uni-popup__wrapper-box",on:{click:function(i){i.stopPropagation(),arguments[0]=i=t.$handleEvent(i),t.clear.apply(void 0,arguments)}}},[t._t("default")],2)],1)],1):t._e()},o=[];n.d(i,"b",(function(){return e})),n.d(i,"c",(function(){return o})),n.d(i,"a",(function(){return a}))},ef82:function(t,i,n){var a=n("c4de");"string"===typeof a&&(a=[[t.i,a,""]]),a.locals&&(t.exports=a.locals);var e=n("4f06").default;e("5ae87c9f",a,!0,{sourceMap:!1,shadowMode:!1})},f4b7:function(t,i,n){"use strict";var a=n("ee27");n("4160"),n("a9e3"),n("ac1f"),n("5319"),n("159b"),Object.defineProperty(i,"__esModule",{value:!0}),i.default=void 0;var e=a(n("f3f3")),o={name:"uniTransition",props:{show:{type:Boolean,default:!1},modeClass:{type:Array,default:function(){return[]}},duration:{type:Number,default:300},styles:{type:Object,default:function(){return{}}}},data:function(){return{isShow:!1,transform:"",ani:{in:"",active:""}}},watch:{show:{handler:function(t){t?this.open():this.close()},immediate:!0}},computed:{stylesObject:function(){var t=(0,e.default)({},this.styles,{"transition-duration":this.duration/1e3+"s"}),i="";for(var n in t){var a=this.toLine(n);i+=a+":"+t[n]+";"}return i}},created:function(){},methods:{change:function(){this.$emit("click",{detail:this.isShow})},open:function(){var t=this;for(var i in clearTimeout(this.timer),this.isShow=!0,this.transform="",this.ani.in="",this.getTranfrom(!1))"opacity"===i?this.ani.in="fade-in":this.transform+="".concat(this.getTranfrom(!1)[i]," ");this.$nextTick((function(){setTimeout((function(){t._animation(!0)}),50)}))},close:function(t){clearTimeout(this.timer),this._animation(!1)},_animation:function(t){var i=this,n=this.getTranfrom(t);for(var a in this.transform="",n)"opacity"===a?this.ani.in="fade-".concat(t?"out":"in"):this.transform+="".concat(n[a]," ");this.timer=setTimeout((function(){t||(i.isShow=!1),i.$emit("change",{detail:i.isShow})}),this.duration)},getTranfrom:function(t){var i={transform:""};return this.modeClass.forEach((function(n){switch(n){case"fade":i.opacity=t?1:0;break;case"slide-top":i.transform+="translateY(".concat(t?"0":"-100%",") ");break;case"slide-right":i.transform+="translateX(".concat(t?"0":"100%",") ");break;case"slide-bottom":i.transform+="translateY(".concat(t?"0":"100%",") ");break;case"slide-left":i.transform+="translateX(".concat(t?"0":"-100%",") ");break;case"zoom-in":i.transform+="scale(".concat(t?1:.8,") ");break;case"zoom-out":i.transform+="scale(".concat(t?1:1.2,") ");break}})),i},_modeClassArr:function(t){var i=this.modeClass;if("string"!==typeof i){var n="";return i.forEach((function(i){n+=i+"-"+t+","})),n.substr(0,n.length-1)}return i+"-"+t},toLine:function(t){return t.replace(/([A-Z])/g,"-$1").toLowerCase()}}};i.default=o},fd74:function(t,i,n){"use strict";n.r(i);var a=n("ec15"),e=n("ca11");for(var o in e)"default"!==o&&function(t){n.d(i,t,(function(){return e[t]}))}(o);n("02c0");var r,s=n("f0c5"),c=Object(s["a"])(e["default"],a["b"],a["c"],!1,null,"73ab000a",null,!1,a["a"],r);i["default"]=c.exports}}]);