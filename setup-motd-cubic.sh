#!/bin/bash

# Langsung tulis ke /etc/motd
cat << "EOF" | tee /etc/motd > /dev/null
██████╗░██╗░░░██╗███╗░░██╗███████╗██╗░░░░░██╗░░░██╗██╗░░██╗░█████╗░░██████╗
██╔══██╗██║░░░██║████╗░██║██╔════╝██║░░░░░██║░░░██║╚██╗██╔╝██╔══██╗██╔════╝
██████╔╝██║░░░██║██╔██╗██║█████╗░░██║░░░░░██║░░░██║░╚███╔╝░██║░░██║╚█████╗░
██╔══██╗██║░░░██║██║╚████║██╔══╝░░██║░░░░░██║░░░██║░██╔██╗░██║░░██║░╚═══██╗
██║░░██║╚██████╔╝██║░╚███║██║░░░░░███████╗╚██████╔╝██╔╝╚██╗╚█████╔╝██████╔╝
╚═╝░░╚═╝░╚═════╝░╚═╝░░╚══╝╚═╝░░░░░╚══════╝░╚═════╝░╚═╝░░╚═╝░╚════╝░╚═════╝░

                    Selamat Datang di **RunfluxOS** Remastered                    
                     Sistem Operasi Ringan, Stabil, Modern                    

                ------------------------------------------------
                      Nama  : Ardhan Dikri Achmad Fahrudin
                      NIM   : 244107020012
                      Kelas : Teknik Informatika 1F
                ------------------------------------------------
EOF

if ! grep -Fxq "cat /etc/motd" ~/.bashrc; then
    echo "cat /etc/motd" >> ~/.bashrc
    echo "MOTD berhasil ditambahkan ke .bashrc!"
else
    echo "cat /etc/motd sudah ada di .bashrc, tidak perlu ditambah lagi."
fi

echo "Selesai. Buka terminal baru untuk melihat hasilnya."

echo "MOTD berhasil diperbarui!"
