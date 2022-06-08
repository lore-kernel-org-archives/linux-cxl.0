Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0C06C433EF
	for <linux-cxl@archiver.kernel.org>; Wed,  8 Jun 2022 15:00:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243192AbiFHPAh (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 8 Jun 2022 11:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244016AbiFHO64 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 8 Jun 2022 10:58:56 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79F252E93EA
        for <linux-cxl@vger.kernel.org>; Wed,  8 Jun 2022 07:55:29 -0700 (PDT)
Received: from fraeml744-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LJ9C90sXNz6872x;
        Wed,  8 Jun 2022 22:51:01 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml744-chm.china.huawei.com (10.206.15.225) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 8 Jun 2022 16:54:33 +0200
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2375.24; Wed, 8 Jun 2022 15:54:32 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, <qemu-devel@nongnu.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Ben Widawsky <bwidawsk@kernel.org>
CC:     <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>,
        <alex.bennee@linaro.org>, Marcel Apfelbaum <marcel@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>,
        Markus Armbruster <armbru@redhat.com>,
        "Mark Cave-Ayland" <mark.cave-ayland@ilande.co.uk>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Tong Zhang <ztong0001@gmail.com>,
        "Shameerali Kolothum Thodi" <shameerali.kolothum.thodi@huawei.com>
Subject: [PATCH v3 0/8] hw/cxl: Move CXL emulation options and state to machines.
Date:   Wed, 8 Jun 2022 15:54:32 +0100
Message-ID: <20220608145440.26106-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhreml703-chm.china.huawei.com (10.201.108.52) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Changes since v2: (reviews from Davidlohr and Ben - thanks!)
- Update qemu-options.hx to reflect that cxl-fmw is now a machine
  property. (Davidlohr Bueso)
- Pick up David (patch 1) and Ben's RBs (all).

Changes since v1 (thanks to Paolo Bonzini)
* Update 'description' of cxl-fmw as suggested to mention it's an array.
* Add a wrapper cxl_hook_up_pxb_registers() to cxl-host.c as it'll be common
  for all machines using CXL with PXB.

V1 Cover letter:

Currently the only machine with CXL support upstream is i386/pc but arm/virt
patches have been posted and once this is merged an updated series will
follow. Switch support is queued behind this as well because they both
include documentation updates.

Paolo Bonzini highlighted a couple of issues with the current CXL
emulation code.

* Top level parameter rather than machine for fixed memory windows

  The --cxl-fixed-memory-window top level command line parameters won't play
  well with efforts to make it possible to instantiate entire machines via
  RPC. Better to move these to be machine configuration.  This change is
  relatively straight forward, but does result in very long command lines
  (cannot break fixed window setup into multiple -M entries).

* Move all CXL stuff to machine specific code and helpers

  To simplify the various interactions between machine setup and host
  bridges etc, currently various CXL steps are called from the generic
  core/machine.c and softmmu/vl.c + there are CXL elements in MachineState.

  Much of this is straight forward to do with one exception:
  The CXL pci_expander_bridge host bridges require MMIO register space.
  This series does this by walking the bus and filling the register space
  in via the machine_done callback. This is similar to the walk done for
  identifying host bridges in the ACPI building code but it is rather ugly
  and postpones rejection of PXB_CXL instances where cxl=off (default).

All comments welcome, but the first patch at least changes the command-line
so to avoid have to add backwards compatibility code, it would be great
to merge that before 7.1 is released.

Thanks,

Jonathan

Jonathan Cameron (8):
  hw/cxl: Make the CXL fixed memory window setup a machine parameter.
  hw/acpi/cxl: Pass in the CXLState directly rather than MachineState
  hw/cxl: Push linking of CXL targets into i386/pc rather than in
    machine.c
  tests/acpi: Allow modification of q35 CXL CEDT table.
  pci/pci_expander_bridge: For CXL HB delay the HB register memory
    region setup.
  tests/acpi: Update q35/CEDT.cxl for new memory addresses.
  hw/cxl: Move the CXLState from MachineState to machine type specific
    state.
  hw/machine: Drop cxl_supported flag as no longer useful

 docs/system/devices/cxl.rst                 |   4 +-
 hw/acpi/cxl.c                               |   9 +-
 hw/core/machine.c                           |  28 ------
 hw/cxl/cxl-host-stubs.c                     |   9 +-
 hw/cxl/cxl-host.c                           | 100 ++++++++++++++++++--
 hw/i386/acpi-build.c                        |   8 +-
 hw/i386/pc.c                                |  31 +++---
 hw/pci-bridge/meson.build                   |   5 +-
 hw/pci-bridge/pci_expander_bridge.c         |  32 ++++---
 hw/pci-bridge/pci_expander_bridge_stubs.c   |  14 +++
 include/hw/acpi/cxl.h                       |   5 +-
 include/hw/boards.h                         |   3 +-
 include/hw/cxl/cxl.h                        |   9 +-
 include/hw/cxl/cxl_host.h                   |  23 +++++
 include/hw/i386/pc.h                        |   2 +
 include/hw/pci-bridge/pci_expander_bridge.h |  12 +++
 qapi/machine.json                           |  13 +++
 qemu-options.hx                             |  73 +++++++-------
 softmmu/vl.c                                |  46 ---------
 tests/data/acpi/q35/CEDT.cxl                | Bin 184 -> 184 bytes
 tests/qtest/bios-tables-test.c              |   4 +-
 tests/qtest/cxl-test.c                      |   4 +-
 22 files changed, 256 insertions(+), 178 deletions(-)
 create mode 100644 hw/pci-bridge/pci_expander_bridge_stubs.c
 create mode 100644 include/hw/cxl/cxl_host.h
 create mode 100644 include/hw/pci-bridge/pci_expander_bridge.h

-- 
2.32.0

