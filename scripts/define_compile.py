import re 

def opcode_compile(x:str):
    opcode_dict = {
        'lui': '0110111',
        'auipc': '0010111',
        'jal': '1101111',
        'jalr': '1100111',
        'beq': '1100011',
        'bne': '1100011',
        'blt': '1100011',
        'bge': '1100011',
        'bltu': '1100011',
        'bgeu': '1100011',
        'lb': '0000011',
        'lh': '0000011',
        'lw': '0000011',
        'lbu': '0000011',
        'lhu': '0000011',
        'sb': '0100011',
        'sh': '0100011',
        'sw': '0100011',
        'addi': '0010011',
        'slti': '0010011',
        'sltiu': '0010011',
        'xori': '0010011',
        'ori': '0010011',
        'andi': '0010011',
        'slli': '0010011',
        'srli': '0010011',
        'srai': '0010011',
        'add': '0110011',
        'sub': '0110011',
        'sll': '0110011',
        'slt': '0110011',
        'sltu': '0110011',
        'xor': '0110011',
        'srl': '0110011',
        'sra': '0110011',
        'or': '0110011',
        'and': '0110011'
    }

    instruction = re.match(r'\w+', x).group()
    return opcode_dict.get(instruction.lower(), 'Unknown instruction')

def funct3_compile(x:str):
    funct3_dict = {
        'add': '000',
        'sub': '000',
        'sll': '001',
        'slt': '010',
        'sltu': '011',
        'xor': '100',
        'srl': '101',
        'sra': '101',
        'or': '110',
        'and': '111',
        'jalr': '000',
        'beq': '000',
        'bne': '001',
        'blt': '100',
        'bge': '101',
        'bltu': '110',
        'bgeu': '111',
        'lb': '000',
        'lh': '001',
        'lw': '010',
        'lbu': '100',
        'lhu': '101',
        'addi': '000',
        'slti': '010',
        'sltiu': '011',
        'xori': '100',
        'ori': '110',
        'andi': '111',
        'slli': '001',
        'srli': '101',
        'srai': '101',
    }

    instruction = re.match(r'\w+', x).group()
    return funct3_dict.get(instruction.lower(), 'Unknown instruction')

def instruction_type(x:str):
    type_dict = {
        'lui': 'U',
        'auipc': 'U',
        'jal': 'J',
        'jalr': 'I',
        'beq': 'B',
        'bne': 'B',
        'blt': 'B',
        'bge': 'B',
        'bltu': 'B',
        'bgeu': 'B',
        'lb': 'I',
        'lh': 'I',
        'lw': 'I',
        'lbu': 'I',
        'lhu': 'I',
        'sb': 'S',
        'sh': 'S',
        'sw': 'S',
        'addi': 'I',
        'slti': 'I',
        'sltiu': 'I',
        'xori': 'I',
        'ori': 'I',
        'andi': 'I',
        'slli': 'I',
        'srli': 'I',
        'srai': 'I',
        'add': 'R',
        'sub': 'R',
        'sll': 'R',
        'slt': 'R',
        'sltu': 'R',
        'xor': 'R',
        'srl': 'R',
        'sra': 'R',
        'or': 'R',
        'and': 'R'
    }

    instruction = re.match(r'\w+', x).group()
    return type_dict.get(instruction.lower(), 'Unknown instruction')


def bin2hex(binary, num_bits):
    hex_num = hex(int(binary, 2))[2:]  # 将二进制数转换为十六进制数
    return hex_num.zfill(num_bits // 4)  # 确保结果有足够的位数

