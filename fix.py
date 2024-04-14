import os

print("Solucionador error 0x80070643 de Windows 10")
print("Este script es gracias a la solución dada por GAMING URUGUAY en su canal de Youtube")

os.system("reagentc /info")
os.system("reagentc /disable")
os.system("diskpart")
os.system("list disk")

check_disco = False
while not check_disco:
    disco = input("Indique el número del disco: ")
    try:
        disco = int(disco)
        os.system(f"sel disk {disco}")
        check_disco = True
    except ValueError:
        print("Por favor, ingrese un número válido.")

os.system("list part")

check_part = False
while not check_part:
    part = input("Indique la partición Principal: ")
    try:
        part = int(part)
        os.system(f"sel part {part}")
        check_part = True
    except ValueError:
        print("Por favor, ingrese un número válido.")

os.system("shrink desired=250 minimum=250")
os.system("list partition")

check_recuperacion = False
while not check_recuperacion:
    recuperacion = input("Indique la partición de Recuperación: ")
    try:
        recuperacion = int(recuperacion)
        os.system(f"sel part {recuperacion}")
        check_recuperacion = True
    except ValueError:
        print("Por favor, ingrese un número válido.")

os.system("delete partition override")
os.system("list part")
os.system("list disk")

tipo_disco = None
while tipo_disco is None:
    tipo = input("1-Mecánico 2-M.2: ")
    if tipo == "1":
        tipo_disco = True
        os.system("create partition primary id=27")
    elif tipo == "2":
        tipo_disco = True
        os.system(
            "create partition primary id=de94bba4-06d1-4d40-a16a-bfd50179d6ac")
        os.system("gpt attributes =0x8000000000000001")
    else:
        print("Opción no disponible")

os.system("format quick fs=ntfs label=\"Windows RE tools\"")
os.system("list part")
os.system("list vol")
os.system("exit")
os.system("reagentc /enable")
os.system("reagentc /info")

print("Equipo Reparado")
