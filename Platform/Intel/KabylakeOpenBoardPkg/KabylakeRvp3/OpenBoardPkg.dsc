## @file
#  Platform description.
#
# Copyright (c) 2017, Intel Corporation. All rights reserved.<BR>
#
# This program and the accompanying materials are licensed and made available under
# the terms and conditions of the BSD License which accompanies this distribution.
# The full text of the license may be found at
# http://opensource.org/licenses/bsd-license.php
#
# THE PROGRAM IS DISTRIBUTED UNDER THE BSD LICENSE ON AN "AS IS" BASIS,
# WITHOUT WARRANTIES OR REPRESENTATIONS OF ANY KIND, EITHER EXPRESS OR IMPLIED.
#
##
[Defines]
  #
  # Set platform specific package/folder name, same as passed from PREBUILD script.
  # PLATFORM_PACKAGE would be the same as PLATFORM_NAME as well as package build folder
  # DEFINE only takes effect at R9 DSC and FDF.
  #
  DEFINE      PLATFORM_PACKAGE                = MinPlatformPkg
  DEFINE      PLATFORM_SI_PACKAGE             = KabylakeSiliconPkg
  DEFINE      PLATFORM_SI_BIN_PACKAGE         = KabylakeSiliconBinPkg
  DEFINE      PLATFORM_FSP_BIN_PACKAGE        = KabylakeFspBinPkg
  DEFINE      PLATFORM_BOARD_PACKAGE          = KabylakeOpenBoardPkg
  DEFINE      BOARD                           = KabylakeRvp3
  DEFINE      PROJECT                         = $(PLATFORM_BOARD_PACKAGE)/$(BOARD)

[PcdsFeatureFlag]
  #
  # Platform On/Off features are defined here
  #
  !include OpenBoardPkgConfig.dsc

################################################################################
#
# Defines Section - statements that will be processed to create a Makefile.
#
################################################################################
[Defines]
  PLATFORM_NAME                       = $(PLATFORM_PACKAGE)
  PLATFORM_GUID                       = 465B0A0B-7AC1-443b-8F67-7B8DEC145F90
  PLATFORM_VERSION                    = 0.1
  DSC_SPECIFICATION                   = 0x00010005
  OUTPUT_DIRECTORY                    = Build/$(PROJECT)
  SUPPORTED_ARCHITECTURES             = IA32|X64
  BUILD_TARGETS                       = DEBUG|RELEASE
  SKUID_IDENTIFIER                    = ALL


  FLASH_DEFINITION                    = $(PROJECT)/OpenBoardPkg.fdf

  FIX_LOAD_TOP_MEMORY_ADDRESS         = 0x0
  DEFINE   TOP_MEMORY_ADDRESS         = 0x0

  #
  # Default value for OpenBoardPkg.fdf use
  #
  DEFINE BIOS_SIZE_OPTION = SIZE_70

  DEFINE     TRACEHUB     =
  EDK_GLOBAL TRACEHUB     =

  DEFINE   COV_TOOLS                  = VS2008


################################################################################
#
# SKU Identification section - list of all SKU IDs supported by this
#                              Platform.
#
################################################################################
[SkuIds]
  0|DEFAULT              # The entry: 0|DEFAULT is reserved and always required.
  4|KabylakeRvp3
  0x60|KabyLakeYLpddr3Rvp3

################################################################################
#
# Library Class section - list of all Library Classes needed by this Platform.
#
################################################################################

!include $(PLATFORM_PACKAGE)/Include/Dsc/CoreCommonLib.dsc
!include $(PLATFORM_PACKAGE)/Include/Dsc/CorePeiLib.dsc
!include $(PLATFORM_PACKAGE)/Include/Dsc/CoreDxeLib.dsc

[LibraryClasses.common]

  PeiLib|$(PLATFORM_PACKAGE)/Library/PeiLib/PeiLib.inf

  PciHostBridgeLib|$(PLATFORM_PACKAGE)/Pci/Library/PciHostBridgeLibSimple/PciHostBridgeLibSimple.inf
  PlatformBootManagerLib|$(PLATFORM_PACKAGE)/Bds/Library/DxePlatformBootManagerLib/DxePlatformBootManagerLib.inf
  I2cAccessLib|$(PLATFORM_BOARD_PACKAGE)/Library/PeiI2cAccessLib/PeiI2cAccessLib.inf
  GpioExpanderLib|$(PLATFORM_BOARD_PACKAGE)/Library/BaseGpioExpanderLib/BaseGpioExpanderLib.inf

  PlatformHookLib|$(PROJECT)/Library/BasePlatformHookLib/BasePlatformHookLib.inf

  FspWrapperHobProcessLib|$(PLATFORM_PACKAGE)/FspWrapper/Library/PeiFspWrapperHobProcessLib/PeiFspWrapperHobProcessLib.inf
  PlatformSecLib|$(PLATFORM_PACKAGE)/FspWrapper/Library/SecFspWrapperPlatformSecLib/SecFspWrapperPlatformSecLib.inf
  
  FspWrapperApiLib|IntelFsp2WrapperPkg/Library/BaseFspWrapperApiLib/BaseFspWrapperApiLib.inf
  FspWrapperApiTestLib|IntelFsp2WrapperPkg/Library/PeiFspWrapperApiTestLib/PeiFspWrapperApiTestLib.inf

  FspWrapperPlatformLib|$(PLATFORM_PACKAGE)/FspWrapper/Library/PeiFspWrapperPlatformLib/PeiFspWrapperPlatformLib.inf
  SiliconPolicyInitLib|$(PLATFORM_SI_PACKAGE)/Library/PeiSiliconPolicyInitLibFsp/PeiSiliconPolicyInitLibFsp.inf
  SiliconPolicyUpdateLib|$(PLATFORM_BOARD_PACKAGE)/FspWrapper/Library/PeiSiliconPolicyUpdateLibFsp/PeiSiliconPolicyUpdateLibFsp.inf

  ConfigBlockLib|$(PLATFORM_SI_PACKAGE)/Library/BaseConfigBlockLib/BaseConfigBlockLib.inf
  SiliconInitLib|$(PLATFORM_SI_PACKAGE)/Library/SiliconInitLib/SiliconInitLib.inf

  BoardInitLib|$(PLATFORM_PACKAGE)/PlatformInit/Library/BoardInitLibNull/BoardInitLibNull.inf
  TestPointCheckLib|$(PLATFORM_PACKAGE)/Test/Library/TestPointCheckLibNull/TestPointCheckLibNull.inf

#
# Silicon Init Package
#
!include $(PLATFORM_SI_PACKAGE)/SiPkgCommonLib.dsc

[LibraryClasses.IA32]
  #
  # PEI phase common
  #
  FspWrapperPlatformLib|$(PLATFORM_PACKAGE)/FspWrapper/Library/PeiFspWrapperPlatformLib/PeiFspWrapperPlatformLib.inf
!if $(TARGET) == DEBUG
  TestPointCheckLib|$(PLATFORM_PACKAGE)/Test/Library/TestPointCheckLib/PeiTestPointCheckLib.inf
!endif
  TestPointLib|$(PLATFORM_PACKAGE)/Test/Library/TestPointLib/PeiTestPointLib.inf
  MultiBoardInitSupportLib|$(PLATFORM_PACKAGE)/PlatformInit/Library/MultiBoardInitSupportLib/PeiMultiBoardInitSupportLib.inf
  BoardInitLib|$(PLATFORM_PACKAGE)/PlatformInit/Library/MultiBoardInitSupportLib/PeiMultiBoardInitSupportLib.inf

#
# Silicon Init Package
#
!include $(PLATFORM_SI_PACKAGE)/SiPkgPeiLib.dsc

[LibraryClasses.IA32.SEC]
  TestPointCheckLib|$(PLATFORM_PACKAGE)/Test/Library/TestPointCheckLib/SecTestPointCheckLib.inf
  SecBoardInitLib|$(PLATFORM_PACKAGE)/PlatformInit/Library/SecBoardInitLibNull/SecBoardInitLibNull.inf

[LibraryClasses.X64]
  #
  # DXE phase common
  #
  FspWrapperPlatformLib|$(PLATFORM_PACKAGE)/FspWrapper/Library/DxeFspWrapperPlatformLib/DxeFspWrapperPlatformLib.inf
!if $(TARGET) == DEBUG
  TestPointCheckLib|$(PLATFORM_PACKAGE)/Test/Library/TestPointCheckLib/DxeTestPointCheckLib.inf
!endif
  TestPointLib|$(PLATFORM_PACKAGE)/Test/Library/TestPointLib/DxeTestPointLib.inf
  MultiBoardInitSupportLib|$(PLATFORM_PACKAGE)/PlatformInit/Library/MultiBoardInitSupportLib/DxeMultiBoardInitSupportLib.inf
  BoardInitLib|$(PLATFORM_PACKAGE)/PlatformInit/Library/MultiBoardInitSupportLib/DxeMultiBoardInitSupportLib.inf
  MultiBoardAcpiSupportLib|$(PLATFORM_PACKAGE)/Acpi/Library/MultiBoardAcpiSupportLib/DxeMultiBoardAcpiSupportLib.inf
  BoardAcpiTableLib|$(PLATFORM_PACKAGE)/Acpi/Library/MultiBoardAcpiSupportLib/DxeMultiBoardAcpiSupportLib.inf

  SiliconPolicyInitLib|$(PLATFORM_SI_PACKAGE)/Library/DxeSiliconPolicyInitLib/DxeSiliconPolicyInitLib.inf
  SiliconPolicyUpdateLib|$(PLATFORM_BOARD_PACKAGE)/Policy/Library/DxeSiliconPolicyUpdateLib/DxeSiliconPolicyUpdateLib.inf

#
# Silicon Init Package
#
!include $(PLATFORM_SI_PACKAGE)/SiPkgDxeLib.dsc

[LibraryClasses.X64.DXE_SMM_DRIVER]
  SpiFlashCommonLib|$(PLATFORM_SI_PACKAGE)/Pch/Library/SmmSpiFlashCommonLib/SmmSpiFlashCommonLib.inf
!if $(TARGET) == DEBUG
  TestPointCheckLib|$(PLATFORM_PACKAGE)/Test/Library/TestPointCheckLib/SmmTestPointCheckLib.inf
!endif
  TestPointLib|$(PLATFORM_PACKAGE)/Test/Library/TestPointLib/SmmTestPointLib.inf
  MultiBoardAcpiSupportLib|$(PLATFORM_PACKAGE)/Acpi/Library/MultiBoardAcpiSupportLib/SmmMultiBoardAcpiSupportLib.inf
  BoardAcpiEnableLib|$(PLATFORM_PACKAGE)/Acpi/Library/MultiBoardAcpiSupportLib/SmmMultiBoardAcpiSupportLib.inf

[LibraryClasses.X64.DXE_RUNTIME_DRIVER]
  ResetSystemLib|$(PLATFORM_SI_PACKAGE)/Pch/Library/DxeRuntimeResetSystemLib/DxeRuntimeResetSystemLib.inf

!include OpenBoardPkgPcd.dsc

[Components.IA32]

!include $(PLATFORM_PACKAGE)/Include/Dsc/CorePeiInclude.dsc

  $(PLATFORM_PACKAGE)/PlatformInit/PlatformInitPei/PlatformInitPreMem.inf {
    <LibraryClasses>
!if gBoardModuleTokenSpaceGuid.PcdMultiBoardSupport == FALSE
      BoardInitLib|$(PROJECT)/Library/BoardInitLib/PeiBoardInitPreMemLib.inf
!else
      NULL|$(PROJECT)/Library/BoardInitLib/PeiMultiBoardInitPreMemLib.inf
!endif
  }

  $(PLATFORM_PACKAGE)/PlatformInit/PlatformInitPei/PlatformInitPostMem.inf {
    <LibraryClasses>
!if gBoardModuleTokenSpaceGuid.PcdMultiBoardSupport == FALSE
      BoardInitLib|$(PROJECT)/Library/BoardInitLib/PeiBoardInitPostMemLib.inf
!else
      NULL|$(PROJECT)/Library/BoardInitLib/PeiMultiBoardInitPostMemLib.inf
!endif
  }
  
  IntelFsp2WrapperPkg/FspmWrapperPeim/FspmWrapperPeim.inf
  IntelFsp2WrapperPkg/FspsWrapperPeim/FspsWrapperPeim.inf

!if gPlatformModuleTokenSpaceGuid.PcdTpm2Enable == TRUE
  $(PLATFORM_PACKAGE)/Tcg/Tcg2PlatformPei/Tcg2PlatformPei.inf
!endif

#
# Silicon Init Package
#
!include $(PLATFORM_SI_PACKAGE)/SiPkgPei.dsc

[Components.X64]

!include $(PLATFORM_PACKAGE)/Include/Dsc/CoreDxeInclude.dsc

#
# Silicon Init Package
#
!include $(PLATFORM_SI_PACKAGE)/SiPkgDxe.dsc

  $(PLATFORM_PACKAGE)/PlatformInit/SiliconPolicyDxe/SiliconPolicyDxe.inf
  $(PLATFORM_PACKAGE)/PlatformInit/PlatformInitDxe/PlatformInitDxe.inf {
    <LibraryClasses>
!if $(TARGET) == DEBUG
      # Use serial debug lib here to print debug message in OsLoader progress code.
      DebugLib|MdePkg/Library/BaseDebugLibSerialPort/BaseDebugLibSerialPort.inf
!endif
  }

!if gPlatformModuleTokenSpaceGuid.PcdBootToShellOnly == FALSE
  $(PLATFORM_PACKAGE)/Acpi/AcpiTables/AcpiPlatform.inf {
    <LibraryClasses>
!if gBoardModuleTokenSpaceGuid.PcdMultiBoardSupport == FALSE
      BoardAcpiTableLib|$(PROJECT)/Library/BoardAcpiLib/DxeBoardAcpiTableLib.inf
!else
      NULL|$(PROJECT)/Library/BoardAcpiLib/DxeMultiBoardAcpiSupportLib.inf
!endif
  }
  $(PLATFORM_BOARD_PACKAGE)/Acpi/BoardAcpiDxe/BoardAcpiDxe.inf {
    <LibraryClasses>
!if gBoardModuleTokenSpaceGuid.PcdMultiBoardSupport == FALSE
      BoardAcpiTableLib|$(PROJECT)/Library/BoardAcpiLib/DxeBoardAcpiTableLib.inf
!else
      NULL|$(PROJECT)/Library/BoardAcpiLib/DxeMultiBoardAcpiSupportLib.inf
!endif
  }
  $(PLATFORM_PACKAGE)/Acpi/AcpiSmm/AcpiSmm.inf {
    <LibraryClasses>
!if gBoardModuleTokenSpaceGuid.PcdMultiBoardSupport == FALSE
      BoardAcpiEnableLib|$(PROJECT)/Library/BoardAcpiLib/SmmBoardAcpiEnableLib.inf
!else
      NULL|$(PROJECT)/Library/BoardAcpiLib/SmmMultiBoardAcpiSupportLib.inf
!endif
  }

  $(PLATFORM_PACKAGE)/Flash/SpiFvbService/SpiFvbServiceSmm.inf
  $(PLATFORM_PACKAGE)/PlatformInit/PlatformInitSmm/PlatformInitSmm.inf
!endif

  IntelFsp2WrapperPkg/FspWrapperNotifyDxe/FspWrapperNotifyDxe.inf
  $(PLATFORM_PACKAGE)/FspWrapper/SaveMemoryConfig/SaveMemoryConfig.inf

  $(PLATFORM_PACKAGE)/Hsti/HstiIbvPlatformDxe/HstiIbvPlatformDxe.inf
  
  $(PLATFORM_PACKAGE)/Test/TestPointDumpApp/TestPointDumpApp.inf

!if gPlatformModuleTokenSpaceGuid.PcdTpm2Enable == TRUE
  $(PLATFORM_PACKAGE)/Tcg/Tcg2PlatformDxe/Tcg2PlatformDxe.inf
!endif

  IntelSiliconPkg/IntelVTdDxe/IntelVTdDxe.inf

  $(PLATFORM_SI_BIN_PACKAGE)/Microcode/MicrocodeUpdates.inf
  
  ShellBinPkg/UefiShell/UefiShell.inf

!include $(PLATFORM_SI_PACKAGE)/SiPkgBuildOption.dsc
!include OpenBoardPkgBuildOption.dsc