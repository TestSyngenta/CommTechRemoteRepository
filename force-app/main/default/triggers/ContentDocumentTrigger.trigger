trigger ContentDocumentTrigger on ContentDocument(before delete)
{
    if(Trigger.isDelete) System.debug('UAC: ContentDocumentTrigger Delete ') ;
    List<ContentDocument> documents = Trigger.isDelete ? Trigger.old : Trigger.new ;

    ContentDocumentTriggerHandler.updateFileCount(documents);
}