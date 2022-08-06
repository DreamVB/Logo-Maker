unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  ComCtrls, Spin, IniFiles, Types, ATStringProc_HtmlColor;

type

  { Tfrmmain }

  Tfrmmain = class(TForm)
    cboVAlign: TComboBox;
    cmdBdrColor1: TColorButton;
    cmdLoad: TButton;
    cmdSave: TButton;
    cmdSaveImg: TButton;
    cboTextAlign: TComboBox;
    cboStyle: TComboBox;
    cboEffects: TComboBox;
    chkShadow: TCheckBox;
    cmdGrad1: TColorButton;
    cmdGrad2: TColorButton;
    cmdImgBk: TButton;
    cmdSet: TButton;
    cmdbkColor: TColorButton;
    cboGradeDir: TComboBox;
    cboFonts: TComboBox;
    cmdTextColor: TColorButton;
    cmdBdrColor: TColorButton;
    cmdTextShadow: TColorButton;
    gBackColor: TGroupBox;
    gPicture: TGroupBox;
    gGrad: TGroupBox;
    gBorder: TGroupBox;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    lblColBdr1: TLabel;
    lblJpegQulity: TLabel;
    lblShadowX: TLabel;
    lblShadowY: TLabel;
    lblShadowoffset: TLabel;
    lblBdrWidth: TLabel;
    lblColBdr: TLabel;
    lblTextAlign: TLabel;
    lblTextColor: TLabel;
    lblFonts: TLabel;
    lblFontStyle: TLabel;
    lblFontEffect: TLabel;
    lblTextShadow: TLabel;
    lblTextSize: TLabel;
    LogoText: TLabeledEdit;
    lblBackgroundType: TLabel;
    lblFirst: TLabel;
    lblGradDirection: TLabel;
    lblSecond: TLabel;
    optGrad: TRadioButton;
    optSaveType3: TRadioButton;
    optSize2: TRadioButton;
    optSize3: TRadioButton;
    optSize4: TRadioButton;
    optSize5: TRadioButton;
    optSize6: TRadioButton;
    optSize7: TRadioButton;
    optSize8: TRadioButton;
    optSize9: TRadioButton;
    PageControl1: TPageControl;
    optSize1: TRadioButton;
    optBkColor: TRadioButton;
    optBkPicture: TRadioButton;
    optSaveType1: TRadioButton;
    optSaveType2: TRadioButton;
    TabSheet5: TTabSheet;
    txtJPEGComp: TSpinEdit;
    TabSheet4: TTabSheet;
    txtShadowX: TSpinEdit;
    txtShadowY: TSpinEdit;
    txtBdrWidth: TSpinEdit;
    txtFontSize: TSpinEdit;
    txtWidth: TSpinEdit;
    txtHeight: TSpinEdit;
    StatusBar1: TStatusBar;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    pBox: TPaintBox;
    ScrollBox1: TScrollBox;
    procedure cboEffectsSelect(Sender: TObject);
    procedure cboFontsSelect(Sender: TObject);
    procedure cboGradeDirSelect(Sender: TObject);
    procedure cboStyleSelect(Sender: TObject);
    procedure cboTextAlignSelect(Sender: TObject);
    procedure cboVAlignSelect(Sender: TObject);
    procedure chkAntialiasedChange(Sender: TObject);
    procedure chkShadowChange(Sender: TObject);
    procedure cmdBdrColor1Click(Sender: TObject);
    procedure cmdBdrColor1ColorChanged(Sender: TObject);
    procedure cmdBdrColorColorChanged(Sender: TObject);
    procedure cmdbkColorColorChanged(Sender: TObject);
    procedure cmdGrad1ColorChanged(Sender: TObject);
    procedure cmdGrad2ColorChanged(Sender: TObject);
    procedure cmdImgBkClick(Sender: TObject);
    procedure cmdLoadClick(Sender: TObject);
    procedure cmdSaveClick(Sender: TObject);
    procedure cmdSaveImgClick(Sender: TObject);
    procedure cmdSetClick(Sender: TObject);
    procedure cmdTextShadowColorChanged(Sender: TObject);
    procedure cmdTextColorColorChanged(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure LogoTextChange(Sender: TObject);
    procedure optBkColorChange(Sender: TObject);
    procedure optBkPictureChange(Sender: TObject);
    procedure optGradChange(Sender: TObject);
    procedure optSaveType1Change(Sender: TObject);
    procedure optSaveType2Change(Sender: TObject);
    procedure optSaveType3Change(Sender: TObject);
    procedure optSize1Change(Sender: TObject);
    procedure optSize2Change(Sender: TObject);
    procedure optSize3Change(Sender: TObject);
    procedure optSize4Change(Sender: TObject);
    procedure optSize5Change(Sender: TObject);
    procedure optSize6Change(Sender: TObject);
    procedure optSize7Change(Sender: TObject);
    procedure optSize8Change(Sender: TObject);
    procedure optSize9Change(Sender: TObject);
    procedure pBoxPaint(Sender: TObject);
    procedure txtBdrWidthChange(Sender: TObject);
    procedure txtFontSizeChange(Sender: TObject);
    procedure txtShadowXChange(Sender: TObject);
    procedure txtShadowYChange(Sender: TObject);
  private
    procedure RenderLogo;
    procedure SetBannerSize(W, H: integer);
    procedure SetSizeTextB(W, H: integer);
    procedure CenterBanner;
    procedure SaveProject(Filename: string);
    procedure LoadProject(Filename: string);
  public

  end;

var
  frmmain: Tfrmmain;
  TheBmp: TBitmap;
  TheWidth, TheHeight, x, y: integer;
  TheText: string;
  TheBackColor: TColor;
  TheBrushFile: string;
  TheBackgroundType: integer;
  Foreground, Shadow: TColor;
  GradColor1, GradColor2: TColor;
  GradDirection: TGradientDirection;
  dlgFilter: string;

implementation

{$R *.lfm}

{ Tfrmmain }

procedure SaveToPng(const bmp: TBitmap; PngFileName: String);
var
  png : TPortableNetworkGraphic;
begin
  png := TPortableNetworkGraphic.Create;
  try
    png.Assign(bmp);
    png.SaveToFile(PngFileName);
  finally
    png.Free;
  end;
end;

procedure Tfrmmain.LoadProject(Filename: string);
var
  ini: TIniFile;
  w, h, bt: integer;
  temp: string;
  len: integer;
begin
  ini := TIniFile.Create(Filename);

  w := ini.ReadInteger('size', 'width', 728);
  h := ini.ReadInteger('size', 'height', 90);

  SetBannerSize(w, h);
  SetSizeTextB(w, h);

  //Background
  bt := ini.ReadInteger('background', 'type', 0);

  if bt = 0 then optBkColor.Checked := True;
  if bt = 1 then optBkPicture.Checked := True;
  if bt = 2 then optGrad.Checked := True;

  temp := ini.ReadString('background', 'color', '#ffffff');
  cmdbkColor.ButtonColor := SHtmlColorToColor(temp, len, clWhite);
  TheBrushFile := ini.ReadString('background', 'picture', '');
  //Gradident
  temp := ini.ReadString('background', 'grad1', '#ffffff');
  cmdGrad1.ButtonColor := SHtmlColorToColor(temp, len, clWhite);
  temp := ini.ReadString('background', 'grad2', '#000000');
  cmdGrad2.ButtonColor := SHtmlColorToColor(temp, len, clblack);
  cboGradeDir.ItemIndex := ini.ReadInteger('background', 'grad-dir', 0);
  //Border 1
  temp := ini.ReadString('background', 'line1', '#000000');
  cmdBdrColor.ButtonColor := SHtmlColorToColor(temp, len, clBlack);
  txtBdrWidth.Value := ini.ReadInteger('background', 'line1', 0);
  //Border 2
  temp := ini.ReadString('background', 'line2', '#8d8c86');
  cmdBdrColor1.ButtonColor := SHtmlColorToColor(temp, len, clDkGray);
  txtBdrWidth.Value := ini.ReadInteger('background','border-width',0);

  //Text
  LogoText.Text := ini.ReadString('text', 'text', 'Hello World');
  temp := ini.ReadString('text', 'font', 'arial');
  cboFonts.ItemIndex := cbofonts.Items.IndexOf(temp);
  txtFontSize.Value := ini.ReadInteger('text', 'size', 28);
  cboTextAlign.ItemIndex := ini.ReadInteger('text', 'align', 1);
  cboVAlign.ItemIndex := ini.ReadInteger('text','VAlign',1);
  cboStyle.ItemIndex := ini.ReadInteger('text', 'style', 0);
  cboEffects.ItemIndex := ini.ReadInteger('text', 'effects', 0);
  //Text color
  temp := ini.ReadString('text', 'color', '#000000');
  cmdTextColor.ButtonColor := SHtmlColorToColor(temp, len, clblack);
  //Shadow
  temp := ini.ReadString('text', 'shadowcolor', '#c6c6c6');
  cmdTextShadow.ButtonColor := SHtmlColorToColor(temp, len, clDkGray);
  chkShadow.Checked := ini.ReadBool('text', 'shadow', False);
  //Shadow offset
  txtShadowX.Value := ini.ReadInteger('text', 'shadowx', 3);
  txtShadowY.Value := ini.ReadInteger('text', 'shadowy', 3);
  //Free ini
  ini.Free;
  //Render logo
  pBoxPaint(nil);
end;

procedure Tfrmmain.SaveProject(Filename: string);
var
  ini: TIniFile;
begin
  ini := TIniFile.Create(Filename);

  ini.WriteInteger('size', 'width', txtWidth.Value);
  ini.WriteInteger('size', 'height', txtHeight.Value);
  //Background
  ini.WriteInteger('background', 'type', TheBackgroundType);
  ini.WriteString('background', 'color', SColorToHtmlColor(cmdbkColor.ButtonColor));
  ini.WriteString('background', 'picture', TheBrushFile);
  ini.WriteString('background', 'grad1', SColorToHtmlColor(cmdGrad1.ButtonColor));
  ini.WriteString('background', 'grad2', SColorToHtmlColor(cmdGrad2.ButtonColor));
  ini.WriteInteger('background', 'grad-dir', cboGradeDir.ItemIndex);
  ini.WriteString('background', 'line1', SColorToHtmlColor(cmdBdrColor.ButtonColor));
  ini.WriteString('background', 'line2', SColorToHtmlColor(cmdBdrColor1.ButtonColor));
  ini.WriteInteger('background', 'border-width', txtBdrWidth.Value);



  //Text
  ini.WriteString('text', 'text', LogoText.Text);
  ini.WriteString('text', 'font', cboFonts.Text);
  ini.WriteInteger('text', 'size', txtFontSize.Value);
  ini.WriteInteger('text', 'align', cboTextAlign.ItemIndex);
  ini.WriteInteger('text','VAlign',cboVAlign.ItemIndex);
  ini.WriteInteger('text', 'style', cboStyle.ItemIndex);
  ini.WriteInteger('text', 'effects', cboEffects.ItemIndex);
  ini.WriteString('text', 'color', SColorToHtmlColor(cmdTextColor.ButtonColor));
  ini.WriteString('text', 'shadowcolor', SColorToHtmlColor(
    cmdTextShadow.ButtonColor));
  ini.WriteBool('text', 'shadow', chkShadow.Checked);
  ini.WriteInteger('text', 'shadowx', txtShadowX.Value);
  ini.WriteInteger('text', 'shadowy', txtShadowY.Value);
  ini.UpdateFile;
  ini.Free;
end;

procedure Tfrmmain.CenterBanner;
begin
  pBox.Left := (ScrollBox1.Width - pBox.Width) div 2;
  pBox.Top := (ScrollBox1.Height - pBox.Height) div 2;
end;

procedure Tfrmmain.SetSizeTextB(W, H: integer);
begin
  txtwidth.Value := W;
  txtHeight.Value := H;
end;

procedure Tfrmmain.SetBannerSize(W, H: integer);
begin
  TheWidth := W;
  TheHeight := H;
  pBoxPaint(nil);
end;

procedure Tfrmmain.RenderLogo;
var
  bmp: TBitmap;
  xPos, yPos,I: integer;
  sText: string;
begin

  if TheBmp <> nil then
    TheBmp.Destroy;

  TheBmp := TBitmap.Create;

  if pBox.Width <> TheWidth then
  begin
    pBox.Width := TheWidth;
    exit;
  end;

  if pBox.Height <> TheHeight then
  begin
    pBox.Height := TheHeight;
    exit;
  end;

  theBmp.SetSize(TheWidth, TheHeight);
  theBmp.PixelFormat := pf24bit;

  if TheBackgroundType = 0 then
  begin
    theBmp.Canvas.Brush.Style := bsSolid;
    theBmp.Canvas.Brush.Color := TheBackColor;
    theBmp.Canvas.FillRect(0, 0, TheWidth, TheHeight);
  end;

  //Background type is using a texture
  if TheBackgroundType = 1 then
  begin
    if (TheBrushFile <> '') and (FileExists(TheBrushFile)) then
    begin
      bmp := TBitmap.Create;
      bmp.PixelFormat := pf24bit;
      bmp.LoadFromFile(TheBrushFile);
      theBmp.Canvas.Brush.Bitmap := bmp;
      theBmp.Canvas.FillRect(0, 0, TheWidth, TheHeight);
      bmp.Free;
    end;
  end;

  //Check if user wants a gradident background
  if TheBackgroundType = 2 then
  begin
    theBmp.Canvas.GradientFill(RECT(0, 0, TheWidth, TheHeight),
      GradColor1, GradColor2, GradDirection);
  end;

  //The text rendering
  theBmp.Canvas.Font.Size := txtFontSize.Value;

  //Reset eveything
  theBmp.Canvas.Font.Bold := False;
  theBmp.Canvas.Font.Italic := False;
  theBmp.Canvas.Font.Underline := False;
  theBmp.Canvas.Font.StrikeThrough := False;

  //Font style
  case cboStyle.ItemIndex of
    1:
    begin
      theBmp.Canvas.Font.Bold := True;
    end;
    2:
    begin
      theBmp.Canvas.Font.Italic := True;
    end;
    3:
    begin
      theBmp.Canvas.Font.Bold := True;
      theBmp.Canvas.Font.Italic := True;
    end;
  end;
  //Font effects
  case cboEffects.ItemIndex of
    1:
    begin
      theBmp.Canvas.Font.StrikeThrough := True;
    end;
    2:
    begin
      theBmp.Canvas.Font.Underline := True;
    end;
    3:
    begin
      theBmp.Canvas.Font.StrikeThrough := True;
      theBmp.Canvas.Font.Underline := True;
    end;
  end;

  //Logo text
  sText := LogoText.Text;

  theBmp.Canvas.Brush.Style := bsClear;
  theBmp.Canvas.Font.Name := cboFonts.Text;

  case cboVAlign.ItemIndex of
    0:
    begin
      yPos := 0;
    end;
    1:
    begin
      //Text Y pos
      yPos := (theBmp.Height - theBmp.Canvas.TextHeight(sText)) div 2;
    end;
    2:
    begin
      yPos := (TheHeight - theBmp.Canvas.TextHeight(sText));
    end;
  end;

  //Text alignment
  case cboTextAlign.ItemIndex of
    0:
      //Left
    begin
      xPos := 4;
    end;
    1:
      //Center
    begin
      xPos := (theBmp.Width - theBmp.Canvas.TextWidth(sText)) div 2;
    end;
    2:
      //Right
    begin
      xPos := (theBmp.Width - theBmp.Canvas.TextWidth(sText)) - 4;
    end;
  end;

  //Draw rectangle around logo
  if txtBdrWidth.Value > 0 then
  begin

    theBmp.Canvas.Pen.Color := cmdBdrColor.ButtonColor;

    For I := 0 to txtBdrWidth.Value do begin
       theBmp.Canvas.Line(0,I,TheWidth-I,I);
       theBmp.Canvas.Line(I,0,I,TheHeight -I);
    end;

    theBmp.Canvas.Pen.Color := cmdBdrColor1.ButtonColor;

    For I := 0 to txtBdrWidth.Value do begin
     theBmp.Canvas.Line(TheWidth-I,I,TheWidth-I,TheHeight-I);
     theBmp.Canvas.Line(I,TheHeight-I,TheWidth,TheHeight-I);
    end;

  end;

  //Check if drawing shadow
  if chkShadow.Checked then
  begin
    theBmp.Canvas.Font.Color := cmdTextShadow.ButtonColor;
    theBmp.Canvas.TextOut(xPos, yPos, sText);
    theBmp.Canvas.Font.Color := cmdTextColor.ButtonColor;
    theBmp.Canvas.TextOut(xPos + txtShadowX.Value, yPos + txtShadowY.Value, sText);
  end
  else
  begin
    //No shadow just draw the text
    theBmp.Canvas.Font.Color := cmdTextColor.ButtonColor;
    theBmp.Canvas.TextOut(xPos, yPos, sText);
  end;

  pbox.Canvas.Draw(0, 0, theBmp);
  //Center pictirebox
  CenterBanner;
end;

procedure Tfrmmain.FormCreate(Sender: TObject);
begin
  dlgFilter := 'Bitmap Files(*.bmp)|*.bmp';

  TheBackgroundType := 0;
  TheBackColor := clWhite;
  GradColor1 := clBlack;
  GradColor2 := clWhite;
  GradDirection := gdVertical;
  //Load screen fonts
  cboFonts.Items := Screen.Fonts;
  //Set the default font
  cboFonts.ItemIndex := cboFonts.Items.IndexOf('Verdana');
  //Set the size of the pictirebox.
  optSize2Change(Sender);
end;

procedure Tfrmmain.LogoTextChange(Sender: TObject);
begin
  pBoxPaint(Sender);
end;

procedure Tfrmmain.optBkColorChange(Sender: TObject);
begin
  TheBackgroundType := 0;
  pBoxPaint(Sender);
end;

procedure Tfrmmain.optBkPictureChange(Sender: TObject);
begin
  TheBackgroundType := 1;
  pBoxPaint(Sender);
end;

procedure Tfrmmain.optGradChange(Sender: TObject);
begin
  TheBackgroundType := 2;
  pBoxPaint(Sender);
end;

procedure Tfrmmain.optSaveType1Change(Sender: TObject);
begin
  dlgFilter := 'Bitmap Files(*.bmp)|*.bmp';
end;

procedure Tfrmmain.optSaveType2Change(Sender: TObject);
begin
  dlgFilter := 'JPEG Files(*.jpg)|*.jpg';
end;

procedure Tfrmmain.optSaveType3Change(Sender: TObject);
begin
  dlgFilter := 'Portable Network Graphic(*.png)|*.png';
end;

procedure Tfrmmain.optSize1Change(Sender: TObject);
begin
  SetBannerSize(468, 60);
  SetSizeTextB(468, 60);
end;

procedure Tfrmmain.optSize2Change(Sender: TObject);
begin
  SetBannerSize(728, 90);
  SetSizeTextB(728, 90);
end;

procedure Tfrmmain.optSize3Change(Sender: TObject);
begin
  SetBannerSize(234, 60);
  SetSizeTextB(234, 60);
end;

procedure Tfrmmain.optSize4Change(Sender: TObject);
begin
  SetBannerSize(125, 125);
  SetSizeTextB(125, 125);
end;

procedure Tfrmmain.optSize5Change(Sender: TObject);
begin
  SetBannerSize(88, 31);
  SetSizeTextB(88, 31);
end;

procedure Tfrmmain.optSize6Change(Sender: TObject);
begin
  SetBannerSize(485, 68);
  SetSizeTextB(485, 68);
end;

procedure Tfrmmain.optSize7Change(Sender: TObject);
begin
  SetBannerSize(336, 280);
  SetSizeTextB(336, 280);
end;

procedure Tfrmmain.optSize8Change(Sender: TObject);
begin
  SetBannerSize(300, 600);
  SetSizeTextB(300, 600);
end;

procedure Tfrmmain.optSize9Change(Sender: TObject);
begin
  SetBannerSize(850, 315);
  SetSizeTextB(850, 315);
end;

procedure Tfrmmain.pBoxPaint(Sender: TObject);
begin
  RenderLogo;
end;

procedure Tfrmmain.txtBdrWidthChange(Sender: TObject);
begin
  pBoxPaint(Sender);
end;

procedure Tfrmmain.txtFontSizeChange(Sender: TObject);
begin
  pBoxPaint(Sender);
end;

procedure Tfrmmain.txtShadowXChange(Sender: TObject);
begin
  pBoxPaint(Sender);
end;

procedure Tfrmmain.txtShadowYChange(Sender: TObject);
begin
  pBoxPaint(Sender);
end;

procedure Tfrmmain.cboEffectsSelect(Sender: TObject);
begin
  pBoxPaint(Sender);
end;

procedure Tfrmmain.cboFontsSelect(Sender: TObject);
begin
  pBoxPaint(Sender);
end;

procedure Tfrmmain.cboGradeDirSelect(Sender: TObject);
begin
  if cboGradeDir.ItemIndex = 0 then GradDirection := gdVertical;
  if cboGradeDir.ItemIndex = 1 then GradDirection := gdHorizontal;
  pBoxPaint(Sender);
end;

procedure Tfrmmain.cboStyleSelect(Sender: TObject);
begin
  pBoxPaint(Sender);
end;

procedure Tfrmmain.cboTextAlignSelect(Sender: TObject);
begin
  pBoxPaint(Sender);
end;

procedure Tfrmmain.cboVAlignSelect(Sender: TObject);
begin
     pBoxPaint(Sender);
end;

procedure Tfrmmain.chkAntialiasedChange(Sender: TObject);
begin
  pBoxPaint(Sender);
end;

procedure Tfrmmain.chkShadowChange(Sender: TObject);
begin
  pBoxPaint(Sender);
end;

procedure Tfrmmain.cmdBdrColor1Click(Sender: TObject);
begin

end;

procedure Tfrmmain.cmdBdrColor1ColorChanged(Sender: TObject);
begin
    pBoxPaint(Sender);
end;

procedure Tfrmmain.cmdBdrColorColorChanged(Sender: TObject);
begin
  pBoxPaint(Sender);
end;

procedure Tfrmmain.cmdbkColorColorChanged(Sender: TObject);
begin
  TheBackColor := cmdbkColor.ButtonColor;
  pBoxPaint(Sender);
end;

procedure Tfrmmain.cmdGrad1ColorChanged(Sender: TObject);
begin
  GradColor1 := cmdGrad1.ButtonColor;
  pBoxPaint(Sender);
end;

procedure Tfrmmain.cmdGrad2ColorChanged(Sender: TObject);
begin
  GradColor2 := cmdGrad2.ButtonColor;
  pBoxPaint(Sender);
end;

procedure Tfrmmain.cmdImgBkClick(Sender: TObject);
var
  od: TOpenDialog;
begin
  od := TOpenDialog.Create(self);
  od.Title := 'Open Bitmap';
  od.Filter := 'Bitmap Files(*.bmp)|*.bmp';
  od.FilterIndex := 1;
  if od.Execute then
  begin
    TheBrushFile := od.FileName;
    pBoxPaint(Sender);
  end;
  od.Free;
end;

procedure Tfrmmain.cmdLoadClick(Sender: TObject);
var
  od: TOpenDialog;
begin
  od := TOpenDialog.Create(self);
  od.Title := 'Open Project';
  od.Filter := 'Logo Projects(*.lproj)|*.lproj';
  od.FilterIndex := 1;
  if od.Execute then
  begin
    LoadProject(od.FileName);
  end;
  od.Free;
end;

procedure Tfrmmain.cmdSaveClick(Sender: TObject);
var
  sd: TSaveDialog;
begin
  sd := TSaveDialog.Create(self);
  sd.Title := 'Save Project';
  sd.Filter := 'Logo Projects(*.lproj)|*.lproj';
  sd.FilterIndex := 1;
  if sd.Execute then
  begin

    if FileExists(sd.FileName) then
    begin
      if MessageDlg(Text,'The file already exists do you want to overwrite it.',
      mtInformation,[mbYes,mbNo,mbCancel],0) <> mrYes then
      begin
        exit;
      end
      else
      begin
        SaveProject(sd.FileName);
      end;
    end
    else
    begin
      SaveProject(sd.FileName);
    end;

  end;
  sd.Free;
end;

procedure Tfrmmain.cmdSaveImgClick(Sender: TObject);
var
  sd: TSaveDialog;
  jpg: TJPEGImage;
begin
  sd := TSaveDialog.Create(self);
  sd.Title := 'Save Pictire';
  sd.Filter := dlgFilter;

  if sd.Execute then
  begin
    //Save bitmap
    if optSaveType1.Checked then
    begin
      TheBmp.SaveToFile(sd.FileName);
    end;
    //Save JPEG
    if optSaveType2.Checked then
    begin
      jpg := TJPEGImage.Create;
      jpg.CompressionQuality := txtJPEGComp.Value;
      jpg.Assign(TheBmp);
      jpg.SaveToFile(sd.FileName);
      jpg.Free;
    end;
    if optSaveType3.Checked then
    begin
      SaveToPng(TheBmp,sd.FileName);
    end;
  end;

  sd.Free;
end;

procedure Tfrmmain.cmdSetClick(Sender: TObject);
begin
  SetBannerSize(txtWidth.Value, txtHeight.Value);
end;

procedure Tfrmmain.cmdTextShadowColorChanged(Sender: TObject);
begin
  pBoxPaint(Sender);
end;

procedure Tfrmmain.cmdTextColorColorChanged(Sender: TObject);
begin
  pBoxPaint(Sender);
end;

procedure Tfrmmain.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  TheBmp.Free;
end;

end.
