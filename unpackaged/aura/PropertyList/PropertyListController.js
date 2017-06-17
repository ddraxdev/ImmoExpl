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
        console.log("yesinhouse");
                helper.findByHouseType(component,event);
        }

})