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


`ifndef SKY130_FD_SC_HDLL__O2BB2A_4_TIMING_PP_V
`define SKY130_FD_SC_HDLL__O2BB2A_4_TIMING_PP_V

/**
 * o2bb2a: 2-input NAND and 2-input OR into 2-input AND.
 *
 *         X = (!(A1 & A2) & (B1 | B2))
 *
 * Verilog simulation timing model.
 */

`timescale 1ns / 1ps
`default_nettype none

// Import user defined primitives.
`include "../../models/udp_pwrgood_pp_pg/sky130_fd_sc_hdll__udp_pwrgood_pp_pg.v"

`celldefine
module sky130_fd_sc_hdll__o2bb2a_4 (
    X   ,
    A1_N,
    A2_N,
    B1  ,
    B2  ,
    VPWR,
    VGND,
    VPB ,
    VNB
);

    // Module ports
    output X   ;
    input  A1_N;
    input  A2_N;
    input  B1  ;
    input  B2  ;
    input  VPWR;
    input  VGND;
    input  VPB ;
    input  VNB ;

    // Local signals
    wire nand0_out        ;
    wire or0_out          ;
    wire and0_out_X       ;
    wire pwrgood_pp0_out_X;

    //                                   Name         Output             Other arguments
    nand                                 nand0       (nand0_out        , A2_N, A1_N            );
    or                                   or0         (or0_out          , B2, B1                );
    and                                  and0        (and0_out_X       , nand0_out, or0_out    );
    sky130_fd_sc_hdll__udp_pwrgood_pp$PG pwrgood_pp0 (pwrgood_pp0_out_X, and0_out_X, VPWR, VGND);
    buf                                  buf0        (X                , pwrgood_pp0_out_X     );

specify
if (A2_N==1'b1&&B1==1'b0&&B2==1'b1) (A1_N -=> X)=(0:0:0, 0:0:0);
if (A2_N==1'b1&&B1==1'b1&&B2==1'b0) (A1_N -=> X)=(0:0:0, 0:0:0);
if (A2_N==1'b1&&B1==1'b1&&B2==1'b1) (A1_N -=> X)=(0:0:0, 0:0:0);
if (A1_N==1'b1&&B1==1'b0&&B2==1'b1) (A2_N -=> X)=(0:0:0, 0:0:0);
if (A1_N==1'b1&&B1==1'b1&&B2==1'b0) (A2_N -=> X)=(0:0:0, 0:0:0);
if (A1_N==1'b1&&B1==1'b1&&B2==1'b1) (A2_N -=> X)=(0:0:0, 0:0:0);
if (A1_N==1'b0&&A2_N==1'b0&&B2==1'b0) (B1 +=> X)=(0:0:0, 0:0:0);
if (A1_N==1'b0&&A2_N==1'b1&&B2==1'b0) (B1 +=> X)=(0:0:0, 0:0:0);
if (A1_N==1'b1&&A2_N==1'b0&&B2==1'b0) (B1 +=> X)=(0:0:0, 0:0:0);
if (A1_N==1'b0&&A2_N==1'b0&&B1==1'b0) (B2 +=> X)=(0:0:0, 0:0:0);
if (A1_N==1'b0&&A2_N==1'b1&&B1==1'b0) (B2 +=> X)=(0:0:0, 0:0:0);
if (A1_N==1'b1&&A2_N==1'b0&&B1==1'b0) (B2 +=> X)=(0:0:0, 0:0:0);
endspecify
endmodule
`endcelldefine

`default_nettype wire
`endif  // SKY130_FD_SC_HDLL__O2BB2A_4_TIMING_PP_V
