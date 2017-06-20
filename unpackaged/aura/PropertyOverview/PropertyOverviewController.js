({
	doInit : function(component, event, helper) {
		helper.getProperties(component);
	},
	searchKeyChange : function(component, event, helper){
        helper.findByName(component,event);
    },
    	cityFilterChange: function(component, event, helper) {

                helper.findByCity(component,event);
            },
        houseTypeFilterChange: function(component,event,helper)
        {
                helper.findByHouseType(component,event);
        },
        filtersChange:function(component,event,helper)
        {
                helper.findByFilters(component,event);
        },
openModel: function(component, event, helper) {
      // for Display Model,set the "isOpen" attribute to "true"
      component.set("v.isOpen", true);
   },

   closeModel: function(component, event, helper) {
      // for Hide/Close Model,set the "isOpen" attribute to "Fasle"
      component.set("v.isOpen", false);
   },



})