({
doInit : function(component, event, helper) {
		helper.getLocations(component);
		helper.getHouseTypes(component);
	},

	cityFilterChange : function(component, event, helper) {

                     var changeEvent = component.getEvent("onchange");
                            changeEvent.setParams({
                                "cityFilterKey": component.get("v.selectedValue")
                            });
                            changeEvent.fire();

	},
	houseTypeFilterChange: function(component,event,helper)
	{
console.log("t1");
 var changeEvent = component.getEvent("onchangeType");
                            changeEvent.setParams({
                                "houseTypeFilterKey": component.get("v.selectedValueType")
                            });
                                    console.log(component.get("v.selectedValueType"));

                            changeEvent.fire();
	}
})