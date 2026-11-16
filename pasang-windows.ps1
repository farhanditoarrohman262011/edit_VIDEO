# Installer Studio Maliki untuk Windows 10/11.
# Dijalankan oleh "Pasang Studio Maliki (Windows).bat". Memasang uv (kalau belum ada), dependensi Klip,
# Motion (kalau Node.js ada), lalu membuat pintasan "Studio Maliki" di Desktop dan Start Menu.
$ErrorActionPreference = "Stop"
$Alat = Split-Path -Parent $PSScriptRoot
$env:Path = "$env:USERPROFILE\.local\bin;$env:Path"

Write-Host ""
Write-Host "  Memasang Studio Maliki (Klip + Motion)" -ForegroundColor Cyan
Write-Host ""

# 1) uv — pengelola Python resmi dari Astral (astral.sh/uv)
if (-not (Get-Command uv -ErrorAction SilentlyContinue)) {
  Write-Host "- Memasang uv..."
  powershell -ExecutionPolicy ByPass -NoProfile -Command "irm https://astral.sh/uv/install.ps1 | iex"
  $env:Path = "$env:USERPROFILE\.local\bin;$env:Path"
}
Write-Host "- uv siap: $(uv --version)"

# 2) Jendela aplikasi (komponen lain dipasang lewat wizard di dalam Studio)
Write-Host "- Menyiapkan jendela aplikasi..."
uv sync -q --script "$Alat\studio\studio.py"

# 4) Pintasan (uvw.exe = uv tanpa jendela konsol)
$Uvw = (Get-Command uvw -ErrorAction SilentlyContinue).Source
if (-not $Uvw) { $Uvw = "$env:USERPROFILE\.local\bin\uvw.exe" }
$Wsh = New-Object -ComObject WScript.Shell
$Tujuan = @(
  [Environment]::GetFolderPath("Desktop"),
  (Join-Path ([Environment]::GetFolderPath("Programs")) "")
)
foreach ($Folder in $Tujuan) {
  $Lnk = $Wsh.CreateShortcut((Join-Path $Folder "Studio Maliki.lnk"))
  $Lnk.TargetPath = $Uvw
  $Lnk.Arguments = "run -q --gui-script `"$Alat\studio\studio.py`""
  $Lnk.WorkingDirectory = "$Alat\studio"
  $Lnk.IconLocation = "$Alat\studio\aset\ikon.ico"
  $Lnk.Description = "Studio Maliki - Klip & Motion"
  $Lnk.Save()
}

Write-Host ""
Write-Host "Selesai! Buka 'Studio Maliki' dari Desktop atau Start Menu." -ForegroundColor Green
Write-Host "Hasil kerja tersimpan di: $env:USERPROFILE\Studio Maliki"
Write-Host "Kalau folder alat ini dipindah, jalankan installer ini lagi."
Start-Process $Uvw -ArgumentList "run -q --gui-script `"$Alat\studio\studio.py`"" -WorkingDirectory "$Alat\studio"
