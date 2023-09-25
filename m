Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F406CE7A9B
	for <linux-cxl@archiver.kernel.org>; Mon, 25 Sep 2023 16:13:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231689AbjIYQOE (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 25 Sep 2023 12:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjIYQOD (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 25 Sep 2023 12:14:03 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A86ADB6
        for <linux-cxl@vger.kernel.org>; Mon, 25 Sep 2023 09:13:57 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RvSYQ3tBBz6DBBV;
        Tue, 26 Sep 2023 00:11:38 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 25 Sep 2023 17:13:55 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
        Michael Tsirkin <mst@redhat.com>
CC:     <linuxarm@huawei.com>, Fan Ni <fan.ni@samsung.com>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Gregory Price <gregory.price@memverge.com>,
        Klaus Jensen <its@irrelevant.dk>,
        Corey Minyard <cminyard@mvista.com>,
        Klaus Jensen <k.jensen@samsung.com>
Subject: [PATCH 05/19] hw/pci-bridge/cxl_upstream: Move defintion of device to header.
Date:   Mon, 25 Sep 2023 17:11:10 +0100
Message-ID: <20230925161124.18940-6-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230925161124.18940-1-Jonathan.Cameron@huawei.com>
References: <20230925161124.18940-1-Jonathan.Cameron@huawei.com>
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

To avoid repetition of switch upstream port specific data in the
CXLDeviceState structure it will be necessary to access the switch USP
specific data from mailbox callbacks. Hence move it to cxl_device.h so it
is no longer an opaque structure.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 include/hw/pci-bridge/cxl_upstream_port.h | 18 ++++++++++++++++++
 hw/pci-bridge/cxl_upstream.c              | 11 +----------
 2 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/include/hw/pci-bridge/cxl_upstream_port.h b/include/hw/pci-bridge/cxl_upstream_port.h
new file mode 100644
index 0000000000..b02aa8f659
--- /dev/null
+++ b/include/hw/pci-bridge/cxl_upstream_port.h
@@ -0,0 +1,18 @@
+
+#ifndef CXL_USP_H
+#define CXL_USP_H
+#include "hw/pci/pcie.h"
+#include "hw/pci/pcie_port.h"
+#include "hw/cxl/cxl.h"
+
+typedef struct CXLUpstreamPort {
+    /*< private >*/
+    PCIEPort parent_obj;
+
+    /*< public >*/
+    CXLComponentState cxl_cstate;
+    DOECap doe_cdat;
+    uint64_t sn;
+} CXLUpstreamPort;
+
+#endif /* CXL_SUP_H */
diff --git a/hw/pci-bridge/cxl_upstream.c b/hw/pci-bridge/cxl_upstream.c
index b81bb5fec9..36737189c6 100644
--- a/hw/pci-bridge/cxl_upstream.c
+++ b/hw/pci-bridge/cxl_upstream.c
@@ -14,6 +14,7 @@
 #include "hw/pci/msi.h"
 #include "hw/pci/pcie.h"
 #include "hw/pci/pcie_port.h"
+#include "hw/pci-bridge/cxl_upstream_port.h"
 /*
  * Null value of all Fs suggested by IEEE RA guidelines for use of
  * EU, OUI and CID
@@ -30,16 +31,6 @@
 #define CXL_UPSTREAM_PORT_DVSEC_OFFSET \
     (CXL_UPSTREAM_PORT_SN_OFFSET + PCI_EXT_CAP_DSN_SIZEOF)
 
-typedef struct CXLUpstreamPort {
-    /*< private >*/
-    PCIEPort parent_obj;
-
-    /*< public >*/
-    CXLComponentState cxl_cstate;
-    DOECap doe_cdat;
-    uint64_t sn;
-} CXLUpstreamPort;
-
 CXLComponentState *cxl_usp_to_cstate(CXLUpstreamPort *usp)
 {
     return &usp->cxl_cstate;
-- 
2.39.2

