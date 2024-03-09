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


`ifndef SKY130_FD_SC_HDLL__AND4B_1_TIMING_PP_V
`define SKY130_FD_SC_HDLL__AND4B_1_TIMING_PP_V

/**
 * and4b: 4-input AND, first input inverted.
 *
 * Verilog simulation timing model.
 */

`timescale 1ns / 1ps
`default_nettype none

// Import user defined primitives.
`include "../../models/udp_pwrgood_pp_pg/sky130_fd_sc_hdll__udp_pwrgood_pp_pg.v"

`celldefine
module sky130_fd_sc_hdll__and4b_1 (
    X   ,
    A_N ,
    B   ,
    C   ,
    D   ,
    VPWR,
    VGND,
    VPB ,
    VNB
);

    // Module ports
    output X   ;
    input  A_N ;
    input  B   ;
    input  C   ;
    input  D   ;
    input  VPWR;
    input  VGND;
    input  VPB ;
    input  VNB ;

    // Local signals
    wire not0_out         ;
    wire and0_out_X       ;
    wire pwrgood_pp0_out_X;

    //                                   Name         Output             Other arguments
    not                                  not0        (not0_out         , A_N                   );
    and                                  and0        (and0_out_X       , not0_out, B, C, D     );
    sky130_fd_sc_hdll__udp_pwrgood_pp$PG pwrgood_pp0 (pwrgood_pp0_out_X, and0_out_X, VPWR, VGND);
    buf                                  buf0        (X                , pwrgood_pp0_out_X     );

specify
if (B==1'b1&&C==1'b1&&D==1'b1) (A_N -=> X)=(0:0:0, 0:0:0);
if (A_N==1'b0&&C==1'b1&&D==1'b1) (B +=> X)=(0:0:0, 0:0:0);
if (A_N==1'b0&&B==1'b1&&D==1'b1) (C +=> X)=(0:0:0, 0:0:0);
if (A_N==1'b0&&B==1'b1&&C==1'b1) (D +=> X)=(0:0:0, 0:0:0);
endspecify
endmodule
`endcelldefine

`default_nettype wire
`endif  // SKY130_FD_SC_HDLL__AND4B_1_TIMING_PP_V