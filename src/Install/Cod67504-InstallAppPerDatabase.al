codeunit 67504 TTTMGTOInstallAppPerDatabase
{
    Description = 'TTT Magento Install per Database';
    Subtype = Install;

    trigger OnInstallAppPerDatabase()
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