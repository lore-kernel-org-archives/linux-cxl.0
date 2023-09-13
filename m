Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04C04EDEC4D
	for <linux-cxl@archiver.kernel.org>; Wed, 13 Sep 2023 13:36:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240991AbjIMNgY (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 13 Sep 2023 09:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240962AbjIMNgW (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 13 Sep 2023 09:36:22 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1842019B9
        for <linux-cxl@vger.kernel.org>; Wed, 13 Sep 2023 06:36:18 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Rm1g30SL8z6K6CF;
        Wed, 13 Sep 2023 21:35:43 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Wed, 13 Sep 2023 14:36:16 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>,
        Fan Ni <fan.ni@samsung.com>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        <linux-cxl@vger.kernel.org>
CC:     <linuxarm@huawei.com>
Subject: [PATCH V2] hw/pci-bridge/cxl-upstream: Add serial number extended capability support
Date:   Wed, 13 Sep 2023 14:36:15 +0100
Message-ID: <20230913133615.29876-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Will be needed so there is a defined serial number for
information queries via the Switch CCI.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
v2:  Thanks to Philippe for review.
 - Keep to a fixed offset for the serial number capability.
   If it's not present then there will be a hole which is fine
   under the PCIE specification.
 - As per reply to review of v1, I've not moved the Null definition
   to a header and have kept it is a valid 'default'.

hw/pci-bridge/cxl_upstream.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/hw/pci-bridge/cxl_upstream.c b/hw/pci-bridge/cxl_upstream.c
index 2b9cf0cc97..a57806fb31 100644
--- a/hw/pci-bridge/cxl_upstream.c
+++ b/hw/pci-bridge/cxl_upstream.c
@@ -14,14 +14,21 @@
 #include "hw/pci/msi.h"
 #include "hw/pci/pcie.h"
 #include "hw/pci/pcie_port.h"
+/*
+ * Null value of all Fs suggested by IEEE RA guidelines for use of
+ * EU, OUI and CID
+ */
+#define UI64_NULL (~0ULL)
 
 #define CXL_UPSTREAM_PORT_MSI_NR_VECTOR 2
 
 #define CXL_UPSTREAM_PORT_MSI_OFFSET 0x70
 #define CXL_UPSTREAM_PORT_PCIE_CAP_OFFSET 0x90
 #define CXL_UPSTREAM_PORT_AER_OFFSET 0x100
-#define CXL_UPSTREAM_PORT_DVSEC_OFFSET \
+#define CXL_UPSTREAM_PORT_SN_OFFSET \
     (CXL_UPSTREAM_PORT_AER_OFFSET + PCI_ERR_SIZEOF)
+#define CXL_UPSTREAM_PORT_DVSEC_OFFSET \
+    (CXL_UPSTREAM_PORT_SN_OFFSET + PCI_EXT_CAP_DSN_SIZEOF)
 
 typedef struct CXLUpstreamPort {
     /*< private >*/
@@ -30,6 +37,7 @@ typedef struct CXLUpstreamPort {
     /*< public >*/
     CXLComponentState cxl_cstate;
     DOECap doe_cdat;
+    uint64_t sn;
 } CXLUpstreamPort;
 
 CXLComponentState *cxl_usp_to_cstate(CXLUpstreamPort *usp)
@@ -326,7 +334,9 @@ static void cxl_usp_realize(PCIDevice *d, Error **errp)
     if (rc) {
         goto err_cap;
     }
-
+    if (usp->sn != UI64_NULL) {
+        pcie_dev_ser_num_init(d, CXL_UPSTREAM_PORT_SN_OFFSET, usp->sn);
+    }
     cxl_cstate->dvsec_offset = CXL_UPSTREAM_PORT_DVSEC_OFFSET;
     cxl_cstate->pdev = d;
     build_dvsecs(cxl_cstate);
@@ -366,6 +376,7 @@ static void cxl_usp_exitfn(PCIDevice *d)
 }
 
 static Property cxl_upstream_props[] = {
+    DEFINE_PROP_UINT64("sn", CXLUpstreamPort, sn, UI64_NULL),
     DEFINE_PROP_STRING("cdat", CXLUpstreamPort, cxl_cstate.cdat.filename),
     DEFINE_PROP_END_OF_LIST()
 };
-- 
2.39.2

