Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33904C64ED8
	for <linux-cxl@archiver.kernel.org>; Mon, 27 Feb 2023 16:32:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbjB0Qch (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 27 Feb 2023 11:32:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjB0Qcf (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 27 Feb 2023 11:32:35 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B09C49009
        for <linux-cxl@vger.kernel.org>; Mon, 27 Feb 2023 08:32:29 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PQQvk2Kcvz67Zn3;
        Tue, 28 Feb 2023 00:30:10 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 27 Feb 2023 16:32:27 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>,
        Fan Ni <fan.ni@samsung.com>
CC:     Ben Widawsky <bwidawsk@kernel.org>, <linux-cxl@vger.kernel.org>,
        <linuxarm@huawei.com>, Ira Weiny <ira.weiny@intel.com>,
        Gregory Price <gourry.memverge@gmail.com>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        Mike Maslenkin <mike.maslenkin@gmail.com>,
        Dave Jiang <dave.jiang@intel.com>
Subject: [PATCH v4 1/2] tests/qtest/cxl-test: whitespace, line ending cleanup
Date:   Mon, 27 Feb 2023 16:31:56 +0000
Message-ID: <20230227163157.6621-2-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230227163157.6621-1-Jonathan.Cameron@huawei.com>
References: <20230227163157.6621-1-Jonathan.Cameron@huawei.com>
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

From: Gregory Price <gourry.memverge@gmail.com>

Defines are starting to exceed line length limits, align them for
cleanliness before making modifications.

Signed-off-by: Gregory Price <gregory.price@memverge.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 tests/qtest/cxl-test.c | 84 +++++++++++++++++++++++-------------------
 1 file changed, 46 insertions(+), 38 deletions(-)

diff --git a/tests/qtest/cxl-test.c b/tests/qtest/cxl-test.c
index 61f25a72b6..eda2bbbbe6 100644
--- a/tests/qtest/cxl-test.c
+++ b/tests/qtest/cxl-test.c
@@ -8,50 +8,58 @@
 #include "qemu/osdep.h"
 #include "libqtest-single.h"
 
-#define QEMU_PXB_CMD "-machine q35,cxl=on " \
-                     "-device pxb-cxl,id=cxl.0,bus=pcie.0,bus_nr=52 "  \
-                     "-M cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.size=4G "
+#define QEMU_PXB_CMD \
+    "-machine q35,cxl=on " \
+    "-device pxb-cxl,id=cxl.0,bus=pcie.0,bus_nr=52 " \
+    "-M cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.size=4G "
 
-#define QEMU_2PXB_CMD "-machine q35,cxl=on "                            \
-                      "-device pxb-cxl,id=cxl.0,bus=pcie.0,bus_nr=52 "  \
-                      "-device pxb-cxl,id=cxl.1,bus=pcie.0,bus_nr=53 " \
-                      "-M cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.targets.1=cxl.1,cxl-fmw.0.size=4G "
+#define QEMU_2PXB_CMD \
+    "-machine q35,cxl=on " \
+    "-device pxb-cxl,id=cxl.0,bus=pcie.0,bus_nr=52 " \
+    "-device pxb-cxl,id=cxl.1,bus=pcie.0,bus_nr=53 " \
+    "-M cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.targets.1=cxl.1,cxl-fmw.0.size=4G "
 
-#define QEMU_RP "-device cxl-rp,id=rp0,bus=cxl.0,chassis=0,slot=0 "
+#define QEMU_RP \
+    "-device cxl-rp,id=rp0,bus=cxl.0,chassis=0,slot=0 "
 
 /* Dual ports on first pxb */
-#define QEMU_2RP "-device cxl-rp,id=rp0,bus=cxl.0,chassis=0,slot=0 " \
-                 "-device cxl-rp,id=rp1,bus=cxl.0,chassis=0,slot=1 "
+#define QEMU_2RP \
+    "-device cxl-rp,id=rp0,bus=cxl.0,chassis=0,slot=0 " \
+    "-device cxl-rp,id=rp1,bus=cxl.0,chassis=0,slot=1 "
 
 /* Dual ports on each of the pxb instances */
-#define QEMU_4RP "-device cxl-rp,id=rp0,bus=cxl.0,chassis=0,slot=0 " \
-                 "-device cxl-rp,id=rp1,bus=cxl.0,chassis=0,slot=1 " \
-                 "-device cxl-rp,id=rp2,bus=cxl.1,chassis=0,slot=2 " \
-                 "-device cxl-rp,id=rp3,bus=cxl.1,chassis=0,slot=3 "
-
-#define QEMU_T3D "-object memory-backend-file,id=cxl-mem0,mem-path=%s,size=256M " \
-                 "-object memory-backend-file,id=lsa0,mem-path=%s,size=256M "    \
-                 "-device cxl-type3,bus=rp0,memdev=cxl-mem0,lsa=lsa0,id=cxl-pmem0 "
-
-#define QEMU_2T3D "-object memory-backend-file,id=cxl-mem0,mem-path=%s,size=256M "    \
-                  "-object memory-backend-file,id=lsa0,mem-path=%s,size=256M "    \
-                  "-device cxl-type3,bus=rp0,memdev=cxl-mem0,lsa=lsa0,id=cxl-pmem0 " \
-                  "-object memory-backend-file,id=cxl-mem1,mem-path=%s,size=256M "    \
-                  "-object memory-backend-file,id=lsa1,mem-path=%s,size=256M "    \
-                  "-device cxl-type3,bus=rp1,memdev=cxl-mem1,lsa=lsa1,id=cxl-pmem1 "
-
-#define QEMU_4T3D "-object memory-backend-file,id=cxl-mem0,mem-path=%s,size=256M " \
-                  "-object memory-backend-file,id=lsa0,mem-path=%s,size=256M "    \
-                  "-device cxl-type3,bus=rp0,memdev=cxl-mem0,lsa=lsa0,id=cxl-pmem0 " \
-                  "-object memory-backend-file,id=cxl-mem1,mem-path=%s,size=256M "    \
-                  "-object memory-backend-file,id=lsa1,mem-path=%s,size=256M "    \
-                  "-device cxl-type3,bus=rp1,memdev=cxl-mem1,lsa=lsa1,id=cxl-pmem1 " \
-                  "-object memory-backend-file,id=cxl-mem2,mem-path=%s,size=256M "    \
-                  "-object memory-backend-file,id=lsa2,mem-path=%s,size=256M "    \
-                  "-device cxl-type3,bus=rp2,memdev=cxl-mem2,lsa=lsa2,id=cxl-pmem2 " \
-                  "-object memory-backend-file,id=cxl-mem3,mem-path=%s,size=256M "    \
-                  "-object memory-backend-file,id=lsa3,mem-path=%s,size=256M "    \
-                  "-device cxl-type3,bus=rp3,memdev=cxl-mem3,lsa=lsa3,id=cxl-pmem3 "
+#define QEMU_4RP \
+    "-device cxl-rp,id=rp0,bus=cxl.0,chassis=0,slot=0 " \
+    "-device cxl-rp,id=rp1,bus=cxl.0,chassis=0,slot=1 " \
+    "-device cxl-rp,id=rp2,bus=cxl.1,chassis=0,slot=2 " \
+    "-device cxl-rp,id=rp3,bus=cxl.1,chassis=0,slot=3 "
+
+#define QEMU_T3D \
+    "-object memory-backend-file,id=cxl-mem0,mem-path=%s,size=256M " \
+    "-object memory-backend-file,id=lsa0,mem-path=%s,size=256M " \
+    "-device cxl-type3,bus=rp0,memdev=cxl-mem0,lsa=lsa0,id=cxl-pmem0 "
+
+#define QEMU_2T3D \
+    "-object memory-backend-file,id=cxl-mem0,mem-path=%s,size=256M " \
+    "-object memory-backend-file,id=lsa0,mem-path=%s,size=256M " \
+    "-device cxl-type3,bus=rp0,memdev=cxl-mem0,lsa=lsa0,id=cxl-pmem0 " \
+    "-object memory-backend-file,id=cxl-mem1,mem-path=%s,size=256M " \
+    "-object memory-backend-file,id=lsa1,mem-path=%s,size=256M " \
+    "-device cxl-type3,bus=rp1,memdev=cxl-mem1,lsa=lsa1,id=cxl-pmem1 "
+
+#define QEMU_4T3D \
+    "-object memory-backend-file,id=cxl-mem0,mem-path=%s,size=256M " \
+    "-object memory-backend-file,id=lsa0,mem-path=%s,size=256M " \
+    "-device cxl-type3,bus=rp0,memdev=cxl-mem0,lsa=lsa0,id=cxl-pmem0 " \
+    "-object memory-backend-file,id=cxl-mem1,mem-path=%s,size=256M " \
+    "-object memory-backend-file,id=lsa1,mem-path=%s,size=256M " \
+    "-device cxl-type3,bus=rp1,memdev=cxl-mem1,lsa=lsa1,id=cxl-pmem1 " \
+    "-object memory-backend-file,id=cxl-mem2,mem-path=%s,size=256M " \
+    "-object memory-backend-file,id=lsa2,mem-path=%s,size=256M " \
+    "-device cxl-type3,bus=rp2,memdev=cxl-mem2,lsa=lsa2,id=cxl-pmem2 " \
+    "-object memory-backend-file,id=cxl-mem3,mem-path=%s,size=256M " \
+    "-object memory-backend-file,id=lsa3,mem-path=%s,size=256M " \
+    "-device cxl-type3,bus=rp3,memdev=cxl-mem3,lsa=lsa3,id=cxl-pmem3 "
 
 static void cxl_basic_hb(void)
 {
-- 
2.37.2

