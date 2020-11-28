module data_path #(
    parameter   PC_W = 8,           // Program Counter
    parameter   INS_W = 32,         // Instruction Width
    parameter   RF_ADDRESS = 5,     // Register File Address
    parameter   DATA_W = 32,        // Data WriteData
    parameter   DM_ADDRESS  = 9,    // Data Memory Address
    parameter   ALU_CC_W = 4        // ALU Control Code Width
)(
    input                   clk,        // CLK in Datapath figure
    input                   reset,      // Reset in Datapath figure
    input                   reg_write,   // RegWrite
    input                   mem2reg,    // MemtoReg in Datapath figure
    input                   alu_src,    // ALUSrc in Datapath figure
    input                   mem_write,  // MemWrite in Datapath figure
    input                   mem_read,   // MemRead in Datapath figure
    input   [ALU_CC_W-1:0]  alu_cc,     // ALUCC in Datapath figure
    output           [6:0]  opcode,     // opcode in Datapath figure
    output           [6:0]  funct7,     // Funct7 in Datapath figure
    output           [2:0]  funct3,     // Funct3 in Datapath figure
    output    [DATA_W-1:0]  alu_result  // Datapath_result in Datapath figure
);

    // Define the Datapath behavior here

    // Create the wires that will be used to connect the modules
    wire [PC_W -1:0]    PC , PCPlus4;
    wire [INS_W -1:0]   Instruction;
    wire [DATA_W -1:0]  ALU_Result;
    wire [DATA_W -1:0]  Reg1 , Reg2;
    wire [DATA_W -1:0]  DataMem_read;
    wire [DATA_W -1:0]  WriteBack_Data;
    wire [DATA_W -1:0]  SrcB ;
    wire [DATA_W -1:0]  ExtImm;

    // Use PC + 4 to act as the Half Adder
    assign  PCPlus4 = PC + 4;
    
    // Initialize the Flip Flop module
    FlipFlop   pcreg(clk , reset , PCPlus4 , PC);

    // Initialize the Instruction Memory module
    InstMem  instruction_mem (PC , Instruction );

    // Assign the opcode, funct7, and funct3 wires
    assign  opcode = Instruction [6:0];
    assign  funct7 = Instruction [31:25];
    assign  funct3 = Instruction [14:12];

    // Initialize the Register File module
    RegFile  rf(
        .clk            ( clk                   ),
        .reset          ( reset                 ),
        .rg_wrt_en      ( reg_write             ),
        .rg_wrt_addr    ( Instruction [11:7]    ),
        .rg_rd_addr1    ( Instruction [19:15]   ),
        .rg_rd_addr2    ( Instruction [24:20]   ),
        .rg_wrt_data    ( WriteBack_Data         ),
        .rg_rd_data1    ( Reg1                  ),
        .rg_rd_data2    ( Reg2                  )
    );

    // Assign the Write Back Data wire
    assign  WriteBack_Data = mem2reg ? DataMem_read : ALU_Result;

    // Initialize the Immediate Generator module
    ImmGen  ext_imm (Instruction , ExtImm );

    // Assign the SrcB wire
    assign  SrcB = alu_src ? ExtImm : Reg2;
    
    // Initialize the ALU module
    ALU  alu_module( .A_in(Reg1), .B_in(SrcB), .ALU_Sel(alu_cc),
    .ALU_Out(ALU_Result), .Carry_Out(), .Zero(), .Overflow ());

    // Assign the ALU Result wire
    assign  alu_result = ALU_Result;

    // Initializethe Data Memory wire
    DataMem  data_mem(.addr(ALU_Result[DM_ADDRESS -1:2]) , .read_data(DataMem_read),
    .write_data(Reg2), .MemWrite(mem_write), .MemRead(mem_read) );

endmodule   // Datapath
