Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1AD22C326D
	for <linux-cxl@vger.kernel.org>; Mon,  2 Jun 2025 16:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748880741; cv=none; b=UeUaUz5O57srnnTPby5jvuVQKBmdxc1jEu0xlZBoQIXmb7cLFgqMVbKFDMGMUSwqkZlgn21vZwraSJ5pRnVuIgt0D1LUVQAi6N0htaWR9ebLUcr49Y20YYGzFiq1bCqXJ8aK9Vn7tM8zqiJYse3uTCNehtUW3gmhLj4foeNywkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748880741; c=relaxed/simple;
	bh=AGxkB/CLHAP5al/D9EBNAmqc4tMwel/0hS85iCfFK2Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=BIp2Thx5TSBo5CYPxwLTrZOSCYebxgyZ87TdIWa+ycoqJBHjj6eirhBOkDyy/dFIYeya7hzXUjX3tKV+Q78/FzzEYzR4/6a8ufD6oo8xPER5HWKXN9tC3i1+EQfUVs/o8YHddjOrUke7zh71cprcI612FrC4IXj5BTTgBxcGhfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=VllU8F+O; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="VllU8F+O"
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250602160233epoutp04dfc169ef66a81f8425ef724679440274~FRTu7nsL52231122311epoutp04I
	for <linux-cxl@vger.kernel.org>; Mon,  2 Jun 2025 16:02:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250602160233epoutp04dfc169ef66a81f8425ef724679440274~FRTu7nsL52231122311epoutp04I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1748880153;
	bh=gNt1A+G1hcdy1aQffIAfDZUX8n3iMKGTaux7QVLHRYE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VllU8F+OSZVA+ORS9YvDRLebNGKcWGU7wVT4RXchyDXRjf1Bg/g+wBW5cgqkieT1Y
	 DnSGCoMI3tSy2K4M0aaTWaScJkIIEwmnQUpnkRweMK3PIaKqg3HMDL/2RQ2tVjzIum
	 Hx3eWS3suxjVW8FIcTlLF979Yx+NNzM98cZ6aBw0=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
	20250602160232epcas5p1a7607190e157d50242c3ef904976c98f~FRTuEtOOj1466514665epcas5p1N;
	Mon,  2 Jun 2025 16:02:32 +0000 (GMT)
Received: from epcas5p2.samsung.com (unknown [182.195.38.177]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4b9zBZ71bwz3hhTB; Mon,  2 Jun
	2025 16:02:30 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20250602140018epcas5p2de38473dfcc0369193dd826c6e0e3fac~FPpAQUhSw1197711977epcas5p2T;
	Mon,  2 Jun 2025 14:00:18 +0000 (GMT)
Received: from test-PowerEdge-R740xd.samsungds.net (unknown [107.99.41.79])
	by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250602140017epsmtip2e3958f4716988e307d94f02d38db4166~FPo_11Uii2410424104epsmtip20;
	Mon,  2 Jun 2025 14:00:17 +0000 (GMT)
From: Arpit Kumar <arpit1.kumar@samsung.com>
To: qemu-devel@nongnu.org
Cc: gost.dev@samsung.com, linux-cxl@vger.kernel.org, nifan.cxl@gmail.com,
	dave@stgolabs.net, vishak.g@samsung.com, krish.reddy@samsung.com,
	a.manzanares@samsung.com, alok.rathore@samsung.com, Arpit Kumar
	<arpit1.kumar@samsung.com>
Subject: [PATCH 1/3] hw/cxl: Storing physical ports info during enumeration
Date: Mon,  2 Jun 2025 19:29:40 +0530
Message-Id: <20250602135942.2773823-2-arpit1.kumar@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250602135942.2773823-1-arpit1.kumar@samsung.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250602140018epcas5p2de38473dfcc0369193dd826c6e0e3fac
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250602140018epcas5p2de38473dfcc0369193dd826c6e0e3fac
References: <20250602135942.2773823-1-arpit1.kumar@samsung.com>
	<CGME20250602140018epcas5p2de38473dfcc0369193dd826c6e0e3fac@epcas5p2.samsung.com>

Physical ports info is stored for both mailbox cci &
mctp based cci type as per spec CXL r3.2 Table 8-230: Physical Switch

Signed-off-by: Arpit Kumar <arpit1.kumar@samsung.com>
---
 hw/cxl/cxl-mailbox-utils.c  | 166 ++++++++++++++++++++++++++++++++++++
 include/hw/cxl/cxl_device.h |  28 ++++++
 2 files changed, 194 insertions(+)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index a02d130926..680055c6c0 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -124,6 +124,64 @@ enum {
         #define GET_MHD_INFO 0x0
 };
 
+/* link state flags */
+#define LINK_STATE_FLAG_LANE_REVERSED    (1 << 0)
+#define LINK_STATE_FLAG_PERST_ASSERTED   (1 << 1)
+#define LINK_STATE_FLAG_PRSNT            (1 << 2)
+#define LINK_STATE_FLAG_POWER_OFF        (1 << 3)
+
+/* physical port control info - CXL r3.2 table 7-19 */
+typedef enum {
+    PORT_DISABLED = 0,
+    BIND_IN_PROGRESS = 1,
+    UNBIND_IN_PROGRESS = 2,
+    DSP = 3,
+    USP = 4,
+    FABRIC_PORT = 5,
+    INVALID_PORT_ID = 15
+} current_port_config_state;
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
 /* CCI Message Format CXL r3.1 Figure 7-19 */
 typedef struct CXLCCIMessage {
     uint8_t category;
@@ -3686,6 +3744,112 @@ void cxl_add_cci_commands(CXLCCI *cci, const struct cxl_cmd (*cxl_cmd_set)[256],
     cxl_rebuild_cel(cci);
 }
 
+static CXLRetCode cxl_set_port_type(struct phy_port *ports, int pnum,
+                                    CXLCCI *cci)
+{
+    PCIDevice *port_dev;
+    uint16_t lnkcap, lnkcap2, lnksta;
+    int i = pnum;
+    if (!cci) {
+        return CXL_MBOX_INTERNAL_ERROR;
+    }
+
+    PCIBus *bus = &PCI_BRIDGE(cci->d)->sec_bus;
+    PCIEPort *usp = PCIE_PORT(cci->d);
+    port_dev = pcie_find_port_by_pn(bus, i);
+
+    if (port_dev) { /* DSP */
+        PCIDevice *ds_dev = pci_bridge_get_sec_bus(PCI_BRIDGE(port_dev))
+            ->devices[0];
+        ports->pport_info[i].port_id = i;
+        ports->pport_info[i].current_port_config_state = DSP;
+        ports->active_port_bitmask[i / 8] |= (1 << i % 8);
+        if (ds_dev) {
+            if (object_dynamic_cast(OBJECT(ds_dev), TYPE_CXL_TYPE3)) {
+                ports->pport_info[i].connected_device_type = CXL_TYPE_3_MLD;
+            } else {
+                ports->pport_info[i].connected_device_type = PCIE_DEVICE;
+            }
+        } else {
+            ports->pport_info[i].connected_device_type = NO_DEVICE_DETECTED;
+        }
+        ports->pport_info[i].supported_ld_count = 3;
+    } else if (usp->port == i) { /* USP */
+        port_dev = PCI_DEVICE(usp);
+        ports->pport_info[i].port_id = i;
+        ports->pport_info[i].current_port_config_state = USP;
+        ports->pport_info[i].connected_device_type = NO_DEVICE_DETECTED;
+        ports->active_port_bitmask[i / 8] |= (1 << i % 8);
+    } else {
+        return CXL_MBOX_INVALID_INPUT;
+    }
+
+    if (!port_dev->exp.exp_cap) {
+        return CXL_MBOX_INTERNAL_ERROR;
+    }
+
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
+    ports->pport_info[i].max_link_width = (lnkcap & PCI_EXP_LNKCAP_MLW) >> 4;
+    ports->pport_info[i].negotiated_link_width = (lnksta & PCI_EXP_LNKSTA_NLW) >> 4;
+    ports->pport_info[i].supported_link_speeds_vector = (lnkcap2 & 0xFE) >> 1;
+    ports->pport_info[i].max_link_speed = lnkcap & PCI_EXP_LNKCAP_SLS;
+    ports->pport_info[i].current_link_speed = lnksta & PCI_EXP_LNKSTA_CLS;
+
+    ports->pport_info[i].ltssm_state = LTSSM_L2;
+    ports->pport_info[i].first_negotiated_lane_num = 0;
+    ports->pport_info[i].link_state_flags = 0;
+    ports->pport_info[i].supported_cxl_modes = CXL_256B_FLIT_CAPABLE;
+    ports->pport_info[i].connected_device_mode = STANDARD_256B_FLIT_MODE;
+
+    return CXL_MBOX_SUCCESS;
+}
+
+static CXLRetCode cxl_set_phy_port_info(CXLCCI *cci)
+{
+    uint8_t phy_port_num;
+    if (!cci) {
+        return CXL_MBOX_INTERNAL_ERROR;
+    }
+
+    PCIEPort *usp = PCIE_PORT(cci->d);
+    PCIBus *bus = &PCI_BRIDGE(cci->d)->sec_bus;
+    struct phy_port *ports = &cci->pports;
+    int num_phys_ports = pcie_count_ds_ports(bus) + 1;
+    if (num_phys_ports < 0) {
+        return CXL_MBOX_INTERNAL_ERROR;
+    }
+
+    ports->num_ports = num_phys_ports;
+    phy_port_num =  usp->port;
+
+    cxl_set_port_type(ports, phy_port_num, cci); /* usp */
+
+    for (int devfn = 0; devfn < ARRAY_SIZE(bus->devices); devfn++) {
+        PCIDevice *dev = bus->devices[devfn];
+
+        if (dev) {
+            phy_port_num = PCIE_PORT(dev)->port;
+            const char *typename = object_get_typename(OBJECT(dev));
+
+            if ((strcmp(typename, "cxl-downstream") == 0)) {
+                cxl_set_port_type(ports, phy_port_num, cci);
+            } else {
+                return CXL_MBOX_INTERNAL_ERROR;
+            }
+        }
+    }
+    return CXL_MBOX_SUCCESS;
+}
+
 void cxl_initialize_mailbox_swcci(CXLCCI *cci, DeviceState *intf,
                                   DeviceState *d, size_t payload_max)
 {
@@ -3693,6 +3857,7 @@ void cxl_initialize_mailbox_swcci(CXLCCI *cci, DeviceState *intf,
     cci->d = d;
     cci->intf = intf;
     cxl_init_cci(cci, payload_max);
+    cxl_set_phy_port_info(cci); /* store port info */
 }
 
 void cxl_initialize_mailbox_t3(CXLCCI *cci, DeviceState *d, size_t payload_max)
@@ -3797,4 +3962,5 @@ void cxl_initialize_usp_mctpcci(CXLCCI *cci, DeviceState *d, DeviceState *intf,
     cci->d = d;
     cci->intf = intf;
     cxl_init_cci(cci, payload_max);
+    cxl_set_phy_port_info(cci); /* store port info */
 }
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index ca515cab13..9eb128a1e8 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -127,6 +127,31 @@
                   CXL_NUM_CHMU_INSTANCES * (1 << 16),                   \
                   (1 << 16))
 
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
+    struct cxl_phy_port_info pport_info[PCI_DEVFN_MAX];
+};
+
 /* CXL r3.1 Table 8-34: Command Return Codes */
 typedef enum {
     CXL_MBOX_SUCCESS = 0x0,
@@ -223,6 +248,9 @@ typedef struct CXLCCI {
     /* get log capabilities */
     const CXLLogCapabilities *supported_log_cap;
 
+    /*physical ports information */
+    struct phy_port pports;
+
     /* background command handling (times in ms) */
     struct {
         uint16_t opcode;
-- 
2.34.1

