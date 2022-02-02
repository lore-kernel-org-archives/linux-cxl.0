Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55E68C433EF
	for <linux-cxl@archiver.kernel.org>; Wed,  2 Feb 2022 14:32:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344994AbiBBOcI (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 2 Feb 2022 09:32:08 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4659 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbiBBOcI (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 2 Feb 2022 09:32:08 -0500
Received: from fraeml705-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Jpkkr6fdqz67P1q;
        Wed,  2 Feb 2022 22:31:32 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml705-chm.china.huawei.com (10.206.15.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.21; Wed, 2 Feb 2022 15:32:06 +0100
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 2 Feb 2022 14:32:05 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <qemu-devel@nongnu.org>,
        =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
        Marcel Apfelbaum <marcel@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>
CC:     <linux-cxl@vger.kernel.org>, Ben Widawsky <ben.widawsky@intel.com>,
        "Peter Maydell" <peter.maydell@linaro.org>, <linuxarm@huawei.com>,
        "Shameerali Kolothum Thodi" <shameerali.kolothum.thodi@huawei.com>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
        Saransh Gupta1 <saransh@ibm.com>,
        Shreyas Shah <shreyas.shah@elastics.cloud>,
        Chris Browy <cbrowy@avery-design.com>,
        Samarth Saxena <samarths@cadence.com>,
        "Dan Williams" <dan.j.williams@intel.com>
Subject: [PATCH v5 42/43] qtest/cxl: Add very basic sanity tests
Date:   Wed, 2 Feb 2022 14:10:36 +0000
Message-ID: <20220202141037.17352-43-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220202141037.17352-1-Jonathan.Cameron@huawei.com>
References: <20220202141037.17352-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhreml743-chm.china.huawei.com (10.201.108.193) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Ben Widawsky <ben.widawsky@intel.com>

Simple 'does it boot tests' with up to
2x PXB host bridge, each with 2x CXL RP and each of those with
a Type 3 memory device.  Single CFMWS to interleave across the
two HBs and ultimate the 4 devices.

More complete tests may be possible but CXL interleave setup
is complex so a lot of steps will be needed.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
Co-developed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 tests/qtest/cxl-test.c  | 151 ++++++++++++++++++++++++++++++++++++++++
 tests/qtest/meson.build |   4 ++
 2 files changed, 155 insertions(+)
 create mode 100644 tests/qtest/cxl-test.c

diff --git a/tests/qtest/cxl-test.c b/tests/qtest/cxl-test.c
new file mode 100644
index 0000000000..a50c0c6de4
--- /dev/null
+++ b/tests/qtest/cxl-test.c
@@ -0,0 +1,151 @@
+/*
+ * QTest testcase for CXL
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "libqtest-single.h"
+
+#define QEMU_PXB_CMD "-machine q35,cxl=on " \
+                     "-device pxb-cxl,id=cxl.0,bus=pcie.0,bus_nr=52 "  \
+                     "-cxl-fixed-memory-window targets=cxl.0,size=4G "
+
+#define QEMU_2PXB_CMD "-machine q35,cxl=on " \
+                      "-device pxb-cxl,id=cxl.0,bus=pcie.0,bus_nr=52 "  \
+                      "-device pxb-cxl,id=cxl.1,bus=pcie.0,bus_nr=53 " \
+                      "-cxl-fixed-memory-window targets=cxl.0,targets=cxl.1,size=4G "
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
+                 "-device cxl-type3,bus=rp0,memdev=cxl-mem0,id=cxl-pmem0,size=256M "
+
+#define QEMU_2T3D "-object memory-backend-file,id=cxl-mem0,mem-path=%s,size=256M "    \
+                  "-device cxl-type3,bus=rp0,memdev=cxl-mem0,id=cxl-pmem0,size=256M " \
+                  "-object memory-backend-file,id=cxl-mem1,mem-path=%s,size=256M "    \
+                  "-device cxl-type3,bus=rp1,memdev=cxl-mem1,id=cxl-pmem1,size=256M "
+
+#define QEMU_4T3D "-object memory-backend-file,id=cxl-mem0,mem-path=%s,size=256M "    \
+                  "-device cxl-type3,bus=rp0,memdev=cxl-mem0,id=cxl-pmem0,size=256M " \
+                  "-object memory-backend-file,id=cxl-mem1,mem-path=%s,size=256M "    \
+                  "-device cxl-type3,bus=rp1,memdev=cxl-mem1,id=cxl-pmem1,size=256M " \
+                  "-object memory-backend-file,id=cxl-mem2,mem-path=%s,size=256M "    \
+                  "-device cxl-type3,bus=rp2,memdev=cxl-mem2,id=cxl-pmem2,size=256M " \
+                  "-object memory-backend-file,id=cxl-mem3,mem-path=%s,size=256M "    \
+                  "-device cxl-type3,bus=rp3,memdev=cxl-mem3,id=cxl-pmem3,size=256M "
+
+static void cxl_basic_hb(void)
+{
+    qtest_start("-machine q35,cxl=on");
+    qtest_end();
+}
+
+static void cxl_basic_pxb(void)
+{
+    qtest_start("-machine q35,cxl=on -device pxb-cxl,bus=pcie.0");
+    qtest_end();
+}
+
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
+    GString *cmdline;
+    char template[] = "/tmp/cxl-test-XXXXXX";
+    const char *tmpfs;
+
+    tmpfs = mkdtemp(template);
+
+    cmdline = g_string_new(NULL);
+    g_string_printf(cmdline, QEMU_PXB_CMD QEMU_RP QEMU_T3D, tmpfs);
+
+    qtest_start(cmdline->str);
+    qtest_end();
+
+    g_string_free(cmdline, TRUE);
+}
+
+static void cxl_1pxb_2rp_2t3d(void)
+{
+    GString *cmdline;
+    char template[] = "/tmp/cxl-test-XXXXXX";
+    const char *tmpfs;
+
+    tmpfs = mkdtemp(template);
+
+    cmdline = g_string_new(NULL);
+    g_string_printf(cmdline, QEMU_PXB_CMD QEMU_2RP QEMU_2T3D, tmpfs, tmpfs);
+
+    qtest_start(cmdline->str);
+    qtest_end();
+
+    g_string_free(cmdline, TRUE);
+}
+
+static void cxl_2pxb_4rp_4t3d(void)
+{
+    GString *cmdline;
+    char template[] = "/tmp/cxl-test-XXXXXX";
+    const char *tmpfs;
+
+    tmpfs = mkdtemp(template);
+
+    cmdline = g_string_new(NULL);
+    g_string_printf(cmdline, QEMU_2PXB_CMD QEMU_4RP QEMU_4T3D,
+                    tmpfs, tmpfs, tmpfs, tmpfs);
+
+    qtest_start(cmdline->str);
+    qtest_end();
+
+    g_string_free(cmdline, TRUE);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+
+    qtest_add_func("/pci/cxl/basic_hostbridge", cxl_basic_hb);
+    qtest_add_func("/pci/cxl/basic_pxb", cxl_basic_pxb);
+    qtest_add_func("/pci/cxl/pxb_with_window", cxl_pxb_with_window);
+    qtest_add_func("/pci/cxl/pxb_x2_with_window", cxl_2pxb_with_window);
+    qtest_add_func("/pci/cxl/rp", cxl_root_port);
+    qtest_add_func("/pci/cxl/rp_x2", cxl_2root_port);
+    qtest_add_func("/pci/cxl/type3_device", cxl_t3d);
+    qtest_add_func("/pci/cxl/rp_x2_type3_x2", cxl_1pxb_2rp_2t3d);
+    qtest_add_func("/pci/cxl/pxb_x2_root_port_x4_type3_x4", cxl_2pxb_4rp_4t3d);
+    return g_test_run();
+}
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 842b1df420..52a7bbe177 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -41,6 +41,9 @@ qtests_pci = \
   (config_all_devices.has_key('CONFIG_VGA') ? ['display-vga-test'] : []) +                  \
   (config_all_devices.has_key('CONFIG_IVSHMEM_DEVICE') ? ['ivshmem-test'] : [])
 
+qtests_cxl = \
+  (config_all_devices.has_key('CONFIG_CXL') ? ['cxl-test'] : [])
+
 qtests_i386 = \
   (slirp.found() ? ['pxe-test', 'test-netfilter'] : []) +             \
   (config_host.has_key('CONFIG_POSIX') ? ['test-filter-mirror'] : []) +                     \
@@ -74,6 +77,7 @@ qtests_i386 = \
    slirp.found() ? ['virtio-net-failover'] : []) +                                          \
   (unpack_edk2_blobs ? ['bios-tables-test'] : []) +                                         \
   qtests_pci +                                                                              \
+  qtests_cxl +                                                                              \
   ['fdc-test',
    'ide-test',
    'hd-geo-test',
-- 
2.32.0

