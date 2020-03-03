unit frmMain1;

interface

uses
  Seedkey,
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Edit, FMX.Controls.Presentation, FMX.ScrollBox, FMX.Memo, FMX.Objects,
  FMX.Effects, FMX.Layouts;

type
  TfrmMain = class(TForm)
    StyleBook: TStyleBook;
    lblHeader: TLabel;
    edtSeed: TEdit;
    lblSeed: TLabel;
    edtAlgo: TEdit;
    lblAlgo: TLabel;
    btnGenerate: TButton;
    edtKey: TEdit;
    lblKey: TLabel;
    chkBrute: TCheckBox;
    MemoResults: TMemo;
    btnHelp: TButton;
    ShadowEffect1: TShadowEffect;
    ShadowEffect2: TShadowEffect;
    ShadowEffect3: TShadowEffect;
    ShadowEffect4: TShadowEffect;
    ShadowEffect5: TShadowEffect;
    ShadowEffect6: TShadowEffect;
    GlowEffect1: TGlowEffect;
    ScaledLayout1: TScaledLayout;
    RectBottomBreak: TRectangle;
    RectTopBreak: TRectangle;
    RectContainer: TRectangle;
    procedure chkBruteChange(Sender: TObject);
    procedure btnGenerateClick(Sender: TObject);
    procedure btnHelpClick(Sender: TObject);
  private
    procedure BruteCalc;
    procedure SingleCalc;
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.fmx}

procedure TfrmMain.BruteCalc;
var
  cnt: integer;
  seed: integer;
  key: string;
begin

  try
    seed := strtoint('$' + edtSeed.Text);
  except
    on e: exception do
    begin
      showmessage('Invalid SEED Hex Value');
      edtSeed.Text := '';
      exit;
    end;
  end;

  MemoResults.Lines.Clear;

  MemoResults.Lines.Add('Calculating all 256 combinations');
  MemoResults.Lines.Add('');

  for cnt := 0 to 255 do
  begin
    key := Seedkey.create_key(seed, cnt).ToHexString(4);

    if length(key) = 3 then
      key := '0' + key;

    if length(key) = 2 then
      key := '00' + key;

    if cnt <= 15 then
      MemoResults.Lines.Add('Algorithm 0' + cnt.ToHexString(1) + ' - Key = ' + key)
    else
      MemoResults.Lines.Add('Algorithm ' + cnt.ToHexString(1) + ' - Key = ' + key);
  end;

end;

procedure TfrmMain.SingleCalc;
var
  cnt: integer;
  seed: integer;
begin

  if length(Trim(edtAlgo.Text)) < 2 then
  begin
    showmessage('Invalid Algorithm HEX Value. Must be 2 characters long.');
    exit;
  end;

  try
    seed := strtoint('$' + edtSeed.Text);
  except
    on e: exception do
    begin
      showmessage('Invalid SEED Hex Value');
      edtSeed.Text := '';
      exit;
    end;
  end;

  try
    cnt := strtoint('$' + edtAlgo.Text);
  except
    on e: exception do
    begin
      showmessage('Invalid Algorithm Hex Value');
      edtAlgo.Text := '';
      exit;
    end;
  end;

  MemoResults.Lines.Clear;
  MemoResults.Lines.Add('Calculating single algorithm');
  MemoResults.Lines.Add('');
  MemoResults.Lines.Add('Key = ' + Seedkey.create_key(seed, cnt).ToHexString);

  edtKey.Text := Seedkey.create_key(seed, cnt).ToHexString;
end;

procedure TfrmMain.btnGenerateClick(Sender: TObject);
begin

  if length(Trim(edtSeed.Text)) < 4 then
  begin
    showmessage('Invalid Seed HEX Value. Must be 4 characters long.');
    exit;
  end;

  case chkBrute.IsChecked of
    true:
      BruteCalc;
    false:
      SingleCalc;
  end;
end;

procedure TfrmMain.btnHelpClick(Sender: TObject);
begin
  showmessage('Input your 4 digit SEED value. Then input your 2 digit ' +
    'Algorithm number if you know it or use the brute force to calculate all 256 combinations. ' +
    'Use the GENERATE button to do your calculations.');
end;

procedure TfrmMain.chkBruteChange(Sender: TObject);
begin
  edtAlgo.Text := '';
  edtKey.Text := '';
  case chkBrute.IsChecked of
    true:
      begin
        lblAlgo.Visible := false;
        lblKey.Visible := false;
        edtAlgo.Visible := false;
        edtKey.Visible := false;
      end;
    false:
      begin
        lblAlgo.Visible := true;
        lblKey.Visible := true;
        edtAlgo.Visible := true;
        edtKey.Visible := true;
      end;
  end;
end;

end.
