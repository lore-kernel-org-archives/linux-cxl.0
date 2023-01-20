Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E0C7C25B4E
	for <linux-cxl@archiver.kernel.org>; Fri, 20 Jan 2023 14:48:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbjATOsQ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 20 Jan 2023 09:48:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbjATOsQ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 20 Jan 2023 09:48:16 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA1DC6D68C
        for <linux-cxl@vger.kernel.org>; Fri, 20 Jan 2023 06:47:57 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Nz1v11syPz6J7P3;
        Fri, 20 Jan 2023 22:23:25 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 20 Jan 2023 14:27:23 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>
CC:     Ben Widawsky <bwidawsk@kernel.org>, <linux-cxl@vger.kernel.org>,
        <linuxarm@huawei.com>, Ira Weiny <ira.weiny@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        <alison.schofield@intel.com>,
        Mike Maslenkin <mike.maslenkin@gmail.com>
Subject: [PATCH v2 5/7] hw/mem/cxl-type3: Add AER extended capability
Date:   Fri, 20 Jan 2023 14:24:48 +0000
Message-ID: <20230120142450.16089-6-Jonathan.Cameron@huawei.com>
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

This enables AER error injection to function as expected.
It is intended as a building block in enabling CXL RAS error injection
in the following patches.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 hw/mem/cxl_type3.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 217a5e639b..6cdd988d1d 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -250,6 +250,7 @@ static void ct3d_config_write(PCIDevice *pci_dev, uint32_t addr, uint32_t val,
 
     pcie_doe_write_config(&ct3d->doe_cdat, addr, val, size);
     pci_default_write_config(pci_dev, addr, val, size);
+    pcie_aer_write_config(pci_dev, addr, val, size);
 }
 
 /*
@@ -452,8 +453,19 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
     cxl_cstate->cdat.free_cdat_table = ct3_free_cdat_table;
     cxl_cstate->cdat.private = ct3d;
     cxl_doe_cdat_init(cxl_cstate, errp);
+
+    pcie_cap_deverr_init(pci_dev);
+    /* Leave a bit of room for expansion */
+    rc = pcie_aer_init(pci_dev, PCI_ERR_VER, 0x200, PCI_ERR_SIZEOF, NULL);
+    if (rc) {
+        goto err_release_cdat;
+    }
+
     return;
 
+err_release_cdat:
+    cxl_doe_cdat_release(cxl_cstate);
+    g_free(regs->special_ops);
 err_address_space_free:
     address_space_destroy(&ct3d->hostmem_as);
     return;
@@ -465,6 +477,7 @@ static void ct3_exit(PCIDevice *pci_dev)
     CXLComponentState *cxl_cstate = &ct3d->cxl_cstate;
     ComponentRegisters *regs = &cxl_cstate->crb;
 
+    pcie_aer_exit(pci_dev);
     cxl_doe_cdat_release(cxl_cstate);
     g_free(regs->special_ops);
     address_space_destroy(&ct3d->hostmem_as);
-- 
2.37.2

