Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86184C433EF
	for <linux-cxl@archiver.kernel.org>; Mon,  4 Apr 2022 15:33:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241140AbiDDPfg (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 4 Apr 2022 11:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378611AbiDDPff (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 4 Apr 2022 11:35:35 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3146A10F1
        for <linux-cxl@vger.kernel.org>; Mon,  4 Apr 2022 08:33:38 -0700 (PDT)
Received: from fraeml702-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KXFBL4j2mz681Yv;
        Mon,  4 Apr 2022 23:31:54 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml702-chm.china.huawei.com (10.206.15.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Mon, 4 Apr 2022 17:33:36 +0200
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 4 Apr 2022 16:33:35 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <linuxarm@huawei.com>, <qemu-devel@nongnu.org>,
        =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
        Marcel Apfelbaum <marcel@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>,
        Markus Armbruster <armbru@redhat.com>,
        "Mark Cave-Ayland" <mark.cave-ayland@ilande.co.uk>,
        Adam Manzanares <a.manzanares@samsung.com>
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
        "k . jensen @ samsung . com" <k.jensen@samsung.com>,
        Tong Zhang <t.zhang2@samsung.com>, <dave@stgolabs.net>,
        Alison Schofield <alison.schofield@intel.com>
Subject: [PATCH v9 37/45] qtests/bios-tables-test: Add a test for CXL emulation.
Date:   Mon, 4 Apr 2022 16:14:37 +0100
Message-ID: <20220404151445.10955-38-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220404151445.10955-1-Jonathan.Cameron@huawei.com>
References: <20220404151445.10955-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhreml717-chm.china.huawei.com (10.201.108.68) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

The DSDT includes several CXL specific elements and the CEDT
table is only present if we enable CXL.

The test exercises all current functionality with several
CFMWS, CHBS structures in CEDT and ACPI0016/ACPI00017 and _OSC
entries in DSDT.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 tests/qtest/bios-tables-test.c | 44 ++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index c4a2d1e166..577b26bcec 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -1537,6 +1537,49 @@ static void test_acpi_q35_viot(void)
     free_test_data(&data);
 }
 
+static void test_acpi_q35_cxl(void)
+{
+    gchar *tmp_path = g_dir_make_tmp("qemu-test-cxl.XXXXXX", NULL);
+    gchar *params;
+
+    test_data data = {
+        .machine = MACHINE_Q35,
+        .variant = ".cxl",
+    };
+    /*
+     * A complex CXL setup.
+     */
+    params = g_strdup_printf(" -machine cxl=on"
+                             " -object memory-backend-file,id=cxl-mem1,mem-path=%s,size=256M"
+                             " -object memory-backend-file,id=cxl-mem2,mem-path=%s,size=256M"
+                             " -object memory-backend-file,id=cxl-mem3,mem-path=%s,size=256M"
+                             " -object memory-backend-file,id=cxl-mem4,mem-path=%s,size=256M"
+                             " -object memory-backend-file,id=lsa1,mem-path=%s,size=256M"
+                             " -object memory-backend-file,id=lsa2,mem-path=%s,size=256M"
+                             " -object memory-backend-file,id=lsa3,mem-path=%s,size=256M"
+                             " -object memory-backend-file,id=lsa4,mem-path=%s,size=256M"
+                             " -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1"
+                             " -device pxb-cxl,bus_nr=222,bus=pcie.0,id=cxl.2"
+                             " -device cxl-rp,port=0,bus=cxl.1,id=rp1,chassis=0,slot=2"
+                             " -device cxl-type3,bus=rp1,memdev=cxl-mem1,lsa=lsa1"
+                             " -device cxl-rp,port=1,bus=cxl.1,id=rp2,chassis=0,slot=3"
+                             " -device cxl-type3,bus=rp2,memdev=cxl-mem2,lsa=lsa2"
+                             " -device cxl-rp,port=0,bus=cxl.2,id=rp3,chassis=0,slot=5"
+                             " -device cxl-type3,bus=rp3,memdev=cxl-mem3,lsa=lsa3"
+                             " -device cxl-rp,port=1,bus=cxl.2,id=rp4,chassis=0,slot=6"
+                             " -device cxl-type3,bus=rp4,memdev=cxl-mem4,lsa=lsa4"
+                             " -cxl-fixed-memory-window targets.0=cxl.1,size=4G,interleave-granularity=8k"
+                             " -cxl-fixed-memory-window targets.0=cxl.1,targets.1=cxl.2,size=4G,interleave-granularity=8k",
+                             tmp_path, tmp_path, tmp_path, tmp_path,
+                             tmp_path, tmp_path, tmp_path, tmp_path);
+    test_acpi_one(params, &data);
+
+    g_free(params);
+    g_assert(g_rmdir(tmp_path) == 0);
+    g_free(tmp_path);
+    free_test_data(&data);
+}
+
 static void test_acpi_virt_viot(void)
 {
     test_data data = {
@@ -1742,6 +1785,7 @@ int main(int argc, char *argv[])
             qtest_add_func("acpi/q35/kvm/dmar", test_acpi_q35_kvm_dmar);
         }
         qtest_add_func("acpi/q35/viot", test_acpi_q35_viot);
+        qtest_add_func("acpi/q35/cxl", test_acpi_q35_cxl);
         qtest_add_func("acpi/q35/slic", test_acpi_q35_slic);
     } else if (strcmp(arch, "aarch64") == 0) {
         if (has_tcg) {
-- 
2.32.0

