import inst_compile
import argparse
if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='RISC-V instruction compile')
    parser.add_argument('--machine', type=str, help='generate assembly code')
    parser.add_argument('--out', type=str, help='outfile name')
    args = parser.parse_args()

    file_r = open('./'+args.machine+'.txt','r')
    file_w = open('./'+args.out+'.txt','w')

    for line in file_r.readlines():
        x = line[:-1]
        assembly = inst_compile.machine_to_assembly(inst_compile.hex2bin(x,32))
        
        file_w.write(assembly+'\n')
    
    file_r.close()
    file_w.close()

    

