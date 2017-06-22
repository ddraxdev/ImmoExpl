({
	doInit : function(component, event, helper) {
		helper.getProperties(component);
	},
	searchKeyChange : function(component, event, helper){
        helper.findByName(component,event);
    },

        filtersChange:function(component,event,helper)
        {
                helper.findByFilters(component,event);

        },
openModel: function(component, event, helper) {
      // for Display Model,set the "isOpen" attribute to "true"
      component.set("v.isOpen", true);
      helper.findDetailsById(component,event);

   },

   closeModel: function(component, event, helper) {
      // for Hide/Close Model,set the "isOpen" attribute to "False"
      component.set("v.isOpen", false);
   },



})