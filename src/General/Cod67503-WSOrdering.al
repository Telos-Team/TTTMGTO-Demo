codeunit 67503 TTTMGTOWSOrdering
{
    trigger OnRun()
    begin
    end;

    procedure PostOrderShipment(OrderNo: Text; LineNo: Integer): Text
    begin
        PostOrderShipmentInternal(OrderNo, LineNo);
    end;

    procedure PostOrderInvoice(OrderNo: Text; LineNo: Integer): Text
    begin
        PostOrderInvoiceInternal(OrderNo, LineNo);
    end;

    local procedure PostOrderShipmentInternal(partxtOrderNo: Text; parintLineNo: Integer)
    begin
        CheckOrderNoLength(partxtOrderNo);

    end;

    local procedure PostOrderInvoiceInternal(partxtOrderNo: Text; parintLineNo: Integer)
    begin
        CheckOrderNoLength(partxtOrderNo);

    end;

    local procedure CheckOrderNoLength(partxtOrderNo: Text)
    var
        locrecSH: Record "Sales Header";
    begin
        CheckVariableLength(locrecSH.TableCaption(), locrecsh.FieldCaption("No."), MaxStrLen(locrecSH."No."), StrLen(partxtOrderNo), true);
    end;

    local procedure CheckVariableLength(partxtTableCaption: Text; partxtFieldCaption: Text; parintMaxLength: Integer; parintUsedLength: Integer; parbooCheckZero: Boolean)
    var
        errFieldLengthExceededErr: Label 'Field length exceeded!\Table: %1\Field: %2\Allowed: %3\Used: %4';
        errFieldLengthZeroErr: Label 'Field length cannot be zero!\Table: %1\Field: %2';
    begin
        if parintUsedLength > 0 then begin
            if parintUsedLength > parintMaxLength then
                error(errFieldLengthExceededErr, partxtTableCaption, partxtFieldCaption, parintMaxLength, parintUsedLength);
        end else
            if parbooCheckZero then
                if parintUsedLength = 0 then
                    error(errFieldLengthZeroErr, partxtTableCaption, partxtFieldCaption);
    end;
}