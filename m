Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE069C433F5
	for <linux-cxl@archiver.kernel.org>; Fri, 18 Mar 2022 15:17:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236581AbiCRPTF (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 18 Mar 2022 11:19:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237893AbiCRPTE (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 18 Mar 2022 11:19:04 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D2771A9CB3
        for <linux-cxl@vger.kernel.org>; Fri, 18 Mar 2022 08:17:45 -0700 (PDT)
Received: from fraeml740-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KKndz2HVKz67dqp;
        Fri, 18 Mar 2022 23:16:07 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml740-chm.china.huawei.com (10.206.15.221) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 18 Mar 2022 16:17:43 +0100
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 18 Mar 2022 15:17:41 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <linuxarm@huawei.com>, <qemu-devel@nongnu.org>,
        =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
        Marcel Apfelbaum <marcel@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>,
        Markus Armbruster <armbru@redhat.com>
CC:     <linux-cxl@vger.kernel.org>, Ben Widawsky <ben.widawsky@intel.com>,
        "Peter Maydell" <peter.maydell@linaro.org>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Saransh Gupta1 <saransh@ibm.com>,
        Shreyas Shah <shreyas.shah@elastics.cloud>,
        Chris Browy <cbrowy@avery-design.com>,
        "Samarth Saxena" <samarths@cadence.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Mark Cave-Ayland" <mark.cave-ayland@ilande.co.uk>
Subject: [PATCH v8 22/46] qtests/cxl: Add initial root port and CXL type3 tests
Date:   Fri, 18 Mar 2022 15:06:11 +0000
Message-ID: <20220318150635.24600-23-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220318150635.24600-1-Jonathan.Cameron@huawei.com>
References: <20220318150635.24600-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhreml732-chm.china.huawei.com (10.201.108.83) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

At this stage we can boot configurations with host bridges,
root ports and type 3 memory devices, so add appropriate
tests.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/qtest/cxl-test.c | 126 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 126 insertions(+)

diff --git a/tests/qtest/cxl-test.c b/tests/qtest/cxl-test.c
index 1006c8ae4e..148bc94340 100644
--- a/tests/qtest/cxl-test.c
+++ b/tests/qtest/cxl-test.c
@@ -8,6 +8,54 @@
 #include "qemu/osdep.h"
 #include "libqtest-single.h"
 
+#define QEMU_PXB_CMD "-machine q35,cxl=on " \
+                     "-device pxb-cxl,id=cxl.0,bus=pcie.0,bus_nr=52 "
+
+#define QEMU_2PXB_CMD "-machine q35,cxl=on " \
+                      "-device pxb-cxl,id=cxl.0,bus=pcie.0,bus_nr=52 "  \
+                      "-device pxb-cxl,id=cxl.1,bus=pcie.0,bus_nr=53 "
+
+#define QEMU_RP "-device cxl-rp,id=rp0,bus=cxl.0,chassis=0,slot=0 "
+
+/* Dual ports on first pxb */
+#define QEMU_2RP "-device cxl-rp,id=rp0,bus=cxl.0,chassis=0,slot=0 " \
+                 "-device cxl-rp,id=rp1,bus=cxl.0,chassis=0,slot=1 "
+
+/* Dual ports on each of the pxb instances */
+#define QEMU_4RP "-device cxl-rp,id=rp0,bus=cxl.0,chassis=0,slot=0 " \
+                 "-device cxl-rp,id=rp1,bus=cxl.0,chassis=0,slot=1 " \
+                 "-device cxl-rp,id=rp2,bus=cxl.1,chassis=0,slot=2 " \
+                 "-device cxl-rp,id=rp3,bus=cxl.1,chassis=0,slot=3 "
+
+#define QEMU_T3D "-object memory-backend-file,id=cxl-mem0,mem-path=%s,size=256M " \
+                 "-object memory-backend-file,id=lsa0,mem-path=%s,size=256M "    \
+                 "-device cxl-type3,bus=rp0,memdev=cxl-mem0,lsa=lsa0,id=cxl-pmem0,size=256M "
+
+#define QEMU_2T3D "-object memory-backend-file,id=cxl-mem0,mem-path=%s,size=256M "    \
+                  "-object memory-backend-file,id=lsa0,mem-path=%s,size=256M "    \
+                  "-device cxl-type3,bus=rp0,memdev=cxl-mem0,lsa=lsa0,id=cxl-pmem0,size=256M " \
+                  "-object memory-backend-file,id=cxl-mem1,mem-path=%s,size=256M "    \
+                  "-object memory-backend-file,id=lsa1,mem-path=%s,size=256M "    \
+                  "-device cxl-type3,bus=rp1,memdev=cxl-mem1,lsa=lsa1,id=cxl-pmem1,size=256M "
+
+#define QEMU_4T3D "-object memory-backend-file,id=cxl-mem0,mem-path=%s,size=256M " \
+                  "-object memory-backend-file,id=lsa0,mem-path=%s,size=256M "    \
+                  "-device cxl-type3,bus=rp0,memdev=cxl-mem0,lsa=lsa0,id=cxl-pmem0,size=256M " \
+                  "-object memory-backend-file,id=cxl-mem1,mem-path=%s,size=256M "    \
+                  "-object memory-backend-file,id=lsa1,mem-path=%s,size=256M "    \
+                  "-device cxl-type3,bus=rp1,memdev=cxl-mem1,lsa=lsa1,id=cxl-pmem1,size=256M " \
+                  "-object memory-backend-file,id=cxl-mem2,mem-path=%s,size=256M "    \
+                  "-object memory-backend-file,id=lsa2,mem-path=%s,size=256M "    \
+                  "-device cxl-type3,bus=rp2,memdev=cxl-mem2,lsa=lsa2,id=cxl-pmem2,size=256M " \
+                  "-object memory-backend-file,id=cxl-mem3,mem-path=%s,size=256M "    \
+                  "-object memory-backend-file,id=lsa3,mem-path=%s,size=256M "    \
+                  "-device cxl-type3,bus=rp3,memdev=cxl-mem3,lsa=lsa3,id=cxl-pmem3,size=256M "
+
+static void cxl_basic_hb(void)
+{
+    qtest_start("-machine q35,cxl=on");
+    qtest_end();
+}
 
 static void cxl_basic_pxb(void)
 {
@@ -15,9 +63,87 @@ static void cxl_basic_pxb(void)
     qtest_end();
 }
 
+static void cxl_pxb_with_window(void)
+{
+    qtest_start(QEMU_PXB_CMD);
+    qtest_end();
+}
+
+static void cxl_2pxb_with_window(void)
+{
+    qtest_start(QEMU_2PXB_CMD);
+    qtest_end();
+}
+
+static void cxl_root_port(void)
+{
+    qtest_start(QEMU_PXB_CMD QEMU_RP);
+    qtest_end();
+}
+
+static void cxl_2root_port(void)
+{
+    qtest_start(QEMU_PXB_CMD QEMU_2RP);
+    qtest_end();
+}
+
+static void cxl_t3d(void)
+{
+    g_autoptr(GString) cmdline = g_string_new(NULL);
+    char template[] = "/tmp/cxl-test-XXXXXX";
+    const char *tmpfs;
+
+    tmpfs = mkdtemp(template);
+
+    g_string_printf(cmdline, QEMU_PXB_CMD QEMU_RP QEMU_T3D, tmpfs, tmpfs);
+
+    qtest_start(cmdline->str);
+    qtest_end();
+}
+
+static void cxl_1pxb_2rp_2t3d(void)
+{
+    g_autoptr(GString) cmdline = g_string_new(NULL);
+    char template[] = "/tmp/cxl-test-XXXXXX";
+    const char *tmpfs;
+
+    tmpfs = mkdtemp(template);
+
+    g_string_printf(cmdline, QEMU_PXB_CMD QEMU_2RP QEMU_2T3D,
+                    tmpfs, tmpfs, tmpfs, tmpfs);
+
+    qtest_start(cmdline->str);
+    qtest_end();
+}
+
+static void cxl_2pxb_4rp_4t3d(void)
+{
+    g_autoptr(GString) cmdline = g_string_new(NULL);
+    char template[] = "/tmp/cxl-test-XXXXXX";
+    const char *tmpfs;
+
+    tmpfs = mkdtemp(template);
+
+    g_string_printf(cmdline, QEMU_2PXB_CMD QEMU_4RP QEMU_4T3D,
+                    tmpfs, tmpfs, tmpfs, tmpfs, tmpfs, tmpfs,
+                    tmpfs, tmpfs);
+
+    qtest_start(cmdline->str);
+    qtest_end();
+}
+
 int main(int argc, char **argv)
 {
     g_test_init(&argc, &argv, NULL);
+
+    qtest_add_func("/pci/cxl/basic_hostbridge", cxl_basic_hb);
     qtest_add_func("/pci/cxl/basic_pxb", cxl_basic_pxb);
+    qtest_add_func("/pci/cxl/pxb_with_window", cxl_pxb_with_window);
+    qtest_add_func("/pci/cxl/pxb_x2_with_window", cxl_2pxb_with_window);
+    qtest_add_func("/pci/cxl/rp", cxl_root_port);
+    qtest_add_func("/pci/cxl/rp_x2", cxl_2root_port);
+    qtest_add_func("/pci/cxl/type3_device", cxl_t3d);
+    qtest_add_func("/pci/cxl/rp_x2_type3_x2", cxl_1pxb_2rp_2t3d);
+    qtest_add_func("/pci/cxl/pxb_x2_root_port_x4_type3_x4", cxl_2pxb_4rp_4t3d);
     return g_test_run();
 }
-- 
2.32.0

