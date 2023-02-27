Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2E16C64ED8
	for <linux-cxl@archiver.kernel.org>; Mon, 27 Feb 2023 11:29:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbjB0L34 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 27 Feb 2023 06:29:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjB0L3z (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 27 Feb 2023 06:29:55 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A511C59C
        for <linux-cxl@vger.kernel.org>; Mon, 27 Feb 2023 03:29:54 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PQJBb5fn9z6JB0q;
        Mon, 27 Feb 2023 19:27:35 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 27 Feb 2023 11:29:52 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>
CC:     Ben Widawsky <bwidawsk@kernel.org>, <linux-cxl@vger.kernel.org>,
        <linuxarm@huawei.com>, Ira Weiny <ira.weiny@intel.com>,
        Gregory Price <gourry.memverge@gmail.com>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        Mike Maslenkin <mike.maslenkin@gmail.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Markus Armbruster <armbru@redhat.com>,
        =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
        Thomas Huth <thuth@redhat.com>
Subject: [PATCH v6 4/8] hw/pci-bridge/cxl_root_port: Wire up MSI
Date:   Mon, 27 Feb 2023 11:27:47 +0000
Message-ID: <20230227112751.6101-5-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230227112751.6101-1-Jonathan.Cameron@huawei.com>
References: <20230227112751.6101-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Done to avoid fixing ACPI route description of traditional PCI interrupts on q35
and because we should probably move with the times anyway.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
 hw/pci-bridge/cxl_root_port.c | 61 +++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/hw/pci-bridge/cxl_root_port.c b/hw/pci-bridge/cxl_root_port.c
index 00195257f7..7dfd20aa67 100644
--- a/hw/pci-bridge/cxl_root_port.c
+++ b/hw/pci-bridge/cxl_root_port.c
@@ -22,6 +22,7 @@
 #include "qemu/range.h"
 #include "hw/pci/pci_bridge.h"
 #include "hw/pci/pcie_port.h"
+#include "hw/pci/msi.h"
 #include "hw/qdev-properties.h"
 #include "hw/sysbus.h"
 #include "qapi/error.h"
@@ -29,6 +30,10 @@
 
 #define CXL_ROOT_PORT_DID 0x7075
 
+#define CXL_RP_MSI_OFFSET               0x60
+#define CXL_RP_MSI_SUPPORTED_FLAGS      PCI_MSI_FLAGS_MASKBIT
+#define CXL_RP_MSI_NR_VECTOR            2
+
 /* Copied from the gen root port which we derive */
 #define GEN_PCIE_ROOT_PORT_AER_OFFSET 0x100
 #define GEN_PCIE_ROOT_PORT_ACS_OFFSET \
@@ -47,6 +52,49 @@ typedef struct CXLRootPort {
 #define TYPE_CXL_ROOT_PORT "cxl-rp"
 DECLARE_INSTANCE_CHECKER(CXLRootPort, CXL_ROOT_PORT, TYPE_CXL_ROOT_PORT)
 
+/*
+ * If two MSI vector are allocated, Advanced Error Interrupt Message Number
+ * is 1. otherwise 0.
+ * 17.12.5.10 RPERRSTS,  32:27 bit Advanced Error Interrupt Message Number.
+ */
+static uint8_t cxl_rp_aer_vector(const PCIDevice *d)
+{
+    switch (msi_nr_vectors_allocated(d)) {
+    case 1:
+        return 0;
+    case 2:
+        return 1;
+    case 4:
+    case 8:
+    case 16:
+    case 32:
+    default:
+        break;
+    }
+    abort();
+    return 0;
+}
+
+static int cxl_rp_interrupts_init(PCIDevice *d, Error **errp)
+{
+    int rc;
+
+    rc = msi_init(d, CXL_RP_MSI_OFFSET, CXL_RP_MSI_NR_VECTOR,
+                  CXL_RP_MSI_SUPPORTED_FLAGS & PCI_MSI_FLAGS_64BIT,
+                  CXL_RP_MSI_SUPPORTED_FLAGS & PCI_MSI_FLAGS_MASKBIT,
+                  errp);
+    if (rc < 0) {
+        assert(rc == -ENOTSUP);
+    }
+
+    return rc;
+}
+
+static void cxl_rp_interrupts_uninit(PCIDevice *d)
+{
+    msi_uninit(d);
+}
+
 static void latch_registers(CXLRootPort *crp)
 {
     uint32_t *reg_state = crp->cxl_cstate.crb.cache_mem_registers;
@@ -183,6 +231,15 @@ static void cxl_rp_dvsec_write_config(PCIDevice *dev, uint32_t addr,
     }
 }
 
+static void cxl_rp_aer_vector_update(PCIDevice *d)
+{
+    PCIERootPortClass *rpc = PCIE_ROOT_PORT_GET_CLASS(d);
+
+    if (rpc->aer_vector) {
+        pcie_aer_root_set_vector(d, rpc->aer_vector(d));
+    }
+}
+
 static void cxl_rp_write_config(PCIDevice *d, uint32_t address, uint32_t val,
                                 int len)
 {
@@ -192,6 +249,7 @@ static void cxl_rp_write_config(PCIDevice *d, uint32_t address, uint32_t val,
 
     pcie_cap_slot_get(d, &slt_ctl, &slt_sta);
     pci_bridge_write_config(d, address, val, len);
+    cxl_rp_aer_vector_update(d);
     pcie_cap_flr_write_config(d, address, val, len);
     pcie_cap_slot_write_config(d, slt_ctl, slt_sta, address, val, len);
     pcie_aer_write_config(d, address, val, len);
@@ -220,6 +278,9 @@ static void cxl_root_port_class_init(ObjectClass *oc, void *data)
 
     rpc->aer_offset = GEN_PCIE_ROOT_PORT_AER_OFFSET;
     rpc->acs_offset = GEN_PCIE_ROOT_PORT_ACS_OFFSET;
+    rpc->aer_vector = cxl_rp_aer_vector;
+    rpc->interrupts_init = cxl_rp_interrupts_init;
+    rpc->interrupts_uninit = cxl_rp_interrupts_uninit;
 
     dc->hotpluggable = false;
 }
-- 
2.37.2

