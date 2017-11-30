/** @file
  Register names for PCH DCI device

  Conventions:

  - Prefixes:
    Definitions beginning with "R_" are registers
    Definitions beginning with "B_" are bits within registers
    Definitions beginning with "V_" are meaningful values within the bits
    Definitions beginning with "S_" are register sizes
    Definitions beginning with "N_" are the bit position
  - In general, PCH registers are denoted by "_PCH_" in register names
  - Registers / bits that are different between PCH generations are denoted by
    "_PCH_[generation_name]_" in register/bit names.
  - Registers / bits that are specific to PCH-H denoted by "_H_" in register/bit names.
    Registers / bits that are specific to PCH-LP denoted by "_LP_" in register/bit names.
    e.g., "_PCH_H_", "_PCH_LP_"
    Registers / bits names without _H_ or _LP_ apply for both H and LP.
  - Registers / bits that are different between SKUs are denoted by "_[SKU_name]"
    at the end of the register/bit names
  - Registers / bits of new devices introduced in a PCH generation will be just named
    as "_PCH_" without [generation_name] inserted.

Copyright (c) 2017, Intel Corporation. All rights reserved.<BR>
This program and the accompanying materials are licensed and made available under
the terms and conditions of the BSD License that accompanies this distribution.
The full text of the license may be found at
http://opensource.org/licenses/bsd-license.php.

THE PROGRAM IS DISTRIBUTED UNDER THE BSD LICENSE ON AN "AS IS" BASIS,
WITHOUT WARRANTIES OR REPRESENTATIONS OF ANY KIND, EITHER EXPRESS OR IMPLIED.

**/
#ifndef _PCH_REGS_DCI_H_
#define _PCH_REGS_DCI_H_

//
// DCI PCR Registers
//
#define R_PCH_PCR_DCI_ECTRL                       0x04            ///< DCI Control Register
#define B_PCH_PCR_DCI_ECTRL_HDCIEN                BIT4            ///< Host DCI enable
#define B_PCH_PCR_DCI_ECTRL_HDCIEN_LOCK           BIT0            ///< Host DCI Enable Lock
#define R_PCH_PCR_DCI_ECKPWRCTL                   0x08            ///< DCI Power Control
#define R_PCH_PCR_DCI_PCE                         0x30            ///< DCI Power Control Enable Register
#define B_PCH_PCR_DCI_PCE_HAE                     BIT5            ///< Hardware Autonomous Enable
#define B_PCH_PCR_DCI_PCE_D3HE                    BIT2            ///< D3-Hot Enable
#define B_PCH_PCR_DCI_PCE_I3E                     BIT1            ///< I3 Enable
#define B_PCH_PCR_DCI_PCE_PMCRE                   BIT0            ///< PMC Request Enable

#endif