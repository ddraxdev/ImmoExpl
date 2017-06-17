({
	getLocations: function(component, event, helper) {
        		var action = component.get("c.getLocations");
        		action.setCallback(this,function(response)
        		{
        		    var state = response.getState();
        		    if(component.isValid() && state === "SUCCESS")
        		    {
        		        component.set("v.locations",response.getReturnValue());
        		    }
        		});
        		$A.enqueueAction(action);
        	},
        		getHouseTypes: function(component, event, helper) {
                    		var action = component.get("c.getHouseTypes");
                    		action.setCallback(this,function(response)
                    		{
                    		    var state = response.getState();
                    		    if(component.isValid() && state === "SUCCESS")
                    		    {
                    		        component.set("v.houseTypes",response.getReturnValue());
                    		    }
                    		});
                    		$A.enqueueAction(action);
                    	}

})