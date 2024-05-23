import re
import argparse
def assembly_split(assembly):
    x = assembly.replace(', ',' ')
    x = x.replace(')','')
    x = re.split(' |\(',x)
    return x

def bin2hex(binary, num_bits):
    hex_num = hex(int(binary, 2))[2:]  # 将二进制数转换为十六进制数
    return hex_num.zfill(num_bits // 4)  # 确保结果有足够的位数

def hex2bin(hex_num, num_bits):
    binary = bin(int(hex_num, 16))[2:]  # 将十六进制数转换为二进制数
    return binary.zfill(num_bits)  # 确保结果有足够的位数

def reverse_string(s):
    return s[::-1]


def assembly_to_machine(assembly):
    # resister define 
    registers = {"x"+str(i): i for i in range(32)}
    # opcode
    opcodes = {
        "lui":      "0110111",
        "auipc":    "0010111",
        "jal":      "1101111", 
        "jalr":     "1100111",

        "beq":      "1100011", 
        "bne":      "1100011", 
        "blt":      "1100011", 
        "bge":      "1100011", 
        "bltu":     "1100011", 
        "bgeu":     "1100011", 
        
        "lb":       "0000011", 
        "lh":       "0000011", 
        "lw":       "0000011", 
        "lbu":      "0000011", 
        "lhu":      "0000011", 
        
        "sb":       "0100011", 
        "sh":       "0100011", 
        "sw":       "0100011", 
        
        "addi":     "0010011", 
        "slti":     "0010011", 
        "sltiu":    "0010011", 
        "xori":     "0010011", 
        "ori":      "0010011", 
        "andi":     "0010011", 
        "slli":     "0010011", 
        "srli":     "0010011", 
        "srai":     "0010011", 
        
        "add":      "0110011", 
        "sub":      "0110011", 
        "sll":      "0110011", 
        "slt":      "0110011", 
        "sltu":     "0110011", 
        "xor":      "0110011", 
        "srl":      "0110011", 
        "sra":      "0110011", 
        "or":       "0110011", 
        "and":      "0110011",
        "mul":      "0110011",
        "mulh":     "0110011",
        "mulhsu":   "0110011",
        "mulhu":    "0110011",
        "div":      "0110011",
        "divu":     "0110011",
        "rem":      "0110011",
        "remu":     "0110011",

        "fence":    "0001111",
        "fence.i":  "0001111",

        "ecall":    "1110011",
        "ebreak":   "1110011",
        "csrrw":    "1110011",
        "csrrs":    "1110011",
        "csrrc":    "1110011",
        "csrrwi":   "1110011",
        "csrrsi":   "1110011",
        "csrrci":   "1110011",

        "if":       "0101111",
        "rT":       "0101111",
        "sID":      "0101111"

        }
    # formats: R, I, S, B, U, J, F(fence), L(load), C(csr)
    formats = {
        "lui":      "U", 
        "auipc":    "U", 
        "jal":      "J", 
        "jalr":     "I", 
        "beq":      "B", 
        "bne":      "B", 
        "blt":      "B", 
        "bge":      "B", 
        "bltu":     "B", 
        "bgeu":     "B", 
        "lb":       "L", 
        "lh":       "L", 
        "lw":       "L", 
        "lbu":      "L", 
        "lhu":      "L", 
        "sb":       "S", 
        "sh":       "S", 
        "sw":       "S", 
        "addi":     "I", 
        "slti":     "I", 
        "sltiu":    "I", 
        "xori":     "I", 
        "ori":      "I", 
        "andi":     "I", 
        "slli":     "I", 
        "srli":     "I", 
        "srai":     "I", 
        "add":      "R", 
        "sub":      "R", 
        "sll":      "R", 
        "slt":      "R", 
        "sltu":     "R", 
        "xor":      "R", 
        "srl":      "R", 
        "sra":      "R", 
        "or":       "R", 
        "and":      "R",
        "mul":      "R",
        "mulh":     "R",
        "mulhsu":   "R",
        "mulhu":    "R",
        "div":      "R",
        "divu":     "R",
        "rem":      "R",
        "remu":     "R",

        "fence":    "F",
        "fence.i":  "F",
        "ecall":    "csr",
        "ebreak":   "csr",
        "csrrw":    "csr",
        "csrrs":    "csr",
        "csrrc":    "csr",
        "csrrwi":   "csr",
        "csrrsi":   "csr",
        "csrrci":   "csr",

        # added instructions 
        "if":       "N",
        "rT":       "N",
        "sID":       "N",

        }

    funct3s = {
        "add":    "000", 
        "sub":    "000", 
        "sll":    "001", 
        "slt":    "010", 
        "sltu":   "011", 
        "xor":    "100", 
        "srl":    "101", 
        "sra":    "101", 
        "or":     "110", 
        "and":    "111", 

        "mul":    "000",
        "mulh":   "001",
        "mulhsu": "010",
        "mulhu":  "011",
        "div":    "100",
        "divu":   "101",
        "rem":    "110",
        "remu":   "111",

        "lb":     "000", 
        "lh":     "001", 
        "lw":     "010", 
        "lbu":    "100", 
        "lhu":    "101", 
        "sb":     "000", 
        "sh":     "001", 
        "sw":     "010", 
        "beq":    "000", 
        "bne":    "001", 
        "blt":    "100", 
        "bge":    "101", 
        "bltu":   "110", 
        "bgeu":   "111", 
        "addi":   "000", 
        "slti":   "010", 
        "sltiu":  "011", 
        "xori":   "100", 
        "ori":    "110", 
        "andi":   "111", 
        "slli":   "001", 
        "srli":   "101", 
        "srai":   "101",
        "jalr":   "000",
        "fence":  "000",
        "fence.i":"001",
        "ecall":  "000",
        "ebreak": "000",
        "csrrw":  "001",
        "csrrs":  "010",
        "csrrc":  "011",
        "csrrwi": "101",
        "csrrsi": "110",
        "csrrci": "111",

        # added instruction
        "if":     "010",
        "rT":     "001",
        "sID":    "000"

        }
    
    funct7s = {
        # Itype: slli, srli, srai
        "slli":   "0000000",
        "srli":   "0000000",
        "srai":   "0100000",
        # Rtype: add, sub, sll, slt, sltu, xor, srl, sra, or, and
        "add":    "0000000",
        "sub":    "0100000",
        "sll":    "0000000",
        "slt":    "0000000",
        "sltu":   "0000000",
        "xor":    "0000000",
        "srl":    "0000000",
        "sra":    "0100000",
        "or":     "0000000",
        "and":    "0000000",
        # Rtype: 
        "mul":    "0000001",
        "mulh":   "0000001",
        "mulhsu": "0000001",
        "mulhu":  "0000001",
        "div":    "0000001",
        "divu":   "0000001",
        "rem":    "0000001",
        "remu":   "0000001"

        }
    
    funct12_e = {
        "ecall":  "000000000000",
        "ebreak": "000000000001"
    }

    # 解析汇编代码
    parts = assembly_split(assembly)
    
    opcode = opcodes[parts[0]]
    format = formats[parts[0]]

    # 根据格式进行转换
    if format == "R":
        rd = "{:05b}".format(registers[parts[1]])
        rs1 = "{:05b}".format(registers[parts[2]])
        rs2 = "{:05b}".format(registers[parts[3]])
        funct3 = funct3s[parts[0]]
        funct7 = funct7s[parts[0]]
        machine = funct7 + rs2 + rs1 + funct3 + rd + opcode
    
    elif format == "L":
        rd = "{:05b}".format(registers[parts[1]])
        funct3 = funct3s[parts[0]]
        rs1 = "{:05b}".format(registers[parts[3]])
        imm = "{:012b}".format(int(parts[2]))
        machine = imm + rs1 + funct3 + rd + opcode

    elif format == "I":
        rd = "{:05b}".format(registers[parts[1]])
        funct3 = funct3s[parts[0]]
        if parts[0] in ['addi', 'slti', 'sltiu', 'xori', 'ori', 'andi', 'slli', 'srli', 'srai', 'jalr']:
            rs1 = "{:05b}".format(registers[parts[2]])
            imm = "{:012b}".format(int(parts[3]))
        elif parts[0] in ['slli', 'srli', 'srai']:
            rs1 = "{:05b}".format(registers[parts[2]])
            imm = funct7s[parts[0]] + "{:05b}".format(int(parts[3]))
        else:
            # to-do: add fence ~ csrrci
            print('Error!')
        machine = imm + rs1 + funct3 + rd + opcode

    elif format == "S":
        rs1 = "{:05b}".format(registers[parts[3]])
        rs2 = "{:05b}".format(registers[parts[1]])
        imm = "{:012b}".format(int(parts[2]))
        funct3 = funct3s[parts[0]]
        machine = imm[0:7] + rs2 + rs1 + funct3 + imm[7:] + opcode

    elif format == "B":
        rs1 = "{:05b}".format(registers[parts[1]])
        rs2 = "{:05b}".format(registers[parts[2]])
        imm = "{:013b}".format(int(parts[3]))
        funct3 = funct3s[parts[0]]
        machine = imm[0] + imm[2:8] + rs2 + rs1 + funct3 + imm[8:12] + imm[1] + opcode
    elif format == "U":
        rd = "{:05b}".format(registers[parts[1]])
        imm = "{:020b}".format(int(parts[2]))
        machine = imm + rd + opcode
    elif format == "J":
        rd = "{:05b}".format(registers[parts[1]])
        imm = "{:021b}".format(int(parts[2]))
        machine = imm[0] + imm[10:20] + imm[9] + imm[1:9] + rd + opcode
    elif format == "F":
        if parts[0] == 'fence.i':
            machine = 17*'0' +  funct3s[parts[0]] + 5*'0' + opcode
        else:
            return None
    elif format == 'csr':
        if parts[0] in ['ecall', 'ebreak']:
            machine = funct12_e[parts[0]] + 13* '0' + opcode
        elif parts[0] in ['csrrw', 'csrrs', 'csrrc']:
            rd = "{:05b}".format(registers[parts[1]])
            csr = "{:012b}".format(int(parts[2]))
            rs1 = "{:05b}".format(registers[parts[3]])
            machine = csr + rs1 + funct3s[parts[0]] + rd + opcode
        elif parts[0] in ['csrrwi', 'csrrsi', 'csrrci']:
            rd = "{:05b}".format(registers[parts[1]])
            csr = "{:012b}".format(int(parts[2]))
            
            zimm = "{:05b}".format(int(parts[3]))
            machine = csr + zimm + funct3s[parts[0]] + rd + opcode
        else:
            return None
    elif format == 'N':
        rd = "{:05b}".format(registers[parts[1]])
        funct3 = funct3s[parts[0]]
        
        rs1 = "{:05b}".format(registers[parts[2]])
        imm = "{:012b}".format(int(parts[3]))
        
        machine = imm + rs1 + funct3 + rd + opcode 
    else:
        return None
    # 转换为16进制
    machine = "{:08x}".format(int(machine, 2))
    return machine


def machine_to_assembly(machine):
    opcode = machine[25:32]
    rd = machine[20:25]
    funct3 = machine[17:20]
    funct7 = machine[0:7]
    shamt = machine[7:12]
    rs1 = machine[12:17]
    rs2 = machine[7:12]

    imm_I = machine[0:12]
    imm_L = machine[0:12]
    imm_S = machine[0:7]+machine[20:25]
    imm_U = machine[0:20]
    imm_B = machine[0]+machine[24]+machine[1:7]+machine[20:24] + '0'
    imm_J = machine[0]+machine[12:20]+machine[11]+machine[1:11] + '0'
    
    opcodes = {
        '0110111':  'lui',
        '0010111':  'auipc',
        '1101111':  'jal',
        '1100111':  'jalr',

        '1100011':  'B',
        '0000011':  'L',
        '0100011':  'S',
        '0010011':  'I',
        '0110011':  'R',

        '0001111':  'fence.i',

        '1110011':  'csr',
        '0101111':  'N'
    }

    funct_R = {
        '0000000000': 'add',
        '0100000000': 'sub',
        '0000000001': 'sll',
        '0000000010': 'slt',
        '0000000011': 'sltu',
        '0000000100': 'xor',
        
        '0000000101': 'srl',
        '0100000101': 'sra',
        
        '0000000110': 'or',
        '0000000111': 'and',

        '0000001000': 'mul',
        '0000001001': 'mulh',
        '0000001010': 'mulhsu',
        '0000001011': 'mulhu',
        '0000001100': 'div',
        '0000001101': 'divu',
        '0000001110': 'rem',
        '0000001111': 'remu'
    }


    funct3_I = {
        '000': 'addi',
        '010': 'slti',
        '011': 'sltiu',
        '100': 'xori',
        '110': 'ori',
        '111': 'andi'
    }

    funct_I_shift = {
        '0000000001': 'slli',
        '0000000101': 'srli',
        '0100000101': 'srai'
    }

    funct3_S = {
        '000': 'sb',
        '001': 'sh',
        '010': 'sw'
    }

    funct_3_L = { 
        '000': 'lb',
        '001': 'lh',
        '010': 'lw',
        '100': 'lbu',
        '101': 'lhu'
    }    

    funct3_B = {
        '000': 'beq',
        '001': 'bne',
        '100': 'blt',
        '101': 'bge',
        '110': 'bltu',
        '111': 'bgeu'
    }

    funct3_fence = {
        '000': 'fence',
        '001': 'fence.i'
    }

    funct_3_csr = {
        '000': 'e',
        '001': 'csrrw', 
        '010': 'csrrs',
        '011': 'csrrc',
        '101': 'csrrwi',
        '110': 'csrrsi',
        '111': 'csrrci'
    }
    
    funct_3_N = {
        '000': 'sID',
        '001': 'rT',
        '010': 'if'
    }

    
    
    if opcodes[opcode] == 'jal':
        return 'jal x'+str(int(rd,2))+', '+str(int(imm_J,2))
    elif opcodes[opcode] == 'lui':
        return 'lui x'+str(int(rd,2))+', '+str(int(imm_U,2))
    elif opcodes[opcode] == 'auipc':
        return 'auipc x'+str(int(rd,2))+', '+str(int(imm_U,2))
    elif opcodes[opcode] == 'jalr':
        return 'jalr x'+str(int(rd,2))+', x'+str(int(rs1,2))+', '+str(int(imm_I,2))
    elif opcodes[opcode] == 'B':
        return funct3_B[funct3]+' x'+str(int(rs1,2))+', x'+str(int(rs2,2))+', '+str(int(imm_B,2))
    elif opcodes[opcode] == 'L':
        return funct_3_L[funct3]+' x'+str(int(rd,2))+', '+str(int(imm_L,2))+'(x'+str(int(rs1,2))+')'
    elif opcodes[opcode] == 'S':
        return funct3_S[funct3]+' x'+str(int(rs2,2))+', '+str(int(imm_S,2))+'(x'+str(int(rs1,2))+')'
    elif opcodes[opcode] == 'I':
        if funct3 in ['001', '101']: #slli, srli, srai
            return funct_I_shift[funct7+funct3]+' x'+str(int(rd,2))+', x'+str(int(rs1,2))+', '+str(int(imm_I,2))
        else:
            return funct3_I[funct3]+' x'+str(int(rd,2))+', x'+str(int(rs1,2))+', '+str(int(imm_I,2))
    elif opcodes[opcode] == 'R':
        return funct_R[funct7+funct3]+ ' x'+str(int(rd,2))+', x'+str(int(rs1,2))+', x'+str(int(rs2,2))
    elif opcodes[opcode] == 'fence.i':
        return funct3_fence[funct3]
    elif opcodes[opcode] == 'csr':
        if funct_3_csr[funct3] in ['csrrw', 'csrrs', 'csrrc']:
            csr = machine[0:12]
            return funct_3_csr[funct3]+' x'+str(int(rd,2))+', '+str(int(csr,2))+', x'+str(int(rs1,2))
        elif funct_3_csr[funct3] in ['csrrwi', 'csrrsi', 'csrrci']:
            csr = machine[0:12]
            zimm = machine[12:17]
            return funct_3_csr[funct3]+' x'+str(int(rd,2))+', '+str(int(csr,2))+', '+str(int(zimm,2))
        elif funct_3_csr[funct3] == 'e':
            if machine[0:12] == '000000000000':
                return 'ecall'
            elif machine[0:12] == '000000000001':
                return 'ebreak'
            else:
                return None
        else :
            return None            
    elif opcodes[opcode] == 'N':
        return funct_3_N[funct3]+' x'+str(int(rd,2))+', x'+str(int(rs1,2))+', '+str(int(imm_I,2))
    else:
        return None
    
if __name__ == "__main__": 
    
    parser = argparse.ArgumentParser(description='RISC-V instruction compile')
    parser.add_argument('--assembly', type=str, help='generate assembly code')
    parser.add_argument('--machine', type=str, help='generate machine code')
    parser.add_argument('--outfile', type=str, help='outfile name')
    args = parser.parse_args()
    
    # 测试
    test_file = open('input.txt', 'r')
    outfile1 = open('out_machine.txt', 'w')
    outfile2 = open('out_assembly.txt', 'w')
    for line in test_file.readlines():
        x = line[:-1]
        assemble_ori = x
        machine_hex = assembly_to_machine(x)
        outfile1.write(machine_hex+'\n')
        assemble_gen = machine_to_assembly(hex2bin(machine_hex,32))
        outfile2.write(assemble_gen+'\n')
        
    
    test_file.close()
    outfile1.close()
    outfile2.close()

    '''
    machine_hex = assembly_to_machine(assembly)
    print(machine_hex)
    machine_bin = hex2bin(machine_hex, 32)
    print(machine_bin[0])
    print(machine_bin)
    print(machine_to_assembly(machine_bin))
    '''
