/**
 * Created by DDRAX76 on 16/06/2017.
 */
public class PropertyListController {

	@AuraEnabled
	public static List<String> getHouseTypes() {
		Schema.DescribeFieldResult result = Property__c.Tags__c.getDescribe();
		List<Schema.PicklistEntry> entries = result.getPicklistValues();
		List<String> values = new list <String>();
		for (Schema.PicklistEntry entry: entries) {
			values.add(entry.getValue());
		}
		return values;
	}

	@AuraEnabled
	public static List<String> getLocations() {
		Schema.DescribeFieldResult result = Property__c.City__c.getDescribe();
		List<Schema.PicklistEntry> entries = result.getPicklistValues();
		List<String> values = new list <String>();
		for (Schema.PicklistEntry entry: entries) {
			values.add(entry.getValue());
		}
		return values;
	}

	/*@AuraEnabled
	public static List<String> getHouseTypes()
		{
			List<Property__c> types = [SELECT Tags__c FROM Property__c];
			//AuraEnabled Methods returns no set collections.. Workaround:
			Set<String>houseTypes = new Set<String>();
			List<String> t = new List<String>();
			for (Property__c p : types)
				{
					if (!houseTypes.contains(p.Tags__c))
					{
						houseTypes.add(p.Tags__c);
					}
				}

			t.addAll(houseTypes);


			return t;
		}
*/
	/*@AuraEnabled
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
		}*/

	@AuraEnabled
	public static List<Property__c> getProperties()
		{
			List<Property__c> propList = [SELECT Name,City__c,Tags__c,Price__c,Picture__c,Beds__c,Baths__c FROM Property__c];
			return propList;
		}

	@AuraEnabled
	public static List<Property__c> findByFilters(String searchKey, String cityFilterKey, String houseTypeFilterKey,Integer bedFilterKey, Integer bathFilterKey , Decimal minValue, Decimal maxValue,Property__c[] propertyList)
		{

			Set<Id> recordIds = new Map<Id, Property__c>(getProperties()).keySet();

			system.debug('Properties LIST' + propertyList);
			String searchInput = '%' + searchKey + '%';
			String cityFilterInput = '';
			String houseTypeFilterInput = '';
			cityFilterInput = '%' + cityFilterKey + '%';
			houseTypeFilterInput = '%' + houseTypeFilterKey + '%';
			//debug
			System.debug('bath'+bathFilterKey);
			System.debug('minvalue::'+minValue);
			System.debug('maxvalue::'+maxValue);

			String soql = 'SELECT Name,City__c,Tags__c,Price__c,Picture__c,Beds__c,Baths__c FROM Property__c WHERE (Name LIKE:searchInput OR City__c LIKE :cityFilterInput)';

			//Some checks before creating the dynamic SOQL query
			if(cityFilterInput != null && cityFilterInput != 'None')
				{
					soql += ' AND City__C LIKE :cityFilterInput';
				}

			if(houseTypeFilterInput != null && cityFilterInput != 'None')
				{
					soql += ' AND Tags__c LIKE :houseTypeFilterInput ';
				}
			if(bedFilterKey != null)
				{
					soql += ' AND Beds__c =: bedFilterKey';
				}
			if(bathFilterKey != null)
				{
					soql += ' AND Baths__c =: bathFilterKey';
				}
			if(minValue != null)
				{
					soql += ' AND Price__c >=: minValue';
				}
			if(maxValue != null)
				{
					soql += ' AND Price__c <=: maxValue';
				}

		System.debug(soql);
			List<Property__c>propsList = Database.query(soql);
			return propsList;
		}
	@AuraEnabled
	public static List<Property__c> findByName(String searchKey, Property__c[] propertyList) {
		Set<Id> recordIds = new Map<Id, Property__c>(getProperties()).keySet();
		system.debug('Properties LIST' + propertyList);
		String name = '%' + searchKey + '%';
		return [Select Id, Name,City__c,Tags__c,Price__c,Picture__c from Property__c WHERE (Name LIKE :name OR City__c LIKE :name) AND Id IN:recordIds LIMIT 50];
	}

	@AuraEnabled
	public static List<Property__c> findByCity(String cityFilterKey, Property__C[] propertyList)
		{
			Set<Id> recordIds = new Map<Id, Property__c>(getProperties()).keySet();
			system.debug('Properties LIST' + propertyList);
			String name = '%' + cityFilterKey + '%';
			return [Select Id, Name,City__c from Property__c WHERE ( City__c LIKE :name) AND Id IN:recordIds LIMIT 50];
		}

	@AuraEnabled
	public static List<Property__C> findByHouseType(String houseTypeFilterKey, Property__c[] propertyList )
		{

			Set<Id> recordIds = new Map<Id, Property__c>(getProperties()).keySet();
			system.debug('Properties LIST' + propertyList);
			String name = '%' + houseTypeFilterKey + '%';
			return [SELECT Name,City__c,Tags__c,Price__c,Picture__c,Beds__c,Baths__c from Property__c WHERE ( Tags__c LIKE :name) AND Id IN:recordIds LIMIT 50];
		}
}