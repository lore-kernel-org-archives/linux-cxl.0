Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03D6CC433DB
	for <linux-cxl@archiver.kernel.org>; Tue,  2 Feb 2021 01:02:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D63BB64EE9
	for <linux-cxl@archiver.kernel.org>; Tue,  2 Feb 2021 01:02:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbhBBBCO (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 1 Feb 2021 20:02:14 -0500
Received: from mga06.intel.com ([134.134.136.31]:21915 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229832AbhBBBCO (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Mon, 1 Feb 2021 20:02:14 -0500
IronPort-SDR: 4SWv9UwP8TliOnjeF8vV9rQ/8vnsC5pwvRGqLBAtM5zGsRg5W9Z1+de8j/FhQEjFRyAuDae0S8
 hhuplF0t8UYQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9882"; a="242294675"
X-IronPort-AV: E=Sophos;i="5.79,393,1602572400"; 
   d="scan'208";a="242294675"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 17:00:25 -0800
IronPort-SDR: gaLajS1KKfepojaxXY1K+YOXX8MADJ1ZoGGUwHtf/ghOeEx57GILnkCQG9RuYGUgOnmczUNVsm
 TRCA2X7hVlwA==
X-IronPort-AV: E=Sophos;i="5.79,393,1602572400"; 
   d="scan'208";a="581764293"
Received: from jambrizm-mobl1.amr.corp.intel.com (HELO bwidawsk-mobl5.local) ([10.252.133.15])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 17:00:23 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     qemu-devel@nongnu.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>, linux-cxl@vger.kernel.org,
        Chris Browy <cbrowy@avery-design.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
        Markus Armbruster <armbru@redhat.com>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "John Groves (jgroves)" <jgroves@micron.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
Subject: [RFC PATCH v3 30/31] qtest/cxl: Add very basic sanity tests
Date:   Mon,  1 Feb 2021 16:59:47 -0800
Message-Id: <20210202005948.241655-31-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210202005948.241655-1-ben.widawsky@intel.com>
References: <20210202005948.241655-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 tests/qtest/cxl-test.c  | 93 +++++++++++++++++++++++++++++++++++++++++
 tests/qtest/meson.build |  4 ++
 2 files changed, 97 insertions(+)
 create mode 100644 tests/qtest/cxl-test.c

diff --git a/tests/qtest/cxl-test.c b/tests/qtest/cxl-test.c
new file mode 100644
index 0000000000..00eca14faa
--- /dev/null
+++ b/tests/qtest/cxl-test.c
@@ -0,0 +1,93 @@
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
+#define QEMU_PXB_CMD "-machine q35 -object memory-backend-file,id=cxl-mem1," \
+                     "share,mem-path=%s,size=512M "                          \
+                     "-device pxb-cxl,id=cxl.0,bus=pcie.0,bus_nr=52,uid=0,"  \
+                     "len-window-base=1,window-base[0]=0x4c0000000,memdev[0]=cxl-mem1"
+#define QEMU_RP "-device cxl-rp,id=rp0,bus=cxl.0,addr=0.0,chassis=0,slot=0"
+
+#define QEMU_T3D "-device cxl-type3,bus=rp0,memdev=cxl-mem1,id=cxl-pmem0,size=256M"
+
+static void cxl_basic_hb(void)
+{
+    qtest_start("-machine q35,cxl");
+    qtest_end();
+}
+
+static void cxl_basic_pxb(void)
+{
+    qtest_start("-machine q35 -device pxb-cxl,bus=pcie.0,uid=0");
+    qtest_end();
+}
+
+static void cxl_pxb_with_window(void)
+{
+    GString *cmdline;
+    char template[] = "/tmp/cxl-test-XXXXXX";
+    const char *tmpfs;
+
+    tmpfs = mkdtemp(template);
+
+    cmdline = g_string_new(NULL);
+    g_string_printf(cmdline, QEMU_PXB_CMD, tmpfs);
+
+    qtest_start(cmdline->str);
+    qtest_end();
+
+    g_string_free(cmdline, TRUE);
+}
+
+static void cxl_root_port(void)
+{
+    GString *cmdline;
+    char template[] = "/tmp/cxl-test-XXXXXX";
+    const char *tmpfs;
+
+    tmpfs = mkdtemp(template);
+
+    cmdline = g_string_new(NULL);
+    g_string_printf(cmdline, QEMU_PXB_CMD " %s", tmpfs, QEMU_RP);
+
+    qtest_start(cmdline->str);
+    qtest_end();
+
+    g_string_free(cmdline, TRUE);
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
+    g_string_printf(cmdline, QEMU_PXB_CMD " %s %s", tmpfs, QEMU_RP, QEMU_T3D);
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
+    qtest_add_func("/pci/cxl/root_port", cxl_root_port);
+    qtest_add_func("/pci/cxl/type3_device", cxl_t3d);
+
+    return g_test_run();
+}
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index c83bc211b6..554152b7c5 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -22,6 +22,9 @@ qtests_pci = \
   (config_all_devices.has_key('CONFIG_VGA') ? ['display-vga-test'] : []) +                  \
   (config_all_devices.has_key('CONFIG_IVSHMEM_DEVICE') ? ['ivshmem-test'] : [])
 
+qtests_cxl = \
+  (config_all_devices.has_key('CONFIG_CXL') ? ['cxl-test'] : [])
+
 qtests_i386 = \
   (slirp.found() ? ['pxe-test', 'test-netfilter'] : []) +             \
   (config_host.has_key('CONFIG_POSIX') ? ['test-filter-mirror'] : []) +                     \
@@ -48,6 +51,7 @@ qtests_i386 = \
   (config_all_devices.has_key('CONFIG_TPM_TIS_ISA') ? ['tpm-tis-swtpm-test'] : []) +        \
   (config_all_devices.has_key('CONFIG_RTL8139_PCI') ? ['rtl8139-test'] : []) +              \
   qtests_pci +                                                                              \
+  qtests_cxl +                                                                              \
   ['fdc-test',
    'ide-test',
    'hd-geo-test',
-- 
2.30.0

