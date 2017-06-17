/**
 * Created by DDRAX76 on 16/06/2017.
 */
public class PropertyListController {

	@AuraEnabled
	public static List<String> getLocations()
		{

			List<Property__c> locations = [SELECT City__c FROM Property__c];

			//AuraEnabled Methods returns no set collections.. Workaround:
			Set<String>cityAreas = new Set<String>();
			List<String> t = new List<String>();
			for (Property__c p : locations)
				{
					if (!cityAreas.contains(p.City__c))
					{
						cityAreas.add(p.City__c);
					}
				}

			t.addAll(cityAreas);


			return t;
		}

	@AuraEnabled
	public static List<Property__c> getProperties()
		{
			List<Property__c> propList = [SELECT Name,City__c FROM Property__c];
			return propList;
		}

	@AuraEnabled
	public static List<Property__c> findByName(String searchKey, Property__c[] propertyList) {
		Set<Id> recordIds = new Map<Id, Property__c>(getProperties()).keySet();
		system.debug('Properties LIST' + propertyList);
		String name = '%' + searchKey + '%';
		return [Select Id, Name,City__c from Property__c WHERE (Name LIKE :name OR City__c LIKE :name) AND Id IN:recordIds LIMIT 50];
	}

	@AuraEnabled
	public static List<Property__c> findByCity(String cityFilterKey, Property__C[] propertyList)
		{
			Set<Id> recordIds = new Map<Id, Property__c>(getProperties()).keySet();
			system.debug('Properties LIST' + propertyList);
			String name = '%' + cityFilterKey + '%';
			return [Select Id, Name,City__c from Property__c WHERE ( City__c LIKE :name) AND Id IN:recordIds LIMIT 50];
		}
}