var uniqBy = require('lodash/uniqBy')

// Match on card number and name
const matcher = /(\d):.*\[(.*)\]/

const parse = (rawStr) => 
  rawStr.split("\n").filter((line) => line != "").map((device) => {
    const [_, id, name] = device.match(matcher)
    return {
      id: `plughw:${id},0`,
      name
    }
  })


const parseDevices = (outputsStr, inputsStr) => {
  const parsed = parse(`${outputsStr}\n${inputsStr}`).map(device => ({
    ...device,
    output: outputsStr.includes(device.name),
    input: inputsStr.includes(device.name)
  }))
  
  // Devices may appear twice
  const devices = uniqBy(parsed, device => device.id)
  
  const outputs = devices.filter(dev => dev.output);
  const inputs = devices.filter((dev) => dev.input)
  
  return {outputs, inputs}
};

module.exports = {parseDevices};
