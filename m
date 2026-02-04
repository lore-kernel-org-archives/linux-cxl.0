Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7E12556E
	for <linux-cxl@vger.kernel.org>; Wed,  4 Feb 2026 17:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770226441; cv=none; b=rYqKdV32Maas2/lxadP5n6t6QmoodzQ8NNwGf/Oc1IBdf0fJFQZPfv12g74wNvKva3N39kW0UauKtOz+RzS4UQt4nYxyy04c/B0wrW9JK7Q308Y+Kc4D3HGsXJO7Mul7KQDcy3hImzV+DVnSStcVjc0sB4/Aqoyb0NU2YAQiUSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770226441; c=relaxed/simple;
	bh=QSGWomTRkYo+LlcORlzCvsLb6E0x0/rtPfMsAupGeA4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JfooT3mjTzXxXSDai+U9tUZY8XTiGz59Rki2GnB2wNzq7eWF7LJWl5uo0W5fUFQI2XrGHphhe6MyYhzj718OdhSpS9j6ZtKZaIbgE/qf7SpGr9GIJru3w3VN7XkzhvoyXE5gSaoxllTSc7wk2gJ8inIn+bK1dvVe/cEOovSaawA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4f5nW90nMTzJ46Zw;
	Thu,  5 Feb 2026 01:33:09 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 70FEC4056A;
	Thu,  5 Feb 2026 01:33:58 +0800 (CST)
Received: from SecurePC-101-06.huawei.com (10.122.19.247) by
 dubpeml500005.china.huawei.com (7.214.145.207) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 4 Feb 2026 17:33:57 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Michael Tsirkin <mst@redhat.com>, <qemu-devel@nongnu.org>, Arpit Kumar
	<arpit1.kumar@samsung.com>
CC: <linuxarm@huawei.com>, <linux-cxl@vger.kernel.org>, Ravi Shankar
	<venkataravis@micron.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
	Michael Roth <michael.roth@amd.com>
Subject: [PATCH qemu v5 3/3] hw/cxl: Add Physical Port Control FMAPI Command (Opcode 5102h)
Date: Wed, 4 Feb 2026 17:32:23 +0000
Message-ID: <20260204173223.44122-4-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260204173223.44122-1-Jonathan.Cameron@huawei.com>
References: <20260204173223.44122-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 dubpeml500005.china.huawei.com (7.214.145.207)

From: Arpit Kumar <arpit1.kumar@samsung.com>

Added assert-deassert PERST implementation for physical ports (both USP
and DSP's).

Assert PERST involves bg operation for holding 100ms.
Reset PPB implementation for physical ports.

Signed-off-by: Arpit Kumar <arpit1.kumar@samsung.com>
Co-developed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

---
Changes mostly due to dropping refactor that preceeded this in original
series.
---
 include/hw/cxl/cxl_port.h                   |  20 +++
 include/hw/pci-bridge/cxl_downstream_port.h |  12 ++
 include/hw/pci-bridge/cxl_upstream_port.h   |   2 +
 hw/cxl/cxl-mailbox-utils.c                  | 130 ++++++++++++++++++++
 hw/pci-bridge/cxl_downstream.c              |   9 ++
 hw/pci-bridge/cxl_upstream.c                |   1 +
 6 files changed, 174 insertions(+)

diff --git a/include/hw/cxl/cxl_port.h b/include/hw/cxl/cxl_port.h
index 04db60f7bc23..fb2e22a9f2ae 100644
--- a/include/hw/cxl/cxl_port.h
+++ b/include/hw/cxl/cxl_port.h
@@ -3,6 +3,8 @@
 #ifndef CXL_PORT_H
 #define CXL_PORT_H
 
+#include "qemu/thread.h"
+
 /* CXL r3.2 Table 7-19: Get Physical Port State Port Information Block Format */
 #define CXL_PORT_CONFIG_STATE_DISABLED           0x0
 #define CXL_PORT_CONFIG_STATE_BIND_IN_PROGRESS   0x1
@@ -50,4 +52,22 @@
 #define CXL_PORT_LINK_STATE_FLAG_PRSNT            BIT(2)
 #define CXL_PORT_LINK_STATE_FLAG_POWER_OFF        BIT(3)
 
+#define CXL_MAX_PHY_PORTS 256
+#define ASSERT_WAIT_TIME_MS 100 /* Assert - Deassert PERST */
+
+/* Assert - Deassert PERST */
+typedef struct CXLPhyPortPerst {
+    bool issued_assert_perst;
+    QemuMutex lock; /* protecting assert-deassert reset request */
+    uint64_t asrt_time;
+    QemuThread asrt_thread; /* thread for 100ms delay */
+} CXLPhyPortPerst;
+
+void cxl_init_physical_port_control(CXLPhyPortPerst *perst);
+
+static inline bool cxl_perst_asserted(CXLPhyPortPerst *perst)
+{
+    return perst->issued_assert_perst || perst->asrt_time < ASSERT_WAIT_TIME_MS;
+}
+
 #endif /* CXL_PORT_H */
diff --git a/include/hw/pci-bridge/cxl_downstream_port.h b/include/hw/pci-bridge/cxl_downstream_port.h
new file mode 100644
index 000000000000..1611504c8764
--- /dev/null
+++ b/include/hw/pci-bridge/cxl_downstream_port.h
@@ -0,0 +1,12 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef CXL_DOWNSTREAM_PORT_H
+#define CXL_DOWNSTREAM_PORT_H
+#include "include/hw/cxl/cxl_port.h"
+
+typedef struct CXLDownstreamPort CXLDownstreamPort;
+CXLPhyPortPerst *cxl_dsp_get_perst(CXLDownstreamPort *dsp);
+
+#endif
diff --git a/include/hw/pci-bridge/cxl_upstream_port.h b/include/hw/pci-bridge/cxl_upstream_port.h
index e3d6a27acc86..dfe01771c7d7 100644
--- a/include/hw/pci-bridge/cxl_upstream_port.h
+++ b/include/hw/pci-bridge/cxl_upstream_port.h
@@ -4,6 +4,7 @@
 #include "hw/pci/pcie.h"
 #include "hw/pci/pcie_port.h"
 #include "hw/cxl/cxl.h"
+#include "hw/cxl/cxl_port.h"
 
 typedef struct CXLUpstreamPort {
     /*< private >*/
@@ -12,6 +13,7 @@ typedef struct CXLUpstreamPort {
     /*< public >*/
     CXLComponentState cxl_cstate;
     CXLCCI swcci;
+    CXLPhyPortPerst perst;
 
     PCIExpLinkSpeed speed;
     PCIExpLinkWidth width;
diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index b6ac987ee021..c83b5f90d4d3 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -17,6 +17,7 @@
 #include "hw/cxl/cxl_mailbox.h"
 #include "hw/cxl/cxl_port.h"
 #include "hw/pci/pci.h"
+#include "hw/pci-bridge/cxl_downstream_port.h"
 #include "hw/pci-bridge/cxl_upstream_port.h"
 #include "qemu/cutils.h"
 #include "qemu/host-utils.h"
@@ -119,6 +120,7 @@ enum {
     PHYSICAL_SWITCH = 0x51,
         #define IDENTIFY_SWITCH_DEVICE      0x0
         #define GET_PHYSICAL_PORT_STATE     0x1
+        #define PHYSICAL_PORT_CONTROL       0x2
     TUNNEL = 0x53,
         #define MANAGEMENT_COMMAND     0x0
     FMAPI_DCD_MGMT = 0x56,
@@ -616,6 +618,7 @@ static CXLRetCode cmd_get_physical_port_state(const struct cxl_cmd *cmd,
         struct cxl_fmapi_port_state_info_block *port;
         /* First try to match on downstream port */
         PCIDevice *port_dev;
+        CXLPhyPortPerst *perst;
         uint16_t lnkcap, lnkcap2, lnksta;
 
         port = &out->ports[i];
@@ -663,6 +666,7 @@ static CXLRetCode cmd_get_physical_port_state(const struct cxl_cmd *cmd,
             port->supported_cxl_mode_bitmask = CXL_PORT_SUPPORTS_68B_VH |
                 CXL_PORT_SUPPORTS_256B;
             port->supported_ld_count = 3;
+            perst = cxl_dsp_get_perst(CXL_DSP(port_dev));
         } else if (usp->port == in->ports[i]) { /* USP */
             port_dev = PCI_DEVICE(usp);
             port->config_state = CXL_PORT_CONFIG_STATE_USP;
@@ -670,6 +674,7 @@ static CXLRetCode cmd_get_physical_port_state(const struct cxl_cmd *cmd,
             port->connected_device_mode = 0; /* Reserved for USP */
             port->supported_cxl_mode_bitmask = CXL_PORT_SUPPORTS_68B_VH |
                 (CXL_USP(usp)->flitmode ? CXL_PORT_SUPPORTS_256B : 0);
+            perst = &CXL_USP(usp)->perst;
         } else {
             return CXL_MBOX_INVALID_INPUT;
         }
@@ -698,6 +703,7 @@ static CXLRetCode cmd_get_physical_port_state(const struct cxl_cmd *cmd,
         /* TODO: Track down if we can get the rest of the info */
         port->ltssm_state = 0x7;
         port->first_lane_num = 0;
+        port->link_state = perst ? CXL_PORT_LINK_STATE_FLAG_PERST_ASSERTED : 0;
     }
 
     pl_size = sizeof(*out) + sizeof(*out->ports) * in->num_ports;
@@ -706,6 +712,115 @@ static CXLRetCode cmd_get_physical_port_state(const struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
+static void *bg_assertcb(void *opaque)
+{
+    CXLPhyPortPerst *perst = opaque;
+
+    /* holding reset phase for 100ms */
+    while (perst->asrt_time--) {
+        usleep(1000);
+    }
+    perst->issued_assert_perst = true;
+    return NULL;
+}
+
+static CXLRetCode cxl_deassert_perst(Object *obj, CXLPhyPortPerst *perst)
+{
+    if (!perst->issued_assert_perst) {
+        return CXL_MBOX_INTERNAL_ERROR;
+    }
+
+    QEMU_LOCK_GUARD(&perst->lock);
+    resettable_release_reset(obj, RESET_TYPE_COLD);
+    perst->issued_assert_perst = false;
+    perst->asrt_time = ASSERT_WAIT_TIME_MS;
+
+    return CXL_MBOX_SUCCESS;
+}
+
+static CXLRetCode cxl_assert_perst(Object *obj, CXLPhyPortPerst *perst)
+{
+    if (cxl_perst_asserted(perst)) {
+        return CXL_MBOX_INTERNAL_ERROR;
+    }
+
+    QEMU_LOCK_GUARD(&perst->lock);
+    resettable_assert_reset(obj, RESET_TYPE_COLD);
+    qemu_thread_create(&perst->asrt_thread, "assert_thread", bg_assertcb,
+                       perst, QEMU_THREAD_DETACHED);
+
+    return CXL_MBOX_SUCCESS;
+}
+
+static CXLDownstreamPort *cxl_find_dsp_on_bus(PCIBus *bus, uint8_t pn)
+{
+
+    PCIDevice *port_dev = pcie_find_port_by_pn(bus, pn);
+
+    if (object_dynamic_cast(OBJECT(port_dev), TYPE_CXL_DSP)) {
+        return CXL_DSP(port_dev);
+    }
+
+    return NULL;
+}
+
+/* CXL r3.2 Section 7.6.7.1.3: Get Physical Port Control (Opcode 5102h) */
+static CXLRetCode cmd_physical_port_control(const struct cxl_cmd *cmd,
+                                            uint8_t *payload_in,
+                                            size_t len_in,
+                                            uint8_t *payload_out,
+                                            size_t *len_out,
+                                            CXLCCI *cci)
+{
+   CXLUpstreamPort *pp = CXL_USP(cci->d);
+   CXLPhyPortPerst *perst;
+   PCIDevice *dev;
+
+   struct cxl_fmapi_get_physical_port_control_req_pl {
+        uint8_t ppb_id;
+        uint8_t ports_op;
+    } QEMU_PACKED *in = (void *)payload_in;
+
+    if (len_in < sizeof(*in)) {
+        return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
+    }
+
+    if (PCIE_PORT(pp)->port == in->ppb_id) {
+        dev = PCI_DEVICE(pp);
+        perst = &pp->perst;
+    } else {
+        CXLDownstreamPort *dsp =
+            cxl_find_dsp_on_bus(&PCI_BRIDGE(pp)->sec_bus, in->ppb_id);
+
+        if (!dsp) {
+            return CXL_MBOX_INVALID_INPUT;
+        }
+        dev = PCI_DEVICE(dsp);
+        perst = cxl_dsp_get_perst(dsp);
+    }
+
+    switch (in->ports_op) {
+    case 0:
+        return cxl_assert_perst(OBJECT(&dev->qdev), perst);
+    case 1:
+        return cxl_deassert_perst(OBJECT(&dev->qdev), perst);
+    case 2: {
+        if (!perst) {
+            return CXL_MBOX_INVALID_INPUT;
+        }
+
+        if (perst->issued_assert_perst ||
+            perst->asrt_time < ASSERT_WAIT_TIME_MS) {
+            return CXL_MBOX_INTERNAL_ERROR;
+        }
+        device_cold_reset(&dev->qdev);
+        return CXL_MBOX_SUCCESS;
+    }
+    default:
+        return CXL_MBOX_INVALID_INPUT;
+    }
+}
+
 /* CXL r3.1 Section 8.2.9.1.2: Background Operation Status (Opcode 0002h) */
 static CXLRetCode cmd_infostat_bg_op_sts(const struct cxl_cmd *cmd,
                                          uint8_t *payload_in,
@@ -4412,6 +4527,8 @@ static const struct cxl_cmd cxl_cmd_set_sw[256][256] = {
         cmd_identify_switch_device, 0, 0 },
     [PHYSICAL_SWITCH][GET_PHYSICAL_PORT_STATE] = { "SWITCH_PHYSICAL_PORT_STATS",
         cmd_get_physical_port_state, ~0, 0 },
+    [PHYSICAL_SWITCH][PHYSICAL_PORT_CONTROL] = { "SWITCH_PHYSICAL_PORT_CONTROL",
+        cmd_physical_port_control, 2, 0 },
     [TUNNEL][MANAGEMENT_COMMAND] = { "TUNNEL_MANAGEMENT_COMMAND",
                                      cmd_tunnel_management_cmd, ~0, 0 },
 };
@@ -4618,6 +4735,19 @@ static void cxl_rebuild_cel(CXLCCI *cci)
     }
 }
 
+void cxl_init_physical_port_control(CXLPhyPortPerst *perst)
+{
+    qemu_mutex_init(&perst->lock);
+    perst->issued_assert_perst = false;
+    /*
+     * Assert PERST involves physical port to be in
+     * hold reset phase for minimum 100ms. No other
+     * physical port control requests are entertained
+     * until Deassert PERST command.
+     */
+    perst->asrt_time = ASSERT_WAIT_TIME_MS;
+}
+
 void cxl_init_cci(CXLCCI *cci, size_t payload_max)
 {
     cci->payload_max = payload_max;
diff --git a/hw/pci-bridge/cxl_downstream.c b/hw/pci-bridge/cxl_downstream.c
index 320818a8f1ce..ec450d1aa09e 100644
--- a/hw/pci-bridge/cxl_downstream.c
+++ b/hw/pci-bridge/cxl_downstream.c
@@ -13,9 +13,11 @@
 #include "hw/pci/msi.h"
 #include "hw/pci/pcie.h"
 #include "hw/pci/pcie_port.h"
+#include "hw/pci-bridge/cxl_downstream_port.h"
 #include "hw/core/qdev-properties.h"
 #include "hw/core/qdev-properties-system.h"
 #include "hw/cxl/cxl.h"
+#include "hw/cxl/cxl_port.h"
 #include "qapi/error.h"
 
 typedef struct CXLDownstreamPort {
@@ -24,6 +26,7 @@ typedef struct CXLDownstreamPort {
 
     /*< public >*/
     CXLComponentState cxl_cstate;
+    CXLPhyPortPerst perst;
 } CXLDownstreamPort;
 
 #define CXL_DOWNSTREAM_PORT_MSI_OFFSET 0x70
@@ -81,6 +84,11 @@ static void cxl_dsp_config_write(PCIDevice *d, uint32_t address,
     cxl_dsp_dvsec_write_config(d, address, val, len);
 }
 
+CXLPhyPortPerst *cxl_dsp_get_perst(CXLDownstreamPort *dsp)
+{
+    return &dsp->perst;
+}
+
 static void cxl_dsp_reset(DeviceState *qdev)
 {
     PCIDevice *d = PCI_DEVICE(qdev);
@@ -92,6 +100,7 @@ static void cxl_dsp_reset(DeviceState *qdev)
     pci_bridge_reset(qdev);
 
     latch_registers(dsp);
+    cxl_init_physical_port_control(&dsp->perst);
 }
 
 static void build_dvsecs(PCIDevice *d, CXLComponentState *cxl)
diff --git a/hw/pci-bridge/cxl_upstream.c b/hw/pci-bridge/cxl_upstream.c
index fb8d19539c9f..b6281cbd4cb0 100644
--- a/hw/pci-bridge/cxl_upstream.c
+++ b/hw/pci-bridge/cxl_upstream.c
@@ -103,6 +103,7 @@ static void cxl_usp_reset(DeviceState *qdev)
     pcie_cap_deverr_reset(d);
     pcie_cap_fill_link_ep_usp(d, usp->width, usp->speed, usp->flitmode);
     latch_registers(usp);
+    cxl_init_physical_port_control(&usp->perst);
 }
 
 static void build_dvsecs(CXLUpstreamPort *usp)
-- 
2.51.0

