Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC4721771B
	for <linux-cxl@vger.kernel.org>; Tue, 16 Sep 2025 08:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758010097; cv=none; b=R28CHmPAK/UoF6Pli8BobMq8gjU5KJ/h+jLiGk47rbY+6l3k40I56p7femrLjE1IESJCVEEMCV8dl+tMhW1hda1izZq9cZebgIUjVV22eA9tniiBodIS4FROWbFriJTDHWbVwQHu/w5+9I5lwOtUA7QQ4FFfRupjV2f4FBwltw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758010097; c=relaxed/simple;
	bh=B9Yog5ipfRgBUQ9TxvaBGXIzFbhk8IxHUTx0oMaCZqo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=VJXdYqg6/Spw1Mli+GrX74t5sD/JD9CpEfmKFsvTNtt1grC/lPqP+vpNvK73eGAjPk1kKalE3h/vggijtB8mmhsrspBOrnq7XP915vjyom/ma7VJkBf019I/PabQPhInE7aFnZ8TRcl63FMT1zb8PNT2ROIcG1ZzkcuO86HaScs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=uZWNkQ8G; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="uZWNkQ8G"
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250916080806epoutp017f32c781b49d05221dc4c160f41ac88b~ltNvrfh_w1024810248epoutp01C
	for <linux-cxl@vger.kernel.org>; Tue, 16 Sep 2025 08:08:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250916080806epoutp017f32c781b49d05221dc4c160f41ac88b~ltNvrfh_w1024810248epoutp01C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1758010086;
	bh=QWOr5UrRFq5V55pWbdsSMOsvZ72+MWSZXLwgvo3qiEA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uZWNkQ8GxsSdP9UhbJlzyD6BDeFtWzyN8MGEcnjt5WPqAiHSAmT1b08wBHdlYYb7h
	 eloDRX1GexPpQDk7TMFb2r+46Qm6HmvLqDl3TZREboHm2efNosekb73tD4NYQK1iU7
	 YY/3wrJvuQAeruLajrlbcwMPZ/R74ROH3dV96Mes=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
	20250916080805epcas5p447af8dcd37aef24d85e886591a82c6c5~ltNvX3cmr0272502725epcas5p4h;
	Tue, 16 Sep 2025 08:08:05 +0000 (GMT)
Received: from epcas5p3.samsung.com (unknown [182.195.38.89]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4cQvfD4tV1z3hhT7; Tue, 16 Sep
	2025 08:08:04 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20250916080803epcas5p1cd11689108b259f21908d9779993cc0f~ltNtgYl4w2550025500epcas5p1R;
	Tue, 16 Sep 2025 08:08:03 +0000 (GMT)
Received: from test-PowerEdge-R740xd.samsungds.net (unknown [107.99.41.79])
	by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250916080802epsmtip15f601a0785c74ef2f54744559cfe16c1~ltNsC6o7t1315113151epsmtip1V;
	Tue, 16 Sep 2025 08:08:02 +0000 (GMT)
From: Arpit Kumar <arpit1.kumar@samsung.com>
To: qemu-devel@nongnu.org
Cc: gost.dev@samsung.com, linux-cxl@vger.kernel.org, dave@stgolabs.net,
	Jonathan.Cameron@huawei.com, vishak.g@samsung.com, krish.reddy@samsung.com,
	a.manzanares@samsung.com, alok.rathore@samsung.com, cpgs@samsung.com, Arpit
	Kumar <arpit1.kumar@samsung.com>
Subject: [PATCH v4 1/2] hw/cxl: Refactored Identify Switch Device & Get
 Physical Port State
Date: Tue, 16 Sep 2025 13:37:35 +0530
Message-Id: <20250916080736.1266083-2-arpit1.kumar@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250916080736.1266083-1-arpit1.kumar@samsung.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250916080803epcas5p1cd11689108b259f21908d9779993cc0f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CPGSPASS: Y
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250916080803epcas5p1cd11689108b259f21908d9779993cc0f
References: <20250916080736.1266083-1-arpit1.kumar@samsung.com>
	<CGME20250916080803epcas5p1cd11689108b259f21908d9779993cc0f@epcas5p1.samsung.com>

-Storing physical ports info during enumeration.
-Refactored changes using physical ports info for
 Identify Switch Device (Opcode 5100h) & Get Physical Port State
 (Opcode 5101h) physical switch FM-API command set.

Signed-off-by: Arpit Kumar <arpit1.kumar@samsung.com>
---
 hw/cxl/cxl-mailbox-utils.c                | 229 ++++++++++++----------
 include/hw/cxl/cxl_device.h               |  67 +++++++
 include/hw/pci-bridge/cxl_upstream_port.h |   8 +
 3 files changed, 198 insertions(+), 106 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index c5177dfd92..2a104dd337 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -435,16 +435,6 @@ static CXLRetCode cmd_set_response_msg_limit(const struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
-static void cxl_set_dsp_active_bm(PCIBus *b, PCIDevice *d,
-                                  void *private)
-{
-    uint8_t *bm = private;
-    if (object_dynamic_cast(OBJECT(d), TYPE_CXL_DSP)) {
-        uint8_t port = PCIE_PORT(d)->port;
-        bm[port / 8] |= 1 << (port % 8);
-    }
-}
-
 /* CXL r3.1 Section 7.6.7.1.1: Identify Switch Device (Opcode 5100h) */
 static CXLRetCode cmd_identify_switch_device(const struct cxl_cmd *cmd,
                                              uint8_t *payload_in,
@@ -453,9 +443,8 @@ static CXLRetCode cmd_identify_switch_device(const struct cxl_cmd *cmd,
                                              size_t *len_out,
                                              CXLCCI *cci)
 {
-    PCIEPort *usp = PCIE_PORT(cci->d);
-    PCIBus *bus = &PCI_BRIDGE(cci->d)->sec_bus;
-    int num_phys_ports = pcie_count_ds_ports(bus);
+    CXLUpstreamPort *pp = CXL_USP(cci->d);
+    uint8_t num_phys_ports = pp->pports.num_ports;
 
     struct cxl_fmapi_ident_switch_dev_resp_pl {
         uint8_t ingress_port_id;
@@ -472,11 +461,11 @@ static CXLRetCode cmd_identify_switch_device(const struct cxl_cmd *cmd,
 
     out = (struct cxl_fmapi_ident_switch_dev_resp_pl *)payload_out;
     *out = (struct cxl_fmapi_ident_switch_dev_resp_pl) {
-        .num_physical_ports = num_phys_ports + 1, /* 1 USP */
+        .num_physical_ports = num_phys_ports,
         .num_vcss = 1, /* Not yet support multiple VCS - potentially tricky */
         .active_vcs_bitmask[0] = 0x1,
-        .total_vppbs = num_phys_ports + 1,
-        .bound_vppbs = num_phys_ports + 1,
+        .total_vppbs = num_phys_ports,
+        .bound_vppbs = num_phys_ports,
         .num_hdm_decoders_per_usp = 4,
     };
 
@@ -488,16 +477,14 @@ static CXLRetCode cmd_identify_switch_device(const struct cxl_cmd *cmd,
         out->ingress_port_id = 0;
     }
 
-    pci_for_each_device_under_bus(bus, cxl_set_dsp_active_bm,
-                                  out->active_port_bitmask);
-    out->active_port_bitmask[usp->port / 8] |= (1 << usp->port % 8);
-
+    memcpy(out->active_port_bitmask, pp->pports.active_port_bitmask,
+           sizeof(pp->pports.active_port_bitmask));
     *len_out = sizeof(*out);
 
     return CXL_MBOX_SUCCESS;
 }
 
-/* CXL r3.1 Section 7.6.7.1.2: Get Physical Port State (Opcode 5101h) */
+/* CXL r3.2 Section 7.6.7.1.2: Get Physical Port State (Opcode 5101h) */
 static CXLRetCode cmd_get_physical_port_state(const struct cxl_cmd *cmd,
                                               uint8_t *payload_in,
                                               size_t len_in,
@@ -505,44 +492,22 @@ static CXLRetCode cmd_get_physical_port_state(const struct cxl_cmd *cmd,
                                               size_t *len_out,
                                               CXLCCI *cci)
 {
-    /* CXL r3.1 Table 7-17: Get Physical Port State Request Payload */
+    CXLUpstreamPort *pp = CXL_USP(cci->d);
+    size_t pl_size;
+    int i;
+
+    /* CXL r3.2 Table 7-17: Get Physical Port State Request Payload */
     struct cxl_fmapi_get_phys_port_state_req_pl {
         uint8_t num_ports;
         uint8_t ports[];
     } QEMU_PACKED *in;
 
-    /*
-     * CXL r3.1 Table 7-19: Get Physical Port State Port Information Block
-     * Format
-     */
-    struct cxl_fmapi_port_state_info_block {
-        uint8_t port_id;
-        uint8_t config_state;
-        uint8_t connected_device_cxl_version;
-        uint8_t rsv1;
-        uint8_t connected_device_type;
-        uint8_t port_cxl_version_bitmask;
-        uint8_t max_link_width;
-        uint8_t negotiated_link_width;
-        uint8_t supported_link_speeds_vector;
-        uint8_t max_link_speed;
-        uint8_t current_link_speed;
-        uint8_t ltssm_state;
-        uint8_t first_lane_num;
-        uint16_t link_state;
-        uint8_t supported_ld_count;
-    } QEMU_PACKED;
-
-    /* CXL r3.1 Table 7-18: Get Physical Port State Response Payload */
+    /* CXL r3.2 Table 7-18: Get Physical Port State Response Payload */
     struct cxl_fmapi_get_phys_port_state_resp_pl {
         uint8_t num_ports;
         uint8_t rsv1[3];
-        struct cxl_fmapi_port_state_info_block ports[];
+        CXLPhyPortInfo ports[];
     } QEMU_PACKED *out;
-    PCIBus *bus = &PCI_BRIDGE(cci->d)->sec_bus;
-    PCIEPort *usp = PCIE_PORT(cci->d);
-    size_t pl_size;
-    int i;
 
     in = (struct cxl_fmapi_get_phys_port_state_req_pl *)payload_in;
     out = (struct cxl_fmapi_get_phys_port_state_resp_pl *)payload_out;
@@ -555,69 +520,21 @@ static CXLRetCode cmd_get_physical_port_state(const struct cxl_cmd *cmd,
         return CXL_MBOX_INVALID_INPUT;
     }
 
-    /* For success there should be a match for each requested */
-    out->num_ports = in->num_ports;
+    if (in->num_ports > pp->pports.num_ports) {
+        return CXL_MBOX_INVALID_INPUT;
+    }
 
     for (i = 0; i < in->num_ports; i++) {
-        struct cxl_fmapi_port_state_info_block *port;
-        /* First try to match on downstream port */
-        PCIDevice *port_dev;
-        uint16_t lnkcap, lnkcap2, lnksta;
-
-        port = &out->ports[i];
+        int pn = in->ports[i];
 
-        port_dev = pcie_find_port_by_pn(bus, in->ports[i]);
-        if (port_dev) { /* DSP */
-            PCIDevice *ds_dev = pci_bridge_get_sec_bus(PCI_BRIDGE(port_dev))
-                ->devices[0];
-            port->config_state = 3;
-            if (ds_dev) {
-                if (object_dynamic_cast(OBJECT(ds_dev), TYPE_CXL_TYPE3)) {
-                    port->connected_device_type = 5; /* Assume MLD for now */
-                } else {
-                    port->connected_device_type = 1;
-                }
-            } else {
-                port->connected_device_type = 0;
-            }
-            port->supported_ld_count = 3;
-        } else if (usp->port == in->ports[i]) { /* USP */
-            port_dev = PCI_DEVICE(usp);
-            port->config_state = 4;
-            port->connected_device_type = 0;
-        } else {
+        if (pp->pports.pport_info[pn].port_id != pn) {
             return CXL_MBOX_INVALID_INPUT;
         }
-
-        port->port_id = in->ports[i];
-        /* Information on status of this port in lnksta, lnkcap */
-        if (!port_dev->exp.exp_cap) {
-            return CXL_MBOX_INTERNAL_ERROR;
-        }
-        lnksta = port_dev->config_read(port_dev,
-                                       port_dev->exp.exp_cap + PCI_EXP_LNKSTA,
-                                       sizeof(lnksta));
-        lnkcap = port_dev->config_read(port_dev,
-                                       port_dev->exp.exp_cap + PCI_EXP_LNKCAP,
-                                       sizeof(lnkcap));
-        lnkcap2 = port_dev->config_read(port_dev,
-                                        port_dev->exp.exp_cap + PCI_EXP_LNKCAP2,
-                                        sizeof(lnkcap2));
-
-        port->max_link_width = (lnkcap & PCI_EXP_LNKCAP_MLW) >> 4;
-        port->negotiated_link_width = (lnksta & PCI_EXP_LNKSTA_NLW) >> 4;
-        /* No definition for SLS field in linux/pci_regs.h */
-        port->supported_link_speeds_vector = (lnkcap2 & 0xFE) >> 1;
-        port->max_link_speed = lnkcap & PCI_EXP_LNKCAP_SLS;
-        port->current_link_speed = lnksta & PCI_EXP_LNKSTA_CLS;
-        /* TODO: Track down if we can get the rest of the info */
-        port->ltssm_state = 0x7;
-        port->first_lane_num = 0;
-        port->link_state = 0;
-        port->port_cxl_version_bitmask = 0x2;
-        port->connected_device_cxl_version = 0x2;
+        memcpy(&out->ports[i], &(pp->pports.pport_info[pn]),
+               sizeof(CXLPhyPortInfo));
     }
 
+    out->num_ports = in->num_ports;
     pl_size = sizeof(*out) + sizeof(*out->ports) * in->num_ports;
     *len_out = pl_size;
 
@@ -4684,6 +4601,104 @@ void cxl_add_cci_commands(CXLCCI *cci, const struct cxl_cmd (*cxl_cmd_set)[256],
     cxl_rebuild_cel(cci);
 }
 
+static CXLRetCode cxl_set_port_type(CXLUpstreamPort *ports, int pnum,
+                                    CXLCCI *cci)
+{
+    uint8_t current_port_config_state;
+    uint8_t connected_device_type;
+    uint8_t supported_ld_count;
+    uint16_t lnkcap, lnkcap2, lnksta;
+    PCIBus *bus;
+    PCIDevice *port_dev;
+    PCIEPort *usp = PCIE_PORT(cci->d);
+
+    if (usp->port == pnum) {
+        port_dev = PCI_DEVICE(usp);
+        current_port_config_state = CXL_PORT_CONFIG_STATE_USP;
+        connected_device_type = CXL_PORT_CONNECTED_DEV_TYPE_NONE;
+        supported_ld_count = 0;
+    } else {
+        bus = &PCI_BRIDGE(cci->d)->sec_bus;
+        port_dev = pcie_find_port_by_pn(bus, pnum);
+        if (port_dev) { /* DSP */
+            PCIDevice *ds_dev = pci_bridge_get_sec_bus(PCI_BRIDGE(port_dev))
+                ->devices[0];
+            current_port_config_state = CXL_PORT_CONFIG_STATE_DSP;
+            if (ds_dev) {
+                if (object_dynamic_cast(OBJECT(ds_dev), TYPE_CXL_TYPE3)) {
+                    /* To-do: controllable */
+                    connected_device_type = CXL_PORT_CONNECTED_DEV_TYPE_3_SLD;
+                } else {
+                    connected_device_type = CXL_PORT_CONNECTED_DEV_TYPE_PCIE;
+                }
+            } else {
+                connected_device_type = CXL_PORT_CONNECTED_DEV_TYPE_NONE;
+            }
+            supported_ld_count = 3;
+        } else {
+            return CXL_MBOX_INVALID_INPUT;
+        }
+    }
+
+    if (!port_dev->exp.exp_cap) {
+        return CXL_MBOX_INTERNAL_ERROR;
+    }
+    lnksta = port_dev->config_read(port_dev,
+                                   port_dev->exp.exp_cap + PCI_EXP_LNKSTA,
+                                   sizeof(lnksta));
+    lnkcap = port_dev->config_read(port_dev,
+                                   port_dev->exp.exp_cap + PCI_EXP_LNKCAP,
+                                   sizeof(lnkcap));
+    lnkcap2 = port_dev->config_read(port_dev,
+                                    port_dev->exp.exp_cap + PCI_EXP_LNKCAP2,
+                                    sizeof(lnkcap2));
+
+    ports->pports.pport_info[pnum] = (CXLPhyPortInfo) {
+        .port_id = pnum,
+        .current_port_config_state = current_port_config_state,
+        .connected_device_mode = CXL_PORT_CONNECTED_DEV_MODE_256B,
+        .connected_device_type = connected_device_type,
+        .supported_cxl_modes = CXL_PORT_SUPPORTS_256B,
+        .max_link_width = (lnkcap & PCI_EXP_LNKCAP_MLW) >> 4,
+        .negotiated_link_width = (lnksta & PCI_EXP_LNKSTA_NLW) >> 4,
+        .supported_link_speeds_vector = (lnkcap2 & 0xFE) >> 1,
+        .max_link_speed = lnkcap & PCI_EXP_LNKCAP_SLS,
+        .current_link_speed = lnksta & PCI_EXP_LNKSTA_CLS,
+        .ltssm_state = CXL_PORT_LTSSM_L2,
+        .first_negotiated_lane_num = 0,
+        .link_state_flags = 0,
+        .supported_ld_count = supported_ld_count,
+    };
+    ports->pports.active_port_bitmask[pnum / 8] |= (1 << pnum % 8);
+
+    return CXL_MBOX_SUCCESS;
+}
+
+static void cxl_set_dsp_port(PCIBus *bus, PCIDevice *dev, void *opaque)
+{
+    CXLCCI *cci = opaque;
+    CXLUpstreamPort *pp = CXL_USP(cci->d);
+
+    if (object_dynamic_cast(OBJECT(dev), TYPE_CXL_DSP)) {
+        cxl_set_port_type(pp, PCIE_PORT(dev)->port, cci);
+    }
+}
+
+static CXLRetCode cxl_set_phy_port_info(CXLCCI *cci)
+{
+    PCIEPort *usp = PCIE_PORT(cci->d);
+    PCIBus *bus = &PCI_BRIDGE(cci->d)->sec_bus;
+    CXLUpstreamPort *pp = CXL_USP(cci->d);
+    uint8_t num_phys_ports = pcie_count_ds_ports(bus) + 1;
+    uint8_t phy_port_num = usp->port;
+
+    pp->pports.num_ports = num_phys_ports;
+    cxl_set_port_type(pp, phy_port_num, cci); /* USP */
+    pci_for_each_device_under_bus(bus, cxl_set_dsp_port, cci); /* DSP */
+
+    return CXL_MBOX_SUCCESS;
+}
+
 void cxl_initialize_mailbox_swcci(CXLCCI *cci, DeviceState *intf,
                                   DeviceState *d, size_t payload_max)
 {
@@ -4691,6 +4706,7 @@ void cxl_initialize_mailbox_swcci(CXLCCI *cci, DeviceState *intf,
     cci->d = d;
     cci->intf = intf;
     cxl_init_cci(cci, payload_max);
+    cxl_set_phy_port_info(cci);
 }
 
 void cxl_initialize_mailbox_t3(CXLCCI *cci, DeviceState *d, size_t payload_max)
@@ -4777,4 +4793,5 @@ void cxl_initialize_usp_mctpcci(CXLCCI *cci, DeviceState *d, DeviceState *intf,
     cci->d = d;
     cci->intf = intf;
     cxl_init_cci(cci, payload_max);
+    cxl_set_phy_port_info(cci);
 }
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 068c20d61e..536d465f42 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -129,6 +129,73 @@
                   CXL_NUM_CPMU_INSTANCES * (1 << 16),                   \
                   (1 << 16))
 
+#define CXL_MAX_PHY_PORTS 256
+
+/* CXL r3.2 Table 7-19: Get Physical Port State Port Information Block Format */
+#define CXL_PORT_CONFIG_STATE_DISABLED           0x0
+#define CXL_PORT_CONFIG_STATE_BIND_IN_PROGRESS   0x1
+#define CXL_PORT_CONFIG_STATE_UNBIND_IN_PROGRESS 0x2
+#define CXL_PORT_CONFIG_STATE_DSP                0x3
+#define CXL_PORT_CONFIG_STATE_USP                0x4
+#define CXL_PORT_CONFIG_STATE_FABRIC_PORT        0x5
+#define CXL_PORT_CONFIG_STATE_INVALID_PORT_ID    0xF
+
+#define CXL_PORT_CONNECTED_DEV_MODE_NOT_CXL_OR_DISCONN 0x00
+#define CXL_PORT_CONNECTED_DEV_MODE_RCD                0x01
+#define CXL_PORT_CONNECTED_DEV_MODE_68B_VH             0x02
+#define CXL_PORT_CONNECTED_DEV_MODE_256B               0x03
+#define CXL_PORT_CONNECTED_DEV_MODE_LO_256B            0x04
+#define CXL_PORT_CONNECTED_DEV_MODE_PBR                0x05
+
+#define CXL_PORT_CONNECTED_DEV_TYPE_NONE            0x00
+#define CXL_PORT_CONNECTED_DEV_TYPE_PCIE            0x01
+#define CXL_PORT_CONNECTED_DEV_TYPE_1               0x02
+#define CXL_PORT_CONNECTED_DEV_TYPE_2_OR_HBR_SWITCH 0x03
+#define CXL_PORT_CONNECTED_DEV_TYPE_3_SLD           0x04
+#define CXL_PORT_CONNECTED_DEV_TYPE_3_MLD           0x05
+#define CXL_PORT_CONNECTED_DEV_PBR_COMPONENT        0x06
+
+#define CXL_PORT_SUPPORTS_RCD        BIT(0)
+#define CXL_PORT_SUPPORTS_68B_VH     BIT(1)
+#define CXL_PORT_SUPPORTS_256B       BIT(2)
+#define CXL_PORT_SUPPORTS_LO_256B    BIT(3)
+#define CXL_PORT_SUPPORTS_PBR        BIT(4)
+
+#define CXL_PORT_LTSSM_DETECT        0x00
+#define CXL_PORT_LTSSM_POLLING       0x01
+#define CXL_PORT_LTSSM_CONFIGURATION 0x02
+#define CXL_PORT_LTSSM_RECOVERY      0x03
+#define CXL_PORT_LTSSM_L0            0x04
+#define CXL_PORT_LTSSM_L0S           0x05
+#define CXL_PORT_LTSSM_L1            0x06
+#define CXL_PORT_LTSSM_L2            0x07
+#define CXL_PORT_LTSSM_DISABLED      0x08
+#define CXL_PORT_LTSSM_LOOPBACK      0x09
+#define CXL_PORT_LTSSM_HOT_RESET     0x0A
+
+#define CXL_PORT_LINK_STATE_FLAG_LANE_REVERSED    BIT(0)
+#define CXL_PORT_LINK_STATE_FLAG_PERST_ASSERTED   BIT(1)
+#define CXL_PORT_LINK_STATE_FLAG_PRSNT            BIT(2)
+#define CXL_PORT_LINK_STATE_FLAG_POWER_OFF        BIT(3)
+
+typedef struct CXLPhyPortInfo {
+    uint8_t port_id;
+    uint8_t current_port_config_state;
+    uint8_t connected_device_mode;
+    uint8_t rsv1;
+    uint8_t connected_device_type;
+    uint8_t supported_cxl_modes;
+    uint8_t max_link_width;
+    uint8_t negotiated_link_width;
+    uint8_t supported_link_speeds_vector;
+    uint8_t max_link_speed;
+    uint8_t current_link_speed;
+    uint8_t ltssm_state;
+    uint8_t first_negotiated_lane_num;
+    uint16_t link_state_flags;
+    uint8_t supported_ld_count;
+} QEMU_PACKED CXLPhyPortInfo;
+
 /* CXL r3.1 Table 8-34: Command Return Codes */
 typedef enum {
     CXL_MBOX_SUCCESS = 0x0,
diff --git a/include/hw/pci-bridge/cxl_upstream_port.h b/include/hw/pci-bridge/cxl_upstream_port.h
index db1dfb6afd..c6218100a2 100644
--- a/include/hw/pci-bridge/cxl_upstream_port.h
+++ b/include/hw/pci-bridge/cxl_upstream_port.h
@@ -4,6 +4,7 @@
 #include "hw/pci/pcie.h"
 #include "hw/pci/pcie_port.h"
 #include "hw/cxl/cxl.h"
+#include "include/hw/cxl/cxl_device.h"
 
 typedef struct CXLUpstreamPort {
     /*< private >*/
@@ -23,6 +24,13 @@ typedef struct CXLUpstreamPort {
 
     DOECap doe_cdat;
     uint64_t sn;
+
+    /* physical ports information */
+    struct {
+        uint8_t num_ports;
+        uint8_t active_port_bitmask[CXL_MAX_PHY_PORTS / BITS_PER_BYTE];
+        CXLPhyPortInfo pport_info[CXL_MAX_PHY_PORTS];
+    } pports;
 } CXLUpstreamPort;
 
 #endif /* CXL_SUP_H */
-- 
2.34.1

