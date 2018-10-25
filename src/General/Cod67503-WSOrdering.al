codeunit 67503 TTTMGTOWSOrdering
{
    Description = 'TTT Magento Web Service Ordering';

    trigger OnRun()
    begin
    end;

    var
        textACKTxt: Label 'OK', Locked = true;
        errFieldLengthExceededErr: Label 'Field length exceeded!\Table: %1\Field: %2\Allowed: %3\Used: %4';
        errFieldLengthZeroErr: Label 'Field length cannot be zero!\Table: %1\Field: %2';

    procedure PostOrderShipment(OrderNo: Text; LineNo: Integer): Text
    begin
        PostOrderShipmentInternal(OrderNo, LineNo);
        exit(textACKTxt);
    end;

    procedure PostOrderInvoice(OrderNo: Text; LineNo: Integer): Text
    begin
        PostOrderInvoiceInternal(OrderNo, LineNo);
        exit(textACKTxt);
    end;

    local procedure PostOrderShipmentInternal(partxtOrderNo: Text; parintLineNo: Integer)
    var
        locrecSH: Record "Sales Header";
        loccuPost: Codeunit "Sales-Post";
    begin
        CheckOrderNoLength(partxtOrderNo);
        if parintLineNo > 0 then
            UpdateLines(partxtOrderNo, parintLineNo, false);
        locrecSH.Get(locrecSH."Document Type"::Order, partxtOrderNo);
        locrecSH.SetRecFilter();
        locrecSH.Validate(Ship, true);
        locrecSH.Validate(Invoice, false);
        loccuPost.Run(locrecsh);
    end;

    local procedure PostOrderInvoiceInternal(partxtOrderNo: Text; parintLineNo: Integer)
    var
        locrecSH: Record "Sales Header";
        loccuPost: Codeunit "Sales-Post";
    begin
        CheckOrderNoLength(partxtOrderNo);
        if parintLineNo > 0 then
            UpdateLines(partxtOrderNo, parintLineNo, true);
        locrecSH.Get(locrecSH."Document Type"::Order, partxtOrderNo);
        locrecSH.SetRecFilter();
        locrecSH.Validate(Ship, false);
        locrecSH.Validate(Invoice, true);
        loccuPost.Run(locrecsh);
    end;

    local procedure UpdateLines(partxtOrderNo: Text; parintLineNo: Integer; partxtIsInvoice: Boolean)
    var
        locrecSL: Record "Sales Line";
    begin
        locrecSL.SetRange("Document No.", partxtOrderNo);
        locrecSL.SetRange("Line No.", parintLineNo);
        locrecSL.FindFirst();

        locrecSL.SetFilter("Line No.", '<>%1', parintLineNo);
        locrecSL.SetFilter("No.", '<>%1', '');
        locrecSL.SetFilter(Quantity, '<>%1', 0);
        if not locrecSL.FindSet() then
            exit;
        repeat
            if not partxtIsInvoice then begin
                if locrecSL."Qty. to Ship" <> 0 then begin
                    locrecSL.Validate("Qty. to Ship", 0);
                    locrecSL.Modify(true);
                end;
            end else begin
                if locrecSL."Qty. to Invoice" <> 0 then begin
                    locrecSL.Validate("Qty. to Ship", 0);
                    locrecSL.Modify(true);
                end;
            end;
        until locrecSL.Next = 0;
    end;

    local procedure CheckOrderNoLength(partxtOrderNo: Text)
    var
        locrecSH: Record "Sales Header";
    begin
        CheckVariableLength(locrecSH.TableCaption(), locrecsh.FieldCaption("No."), MaxStrLen(locrecSH."No."), StrLen(partxtOrderNo), true);
    end;

    local procedure CheckVariableLength(partxtTableCaption: Text; partxtFieldCaption: Text; parintMaxLength: Integer; parintUsedLength: Integer; parbooCheckZero: Boolean)
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