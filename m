Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B46ECC54EAA
	for <linux-cxl@archiver.kernel.org>; Mon, 30 Jan 2023 14:37:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235123AbjA3Ohh (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 30 Jan 2023 09:37:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235834AbjA3Ohg (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 30 Jan 2023 09:37:36 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ADE8E9
        for <linux-cxl@vger.kernel.org>; Mon, 30 Jan 2023 06:37:36 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4P59jc2sKCz6J9fJ;
        Mon, 30 Jan 2023 22:36:36 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 30 Jan 2023 14:37:33 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>
CC:     Ben Widawsky <bwidawsk@kernel.org>, <linux-cxl@vger.kernel.org>,
        <linuxarm@huawei.com>, Ira Weiny <ira.weiny@intel.com>,
        Gregory Price <gourry.memverge@gmail.com>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 01/10] hw/mem/cxl_type3: Improve error handling in realize()
Date:   Mon, 30 Jan 2023 14:36:56 +0000
Message-ID: <20230130143705.11758-2-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230130143705.11758-1-Jonathan.Cameron@huawei.com>
References: <20230130143705.11758-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

msix_init_exclusive_bar() can fail, so if it does cleanup the address space.

Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 hw/mem/cxl_type3.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index dae4fd89ca..252822bd82 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -401,7 +401,7 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
     MemoryRegion *mr = &regs->component_registers;
     uint8_t *pci_conf = pci_dev->config;
     unsigned short msix_num = 1;
-    int i;
+    int i, rc;
 
     if (!cxl_setup_memory(ct3d, errp)) {
         return;
@@ -438,7 +438,10 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
                      &ct3d->cxl_dstate.device_registers);
 
     /* MSI(-X) Initailization */
-    msix_init_exclusive_bar(pci_dev, msix_num, 4, NULL);
+    rc = msix_init_exclusive_bar(pci_dev, msix_num, 4, NULL);
+    if (rc) {
+        goto err_address_space_free;
+    }
     for (i = 0; i < msix_num; i++) {
         msix_vector_use(pci_dev, i);
     }
@@ -450,6 +453,11 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
     cxl_cstate->cdat.free_cdat_table = ct3_free_cdat_table;
     cxl_cstate->cdat.private = ct3d;
     cxl_doe_cdat_init(cxl_cstate, errp);
+    return;
+
+err_address_space_free:
+    address_space_destroy(&ct3d->hostmem_as);
+    return;
 }
 
 static void ct3_exit(PCIDevice *pci_dev)
-- 
2.37.2

