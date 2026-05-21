# Windows RDP over Cloudflare Tunnel (Zero Trust)

Repositori ini berisi skrip otomatisasi dan panduan untuk mengonfigurasi akses Remote Desktop Protocol (RDP) pada komputer Windows secara aman melalui Cloudflare Tunnel (Zero Trust) untuk diakses dari perangkat Android atau perangkat luar lainnya tanpa membuka port router (Port Forwarding).

## File dalam Repositori
* `install_cloudflared.ps1` - Skrip PowerShell untuk mengunduh versi standalone `cloudflared.exe` secara otomatis ke dalam direktori kerja.
* `.gitignore` - Mengabaikan file biner besar (`cloudflared.exe`) dan skrip konfigurasi lokal sensitif (`create_service.bat`) agar tidak terunggah ke publik.

---

## Langkah Setup Cepat

### 1. Unduh Binary Cloudflared
Buka PowerShell (non-administrator) pada folder ini, lalu jalankan:
```powershell
powershell -ExecutionPolicy Bypass -File .\install_cloudflared.ps1
```
Skrip ini akan mengunduh `cloudflared.exe` terbaru secara otomatis.

### 2. Dapatkan Token Tunnel
1. Buka [Cloudflare Zero Trust Dashboard](https://one.dash.cloudflare.com/).
2. Masuk ke **Networks > Connectors > Tunnels** lalu buat tunnel baru.
3. Pilih **Windows**, dan salin token tunnel (string acak panjang di akhir perintah install service).

### 3. Buat dan Jalankan Service di Windows
Jalankan file batch `create_service.bat` dengan hak akses **Administrator** untuk menghapus service yang lama (jika ada), membuat service baru dengan token Anda, dan langsung menjalankannya.

Skrip ini dijalankan otomatis oleh helper dengan perintah dasar:
```cmd
sc create Cloudflared binPath= "C:\path\ke\cloudflared.exe tunnel run --token TOKEN_ANDA" start= auto
sc start Cloudflared
```

### 4. Konfigurasi Routing & Client (HP Android)
Detail konfigurasi routing IP lokal (**Split Tunnels**) dan login aplikasi **Cloudflare One (WARP)** di Android dapat dibaca pada file panduan [walkthrough.md](file:///C:/Users/Setiaji/.gemini/antigravity/brain/9d96d9bb-f49e-4e74-9252-877558df8737/walkthrough.md).
