Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22A4CC433EF
	for <linux-cxl@archiver.kernel.org>; Sun,  6 Mar 2022 17:49:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232637AbiCFRuD (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sun, 6 Mar 2022 12:50:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232052AbiCFRuC (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sun, 6 Mar 2022 12:50:02 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A79F3D1E9
        for <linux-cxl@vger.kernel.org>; Sun,  6 Mar 2022 09:49:09 -0800 (PST)
Received: from fraeml742-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KBTZX5Gh5z67M3B;
        Mon,  7 Mar 2022 01:47:48 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml742-chm.china.huawei.com (10.206.15.223) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Sun, 6 Mar 2022 18:49:07 +0100
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.21; Sun, 6 Mar 2022 17:49:07 +0000
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
Subject: [PATCH v7 15/46] qtest/cxl: Introduce initial test for pxb-cxl only.
Date:   Sun, 6 Mar 2022 17:41:06 +0000
Message-ID: <20220306174137.5707-16-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220306174137.5707-1-Jonathan.Cameron@huawei.com>
References: <20220306174137.5707-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhreml706-chm.china.huawei.com (10.201.108.55) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Initial test with just pxb-cxl.  Other tests will be added
alongside functionality.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/qtest/cxl-test.c  | 23 +++++++++++++++++++++++
 tests/qtest/meson.build |  4 ++++
 2 files changed, 27 insertions(+)

diff --git a/tests/qtest/cxl-test.c b/tests/qtest/cxl-test.c
new file mode 100644
index 0000000000..1006c8ae4e
--- /dev/null
+++ b/tests/qtest/cxl-test.c
@@ -0,0 +1,23 @@
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
+
+static void cxl_basic_pxb(void)
+{
+    qtest_start("-machine q35,cxl=on -device pxb-cxl,bus=pcie.0");
+    qtest_end();
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+    qtest_add_func("/pci/cxl/basic_pxb", cxl_basic_pxb);
+    return g_test_run();
+}
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 721eafad12..7e072d9a84 100644
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
@@ -75,6 +78,7 @@ qtests_i386 = \
    slirp.found() ? ['virtio-net-failover'] : []) +                                          \
   (unpack_edk2_blobs ? ['bios-tables-test'] : []) +                                         \
   qtests_pci +                                                                              \
+  qtests_cxl +                                                                              \
   ['fdc-test',
    'ide-test',
    'hd-geo-test',
-- 
2.32.0

