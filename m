Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6100D134A8
	for <linux-cxl@vger.kernel.org>; Mon, 14 Jul 2025 13:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752498260; cv=none; b=Bm/R+YtlfOCqT3byww1y3DUnKy15buDYMa3/TYUf8CmE/TsWSl7LkfHyQHdqk3Y7+xn7WXzIKlB8RB+hGGbiiM8o+n42+3afG+KTjDPy0AeeEpWbeWsTa3jVKCm2AcPjD83mOqdzdB8w2ZPrG7BIpjwMfogsfG27dXS1NS90WsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752498260; c=relaxed/simple;
	bh=VnLckDsNprmQRURJKIsXsYnnnA8nlh5sX/dpFGoiFbE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=HYR8m7HvyDY+3uhFg3kcLVjW8ptfDUe/p5SIus+TDg3OEZ3lbkWTYxasjJqLUQU2yvKCEOHHJVPpJVDBvpbSgclYhaU8yiABZdBQAH6N0EEU8FiE396QnwEsNlU+K6R8tVA09fJbjGKlVIbvAGHpsCH9AJriBZpXofJHVKgFJ+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=kx2k9/QY; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="kx2k9/QY"
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250714130414epoutp04343d0896d4b8b129cf0018f3b996ccda~SH_CPhCkd2815628156epoutp04J
	for <linux-cxl@vger.kernel.org>; Mon, 14 Jul 2025 13:04:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250714130414epoutp04343d0896d4b8b129cf0018f3b996ccda~SH_CPhCkd2815628156epoutp04J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1752498254;
	bh=wexRdYSX/POQW9r6xMlSyrNroYododbW5ywT6p75eSM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kx2k9/QYRxH1akQiK5bspsHQFnC3vdakMwTeLldNGMVZyawjYoagTEQAZUAnl7nFo
	 0mPTxKRNKpIPjQn/JtxqBLASLDbxlpa2FhQI03P/0aNusLyeV02RkVdXFj8om5uzyF
	 VZpu/afiCa5o0+54niAjMT3t8+VlhbFb121U62FQ=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20250714130413epcas5p3c9658886c4882a8288d1674da0faf1f5~SH_BsMRdY1237812378epcas5p3B;
	Mon, 14 Jul 2025 13:04:13 +0000 (GMT)
Received: from epcas5p3.samsung.com (unknown [182.195.38.86]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4bgjFS4MJjz6B9m7; Mon, 14 Jul
	2025 13:04:12 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20250710144354epcas5p46a083b743de04f5849e3449a4d9dfe87~Q6v6P-SHF2443524435epcas5p4X;
	Thu, 10 Jul 2025 14:43:54 +0000 (GMT)
Received: from test-PowerEdge-R740xd.samsungds.net (unknown [107.99.41.79])
	by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250710144352epsmtip2d2b7c309f9ebe305bc4e3f4830473cf5~Q6v4uYMAP1607016070epsmtip20;
	Thu, 10 Jul 2025 14:43:52 +0000 (GMT)
From: Arpit Kumar <arpit1.kumar@samsung.com>
To: qemu-devel@nongnu.org
Cc: gost.dev@samsung.com, linux-cxl@vger.kernel.org, nifan.cxl@gmail.com,
	dave@stgolabs.net, Jonathan.Cameron@huawei.com, vishak.g@samsung.com,
	krish.reddy@samsung.com, a.manzanares@samsung.com, alok.rathore@samsung.com,
	cpgs@samsung.com, Arpit Kumar <arpit1.kumar@samsung.com>
Subject: [PATCH v2 1/2] hw/cxl: Refactored Identify Switch Device & Get
 Physical Port State
Date: Thu, 10 Jul 2025 20:13:37 +0530
Message-Id: <20250710144338.2839512-2-arpit1.kumar@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250710144338.2839512-1-arpit1.kumar@samsung.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250710144354epcas5p46a083b743de04f5849e3449a4d9dfe87
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CPGSPASS: Y
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250710144354epcas5p46a083b743de04f5849e3449a4d9dfe87
References: <20250710144338.2839512-1-arpit1.kumar@samsung.com>
	<CGME20250710144354epcas5p46a083b743de04f5849e3449a4d9dfe87@epcas5p4.samsung.com>

-Storing physical ports info during enumeration.
-Refactored changes using physical ports info for
 Identify Switch Device (Opcode 5100h) & Get Physical Port State
 (Opcode 5101h) physical switch FM-API command set.

Signed-off-by: Arpit Kumar <arpit1.kumar@samsung.com>
---
 hw/cxl/cxl-mailbox-utils.c                | 229 ++++++++++++----------
 include/hw/cxl/cxl_device.h               |  82 ++++++++
 include/hw/pci-bridge/cxl_upstream_port.h |   4 +
 3 files changed, 207 insertions(+), 108 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index a02d130926..c4e83fb2aa 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -500,16 +500,6 @@ static CXLRetCode cmd_set_response_msg_limit(const struct cxl_cmd *cmd,
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
@@ -518,9 +508,8 @@ static CXLRetCode cmd_identify_switch_device(const struct cxl_cmd *cmd,
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
@@ -537,11 +526,11 @@ static CXLRetCode cmd_identify_switch_device(const struct cxl_cmd *cmd,
 
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
 
@@ -553,16 +542,14 @@ static CXLRetCode cmd_identify_switch_device(const struct cxl_cmd *cmd,
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
@@ -570,44 +557,22 @@ static CXLRetCode cmd_get_physical_port_state(const struct cxl_cmd *cmd,
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
+        struct cxl_phy_port_info ports[];
     } QEMU_PACKED *out;
-    PCIBus *bus = &PCI_BRIDGE(cci->d)->sec_bus;
-    PCIEPort *usp = PCIE_PORT(cci->d);
-    size_t pl_size;
-    int i;
 
     in = (struct cxl_fmapi_get_phys_port_state_req_pl *)payload_in;
     out = (struct cxl_fmapi_get_phys_port_state_resp_pl *)payload_out;
@@ -620,69 +585,20 @@ static CXLRetCode cmd_get_physical_port_state(const struct cxl_cmd *cmd,
         return CXL_MBOX_INVALID_INPUT;
     }
 
-    /* For success there should be a match for each requested */
-    out->num_ports = in->num_ports;
+    if (in->num_ports > pp->pports.num_ports) {
+        return CXL_MBOX_INVALID_INPUT;
+    }
 
+    out->num_ports = in->num_ports;
     for (i = 0; i < in->num_ports; i++) {
-        struct cxl_fmapi_port_state_info_block *port;
-        /* First try to match on downstream port */
-        PCIDevice *port_dev;
-        uint16_t lnkcap, lnkcap2, lnksta;
-
-        port = &out->ports[i];
-
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
+        int pn = in->ports[i];
+        if (pp->pports.pport_info[pn].port_id != pn) {
             return CXL_MBOX_INVALID_INPUT;
+        } else {
+            memcpy(&out->ports[i], &(pp->pports.pport_info[pn]),
+                   sizeof(struct cxl_phy_port_info));
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
     }
-
     pl_size = sizeof(*out) + sizeof(*out->ports) * in->num_ports;
     *len_out = pl_size;
 
@@ -3686,6 +3602,101 @@ void cxl_add_cci_commands(CXLCCI *cci, const struct cxl_cmd (*cxl_cmd_set)[256],
     cxl_rebuild_cel(cci);
 }
 
+static CXLRetCode cxl_set_port_type(CXLUpstreamPort *ports, int pnum,
+                                    CXLCCI *cci)
+{
+    uint16_t lnkcap, lnkcap2, lnksta;
+    PCIBus *bus;
+    PCIDevice *port_dev;
+    PCIEPort *usp = PCIE_PORT(cci->d);
+
+    if (usp->port == pnum) {
+        port_dev = PCI_DEVICE(usp);
+        ports->pports.pport_info[pnum].current_port_config_state =
+            CXL_PORT_CONFIG_STATE_USP;
+        ports->pports.pport_info[pnum].connected_device_type = NO_DEVICE_DETECTED;
+    } else {
+        bus = &PCI_BRIDGE(cci->d)->sec_bus;
+        port_dev = pcie_find_port_by_pn(bus, pnum);
+        if (port_dev) { /* DSP */
+            PCIDevice *ds_dev = pci_bridge_get_sec_bus(PCI_BRIDGE(port_dev))
+                ->devices[0];
+            ports->pports.pport_info[pnum].current_port_config_state =
+               CXL_PORT_CONFIG_STATE_DSP;
+            if (ds_dev) {
+                if (object_dynamic_cast(OBJECT(ds_dev), TYPE_CXL_TYPE3)) {
+                    /* To-do: controllable */
+                    ports->pports.pport_info[pnum].connected_device_type =
+                        CXL_TYPE_3_SLD;
+                } else {
+                    ports->pports.pport_info[pnum].connected_device_type = PCIE_DEVICE;
+                }
+            } else {
+                ports->pports.pport_info[pnum].connected_device_type = NO_DEVICE_DETECTED;
+            }
+            ports->pports.pport_info[pnum].supported_ld_count = 3;
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
+    ports->pports.pport_info[pnum].max_link_width = (lnkcap & PCI_EXP_LNKCAP_MLW) >> 4;
+    ports->pports.pport_info[pnum].negotiated_link_width =
+        (lnksta & PCI_EXP_LNKSTA_NLW) >> 4;
+    ports->pports.pport_info[pnum].supported_link_speeds_vector = (lnkcap2 & 0xFE) >> 1;
+    ports->pports.pport_info[pnum].max_link_speed = lnkcap & PCI_EXP_LNKCAP_SLS;
+    ports->pports.pport_info[pnum].current_link_speed = lnksta & PCI_EXP_LNKSTA_CLS;
+
+    ports->pports.pport_info[pnum].port_id = pnum;
+    ports->pports.active_port_bitmask[pnum / 8] |= (1 << pnum % 8);
+    ports->pports.pport_info[pnum].ltssm_state = LTSSM_L2;
+    ports->pports.pport_info[pnum].first_negotiated_lane_num = 0;
+    ports->pports.pport_info[pnum].link_state_flags = 0;
+    ports->pports.pport_info[pnum].supported_cxl_modes = CXL_256B_FLIT_CAPABLE;
+    ports->pports.pport_info[pnum].connected_device_mode = STANDARD_256B_FLIT_MODE;
+
+    return CXL_MBOX_SUCCESS;
+}
+
+static void cxl_set_dsp_port(PCIBus *bus, PCIDevice *dev, void *opaque)
+{
+    CXLCCI *cci = (CXLCCI *)opaque;
+    CXLUpstreamPort *pp = CXL_USP(cci->d);
+
+    if (object_dynamic_cast(OBJECT(dev), TYPE_CXL_DSP)) {
+        uint8_t phy_port_num = PCIE_PORT(dev)->port;
+        cxl_set_port_type(pp, phy_port_num, cci);
+    }
+}
+
+static CXLRetCode cxl_set_phy_port_info(CXLCCI *cci)
+{
+    PCIEPort *usp = PCIE_PORT(cci->d);
+    PCIBus *bus = &PCI_BRIDGE(cci->d)->sec_bus;
+    CXLUpstreamPort *pp = CXL_USP(cci->d);
+    int num_phys_ports = pcie_count_ds_ports(bus) + 1;
+    pp->pports.num_ports = num_phys_ports;
+    uint8_t phy_port_num =  usp->port;
+
+    cxl_set_port_type(pp, phy_port_num, cci); /* USP */
+    pci_for_each_device_under_bus(bus, cxl_set_dsp_port, cci); /* DSP */
+
+    return CXL_MBOX_SUCCESS;
+}
+
 void cxl_initialize_mailbox_swcci(CXLCCI *cci, DeviceState *intf,
                                   DeviceState *d, size_t payload_max)
 {
@@ -3693,6 +3704,7 @@ void cxl_initialize_mailbox_swcci(CXLCCI *cci, DeviceState *intf,
     cci->d = d;
     cci->intf = intf;
     cxl_init_cci(cci, payload_max);
+    cxl_set_phy_port_info(cci);
 }
 
 void cxl_initialize_mailbox_t3(CXLCCI *cci, DeviceState *d, size_t payload_max)
@@ -3797,4 +3809,5 @@ void cxl_initialize_usp_mctpcci(CXLCCI *cci, DeviceState *d, DeviceState *intf,
     cci->d = d;
     cci->intf = intf;
     cxl_init_cci(cci, payload_max);
+    cxl_set_phy_port_info(cci);
 }
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index ca515cab13..1fa6cf7536 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -127,6 +127,88 @@
                   CXL_NUM_CHMU_INSTANCES * (1 << 16),                   \
                   (1 << 16))
 
+#define CXL_MAX_PHY_PORTS 256
+
+#define LINK_STATE_FLAG_LANE_REVERSED    BIT(0)
+#define LINK_STATE_FLAG_PERST_ASSERTED   BIT(1)
+#define LINK_STATE_FLAG_PRSNT            BIT(2)
+#define LINK_STATE_FLAG_POWER_OFF        BIT(3)
+
+/* physical port control info - CXL r3.2 table 7-19 */
+#define CXL_PORT_CONFIG_STATE_DISABLED           0x0
+#define CXL_PORT_CONFIG_STATE_BIND_IN_PROGRESS   0x1
+#define CXL_PORT_CONFIG_STATE_UNBIND_IN_PROGRESS 0x2
+#define CXL_PORT_CONFIG_STATE_DSP                0x3
+#define CXL_PORT_CONFIG_STATE_USP                0x4
+#define CXL_PORT_CONFIG_STATE_FABRIC_PORT        0x5
+#define CXL_PORT_CONFIG_STATE_INVALID_PORT_ID    0xF
+
+typedef enum {
+    NOT_CXL_OR_DISCONNECTED = 0x00,
+    RCD_MODE = 0x01,
+    CXL_68B_FLIT_AND_VH_MODE = 0x02,
+    STANDARD_256B_FLIT_MODE = 0x03,
+    CXL_LATENCY_OPTIMIZED_256B_FLIT_MODE = 0x04,
+    PBR_MODE = 0x05
+} connected_device_mode;
+
+typedef enum {
+    NO_DEVICE_DETECTED = 0,
+    PCIE_DEVICE = 1,
+    CXL_TYPE_1_DEVICE = 2,
+    CXL_TYPE_2_DEVICE_OR_HBR_SWITCH = 3,
+    CXL_TYPE_3_SLD = 4,
+    CXL_TYPE_3_MLD = 5,
+    PBR_COMPONENT = 6
+} connected_device_type;
+
+typedef enum {
+    CXL_RCD_MODE = 0x00,
+    CXL_68B_FLIT_AND_VH_CAPABLE = 0x01,
+    CXL_256B_FLIT_CAPABLE = 0x02,
+    CXL_LATENCY_OPTIMIZED_256B_FLIT = 0x03,
+    CXL_PBR_CAPABLE = 0x04
+} supported_cxl_modes;
+
+typedef enum {
+    LTSSM_DETECT = 0x00,
+    LTSSM_POLLING = 0x01,
+    LTSSM_CONFIGURATION = 0x02,
+    LTSSM_RECOVERY = 0x03,
+    LTSSM_L0 = 0x04,
+    LTSSM_L0S = 0x05,
+    LTSSM_L1 = 0x06,
+    LTSSM_L2 = 0x07,
+    LTSSM_DISABLED = 0x08,
+    LTSSM_LOOPBACK = 0x09,
+    LTSSM_HOT_RESET = 0x0A
+} LTSSM_State;
+
+/* CXL r3.2 Table 7-19: Port Info */
+struct cxl_phy_port_info {
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
+} QEMU_PACKED;
+
+struct phy_port {
+    uint8_t num_ports;
+    uint8_t active_port_bitmask[0x20];
+    struct cxl_phy_port_info pport_info[CXL_MAX_PHY_PORTS];
+};
+
 /* CXL r3.1 Table 8-34: Command Return Codes */
 typedef enum {
     CXL_MBOX_SUCCESS = 0x0,
diff --git a/include/hw/pci-bridge/cxl_upstream_port.h b/include/hw/pci-bridge/cxl_upstream_port.h
index db1dfb6afd..bcd3002cf8 100644
--- a/include/hw/pci-bridge/cxl_upstream_port.h
+++ b/include/hw/pci-bridge/cxl_upstream_port.h
@@ -4,6 +4,7 @@
 #include "hw/pci/pcie.h"
 #include "hw/pci/pcie_port.h"
 #include "hw/cxl/cxl.h"
+#include "include/hw/cxl/cxl_device.h"
 
 typedef struct CXLUpstreamPort {
     /*< private >*/
@@ -23,6 +24,9 @@ typedef struct CXLUpstreamPort {
 
     DOECap doe_cdat;
     uint64_t sn;
+
+    /*< physical ports information >*/
+    struct phy_port pports;
 } CXLUpstreamPort;
 
 #endif /* CXL_SUP_H */
-- 
2.34.1

