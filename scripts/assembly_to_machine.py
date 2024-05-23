import inst_compile
import argparse
if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='RISC-V instruction compile')
    parser.add_argument('--assembly', type=str, help='generate assembly code')
    parser.add_argument('--out', type=str, help='outfile name')
    args = parser.parse_args()

    file_r = open('./'+args.assembly+'.txt','r')
    file_w = open('./'+args.out+'.txt','w')

    for line in file_r.readlines():
        x = line[:-1]
        machine_hex = inst_compile.assembly_to_machine(x)
        file_w.write(machine_hex+'\n')
    
    file_r.close()
    file_w.close()

    

