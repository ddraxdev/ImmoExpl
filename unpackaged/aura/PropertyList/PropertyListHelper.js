({
	getProperties: function(component) {
         var action = component.get("c.getProperties");
         //Set up the callback
         action.setCallback(this, function(actionResult) {
                component.set("v.properties", actionResult.getReturnValue());
           });
            $A.enqueueAction(action);
        },
        findByName: function(component,event) {
                var searchKey = event.getParam("searchKey");
                var propertyList = component.get("v.properties");
                var action = component.get("c.findByName");
                action.setParams({
                  "searchKey": searchKey,
                  "propertyList" : propertyList
                });
                action.setCallback(this, function(a) {
                    component.set("v.properties", a.getReturnValue());
                });
                $A.enqueueAction(action);
            },
         findByCity: function(component,event) {
          var cityFilterKey = event.getParam("cityFilterKey");
                                    var propertyList = component.get("v.properties");
                                    var action = component.get("c.findByCity");

                                    action.setParams({
                                      "cityFilterKey": cityFilterKey,
                                      "propertyList" : propertyList
                                    });
                                    action.setCallback(this, function(response) {
                                        		    var state = response.getState();

                                     if(component.isValid() && state === "SUCCESS")
                                        {
                                        component.set("v.properties", response.getReturnValue());
                                        }
                                    });

                                    $A.enqueueAction(action);
                                }

})