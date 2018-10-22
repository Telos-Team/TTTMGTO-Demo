codeunit 67500 TTTMGTOWSManagement
{
    Description = 'TTT Magento Web Service Management';

    trigger OnRun()
    begin
    end;

    procedure DeleteCompany(Name: Text): Text
    begin
        DeleteCompanyInternal(Name);
    end;

    procedure CreateCompany(Name: Text): Text
    begin
        CreateCompanyInternal(Name);
    end;

    local procedure DeleteCompanyInternal(partxtName: Text): Text
    var
        loccuSafeCompMgt: Codeunit TTTMGTOSafeCompanyMgt;
    begin
        loccuSafeCompMgt.SetSafeAction('DELETECOMPANY');
        loccuSafeCompMgt.SetCompanyName(partxtName);
        if not loccuSafeCompMgt.Run() then
            exit(GetLastErrorText());
        exit(partxtName);
    end;

    local procedure CreateCompanyInternal(partxtName: Text): Text
    var
        loccuSafeCompMgt: Codeunit TTTMGTOSafeCompanyMgt;
    begin
        loccuSafeCompMgt.SetSafeAction('CREATECOMPANY');
        loccuSafeCompMgt.SetCompanyName(partxtName);
        if not loccuSafeCompMgt.Run() then
            exit(GetLastErrorText());
        exit(partxtName);
    end;
}