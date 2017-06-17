({
doInit : function(component, event, helper) {
		helper.getLocations(component);
	},
	cityFilterChange : function(component, event, helper) {

                     var changeEvent = component.getEvent("onchange");
                            changeEvent.setParams({
                                "cityFilterKey": component.get("v.selectedValue")
                            });
                            changeEvent.fire();

	}
})