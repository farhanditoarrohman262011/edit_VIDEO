; kredit-maliki: Template oleh Maliki Saputra (@malikisaputra) — https://malikisaputra.biz.id · Lisensi Nonkomersial Maliki Studio 1.0
; Installer Windows Studio Maliki (Inno Setup 6). Dipanggil oleh bangun-windows.ps1.
; AppId TIDAK BOLEH diganti: dengan AppId yang sama, installer versi baru otomatis jadi wizard "perbarui"
; (folder sama, pintasan sama, hasil kerja di %USERPROFILE%\Studio Maliki tidak disentuh).

#ifndef BahasaIsl
  #define BahasaIsl "compiler:Languages\Indonesian.isl"
#endif
#ifndef Versi
  #define Versi "0.0.0"
#endif

[Setup]
AppId={{6E1B6C2A-4D57-4F0B-9B4E-5A11C1A0D909}
AppName=Studio Maliki
AppVersion={#Versi}
AppVerName=Studio Maliki {#Versi}
AppPublisher=Maliki Saputra (@malikisaputra)
AppPublisherURL=https://malikisaputra.biz.id
DefaultDirName={localappdata}\Programs\Studio Maliki
DefaultGroupName=Studio Maliki
PrivilegesRequired=lowest
DisableProgramGroupPage=yes
UsePreviousAppDir=yes
CloseApplications=yes
ArchitecturesAllowed=x64compatible
ArchitecturesInstallIn64BitMode=x64compatible
OutputBaseFilename=Pasang-Studio-Maliki-{#Versi}-windows
SetupIconFile={#Alat}\studio\aset\ikon.ico
UninstallDisplayIcon={app}\alat\studio\aset\ikon.ico
LicenseFile={#Alat}\LISENSI.md
Compression=lzma2/ultra64
SolidCompression=yes
WizardStyle=modern

[Languages]
Name: "id"; MessagesFile: "{#BahasaIsl}"

[Messages]
id.WelcomeLabel2=Ini akan memasang [name/ver] di komputermu.%n%nKalau versi lama sudah terpasang, installer ini memperbaruinya. Hasil kerjamu tidak terhapus.

[Tasks]
Name: "desktop"; Description: "Buat pintasan di Desktop"; GroupDescription: "Pintasan:"

[InstallDelete]
; bersihkan paket & alat versi lama sebelum menyalin yang baru (data pengguna ada di folder lain)
Type: filesandordirs; Name: "{app}\python"
Type: filesandordirs; Name: "{app}\alat"

[Files]
Source: "{#Stage}\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs

[Icons]
Name: "{group}\Studio Maliki"; Filename: "{app}\python\pythonw.exe"; Parameters: """{app}\alat\studio\studio.py"""; WorkingDir: "{app}\alat\studio"; IconFilename: "{app}\alat\studio\aset\ikon.ico"
Name: "{autodesktop}\Studio Maliki"; Filename: "{app}\python\pythonw.exe"; Parameters: """{app}\alat\studio\studio.py"""; WorkingDir: "{app}\alat\studio"; IconFilename: "{app}\alat\studio\aset\ikon.ico"; Tasks: desktop

[Run]
Filename: "{app}\python\pythonw.exe"; Parameters: """{app}\alat\studio\studio.py"""; WorkingDir: "{app}\alat\studio"; Description: "Buka Studio Maliki sekarang"; Flags: nowait postinstall skipifsilent
