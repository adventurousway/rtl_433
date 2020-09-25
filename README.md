# rtl_433

Lightweight Docker image based on Alpine linux for running [rtl_433](https://github.com/merbanan/rtl_433).

## Tags

Versioned tags follow the [tags of the `rtl_433` repository](https://github.com/merbanan/rtl_433/releases).

For instance,  `adventurousway/rtl_433:20.02` points to the [20.02](https://github.com/merbanan/rtl_433/releases/tag/20.02) tag for `rtl_433`.

There are two additional canonical tags available:

* `stable` points to the most recent release tag of `rtl_433`
* `latest` points to `HEAD` of the `rtl_433` master branch

## Running

The `entrypoint` is `rtl_433` so any arguments passed through go directly to `rtl_433`.

To run it in interactive mode with default arguments, use the following:

```sh
docker run -it --device "/path/to/usb/device" adventurousway/rtl_433
```

### USB Device

In order for `rtl_433` to access the RTL-SDR, the device needs to be mapped through. Unfortunately USB device pass-through is only natively supported on Linux.

To find the path of your RTL-SDR device, plug it into a USB port and run `lsusb`. The output will look something like the following:

```sh
$ lsusb
Bus 004 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
Bus 003 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
Bus 001 Device 005: ID 0bda:2838 Realtek Semiconductor Corp. RTL2838 DVB-T
Bus 001 Device 003: ID 8087:0aaa Intel Corp. 
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
```

The important line is the one that includes `RTL2838`, showing that the RTL-SDR has been mounted on `Bus 001 Device 005`.

This maps as `/dev/bus/usb/<BUS>/<DEVICE>` so in this example the correct path to the RTL-SDR USB device would be:

```
/dev/bus/usb/001/005
```

So the full command to run `rtl_433` with that device would be:

```sh
docker run -it --device "/dev/bus/usb/001/005" adventurousway/rtl_433
```

## Limitations

There are some known limitation of this image.

### RTL-SDR

Note that SoapySDR is not supported, so this only works with RTL-SDR devices.

### Linux only

Docker only runs natively in Linux whereas in other operating systems (e.g. MacOS and Windows) it runs in a hypervisor. These don't natively support USB device pass-through, although you may be able to work around this by using Docker Machine.

## Source

The source for this Docker image can be found at: https://github.com/adventurousway/rtl_433
