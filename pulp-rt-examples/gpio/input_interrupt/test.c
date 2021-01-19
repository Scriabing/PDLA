/*
 * This example shows how to block the core until a GPIO
 * value has changed.
 */

#include <stdio.h>
#include <rt/rt_api.h>
#include <stdint.h>

#if PULP_CHIP == CHIP_GAP
#define GPIO 0
#else
#define GPIO 20
#endif

#define NB_EDGE 100

static int edges = 0;

static void gpio_handler(void *arg)
{
  edges++;
}

int main()
{
  if (rt_event_alloc(NULL, 1)) return -1;

  // GPIO initialization
  rt_gpio_init(0, GPIO);

  // Configure GPIO as an inpout
  rt_gpio_set_dir(0, 1<<GPIO, RT_GPIO_IS_IN);

  // Trigger notifications on both rising and falling edges
  rt_gpio_set_sensitivity(0, GPIO, RT_GPIO_SENSITIVITY_EDGE);

  // Set the event for the GPIO.
  // Note that we use an IRQ event instead of a normal one so that
  // the callback is called directly from the IRQ handler.
  rt_gpio_set_event(0, GPIO, rt_event_irq_get(gpio_handler, (void *)GPIO));

  // Now wait for a few edges and see how long it takes
  unsigned long long start = rt_time_get_us();

  while(edges < NB_EDGE)
  {
    rt_event_yield(NULL);
  }

  unsigned long long end = rt_time_get_us();
  
  printf("Got %d edges in %d us\n", NB_EDGE, end - start);

  return 0;
}
