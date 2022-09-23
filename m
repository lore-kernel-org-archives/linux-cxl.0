Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6BDCECAAD8
	for <linux-cxl@archiver.kernel.org>; Fri, 23 Sep 2022 16:20:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbiIWQU2 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 23 Sep 2022 12:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232000AbiIWQTq (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 23 Sep 2022 12:19:46 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F046F14C06D
        for <linux-cxl@vger.kernel.org>; Fri, 23 Sep 2022 09:18:31 -0700 (PDT)
Received: from fraeml704-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MYxz725JGz67PwL;
        Sat, 24 Sep 2022 00:13:39 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml704-chm.china.huawei.com (10.206.15.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.31; Fri, 23 Sep 2022 18:18:29 +0200
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 23 Sep 2022 17:18:29 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <linux-cxl@vger.kernel.org>, <qemu-devel@nongnu.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Ben Widawsky <bwidawsk@kernel.org>
CC:     <linuxarm@huawei.com>
Subject: [PATCH] mem/cxl-type3: Add sn option to provide serial number for PCI ecap
Date:   Fri, 23 Sep 2022 17:18:35 +0100
Message-ID: <20220923161835.9805-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

The Device Serial Number Extended Capability PCI r6.0 sec 7.9.3
provides a standard way to provide a device serial number as
an IEEE defined 64-bit extended unique identifier EUI-64.

CXL 2.0 section 8.1.12.2 Memory Device PCIe Capabilities and
Extended Capabilities requires this to be used to uniquely
identify CXL memory devices.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---

This is the missing element to be able to use the Linux kernel
support for PMEM region creation.  Without this you can create
a region, but not remount it after reboot (as the label
is not valid).

 hw/mem/cxl_type3.c          | 14 +++++++++++++-
 include/hw/cxl/cxl_device.h |  1 +
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 3bf2869573..e0c1535b73 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -14,6 +14,12 @@
 #include "sysemu/hostmem.h"
 #include "hw/cxl/cxl.h"
 
+/*
+ * Null value of all Fs suggested by IEEE RA guidelines for use of
+ * EU, OUI and CID
+ */
+#define UI64_NULL ~(0ULL)
+
 static void build_dvsecs(CXLType3Dev *ct3d)
 {
     CXLComponentState *cxl_cstate = &ct3d->cxl_cstate;
@@ -149,7 +155,12 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
     pci_config_set_class(pci_conf, PCI_CLASS_MEMORY_CXL);
 
     pcie_endpoint_cap_init(pci_dev, 0x80);
-    cxl_cstate->dvsec_offset = 0x100;
+    if (ct3d->sn != UI64_NULL) {
+        pcie_dev_ser_num_init(pci_dev, 0x100, ct3d->sn);
+        cxl_cstate->dvsec_offset = 0x100 + 0x0c;
+    } else {
+        cxl_cstate->dvsec_offset = 0x100;
+    }
 
     ct3d->cxl_cstate.pdev = pci_dev;
     build_dvsecs(ct3d);
@@ -275,6 +286,7 @@ static Property ct3_props[] = {
                      HostMemoryBackend *),
     DEFINE_PROP_LINK("lsa", CXLType3Dev, lsa, TYPE_MEMORY_BACKEND,
                      HostMemoryBackend *),
+    DEFINE_PROP_UINT64("sn", CXLType3Dev, sn, UI64_NULL),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 1e141b6621..e4d221cdb3 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -237,6 +237,7 @@ struct CXLType3Dev {
     /* Properties */
     HostMemoryBackend *hostmem;
     HostMemoryBackend *lsa;
+    uint64_t sn;
 
     /* State */
     AddressSpace hostmem_as;
-- 
2.32.0

