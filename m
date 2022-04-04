Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1ED0C433EF
	for <linux-cxl@archiver.kernel.org>; Mon,  4 Apr 2022 15:14:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237512AbiDDPQ1 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 4 Apr 2022 11:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345897AbiDDPQ0 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 4 Apr 2022 11:16:26 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCB5121E28
        for <linux-cxl@vger.kernel.org>; Mon,  4 Apr 2022 08:14:29 -0700 (PDT)
Received: from fraeml740-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KXDmF4gNzz67J5F;
        Mon,  4 Apr 2022 23:12:45 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml740-chm.china.huawei.com (10.206.15.221) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 4 Apr 2022 17:14:27 +0200
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 4 Apr 2022 16:14:26 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <linuxarm@huawei.com>, <qemu-devel@nongnu.org>,
        =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
        Marcel Apfelbaum <marcel@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>,
        Markus Armbruster <armbru@redhat.com>,
        "Mark Cave-Ayland" <mark.cave-ayland@ilande.co.uk>,
        Adam Manzanares <a.manzanares@samsung.com>
CC:     <linux-cxl@vger.kernel.org>, Ben Widawsky <ben.widawsky@intel.com>,
        "Peter Maydell" <peter.maydell@linaro.org>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Saransh Gupta1 <saransh@ibm.com>,
        Shreyas Shah <shreyas.shah@elastics.cloud>,
        Chris Browy <cbrowy@avery-design.com>,
        "Samarth Saxena" <samarths@cadence.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "k . jensen @ samsung . com" <k.jensen@samsung.com>,
        Tong Zhang <t.zhang2@samsung.com>, <dave@stgolabs.net>,
        Alison Schofield <alison.schofield@intel.com>
Subject: [PATCH v9 00/45] CXl 2.0 emulation Support
Date:   Mon, 4 Apr 2022 16:14:00 +0100
Message-ID: <20220404151445.10955-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhreml717-chm.china.huawei.com (10.201.108.68) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

CI passing both with the full series and at appropriate points
for a partial series merge if desired (at end of each section
tests are introduced)
https://gitlab.com/jic23/qemu/-/pipelines/508396913
Possible partial sets:
1-15 (end with the test of the pxb-cxl host bridge)
16-22 (end with the test for root port and type3 device)
23-39 (end with tests on x86 pc for CFMWS including BIOS table updates)
40-41 (arm64 virt support + simple test case)
42 (documentation - we could pull this forwards to before the arm support)
43-45 (switch support)

Note the gitlab branch also has additional patches on top of these
that will form the part of future postings (PCIe DOE, CDAT,
serial number support and improved fidelity of emulation)
Several people have asked about contributing additional features.
As those come in I'll apply them on top of this series and handle
rebases etc as necessary whilst we seek to get this first set
of patches upstream.

Changes since v8:
 Thanks to Adam Manzanares, Alison Schofield and Mark Cave-Ayland
 for review.
For reference v8 thread at:
https://lore.kernel.org/qemu-devel/20220318150635.24600-1-Jonathan.Cameron@huawei.com/
 
 - Fix crash when no hostmem region provided (from CI)
 - Fix a mid series build bug (from chasing that CI issue)
 - (various patches) Switch the various struct cxl_dvsec_* to typdefs
   CXLDVSECDeviceGPF etc. This reduces line lengths in a patch to add
   write masks for PCI config space that will be part of a follow up
   to this series.
 - (various) Switch away from old style initializers and associated
   renames (Mark) 
 - (patch 2, various) Use sizeof() or local size variable rather than
   hard coding division by 4 or 8 when indexing into register arrays (Adam)
 - (patch 2) Add comment for strange write mask CXL_RAS_UNC_ERR_SEVERITY (Adam)
 - (patch 2) Fix wrong mask for COR_ERR
 - (patch 2) Add a comment explaining less than obvious fact we can use
   a contrived order of capabilities to allow a single number to represent
   which ones should be enabled. (Adam)
 - (patch 2) Wrong version number for RAS cap header (Adam)
 - (patch 2) Wrong space left for HDM decoders (Adam)
 - (patch 2) Fix field of cxl_dvsec_port_extensions to be
   alt_prefetch_limit_high (Adam)
 - (patch 2) Add CXLDVSECDeviceGPF (noticed as part of follow up series prep)
 - (patch 3) Improve docs around the large ASCI art figure (Adam)
 - (patch 3) Rename CXL_DEVICE_REGISTERS_* to CXL_DEVICE_STATUS_REGISTERS *
   to match the specification (Adam)
 - (patch 3) Extra references to the specification (Adam)
 - (patch 3) Rename a few fields in CXL_DEV_BG_CMD_STS to more closely match
   the specification (Adam)
 - (patch 17) Drop stale ifdef (Mark)
 - (patch 19) Fix wrong value of part_info->nex_pmem so it now matches
   what the spec requires (Alison)
 - (patch 27) Fix docs to not mention OptsVisitor, to be more detailed
   on what sizes are accepted, provid more detail on what id means and
   update version number (Mark)
 - (patch 27) Use loc_save()/loc_pop() to improve printed error (Mark)
 - (patch 27) Rename config function (Mark)
 - (patch 32) Fix address_space cleanup and move other parts of
   instance_finalize() to pc->exit() to balance what is in pc->realize()
   (Mark)
 - (various) Minor typos and formatting cleanup observed whilst preparing
   series.
Some discussion occurred on allow for volatile memory support rather than
just PMEM. That is postponed to a future patch set. Also some discussion
on future work coordination.

Mark's suggestion of using PCI BDF for naming unfortunately doesn't
work as they are not constant (or indeed enumerated at all in some cases)

I'm resisting the urge to have this series continue to grow with
additional features on the basis it is already huge and what we have
here is useful + functional.

Updated background info:

Looking in particular for:
* Review of the PCI interactions
* x86 and ARM machine interactions (particularly the memory maps)
* Review of the interleaving approach - is the basic idea
  acceptable?
* Review of the command line interface.
* CXL related review welcome but much of that got reviewed
  in earlier versions and hasn't changed substantially.

TODOs:

* Volatile memory devices (easy but it's more code so left for now).
* Hotplug?  May not need much but it's not tested yet!
* More tests and tighter verification that values written to hardware
  are actually valid - stuff that real hardware would check.
* Testing, testing and more testing.  I have been running a basic
  set of ARM and x86 tests on this, but there is always room for
  more tests and greater automation.
* CFMWS flags as requested by Ben.
* Parititioning support - ability to change the balance of volatile
  and non volatile memory on demand.
* Trace points as suggested my Mark to help with debugging memory
  interleaving setup.

Why do we want QEMU emulation of CXL?

As Ben stated in V3, QEMU support has been critical to getting OS
software written given lack of availability of hardware supporting the
latest CXL features (coupled with very high demand for support being
ready in a timely fashion). What has become clear since Ben's v3
is that situation is a continuous one. Whilst we can't talk about
them yet, CXL 3.0 features and OS support have been prototyped on
top of this support and a lot of the ongoing kernel work is being
tested against these patches. The kernel CXL mocking code allows
some forms of testing, but QEMU provides a more versatile and
extensible platform.

Other features on the qemu-list that build on these include PCI-DOE
/CDAT support from the Avery Design team further showing how this
code is useful. Whilst not directly related this is also the test
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

What we have here is about what you need for it to be useful for testing
currently kernel code.  Note the kernel code is moving fast so
since v4, some features have been introduced we don't yet support in
QEMU (e.g. use of the PCIe serial number extended capability).

All comments welcome.

Additional info that was here in v5 is now in the documentation patch.

Thanks,

Jonathan

Ben Widawsky (24):
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
  hw/cxl/rp: Add a root port
  hw/cxl/device: Add a memory device (8.2.8.5)
  hw/cxl/device: Implement MMIO HDM decoding (8.2.5.12)
  hw/cxl/device: Add some trivial commands
  hw/cxl/device: Plumb real Label Storage Area (LSA) sizing
  hw/cxl/device: Implement get/set Label Storage Area (LSA)
  hw/cxl/component: Implement host bridge MMIO (8.2.5, table 142)
  acpi/cxl: Add _OSC implementation (9.14.2)
  acpi/cxl: Create the CEDT (9.14.1)
  acpi/cxl: Introduce CFMWS structures in CEDT
  hw/cxl/component Add a dumb HDM decoder handler
  qtest/cxl: Add more complex test cases with CFMWs

Jonathan Cameron (21):
  MAINTAINERS: Add entry for Compute Express Link Emulation
  cxl: Machine level control on whether CXL support is enabled
  qtest/cxl: Introduce initial test for pxb-cxl only.
  qtests/cxl: Add initial root port and CXL type3 tests
  hw/cxl/component: Add utils for interleave parameter encoding/decoding
  hw/cxl/host: Add support for CXL Fixed Memory Windows.
  hw/pci-host/gpex-acpi: Add support for dsdt construction for pxb-cxl
  pci/pcie_port: Add pci_find_port_by_pn()
  CXL/cxl_component: Add cxl_get_hb_cstate()
  mem/cxl_type3: Add read and write functions for associated hostmem.
  cxl/cxl-host: Add memops for CFMWS region.
  i386/pc: Enable CXL fixed memory windows
  tests/acpi: q35: Allow addition of a CXL test.
  qtests/bios-tables-test: Add a test for CXL emulation.
  tests/acpi: Add tables for CXL emulation.
  hw/arm/virt: Basic CXL enablement on pci_expander_bridge instances
    pxb-cxl
  qtest/cxl: Add aarch64 virt test for CXL
  docs/cxl: Add initial Compute eXpress Link (CXL) documentation.
  pci-bridge/cxl_upstream: Add a CXL switch upstream port
  pci-bridge/cxl_downstream: Add a CXL switch downstream port
  docs/cxl: Add switch documentation

 MAINTAINERS                         |   7 +
 docs/system/device-emulation.rst    |   1 +
 docs/system/devices/cxl.rst         | 386 ++++++++++++++++++++++
 hw/Kconfig                          |   1 +
 hw/acpi/Kconfig                     |   5 +
 hw/acpi/cxl-stub.c                  |  12 +
 hw/acpi/cxl.c                       | 257 +++++++++++++++
 hw/acpi/meson.build                 |   4 +-
 hw/arm/Kconfig                      |   1 +
 hw/arm/virt-acpi-build.c            |  33 ++
 hw/arm/virt.c                       |  40 ++-
 hw/core/machine.c                   |  28 ++
 hw/cxl/Kconfig                      |   3 +
 hw/cxl/cxl-component-utils.c        | 290 +++++++++++++++++
 hw/cxl/cxl-device-utils.c           | 265 +++++++++++++++
 hw/cxl/cxl-host-stubs.c             |  16 +
 hw/cxl/cxl-host.c                   | 261 +++++++++++++++
 hw/cxl/cxl-mailbox-utils.c          | 478 ++++++++++++++++++++++++++++
 hw/cxl/meson.build                  |  12 +
 hw/i386/acpi-build.c                |  57 +++-
 hw/i386/pc.c                        |  57 +++-
 hw/mem/Kconfig                      |   5 +
 hw/mem/cxl_type3.c                  | 368 +++++++++++++++++++++
 hw/mem/meson.build                  |   1 +
 hw/meson.build                      |   1 +
 hw/pci-bridge/Kconfig               |   5 +
 hw/pci-bridge/cxl_downstream.c      | 244 ++++++++++++++
 hw/pci-bridge/cxl_root_port.c       | 231 ++++++++++++++
 hw/pci-bridge/cxl_upstream.c        | 211 ++++++++++++
 hw/pci-bridge/meson.build           |   1 +
 hw/pci-bridge/pci_expander_bridge.c | 167 +++++++++-
 hw/pci-bridge/pcie_root_port.c      |   6 +-
 hw/pci-host/gpex-acpi.c             |  20 +-
 hw/pci/pci.c                        |  21 +-
 hw/pci/pcie_port.c                  |  25 ++
 include/hw/acpi/cxl.h               |  28 ++
 include/hw/arm/virt.h               |   1 +
 include/hw/boards.h                 |   2 +
 include/hw/cxl/cxl.h                |  65 ++++
 include/hw/cxl/cxl_component.h      | 207 ++++++++++++
 include/hw/cxl/cxl_device.h         | 268 ++++++++++++++++
 include/hw/cxl/cxl_pci.h            | 167 ++++++++++
 include/hw/pci/pci.h                |  14 +
 include/hw/pci/pci_bridge.h         |  20 ++
 include/hw/pci/pci_bus.h            |   7 +
 include/hw/pci/pci_ids.h            |   1 +
 include/hw/pci/pcie_port.h          |   2 +
 qapi/machine.json                   |  21 ++
 qemu-options.hx                     |  38 +++
 scripts/device-crash-test           |   1 +
 softmmu/vl.c                        |  47 +++
 tests/data/acpi/q35/CEDT.cxl        | Bin 0 -> 184 bytes
 tests/data/acpi/q35/DSDT.cxl        | Bin 0 -> 9615 bytes
 tests/qtest/bios-tables-test.c      |  44 +++
 tests/qtest/cxl-test.c              | 181 +++++++++++
 tests/qtest/meson.build             |   5 +
 56 files changed, 4612 insertions(+), 27 deletions(-)
 create mode 100644 docs/system/devices/cxl.rst
 create mode 100644 hw/acpi/cxl-stub.c
 create mode 100644 hw/acpi/cxl.c
 create mode 100644 hw/cxl/Kconfig
 create mode 100644 hw/cxl/cxl-component-utils.c
 create mode 100644 hw/cxl/cxl-device-utils.c
 create mode 100644 hw/cxl/cxl-host-stubs.c
 create mode 100644 hw/cxl/cxl-host.c
 create mode 100644 hw/cxl/cxl-mailbox-utils.c
 create mode 100644 hw/cxl/meson.build
 create mode 100644 hw/mem/cxl_type3.c
 create mode 100644 hw/pci-bridge/cxl_downstream.c
 create mode 100644 hw/pci-bridge/cxl_root_port.c
 create mode 100644 hw/pci-bridge/cxl_upstream.c
 create mode 100644 include/hw/acpi/cxl.h
 create mode 100644 include/hw/cxl/cxl.h
 create mode 100644 include/hw/cxl/cxl_component.h
 create mode 100644 include/hw/cxl/cxl_device.h
 create mode 100644 include/hw/cxl/cxl_pci.h
 create mode 100644 tests/data/acpi/q35/CEDT.cxl
 create mode 100644 tests/data/acpi/q35/DSDT.cxl
 create mode 100644 tests/qtest/cxl-test.c

-- 
2.32.0

