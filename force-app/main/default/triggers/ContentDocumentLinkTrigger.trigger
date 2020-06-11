trigger ContentDocumentLinkTrigger on ContentDocumentLink(after insert, after update, after delete )
{
    if(Trigger.isInsert) System.debug('UAC: ContentDocumentLink Insert ') ;
    if(Trigger.isUpdate) System.debug('UAC: ContentDocumentLink Update ') ;
    if(Trigger.isDelete) System.debug('UAC: ContentDocumentLink Delete ') ;

    List<ContentDocumentLink> links = Trigger.isDelete ? Trigger.old : Trigger.new ;
    ContentDocumentLinkTriggerHandler.updateCount(links);
}