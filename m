Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7217C61DA4
	for <linux-cxl@archiver.kernel.org>; Mon, 30 Jan 2023 15:53:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235055AbjA3Pxx (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 30 Jan 2023 10:53:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235825AbjA3Pxw (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 30 Jan 2023 10:53:52 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7E4A76BF
        for <linux-cxl@vger.kernel.org>; Mon, 30 Jan 2023 07:53:51 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4P5CPb6py2z6J9gH;
        Mon, 30 Jan 2023 23:52:51 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 30 Jan 2023 15:53:49 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>
CC:     Ben Widawsky <bwidawsk@kernel.org>, <linux-cxl@vger.kernel.org>,
        <linuxarm@huawei.com>, Ira Weiny <ira.weiny@intel.com>,
        Gregory Price <gourry.memverge@gmail.com>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        Mike Maslenkin <mike.maslenkin@gmail.com>
Subject: [PATCH v3 2/8] hw/pci/aer: Add missing routing for AER errors
Date:   Mon, 30 Jan 2023 15:52:45 +0000
Message-ID: <20230130155251.3430-3-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230130155251.3430-1-Jonathan.Cameron@huawei.com>
References: <20230130155251.3430-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
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

