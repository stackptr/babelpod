var {parseDevices} = require('./../app/pcm')

const mockPcmDevicesString = `00-00: bcm2835 Headphones : bcm2835 Headphones : playback 8
01-00: MAI PCM i2s-hifi-0 : MAI PCM i2s-hifi-0 : playback 1
02-00: USB Audio : USB Audio : playback 1 : capture 1`

describe('parseDevices', () => {
  it('returns inputs and outputs', () => {
    const result = parseDevices(mockPcmDevicesString)
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