Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F0DDC433EF
	for <linux-cxl@archiver.kernel.org>; Mon, 24 Jan 2022 17:17:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbiAXRRI (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 24 Jan 2022 12:17:08 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4445 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231818AbiAXRRF (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 24 Jan 2022 12:17:05 -0500
Received: from fraeml713-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JjGqZ1rSbz6888Q;
        Tue, 25 Jan 2022 01:16:42 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml713-chm.china.huawei.com (10.206.15.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 24 Jan 2022 18:17:03 +0100
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 24 Jan 2022 17:17:02 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <qemu-devel@nongnu.org>, Marcel Apfelbaum <marcel@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>
CC:     <linux-cxl@vger.kernel.org>, Ben Widawsky <ben.widawsky@intel.com>,
        =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
        Peter Maydell <peter.maydell@linaro.org>,
        <linuxarm@huawei.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
        Saransh Gupta1 <saransh@ibm.com>,
        Shreyas Shah <shreyas.shah@elastics.cloud>,
        Chris Browy <cbrowy@avery-design.com>,
        Samarth Saxena <samarths@cadence.com>,
        "Dan Williams" <dan.j.williams@intel.com>
Subject: [PATCH v4 00/42] CXl 2.0 emulation Support
Date:   Mon, 24 Jan 2022 17:16:23 +0000
Message-ID: <20220124171705.10432-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhreml740-chm.china.huawei.com (10.201.108.190) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Previous version was RFC v3: CXL 2.0 Support.
No longer an RFC as I would consider the vast majority of this
to be ready for detailed review. There are still questions called
out in some patches however.

Looking in particular for:
* Review of the PCI interactions
* x86 and ARM machine interactions (particularly the memory maps)
* Review of the interleaving approach - is the basic idea
  acceptable?
* Review of the command line interface.
* CXL related review welcome but much of that got reviewed
  in earlier versions and hasn't changed substantially.

Main changes:
* The CXL fixed memory windows are now instantiated via a
  -cxl-fixed-memory-window command line option.  As they are host level
  entities, not associated with a particular hardware entity a top
  level parameter seems the most natural way to describe them.
  This is also much closer to how it works on a real host than the
  previous assignment of a physical address window to all components
  along the CXL path.
* Dynamic host memory physical address space allocation both for
  the CXL host bridge MMIO space and the CFMWS windows.
* Interleaving support (based loosely on Philippe Mathieu-Daudé's
  earlier work on an interleaved memory device).  Note this is rudimentary
  and low performance but it may be sufficient for test purposes.
* Additional PCI and memory related utility functions needed for the
  interleaving.
* Various minor cleanup and increase in scope of tests.
* For now dropped the support for presenting CXL type 3 devices
  as memory devices in various QEMU interfaces.
* Dropped the patch letting UID be different from bus_nr.  Whilst
  it may be a useful thing to have, we don't need it for this series
  and so should be handled separately.

I've called out patches with major changes by marking them as
co-developed or introducing them as new patches. The original
memory window code has been dropped

After discussions at plumbers and more recently on the mailing list
it was clear that there was interest in getting emulation for CXL 2.0
upstream in QEMU.  This version resolves many of the outstanding issues
and enables the following features:

* Support on both x86/pc and ARM/virt with relevant ACPI tables
  generated in QEMU.
* Host bridge based on the existing PCI Expander Bridge PXB.
* CXL fixed memory windows, allowing host to describe interleaving
  across multiple CXL host bridges.
* pxb-cxl CXL host bridge support including MMIO region for control
  and HDM (Host manage device memory - basically interleaving / routing)
  decoder configuration.
* Basic CXL Root port support.
* CXL Type 3 device support with persistent memory regions (backed by
  hostmem backend).
* Pulled MAINTAINERS entry out to a separate patch and add myself as
  a co-maintainer at Ben's suggestion.

Big TODOs:

* Volatile memory devices (easy but it's more code so left for now).
* Switch support.
* Hotplug?  May not need much but it's not tested yet!
* More tests and tighter verification that values written to hardware
  are actually valid - stuff that real hardware would check.
* Main host bridge support (not a priority for me...)
* Testing, testing and more testing.  I have been running a basic
  set of ARM and x86 tests on this, but there is always room for
  more tests and greater automation.

Why do we want QEMU emulation of CXL?

As Ben stated in V3, QEMU support has been critical to getting OS
software written given lack of availability of hardware supporting the
latest CXL features (coupled with very high demand for support being
ready in a timely fashion). What has become clear since Ben's v3
is that situation is a continuous one.  Whilst we can't talk about
them yet, CXL 3.0 features and OS support have been prototyped on
top of this support and a lot of the ongoing kernel work is being
tested against these patches.

Other features on the qemu-list that build on these include PCI-DOE
/CDAT support from the Avery Design team further showing how this
code is useful.  Whilst not directly related this is also the test
platform for work on PCI IDE/CMA + related DMTF SPDM as CXL both
utilizes and extends those technologies and is likely to be an early
adopter.
Refs:
CMA Kernel: https://lore.kernel.org/all/20210804161839.3492053-1-Jonathan.Cameron@huawei.com/
CMA Qemu: https://lore.kernel.org/qemu-devel/1624665723-5169-1-git-send-email-cbrowy@avery-design.com/
DOE Qemu: https://lore.kernel.org/qemu-devel/1623329999-15662-1-git-send-email-cbrowy@avery-design.com/


As can be seen there is non trivial interaction with other areas of
Qemu, particularly PCI and keeping this set up to date is proving
a burden we'd rather do without :)

Ben mentioned a few other good reasons in v3:
https://lore.kernel.org/qemu-devel/20210202005948.241655-1-ben.widawsky@intel.com/

The evolution of this series perhaps leave it in a less than
entirely obvious order and that may get tidied up in future postings.
I'm also open to this being considered in bite sized chunks.  What
we have here is about what you need for it to be useful for testing
currently kernel code.

All comments welcome.

Ben - I lifted one patch from your git tree that didn't have a
Sign-off.   hw/cxl/component Add a dumb HDM decoder handler
Could you confirm you are happy for one to be added?

Example of new command line (with virt ITS patches ;)

qemu-system-aarch64 -M virt,gic-version=3,cxl=on \
 -m 4g,maxmem=8G,slots=8 \
 ...
 -object memory-backend-file,id=cxl-mem1,share=on,mem-path=/tmp/cxltest.raw,size=256M,align=256M \
 -object memory-backend-file,id=cxl-mem2,share=on,mem-path=/tmp/cxltest2.raw,size=256M,align=256M \
 -object memory-backend-file,id=cxl-mem3,share=on,mem-path=/tmp/cxltest3.raw,size=256M,align=256M \
 -object memory-backend-file,id=cxl-mem4,share=on,mem-path=/tmp/cxltest4.raw,size=256M,align=256M \
 -object memory-backend-file,id=cxl-lsa1,share=on,mem-path=/tmp/lsa.raw,size=256M,align=256M \
 -object memory-backend-file,id=cxl-lsa2,share=on,mem-path=/tmp/lsa2.raw,size=256M,align=256M \
 -object memory-backend-file,id=cxl-lsa3,share=on,mem-path=/tmp/lsa3.raw,size=256M,align=256M \
 -object memory-backend-file,id=cxl-lsa4,share=on,mem-path=/tmp/lsa4.raw,size=256M,align=256M \
 -object memory-backend-file,id=tt,share=on,mem-path=/tmp/tt.raw,size=1g \
 -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1 \
 -device pxb-cxl,bus_nr=222,bus=pcie.0,id=cxl.2 \
 -device cxl-rp,port=0,bus=cxl.1,id=root_port13,chassis=0,slot=2 \
 -device cxl-type3,bus=root_port13,memdev=cxl-mem1,lsa=cxl-lsa1,id=cxl-pmem0,size=256M \
 -device cxl-rp,port=1,bus=cxl.1,id=root_port14,chassis=0,slot=3 \
 -device cxl-type3,bus=root_port14,memdev=cxl-mem2,lsa=cxl-lsa2,id=cxl-pmem1,size=256M \
 -device cxl-rp,port=0,bus=cxl.2,id=root_port15,chassis=0,slot=5 \
 -device cxl-type3,bus=root_port15,memdev=cxl-mem3,lsa=cxl-lsa3,id=cxl-pmem2,size=256M \
 -device cxl-rp,port=1,bus=cxl.2,id=root_port16,chassis=0,slot=6 \
 -device cxl-type3,bus=root_port16,memdev=cxl-mem4,lsa=cxl-lsa4,id=cxl-pmem3,size=256M \
 -cxl-fixed-memory-window targets=cxl.1,size=4G,interleave-granularity=8k \
 -cxl-fixed-memory-window targets=cxl.1,targets=cxl.2,size=4G,interleave-granularity=8k

First CFMWS suitable for 2 way interleave, the second for 4 way (2 way
at host level and 2 way at the host bridge).
targets=<range of pxb-cxl uids> , multiple entries if range is disjoint.

With Ben's CXL region patches (v3 shortly) plus fixes as discussed on list,
Linux commands to bring up a 4 way interleave is:

 cd /sys/bus/cxl/devices/
 region=$(cat decoder0.1/create_region)
 echo $region  > decoder0.1/create_region
 ls -lh
 
 //Note the order of devices and adjust the following to make sure they
 //are in order across the 4 root ports.  Easy to do in a tool, but
 //not easy to paste in a cover letter.

 cd region0.1\:0
 echo 4 > interleave_ways
 echo mem2 > target0
 echo mem3 > target1
 echo mem0 > target2
 echo mem1 > target3
 echo $((1024<<20)) > size
 echo 4096 > interleave_granularity
 echo region0.1:0 > /sys/bus/cxl/drivers/cxl_region/bind

Tested with devmem2 and files with known content.
Kernel tree was based on previous version of the region patches
from Ben with various fixes. As Dan just posted an updated version
next job on my list is to test that.

Thanks to Shameer for his help with reviewing the new stuff before
posting.

I'll post a git tree shortly for any who prefer that to lots
of emails ;)

Thanks,

Jonathan

Ben Widawsky (26):
  hw/pci/cxl: Add a CXL component type (interface)
  hw/cxl/component: Introduce CXL components (8.1.x, 8.2.5)
  hw/cxl/device: Introduce a CXL device (8.2.8)
  hw/cxl/device: Implement the CAP array (8.2.8.1-2)
  hw/cxl/device: Implement basic mailbox (8.2.8.4)
  hw/cxl/device: Add memory device utilities
  hw/cxl/device: Add cheap EVENTS implementation (8.2.9.1)
  hw/cxl/device: Timestamp implementation (8.2.9.3)
  hw/cxl/device: Add log commands (8.2.9.4) + CEL
  hw/pxb: Use a type for realizing expanders
  hw/pci/cxl: Create a CXL bus type
  hw/pxb: Allow creation of a CXL PXB (host bridge)
  acpi/pci: Consolidate host bridge setup
  hw/cxl/component: Implement host bridge MMIO (8.2.5, table 142)
  hw/cxl/rp: Add a root port
  hw/cxl/device: Add a memory device (8.2.8.5)
  hw/cxl/device: Implement MMIO HDM decoding (8.2.5.12)
  acpi/cxl: Add _OSC implementation (9.14.2)
  tests/acpi: allow CEDT table addition
  acpi/cxl: Create the CEDT (9.14.1)
  hw/cxl/device: Add some trivial commands
  hw/cxl/device: Plumb real Label Storage Area (LSA) sizing
  hw/cxl/device: Implement get/set Label Storage Area (LSA)
  acpi/cxl: Introduce CFMWS structures in CEDT
  hw/cxl/component Add a dumb HDM decoder handler
  qtest/cxl: Add very basic sanity tests

Jonathan Cameron (16):
  MAINTAINERS: Add entry for Compute Express Link Emulation
  tests/acpi: allow DSDT.viot table changes.
  tests/acpi: Add update DSDT.viot
  cxl: Machine level control on whether CXL support is enabled
  hw/cxl/component: Add utils for interleave parameter encoding/decoding
  hw/cxl/host: Add support for CXL Fixed Memory Windows.
  hw/pci-host/gpex-acpi: Add support for dsdt construction for pxb-cxl
  pci/pcie_port: Add pci_find_port_by_pn()
  CXL/cxl_component: Add cxl_get_hb_cstate()
  mem/cxl_type3: Add read and write functions for associated hostmem.
  cxl/cxl-host: Add memops for CFMWS region.
  arm/virt: Allow virt/CEDT creation
  hw/arm/virt: Basic CXL enablement on pci_expander_bridge instances
    pxb-cxl
  RFC: softmmu/memory: Add ops to memory_region_ram_init_from_file
  i386/pc: Enable CXL fixed memory windows
  qtest/acpi: Add reference CEDT tables.

 MAINTAINERS                         |   7 +
 hw/Kconfig                          |   1 +
 hw/acpi/Kconfig                     |   5 +
 hw/acpi/cxl.c                       | 232 +++++++++++++
 hw/acpi/meson.build                 |   1 +
 hw/arm/Kconfig                      |   1 +
 hw/arm/virt-acpi-build.c            |  30 ++
 hw/arm/virt.c                       |  40 ++-
 hw/core/machine.c                   |  26 ++
 hw/cxl/Kconfig                      |   3 +
 hw/cxl/cxl-component-utils.c        | 277 +++++++++++++++
 hw/cxl/cxl-device-utils.c           | 268 +++++++++++++++
 hw/cxl/cxl-host-stubs.c             |  22 ++
 hw/cxl/cxl-host.c                   | 263 ++++++++++++++
 hw/cxl/cxl-mailbox-utils.c          | 509 ++++++++++++++++++++++++++++
 hw/cxl/meson.build                  |   9 +
 hw/i386/acpi-build.c                |  97 +++++-
 hw/i386/microvm.c                   |   1 +
 hw/i386/pc.c                        |  57 +++-
 hw/mem/Kconfig                      |   5 +
 hw/mem/cxl_type3.c                  | 353 +++++++++++++++++++
 hw/mem/meson.build                  |   1 +
 hw/meson.build                      |   1 +
 hw/pci-bridge/Kconfig               |   5 +
 hw/pci-bridge/cxl_root_port.c       | 231 +++++++++++++
 hw/pci-bridge/meson.build           |   1 +
 hw/pci-bridge/pci_expander_bridge.c | 179 +++++++++-
 hw/pci-bridge/pcie_root_port.c      |   6 +-
 hw/pci-host/gpex-acpi.c             |  22 +-
 hw/pci/pci.c                        |  21 +-
 hw/pci/pcie_port.c                  |  25 ++
 hw/ppc/spapr.c                      |   1 +
 include/hw/acpi/cxl.h               |  28 ++
 include/hw/arm/virt.h               |   1 +
 include/hw/boards.h                 |   2 +
 include/hw/cxl/cxl.h                |  51 +++
 include/hw/cxl/cxl_component.h      | 206 +++++++++++
 include/hw/cxl/cxl_device.h         | 266 +++++++++++++++
 include/hw/cxl/cxl_pci.h            | 160 +++++++++
 include/hw/pci/pci.h                |  14 +
 include/hw/pci/pci_bridge.h         |  20 ++
 include/hw/pci/pci_bus.h            |   7 +
 include/hw/pci/pci_ids.h            |   1 +
 include/hw/pci/pcie_port.h          |   2 +
 qapi/machine.json                   |  15 +
 qemu-options.hx                     |  37 ++
 softmmu/memory.c                    |   9 +
 softmmu/vl.c                        |  11 +
 tests/data/acpi/pc/CEDT             | Bin 0 -> 36 bytes
 tests/data/acpi/q35/CEDT            | Bin 0 -> 36 bytes
 tests/data/acpi/q35/DSDT.viot       | Bin 9398 -> 9416 bytes
 tests/data/acpi/virt/CEDT           | Bin 0 -> 36 bytes
 tests/qtest/cxl-test.c              | 151 +++++++++
 tests/qtest/meson.build             |   4 +
 54 files changed, 3645 insertions(+), 40 deletions(-)
 create mode 100644 hw/acpi/cxl.c
 create mode 100644 hw/cxl/Kconfig
 create mode 100644 hw/cxl/cxl-component-utils.c
 create mode 100644 hw/cxl/cxl-device-utils.c
 create mode 100644 hw/cxl/cxl-host-stubs.c
 create mode 100644 hw/cxl/cxl-host.c
 create mode 100644 hw/cxl/cxl-mailbox-utils.c
 create mode 100644 hw/cxl/meson.build
 create mode 100644 hw/mem/cxl_type3.c
 create mode 100644 hw/pci-bridge/cxl_root_port.c
 create mode 100644 include/hw/acpi/cxl.h
 create mode 100644 include/hw/cxl/cxl.h
 create mode 100644 include/hw/cxl/cxl_component.h
 create mode 100644 include/hw/cxl/cxl_device.h
 create mode 100644 include/hw/cxl/cxl_pci.h
 create mode 100644 tests/data/acpi/pc/CEDT
 create mode 100644 tests/data/acpi/q35/CEDT
 create mode 100644 tests/data/acpi/virt/CEDT
 create mode 100644 tests/qtest/cxl-test.c

-- 
2.32.0

