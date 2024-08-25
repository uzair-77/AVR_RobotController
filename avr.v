#include <avr/io.h>
#define F_CPU 16000000UL
#include <util/delay.h>
#include <avr/interrupt.h>
#define firing_motor PD1
#define Buzzer_PIN PD0
#define SENSOR1_PIN PD2
#define SENSOR3_PIN PC4
#define LED1_PIN PC0
#define LED2_PIN PC1
#define LED3_PIN PC2
#define LED4_PIN PC3
int main(void)
{
DDRC = 0x0F; // Set all pins of PORTC as outputs for LEDs
PORTC = 0x00; // Turn off all LEDs initially
PORTC |= (1 << SENSOR3_PIN);
DDRD = 0xF3; // Set PD2 and PD3 as input, PD1 and PD4 as
output
PORTD |= (1 << SENSOR1_PIN);
EICRA |= (1 << ISC00) | (1 << ISC01); // Interrupt on rising edge for INT0
EIMSK |= (1 << INT0); // Enable external interrupt INT0
sei(); // Enable global interrupts
while (1)
{
if (PINC & (1 << SENSOR3_PIN)) // Check if switch at PC4 is HIGH
(not pressed)
{ PORTD = 0x50; // Set output pins PD1 and PD4 high
PORTC = (1 << LED1_PIN) | (1 << LED2_PIN);
}
else // Switch at PC4 is LOW (pressed)
{
// Stop and move backward for 1 second
PORTD = 0x00; // Stop both motors by setting all PD1-PD7 low
PORTC = (1 << LED3_PIN) | (1 << LED4_PIN);
PORTD |= (1 << Buzzer_PIN);
_delay_ms(30);
PORTD = 0xA0; // Set output pins PD1 and PD4 high
_delay_ms(500);
// Turn 90 degrees right (you need to adjust the timings depending on your
motor)
PORTD = 0x40;
// Assuming one motor moves forward and the other backward for a right turn
_delay_ms(30); // this delay for a 90-degree right turn
PORTD = 0x50; // Set output pins PD1 and PD4 high (assuming
these are connected to motor control)
PORTC = 0; //LED's off
}
}
}
// Interrupt Service Routine for INT0 (Obstacle detected by Sensor1)
ISR(INT0_vect)
{
cli(); // Disable global interrupts
PORTD = 0x00; // Stop both motors by setting all PD1-PD7 low
// Toggle LED1 (PC0) and LED2 (PC1)
for (int i = 0; i < 5; i++)
{
PORTC ^= (1 << LED1_PIN) | (1 << LED2_PIN);
PORTC ^= (1 << LED3_PIN) | (1 << LED4_PIN);
PORTD ^= (1 << Buzzer_PIN);
_delay_ms(25);
PORTD |= (1 << firing_motor);
}
PORTD = 0x50; // Set output pins PD1 and PD4 high
// Small delay to avoid re-triggering the interrupt immediately
EIMSK |= (1 << INT0); // Re-enable INT0 interrupt
sei(); // Enable global interrupts
}
// Interrupt Service Routine for INT1 (Obstacle detected by Sensor2)
