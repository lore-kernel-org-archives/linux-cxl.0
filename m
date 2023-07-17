Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C2FAEB64DC
	for <linux-cxl@archiver.kernel.org>; Mon, 17 Jul 2023 17:17:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbjGQRRU (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 17 Jul 2023 13:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbjGQRRR (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 17 Jul 2023 13:17:17 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98C7919F
        for <linux-cxl@vger.kernel.org>; Mon, 17 Jul 2023 10:17:16 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4R4TFg1ng8z6J7mn;
        Tue, 18 Jul 2023 01:13:59 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 17 Jul 2023 18:17:14 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <linux-cxl@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        <qemu-devel@nongnu.org>
CC:     <linuxarm@huawei.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Viacheslav Dubeyko <slava@dubeyko.com>,
        Shesha Bhushan Sreenivasamurthy <sheshas@marvell.com>,
        Fan Ni <fan.ni@samsung.com>, Michael Tsirkin <mst@redhat.com>,
        Jonathan Zhang <jonzhang@meta.com>,
        Klaus Jensen <k.jensen@samsung.com>
Subject: [RFC PATCH 01/17] hw/pci-bridge/cxl_upstream: Move defintion of device to header.
Date:   Mon, 17 Jul 2023 18:16:30 +0100
Message-ID: <20230717171646.8972-2-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230717171646.8972-1-Jonathan.Cameron@huawei.com>
References: <20230717171646.8972-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

To avoid repitition of switch upstream port specific data in
the CXLDeviceState structure it will be necessary to call
access the switch USP specific from mailbox callbacks.
Hence move it to a header so it is no longer an opaque
structure.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 include/hw/pci-bridge/cxl_upstream_port.h | 18 ++++++++++++++++++
 hw/cxl/cxl-mailbox-utils.c                |  1 +
 hw/pci-bridge/cxl_upstream.c              | 11 +----------
 3 files changed, 20 insertions(+), 10 deletions(-)

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
diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 02f9b5a870..1e0d96f64f 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -11,6 +11,7 @@
 #include "hw/cxl/cxl.h"
 #include "hw/cxl/cxl_events.h"
 #include "hw/pci/pci.h"
+#include "hw/pci-bridge/cxl_upstream_port.h"
 #include "qemu/cutils.h"
 #include "qemu/log.h"
 #include "qemu/units.h"
diff --git a/hw/pci-bridge/cxl_upstream.c b/hw/pci-bridge/cxl_upstream.c
index 96d093add1..f9627f820e 100644
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
@@ -28,16 +29,6 @@
 #define CXL_UPSTREAM_PORT_DVSEC_OFFSET \
     (CXL_UPSTREAM_PORT_AER_OFFSET + PCI_ERR_SIZEOF)
 
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

