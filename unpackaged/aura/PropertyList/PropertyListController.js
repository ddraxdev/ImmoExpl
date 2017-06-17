({
	doInit : function(component, event, helper) {
		helper.getProperties(component);
	},
	searchKeyChange : function(component, event, helper){
        helper.findByName(component,event);
    },
    	cityFilterChange: function(component, event, helper) {

                helper.findByCity(component,event);
            }

})