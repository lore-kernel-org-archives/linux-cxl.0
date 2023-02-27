Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89510C64ED8
	for <linux-cxl@archiver.kernel.org>; Mon, 27 Feb 2023 15:33:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbjB0Pc7 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 27 Feb 2023 10:32:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbjB0Pcc (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 27 Feb 2023 10:32:32 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6911233E0
        for <linux-cxl@vger.kernel.org>; Mon, 27 Feb 2023 07:32:30 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PQPWW4hWcz6J79W;
        Mon, 27 Feb 2023 23:27:35 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 27 Feb 2023 15:32:28 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>,
        Fan Ni <fan.ni@samsung.com>
CC:     Ben Widawsky <bwidawsk@kernel.org>, <linux-cxl@vger.kernel.org>,
        <linuxarm@huawei.com>, Ira Weiny <ira.weiny@intel.com>,
        Gregory Price <gourry.memverge@gmail.com>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        Mike Maslenkin <mike.maslenkin@gmail.com>,
        Dave Jiang <dave.jiang@intel.com>
Subject: [PATCH v2 2/2] hw/pxb-cxl: Support passthrough HDM Decoders unless overridden
Date:   Mon, 27 Feb 2023 15:31:28 +0000
Message-ID: <20230227153128.8164-3-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230227153128.8164-1-Jonathan.Cameron@huawei.com>
References: <20230227153128.8164-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

The CXL r3.0 specification allows for there to be no HDM decoders on CXL
Host Bridges if they have only a single root port. Instead, all accesses
directed to the host bridge (as specified in CXL Fixed Memory Windows)
are assumed to be routed to the single root port.

Linux currently assumes this implementation choice. So to simplify testing,
make QEMU emulation also default to no HDM decoders under these particular
circumstances, but provide a hdm_for_passthrough boolean option to have
HDM decoders as previously.

Technically this is breaking backwards compatibility, but given the only
known software stack used with the QEMU emulation is the Linux kernel
and this configuration did not work before this change, there are
unlikely to be any complaints that it now works. The option is retained
to allow testing of software that does allow for these HDM decoders to exist,
once someone writes it.

Reported-by: Fan Ni <fan.ni@samsung.com>
Reviewed-by: Fan Ni <fan.ni@samsung.com>
Tested-by: Fan Ni <fan.ni@samsung.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

--
v2: Pick up and fix typo in tag from Fan Ni
---
 hw/cxl/cxl-host.c                   | 31 ++++++++++++--------
 hw/pci-bridge/pci_expander_bridge.c | 44 +++++++++++++++++++++++++----
 include/hw/cxl/cxl.h                |  1 +
 include/hw/cxl/cxl_component.h      |  1 +
 include/hw/pci/pci_bridge.h         |  1 +
 5 files changed, 61 insertions(+), 17 deletions(-)

diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
index 3c1ec8732a..6e923ceeaf 100644
--- a/hw/cxl/cxl-host.c
+++ b/hw/cxl/cxl-host.c
@@ -146,21 +146,28 @@ static PCIDevice *cxl_cfmws_find_device(CXLFixedWindow *fw, hwaddr addr)
         return NULL;
     }
 
-    hb_cstate = cxl_get_hb_cstate(hb);
-    if (!hb_cstate) {
-        return NULL;
-    }
+    if (cxl_get_hb_passthrough(hb)) {
+        rp = pcie_find_port_first(hb->bus);
+        if (!rp) {
+            return NULL;
+        }
+    } else {
+        hb_cstate = cxl_get_hb_cstate(hb);
+        if (!hb_cstate) {
+            return NULL;
+        }
 
-    cache_mem = hb_cstate->crb.cache_mem_registers;
+        cache_mem = hb_cstate->crb.cache_mem_registers;
 
-    target_found = cxl_hdm_find_target(cache_mem, addr, &target);
-    if (!target_found) {
-        return NULL;
-    }
+        target_found = cxl_hdm_find_target(cache_mem, addr, &target);
+        if (!target_found) {
+            return NULL;
+        }
 
-    rp = pcie_find_port_by_pn(hb->bus, target);
-    if (!rp) {
-        return NULL;
+        rp = pcie_find_port_by_pn(hb->bus, target);
+        if (!rp) {
+            return NULL;
+        }
     }
 
     d = pci_bridge_get_sec_bus(PCI_BRIDGE(rp))->devices[0];
diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expander_bridge.c
index e752a21292..ead33f0c05 100644
--- a/hw/pci-bridge/pci_expander_bridge.c
+++ b/hw/pci-bridge/pci_expander_bridge.c
@@ -15,6 +15,7 @@
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_bus.h"
 #include "hw/pci/pci_host.h"
+#include "hw/pci/pcie_port.h"
 #include "hw/qdev-properties.h"
 #include "hw/pci/pci_bridge.h"
 #include "hw/pci-bridge/pci_expander_bridge.h"
@@ -79,6 +80,13 @@ CXLComponentState *cxl_get_hb_cstate(PCIHostState *hb)
     return &host->cxl_cstate;
 }
 
+bool cxl_get_hb_passthrough(PCIHostState *hb)
+{
+    CXLHost *host = PXB_CXL_HOST(hb);
+
+    return host->passthrough;
+}
+
 static int pxb_bus_num(PCIBus *bus)
 {
     PXBDev *pxb = convert_to_pxb(bus->parent_dev);
@@ -289,15 +297,32 @@ static int pxb_map_irq_fn(PCIDevice *pci_dev, int pin)
     return pin - PCI_SLOT(pxb->devfn);
 }
 
-static void pxb_dev_reset(DeviceState *dev)
+static void pxb_cxl_dev_reset(DeviceState *dev)
 {
     CXLHost *cxl = PXB_CXL_DEV(dev)->cxl.cxl_host_bridge;
     CXLComponentState *cxl_cstate = &cxl->cxl_cstate;
+    PCIHostState *hb = PCI_HOST_BRIDGE(cxl);
     uint32_t *reg_state = cxl_cstate->crb.cache_mem_registers;
     uint32_t *write_msk = cxl_cstate->crb.cache_mem_regs_write_mask;
+    int dsp_count = 0;
 
     cxl_component_register_init_common(reg_state, write_msk, CXL2_ROOT_PORT);
-    ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, TARGET_COUNT, 8);
+    /*
+     * The CXL specification allows for host bridges with no HDM decoders
+     * if they only have a single root port.
+     */
+    if (!PXB_DEV(dev)->hdm_for_passthrough) {
+        dsp_count = pcie_count_ds_ports(hb->bus);
+    }
+    /* Initial reset will have 0 dsp so wait until > 0 */
+    if (dsp_count == 1) {
+        cxl->passthrough = true;
+        /* Set Capability ID in header to NONE */
+        ARRAY_FIELD_DP32(reg_state, CXL_HDM_CAPABILITY_HEADER, ID, 0);
+    } else {
+        ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, TARGET_COUNT,
+                         8);
+    }
 }
 
 static gint pxb_compare(gconstpointer a, gconstpointer b)
@@ -481,9 +506,18 @@ static void pxb_cxl_dev_realize(PCIDevice *dev, Error **errp)
     }
 
     pxb_dev_realize_common(dev, CXL, errp);
-    pxb_dev_reset(DEVICE(dev));
+    pxb_cxl_dev_reset(DEVICE(dev));
 }
 
+static Property pxb_cxl_dev_properties[] = {
+    /* Note: 0 is not a legal PXB bus number. */
+    DEFINE_PROP_UINT8("bus_nr", PXBDev, bus_nr, 0),
+    DEFINE_PROP_UINT16("numa_node", PXBDev, numa_node, NUMA_NODE_UNASSIGNED),
+    DEFINE_PROP_BOOL("bypass_iommu", PXBDev, bypass_iommu, false),
+    DEFINE_PROP_BOOL("hdm_for_passthrough", PXBDev, hdm_for_passthrough, false),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
 static void pxb_cxl_dev_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc   = DEVICE_CLASS(klass);
@@ -497,12 +531,12 @@ static void pxb_cxl_dev_class_init(ObjectClass *klass, void *data)
      */
 
     dc->desc = "CXL Host Bridge";
-    device_class_set_props(dc, pxb_dev_properties);
+    device_class_set_props(dc, pxb_cxl_dev_properties);
     set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
 
     /* Host bridges aren't hotpluggable. FIXME: spec reference */
     dc->hotpluggable = false;
-    dc->reset = pxb_dev_reset;
+    dc->reset = pxb_cxl_dev_reset;
 }
 
 static const TypeInfo pxb_cxl_dev_info = {
diff --git a/include/hw/cxl/cxl.h b/include/hw/cxl/cxl.h
index b161be59b7..b2cffbb364 100644
--- a/include/hw/cxl/cxl.h
+++ b/include/hw/cxl/cxl.h
@@ -49,6 +49,7 @@ struct CXLHost {
     PCIHostState parent_obj;
 
     CXLComponentState cxl_cstate;
+    bool passthrough;
 };
 
 #define TYPE_PXB_CXL_HOST "pxb-cxl-host"
diff --git a/include/hw/cxl/cxl_component.h b/include/hw/cxl/cxl_component.h
index ec4203b83f..42c7e581a7 100644
--- a/include/hw/cxl/cxl_component.h
+++ b/include/hw/cxl/cxl_component.h
@@ -247,6 +247,7 @@ static inline hwaddr cxl_decode_ig(int ig)
 }
 
 CXLComponentState *cxl_get_hb_cstate(PCIHostState *hb);
+bool cxl_get_hb_passthrough(PCIHostState *hb);
 
 void cxl_doe_cdat_init(CXLComponentState *cxl_cstate, Error **errp);
 void cxl_doe_cdat_release(CXLComponentState *cxl_cstate);
diff --git a/include/hw/pci/pci_bridge.h b/include/hw/pci/pci_bridge.h
index 63a7521567..81a058bb2c 100644
--- a/include/hw/pci/pci_bridge.h
+++ b/include/hw/pci/pci_bridge.h
@@ -92,6 +92,7 @@ struct PXBDev {
     uint8_t bus_nr;
     uint16_t numa_node;
     bool bypass_iommu;
+    bool hdm_for_passthrough;
     struct cxl_dev {
         CXLHost *cxl_host_bridge; /* Pointer to a CXLHost */
     } cxl;
-- 
2.37.2

