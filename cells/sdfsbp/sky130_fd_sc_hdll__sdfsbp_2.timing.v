/*
 * Copyright 2020 The SkyWater PDK Authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 * SPDX-License-Identifier: Apache-2.0
*/


`ifndef SKY130_FD_SC_HDLL__SDFSBP_2_TIMING_V
`define SKY130_FD_SC_HDLL__SDFSBP_2_TIMING_V

/**
 * sdfsbp: Scan delay flop, inverted set, non-inverted clock,
 *         complementary outputs.
 *
 * Verilog simulation timing model.
 */

`timescale 1ns / 1ps
`default_nettype none

// Import user defined primitives.
`include "../../models/udp_mux_2to1/sky130_fd_sc_hdll__udp_mux_2to1.v"
`include "../../models/udp_dff_ps_pp_pg_n/sky130_fd_sc_hdll__udp_dff_ps_pp_pg_n.v"

`celldefine
module sky130_fd_sc_hdll__sdfsbp_2 (
    Q    ,
    Q_N  ,
    CLK  ,
    D    ,
    SCD  ,
    SCE  ,
    SET_B
);

    // Module ports
    output Q    ;
    output Q_N  ;
    input  CLK  ;
    input  D    ;
    input  SCD  ;
    input  SCE  ;
    input  SET_B;

    // Module supplies
    supply1 VPWR;
    supply0 VGND;
    supply1 VPB ;
    supply0 VNB ;

    // Local signals
    wire buf_Q        ;
    wire SET          ;
    wire mux_out      ;
    reg  notifier     ;
    wire D_delayed    ;
    wire SCD_delayed  ;
    wire SCE_delayed  ;
    wire SET_B_delayed;
    wire CLK_delayed  ;
    wire awake        ;
    wire cond0        ;
    wire cond1        ;
    wire cond2        ;
    wire cond3        ;
    wire cond4        ;

    //                                    Name       Output   Other arguments
    not                                   not0      (SET    , SET_B_delayed                                  );
    sky130_fd_sc_hdll__udp_mux_2to1       mux_2to10 (mux_out, D_delayed, SCD_delayed, SCE_delayed            );
    sky130_fd_sc_hdll__udp_dff$PS_pp$PG$N dff0      (buf_Q  , mux_out, CLK_delayed, SET, notifier, VPWR, VGND);
    assign awake = ( VPWR === 1'b1 );
    assign cond0 = ( ( SET_B_delayed === 1'b1 ) && awake );
    assign cond1 = ( ( SCE_delayed === 1'b0 ) && cond0 );
    assign cond2 = ( ( SCE_delayed === 1'b1 ) && cond0 );
    assign cond3 = ( ( D_delayed !== SCD_delayed ) && cond0 );
    assign cond4 = ( ( SET_B === 1'b1 ) && awake );
    buf                                   buf0      (Q      , buf_Q                                          );
    not                                   not1      (Q_N    , buf_Q                                          );

specify
if (CLK==1'b0&&D==1'b0&&SCD==1'b0&&SCE==1'b0) (negedge SET_B => (Q -: 1'b1))=(0:0:0, 0:0:0);
if (CLK==1'b0&&D==1'b0&&SCD==1'b0&&SCE==1'b1) (negedge SET_B => (Q -: 1'b1))=(0:0:0, 0:0:0);
if (CLK==1'b0&&D==1'b0&&SCD==1'b1&&SCE==1'b0) (negedge SET_B => (Q -: 1'b1))=(0:0:0, 0:0:0);
if (CLK==1'b0&&D==1'b0&&SCD==1'b1&&SCE==1'b1) (negedge SET_B => (Q -: 1'b1))=(0:0:0, 0:0:0);
if (CLK==1'b0&&D==1'b1&&SCD==1'b0&&SCE==1'b0) (negedge SET_B => (Q -: 1'b1))=(0:0:0, 0:0:0);
if (CLK==1'b0&&D==1'b1&&SCD==1'b0&&SCE==1'b1) (negedge SET_B => (Q -: 1'b1))=(0:0:0, 0:0:0);
if (CLK==1'b0&&D==1'b1&&SCD==1'b1&&SCE==1'b0) (negedge SET_B => (Q -: 1'b1))=(0:0:0, 0:0:0);
if (CLK==1'b0&&D==1'b1&&SCD==1'b1&&SCE==1'b1) (negedge SET_B => (Q -: 1'b1))=(0:0:0, 0:0:0);
if (CLK==1'b1&&D==1'b0&&SCD==1'b0&&SCE==1'b0) (negedge SET_B => (Q -: 1'b1))=(0:0:0, 0:0:0);
if (CLK==1'b1&&D==1'b0&&SCD==1'b0&&SCE==1'b1) (negedge SET_B => (Q -: 1'b1))=(0:0:0, 0:0:0);
if (CLK==1'b1&&D==1'b0&&SCD==1'b1&&SCE==1'b0) (negedge SET_B => (Q -: 1'b1))=(0:0:0, 0:0:0);
if (CLK==1'b1&&D==1'b0&&SCD==1'b1&&SCE==1'b1) (negedge SET_B => (Q -: 1'b1))=(0:0:0, 0:0:0);
if (CLK==1'b1&&D==1'b1&&SCD==1'b0&&SCE==1'b0) (negedge SET_B => (Q -: 1'b1))=(0:0:0, 0:0:0);
if (CLK==1'b1&&D==1'b1&&SCD==1'b0&&SCE==1'b1) (negedge SET_B => (Q -: 1'b1))=(0:0:0, 0:0:0);
if (CLK==1'b1&&D==1'b1&&SCD==1'b1&&SCE==1'b0) (negedge SET_B => (Q -: 1'b1))=(0:0:0, 0:0:0);
if (CLK==1'b1&&D==1'b1&&SCD==1'b1&&SCE==1'b1) (negedge SET_B => (Q -: 1'b1))=(0:0:0, 0:0:0);
if (D==1'b0&&SCD==1'b1&&SCE==1'b1&&SET_B==1'b1) (posedge CLK => (Q +: 1'b1))=(0:0:0, 0:0:0);
if (D==1'b1&&SCD==1'b0&&SCE==1'b0&&SET_B==1'b1) (posedge CLK => (Q +: 1'b1))=(0:0:0, 0:0:0);
if (D==1'b1&&SCD==1'b1&&SCE==1'b0&&SET_B==1'b1) (posedge CLK => (Q +: 1'b1))=(0:0:0, 0:0:0);
if (D==1'b1&&SCD==1'b1&&SCE==1'b1&&SET_B==1'b1) (posedge CLK => (Q +: 1'b1))=(0:0:0, 0:0:0);
if (D==1'b0&&SCD==1'b0&&SCE==1'b0&&SET_B==1'b1) (posedge CLK => (Q -: 1'b1))=(0:0:0, 0:0:0);
if (D==1'b0&&SCD==1'b0&&SCE==1'b1&&SET_B==1'b1) (posedge CLK => (Q -: 1'b1))=(0:0:0, 0:0:0);
if (D==1'b0&&SCD==1'b1&&SCE==1'b0&&SET_B==1'b1) (posedge CLK => (Q -: 1'b1))=(0:0:0, 0:0:0);
if (D==1'b1&&SCD==1'b0&&SCE==1'b1&&SET_B==1'b1) (posedge CLK => (Q -: 1'b1))=(0:0:0, 0:0:0);
if (CLK==1'b0&&D==1'b0&&SCD==1'b0&&SCE==1'b0) (negedge SET_B => (Q_N +: 1'b0))=(0:0:0, 0:0:0);
if (CLK==1'b0&&D==1'b0&&SCD==1'b0&&SCE==1'b1) (negedge SET_B => (Q_N +: 1'b0))=(0:0:0, 0:0:0);
if (CLK==1'b0&&D==1'b0&&SCD==1'b1&&SCE==1'b0) (negedge SET_B => (Q_N +: 1'b0))=(0:0:0, 0:0:0);
if (CLK==1'b0&&D==1'b0&&SCD==1'b1&&SCE==1'b1) (negedge SET_B => (Q_N +: 1'b0))=(0:0:0, 0:0:0);
if (CLK==1'b0&&D==1'b1&&SCD==1'b0&&SCE==1'b0) (negedge SET_B => (Q_N +: 1'b0))=(0:0:0, 0:0:0);
if (CLK==1'b0&&D==1'b1&&SCD==1'b0&&SCE==1'b1) (negedge SET_B => (Q_N +: 1'b0))=(0:0:0, 0:0:0);
if (CLK==1'b0&&D==1'b1&&SCD==1'b1&&SCE==1'b0) (negedge SET_B => (Q_N +: 1'b0))=(0:0:0, 0:0:0);
if (CLK==1'b0&&D==1'b1&&SCD==1'b1&&SCE==1'b1) (negedge SET_B => (Q_N +: 1'b0))=(0:0:0, 0:0:0);
if (CLK==1'b1&&D==1'b0&&SCD==1'b0&&SCE==1'b0) (negedge SET_B => (Q_N +: 1'b0))=(0:0:0, 0:0:0);
if (CLK==1'b1&&D==1'b0&&SCD==1'b0&&SCE==1'b1) (negedge SET_B => (Q_N +: 1'b0))=(0:0:0, 0:0:0);
if (CLK==1'b1&&D==1'b0&&SCD==1'b1&&SCE==1'b0) (negedge SET_B => (Q_N +: 1'b0))=(0:0:0, 0:0:0);
if (CLK==1'b1&&D==1'b0&&SCD==1'b1&&SCE==1'b1) (negedge SET_B => (Q_N +: 1'b0))=(0:0:0, 0:0:0);
if (CLK==1'b1&&D==1'b1&&SCD==1'b0&&SCE==1'b0) (negedge SET_B => (Q_N +: 1'b0))=(0:0:0, 0:0:0);
if (CLK==1'b1&&D==1'b1&&SCD==1'b0&&SCE==1'b1) (negedge SET_B => (Q_N +: 1'b0))=(0:0:0, 0:0:0);
if (CLK==1'b1&&D==1'b1&&SCD==1'b1&&SCE==1'b0) (negedge SET_B => (Q_N +: 1'b0))=(0:0:0, 0:0:0);
if (CLK==1'b1&&D==1'b1&&SCD==1'b1&&SCE==1'b1) (negedge SET_B => (Q_N +: 1'b0))=(0:0:0, 0:0:0);
if (D==1'b0&&SCD==1'b0&&SCE==1'b0&&SET_B==1'b1) (posedge CLK => (Q_N +: 1'b1))=(0:0:0, 0:0:0);
if (D==1'b0&&SCD==1'b0&&SCE==1'b1&&SET_B==1'b1) (posedge CLK => (Q_N +: 1'b1))=(0:0:0, 0:0:0);
if (D==1'b0&&SCD==1'b1&&SCE==1'b0&&SET_B==1'b1) (posedge CLK => (Q_N +: 1'b1))=(0:0:0, 0:0:0);
if (D==1'b1&&SCD==1'b0&&SCE==1'b1&&SET_B==1'b1) (posedge CLK => (Q_N +: 1'b1))=(0:0:0, 0:0:0);
if (D==1'b0&&SCD==1'b1&&SCE==1'b1&&SET_B==1'b1) (posedge CLK => (Q_N -: 1'b1))=(0:0:0, 0:0:0);
if (D==1'b1&&SCD==1'b0&&SCE==1'b0&&SET_B==1'b1) (posedge CLK => (Q_N -: 1'b1))=(0:0:0, 0:0:0);
if (D==1'b1&&SCD==1'b1&&SCE==1'b0&&SET_B==1'b1) (posedge CLK => (Q_N -: 1'b1))=(0:0:0, 0:0:0);
if (D==1'b1&&SCD==1'b1&&SCE==1'b1&&SET_B==1'b1) (posedge CLK => (Q_N -: 1'b1))=(0:0:0, 0:0:0);
$recrem ( posedge SET_B , posedge CLK , 0:0:0 , 0:0:0 , notifier , awake , awake , SET_B_delayed , CLK_delayed ) ;
$setuphold ( posedge CLK , posedge D , 0:0:0 , 0:0:0 , notifier , cond1 , cond1 , CLK_delayed , D_delayed ) ;
$setuphold ( posedge CLK , negedge D , 0:0:0 , 0:0:0 , notifier , cond1 , cond1 , CLK_delayed , D_delayed ) ;
$setuphold ( posedge CLK , posedge SCD , 0:0:0 , 0:0:0 , notifier , cond2 , cond2 , CLK_delayed , SCD_delayed ) ;
$setuphold ( posedge CLK , negedge SCD , 0:0:0 , 0:0:0 , notifier , cond2 , cond2 , CLK_delayed , SCD_delayed ) ;
$setuphold ( posedge CLK , posedge SCE , 0:0:0 , 0:0:0 , notifier , cond3 , cond3 , CLK_delayed , SCE_delayed ) ;
$setuphold ( posedge CLK , negedge SCE , 0:0:0 , 0:0:0 , notifier , cond3 , cond3 , CLK_delayed , SCE_delayed ) ;
$width ( posedge CLK &&& cond4 , 1.0:1.0:1.0 , 0 , notifier ) ;
$width ( negedge CLK &&& cond4 , 1.0:1.0:1.0 , 0 , notifier ) ;
$width ( negedge SET_B &&& awake , 1.0:1.0:1.0 , 0 , notifier ) ;
endspecify
endmodule
`endcelldefine

`default_nettype wire
`endif  // SKY130_FD_SC_HDLL__SDFSBP_2_TIMING_V
