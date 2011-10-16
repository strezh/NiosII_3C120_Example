//
// NOTE: this file is `included from either nios2_linux_3c120_125mhz_dev_top.v or nios2_linux_3c120_125mhz_qual_top.v
//

module nios2_linux_3c120_125mhz_top
(
    input           clkin_50,
    input           clkin_125,

    input           cpu_resetn,

    inout   [2:0]   ddr2_ck_n,
    inout   [2:0]   ddr2_ck_p,
    output  [8:0]   ddr2_dm,
    inout   [71:0]  ddr2_dq,
    inout   [8:0]   ddr2_dqs,

    output  [15:0]  ddr2bot_a,
    output          ddr2bot_active,
    output  [2:0]   ddr2bot_ba,
    output          ddr2bot_casn,
    output          ddr2bot_cke,
    output          ddr2bot_csn,
    output          ddr2bot_odt,
    output          ddr2bot_rasn,
    output          ddr2bot_wen,

`ifdef SYSTEM_TYPE_IS_DEVELOPMENT

    output  [15:0]  ddr2top_a,
    output          ddr2top_active,
    output  [2:0]   ddr2top_ba,
    output          ddr2top_casn,
    output          ddr2top_cke,
    output          ddr2top_csn,
    output          ddr2top_odt,
    output          ddr2top_rasn,
    output          ddr2top_wen,

`endif

    input           enet_led_link1000,
    output          enet_mdc,
    inout           enet_mdio,
    output          enet_resetn,
    input           enet_rx_clk,
    input           enet_rx_dv,
    input   [3:0]   enet_rxd,
    output          enet_gtx_clk,
    output          enet_tx_en,
    output  [3:0]   enet_txd,

    output          flash_cen,
    output          flash_oen,
    input           flash_rdybsyn,
    output          flash_resetn,
    output          flash_wen,
    output  [24:0]  fsa,
    inout   [31:0]  fsd,

`ifdef SYSTEM_TYPE_IS_DEVELOPMENT

    output          lcd_csn,
    output          lcd_d_cn,
    inout   [7:0]   lcd_data,
    output          lcd_e_rdn,
    output          lcd_en,
    output          lcd_rstn,
    output          lcd_wen,

    output          seven_seg_a,
    output          seven_seg_b,
    output          seven_seg_c,
    output          seven_seg_d,
    output          seven_seg_dp,
    output          seven_seg_e,
    output          seven_seg_f,
    output          seven_seg_g,
    output          seven_seg_minus,
    output  [4:1]   seven_seg_sel,

    input   [7:0]   user_dipsw,
    output  [7:0]   user_led,
    input   [3:0]   user_pb,

`endif
    
    input   [10:10] hsmb_tx_d_n,
    output  [11:11] hsmb_tx_d_p
);

//
// Declare a localparam for the number of reset sources that exist in this design.
// This parameter will be used by the global_reset_generator module.
//
`ifdef SYSTEM_TYPE_IS_DEVELOPMENT
	localparam RESET_SOURCES_COUNT = 4;
`else
	localparam RESET_SOURCES_COUNT = 3;
`endif

//
// define the wires required for the top level stitching
//

reg [(RESET_SOURCES_COUNT - 1):0]   resetn_sources;

wire            reset_phy_clk_n_from_the_ddr2_lo_latency_128m;
wire            locked_from_the_enet_pll;

wire    [25:0]  address_to_the_cfi_flash_64m;

wire            mdio_oen_from_the_tse_mac;
wire            mdio_out_from_the_tse_mac;
wire            eth_mode_from_the_tse_mac;
wire            ena_10_from_the_tse_mac;
wire            enet_tx_125;
wire            enet_tx_25;
wire            enet_tx_2p5;

wire            tx_clk_to_the_tse_mac;
wire            global_resetn;

`ifdef SYSTEM_TYPE_IS_DEVELOPMENT
	wire            reset_phy_clk_n_from_the_ddr2_hi_latency_128m;

	wire            ats_s0_chipselect_n_to_the_character_lcd_wr;
	wire            ats_s0_read_n_to_the_graphics_lcd;
	wire            ats_s0_read_to_the_character_lcd_rd;
	wire            ats_s0_write_n_to_the_graphics_lcd;
	wire            ats_s0_write_to_the_character_lcd_wr;
	wire            display_atb_byteenable;

	wire    [7:0]   out_port_from_the_seven_seg_abcdefgdp;
	wire    [3:0]   out_port_from_the_seven_seg_sel_1234;
`endif

//
// Shift the flash byte address from the SOPC system down one bit for the 16-bit flash device.
//
assign fsa  =   address_to_the_cfi_flash_64m[25:1];
assign flash_resetn =   global_resetn;

//
// These assignments should illuminate the ddr active LEDs.
//
`ifdef SYSTEM_TYPE_IS_DEVELOPMENT
	assign ddr2bot_active   =   0;
	assign ddr2top_active   =   0;
`else
	assign ddr2bot_active   =   0;
`endif

//
// LCD interface assignments
//
`ifdef SYSTEM_TYPE_IS_DEVELOPMENT
	assign lcd_en       =   (ats_s0_write_to_the_character_lcd_wr | ats_s0_read_to_the_character_lcd_rd) & display_atb_byteenable;
	assign lcd_wen      =   (ats_s0_write_n_to_the_graphics_lcd & ats_s0_chipselect_n_to_the_character_lcd_wr) | !display_atb_byteenable;
	assign lcd_e_rdn    =   display_atb_byteenable ? ats_s0_read_n_to_the_graphics_lcd : 1'b1;
`endif

//
// Ethernet interface assignments
//
assign enet_resetn  =   global_resetn;

enet_gtx_clk_ddio_buffer    enet_gtx_clk_ddio_buffer_inst (
    .aclr ( !global_resetn ),
    .datain_h ( 1'b1 ),
    .datain_l ( 1'b0 ),
    .outclock ( tx_clk_to_the_tse_mac ),
    .dataout ( enet_gtx_clk )
    );
    
assign tx_clk_to_the_tse_mac    =   (eth_mode_from_the_tse_mac) ? (enet_tx_125) :       // GbE Mode = 125MHz clock
                                    (ena_10_from_the_tse_mac) ? (enet_tx_2p5) :         // 10Mb Mode = 2.5MHz clock
                                    (enet_tx_25);                                       // 100Mb Mode = 25MHz clock
                        
assign enet_mdio    =   (!mdio_oen_from_the_tse_mac) ? (mdio_out_from_the_tse_mac) : (1'bz);

//
// These assignments map the seven segment display PIO ports onto the appropriate output pins.
//
`ifdef SYSTEM_TYPE_IS_DEVELOPMENT
	assign { seven_seg_a, seven_seg_b, seven_seg_c, seven_seg_d, seven_seg_e, seven_seg_f, seven_seg_g, seven_seg_dp }  =   out_port_from_the_seven_seg_abcdefgdp;
	assign { seven_seg_sel[1], seven_seg_sel[2], seven_seg_sel[3], seven_seg_sel[4] }   =   out_port_from_the_seven_seg_sel_1234;
`endif

//
// Tie the reset sources from the system into the global_reset_generator module.
// The reset counter width of 8 should provide a 256 clock assertion of global reset
// which at 50MHz should be 5.12us long.
//
`ifdef SYSTEM_TYPE_IS_DEVELOPMENT
	always @ (*) begin
		resetn_sources[(RESET_SOURCES_COUNT - 1)]   <=  cpu_resetn;
		resetn_sources[(RESET_SOURCES_COUNT - 2)]   <=  locked_from_the_enet_pll;
		resetn_sources[(RESET_SOURCES_COUNT - 3)]   <=  reset_phy_clk_n_from_the_ddr2_lo_latency_128m;
		resetn_sources[(RESET_SOURCES_COUNT - 4)]   <=  reset_phy_clk_n_from_the_ddr2_hi_latency_128m;
	end
`else
	always @ (*) begin
		resetn_sources[(RESET_SOURCES_COUNT - 1)]   <=  cpu_resetn;
		resetn_sources[(RESET_SOURCES_COUNT - 2)]   <=  locked_from_the_enet_pll;
		resetn_sources[(RESET_SOURCES_COUNT - 3)]   <=  reset_phy_clk_n_from_the_ddr2_lo_latency_128m;
	end
`endif

global_reset_generator 
#(
    .RESET_SOURCES_WIDTH  (RESET_SOURCES_COUNT),
    .RESET_COUNTER_WIDTH  (8)
) global_reset_generator_inst
(
    .clk            (clkin_50),
    .resetn_sources (resetn_sources),
    .global_resetn  (global_resetn)
);

//
// The SOPC system instantiation.
//
nios2_linux_3c120_125mhz_sys_sopc nios2_linux_3c120_125mhz_sys_sopc_inst
(
    // 1) global signals:
    .clkin_125                                          (clkin_125),
    .clkin_50                                           (clkin_50),
`ifdef SYSTEM_TYPE_IS_DEVELOPMENT
    .ddr2_hi_latency_128m_aux_full_rate_clk_out         (),
    .ddr2_hi_latency_128m_aux_half_rate_clk_out         (),
    .ddr2_hi_latency_128m_phy_clk_out                   (),
`endif
    .ddr2_lo_latency_128m_aux_full_rate_clk_out         (),
    .ddr2_lo_latency_128m_aux_half_rate_clk_out         (),
    .ddr2_lo_latency_128m_phy_clk_out                   (),
    .enet_pll_c0_out                                    (enet_tx_125),
    .enet_pll_c1_out                                    (enet_tx_25),
    .enet_pll_c2_out                                    (enet_tx_2p5),
    .reset_n                                            (global_resetn),

`ifdef SYSTEM_TYPE_IS_DEVELOPMENT

    // the_ddr2_hi_latency_128m
    .global_reset_n_to_the_ddr2_hi_latency_128m         (global_resetn),
    .local_init_done_from_the_ddr2_hi_latency_128m      (),
    .local_refresh_ack_from_the_ddr2_hi_latency_128m    (),
    .local_wdata_req_from_the_ddr2_hi_latency_128m      (),
    .mem_addr_from_the_ddr2_hi_latency_128m             (ddr2top_a),
    .mem_ba_from_the_ddr2_hi_latency_128m               (ddr2top_ba),
    .mem_cas_n_from_the_ddr2_hi_latency_128m            (ddr2top_casn),
    .mem_cke_from_the_ddr2_hi_latency_128m              (ddr2top_cke),
    .mem_clk_n_to_and_from_the_ddr2_hi_latency_128m     (ddr2_ck_n[1]),
    .mem_clk_to_and_from_the_ddr2_hi_latency_128m       (ddr2_ck_p[1]),
    .mem_cs_n_from_the_ddr2_hi_latency_128m             (ddr2top_csn),
    .mem_dm_from_the_ddr2_hi_latency_128m               (ddr2_dm[7:4]),
    .mem_dq_to_and_from_the_ddr2_hi_latency_128m        (ddr2_dq[63:32]),
    .mem_dqs_to_and_from_the_ddr2_hi_latency_128m       (ddr2_dqs[7:4]),
    .mem_odt_from_the_ddr2_hi_latency_128m              (ddr2top_odt),
    .mem_ras_n_from_the_ddr2_hi_latency_128m            (ddr2top_rasn),
    .mem_we_n_from_the_ddr2_hi_latency_128m             (ddr2top_wen),
    .reset_phy_clk_n_from_the_ddr2_hi_latency_128m      (reset_phy_clk_n_from_the_ddr2_hi_latency_128m),

    // the_display_atb_avalon_slave
    .ats_s0_chipselect_n_to_the_character_lcd_rd            (),
    .ats_s0_chipselect_n_to_the_character_lcd_wr            (ats_s0_chipselect_n_to_the_character_lcd_wr),
    .ats_s0_chipselect_n_to_the_graphics_lcd                (lcd_csn),
    .ats_s0_read_n_to_the_graphics_lcd                  (ats_s0_read_n_to_the_graphics_lcd),
    .ats_s0_read_to_the_character_lcd_rd                    (ats_s0_read_to_the_character_lcd_rd),
    .ats_s0_write_n_to_the_graphics_lcd                 (ats_s0_write_n_to_the_graphics_lcd),
    .ats_s0_write_to_the_character_lcd_wr               (ats_s0_write_to_the_character_lcd_wr),
    .display_atb_address                                    (lcd_d_cn),
    .display_atb_byteenable                             (display_atb_byteenable),
    .display_atb_data                                   (lcd_data),

    // the_display_fifo
    .empty_from_the_display_fifo                        (),
    .full_from_the_display_fifo                         (), 

    // the_graphics_lcd_resetn_pio
    .out_port_from_the_graphics_lcd_resetn_pio          (lcd_rstn),

    // the_seven_seg_abcdefgdp
    .out_port_from_the_seven_seg_abcdefgdp              (out_port_from_the_seven_seg_abcdefgdp),

    // the_seven_seg_minus
    .out_port_from_the_seven_seg_minus                  (seven_seg_minus),

    // the_seven_seg_sel_1234
    .out_port_from_the_seven_seg_sel_1234               (out_port_from_the_seven_seg_sel_1234),

    // the_user_dipsw_pio_8in
    .in_port_to_the_user_dipsw_pio_8in                  (user_dipsw),

    // the_user_led_pio_8out
    .out_port_from_the_user_led_pio_8out                (user_led),

    // the_user_pb_pio_4in
    .in_port_to_the_user_pb_pio_4in                     (user_pb),

`endif

    // the_cfi_flash_atb_avalon_slave
    .address_to_the_cfi_flash_64m                       (address_to_the_cfi_flash_64m),
    .data_to_and_from_the_cfi_flash_64m                 (fsd),
    .read_n_to_the_cfi_flash_64m                        (flash_oen),
    .select_n_to_the_cfi_flash_64m                      (flash_cen),
    .write_n_to_the_cfi_flash_64m                       (flash_wen),

    // the_ddr2_lo_latency_128m
    .global_reset_n_to_the_ddr2_lo_latency_128m         (global_resetn),
    .local_init_done_from_the_ddr2_lo_latency_128m      (),
    .local_refresh_ack_from_the_ddr2_lo_latency_128m    (),
    .local_wdata_req_from_the_ddr2_lo_latency_128m      (),
    .mem_addr_from_the_ddr2_lo_latency_128m             (ddr2bot_a),
    .mem_ba_from_the_ddr2_lo_latency_128m               (ddr2bot_ba),
    .mem_cas_n_from_the_ddr2_lo_latency_128m            (ddr2bot_casn),
    .mem_cke_from_the_ddr2_lo_latency_128m              (ddr2bot_cke),
    .mem_clk_n_to_and_from_the_ddr2_lo_latency_128m     (ddr2_ck_n[0]),
    .mem_clk_to_and_from_the_ddr2_lo_latency_128m       (ddr2_ck_p[0]),
    .mem_cs_n_from_the_ddr2_lo_latency_128m             (ddr2bot_csn),
    .mem_dm_from_the_ddr2_lo_latency_128m               (ddr2_dm[3:0]),
    .mem_dq_to_and_from_the_ddr2_lo_latency_128m        (ddr2_dq[31:0]),
    .mem_dqs_to_and_from_the_ddr2_lo_latency_128m       (ddr2_dqs[3:0]),
    .mem_odt_from_the_ddr2_lo_latency_128m              (ddr2bot_odt),
    .mem_ras_n_from_the_ddr2_lo_latency_128m            (ddr2bot_rasn),
    .mem_we_n_from_the_ddr2_lo_latency_128m             (ddr2bot_wen),
    .reset_phy_clk_n_from_the_ddr2_lo_latency_128m      (reset_phy_clk_n_from_the_ddr2_lo_latency_128m),    

    // the_enet_pll
    .areset_to_the_enet_pll                             (!global_resetn),
    .locked_from_the_enet_pll                           (locked_from_the_enet_pll),

    // the_tse_mac
    .ena_10_from_the_tse_mac                            (ena_10_from_the_tse_mac),
    .eth_mode_from_the_tse_mac                          (eth_mode_from_the_tse_mac),
    .mdc_from_the_tse_mac                               (enet_mdc),
    .mdio_in_to_the_tse_mac                             (enet_mdio),
    .mdio_oen_from_the_tse_mac                          (mdio_oen_from_the_tse_mac),
    .mdio_out_from_the_tse_mac                          (mdio_out_from_the_tse_mac),
    .rgmii_in_to_the_tse_mac                            (enet_rxd),
    .rgmii_out_from_the_tse_mac                         (enet_txd),
    .rx_clk_to_the_tse_mac                              (enet_rx_clk),
    .rx_control_to_the_tse_mac                          (enet_rx_dv),
    .set_1000_to_the_tse_mac                            (),
    .set_10_to_the_tse_mac                              (),
    .tx_clk_to_the_tse_mac                              (tx_clk_to_the_tse_mac),
    .tx_control_from_the_tse_mac                        (enet_tx_en),

    // the_uart
    .rxd_to_the_uart                                    (hsmb_tx_d_n[10]),
    .txd_from_the_uart                                  (hsmb_tx_d_p[11])
);

endmodule
