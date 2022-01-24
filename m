Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CDF4C433EF
	for <linux-cxl@archiver.kernel.org>; Mon, 24 Jan 2022 17:32:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244487AbiAXRc1 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 24 Jan 2022 12:32:27 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4475 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244479AbiAXRc1 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 24 Jan 2022 12:32:27 -0500
Received: from fraeml704-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JjH4r1yXfz6FGWt;
        Tue, 25 Jan 2022 01:28:12 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml704-chm.china.huawei.com (10.206.15.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.21; Mon, 24 Jan 2022 18:32:25 +0100
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 24 Jan 2022 17:32:24 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <qemu-devel@nongnu.org>, Marcel Apfelbaum <marcel@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>
CC:     <linux-cxl@vger.kernel.org>, Ben Widawsky <ben.widawsky@intel.com>,
        =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
        Peter Maydell <peter.maydell@linaro.org>,
        <linuxarm@huawei.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
        Saransh Gupta1 <saransh@ibm.com>,
        Shreyas Shah <shreyas.shah@elastics.cloud>,
        Chris Browy <cbrowy@avery-design.com>,
        Samarth Saxena <samarths@cadence.com>,
        "Dan Williams" <dan.j.williams@intel.com>
Subject: [PATCH v4 30/42] acpi/cxl: Introduce CFMWS structures in CEDT
Date:   Mon, 24 Jan 2022 17:16:53 +0000
Message-ID: <20220124171705.10432-31-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220124171705.10432-1-Jonathan.Cameron@huawei.com>
References: <20220124171705.10432-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhreml740-chm.china.huawei.com (10.201.108.190) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Ben Widawsky <ben.widawsky@intel.com>

The CEDT CXL Fixed Window Memory Window Structures (CFMWs)
define regions of the host phyiscal address map which
(via an impdef means) are configured such that they have
a particular interleave setup across one or more CXL Host Bridges.

Reported-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 hw/acpi/cxl.c | 59 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/hw/acpi/cxl.c b/hw/acpi/cxl.c
index af8641f999..ade4bbf375 100644
--- a/hw/acpi/cxl.c
+++ b/hw/acpi/cxl.c
@@ -61,6 +61,64 @@ static void cedt_build_chbs(GArray *table_data, PXBDev *cxl)
     build_append_int_noprefix(table_data, memory_region_size(mr), 8);
 }
 
+/*
+ * CFMWS entries in CXL 2.0 ECN: CEDT CFMWS & QTG _DSM.
+ * Interleave ways encoding in CXL 2.0 ECN: 3, 6, 12 and 16-way memory
+ * interleaving.
+ */
+static void cedt_build_cfmws(GArray *table_data, MachineState *ms)
+{
+    CXLState *cxls = ms->cxl_devices_state;
+    GList *it;
+
+    for (it = cxls->fixed_windows; it; it = it->next) {
+        CXLFixedWindow *fw = it->data;
+        int i;
+
+        /* Type */
+        build_append_int_noprefix(table_data, 1, 1);
+
+        /* Reserved */
+        build_append_int_noprefix(table_data, 0, 1);
+
+        /* Record Length */
+        build_append_int_noprefix(table_data, 36 + 4 * fw->num_targets, 2);
+
+        /* Reserved */
+        build_append_int_noprefix(table_data, 0, 4);
+
+        /* Base HPA */
+        build_append_int_noprefix(table_data, fw->mr.addr, 8);
+
+        /* Window Size */
+        build_append_int_noprefix(table_data, fw->size, 8);
+
+        /* Host Bridge Interleave Ways */
+        build_append_int_noprefix(table_data, fw->enc_int_ways, 1);
+
+        /* Host Bridge Interleave Arithmetic */
+        build_append_int_noprefix(table_data, 0, 1);
+
+        /* Reserved */
+        build_append_int_noprefix(table_data, 0, 2);
+
+        /* Host Bridge Interleave Granularity */
+        build_append_int_noprefix(table_data, fw->enc_int_gran, 4);
+
+        /* Window Restrictions */
+        build_append_int_noprefix(table_data, 0x0f, 2); /* No restrictions */
+
+        /* QTG ID */
+        build_append_int_noprefix(table_data, 0, 2);
+
+        /* Host Bridge List (list of UIDs - currently bus_nr) */
+        for (i = 0; i < fw->num_targets; i++) {
+            g_assert(fw->target_hbs[i]);
+            build_append_int_noprefix(table_data, fw->target_hbs[i]->bus_nr, 4);
+        }
+    }
+}
+
 static int cxl_foreach_pxb_hb(Object *obj, void *opaque)
 {
     Aml *cedt = opaque;
@@ -87,6 +145,7 @@ void cxl_build_cedt(MachineState *ms, GArray *table_offsets, GArray *table_data,
     /* reserve space for CEDT header */
 
     object_child_foreach_recursive(object_get_root(), cxl_foreach_pxb_hb, cedt);
+    cedt_build_cfmws(cedt->buf, ms);
 
     /* copy AML table into ACPI tables blob and patch header there */
     g_array_append_vals(table_data, cedt->buf->data, cedt->buf->len);
-- 
2.32.0

