
#!/bin/bash

# Variables
ISO_PATH="$HOME/iso/SnowCrash.iso"
DISK_PATH="$HOME/iso/snowcrash_disk.qcow2"
DISK_SIZE="4G"
RAM="2G"
CPUS=2
HOST_PORT=4242
GUEST_PORT=4242

# Crée le dossier si nécessaire
mkdir -p "$(dirname "$ISO_PATH")"

# Vérifie que l'ISO existe
if [ ! -f "$ISO_PATH" ]; then
    echo "Erreur : ISO non trouvée à $ISO_PATH"
    exit 1
fi

# Crée le disque virtuel si il n'existe pas
if [ ! -f "$DISK_PATH" ]; then
    echo "Création du disque virtuel $DISK_PATH ($DISK_SIZE)"
    qemu-img create -f qcow2 "$DISK_PATH" "$DISK_SIZE"
fi

# Lance QEMU
echo "Lancement de SnowCrash..."
qemu-system-x86_64 \
  -m "$RAM" \
  -smp "$CPUS" \
  -boot d \
  -cdrom "$ISO_PATH" \
  -hda "$DISK_PATH" \
  -net nic \
  -net user,hostfwd=tcp::${HOST_PORT}-:${GUEST_PORT}
