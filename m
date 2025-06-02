Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72CB224245
	for <linux-cxl@vger.kernel.org>; Mon,  2 Jun 2025 16:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748880167; cv=none; b=mGuWLr4R+KgPCkzMAXs/kCVUR/tgY40HKKMi8o+r8wFRaSHZc20C4zLCeOrkKbH3qy9ZQ1i6uVZXoVB4Fms6WSRTODyn9as7wdR9m9/7qrx4l5H9naGCelwaajWsyYAQMBrwPV5xhUPN/JW4dpXYRWr2l64MwgcyqY4oDxzD6Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748880167; c=relaxed/simple;
	bh=rCzwO4gl3eOsQA2BV6H7bR6XFiARmaMf/t0//jaWOS0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=etzV3UjFeZpyTiroBn8EFsNtaCpZKgzN+uakZ74XnP7rUfWqTsA0T0wGXvRgJu04t/VG80qr+OAwgLiD7m53dX8ASQxMAlbdn4Cf8W/uwNvzfAG7GasKhTLEvlxlsRf2pghjo+5SAKihs7bJQ4L7ExN6k7yUgp5C/TegZYYDWEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=WMBwEWyO; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="WMBwEWyO"
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250602160241epoutp012467a54f7cbecae819dc472ed112c395~FRT24Hw4V0130201302epoutp013
	for <linux-cxl@vger.kernel.org>; Mon,  2 Jun 2025 16:02:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250602160241epoutp012467a54f7cbecae819dc472ed112c395~FRT24Hw4V0130201302epoutp013
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1748880161;
	bh=66WVFSP/xSbWixQ+H6vy956pgoDJ2ku2KIszXs8JQdo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WMBwEWyOEyhvifV3H0y73RBsNyAQ34YWagEnwj4qgDL372D0HAjwyx4fYays67wPG
	 vcM9SP+GjtOYI/MV2rbJ+4CIbR4d/1gJGyMEbDMaeSUoJLfERO2J9ZMCi/lZ35TC5N
	 VWs9sLxBG+QqLoMi+wjACdnrqLZQosdZM+iH9faE=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
	20250602160241epcas5p2ce874eb79783f7be0dfc28b6726229ec~FRT2j-qGl0677206772epcas5p26;
	Mon,  2 Jun 2025 16:02:41 +0000 (GMT)
Received: from epcas5p3.samsung.com (unknown [182.195.38.181]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4b9zBm1LTlz2SSKY; Mon,  2 Jun
	2025 16:02:40 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20250602140026epcas5p131c1af3cdd05056e7dccf0f91efe490b~FPpHPViHZ0875708757epcas5p1g;
	Mon,  2 Jun 2025 14:00:26 +0000 (GMT)
Received: from test-PowerEdge-R740xd.samsungds.net (unknown [107.99.41.79])
	by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250602140024epsmtip20063cdd76dfea36f6cb14b02aa894d9e~FPpF70CZD2410424104epsmtip24;
	Mon,  2 Jun 2025 14:00:24 +0000 (GMT)
From: Arpit Kumar <arpit1.kumar@samsung.com>
To: qemu-devel@nongnu.org
Cc: gost.dev@samsung.com, linux-cxl@vger.kernel.org, nifan.cxl@gmail.com,
	dave@stgolabs.net, vishak.g@samsung.com, krish.reddy@samsung.com,
	a.manzanares@samsung.com, alok.rathore@samsung.com, Arpit Kumar
	<arpit1.kumar@samsung.com>
Subject: [PATCH 2/3] hw/cxl: Simplified Identify Switch Device & Get
 Physical Port State
Date: Mon,  2 Jun 2025 19:29:41 +0530
Message-Id: <20250602135942.2773823-3-arpit1.kumar@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250602135942.2773823-1-arpit1.kumar@samsung.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250602140026epcas5p131c1af3cdd05056e7dccf0f91efe490b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250602140026epcas5p131c1af3cdd05056e7dccf0f91efe490b
References: <20250602135942.2773823-1-arpit1.kumar@samsung.com>
	<CGME20250602140026epcas5p131c1af3cdd05056e7dccf0f91efe490b@epcas5p1.samsung.com>

Modified Identify Switch Device (Opcode 5100h)
& Get Physical Port State(Opcode 5101h)
using physical ports info stored during enumeration

Signed-off-by: Arpit Kumar <arpit1.kumar@samsung.com>
---
 hw/cxl/cxl-mailbox-utils.c | 133 +++++++------------------------------
 1 file changed, 24 insertions(+), 109 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 680055c6c0..b2fa79a721 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -558,17 +558,7 @@ static CXLRetCode cmd_set_response_msg_limit(const struct cxl_cmd *cmd,
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
-/* CXL r3.1 Section 7.6.7.1.1: Identify Switch Device (Opcode 5100h) */
+/* CXL r3.2 Section 7.6.7.1.1: Identify Switch Device (Opcode 5100h) */
 static CXLRetCode cmd_identify_switch_device(const struct cxl_cmd *cmd,
                                              uint8_t *payload_in,
                                              size_t len_in,
@@ -576,9 +566,7 @@ static CXLRetCode cmd_identify_switch_device(const struct cxl_cmd *cmd,
                                              size_t *len_out,
                                              CXLCCI *cci)
 {
-    PCIEPort *usp = PCIE_PORT(cci->d);
-    PCIBus *bus = &PCI_BRIDGE(cci->d)->sec_bus;
-    int num_phys_ports = pcie_count_ds_ports(bus);
+    int num_phys_ports = cci->pports.num_ports;
 
     struct cxl_fmapi_ident_switch_dev_resp_pl {
         uint8_t ingress_port_id;
@@ -595,11 +583,11 @@ static CXLRetCode cmd_identify_switch_device(const struct cxl_cmd *cmd,
 
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
 
@@ -611,16 +599,14 @@ static CXLRetCode cmd_identify_switch_device(const struct cxl_cmd *cmd,
         out->ingress_port_id = 0;
     }
 
-    pci_for_each_device_under_bus(bus, cxl_set_dsp_active_bm,
-                                  out->active_port_bitmask);
-    out->active_port_bitmask[usp->port / 8] |= (1 << usp->port % 8);
-
+    memcpy(out->active_port_bitmask, cci->pports.active_port_bitmask,
+           sizeof(cci->pports.active_port_bitmask));
     *len_out = sizeof(*out);
 
     return CXL_MBOX_SUCCESS;
 }
 
-/* CXL r3.1 Section 7.6.7.1.2: Get Physical Port State (Opcode 5101h) */
+/* CXL r3.2 Section 7.6.7.1.2: Get Physical Port State (Opcode 5101h) */
 static CXLRetCode cmd_get_physical_port_state(const struct cxl_cmd *cmd,
                                               uint8_t *payload_in,
                                               size_t len_in,
@@ -628,44 +614,21 @@ static CXLRetCode cmd_get_physical_port_state(const struct cxl_cmd *cmd,
                                               size_t *len_out,
                                               CXLCCI *cci)
 {
-    /* CXL r3.1 Table 7-17: Get Physical Port State Request Payload */
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
@@ -673,72 +636,24 @@ static CXLRetCode cmd_get_physical_port_state(const struct cxl_cmd *cmd,
     if (len_in < sizeof(*in)) {
         return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
     }
-    /* Check if what was requested can fit */
+
     if (sizeof(*out) + sizeof(*out->ports) * in->num_ports > cci->payload_max) {
         return CXL_MBOX_INVALID_INPUT;
     }
 
-    /* For success there should be a match for each requested */
-    out->num_ports = in->num_ports;
+    if (in->num_ports > cci->pports.num_ports) {
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
+        int pn = in->ports[i];
+        for (int j = 0; j < PCI_DEVFN_MAX; j++) {
+            if (pn == cci->pports.pport_info[j].port_id) {
+                memcpy(&out->ports[i], &(cci->pports.pport_info[pn]),
+                       sizeof(struct cxl_phy_port_info));
             }
-            port->supported_ld_count = 3;
-        } else if (usp->port == in->ports[i]) { /* USP */
-            port_dev = PCI_DEVICE(usp);
-            port->config_state = 4;
-            port->connected_device_type = 0;
-        } else {
-            return CXL_MBOX_INVALID_INPUT;
-        }
-
-        port->port_id = in->ports[i];
-        /* Information on status of this port in lnksta, lnkcap */
-        if (!port_dev->exp.exp_cap) {
-            return CXL_MBOX_INTERNAL_ERROR;
         }
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
 
     pl_size = sizeof(*out) + sizeof(*out->ports) * in->num_ports;
-- 
2.34.1

