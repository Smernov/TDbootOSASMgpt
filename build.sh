#!/bin/bash

# Компиляция boot.asm в boot.bin
nasm -f bin boot.asm -o boot.bin

# Создание загрузочного образа ISO с использованием isolinux
mkdir -p iso/boot/grub
cp boot.bin iso/boot/grub/

# Создание конфигурационного файла для GRUB
echo "set timeout=0" > iso/boot/grub/grub.cfg
echo "set default=0" >> iso/boot/grub/grub.cfg
echo "menuentry 'My OS' {" >> iso/boot/grub/grub.cfg
echo "    multiboot /boot/grub/boot.bin" >> iso/boot/grub/grub.cfg
echo "    boot" >> iso/boot/grub/grub.cfg
echo "}" >> iso/boot/grub/grub.cfg

# Создание ISO-образа
grub-mkrescue -o myos.iso iso/

echo "ISO создан и сохранен как myos.iso"
