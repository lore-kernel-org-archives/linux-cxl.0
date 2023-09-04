Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65228C83F3F
	for <linux-cxl@archiver.kernel.org>; Mon,  4 Sep 2023 17:57:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjIDR6B (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 4 Sep 2023 13:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236953AbjIDR6B (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 4 Sep 2023 13:58:01 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38FE910DE
        for <linux-cxl@vger.kernel.org>; Mon,  4 Sep 2023 10:57:55 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RfbtC0mNsz67hmj;
        Tue,  5 Sep 2023 01:56:35 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 4 Sep 2023 18:57:52 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>,
        Fan Ni <fan.ni@samsung.com>, <linux-cxl@vger.kernel.org>
CC:     =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        <linuxarm@huawei.com>
Subject: [PATCH] hw/pci-bridge/cxl-upstream: Add serial number extended capability support
Date:   Mon, 4 Sep 2023 18:57:52 +0100
Message-ID: <20230904175752.17927-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
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

Will be needed so there is a defined serial number for
information queries via the Switch CCI.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
No ordering dependencies wrt to other CXL patch sets.

Whilst we 'need' it for the Switch CCI set it is valid without
it and aligns with existing EP serial number support. Seems sensible
to upstream this first and reduce my out of tree backlog a little!

 hw/pci-bridge/cxl_upstream.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/hw/pci-bridge/cxl_upstream.c b/hw/pci-bridge/cxl_upstream.c
index 2b9cf0cc97..15c4d84a56 100644
--- a/hw/pci-bridge/cxl_upstream.c
+++ b/hw/pci-bridge/cxl_upstream.c
@@ -14,6 +14,11 @@
 #include "hw/pci/msi.h"
 #include "hw/pci/pcie.h"
 #include "hw/pci/pcie_port.h"
+/*
+ * Null value of all Fs suggested by IEEE RA guidelines for use of
+ * EU, OUI and CID
+ */
+#define UI64_NULL (~0ULL)
 
 #define CXL_UPSTREAM_PORT_MSI_NR_VECTOR 2
 
@@ -30,6 +35,7 @@ typedef struct CXLUpstreamPort {
     /*< public >*/
     CXLComponentState cxl_cstate;
     DOECap doe_cdat;
+    uint64_t sn;
 } CXLUpstreamPort;
 
 CXLComponentState *cxl_usp_to_cstate(CXLUpstreamPort *usp)
@@ -326,8 +332,12 @@ static void cxl_usp_realize(PCIDevice *d, Error **errp)
     if (rc) {
         goto err_cap;
     }
-
-    cxl_cstate->dvsec_offset = CXL_UPSTREAM_PORT_DVSEC_OFFSET;
+    if (usp->sn != UI64_NULL) {
+        pcie_dev_ser_num_init(d, CXL_UPSTREAM_PORT_DVSEC_OFFSET, usp->sn);
+        cxl_cstate->dvsec_offset = CXL_UPSTREAM_PORT_DVSEC_OFFSET + 0x0c;
+    } else {
+        cxl_cstate->dvsec_offset = CXL_UPSTREAM_PORT_DVSEC_OFFSET;
+    }
     cxl_cstate->pdev = d;
     build_dvsecs(cxl_cstate);
     cxl_component_register_block_init(OBJECT(d), cxl_cstate, TYPE_CXL_USP);
@@ -366,6 +376,7 @@ static void cxl_usp_exitfn(PCIDevice *d)
 }
 
 static Property cxl_upstream_props[] = {
+    DEFINE_PROP_UINT64("sn", CXLUpstreamPort, sn, UI64_NULL),
     DEFINE_PROP_STRING("cdat", CXLUpstreamPort, cxl_cstate.cdat.filename),
     DEFINE_PROP_END_OF_LIST()
 };
-- 
2.39.2

