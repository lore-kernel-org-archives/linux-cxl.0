Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4F2DC433EF
	for <linux-cxl@archiver.kernel.org>; Sun,  6 Mar 2022 18:03:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbiCFSDw (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sun, 6 Mar 2022 13:03:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbiCFSDv (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sun, 6 Mar 2022 13:03:51 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E9253207F
        for <linux-cxl@vger.kernel.org>; Sun,  6 Mar 2022 10:02:59 -0800 (PST)
Received: from fraeml737-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KBTvd2Kkkz67Gvv;
        Mon,  7 Mar 2022 02:02:37 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml737-chm.china.huawei.com (10.206.15.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Sun, 6 Mar 2022 19:02:57 +0100
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.21; Sun, 6 Mar 2022 18:02:56 +0000
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
        Saransh Gupta1 <saransh@ibm.com>,
        Shreyas Shah <shreyas.shah@elastics.cloud>,
        Chris Browy <cbrowy@avery-design.com>,
        Samarth Saxena <samarths@cadence.com>,
        "Dan Williams" <dan.j.williams@intel.com>
Subject: [PATCH v7 42/46] qtest/cxl: Add aarch64 virt test for CXL
Date:   Sun, 6 Mar 2022 17:41:33 +0000
Message-ID: <20220306174137.5707-43-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220306174137.5707-1-Jonathan.Cameron@huawei.com>
References: <20220306174137.5707-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhreml706-chm.china.huawei.com (10.201.108.55) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Add a single complex case for aarch64 virt machine.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 tests/qtest/cxl-test.c  | 48 +++++++++++++++++++++++++++++++++--------
 tests/qtest/meson.build |  1 +
 2 files changed, 40 insertions(+), 9 deletions(-)

diff --git a/tests/qtest/cxl-test.c b/tests/qtest/cxl-test.c
index 0bb93b0191..c96469a435 100644
--- a/tests/qtest/cxl-test.c
+++ b/tests/qtest/cxl-test.c
@@ -17,6 +17,11 @@
                       "-device pxb-cxl,id=cxl.1,bus=pcie.0,bus_nr=53 " \
                       "-cxl-fixed-memory-window targets.0=cxl.0,targets.1=cxl.1,size=4G "
 
+#define QEMU_VIRT_2PXB_CMD "-machine virt,cxl=on "                      \
+                      "-device pxb-cxl,id=cxl.0,bus=pcie.0,bus_nr=52 "  \
+                      "-device pxb-cxl,id=cxl.1,bus=pcie.0,bus_nr=53 "  \
+                      "-cxl-fixed-memory-window targets.0=cxl.0,targets.1=cxl.1,size=4G "
+
 #define QEMU_RP "-device cxl-rp,id=rp0,bus=cxl.0,chassis=0,slot=0 "
 
 /* Dual ports on first pxb */
@@ -134,18 +139,43 @@ static void cxl_2pxb_4rp_4t3d(void)
     qtest_end();
 }
 
+static void cxl_virt_2pxb_4rp_4t3d(void)
+{
+    g_autoptr(GString) cmdline = g_string_new(NULL);
+    char template[] = "/tmp/cxl-test-XXXXXX";
+    const char *tmpfs;
+
+    tmpfs = mkdtemp(template);
+
+    g_string_printf(cmdline, QEMU_VIRT_2PXB_CMD QEMU_4RP QEMU_4T3D,
+                    tmpfs, tmpfs, tmpfs, tmpfs, tmpfs, tmpfs,
+                    tmpfs, tmpfs);
+
+    qtest_start(cmdline->str);
+    qtest_end();
+}
+
 int main(int argc, char **argv)
 {
+    const char *arch = qtest_get_arch();
+
     g_test_init(&argc, &argv, NULL);
 
-    qtest_add_func("/pci/cxl/basic_hostbridge", cxl_basic_hb);
-    qtest_add_func("/pci/cxl/basic_pxb", cxl_basic_pxb);
-    qtest_add_func("/pci/cxl/pxb_with_window", cxl_pxb_with_window);
-    qtest_add_func("/pci/cxl/pxb_x2_with_window", cxl_2pxb_with_window);
-    qtest_add_func("/pci/cxl/rp", cxl_root_port);
-    qtest_add_func("/pci/cxl/rp_x2", cxl_2root_port);
-    qtest_add_func("/pci/cxl/type3_device", cxl_t3d);
-    qtest_add_func("/pci/cxl/rp_x2_type3_x2", cxl_1pxb_2rp_2t3d);
-    qtest_add_func("/pci/cxl/pxb_x2_root_port_x4_type3_x4", cxl_2pxb_4rp_4t3d);
+    if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
+        qtest_add_func("/pci/cxl/basic_hostbridge", cxl_basic_hb);
+        qtest_add_func("/pci/cxl/basic_pxb", cxl_basic_pxb);
+        qtest_add_func("/pci/cxl/pxb_with_window", cxl_pxb_with_window);
+        qtest_add_func("/pci/cxl/pxb_x2_with_window", cxl_2pxb_with_window);
+        qtest_add_func("/pci/cxl/rp", cxl_root_port);
+        qtest_add_func("/pci/cxl/rp_x2", cxl_2root_port);
+        qtest_add_func("/pci/cxl/type3_device", cxl_t3d);
+        qtest_add_func("/pci/cxl/rp_x2_type3_x2", cxl_1pxb_2rp_2t3d);
+        qtest_add_func("/pci/cxl/pxb_x2_root_port_x4_type3_x4",
+                       cxl_2pxb_4rp_4t3d);
+    } else if (strcmp(arch, "aarch64") == 0) {
+        qtest_add_func("/pci/cxl/virt/pxb_x2_root_port_x4_type3_x4",
+                       cxl_virt_2pxb_4rp_4t3d);
+    }
+
     return g_test_run();
 }
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 7e072d9a84..f384b2096d 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -222,6 +222,7 @@ qtests_aarch64 = \
   (config_all_devices.has_key('CONFIG_TPM_TIS_SYSBUS') ? ['tpm-tis-device-test'] : []) +        \
   (config_all_devices.has_key('CONFIG_TPM_TIS_SYSBUS') ? ['tpm-tis-device-swtpm-test'] : []) +  \
   (config_all_devices.has_key('CONFIG_XLNX_ZYNQMP_ARM') ? ['xlnx-can-test', 'fuzz-xlnx-dp-test'] : []) + \
+  qtests_cxl +                                                                                  \
   ['arm-cpu-features',
    'numa-test',
    'boot-serial-test',
-- 
2.32.0

