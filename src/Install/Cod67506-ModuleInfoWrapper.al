codeunit 67506 TTTMGTOModuleInfoWrapper
{
    Description = 'TTT Magento Module Info Wrapper';

    var
        miApp: ModuleInfo;
        booModuleInfoLoaded: Boolean;

    procedure GetId(): Guid
    begin
        LoadModuleInfo();
        exit(miApp.Id());
    end;

    procedure GetIdString(): Text
    begin
        LoadModuleInfo();
        exit(format(miApp.Id()));
    end;

    procedure GetName(): Text
    begin
        LoadModuleInfo();
        exit(miApp.Name());
    end;

    procedure GetPublisher(): Text
    begin
        LoadModuleInfo();
        exit(miApp.Publisher());
    end;

    procedure GetAppVersion(): Version
    begin
        LoadModuleInfo();
        exit(miApp.AppVersion());
    end;

    procedure GetAppVersionString(): Text
    begin
        exit(format(GetAppVersion()));
    end;

    procedure GetAppVersionMajor(): Integer
    begin
        exit(GetAppVersion().Major());
    end;

    procedure GetAppVersionMinor(): Integer
    begin
        exit(GetAppVersion().Minor());
    end;

    procedure GetAppVersionBuild(): Integer
    begin
        exit(GetAppVersion().Build());
    end;

    procedure GetAppVersionRevision(): Integer
    begin
        exit(GetAppVersion().Revision());
    end;

    procedure GetDataVersion(): Version
    begin
        LoadModuleInfo();
        exit(miApp.DataVersion());
    end;

    procedure GetDataVersionString(): Text
    begin
        exit(format(GetDataVersion()));
    end;

    procedure GetDataVersionMajor(): Integer
    begin
        exit(GetDataVersion().Major());
    end;

    procedure GetDataVersionMinor(): Integer
    begin
        exit(GetDataVersion().Minor());
    end;

    procedure GetDataVersionBuild(): Integer
    begin
        exit(GetDataVersion().Build());
    end;

    procedure GetDataVersionRevision(): Integer
    begin
        exit(GetDataVersion().Revision());
    end;

    procedure IsFreshInstall(): Boolean
    begin
        exit(GetDataVersion() = Version.Create(0, 0, 0, 0));
    end;

    local procedure LoadModuleInfo()
    begin
        if booModuleInfoLoaded then
            exit;
        NavApp.GetCurrentModuleInfo(miApp);
        booModuleInfoLoaded := true;
    end;
}