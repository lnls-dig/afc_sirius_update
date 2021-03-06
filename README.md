# AFC MMC Remote Update Tool
Shell script to remotely update the MMC firmware of AFC boards in Sirius' BPM system.

## Usage

### mmc-update.sh
Before executing the `mmc-update.sh` script you should compile the `hpm-downloader` utility:

```bash
$ git submodule update --init
$ cd hpm-downloader
$ # Make sure you have libssl-dev installed
$ make
$ cd ..
```

Then invoke `mmc-update.sh` :

```bash
$ ./mmc-update.sh afc-sirius-list afc-bpm-fw.bin afc-timing-fw.bin
```

Where `afc-bpm-fw.bin` and `afc-timing-fw.bin` are the openMMC application binary files for each board variant. This utility only works with raw binary images, do not try uploading elf files or you will have a bad time.

### mmc-update-from-release.sh
You can use the `mmc-update-from-release.sh` script to get the update files directly from the [openMMC releases page](https://github.com/lnls-dig/openMMC/releases). This script will download the required binaries, do an integrity check and update the boards specified in the AFCs list file:

```bash
$ ./mmc-update-from-release.sh afc-sirius-list v1.4.4
```

## AFCs List File
The provided afc-sirius-list file include the current AFC and racks configuration installed at Sirius. Each line specifies the crate configuration for each rack. Its syntax is presented bellow:

```
IA-01RaBPM-CO-CrateCtrl          1            7,8,9,10,11
   [MCH hostname/ip]     [AFC Timing slot]  [AFC BPM slots]
```

If you don't want to update AFC Timing boards or AFC BPM boards, mark its respective slot list field with an `n`:

```
IA-01RaBPM-CO-CrateCtrl n 7,8,9,10,11 (only update the bpm boards)
```
