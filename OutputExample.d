/****************************************************************************************
  * Flash configuration field
*/
final abstract class FTFA_FlashConfig: Peripheral!(0x400)
{
  /**************************************************************************************
  * Backdoor Comparison Key 3.
  */
  final abstract class BACKKEY3  : Register!(0  , Access.read_only8)
  {
    /************************************************************************************
    Backdoor Comparison Key.
    */
    alias KEY =   BitField!(8, 0, Mutability.read_only);

  }
  /**************************************************************************************
  * Backdoor Comparison Key 2.
  */
  final abstract class BACKKEY2  : Register!(0x1  , Access.read_only8)
  {
    /************************************************************************************
    Backdoor Comparison Key.
    */
    alias KEY =   BitField!(8, 0, Mutability.read_only);

  }
  /**************************************************************************************
  * Backdoor Comparison Key 1.
  */
  final abstract class BACKKEY1  : Register!(0x2  , Access.read_only8)
  {
    /************************************************************************************
    Backdoor Comparison Key.
    */
    alias KEY =   BitField!(8, 0, Mutability.read_only);

  }
  /**************************************************************************************
  * Backdoor Comparison Key 0.
  */
  final abstract class BACKKEY0  : Register!(0x3  , Access.read_only8)
  {
    /************************************************************************************
    Backdoor Comparison Key.
    */
    alias KEY =   BitField!(8, 0, Mutability.read_only);

  }
  /**************************************************************************************
  * Backdoor Comparison Key 7.
  */
  final abstract class BACKKEY7  : Register!(0x4  , Access.read_only8)
  {
    /************************************************************************************
    Backdoor Comparison Key.
    */
    alias KEY =   BitField!(8, 0, Mutability.read_only);

  }
  /**************************************************************************************
  * Backdoor Comparison Key 6.
  */
  final abstract class BACKKEY6  : Register!(0x5  , Access.read_only8)
  {
    /************************************************************************************
    Backdoor Comparison Key.
    */
    alias KEY =   BitField!(8, 0, Mutability.read_only);

  }
  /**************************************************************************************
  * Backdoor Comparison Key 5.
  */
  final abstract class BACKKEY5  : Register!(0x6  , Access.read_only8)
  {
    /************************************************************************************
    Backdoor Comparison Key.
    */
    alias KEY =   BitField!(8, 0, Mutability.read_only);

  }
  /**************************************************************************************
  * Backdoor Comparison Key 4.
  */
  final abstract class BACKKEY4  : Register!(0x7  , Access.read_only8)
  {
    /************************************************************************************
    Backdoor Comparison Key.
    */
    alias KEY =   BitField!(8, 0, Mutability.read_only);

  }
  /**************************************************************************************
  * Non-volatile P-Flash Protection 1 - Low Register
  */
  final abstract class FPROT3  : Register!(0x8  , Access.read_only8)
  {
    /************************************************************************************
    P-Flash Region Protect
    */
    alias PROT =   BitField!(8, 0, Mutability.read_only);

  }
  /**************************************************************************************
  * Non-volatile P-Flash Protection 1 - High Register
  */
  final abstract class FPROT2  : Register!(0x9  , Access.read_only8)
  {
    /************************************************************************************
    P-Flash Region Protect
    */
    alias PROT =   BitField!(8, 0, Mutability.read_only);

  }
  /**************************************************************************************
  * Non-volatile P-Flash Protection 0 - Low Register
  */
  final abstract class FPROT1  : Register!(0xA  , Access.read_only8)
  {
    /************************************************************************************
    P-Flash Region Protect
    */
    alias PROT =   BitField!(8, 0, Mutability.read_only);

  }
  /**************************************************************************************
  * Non-volatile P-Flash Protection 0 - High Register
  */
  final abstract class FPROT0  : Register!(0xB  , Access.read_only8)
  {
    /************************************************************************************
    P-Flash Region Protect
    */
    alias PROT =   BitField!(8, 0, Mutability.read_only);

  }
  /**************************************************************************************
  * Non-volatile Flash Security Register
  */
  final abstract class FSEC  : Register!(0xC  , Access.read_only8)
  {
    /************************************************************************************
    Flash Security
      10  #10  MCU security status is unsecure
      11  #11  MCU security status is secure
    */
    alias SEC =   BitField!(2, 0, Mutability.read_only);

    /************************************************************************************
    Freescale Failure Analysis Access Code
      10  #10  Freescale factory access denied
      11  #11  Freescale factory access granted
    */
    alias FSLACC =   BitField!(4, 2, Mutability.read_only);

    /************************************************************************************
    no description available
      10  #10  Mass erase is disabled
      11  #11  Mass erase is enabled
    */
    alias MEEN =   BitField!(6, 4, Mutability.read_only);

    /************************************************************************************
    Backdoor Key Security Enable
      10  #10  Backdoor key access enabled
      11  #11  Backdoor key access disabled
    */
    alias KEYEN =   BitField!(8, 6, Mutability.read_only);

  }
  /**************************************************************************************
  * Non-volatile Flash Option Register
  */
  final abstract class FOPT  : Register!(0xD  , Access.read_only8)
  {
    /************************************************************************************
    no description available
      00  #00  Core and system clock divider (OUTDIV1) is 0x7 (divide by 8) when LPBOOT1=0 or 0x1 (divide by 2) when LPBOOT1=1.
      01  #01  Core and system clock divider (OUTDIV1) is 0x3 (divide by 4) when LPBOOT1=0 or 0x0 (divide by 1) when LPBOOT1=1.
    */
    alias LPBOOT0 =   Bit!(1, Mutability.read_only);

    /************************************************************************************
    no description available
      00  #00  NMI interrupts are always blocked
      01  #01  NMI_b pin/interrupts reset default to enabled
    */
    alias NMI_DIS =   Bit!(3, Mutability.read_only);

    /************************************************************************************
    no description available
      00  #00  RESET pin is disabled following a POR and cannot be enabled as reset function
      01  #01  RESET_b pin is dedicated
    */
    alias RESET_PIN_CFG =   Bit!(4, Mutability.read_only);

    /************************************************************************************
    no description available
      00  #00  Core and system clock divider (OUTDIV1) is 0x7 (divide by 8) when LPBOOT0=0 or 0x3 (divide by 4) when LPBOOT0=1.
      01  #01  Core and system clock divider (OUTDIV1) is 0x1 (divide by 2) when LPBOOT0=0 or 0x0 (divide by 1) when LPBOOT0=1.
    */
    alias LPBOOT1 =   Bit!(5, Mutability.read_only);

    /************************************************************************************
    no description available
      00  #00  Slower initialization
      01  #01  Fast Initialization
    */
    alias FAST_INIT =   Bit!(6, Mutability.read_only);

  }
}
