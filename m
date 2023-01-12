Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56095C54EBD
	for <linux-cxl@archiver.kernel.org>; Thu, 12 Jan 2023 10:34:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbjALKeS (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 12 Jan 2023 05:34:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234857AbjALKdJ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 12 Jan 2023 05:33:09 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCD4957912
        for <linux-cxl@vger.kernel.org>; Thu, 12 Jan 2023 02:28:17 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Nt13F40N7z6880d;
        Thu, 12 Jan 2023 18:28:09 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 12 Jan 2023 10:28:15 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>
CC:     Ben Widawsky <bwidawsk@kernel.org>, <linux-cxl@vger.kernel.org>,
        <linuxarm@huawei.com>, Ira Weiny <ira.weiny@intel.com>,
        Gregory Price <gourry.memverge@gmail.com>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 3/8] hw/cxl: set cxl-type3 device type to PCI_CLASS_MEMORY_CXL
Date:   Thu, 12 Jan 2023 10:26:39 +0000
Message-ID: <20230112102644.27830-4-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230112102644.27830-1-Jonathan.Cameron@huawei.com>
References: <20230112102644.27830-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Gregory Price <gourry.memverge@gmail.com>

Current code sets to STORAGE_EXPRESS and then overrides it.

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Gregory Price <gregory.price@memverge.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 hw/mem/cxl_type3.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 252822bd82..217a5e639b 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -408,7 +408,6 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
     }
 
     pci_config_set_prog_interface(pci_conf, 0x10);
-    pci_config_set_class(pci_conf, PCI_CLASS_MEMORY_CXL);
 
     pcie_endpoint_cap_init(pci_dev, 0x80);
     if (ct3d->sn != UI64_NULL) {
@@ -627,7 +626,7 @@ static void ct3_class_init(ObjectClass *oc, void *data)
 
     pc->realize = ct3_realize;
     pc->exit = ct3_exit;
-    pc->class_id = PCI_CLASS_STORAGE_EXPRESS;
+    pc->class_id = PCI_CLASS_MEMORY_CXL;
     pc->vendor_id = PCI_VENDOR_ID_INTEL;
     pc->device_id = 0xd93; /* LVF for now */
     pc->revision = 1;
-- 
2.37.2

