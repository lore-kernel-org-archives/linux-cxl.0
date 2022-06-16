Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65DC8CCA47A
	for <linux-cxl@archiver.kernel.org>; Thu, 16 Jun 2022 14:51:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377146AbiFPOvW (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 16 Jun 2022 10:51:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376998AbiFPOvW (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 16 Jun 2022 10:51:22 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DCE82E6AF
        for <linux-cxl@vger.kernel.org>; Thu, 16 Jun 2022 07:51:20 -0700 (PDT)
Received: from fraeml703-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LP4qc4gn9z67F4F;
        Thu, 16 Jun 2022 22:51:08 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml703-chm.china.huawei.com (10.206.15.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Thu, 16 Jun 2022 16:51:17 +0200
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 16 Jun 2022 15:51:16 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <qemu-devel@nongnu.org>, "Michael S . Tsirkin" <mst@redhat.com>,
        "Ben Widawsky" <bwidawsk@kernel.org>
CC:     Paolo Bonzini <pbonzini@redhat.com>, <linux-cxl@vger.kernel.org>,
        <linuxarm@huawei.com>, <alex.bennee@linaro.org>,
        Peter Maydell <peter.maydell@linaro.org>,
        Marcel Apfelbaum <marcel@redhat.com>,
        "Igor Mammedov" <imammedo@redhat.com>,
        Markus Armbruster <armbru@redhat.com>,
        "Mark Cave-Ayland" <mark.cave-ayland@ilande.co.uk>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Tong Zhang <ztong0001@gmail.com>,
        "Shameerali Kolothum Thodi" <shameerali.kolothum.thodi@huawei.com>
Subject: [PATCH v11 0/3] hw/pci-bridge/cxl: Add CXL Switches.
Date:   Thu, 16 Jun 2022 15:51:23 +0100
Message-ID: <20220616145126.8002-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhreml741-chm.china.huawei.com (10.201.108.191) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Previously sent as patches 43-45 of
[PATCH v10 00/45] CXl 2.0 emulation Support
https://lore.kernel.org/qemu-devel/20220429144110.25167-45-Jonathan.Cameron@huawei.com/#r

Now the initial CXL support is upstream, patch sets applying to different
parts of the CXL infrastructure can be reviewed / applied in any
order.
I have just sent out arm/virt support and aim to send out DOE/CDAT patches
shortly. This series is independent of those others.

Changes since v10:
- Rebase.
- Typo fix in comment about xio3110.

This series adds CXL switch support in the form of upstream and downstream
ports + the additions to the interleave decoder in cxl-host to enable
us to interleave across the downstream switch ports.  The PCI IDs used
have been allocated against Huawei's Vendor ID for use for emulation of
these devices only. Primary use for this support is for testing the Linux
kernel stack.

Note only 1 level of switching / switch based HDM interleave decoding
is supported - consistent with typical CXL 2.0 systems.
Interleaving may occur and any / some / all of:
- Across multiple CXL host bridges (static setup via Fixed Memory Windows).
- Across multiple root ports in a given CXL host bridge (dynamic config
  via CXL host bridge register space.
- Across multiple downstream switch ports (this series).

All comments welcome,

Thanks,

Jonathan


Jonathan Cameron (3):
  pci-bridge/cxl_upstream: Add a CXL switch upstream port
  pci-bridge/cxl_downstream: Add a CXL switch downstream port
  docs/cxl: Add switch documentation

 docs/system/devices/cxl.rst    |  88 +++++++++++-
 hw/cxl/cxl-host.c              |  43 +++++-
 hw/pci-bridge/cxl_downstream.c | 249 +++++++++++++++++++++++++++++++++
 hw/pci-bridge/cxl_upstream.c   | 216 ++++++++++++++++++++++++++++
 hw/pci-bridge/meson.build      |   2 +-
 include/hw/cxl/cxl.h           |   5 +
 6 files changed, 598 insertions(+), 5 deletions(-)
 create mode 100644 hw/pci-bridge/cxl_downstream.c
 create mode 100644 hw/pci-bridge/cxl_upstream.c

-- 
2.32.0

