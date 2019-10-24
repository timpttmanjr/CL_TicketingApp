Public Class Reports
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    'Protected Sub ExportButton_Click(sender As Object, e As EventArgs) Handles ExportButton.Click
    '    Dim s As New StringBuilder

    '    Dim batchnumber As String = NewBatch()

    '    Dim iif As String = NewIIF(batchnumber)


    '    'todo:get a string of stuff
    '    s.Append("QuickBooks file will go here...")


    '    Me.Response.Clear()
    '    Response.ContentType = "text/plain"
    '    Me.Response.AddHeader("Content-disposition", "attachment; filename=QBExport_" & Format(Now, "yyyymmddhhmmss") & ".iif")
    '    Response.Write(s.ToString)
    '    Response.End()
    'End Sub

    'Private Function NewIIF(batchnumber As String) As String
    '    Dim sb As New StringBuilder


    '    Return sb.ToString

    'End Function



    'Public Class OrdersToIIF




    'ACCNT	Accounts Receivable	AR		1200																											
    'ACCNT	Construction:Labor	INC		4100																											
    'ACCNT	Construction:Materials	INC		4200																											
    'ACCNT	Inventory Asset	OCASSET		1120	INVENTORYASSET																										
    'ACCNT	Cost of Goods Sold	COGS	Cost of Goods Sold	5000	COGS																										
    '!INVITEM	NAME	INVITEMTYPE	DESC	PURCHASEDESC	ACCNT	ASSETACCNT	COGSACCNT	PRICE	COST	TAXABLE	PAYMETH	TAXVEND	TAXDIST	PREFVEND	REORDERPOINT	EXTRA															
    'INVITEM	Framing	SERV	Framing labor		Construction:Labor			55	0	N																					
    'INVITEM	Wood Door:Exterior	INVENTORY	Exterior wood door	Exterior door - #P-10981	Construction:Materials	Inventory Asset	Cost of Goods Sold	120	105	Y				Perry Windows & Doors	5																
    'INVITEM	Hardware:Doorknobs Std	INVENTORY	Standard Doorknobs	Doorknobs Part # DK 3704	Construction:Materials	Inventory Asset	Cost of Goods Sold	30	27	Y				Patton Hardware Supplies	50																
    '!CLASS	NAME																														
    'CLASS	class																														
    '!CUST	NAME	BADDR1	BADDR2	BADDR3	BADDR4	BADDR5	SADDR1	SADDR2	SADDR3	SADDR4	SADDR5	PHONE1	PHONE2	FAXNUM	EMAIL	NOTE	CONT1	CONT2	CTYPE	TERMS	TAXABLE	LIMIT	RESALENUM	REP	TAXITEM	NOTEPAD	SALUTATION	COMPANYNAME	FIRSTNAME	MIDINIT	LASTNAME
    'CUST	Customer	Joe Customer	444 Road Rd	"Anywhere, AZ 85740"	USA							5554443333					Joe Customer				N								Joe		Customer
    '!VEND	NAME	PRINTAS	ADDR1	ADDR2	ADDR3	ADDR4	ADDR5	VTYPE	CONT1	CONT2	PHONE1	PHONE2	FAXNUM	EMAIL	NOTE	TAXID	LIMIT	TERMS	NOTEPAD	SALUTATION	COMPANYNAME	FIRSTNAME	MIDINIT	LASTNAME							
    'VEND	Vendor		Jon Vendor	555 Street St	"Anywhere, AZ 85730"	USA			Jon Vendor		5555555555											Jon		Vendor							
    '!TRNS	TRNSID	TRNSTYPE	DATE	ACCNT	NAME	CLASS	AMOUNT	DOCNUM	MEMO	CLEAR	TOPRINT	NAMEISTAXABLE	ADDR1	ADDR3	TERMS	SHIPVIA	SHIPDATE
    '!SPL	SPLID	TRNSTYPE	DATE	ACCNT	NAME	CLASS	AMOUNT	DOCNUM	MEMO	CLEAR	QNTY	PRICE	INVITEM	TAXABLE	OTHER2	YEARTODATE	WAGEBASE
    '!ENDTRNS																	
    'TRNS		INVOICE	7/18/98	Accounts Receivable	Customer		205	1		N	Y	N					7/16/98
    'SPL		INVOICE	7/16/98	Construction:Labor			-55		Framing labor	N		55	Framing	N		0	0
    'SPL		INVOICE	7/16/98	Construction:Materials			-120		Exterior wood door	N		120	Wood Door:Exterior	Y		0	0
    'SPL		INVOICE	7/16/98	Construction:Materials			-30		Standard Doorknobs	N		30	Hardware:Doorknobs Std	Y		0	0
    'ENDTRNS


End Class