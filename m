Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7A9134A8
	for <linux-cxl@vger.kernel.org>; Mon, 14 Jul 2025 13:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752498264; cv=none; b=Hh23lIAtp5ewQWVbLKe13nNO+CF8Ouo7mliYa9NLkOSgpgrTOrULikvIxc+gglUWCBSakvSPwiQZRZuF8bXnx99SQ3KxLgU8W9U8pdB6sKdADpzinIehNwU6fK2eqYJaN8zX5q6uro/u8QYp9dNDJ+L51bcMzhg6EaSIIYikweA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752498264; c=relaxed/simple;
	bh=dJqibs0ec8Fb7uON6cRePd+ouoAz3fBeT0C0hz5H2Hw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=ADk+hencZDuJR3FhPVO7dwkH6Viz7iz6pHWctQCTio88mlfIysnP5G9aPNzymePeAVDrdAjEUnYvKxOn1RN91gPat6ECJg+10NOZyeKwduWOtUa6Sl4I2qbNBUQ386W9AinaTwn5BWw6mevkyqcbtDNKLLtMJPGi2KJXKqSR7qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=rwwKhN0A; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="rwwKhN0A"
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250714130420epoutp0426774c4dce16cc6dbc2266f5c08e5396~SH_HqPz5G2815628156epoutp04K
	for <linux-cxl@vger.kernel.org>; Mon, 14 Jul 2025 13:04:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250714130420epoutp0426774c4dce16cc6dbc2266f5c08e5396~SH_HqPz5G2815628156epoutp04K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1752498260;
	bh=pqdmardhYLbgukB+gPoJmX2cMN4AhVUGeaD4ZeYNo+0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rwwKhN0AlgXXfeHhwfx1BhpT0L4jSHdNxIxaRpOMI6WKP7w7nu1tiDI5rH67m+2NP
	 8SSoUCD6h+dQQl2XFq6kZgasPKkbbCVcrQeG1wRqivS7QpCmKR4Afu9VkMs9HhR8Ag
	 Ye9eJO5OB3nprzpYmTb2IweQkka3WiAqve/hzNG8=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
	20250714130419epcas5p24c7c7ba1728165c7ab6820b2f11d08aa~SH_G2G2550632306323epcas5p2N;
	Mon, 14 Jul 2025 13:04:19 +0000 (GMT)
Received: from epcas5p1.samsung.com (unknown [182.195.38.88]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4bgjFZ2SyFz3hhT7; Mon, 14 Jul
	2025 13:04:18 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20250710144358epcas5p1bf06af9ee56880a24421a2f7a7d6c113~Q6v98PwOy2795427954epcas5p1_;
	Thu, 10 Jul 2025 14:43:58 +0000 (GMT)
Received: from test-PowerEdge-R740xd.samsungds.net (unknown [107.99.41.79])
	by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250710144356epsmtip248b6d188df39bd80a223fcd4c3289228~Q6v8cigKS1506515065epsmtip2h;
	Thu, 10 Jul 2025 14:43:56 +0000 (GMT)
From: Arpit Kumar <arpit1.kumar@samsung.com>
To: qemu-devel@nongnu.org
Cc: gost.dev@samsung.com, linux-cxl@vger.kernel.org, nifan.cxl@gmail.com,
	dave@stgolabs.net, Jonathan.Cameron@huawei.com, vishak.g@samsung.com,
	krish.reddy@samsung.com, a.manzanares@samsung.com, alok.rathore@samsung.com,
	cpgs@samsung.com, Arpit Kumar <arpit1.kumar@samsung.com>
Subject: [PATCH v2 2/2] hw/cxl: Add Physical Port Control (Opcode 5102h)
Date: Thu, 10 Jul 2025 20:13:38 +0530
Message-Id: <20250710144338.2839512-3-arpit1.kumar@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250710144338.2839512-1-arpit1.kumar@samsung.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250710144358epcas5p1bf06af9ee56880a24421a2f7a7d6c113
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CPGSPASS: Y
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250710144358epcas5p1bf06af9ee56880a24421a2f7a7d6c113
References: <20250710144338.2839512-1-arpit1.kumar@samsung.com>
	<CGME20250710144358epcas5p1bf06af9ee56880a24421a2f7a7d6c113@epcas5p1.samsung.com>

-added assert-deassert PERST implementation
 for physical ports (both USP and DSP's).
-assert PERST involves bg operation for holding 100ms.
-reset PPB implementation for physical ports.

Signed-off-by: Arpit Kumar <arpit1.kumar@samsung.com>
---
 hw/cxl/cxl-mailbox-utils.c  | 135 ++++++++++++++++++++++++++++++++++++
 include/hw/cxl/cxl_device.h |  10 +++
 2 files changed, 145 insertions(+)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index c4e83fb2aa..3aa8bd14b9 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -118,6 +118,7 @@ enum {
     PHYSICAL_SWITCH = 0x51,
         #define IDENTIFY_SWITCH_DEVICE      0x0
         #define GET_PHYSICAL_PORT_STATE     0x1
+        #define PHYSICAL_PORT_CONTROL       0X2
     TUNNEL = 0x53,
         #define MANAGEMENT_COMMAND     0x0
     MHD = 0x55,
@@ -605,6 +606,121 @@ static CXLRetCode cmd_get_physical_port_state(const struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
+static void *bg_assertcb(void *opaque)
+{
+    struct pperst *perst = opaque;
+
+    /* holding reset phase for 100ms */
+    while (perst->asrt_time--) {
+        usleep(1000);
+    }
+    perst->issued_assert_perst = true;
+    return NULL;
+}
+
+static CXLRetCode deassert_perst(Object *obj, uint8_t pn, CXLUpstreamPort *pp)
+{
+    if (!pp->pports.perst[pn].issued_assert_perst) {
+        return CXL_MBOX_INTERNAL_ERROR;
+    }
+
+    QEMU_LOCK_GUARD(&pp->pports.perst[pn].lock);
+    resettable_release_reset(obj, RESET_TYPE_COLD);
+    pp->pports.perst[pn].issued_assert_perst = false;
+    pp->pports.pport_info[pn].link_state_flags &=
+        ~LINK_STATE_FLAG_PERST_ASSERTED;
+    pp->pports.perst[pn].asrt_time = ASSERT_WAIT_TIME_MS;
+
+    return CXL_MBOX_SUCCESS;
+}
+
+static CXLRetCode assert_perst(Object *obj, uint8_t pn, CXLUpstreamPort *pp)
+{
+    if (pp->pports.perst[pn].issued_assert_perst ||
+        pp->pports.perst[pn].asrt_time < ASSERT_WAIT_TIME_MS) {
+        return CXL_MBOX_INTERNAL_ERROR;
+    }
+
+    QEMU_LOCK_GUARD(&pp->pports.perst[pn].lock);
+    pp->pports.pport_info[pn].link_state_flags |=
+        LINK_STATE_FLAG_PERST_ASSERTED;
+    resettable_assert_reset(obj, RESET_TYPE_COLD);
+    qemu_thread_create(&pp->pports.perst[pn].asrt_thread, "assert_thread",
+        bg_assertcb, &pp->pports.perst[pn], QEMU_THREAD_DETACHED);
+
+    return CXL_MBOX_SUCCESS;
+}
+
+static struct PCIDevice *cxl_find_port_dev(uint8_t pn, CXLCCI *cci)
+{
+    CXLUpstreamPort *pp = CXL_USP(cci->d);
+    PCIBus *bus = &PCI_BRIDGE(cci->d)->sec_bus;
+
+    if (pp->pports.pport_info[pn].current_port_config_state ==
+        CXL_PORT_CONFIG_STATE_USP) {
+        PCIDevice *usp_dev = pci_bridge_get_device(bus);
+        return usp_dev;
+    }
+
+    if (pp->pports.pport_info[pn].current_port_config_state ==
+        CXL_PORT_CONFIG_STATE_DSP) {
+        PCIDevice *dsp_dev = pcie_find_port_by_pn(bus, pn);
+        return dsp_dev;
+    }
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
+   PCIDevice *dev;
+   uint8_t ret = CXL_MBOX_SUCCESS;
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
+    uint8_t pn = in->ppb_id;
+    if (pp->pports.pport_info[pn].port_id != pn) {
+        return CXL_MBOX_INTERNAL_ERROR;
+    }
+
+    dev = cxl_find_port_dev(pn, cci);
+    if (!dev) {
+        return CXL_MBOX_INTERNAL_ERROR;
+    }
+
+    switch (in->ports_op) {
+    case 0:
+        ret = assert_perst(OBJECT(&dev->qdev), pn, pp);
+        break;
+    case 1:
+        ret = deassert_perst(OBJECT(&dev->qdev), pn, pp);
+        break;
+    case 2:
+        if (pp->pports.perst[pn].issued_assert_perst ||
+            pp->pports.perst[pn].asrt_time < ASSERT_WAIT_TIME_MS) {
+            return CXL_MBOX_INTERNAL_ERROR;
+        }
+        device_cold_reset(&dev->qdev);
+        break;
+    default:
+        return CXL_MBOX_INVALID_INPUT;
+    }
+    return ret;
+}
+
 /* CXL r3.1 Section 8.2.9.1.2: Background Operation Status (Opcode 0002h) */
 static CXLRetCode cmd_infostat_bg_op_sts(const struct cxl_cmd *cmd,
                                          uint8_t *payload_in,
@@ -3579,7 +3695,11 @@ void cxl_init_cci(CXLCCI *cci, size_t payload_max)
 
 void cxl_destroy_cci(CXLCCI *cci)
 {
+    CXLUpstreamPort *pp = CXL_USP(cci->d);
     qemu_mutex_destroy(&cci->bg.lock);
+    for (int i = 0; i < CXL_MAX_PHY_PORTS; i++) {
+        qemu_mutex_destroy(&pp->pports.perst[i].lock);
+    }
     cci->initialized = false;
 }
 
@@ -3798,6 +3918,8 @@ static const struct cxl_cmd cxl_cmd_set_usp_mctp[256][256] = {
         cmd_identify_switch_device, 0, 0 },
     [PHYSICAL_SWITCH][GET_PHYSICAL_PORT_STATE] = { "SWITCH_PHYSICAL_PORT_STATS",
         cmd_get_physical_port_state, ~0, 0 },
+    [PHYSICAL_SWITCH][PHYSICAL_PORT_CONTROL] = { "SWITCH_PHYSICAL_PORT_CONTROL",
+        cmd_physical_port_control, 2, 0 },
     [TUNNEL][MANAGEMENT_COMMAND] = { "TUNNEL_MANAGEMENT_COMMAND",
                                      cmd_tunnel_management_cmd, ~0, 0 },
 };
@@ -3810,4 +3932,17 @@ void cxl_initialize_usp_mctpcci(CXLCCI *cci, DeviceState *d, DeviceState *intf,
     cci->intf = intf;
     cxl_init_cci(cci, payload_max);
     cxl_set_phy_port_info(cci);
+    /* physical port control */
+    CXLUpstreamPort *pp = CXL_USP(cci->d);
+    for (int i = 0; i < CXL_MAX_PHY_PORTS; i++) {
+        qemu_mutex_init(&pp->pports.perst[i].lock);
+        pp->pports.perst[i].issued_assert_perst = false;
+        /*
+         * Assert PERST involves physical port to be in
+         * hold reset phase for minimum 100ms. No other
+         * physcial port control requests are entertained
+         * until Deassert PERST command.
+         */
+         pp->pports.perst[i].asrt_time = ASSERT_WAIT_TIME_MS;
+    }
 }
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 1fa6cf7536..bb47e671eb 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -128,6 +128,7 @@
                   (1 << 16))
 
 #define CXL_MAX_PHY_PORTS 256
+#define ASSERT_WAIT_TIME_MS 100 /* Assert - Deassert PERST */
 
 #define LINK_STATE_FLAG_LANE_REVERSED    BIT(0)
 #define LINK_STATE_FLAG_PERST_ASSERTED   BIT(1)
@@ -203,10 +204,19 @@ struct cxl_phy_port_info {
     uint8_t supported_ld_count;
 } QEMU_PACKED;
 
+/* Assert - Deassert PERST */
+struct pperst {
+    bool issued_assert_perst;
+    QemuMutex lock;
+    uint64_t asrt_time;
+    QemuThread asrt_thread; /* thread for 100ms delay */
+};
+
 struct phy_port {
     uint8_t num_ports;
     uint8_t active_port_bitmask[0x20];
     struct cxl_phy_port_info pport_info[CXL_MAX_PHY_PORTS];
+    struct pperst perst[CXL_MAX_PHY_PORTS];
 };
 
 /* CXL r3.1 Table 8-34: Command Return Codes */
-- 
2.34.1

