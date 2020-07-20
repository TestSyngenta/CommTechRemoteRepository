@isTest
public class CaseCommentConverterTest {
	
    public static Testmethod void commentMergeTest(){
        Account testAccount = new Account(Name='TestAccountSyngentaCaseComments1023910329213123234');
        insert testAccount;
        Case testCase = new Case(Subject='TestCase', AccountID=testAccount.id);
        insert testCase;
        
        CaseComment comment1 = new CaseComment(ParentId=testCase.id, CommentBody='Test Comment 1');
        insert comment1;
        CaseComment comment2 = new CaseComment(ParentId=testCase.id, CommentBody='Test Comment 2');
        insert comment2;

        comment1 = [Select Id, CommentBody, CreatedBy.Name, CreatedDate from CaseComment where Id=:comment1.Id];
        comment2 = [Select Id, CommentBody, CreatedBy.Name, CreatedDate from CaseComment where Id=:comment2.Id];
        String expectedText = '('+comment1.CreatedBy.Name+' '+comment1.CreatedDate+'): '+comment1.CommentBody+'\n'+
        					  '('+comment2.CreatedBy.Name+' '+comment2.CreatedDate+'): '+comment2.CommentBody;
        System.debug('Test: '+expectedText);

        //CaseCommentConverter.convertComments(new Id[]{testcase.Id});
        CaseCommentConverter.convertComments_all();
      
        testCase = [Select Id, Case_Comments__c from Case where Id = :testCase.Id];
        System.debug('Test: '+testCase.Case_Comments__c);
        
        //System.assertEquals(expectedText, testCase.Case_Comments__c);        

	}
}