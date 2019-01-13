
//=======================================================
//  This code is generated by Terasic System Builder
//=======================================================

module DE2_115_D8M_RTL (

	//////////// CLOCK //////////
	input 		          		CLOCK2_50,
	input 		          		CLOCK3_50,
	input 		          		CLOCK_50,

	//////////// Sma //////////
	input 		          		SMA_CLKIN,
	output		          		SMA_CLKOUT,

	//////////// LED //////////
	output		     [8:0]		LEDG,
	output		    [17:0]		LEDR,

	//////////// KEY //////////
	input 		     [3:0]		KEY,

	//////////// SW //////////
	input 		    [17:0]		SW,

	//////////// SEG7 //////////
	output		     [6:0]		HEX0,
	output		     [6:0]		HEX1,
	output		     [6:0]		HEX2,
	output		     [6:0]		HEX3,
	output		     [6:0]		HEX4,
	output		     [6:0]		HEX5,
	output		     [6:0]		HEX6,
	output		     [6:0]		HEX7,

	//////////// LCD //////////
	output		          		LCD_BLON,
	inout 		     [7:0]		LCD_DATA,
	output		          		LCD_EN,
	output		          		LCD_ON,
	output		          		LCD_RS,
	output		          		LCD_RW,

	//////////// VGA //////////
	output		          		VGA_BLANK_N,
	output		     [7:0]		VGA_B,
	output		          		VGA_CLK,
	output		     [7:0]		VGA_G,
	output		          		VGA_HS,
	output		     [7:0]		VGA_R,
	output		          		VGA_SYNC_N,
	output		          		VGA_VS,

	//////////// SDRAM //////////
	output		    [12:0]		DRAM_ADDR,
	output		     [1:0]		DRAM_BA,
	output		          		DRAM_CAS_N,
	output		          		DRAM_CKE,
	output		          		DRAM_CLK,
	output		          		DRAM_CS_N,
	inout 		    [31:0]		DRAM_DQ,
	output		     [3:0]		DRAM_DQM,
	output		          		DRAM_RAS_N,
	output		          		DRAM_WE_N,

	//////////// GPIO, GPIO connect to D8M-GPIO //////////
	inout 		          		CAMERA_I2C_SCL,
	inout 		          		CAMERA_I2C_SDA,
	output		          		CAMERA_PWDN_n,
	output		          		MIPI_CS_n,
	inout 		          		MIPI_I2C_SCL,
	inout 		          		MIPI_I2C_SDA,
	output		          		MIPI_MCLK,
	input 		          		MIPI_PIXEL_CLK,
	input 		     [9:0]		MIPI_PIXEL_D,
	input 		          		MIPI_PIXEL_HS,
	input 		          		MIPI_PIXEL_VS,
	output		          		MIPI_REFCLK,
	output		          		MIPI_RESET_n
);


//=============================================================================
// REG/WIRE declarations
//=============================================================================

wire	[31:0]SDRAM_RD_DATA;
wire	[31:0]SDRAM_RD_DATA1;
wire	[31:0]SDRAM_RD_DATA2;
wire			DLY_RST_0;
wire			DLY_RST_1;
wire			DLY_RST_2;

wire			SDRAM_CTRL_CLK;
wire        D8M_CK_HZ ; 
wire        D8M_CK_HZ2 ; 
wire        D8M_CK_HZ3 ; 

wire [11:0] RED   ; 
wire [11:0] GREEN  ; 
wire [11:0] BLUE 		 ; 
wire [12:0] VGA_H_CNT;			
wire [12:0] VGA_V_CNT;	

wire        READ_Request ;
wire 	[7:0] B_AUTO;
wire 	[7:0] G_AUTO;
wire 	[7:0] R_AUTO;
wire        RESET_N  ; 

wire        I2C_RELEASE ;  
wire        AUTO_FOC ; 
wire        CAMERA_I2C_SCL_MIPI ; 
wire        CAMERA_I2C_SCL_AF;
wire        CAMERA_MIPI_RELAESE ;
wire        MIPI_BRIDGE_RELEASE ; 
  wire   [9:0]MIPI_PIXEL_D_ ;
  wire        MIPI_PIXEL_VS_; 
  wire        MIPI_PIXEL_HS_;  
 
//=============================================================================
// Structural coding
//=============================================================================
assign UART_RTS =0; 
assign UART_TXD =0; 
//------HEX OFF --
assign HEX2           = 7'h7F;
assign HEX3           = 7'h7F;
assign HEX4           = 7'h7F;
assign HEX5           = 7'h7F;
assign HEX6           = 7'h7F;
assign HEX7           = 7'h7F;

//------ MIPI BRIGE & CAMERA RESET  --
assign CAMERA_PWDN_n  = 1; 
assign MIPI_CS_n      = 0; 
assign MIPI_RESET_n   = RESET_N ;

//------ CAMERA MODULE I2C SWITCH  --
assign I2C_RELEASE    = CAMERA_MIPI_RELAESE & MIPI_BRIDGE_RELEASE; 
assign CAMERA_I2C_SCL =( I2C_RELEASE  )?  CAMERA_I2C_SCL_AF  : CAMERA_I2C_SCL_MIPI ;   
 

//----- RESET RELAY  --		
RESET_DELAY			u2	(	
							.iRST  ( KEY[0] ),
                     .iCLK  ( CLOCK2_50 ),
							.oRST_0( DLY_RST_0 ),
							.oRST_1( DLY_RST_1 ),
							.oRST_2( DLY_RST_2 ),					
						   .oREADY( RESET_N)  
							
						);
 
//------ MIPI BRIGE & CAMERA SETTING  --  
MIPI_BRIDGE_CAMERA_Config    cfin(
                      .RESET_N           ( RESET_N ), 
                      .CLK_50            ( CLOCK2_50 ), 
                      .MIPI_I2C_SCL      ( MIPI_I2C_SCL ), 
                      .MIPI_I2C_SDA      ( MIPI_I2C_SDA ), 
                      .MIPI_I2C_RELEASE  ( MIPI_BRIDGE_RELEASE ),  
                      .CAMERA_I2C_SCL    ( CAMERA_I2C_SCL_MIPI ),
                      .CAMERA_I2C_SDA    ( CAMERA_I2C_SDA ),
                      .CAMERA_I2C_RELAESE( CAMERA_MIPI_RELAESE )
             );
				 
//------MIPI / VGA REF CLOCK  --
pll_test pll_ref(
	                   .inclk0 ( CLOCK2_50 ),
	                   .areset ( ~KEY[0] ),
	                   .c0( MIPI_REFCLK ), //20Mhz
	                   .c1( VGA_CLK )      //25.18Mhz	
    );
	 
	 

//---RE-TRIGGER ---
RE_TRIGGER  tr( 
       .iCLK (MIPI_PIXEL_CLK ), 
       .iD   (MIPI_PIXEL_D   ), 
       .iHS  (MIPI_PIXEL_HS  ),
       .iVS  (MIPI_PIXEL_VS  ),	
		 
       .oD   (MIPI_PIXEL_D_  ), 
       .oHS  (MIPI_PIXEL_HS_ ),
       .oVS  (MIPI_PIXEL_VS_ )
);	 
	 
//------AOTO FOCUS ENABLE  --
AUTO_FOCUS_ON  vd( 
                      .CLK_50      ( CLOCK2_50 ), 
                      .I2C_RELEASE ( I2C_RELEASE ), 
                      .AUTO_FOC    ( AUTO_FOC )
               ) ;
					

//------AOTO FOCUS ADJ  --
FOCUS_ADJ adl(
                      .CLK_50        ( CLOCK2_50 ) , 
                      .RESET_N       ( I2C_RELEASE ), 
                      .RESET_SUB_N   ( I2C_RELEASE ), 
                      .AUTO_FOC      ( KEY[3] & AUTO_FOC ), 
                      .SW_Y          ( 0 ),
                      .SW_H_FREQ     ( 0 ),   
                      .SW_FUC_LINE   ( SW[3] ),   
                      .SW_FUC_ALL_CEN( 0 ),
                      .VIDEO_HS      ( VGA_HS ),
                      .VIDEO_VS      ( VGA_VS ),
                      .VIDEO_CLK     ( VGA_CLK ),//MIPI_PIXEL_CLK),
		                .VIDEO_DE      ( iivalid ) ,//READ_Request),
                      .iR            ( R_AUTO ), 
                      .iG            ( G_AUTO ), 
                      .iB            ( B_AUTO ), 
                      .oR            ( VGA_R ) , 
                      .oG            ( VGA_G ) , 
                      .oB            ( VGA_B ) , 
                      
                      .READY         ( READY ),
                      .SCL           ( CAMERA_I2C_SCL_AF ), 
                      .SDA           ( CAMERA_I2C_SDA )
);

//------VGA Controller  --

VGA_Controller		u1	(	//	Host Side
							 .oRequest( READ_Request ),
							 .iRed    ( iR[7:0]),//15:11], 3'b0} ),
							 .iGreen  ( iG[7:0]),//10:5], 2'b0} ),
							 .iBlue   ( iB[7:0]),//4:0], 3'b0} ),
							 
							 //	VGA Side
							 .oVGA_R  ( R_AUTO[7:0] ),
							 .oVGA_G  ( G_AUTO[7:0] ),
							 .oVGA_B  ( B_AUTO[7:0] ),
							 .oVGA_H_SYNC( VGA_HS ),
							 .oVGA_V_SYNC( VGA_VS ),
							 .oVGA_SYNC  ( VGA_SYNC_N ),
							 .oVGA_BLANK ( VGA_BLANK_N ),
							 //	Control Signal
							 .iCLK       ( VGA_CLK ),//MIPI_PIXEL_CLK),
							 .iRST_N     ( DLY_RST_2 ),
							 .H_Cont     ( VGA_H_CNT ),						
						    .V_Cont     ( VGA_V_CNT )								
						);	



//------SDRAM CLOCK GENNERATER  --
sdram_pll u6(
		               .areset( 0 ) ,     
		               .inclk0( CLOCK2_50  ),              
		               .c1    ( DRAM_CLK ),       //100MHZ   -90 degree
		               .c0    ( SDRAM_CTRL_CLK )  //100MHZ     0 degree 							
		              
	               );	
		
wire	wsig;
wire	rsig;		

//------Frmae count --
frame_cnt			u8	(
							.clk		( MIPI_PIXEL_CLK ),
							.rstn		( KEY[0] ),
							.valid	( ivalid ),
							.sig		( wsig )
							);
							
frame_cnt			u9	(
							.clk		( VGA_CLK ),//MIPI_PIXEL_CLK),
							.rstn		( KEY[0] ),
							.valid	( READ_Request ),//iivalid),
							.sig		( rsig )
							);
		
		
//------SDRAM CONTROLLER --

Sdram_Control	   u7	(	//	HOST Side						
						   .RESET_N     ( KEY[0] ),
							.CLK         ( SDRAM_CTRL_CLK ) , 
							//	FIFO Write Side 1
							.WR1_DATA    ( {8'b0,Y, U, V} ),
							.WR1         ( ivalid & ~wsig ) ,//MIPI_PIXEL_HS & MIPI_PIXEL_VS & ~wsig ) ,
							
							.WR1_ADDR    ( 0 ),
                     .WR1_MAX_ADDR( 640*480 ),
						   .WR1_LENGTH  ( 256 ) , 
		               .WR1_LOAD    ( !DLY_RST_0 ),
							.WR1_CLK     ( MIPI_PIXEL_CLK ),
							
							//	FIFO Write Side 2
							.WR2_DATA    ( {8'b0,Y, U, V} ),//{RED[11:4],GREEN[11:4],BLUE[11:4]} ),
							.WR2         ( ivalid & wsig ) ,//MIPI_PIXEL_HS & MIPI_PIXEL_VS & ~wsig ) ,
							
							.WR2_ADDR    ( 640*480 ),
                     .WR2_MAX_ADDR( 640*480*2 ),
						   .WR2_LENGTH  ( 256 ) , 
		               .WR2_LOAD    ( !DLY_RST_0 ),
							.WR2_CLK     ( MIPI_PIXEL_CLK ),

                     //	FIFO Read Side 1
						   .RD1_DATA    ( SDRAM_RD_DATA1 ),
				        	.RD1         ( READ_Request & rsig ),
				        	.RD1_ADDR    ( 0 ),
                     .RD1_MAX_ADDR( 640*480 ),
							.RD1_LENGTH  ( 256  ),
							.RD1_LOAD    ( !DLY_RST_1 ),
							.RD1_CLK     ( VGA_CLK ),//MIPI_PIXEL_CLK),
							
							//	FIFO Read Side 2
						   .RD2_DATA    ( SDRAM_RD_DATA2 ),
				        	.RD2         ( READ_Request & ~rsig ),
				        	.RD2_ADDR    ( 640*480 ),//307201 ),
                     .RD2_MAX_ADDR( 640*480*2 ),
							.RD2_LENGTH  ( 256  ),
							.RD2_LOAD    ( !DLY_RST_1 ),
							.RD2_CLK     ( VGA_CLK ),//MIPI_PIXEL_CLK),
											
							//	SDRAM Side
						   .SA          ( DRAM_ADDR ),
							.BA          ( DRAM_BA ),
							.CS_N        ( DRAM_CS_N ),
							.CKE         ( DRAM_CKE ),
							.RAS_N       ( DRAM_RAS_N ),
							.CAS_N       ( DRAM_CAS_N ),
							.WE_N        ( DRAM_WE_N ),
							.DQ          ( DRAM_DQ ),
							.DQM         ( DRAM_DQM  )
						   );

													
wire	[7:0] Y, U, V, oU, oV;
wire	[7:0]	oYdata, Ydata, Ydata1, Ydata2, YYdata;
wire	[7:0] iR, iG, iB;
wire	ivalid, iivalid;		
		
reg	[7:0] rU, rV;

/*always @( posedge MIPI_PIXEL_CLK ) begin
	rU <= U;
	rV <= V;
end

assign oU = rU;
assign oV = rV;*/

reg mode;

always@(posedge VGA_CLK or negedge KEY[0])	begin
	if(!KEY[0])	mode	<= 1'b0;
	else if(!KEY[1])	mode <= 1'b1;
	else if(!KEY[2])	mode <= 1'b0;
	end

//------ RGB to YUV --
rgb2yuv					u10 (
							.valid		  ( MIPI_PIXEL_HS & MIPI_PIXEL_VS ),
							.clk			  ( MIPI_PIXEL_CLK ),
							.rst			  ( KEY[0] ),
							.R				  ( RED[11:4] ),
							.G				  ( GREEN[11:4] ),
							.B				  ( BLUE[11:4] ),
							.Y				  ( Y ),
							.U				  ( U ),
							.V				  ( V ),
							.outvalid	  ( ivalid )
							);
							
//------ Histogram Equalization 1 --
histeq					u11 (
							.valid		  ( ivalid ),
							.wsig			  ( wsig ),
							.rsig			  ( ~rsig ),
							.clk			  ( MIPI_PIXEL_CLK ),
							.rst			  ( KEY[0] ),
							.ydata		  ( Y ),
							.iydata		  ( SDRAM_RD_DATA2[23:16]),//oYdata ),
							.outY			  ( Ydata1 )
							);
							
//------ Histogram Equalization 2 --
histeq					u13 (
							.valid		  ( ivalid ),
							.wsig			  ( ~wsig ),
							.rsig			  ( rsig ),
							.clk			  ( MIPI_PIXEL_CLK ),
							.rst			  ( KEY[0] ),
							.ydata		  ( Y ),
							.iydata		  ( SDRAM_RD_DATA1[23:16]),//oYdata ),
							.outY			  ( Ydata2 )
							);
							
assign Ydata = rsig ? Ydata2 : Ydata1;
//assign oYdata = rsig ? SDRAM_RD_DATA1[23:16] : SDRAM_RD_DATA2[23:16];		
assign SDRAM_RD_DATA = rsig ? SDRAM_RD_DATA1 : SDRAM_RD_DATA2;
assign YYdata = mode ? Ydata : SDRAM_RD_DATA[23:16];				
							
//------ YUV to RGB --
yuv2rgb					u12 (
							.valid		  ( READ_Request ),
							.clk			  ( VGA_CLK ),//MIPI_PIXEL_CLK),
							.rst			  ( KEY[0] ),
							.Y			  	  ( YYdata ),//SDRAM_RD_DATA[23:16]),
							.U				  ( SDRAM_RD_DATA[15:8] ),
							.V				  ( SDRAM_RD_DATA[7:0] ),
							.R				  ( iR ),
							.G				  ( iG ),
							.B				  ( iB ),
							.outvalid	  ( iivalid )
							);

						
//------ CMOS CCD_DATA TO RGB_DATA -- 
RAW2RGB_J				u4	(	
							.RST          ( MIPI_PIXEL_VS ),
                     .CCD_PIXCLK   ( MIPI_PIXEL_CLK ),
							.mCCD_DATA    ( {MIPI_PIXEL_D[9:0] ,2'b00  }  ),
							.CCD_FVAL     ( MIPI_PIXEL_VS  ),
							.CCD_LVAL     ( MIPI_PIXEL_HS  ),

							//-----------------------------------
                     .VGA_CLK      ( MIPI_PIXEL_CLK ),
                     .READ_Request ( MIPI_PIXEL_HS & MIPI_PIXEL_VS ),
                     .VGA_VS       ( MIPI_PIXEL_VS ),	
							.VGA_HS       ( MIPI_PIXEL_HS ) , 
	                  .READ_Cont    ( READ_Cont ) , 
	                  .V_Cont       (), 
	                  			
							.oRed         ( RED  [11:0] ),
							.oGreen       ( GREEN[11:0] ),
							.oBlue        ( BLUE [11:0] ),
							.oDVAL        ( )

							);	

//------VS FREQUENCY TEST = 60HZ --
							
FpsMonitor uFps( 
	/*input					  */     .clk50    ( CLOCK2_50 ),
	/*input     			  */     .vs       ( MIPI_PIXEL_VS_ ),
	
	/*output reg [7:0]		*/    .fps      (),
	/*output reg [6:0]		*/    .hex_fps_h( HEX1 ),
	/*output reg [6:0]		*/    .hex_fps_l( HEX0 )
);


//--LED DISPLAY--
CLOCKMEM  ck1 ( .CLK(/*rsig*/VGA_CLK )   ,.CLK_FREQ  (25180000  ) , . CK_1HZ (D8M_CK_HZ   )  )        ;//25MHZ
CLOCKMEM  ck2 ( .CLK(/*wsig*/MIPI_REFCLK   )   ,.CLK_FREQ  (25000000   ) , . CK_1HZ (D8M_CK_HZ2  )  ) ;//20MHZ
CLOCKMEM  ck3 ( .CLK(MIPI_PIXEL_CLK)   ,.CLK_FREQ  (25000000  ) , . CK_1HZ (D8M_CK_HZ3  )  )  ;//25MHZ


assign LEDR = { D8M_CK_HZ ,D8M_CK_HZ2,D8M_CK_HZ3 ,5'h0,CAMERA_MIPI_RELAESE ,MIPI_BRIDGE_RELEASE  } ; 

endmodule