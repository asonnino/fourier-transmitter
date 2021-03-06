# fourier-transmitter
[![license](https://img.shields.io/badge/license-GPL3-brightgreen.svg)](https://github.com/asonnino/fourier-transmitter/blob/master/LICENSE)

A variable FPGA-based QAM transmitter with scalable mixed time and frequency domain signal processing. Details and explanations can be found in the [paper](https://sonnino.com/papers/figuli2016variable.pdf).

The flexibility of Field Programmable Gate Arrays (FPGAs) as well as their parallel processing capabilities make them a good choice for digital signal processing in communication systems. However, today, further improvements in performance hang in mid-air as we run into the frequency wall and FPGA based devices are clocked below 1GHz. New methodologies which can cater performance optimization within the frequency wall limitation become highly essential. In this context, efficient modulation techniques like Quadrature Amplitude Modulation (QAM) and mixed time and frequency domain approach have been utilized in this paper to employ a generic scalable FPGA based QAM transmitter with the filter parallelization being executed in mixed domain. The system developed in this paper achieves a throughput of 4Gb/s for QAM-16 format with a clock frequency as low as 62.5MHz, thereby, paves down a promising methodology for applications where having higher clock frequencies is a hard limit.

A link to the full paper is available at the following address: [https://sonnino.com/papers/figuli2016variable.pdf](https://sonnino.com/papers/figuli2016variable.pdf).

This project is the result of my master thesis at the [Karlsruhe Institute of Technologies (KIT)](http://kit.edu), and is available [here](https://sonnino.com/theses/kit-master.pdf).

## Edits
An updated paper integrating forward error correction and achieving better performance is available [here](https://sonnino.com/papers/figuli2017generic.pdf).

## License
[The BSD license](https://opensource.org/licenses/BSD-3-Clause)
