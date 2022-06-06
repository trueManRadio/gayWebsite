/*
 * Copyright (c) True Man Radio, 2022
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

void loudlyThrow(String text) {
  // ignore: avoid_print
  print("FATAL: $text");
  throw (text);
}

void printWarning(String text) {
  // ignore: avoid_print
  print("WARNING: $text");
}
