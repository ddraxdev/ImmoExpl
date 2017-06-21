({
	getProperties: function(component) {
         var action = component.get("c.getProperties");
         //Set up the callback
         action.setCallback(this, function(actionResult) {
                component.set("v.properties", actionResult.getReturnValue());
           });
            $A.enqueueAction(action);
        },
        findDetailsById: function(component,event) {
                 var action = component.get("c.findDetailsById");
                 //Set up the callback
                 var tileID = event.currentTarget.dataset.houseid;
                // console.log(tileID);
                  action.setParams({
                                   "inputID": tileID
                                 });
                 action.setCallback(this, function(actionResult) {
                        component.set("v.details", actionResult.getReturnValue());
                       // console.log(actionResult.getReturnValue());
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

                                         findByFilters: function(component,event) {

                                                             var houseTypeFilterKey = event.getParam("houseTypeFilterKey");
                                                             var cityFilterKey = event.getParam("cityFilterKey");
//Set some defaults for bed & bath filters..

                                                             var bedFilterKey = event.getParam("bedFilterKey");
                                                             var bathFilterKey = event.getParam("bathFilterKey");
                                                             var minVal = event.getParam("minValue");
                                                             var maxVal = event.getParam("maxValue");
                                                             console.log(minVal);
                                                             var propertyList = component.get("v.properties");
                                                             var action = component.get("c.findByFilters");

                                                                                       action.setParams({
                                                                                         "houseTypeFilterKey": houseTypeFilterKey,
                                                                                         "cityFilterKey":cityFilterKey,
                                                                                         "bedFilterKey":bedFilterKey,
                                                                                         "bathFilterKey":bathFilterKey,
                                                                                         "minValue":minVal,
                                                                                         "maxValue":maxVal,
                                                                                         "propertyList" : propertyList
                                                                                       });
                                                                                       action.setCallback(this, function(response) {
                                                                                           		    var state = response.getState();

                                                                                        if(component.isValid() && state === "SUCCESS")
                                                                                           {
                                                                                           component.set("v.properties", response.getReturnValue());
                                                                                           console.log(response.getReturnValue());
                                                                                           }
                                                                                       });

                                                                                       $A.enqueueAction(action);
                                                                                   }

})