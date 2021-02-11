Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E0FBC433E0
	for <linux-cxl@archiver.kernel.org>; Thu, 11 Feb 2021 19:00:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC71164D9C
	for <linux-cxl@archiver.kernel.org>; Thu, 11 Feb 2021 18:59:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbhBKSx2 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 11 Feb 2021 13:53:28 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2555 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbhBKSxN (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 11 Feb 2021 13:53:13 -0500
Received: from fraeml738-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Dc5Dc0Hqqz67dq5;
        Fri, 12 Feb 2021 02:45:52 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml738-chm.china.huawei.com (10.206.15.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 11 Feb 2021 19:52:31 +0100
Received: from localhost (10.47.31.44) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2106.2; Thu, 11 Feb
 2021 18:52:30 +0000
Date:   Thu, 11 Feb 2021 18:51:29 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ben Widawsky <ben@bwidawsk.net>,
        David Hildenbrand <david@redhat.com>
CC:     <qemu-devel@nongnu.org>, Vishal Verma <vishal.l.verma@intel.com>,
        "John Groves (jgroves)" <jgroves@micron.com>,
        Chris Browy <cbrowy@avery-design.com>,
        Markus Armbruster <armbru@redhat.com>,
        <linux-cxl@vger.kernel.org>,
        Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>
Subject: Re: [RFC PATCH v3 00/31] CXL 2.0 Support
Message-ID: <20210211185129.000055d3@Huawei.com>
In-Reply-To: <20210203174216.ko2fqgsvsnp2hjxx@mail.bwidawsk.net>
References: <20210202005948.241655-1-ben.widawsky@intel.com>
        <20210203174216.ko2fqgsvsnp2hjxx@mail.bwidawsk.net>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.31.44]
X-ClientProxiedBy: lhreml709-chm.china.huawei.com (10.201.108.58) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, 3 Feb 2021 09:42:16 -0800
Ben Widawsky <ben@bwidawsk.net> wrote:

> I've started a barebones project plan:
> https://gitlab.com/bwidawsk/qemu/-/snippets/2070304

Great.

> 
> Jonathan, if you have a moment, perhaps you can send a MR summarizing CDAT/DOE
> work from you and Chris?

I need to catch up with what Chris has posted, but sure after that I'll add to your
doc if Chris doesn't get there first.  My intent is to let Chris get on with the
DOE QEMU support.  Plenty of other stuff to do as long as it covers what I need
(if not I'll hack stuff on top :) Will catch up with reviewing that in the next
few days.

I'll also add some other comments on the plan when I get a chance.
Will need to fake at least a partial switch sometime soon for example.

> 
> If folks feel priorities are drastically off, we can discuss it in the snippet
> comments.
> 
> As for wider acceptance, if I'm looking at this from the QEMU community
> perspective, better test cases are really needed. If your fingers are itching
> for some typing, might I suggest starting with that.
> 
> I've opted not to use issue tracker for this because I am hopeful this won't be
> a long living gitlab project.

All sounds good.

I've not reviewed that much on the last few patches in here, at least partly
because a bunch of them have todo comments so I'm assuming they are very much
a work in progress.

One thing I will note is this has become large and complex enough that I'd be
tempted to start separating the 'racey cutting edge' parts from bits that have
been moderately stable for a while.  Hopefully some of that stable part can get
wider review without the fun stuff and all the churn related to that.

Jonathan



> 
> On 21-02-01 16:59:17, Ben Widawsky wrote:
> > Major changes since v2 [1]:
> >  * Removed all register endian/alignment/size checking. Using core functionality
> >    instead. This untested on big endian hosts, but Should Work(tm).
> >  * Fix component capability header generation (off by 1).
> >  * Fixed HDM programming (multiple issues).
> >  * Fixed timestamp command implementations.
> >  * Added commands: GET_FIRMWARE_UPDATE_INFO, GET_PARTITION_INFO, GET_LSA, SET_LSA
> > 
> > Things have remained fairly stable since since v2. The biggest change here is
> > definitely the HDM programming which has received limited (but not 0) testing in
> > the Linux driver.
> > 
> > Jonathan Cameron has gotten this patch series working on ARM [2], and added some
> > much sought after functionality [3].
> > 
> > ---
> > 
> > I've started #cxl on OFTC IRC for discussion. Please feel free to use that
> > channel for questions or suggestions in addition to #qemu.
> > 
> > ---
> > 
> > Introduce emulation of Compute Express Link 2.0
> > (https://www.computeexpresslink.org/). Specifically, add support for Type 3
> > memory expanders with persistent memory.
> > 
> > The emulation has been critical to get the Linux enabling started [4], it would
> > be an ideal place to land regression tests for different topology handling, and
> > there may be applications for this emulation as a way for a guest to manipulate
> > its address space relative to different performance memories.
> > 
> > Three of the five CXL component types are emulated with some level of
> > functionality: host bridge, root port, and memory device. All components and
> > devices implement basic MMIO. Devices/memory devices implement the mailbo
> > interface. Basic ACPI support is also included. Upstream ports and downstream
> > ports aren't implemented (the two components needed to make up a switch).
> > 
> > CXL 2.0 is built on top of PCIe (see spec for details). As a result, much of the
> > implementation utilizes existing PCI paradigms. To implement the host bridge,
> > I've chosen to use PXB (PCI Expander Bridge). It seemed to be the most natural
> > fit even though it doesn't directly map to how hardware will work. For
> > persistent capacity of the memory device, I utilized the memory subsystem
> > (hw/mem).
> > 
> > We have 3 reasons why this work is valuable:
> > 1. Linux driver feature development benefits from emulation both due to a lack
> >    of initial hardware availability, but also, as is seen with NVDIMM/PMEM
> >    emulation, there is value in being able to share topologies with
> >    system-software developers even after hardware is available.
> > 
> > 2. The Linux kernel's unit test suite for NVDIMM/PMEM ended up injecting fake
> >    resources via custom modules (nfit_test). In retrospect a QEMU emulation of
> >    nfit_test capabilities would have made the test environment more portable,
> >    and allowed for easier community contributions of example configurations.
> > 
> > 3. This is still being fleshed out, but in short it provides a standardized
> >    mechanism for the guest to provide feedback to the host about size and
> >    placement needs of the memory. After the host gives the guest a physical
> >    window mapping to the CXL device, the emulated HDM decoders allow the guest a
> >    way to tell the host how much it wants and where. There are likely simpler
> >    ways to do this, but they'd require inventing a new interface and you'd need
> >    to have diverging driver code in the guest programming of the HDM decoder vs.
> >    the host. Since we've already done this work, why not use it?
> > 
> > There is quite a long list of work to do for full spec compliance, but I don't
> > believe that any of it precludes merging. Off the top of my head:
> > - Main host bridge support (WIP)
> > - Interleaving
> > - Better Tests
> > - Hot plug support
> > - Emulating volatile capacity
> > - CDAT emulation [3]
> > 
> > The flow of the patches in general is to define all the data structures and
> > registers associated with the various components in a top down manner. Host
> > bridge, component, ports, devices. Then, the actual implementation is done in
> > the same order.
> > 
> > The summary is:
> > 1-5: Infrastructure for component and device emulation
> > 6-9: Basic mailbox command implementations
> > 10-19: Implement CXL host bridges as PXB devices
> > 20: Implement a root port
> > 21-22: Implement a memory device
> > 23-26: ACPI bits
> > 27-29: Add some more advanced mailbox command implementations
> > 30: Start working on enabling the main host bridge
> > 31: Basic test case
> > 
> > ---
> > 
> > [1]: https://lore.kernel.org/qemu-devel/20210105165323.783725-1-ben.widawsky@intel.com/
> > [2]: https://lore.kernel.org/qemu-devel/20210201152655.31027-1-Jonathan.Cameron@huawei.com/
> > [3]: https://lore.kernel.org/qemu-devel/20210201151629.29656-1-Jonathan.Cameron@huawei.com/
> > [4]: https://lore.kernel.org/linux-cxl/20210130002438.1872527-1-ben.widawsky@intel.com/
> > 
> > ---
> > 
> > Ben Widawsky (31):
> >   hw/pci/cxl: Add a CXL component type (interface)
> >   hw/cxl/component: Introduce CXL components (8.1.x, 8.2.5)
> >   hw/cxl/device: Introduce a CXL device (8.2.8)
> >   hw/cxl/device: Implement the CAP array (8.2.8.1-2)
> >   hw/cxl/device: Implement basic mailbox (8.2.8.4)
> >   hw/cxl/device: Add memory device utilities
> >   hw/cxl/device: Add cheap EVENTS implementation (8.2.9.1)
> >   hw/cxl/device: Timestamp implementation (8.2.9.3)
> >   hw/cxl/device: Add log commands (8.2.9.4) + CEL
> >   hw/pxb: Use a type for realizing expanders
> >   hw/pci/cxl: Create a CXL bus type
> >   hw/pxb: Allow creation of a CXL PXB (host bridge)
> >   qtest: allow DSDT acpi table changes
> >   acpi/pci: Consolidate host bridge setup
> >   tests/acpi: remove stale allowed tables
> >   hw/pci: Plumb _UID through host bridges
> >   hw/cxl/component: Implement host bridge MMIO (8.2.5, table 142)
> >   acpi/pxb/cxl: Reserve host bridge MMIO
> >   hw/pxb/cxl: Add "windows" for host bridges
> >   hw/cxl/rp: Add a root port
> >   hw/cxl/device: Add a memory device (8.2.8.5)
> >   hw/cxl/device: Implement MMIO HDM decoding (8.2.5.12)
> >   acpi/cxl: Add _OSC implementation (9.14.2)
> >   tests/acpi: allow CEDT table addition
> >   acpi/cxl: Create the CEDT (9.14.1)
> >   tests/acpi: Add new CEDT files
> >   hw/cxl/device: Add some trivial commands
> >   hw/cxl/device: Plumb real LSA sizing
> >   hw/cxl/device: Implement get/set LSA
> >   qtest/cxl: Add very basic sanity tests
> >   WIP: i386/cxl: Initialize a host bridge
> > 
> >  MAINTAINERS                         |   6 +
> >  hw/Kconfig                          |   1 +
> >  hw/acpi/Kconfig                     |   5 +
> >  hw/acpi/cxl.c                       | 173 ++++++++++
> >  hw/acpi/meson.build                 |   1 +
> >  hw/arm/virt.c                       |   1 +
> >  hw/core/machine.c                   |  26 ++
> >  hw/core/numa.c                      |   3 +
> >  hw/cxl/Kconfig                      |   3 +
> >  hw/cxl/cxl-component-utils.c        | 208 ++++++++++++
> >  hw/cxl/cxl-device-utils.c           | 264 +++++++++++++++
> >  hw/cxl/cxl-mailbox-utils.c          | 498 ++++++++++++++++++++++++++++
> >  hw/cxl/meson.build                  |   5 +
> >  hw/i386/acpi-build.c                |  87 ++++-
> >  hw/i386/microvm.c                   |   1 +
> >  hw/i386/pc.c                        |   2 +
> >  hw/mem/Kconfig                      |   5 +
> >  hw/mem/cxl_type3.c                  | 405 ++++++++++++++++++++++
> >  hw/mem/meson.build                  |   1 +
> >  hw/meson.build                      |   1 +
> >  hw/pci-bridge/Kconfig               |   5 +
> >  hw/pci-bridge/cxl_root_port.c       | 231 +++++++++++++
> >  hw/pci-bridge/meson.build           |   1 +
> >  hw/pci-bridge/pci_expander_bridge.c | 209 +++++++++++-
> >  hw/pci-bridge/pcie_root_port.c      |   6 +-
> >  hw/pci/pci.c                        |  32 +-
> >  hw/pci/pcie.c                       |  30 ++
> >  hw/ppc/spapr.c                      |   2 +
> >  include/hw/acpi/cxl.h               |  27 ++
> >  include/hw/boards.h                 |   2 +
> >  include/hw/cxl/cxl.h                |  29 ++
> >  include/hw/cxl/cxl_component.h      | 187 +++++++++++
> >  include/hw/cxl/cxl_device.h         | 255 ++++++++++++++
> >  include/hw/cxl/cxl_pci.h            | 160 +++++++++
> >  include/hw/pci/pci.h                |  15 +
> >  include/hw/pci/pci_bridge.h         |  25 ++
> >  include/hw/pci/pci_bus.h            |   8 +
> >  include/hw/pci/pci_ids.h            |   1 +
> >  monitor/hmp-cmds.c                  |  15 +
> >  qapi/machine.json                   |   1 +
> >  tests/data/acpi/pc/CEDT             | Bin 0 -> 36 bytes
> >  tests/data/acpi/pc/DSDT             | Bin 5065 -> 5065 bytes
> >  tests/data/acpi/pc/DSDT.acpihmat    | Bin 6390 -> 6390 bytes
> >  tests/data/acpi/pc/DSDT.bridge      | Bin 6924 -> 6924 bytes
> >  tests/data/acpi/pc/DSDT.cphp        | Bin 5529 -> 5529 bytes
> >  tests/data/acpi/pc/DSDT.dimmpxm     | Bin 6719 -> 6719 bytes
> >  tests/data/acpi/pc/DSDT.hpbridge    | Bin 5026 -> 5026 bytes
> >  tests/data/acpi/pc/DSDT.hpbrroot    | Bin 3084 -> 3084 bytes
> >  tests/data/acpi/pc/DSDT.ipmikcs     | Bin 5137 -> 5137 bytes
> >  tests/data/acpi/pc/DSDT.memhp       | Bin 6424 -> 6424 bytes
> >  tests/data/acpi/pc/DSDT.numamem     | Bin 5071 -> 5071 bytes
> >  tests/data/acpi/pc/DSDT.roothp      | Bin 5261 -> 5261 bytes
> >  tests/data/acpi/q35/CEDT            | Bin 0 -> 36 bytes
> >  tests/data/acpi/q35/DSDT            | Bin 7801 -> 7801 bytes
> >  tests/data/acpi/q35/DSDT.acpihmat   | Bin 9126 -> 9126 bytes
> >  tests/data/acpi/q35/DSDT.bridge     | Bin 7819 -> 7819 bytes
> >  tests/data/acpi/q35/DSDT.cphp       | Bin 8265 -> 8265 bytes
> >  tests/data/acpi/q35/DSDT.dimmpxm    | Bin 9455 -> 9455 bytes
> >  tests/data/acpi/q35/DSDT.ipmibt     | Bin 7876 -> 7876 bytes
> >  tests/data/acpi/q35/DSDT.memhp      | Bin 9160 -> 9160 bytes
> >  tests/data/acpi/q35/DSDT.mmio64     | Bin 8932 -> 8932 bytes
> >  tests/data/acpi/q35/DSDT.numamem    | Bin 7807 -> 7807 bytes
> >  tests/qtest/cxl-test.c              |  93 ++++++
> >  tests/qtest/meson.build             |   4 +
> >  64 files changed, 3004 insertions(+), 30 deletions(-)
> >  create mode 100644 hw/acpi/cxl.c
> >  create mode 100644 hw/cxl/Kconfig
> >  create mode 100644 hw/cxl/cxl-component-utils.c
> >  create mode 100644 hw/cxl/cxl-device-utils.c
> >  create mode 100644 hw/cxl/cxl-mailbox-utils.c
> >  create mode 100644 hw/cxl/meson.build
> >  create mode 100644 hw/mem/cxl_type3.c
> >  create mode 100644 hw/pci-bridge/cxl_root_port.c
> >  create mode 100644 include/hw/acpi/cxl.h
> >  create mode 100644 include/hw/cxl/cxl.h
> >  create mode 100644 include/hw/cxl/cxl_component.h
> >  create mode 100644 include/hw/cxl/cxl_device.h
> >  create mode 100644 include/hw/cxl/cxl_pci.h
> >  create mode 100644 tests/data/acpi/pc/CEDT
> >  create mode 100644 tests/data/acpi/q35/CEDT
> >  create mode 100644 tests/qtest/cxl-test.c
> > 
> > -- 
> > 2.30.0
> > 
> >   

