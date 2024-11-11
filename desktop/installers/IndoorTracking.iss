[Setup]
AppName=Indoor Tracking App
AppVersion=1.0
DefaultDirName={pf}\IndoorTrackingApp
DefaultGroupName=IndoorTrackingApp
OutputDir=Output
OutputBaseFilename=IndoorTrackingInstaller
Compression=lzma
SolidCompression=yes

[Files]
Source: "D:\a\indoor-tracking-frontend-desktop\indoor-tracking-frontend-desktop\desktop\build\windows\x64\runner\Release\*"; DestDir: "{app}\"; Flags: ignoreversion

[Icons]
Name: "{group}\Indoor Tracking App"; Filename: "{app}\IndoorTrackingApp.exe"
Name: "{commondesktop}\Indoor Tracking App"; Filename: "{app}\IndoorTrackingApp.exe"

[Run]
Filename: "{app}\IndoorTrackingApp.exe"; Description: "Run Indoor Tracking App"; Flags: nowait postinstall skipifsilent