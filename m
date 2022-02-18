Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 287F4C433EF
	for <linux-cxl@archiver.kernel.org>; Fri, 18 Feb 2022 18:17:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239133AbiBRSSM (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 18 Feb 2022 13:18:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239136AbiBRSSE (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 18 Feb 2022 13:18:04 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D04128BF7C
        for <linux-cxl@vger.kernel.org>; Fri, 18 Feb 2022 10:17:44 -0800 (PST)
Received: from fraeml706-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4K0fzK0vC1z67Prk;
        Sat, 19 Feb 2022 02:16:45 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml706-chm.china.huawei.com (10.206.15.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.21; Fri, 18 Feb 2022 19:17:41 +0100
Received: from localhost (10.47.75.241) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 18 Feb
 2022 18:17:39 +0000
Date:   Fri, 18 Feb 2022 18:17:38 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     <qemu-devel@nongnu.org>,
        Alex =?ISO-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
        Marcel Apfelbaum <marcel@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>
CC:     <linux-cxl@vger.kernel.org>, Ben Widawsky <ben.widawsky@intel.com>,
        "Peter Maydell" <peter.maydell@linaro.org>, <linuxarm@huawei.com>,
        "Shameerali Kolothum Thodi" <shameerali.kolothum.thodi@huawei.com>,
        Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>,
        Saransh Gupta1 <saransh@ibm.com>,
        Shreyas Shah <shreyas.shah@elastics.cloud>,
        Chris Browy <cbrowy@avery-design.com>,
        Samarth Saxena <samarths@cadence.com>,
        "Dan Williams" <dan.j.williams@intel.com>
Subject: Re: [PATCH v6 00/43] CXl 2.0 emulation Support
Message-ID: <20220218181738.00001dd5@Huawei.com>
In-Reply-To: <20220211120747.3074-1-Jonathan.Cameron@huawei.com>
References: <20220211120747.3074-1-Jonathan.Cameron@huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.75.241]
X-ClientProxiedBy: lhreml726-chm.china.huawei.com (10.201.108.77) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, 11 Feb 2022 12:07:04 +0000
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> This version is mainly a reorganization of v5 patch ordering to make for
> more sensible stepwise review and merging. I took the opportunity to add
> a few more tests and introduce an overview document.

In case anyone is interested at:

https://gitlab.com/jic23/qemu/-/commits/cxl-v7-draft-for-test
is a draft of what will be v7 with basic CXL switch support
and the issue that Ben pointed out in patch 17 fixed.
No change to anything before patch 17 so does not affect the proposed
first block of patches to apply (i.e. no need to wait for v7 if
it makes sense to pick those up sooner!)

There was some follow through from the fix in the later qtests
as they now correctly require LSA / Label Storage Areas to be provided
for CXL-mem types. I've also moved the initial type 3 test later in
the series so that lsa parameter is required by the time it is introduced.
The LSA requirement may be relaxed in the future when volatile memory
support is added as then an LSA becomes optional.

The switch support includes interleave decoding for one layer of switches
and at least for basic tests it all seems to work.  Note that with
current kernel proposal you'll need 2 ports on a host bridge (one can
have nothing attached to it) so as to ensure the kernel programs the HDM decoders.
I'll see if I can find an elegant solution on the kernel side for this
as single port HB with HDM decoders is allowed by the CXL spec.

Next up is fleshing out sanity checks / write masks etc for various interfaces
so that the emulation will reject invalid writes etc much as real
hardware would be expected to do.

Thanks,

Jonathan


> 
> Changes since v5: Thanks to Michael and Igor for comments.
> - Reorganize series to make it more sensible to take in several chunks.
>   Includes splitting qtest/cxl-test up so that we have basic testing
>   for each stage. Suggested chunks as follows:
>   1-15: Infrastructure + host bridge
>     At this stage the pxb-cxl host bridge it is presented to the OS
>     as a legacy / pcie host bridge.
>     This set is close to those Michael Tsirkin suggested picking up
>     in v5, but the cxl=on machine parameter was pulled forwards to
>     avoid breaking backwards compatibility. It could logically be
>     delayed until HB MMIO is introduced but only at cost of then
>     failing to instantiate pxb-cxl in cases that would previously
>     have 'worked'.
>   16-22: Root port, plus CXL type 3 device.
>     Will allow Linux cxl-pci driver to bind and present some basic
>     features of the type 3 devices.
>   23-40: x86 PC support including HB MMIO and CFMWS
>     At this region creation and use is possible on x86 platforms.
>     Includes a new bios-table-test and more complex qtests/cxl-test
>     cases. Includes the interleaving code and an RFC about adding
>     ops to memory_region_ram_init_from_file().
>   41-42: ARM virt enabling equivalent to that done for x86.
>   43: Documentation
>     I can break this down if helpful as it includes command line
>     examples only possible after support is in place for all elements.
>   I've had gitlab CI pipelines testing at patch 15, 22, and 43
>   and other than the build-oss-fuzz which is timing out and a false
>   positive (I think) in checkpatch they are clean.
>   http://gitlab.com/jic23/qemu/~/pipelines
>   (trivial commit message update followed pushing those out, but
>    the code is the same).
> 
> - Add a documentation patch as requested by Alex in v4 review.
> - Drop the code unification around PCI host bridge setup.
>   It will need extensive testing and was only of marginal benefit for this
>   series so get it off the critical path.
> - Don't build CEDT unless machine parameter cxl=on is set. Tests added
>   to exercise the cxl=on case and generate meaningful tables (not empty).
> - Move handling of pxb-cxl reset to a later patch where the required
>   infrastructure has been created (avoids a crash).
> - Split up qtests/cxl-test to build up step by step.
>   Introduced an aarch64 test case covering most complex case only as
>   this probably sufficient to catch any arch specific problems.
> - Introduce test plus bios tables CEDT.cxl and DSDT.cxl.
> 
> Updated background info from v5:
> 
> Looking in particular for:
> * Review of the PCI interactions
> * x86 and ARM machine interactions (particularly the memory maps)
> * Review of the interleaving approach - is the basic idea
>   acceptable?
> * Review of the command line interface.
> * CXL related review welcome but much of that got reviewed
>   in earlier versions and hasn't changed substantially.
> 
> Big TODOs:
> 
> * Lack of unaligned accesses to interleaved memory. Are there any
>   side effects of this restriction?
> * Volatile memory devices (easy but it's more code so left for now).
> * Switch support. Linux kernel support is under review currently,
>   so there is now something to test against.
> * Hotplug?  May not need much but it's not tested yet!
> * More tests and tighter verification that values written to hardware
>   are actually valid - stuff that real hardware would check.
> * Testing, testing and more testing.  I have been running a basic
>   set of ARM and x86 tests on this, but there is always room for
>   more tests and greater automation.
> * CFMWS flags as requested by Ben.
> 
> Why do we want QEMU emulation of CXL?
> 
> As Ben stated in V3, QEMU support has been critical to getting OS
> software written given lack of availability of hardware supporting the
> latest CXL features (coupled with very high demand for support being
> ready in a timely fashion). What has become clear since Ben's v3
> is that situation is a continuous one. Whilst we can't talk about
> them yet, CXL 3.0 features and OS support have been prototyped on
> top of this support and a lot of the ongoing kernel work is being
> tested against these patches. The kernel CXL mocking code allows
> some forms of testing, but QEMU provides a more versatile and
> exensible platform.
> 
> Other features on the qemu-list that build on these include PCI-DOE
> /CDAT support from the Avery Design team further showing how this
> code is useful. Whilst not directly related this is also the test
> platform for work on PCI IDE/CMA + related DMTF SPDM as CXL both
> utilizes and extends those technologies and is likely to be an early
> adopter.
> Refs:
> CMA Kernel: https://lore.kernel.org/all/20210804161839.3492053-1-Jonathan.Cameron@huawei.com/
> CMA Qemu: https://lore.kernel.org/qemu-devel/1624665723-5169-1-git-send-email-cbrowy@avery-design.com/
> DOE Qemu: https://lore.kernel.org/qemu-devel/1623329999-15662-1-git-send-email-cbrowy@avery-design.com/
> 
> As can be seen there is non trivial interaction with other areas of
> Qemu, particularly PCI and keeping this set up to date is proving
> a burden we'd rather do without :)
> 
> Ben mentioned a few other good reasons in v3:
> https://lore.kernel.org/qemu-devel/20210202005948.241655-1-ben.widawsky@intel.com/
> 
> What we have here is about what you need for it to be useful for testing
> currently kernel code.  Note the kernel code is moving fast so
> since v4, some features have been introduced we don't yet support in
> QEMU (e.g. use of the PCIe serial number extended capability).
> 
> All comments welcome.
> 
> Additional info that was here in v5 is now in the documentation patch.
> 
> Thanks,
> 
> Jonathan
> 
> Ben Widawsky (24):
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
>   hw/cxl/rp: Add a root port
>   hw/cxl/device: Add a memory device (8.2.8.5)
>   hw/cxl/device: Implement MMIO HDM decoding (8.2.5.12)
>   hw/cxl/device: Add some trivial commands
>   hw/cxl/device: Plumb real Label Storage Area (LSA) sizing
>   hw/cxl/device: Implement get/set Label Storage Area (LSA)
>   hw/cxl/component: Implement host bridge MMIO (8.2.5, table 142)
>   acpi/cxl: Add _OSC implementation (9.14.2)
>   acpi/cxl: Create the CEDT (9.14.1)
>   acpi/cxl: Introduce CFMWS structures in CEDT
>   hw/cxl/component Add a dumb HDM decoder handler
>   qtest/cxl: Add more complex test cases with CFMWs
> 
> Jonathan Cameron (19):
>   MAINTAINERS: Add entry for Compute Express Link Emulation
>   cxl: Machine level control on whether CXL support is enabled
>   qtest/cxl: Introduce initial test for pxb-cxl only.
>   qtests/cxl: Add initial root port and CXL type3 tests
>   hw/cxl/component: Add utils for interleave parameter encoding/decoding
>   hw/cxl/host: Add support for CXL Fixed Memory Windows.
>   hw/pci-host/gpex-acpi: Add support for dsdt construction for pxb-cxl
>   pci/pcie_port: Add pci_find_port_by_pn()
>   CXL/cxl_component: Add cxl_get_hb_cstate()
>   mem/cxl_type3: Add read and write functions for associated hostmem.
>   cxl/cxl-host: Add memops for CFMWS region.
>   RFC: softmmu/memory: Add ops to memory_region_ram_init_from_file
>   i386/pc: Enable CXL fixed memory windows
>   tests/acpi: q35: Allow addition of a CXL test.
>   qtests/bios-tables-test: Add a test for CXL emulation.
>   tests/acpi: Add tables for CXL emulation.
>   hw/arm/virt: Basic CXL enablement on pci_expander_bridge instances
>     pxb-cxl
>   qtest/cxl: Add aarch64 virt test for CXL  docs/cxl: Add initial Compute eXpress Link (CXL) documentation.
> 
>  MAINTAINERS                         |   7 +
>  docs/system/device-emulation.rst    |   1 +
>  docs/system/devices/cxl.rst         | 302 +++++++++++++++++
>  hw/Kconfig                          |   1 +
>  hw/acpi/Kconfig                     |   5 +
>  hw/acpi/cxl-stub.c                  |  12 +
>  hw/acpi/cxl.c                       | 231 +++++++++++++
>  hw/acpi/meson.build                 |   4 +-
>  hw/arm/Kconfig                      |   1 +
>  hw/arm/virt-acpi-build.c            |  33 ++
>  hw/arm/virt.c                       |  40 ++-
>  hw/core/machine.c                   |  28 ++
>  hw/cxl/Kconfig                      |   3 +
>  hw/cxl/cxl-component-utils.c        | 284 ++++++++++++++++
>  hw/cxl/cxl-device-utils.c           | 271 ++++++++++++++++
>  hw/cxl/cxl-host-stubs.c             |  22 ++
>  hw/cxl/cxl-host.c                   | 262 +++++++++++++++
>  hw/cxl/cxl-mailbox-utils.c          | 483 ++++++++++++++++++++++++++++
>  hw/cxl/meson.build                  |  12 +
>  hw/i386/acpi-build.c                |  57 +++-
>  hw/i386/pc.c                        |  57 +++-
>  hw/mem/Kconfig                      |   5 +
>  hw/mem/cxl_type3.c                  | 353 ++++++++++++++++++++
>  hw/mem/meson.build                  |   1 +
>  hw/meson.build                      |   1 +
>  hw/pci-bridge/Kconfig               |   5 +
>  hw/pci-bridge/cxl_root_port.c       | 231 +++++++++++++
>  hw/pci-bridge/meson.build           |   1 +
>  hw/pci-bridge/pci_expander_bridge.c | 172 +++++++++-
>  hw/pci-bridge/pcie_root_port.c      |   6 +-
>  hw/pci-host/gpex-acpi.c             |  22 +-
>  hw/pci/pci.c                        |  21 +-
>  hw/pci/pcie_port.c                  |  25 ++
>  include/hw/acpi/cxl.h               |  28 ++
>  include/hw/arm/virt.h               |   1 +
>  include/hw/boards.h                 |   2 +
>  include/hw/cxl/cxl.h                |  51 +++
>  include/hw/cxl/cxl_component.h      | 206 ++++++++++++
>  include/hw/cxl/cxl_device.h         | 272 ++++++++++++++++
>  include/hw/cxl/cxl_pci.h            | 160 +++++++++
>  include/hw/pci/pci.h                |  14 +
>  include/hw/pci/pci_bridge.h         |  20 ++
>  include/hw/pci/pci_bus.h            |   7 +
>  include/hw/pci/pci_ids.h            |   1 +
>  include/hw/pci/pcie_port.h          |   2 +
>  qapi/machine.json                   |  15 +
>  qemu-options.hx                     |  37 +++
>  scripts/device-crash-test           |   1 +
>  softmmu/memory.c                    |   9 +
>  softmmu/vl.c                        |  11 +
>  tests/data/acpi/q35/CEDT.cxl        | Bin 0 -> 184 bytes
>  tests/data/acpi/q35/DSDT.cxl        | Bin 0 -> 9627 bytes
>  tests/qtest/bios-tables-test.c      |  39 +++
>  tests/qtest/cxl-test.c              | 181 +++++++++++
>  tests/qtest/meson.build             |   5 +
>  55 files changed, 3996 insertions(+), 25 deletions(-)
>  create mode 100644 docs/system/devices/cxl.rst
>  create mode 100644 hw/acpi/cxl-stub.c
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
>  create mode 100644 tests/data/acpi/q35/CEDT.cxl
>  create mode 100644 tests/data/acpi/q35/DSDT.cxl
>  create mode 100644 tests/qtest/cxl-test.c
> 

