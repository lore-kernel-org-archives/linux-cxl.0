Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA7F8C433EF
	for <linux-cxl@archiver.kernel.org>; Mon, 24 Jan 2022 18:11:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235750AbiAXSLt (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 24 Jan 2022 13:11:49 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4489 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235684AbiAXSLt (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 24 Jan 2022 13:11:49 -0500
Received: from fraeml741-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JjHzD1HH3z67M4k;
        Tue, 25 Jan 2022 02:08:24 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml741-chm.china.huawei.com (10.206.15.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 24 Jan 2022 19:11:47 +0100
Received: from localhost (10.122.247.231) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Mon, 24 Jan
 2022 18:11:46 +0000
Date:   Mon, 24 Jan 2022 18:11:44 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <qemu-devel@nongnu.org>, Marcel Apfelbaum <marcel@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>
CC:     <linux-cxl@vger.kernel.org>, Ben Widawsky <ben.widawsky@intel.com>,
        Alex =?ISO-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
        Peter Maydell <peter.maydell@linaro.org>,
        <linuxarm@huawei.com>,
        "Shameerali Kolothum Thodi" <shameerali.kolothum.thodi@huawei.com>,
        Philippe =?ISO-8859-1?Q?Mat?= =?ISO-8859-1?Q?hieu-Daud=E9?= 
        <f4bug@amsat.org>, Saransh Gupta1 <saransh@ibm.com>,
        Shreyas Shah <shreyas.shah@elastics.cloud>,
        Chris Browy <cbrowy@avery-design.com>,
        Samarth Saxena <samarths@cadence.com>,
        "Dan Williams" <dan.j.williams@intel.com>
Subject: Re: [PATCH v4 00/42] CXl 2.0 emulation Support
Message-ID: <20220124181144.00006d92@huawei.com>
In-Reply-To: <20220124171705.10432-1-Jonathan.Cameron@huawei.com>
References: <20220124171705.10432-1-Jonathan.Cameron@huawei.com>
Organization: Huawei Technologies R&D (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhreml740-chm.china.huawei.com (10.201.108.190) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, 24 Jan 2022 17:16:23 +0000
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> 
> I'll post a git tree shortly for any who prefer that to lots
> of emails ;)


https://github.com/hisilicon/qemu.git  cxl-v4

I've included the pci swizzle fix on the tree as it
avoids some really annoying waits for interrupts to get
masked when testing on ARM.

I've also put the basic DOE patch set on top (CDAT + compliance)
and the ARM GIC ITS support patch for virt as who wouldn't
want that?

Thanks,

Jonathan
 
> 
> Thanks,
> 
> Jonathan
> 
> Ben Widawsky (26):
>   hw/pci/cxl: Add a CXL component type (interface)
>   hw/cxl/component: Introduce CXL components (8.1.x, 8.2.5)
>   hw/cxl/device: Introduce a CXL device (8.2.8)
>   hw/cxl/device: Implement the CAP array (8.2.8.1-2)
>   hw/cxl/device: Implement basic mailbox (8.2.8.4)
>   hw/cxl/device: Add memory device utilities
>   hw/cxl/device: Add cheap EVENTS implementation (8.2.9.1)
>   hw/cxl/device: Timestamp implementation (8.2.9.3)
>   hw/cxl/device: Add log commands (8.2.9.4) + CEL
>   hw/pxb: Use a type for realizing expanders
>   hw/pci/cxl: Create a CXL bus type
>   hw/pxb: Allow creation of a CXL PXB (host bridge)
>   acpi/pci: Consolidate host bridge setup
>   hw/cxl/component: Implement host bridge MMIO (8.2.5, table 142)
>   hw/cxl/rp: Add a root port
>   hw/cxl/device: Add a memory device (8.2.8.5)
>   hw/cxl/device: Implement MMIO HDM decoding (8.2.5.12)
>   acpi/cxl: Add _OSC implementation (9.14.2)
>   tests/acpi: allow CEDT table addition
>   acpi/cxl: Create the CEDT (9.14.1)
>   hw/cxl/device: Add some trivial commands
>   hw/cxl/device: Plumb real Label Storage Area (LSA) sizing
>   hw/cxl/device: Implement get/set Label Storage Area (LSA)
>   acpi/cxl: Introduce CFMWS structures in CEDT
>   hw/cxl/component Add a dumb HDM decoder handler
>   qtest/cxl: Add very basic sanity tests
> 
> Jonathan Cameron (16):
>   MAINTAINERS: Add entry for Compute Express Link Emulation
>   tests/acpi: allow DSDT.viot table changes.
>   tests/acpi: Add update DSDT.viot
>   cxl: Machine level control on whether CXL support is enabled
>   hw/cxl/component: Add utils for interleave parameter encoding/decoding
>   hw/cxl/host: Add support for CXL Fixed Memory Windows.
>   hw/pci-host/gpex-acpi: Add support for dsdt construction for pxb-cxl
>   pci/pcie_port: Add pci_find_port_by_pn()
>   CXL/cxl_component: Add cxl_get_hb_cstate()
>   mem/cxl_type3: Add read and write functions for associated hostmem.
>   cxl/cxl-host: Add memops for CFMWS region.
>   arm/virt: Allow virt/CEDT creation
>   hw/arm/virt: Basic CXL enablement on pci_expander_bridge instances
>     pxb-cxl
>   RFC: softmmu/memory: Add ops to memory_region_ram_init_from_file
>   i386/pc: Enable CXL fixed memory windows
>   qtest/acpi: Add reference CEDT tables.
> 
>  MAINTAINERS                         |   7 +
>  hw/Kconfig                          |   1 +
>  hw/acpi/Kconfig                     |   5 +
>  hw/acpi/cxl.c                       | 232 +++++++++++++
>  hw/acpi/meson.build                 |   1 +
>  hw/arm/Kconfig                      |   1 +
>  hw/arm/virt-acpi-build.c            |  30 ++
>  hw/arm/virt.c                       |  40 ++-
>  hw/core/machine.c                   |  26 ++
>  hw/cxl/Kconfig                      |   3 +
>  hw/cxl/cxl-component-utils.c        | 277 +++++++++++++++
>  hw/cxl/cxl-device-utils.c           | 268 +++++++++++++++
>  hw/cxl/cxl-host-stubs.c             |  22 ++
>  hw/cxl/cxl-host.c                   | 263 ++++++++++++++
>  hw/cxl/cxl-mailbox-utils.c          | 509 ++++++++++++++++++++++++++++
>  hw/cxl/meson.build                  |   9 +
>  hw/i386/acpi-build.c                |  97 +++++-
>  hw/i386/microvm.c                   |   1 +
>  hw/i386/pc.c                        |  57 +++-
>  hw/mem/Kconfig                      |   5 +
>  hw/mem/cxl_type3.c                  | 353 +++++++++++++++++++
>  hw/mem/meson.build                  |   1 +
>  hw/meson.build                      |   1 +
>  hw/pci-bridge/Kconfig               |   5 +
>  hw/pci-bridge/cxl_root_port.c       | 231 +++++++++++++
>  hw/pci-bridge/meson.build           |   1 +
>  hw/pci-bridge/pci_expander_bridge.c | 179 +++++++++-
>  hw/pci-bridge/pcie_root_port.c      |   6 +-
>  hw/pci-host/gpex-acpi.c             |  22 +-
>  hw/pci/pci.c                        |  21 +-
>  hw/pci/pcie_port.c                  |  25 ++
>  hw/ppc/spapr.c                      |   1 +
>  include/hw/acpi/cxl.h               |  28 ++
>  include/hw/arm/virt.h               |   1 +
>  include/hw/boards.h                 |   2 +
>  include/hw/cxl/cxl.h                |  51 +++
>  include/hw/cxl/cxl_component.h      | 206 +++++++++++
>  include/hw/cxl/cxl_device.h         | 266 +++++++++++++++
>  include/hw/cxl/cxl_pci.h            | 160 +++++++++
>  include/hw/pci/pci.h                |  14 +
>  include/hw/pci/pci_bridge.h         |  20 ++
>  include/hw/pci/pci_bus.h            |   7 +
>  include/hw/pci/pci_ids.h            |   1 +
>  include/hw/pci/pcie_port.h          |   2 +
>  qapi/machine.json                   |  15 +
>  qemu-options.hx                     |  37 ++
>  softmmu/memory.c                    |   9 +
>  softmmu/vl.c                        |  11 +
>  tests/data/acpi/pc/CEDT             | Bin 0 -> 36 bytes
>  tests/data/acpi/q35/CEDT            | Bin 0 -> 36 bytes
>  tests/data/acpi/q35/DSDT.viot       | Bin 9398 -> 9416 bytes
>  tests/data/acpi/virt/CEDT           | Bin 0 -> 36 bytes
>  tests/qtest/cxl-test.c              | 151 +++++++++
>  tests/qtest/meson.build             |   4 +
>  54 files changed, 3645 insertions(+), 40 deletions(-)
>  create mode 100644 hw/acpi/cxl.c
>  create mode 100644 hw/cxl/Kconfig
>  create mode 100644 hw/cxl/cxl-component-utils.c
>  create mode 100644 hw/cxl/cxl-device-utils.c
>  create mode 100644 hw/cxl/cxl-host-stubs.c
>  create mode 100644 hw/cxl/cxl-host.c
>  create mode 100644 hw/cxl/cxl-mailbox-utils.c
>  create mode 100644 hw/cxl/meson.build
>  create mode 100644 hw/mem/cxl_type3.c
>  create mode 100644 hw/pci-bridge/cxl_root_port.c
>  create mode 100644 include/hw/acpi/cxl.h
>  create mode 100644 include/hw/cxl/cxl.h
>  create mode 100644 include/hw/cxl/cxl_component.h
>  create mode 100644 include/hw/cxl/cxl_device.h
>  create mode 100644 include/hw/cxl/cxl_pci.h
>  create mode 100644 tests/data/acpi/pc/CEDT
>  create mode 100644 tests/data/acpi/q35/CEDT
>  create mode 100644 tests/data/acpi/virt/CEDT
>  create mode 100644 tests/qtest/cxl-test.c
> 

