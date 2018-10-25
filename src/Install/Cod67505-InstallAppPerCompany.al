codeunit 67505 TTTMGTOInstallAppPerCompany
{
    Description = 'TTT Magento Install per Company';
    Subtype = Install;

    trigger OnInstallAppPerCompany()
    begin
        if cuModuleInfoWrapper.IsFreshInstall() then
            HandleFreshInstall()
        else
            HandleReInstall();
    end;

    local procedure HandleFreshInstall()
    begin
    end;

    local procedure HandleReInstall()
    begin
    end;

    var
        cuModuleInfoWrapper: Codeunit TTTMGTOModuleInfoWrapper;
}