Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B1E2C61DA3
	for <linux-cxl@archiver.kernel.org>; Tue, 21 Feb 2023 15:21:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233810AbjBUPVu (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 21 Feb 2023 10:21:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234503AbjBUPVn (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 21 Feb 2023 10:21:43 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACA6C25BB2
        for <linux-cxl@vger.kernel.org>; Tue, 21 Feb 2023 07:21:37 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PLjd25yt6z6J9fv;
        Tue, 21 Feb 2023 23:19:34 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Tue, 21 Feb 2023 15:21:34 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>
CC:     Ben Widawsky <bwidawsk@kernel.org>, <linux-cxl@vger.kernel.org>,
        <linuxarm@huawei.com>, Ira Weiny <ira.weiny@intel.com>,
        Gregory Price <gourry.memverge@gmail.com>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        Mike Maslenkin <mike.maslenkin@gmail.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Markus Armbruster <armbru@redhat.com>
Subject: [PATCH v5 0/8] hw/cxl: RAS error emulation and injection
Date:   Tue, 21 Feb 2023 15:21:37 +0000
Message-ID: <20230221152145.9736-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

v5: thanks to Dave Jiang for review.
- Spell out Implementation Defined.
- Pick up Dave's tags - thanks!
v4:
In response to similar feedback on poison injection series (Markus Armbruster).
 - More detailed documentation in cxl.json
 - Based on tag in format suggested by Markus.

Based on series "[PATCH v4 00/10] hw/cxl: CXL emulation cleanups and minor fixes for upstream"

Based on: Message-Id: 20230206172816.8201-1-Jonathan.Cameron@huawei.com

v3 cover letter.

CXL error reporting is complex. This series only covers the protocol
related errors reported via PCIe AER - Ira Weiny has posted support for
Event log based injection and I will post an update of Poison list injection
shortly. My proposal is to upstream this one first, followed by Ira's Event
Log series, then finally the Poison List handling. That is based on likely
order of Linux kernel support (the support for this type of error reporting
went in during the recent merge window, the others are still under review).
Note we may propose other non error related features in between!

In order to test the kernel support for RAS error handling, I previously
provided this series via gitlab, enabling David Jiang's kernel patches
to be tested.

Now that Linux kernel support is upstream, this series is proposing the
support for upstream inclusion in QEMU. Note that support for Multiple
Header Recording has been added to QEMU the meantime and a kernel
patch to use that feature sent out.

https://lore.kernel.org/linux-cxl/20230113154058.16227-1-Jonathan.Cameron@huawei.com/T/#t

There are two generic PCI AER precursor feature additions.
1) The PCI_ERR_UCOR_MASK register has not been implemented until now
   and is necessary for correct emulation.
2) The routing for AER errors, via existing AER error injection, only
   covered one of two paths given in the PCIe base specification,
   unfortunately not the one used by the Linux kernel CXL support.

The use of MSI for the CXL root ports, both makes sense from the point
of view of how it may well be implemented, and works around the documented
lack of PCI interrupt routing in i386/q35. I have a hack that lets
us correctly route those interrupts but don't currently plan to post it.

The actual CXL error injection uses a new QMP interface as documented
in the final patch description. The existing AER error injection
internals are reused though it's HMP interface is not.

Injection via QMP:
{ "execute": "qmp_capabilities" }
...
{ "execute": "cxl-inject-uncorrectable-errors",
  "arguments": {
    "path": "/machine/peripheral/cxl-pmem0",
    "errors": [
        {
            "type": "cache-address-parity",
            "header": [ 3, 4]
        },
        {
            "type": "cache-data-parity",
            "header": [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31]
        },
        {
            "type": "internal",
            "header": [ 1, 2, 4]
        }
        ]
  }}
...
{ "execute": "cxl-inject-correctable-error",
    "arguments": {
        "path": "/machine/peripheral/cxl-pmem0",
        "type": "physical"
    } }

Jonathan Cameron (8):
  hw/pci/aer: Implement PCI_ERR_UNCOR_MASK register
  hw/pci/aer: Add missing routing for AER errors
  hw/pci-bridge/cxl_root_port: Wire up AER
  hw/pci-bridge/cxl_root_port: Wire up MSI
  hw/mem/cxl-type3: Add AER extended capability
  hw/cxl: Fix endian issues in CXL RAS capability defaults / masks
  hw/pci/aer: Make PCIE AER error injection facility available for other
    emulation to use.
  hw/mem/cxl_type3: Add CXL RAS Error Injection Support.

 hw/cxl/cxl-component-utils.c   |  20 ++-
 hw/mem/cxl_type3.c             | 294 +++++++++++++++++++++++++++++++++
 hw/mem/cxl_type3_stubs.c       |  10 ++
 hw/mem/meson.build             |   2 +
 hw/pci-bridge/cxl_root_port.c  |  64 +++++++
 hw/pci/pci-internal.h          |   1 -
 hw/pci/pcie_aer.c              |  14 +-
 include/hw/cxl/cxl_component.h |  26 +++
 include/hw/cxl/cxl_device.h    |  11 ++
 include/hw/pci/pcie_aer.h      |   1 +
 include/hw/pci/pcie_regs.h     |   3 +
 qapi/cxl.json                  | 118 +++++++++++++
 qapi/meson.build               |   1 +
 qapi/qapi-schema.json          |   1 +
 14 files changed, 555 insertions(+), 11 deletions(-)
 create mode 100644 hw/mem/cxl_type3_stubs.c
 create mode 100644 qapi/cxl.json

-- 
2.37.2

