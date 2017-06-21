({

doInit : function(component, event, helper) {
		helper.getLocations(component);
		helper.getHouseTypes(component);


	},

    filtersChange: function(component,event,helper)
    	{


     var changeEvent = component.getEvent("onchange");
                            changeEvent.setParams({
                                    "houseTypeFilterKey": component.get("v.selectedValueType"),
                                    "cityFilterKey":component.get("v.selectedValue"),
                                    "bedFilterKey":component.get("v.selectedValueBed"),
                                    "bathFilterKey":component.get("v.selectedValueBath"),
                                    "minValue":component.get("v.selectedValueMinVal"),
                                    "maxValue":component.get("v.selectedValueMaxVal")
                                });


                                changeEvent.fire();
    	}


})