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


`ifndef SKY130_FD_SC_HDLL__O21BA_1_TIMING_PP_V
`define SKY130_FD_SC_HDLL__O21BA_1_TIMING_PP_V

/**
 * o21ba: 2-input OR into first input of 2-input AND,
 *        2nd input inverted.
 *
 *        X = ((A1 | A2) & !B1_N)
 *
 * Verilog simulation timing model.
 */

`timescale 1ns / 1ps
`default_nettype none

// Import user defined primitives.
`include "../../models/udp_pwrgood_pp_pg/sky130_fd_sc_hdll__udp_pwrgood_pp_pg.v"

`celldefine
module sky130_fd_sc_hdll__o21ba_1 (
    X   ,
    A1  ,
    A2  ,
    B1_N,
    VPWR,
    VGND,
    VPB ,
    VNB
);

    // Module ports
    output X   ;
    input  A1  ;
    input  A2  ;
    input  B1_N;
    input  VPWR;
    input  VGND;
    input  VPB ;
    input  VNB ;

    // Local signals
    wire nor0_out         ;
    wire nor1_out_X       ;
    wire pwrgood_pp0_out_X;

    //                                   Name         Output             Other arguments
    nor                                  nor0        (nor0_out         , A1, A2                );
    nor                                  nor1        (nor1_out_X       , B1_N, nor0_out        );
    sky130_fd_sc_hdll__udp_pwrgood_pp$PG pwrgood_pp0 (pwrgood_pp0_out_X, nor1_out_X, VPWR, VGND);
    buf                                  buf0        (X                , pwrgood_pp0_out_X     );

specify
if (A2==1'b0&&B1_N==1'b0) (A1 +=> X)=(0:0:0, 0:0:0);
if (A1==1'b0&&B1_N==1'b0) (A2 +=> X)=(0:0:0, 0:0:0);
if (A1==1'b0&&A2==1'b1) (B1_N -=> X)=(0:0:0, 0:0:0);
if (A1==1'b1&&A2==1'b0) (B1_N -=> X)=(0:0:0, 0:0:0);
if (A1==1'b1&&A2==1'b1) (B1_N -=> X)=(0:0:0, 0:0:0);
endspecify
endmodule
`endcelldefine

`default_nettype wire
`endif  // SKY130_FD_SC_HDLL__O21BA_1_TIMING_PP_V