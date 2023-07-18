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


`ifndef SKY130_FD_SC_HDLL__AND4BB_2_FUNCTIONAL_V
`define SKY130_FD_SC_HDLL__AND4BB_2_FUNCTIONAL_V

/**
 * and4bb: 4-input AND, first two inputs inverted.
 *
 * Verilog simulation functional model.
 */

`timescale 1ns / 1ps
`default_nettype none

`celldefine
module sky130_fd_sc_hdll__and4bb_2 (
    X  ,
    A_N,
    B_N,
    C  ,
    D
);

    // Module ports
    output X  ;
    input  A_N;
    input  B_N;
    input  C  ;
    input  D  ;

    // Local signals
    wire nor0_out  ;
    wire and0_out_X;

    //  Name  Output      Other arguments
    nor nor0 (nor0_out  , A_N, B_N       );
    and and0 (and0_out_X, nor0_out, C, D );
    buf buf0 (X         , and0_out_X     );

endmodule
`endcelldefine

`default_nettype wire
`endif  // SKY130_FD_SC_HDLL__AND4BB_2_FUNCTIONAL_V
