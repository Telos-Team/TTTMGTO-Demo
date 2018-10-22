codeunit 67502 TTTMGTOSafeCompanyMgt
{
    Description = 'TTT Magento Safe Company Management';

    trigger OnRun()
    begin
        Code();
    end;

    local procedure Code()
    begin
        Case UpperCase(txtSafeAction) of
            'DELETECOMPANY':
                begin
                    DeleteCompany(txtCompanyName);
                end;
            'CREATECOMPANY':
                begin
                    CreateCompany(txtCompanyName);
                end;
            else
                Error(textUnknownActionErr);
        end;
    end;

    procedure SetSafeAction(partxtSafeAction: Text)
    begin
        txtSafeAction := partxtSafeAction;
    end;

    procedure SetCompanyName(partxtName: Text)
    begin
        txtCompanyName := partxtName;
    end;

    local procedure DeleteCompany(partxtName: Text)
    var
        locrecComp: Record Company;
    begin
        if StrPos(UpperCase(partxtName), 'CRONUS') > 0 then
            Error(textUnknownCompanyErr, partxtName);
        if not locrecComp.Get(partxtName) then
            Error(textUnknownCompanyErr, partxtName);
        if UpperCase(partxtName) = UpperCase(CompanyName()) then
            error(textSameCompanyErr, partxtName);
        locrecComp.Delete(true);
    end;

    local procedure CreateCompany(partxtName: Text)
    var
        locrecComp: Record Company;
        locbooOK: Boolean;
    begin
        if partxtName = '' then
            error(textMissingNameErr);
        if StrPos(UpperCase(partxtName), 'CRONUS') > 0 then
            Error(textCronusNotAllowedErr, partxtName);
        if locrecComp.Get(partxtName) then
            Error(textAlreadeyExistsErr, partxtName);
        locbooOK := CopyCompany('CRONUS Danmark A/S', partxtName);
        if not locbooOK then
            error(GetLastErrorText());
    end;

    var
        txtCompanyName: Text;
        txtSafeAction: Text;
        textUnknownCompanyErr: Label 'Unknown company: %1';
        textSameCompanyErr: Label 'You can not delete the active company %1. Call this function from another company.';
        textUnknownActionErr: Label 'Unknown action: %1';
        textMissingNameErr: Label 'Missing Name!';
        textCronusNotAllowedErr: Label 'CRONUS not allowed in Name: %1';
        textAlreadeyExistsErr: Label 'Company %1 already exists!';
}