Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 658DEC27C7C
	for <linux-cxl@archiver.kernel.org>; Fri, 20 Jan 2023 14:27:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231148AbjATO07 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 20 Jan 2023 09:26:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230452AbjATO0X (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 20 Jan 2023 09:26:23 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 000C2CFD09
        for <linux-cxl@vger.kernel.org>; Fri, 20 Jan 2023 06:25:53 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Nz1sF4nxFz6J7Pn;
        Fri, 20 Jan 2023 22:21:53 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 20 Jan 2023 14:25:51 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>
CC:     Ben Widawsky <bwidawsk@kernel.org>, <linux-cxl@vger.kernel.org>,
        <linuxarm@huawei.com>, Ira Weiny <ira.weiny@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        <alison.schofield@intel.com>,
        Mike Maslenkin <mike.maslenkin@gmail.com>
Subject: [PATCH v2 2/7] hw/pci/aer: Add missing routing for AER errors
Date:   Fri, 20 Jan 2023 14:24:45 +0000
Message-ID: <20230120142450.16089-3-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230120142450.16089-1-Jonathan.Cameron@huawei.com>
References: <20230120142450.16089-1-Jonathan.Cameron@huawei.com>
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

PCIe r6.0 Figure 6-3 "Pseudo Logic Diagram for Selected Error Message Control
and Status Bits" includes a right hand branch under "All PCI Express devices"
that allows for messages to be generated or sent onwards without SERR#
being set as long as the appropriate per error class bit in the PCIe
Device Control Register is set.

Implement that branch thus enabling routing of ERR_COR, ERR_NONFATAL
and ERR_FATAL under OSes that set these bits appropriately (e.g. Linux)

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 hw/pci/pcie_aer.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/hw/pci/pcie_aer.c b/hw/pci/pcie_aer.c
index 909e027d99..103667c368 100644
--- a/hw/pci/pcie_aer.c
+++ b/hw/pci/pcie_aer.c
@@ -192,8 +192,16 @@ static void pcie_aer_update_uncor_status(PCIDevice *dev)
 static bool
 pcie_aer_msg_alldev(PCIDevice *dev, const PCIEAERMsg *msg)
 {
+    uint16_t devctl = pci_get_word(dev->config + dev->exp.exp_cap +
+                                   PCI_EXP_DEVCTL);
     if (!(pcie_aer_msg_is_uncor(msg) &&
-          (pci_get_word(dev->config + PCI_COMMAND) & PCI_COMMAND_SERR))) {
+          (pci_get_word(dev->config + PCI_COMMAND) & PCI_COMMAND_SERR)) &&
+        !((msg->severity == PCI_ERR_ROOT_CMD_NONFATAL_EN) &&
+          (devctl & PCI_EXP_DEVCTL_NFERE)) &&
+        !((msg->severity == PCI_ERR_ROOT_CMD_COR_EN) &&
+          (devctl & PCI_EXP_DEVCTL_CERE)) &&
+        !((msg->severity == PCI_ERR_ROOT_CMD_FATAL_EN) &&
+          (devctl & PCI_EXP_DEVCTL_FERE))) {
         return false;
     }
 
-- 
2.37.2

