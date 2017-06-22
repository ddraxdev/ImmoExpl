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

	@AuraEnabled
	public static List<Property__c> getProperties()
		{
			List<Property__c> propList = [SELECT Id,Name,City__c,Tags__c,Price__c,Picture__c,Beds__c,Baths__c FROM Property__c];
			return propList;
		}

	@AuraEnabled
	public static List<Property__c>findDetailsById(Id inputID)
		{
			List<Property__c>details = [SELECT Id,Name,City__c,Tags__c,Status__c,Broker__r.Name,Broker__r.Email__c,Broker__r.Picture__c,Zip__c,Address__c,Price__c,Picture__c,Beds__c,Baths__c FROM Property__c Where Id=:inputID];
		//	System.debug('info' + details);
			return details;
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


			String soql = 'SELECT Name,City__c,Tags__c,Price__c,Picture__c,Beds__c,Baths__c FROM Property__c WHERE (Name LIKE:searchInput OR City__c LIKE :cityFilterInput)';

			//Some checks before creating the dynamic SOQL query
			if(cityFilterInput != null || cityFilterInput != 'None')
				{
					soql += ' AND City__C LIKE :cityFilterInput';
				}

			if(houseTypeFilterInput != null || cityFilterInput != 'None')
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

}