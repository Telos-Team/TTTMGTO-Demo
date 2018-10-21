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

                end;
            else
                Error('N/A');
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
    begin
    end;

    var
        txtCompanyName: Text;
        txtSafeAction: Text;
}