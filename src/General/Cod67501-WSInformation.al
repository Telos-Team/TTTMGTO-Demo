codeunit 67501 TTTMGTOWSInformation
{
    Description = 'TTT Magento Web Service Information';

    trigger OnRun()
    begin
    end;

    var
        textSalesOrderFilter: Label 'SORTING(Field1,Field3) WHERE(Field1=1(1)', Locked = true;

    procedure GetItemCount(): Integer
    begin
        exit(GetItemCountInternal());
    end;

    procedure GetCustomerCount(): Integer
    begin
        exit(GetCustomerCountInternal());
    end;

    procedure GetOrderCount(): Integer
    begin
        exit(GetOrderCountInternal());
    end;

    local procedure GetItemCountInternal(): Integer
    begin
        exit(GetRecordCount(Database::Item));
    end;

    local procedure GetCustomerCountInternal(): Integer
    begin
        exit(GetRecordCount(Database::Customer));
    end;

    local procedure GetOrderCountInternal(): Integer
    begin
        exit(GetFilteredRecordCount(Database::"Sales Header", textSalesOrderFilter));
    end;

    local procedure GetRecordCount(parintTableNo: Integer): Integer
    begin
        exit(GetFilteredRecordCount(parintTableNo, ''));
    end;

    local procedure GetFilteredRecordCount(parintTableNo: Integer; partxtView: Text): Integer
    var
        locrrTable: RecordRef;
    begin
        locrrTable.Open(parintTableNo);
        if not locrrTable.ReadPermission() then
            exit(0);
        if partxtView <> '' then
            locrrTable.SetView(partxtView);
        exit(locrrTable.Count());
    end;
}