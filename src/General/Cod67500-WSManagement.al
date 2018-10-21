codeunit 67500 TTTMGTOWSManagement
{
    Description = 'TTT Magento Web Service Management';

    trigger OnRun()
    begin
    end;

    procedure DeleteCompany(Name: Text; Token: Text): Text
    begin
    end;

    procedure CreateCompany(Name: Text): Text
    begin
    end;

    local procedure DeleteCompanyInternal(partxtName: Text; partxtToken: Text): Text
    var
        myInt: Integer;
    begin

    end;

    local procedure CreateCompanyInternal(partxtName: Text): Text
    var
        myInt: Integer;
    begin

    end;

    var
        myInt: Integer;
}