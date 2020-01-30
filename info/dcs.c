#include <stdio.h>

/* Digital-Coded Squelch values */

/*  3         2         1         0
 * 10987654321098765432109876543210
 * 000000000PPPPPPPPPPP100CCCCCCCCC
 *          10987654321   987654321
 *           1        0           0 */

/* Golay (23,12) code, NRZ Tx/Rx, turn off code is 268.6 bps
 * 23 bits:  3 bits fixed, 9 bits data, 11 bits parity sent at 134.3 bps
 * 2^9 bits data => 512 possible values, only 83 to 104 are typically used */

/* Unconfirmed:  There are no sync bits and the baud rate is 134.4 or 136.
 * Unconfirmed:  Each bit is 7.5 msec in length, for a total of 172.5 msec. */

/* http://mmi-comm.tripod.com/dcs.html
 * http://homepage.ntlworld.com/tony.ling/radio/ic-r20/R20um21.htm */

void bit_dump (short int input);

int main (int argc, char **argv)
{
  int i = 0;

  for (i = 0 ; i < 512 ; i++) bit_dump(i);
}

void bit_dump (short int input)
{
  short int c1  = (input & 0x00000001) >> 0;
  short int c2  = (input & 0x00000002) >> 1;
  short int c3  = (input & 0x00000004) >> 2;
  short int c4  = (input & 0x00000008) >> 3;
  short int c5  = (input & 0x00000010) >> 4;
  short int c6  = (input & 0x00000020) >> 5;
  short int c7  = (input & 0x00000040) >> 6;
  short int c8  = (input & 0x00000080) >> 7;
  short int c9  = (input & 0x00000100) >> 8;

  short int p1  = c1 ^ c2 ^ c3 ^ c4 ^ c5 ^ c8; if (0 != p1) p1 = 1; else p1 = 0;
  short int p2  = c2 ^ c3 ^ c4 ^ c5 ^ c6 ^ c9; if (0 != p2) p2 = 0; else p2 = 1;
  short int p3  = c1 ^ c2 ^ c6 ^ c7 ^ c8; if (0 != p3) p3 = 1; else p3 = 0;
  short int p4  = c2 ^ c3 ^ c7 ^ c8 ^ c9; if (0 != p4) p4 = 0; else p4 = 1;
  short int p5  = c1 ^ c2 ^ c5 ^ c9; if (0 != p5) p5 = 0; else p5 = 1;
  short int p6  = c1 ^ c4 ^ c5 ^ c6 ^ c8; if (0 != p6) p6 = 0; else p6 = 1;
  short int p7  = c1 ^ c3 ^ c4 ^ c6 ^ c7 ^ c8 ^ c9; if (0 != p7) p7 = 1; else p7 = 0;
  short int p8  = c2 ^ c4 ^ c5 ^ c7 ^ c8 ^ c9; if (0 != p8) p8 = 1; else p8 = 0;
  short int p9  = c3 ^ c5 ^ c6 ^ c8 ^ c9;  if (0 != p9) p9 = 1; else p9 = 0;
  short int p10 = c4 ^ c6 ^ c7 ^ c9; if (0 != p10) p10 = 0; else p10 = 1;
  short int p11 = c1 ^ c2 ^ c3 ^ c4 ^ c7; if (0 != p11) p11 = 0; else p11 = 1;

  printf ("+%0.3o => 0", input);
  if (0 != p11) printf ("1"); else printf ("0");
  if (0 != p10) printf ("1"); else printf ("0");
  if (0 != p9)  printf ("1"); else printf ("0");
  if (0 != p8)  printf ("1"); else printf ("0");
  if (0 != p7)  printf ("1"); else printf ("0");
  if (0 != p6)  printf ("1"); else printf ("0");
  if (0 != p5)  printf ("1"); else printf ("0"); printf (" ");
  if (0 != p4)  printf ("1"); else printf ("0");
  if (0 != p3)  printf ("1"); else printf ("0");
  if (0 != p2)  printf ("1"); else printf ("0");
  if (0 != p1)  printf ("1"); else printf ("0"); printf ("100");
  if (0 != c9)  printf ("1"); else printf ("0"); printf (" ");
  if (0 != c8)  printf ("1"); else printf ("0");
  if (0 != c7)  printf ("1"); else printf ("0");
  if (0 != c6)  printf ("1"); else printf ("0");
  if (0 != c5)  printf ("1"); else printf ("0");
  if (0 != c4)  printf ("1"); else printf ("0");
  if (0 != c3)  printf ("1"); else printf ("0");
  if (0 != c2)  printf ("1"); else printf ("0");
  if (0 != c1)  printf ("1"); else printf ("0"); printf ("\n");
}
