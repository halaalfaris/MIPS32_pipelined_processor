
def int_to_binary(num, num_bits):
    if num >= 0:

        binary = format(num, f'0{num_bits}b')
    else:

        binary = format((1 << num_bits) + num, f'0{num_bits}b')

    return binary

def assemble(inp):
  parts = inp.split()
  opcode = parts[0]
  rtype = ['add','sub','and','or','xor', 'xnor', 'sll', 'srl', 'addu', 'subu']
  itype = {'sw':'000001', 'lw':'000010', 'addi':'000011', 'andi':'000100', 'ori':'000101', 'beq':'000110', 'bne':'000111', 'bge':'001000', 'bgt':'001001', 'ble':'001010', 'blt':'001011', 'jal':'001101'}
  jtype = {'jump': '001100', 'jr':'001110'}
  if opcode in rtype:
    _,  src1, src2, dest = parts
    opcode_binary = format(0b000000,'06b')
    src1_binary = format(int(src1[1:]), '05b')
    src2_binary = format(int(src2[1:]), '05b')
    dest_binary = format(int(dest[1:]), '05b')
    shamt = format(0b00000, '05b')
    funct = format({'add': 0b000, 'sub': 0b001, 'and': 0b010, 'or': 0b011, 'xor': 0b100, 'xnor': 0b101, 'sll': 0b110, 'srl': 0b111, 'addu': 0b1110, 'subu': 0b1111}[opcode], '06b')
    machine_code = f"{opcode_binary}{src1_binary}{src2_binary}{dest_binary}{shamt}{funct}"
    return machine_code

  elif opcode in itype:
    _,  src1, dest, imm = parts
    opcode_binary = itype[opcode]
    src1_binary = format(int(src1[1:]), '05b')
    dest_binary = format(int(dest[1:]), '05b')
    imm_binary = int_to_binary(int(imm), 16)
    machine_code = f"{opcode_binary}{src1_binary}{dest_binary}{imm_binary}"
    return machine_code
  elif opcode in jtype:
    if opcode == 'jump':
      _,  imm = parts
      opcode_binary = jtype[opcode]
      imm_binary = int_to_binary(int(imm), 26)
      machine_code = f"{opcode_binary}{imm_binary}"
      return machine_code
    else:
      _,  src1 = parts
      opcode_binary = jtype[opcode]
      src1_binary = format(int(src1[1:]), '05b')
      padding = format(0b0, '021b')
      machine_code = f"{opcode_binary}{src1_binary}{padding}"
      return machine_code
  else:
    return 'instruction not found'

file_path = '/content/sample_data/testcode.txt' #adjustable

i = 0
with open(file_path, 'r') as file:

    for line in file:
      print(f"Imemory[{i}] = 32'b{assemble(line)};")
      i += 1
