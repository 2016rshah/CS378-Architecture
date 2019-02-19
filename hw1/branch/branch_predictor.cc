#include "ooo_cpu.h"

int k;
int counter;

/*
 * This method is called once before any other methods,
 * allowing you to initialize anything you want.
 */
void O3_CPU::initialize_branch_predictor() {
  k = 20;
}

/*
 * "pc" is the address of the last branch in memory
 */
uint8_t O3_CPU::predict_branch(uint64_t pc)
{
    /*
     * Your prediction code goes here.
     *
     * Return true or false to indicate taken or not taken.
     * Stick to simple structures like arrays to record information,
     * but feel free to experiment with the size of your tables.
     */
  // The branch predictor predicts the common case for the last k branch outcomes for every branch. You are encouraged to try different values of k to find the configuration with the best performance.
  return (counter >> (k-1)) & 1;
}

/*
 * "pc" is the address of the last branch in memory
 * taken is a boolean indicating taken or not taken
 */
void O3_CPU::last_branch_result(uint64_t pc, uint8_t taken) {
  if(taken) {
    counter += 1;
    counter = min(counter, (1 << k) - 1); // 1 << k is 2^k so saturate to that value
  } else {
    counter -= 1;
    counter = max(counter, 0);
  }
}
