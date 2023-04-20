const parseDevices = (pcmDevicesString) => {
  var pcmDevicesArray = pcmDevicesString
    .split("\n")
    .filter((line) => line != "");
  var pcmDevices = pcmDevicesArray.map((device) => {
    var splitDev = device.split(":");
    return {
      id:
        "plughw:" +
        splitDev[0]
          .split("-")
          .map((num) => parseInt(num, 10))
          .join(","),
      name: splitDev[2].trim(),
      output: splitDev.some((part) => part.includes("playback")),
      input: splitDev.some((part) => part.includes("capture")),
    };
  });

  outputs = pcmDevices.filter((dev) => dev.output);
  inputs = pcmDevices.filter((dev) => dev.input);
  
  return {outputs, inputs}
};

module.exports = {parseDevices};
