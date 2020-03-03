program OBD2GMSeedKeyTool;

uses
  System.StartUpCopy,
  FMX.MobilePreview,
  FMX.Forms,
  frmMain1 in 'frmMain1.pas' {frmMain},
  seedkey in 'seedkey.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
