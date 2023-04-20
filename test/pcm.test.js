var {parseDevices} = require('./../app/pcm')

const mockPcmOutputs = `card 0: Headphones [bcm2835 Headphones], device 0: bcm2835 Headphones [bcm2835 Headphones]
card 1: vc4hdmi [vc4-hdmi], device 0: MAI PCM i2s-hifi-0 [MAI PCM i2s-hifi-0]
card 2: CODEC [USB Audio CODEC], device 0: USB Audio [USB Audio]`

const mockPcmInputs = `card 2: CODEC [USB Audio CODEC], device 0: USB Audio [USB Audio]`

describe('parseDevices', () => {
  it('returns inputs and outputs', () => {
    const result = parseDevices(mockPcmOutputs, mockPcmInputs)
    expect(result).toEqual({
      outputs: [
        {
          id: 'plughw:0,0',
          name: 'bcm2835 Headphones',
          output: true,
          input: false
        },
        {
          id: 'plughw:1,0',
          name: 'MAI PCM i2s-hifi-0',
          output: true,
          input: false
        },
        { id: 'plughw:2,0', name: 'USB Audio', output: true, input: true }
      ],
      inputs: [
        { id: 'plughw:2,0', name: 'USB Audio', output: true, input: true }
      ]
    })
  })
})