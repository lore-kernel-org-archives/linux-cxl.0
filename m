Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1817B1A3A80
	for <linux-cxl@vger.kernel.org>; Mon,  2 Jun 2025 16:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748880180; cv=none; b=GxBHmEQ1pa2RikXvkrfAm7pb7QNKDuAsv9oT/yNr3tdDGNwjWdvKNzFcHV9AeOqCqnVg/o5HKSgGFUNcRbYq/fFjr+TK7A9ADFFXuchMrc5iqfO4nfVnlHrPob3vfkgoJmzteFiX58EQk1a/+A77Eh5kRm/YwKRZV7afgMCuuEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748880180; c=relaxed/simple;
	bh=Uc3qoZ7SobylfgGFuPbckQ6Bv+mXV59OwFLlL0upvQo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=bM2RMRgV1h/af8lMMC1h5fRvJ2LLfQeBS58BhDBfvAcN4NJ96Jw4RLWDo3kJoHkZUZz+CcC9pYXJt0QKs99yEgSQFXzyPlYKIBeqvHcbzXYA2OOWqWEDqYcpP3VTeRiC47pjb14hVwQ2Ecz5qlLzLgBYPb6PWPGNEzyG8QdF1Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=kUDtR3TH; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="kUDtR3TH"
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250602160249epoutp02699d164e26e81e4dd79de29b42912930~FRT_bbLp71164211642epoutp02d
	for <linux-cxl@vger.kernel.org>; Mon,  2 Jun 2025 16:02:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250602160249epoutp02699d164e26e81e4dd79de29b42912930~FRT_bbLp71164211642epoutp02d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1748880169;
	bh=KrYuxyakbnI0aUfKV8KahEPEuvW90FgrJ3GbYGPxDR8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kUDtR3THaBC4NJE0/6pNiN/jRpdMQ/5TvZ7OCB8xtcJ43gKJuZQnYKLrgEDNoRrtB
	 tOhlKlUTBVjJG6wYeQkXyBTUrAThBrRayx20RLI1sUSQZB4e8oL4T0A1J9FYaGGyvY
	 IUjZNDsjTd7GUc1kFnFe0vQ4p/BTaiqs9DYHY2iM=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20250602160249epcas5p39b32dd1fa7f27c0d116a0a07bb260e18~FRT9t4Fzl2563625636epcas5p3s;
	Mon,  2 Jun 2025 16:02:49 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.38.181]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4b9zBv69dqz6B9m4; Mon,  2 Jun
	2025 16:02:47 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20250602140045epcas5p2445a99b249ba9588af027d59b0c8bd35~FPpYy0aSU1197711977epcas5p2J;
	Mon,  2 Jun 2025 14:00:45 +0000 (GMT)
Received: from test-PowerEdge-R740xd.samsungds.net (unknown [107.99.41.79])
	by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250602140043epsmtip2ad0bbef41f87f43164c52b5da210d4e0~FPpXfr8kp2232922329epsmtip2e;
	Mon,  2 Jun 2025 14:00:43 +0000 (GMT)
From: Arpit Kumar <arpit1.kumar@samsung.com>
To: qemu-devel@nongnu.org
Cc: gost.dev@samsung.com, linux-cxl@vger.kernel.org, nifan.cxl@gmail.com,
	dave@stgolabs.net, vishak.g@samsung.com, krish.reddy@samsung.com,
	a.manzanares@samsung.com, alok.rathore@samsung.com, Arpit Kumar
	<arpit1.kumar@samsung.com>
Subject: [PATCH 3/3] hw/cxl: Add Physical Port Control (Opcode 5102h)
Date: Mon,  2 Jun 2025 19:29:42 +0530
Message-Id: <20250602135942.2773823-4-arpit1.kumar@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250602135942.2773823-1-arpit1.kumar@samsung.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250602140045epcas5p2445a99b249ba9588af027d59b0c8bd35
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250602140045epcas5p2445a99b249ba9588af027d59b0c8bd35
References: <20250602135942.2773823-1-arpit1.kumar@samsung.com>
	<CGME20250602140045epcas5p2445a99b249ba9588af027d59b0c8bd35@epcas5p2.samsung.com>

added assert-deassert PERST implementation, reset PPB
for physical port.

Signed-off-by: Arpit Kumar <arpit1.kumar@samsung.com>
---
 hw/cxl/cxl-mailbox-utils.c  | 128 ++++++++++++++++++++++++++++++++++++
 include/hw/cxl/cxl_device.h |   8 +++
 2 files changed, 136 insertions(+)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index b2fa79a721..4f09692713 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -118,12 +118,16 @@ enum {
     PHYSICAL_SWITCH = 0x51,
         #define IDENTIFY_SWITCH_DEVICE      0x0
         #define GET_PHYSICAL_PORT_STATE     0x1
+        #define PHYSICAL_PORT_CONTROL       0X2
     TUNNEL = 0x53,
         #define MANAGEMENT_COMMAND     0x0
     MHD = 0x55,
         #define GET_MHD_INFO 0x0
 };
 
+/* Assert - Deassert PERST */
+#define ASSERT_WAIT_TIME_MS 100
+
 /* link state flags */
 #define LINK_STATE_FLAG_LANE_REVERSED    (1 << 0)
 #define LINK_STATE_FLAG_PERST_ASSERTED   (1 << 1)
@@ -662,6 +666,114 @@ static CXLRetCode cmd_get_physical_port_state(const struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
+static struct PCIDevice *cxl_find_port_dev(uint8_t ppb_id, PCIBus *bus)
+{
+    PCIDevice *d;
+    int devfn;
+
+    for (devfn = 0; devfn < ARRAY_SIZE(bus->devices); devfn++) {
+        d = bus->devices[devfn];
+        if (d) {
+            if (object_dynamic_cast(OBJECT(d), TYPE_CXL_DSP)) {
+                uint8_t port = PCIE_PORT(d)->port;
+                if (port == ppb_id) {
+                    return d;
+                }
+            }
+        }
+    }
+    return NULL;
+}
+
+static CXLRetCode deassert_PERST(Object *obj, ResetType type, uint8_t pn, CXLCCI *cci)
+{
+    ResettableClass *rc = RESETTABLE_GET_CLASS(obj);
+    ResettableState *s = rc->get_state(obj);
+
+    if (cci->pports.perst[pn].issued_assert_PERST) {
+        if (cci->pports.perst[pn].asrt_time == -1 && !s->hold_phase_pending) {
+            qemu_mutex_lock(&cci->pports.perst[pn].lock);
+            resettable_release_reset(obj, type);
+            cci->pports.perst[pn].issued_assert_PERST = false;
+            cci->pports.pport_info[pn].link_state_flags &=
+                ~LINK_STATE_FLAG_PERST_ASSERTED;
+            cci->pports.perst[pn].asrt_time = ASSERT_WAIT_TIME_MS;
+            qemu_mutex_unlock(&cci->pports.perst[pn].lock);
+        } else {
+            return CXL_MBOX_INTERNAL_ERROR;
+        }
+    } else {
+        return CXL_MBOX_INTERNAL_ERROR;
+    }
+    return CXL_MBOX_SUCCESS;
+}
+
+static CXLRetCode assert_PERST(Object *obj, ResetType type, uint8_t pn, CXLCCI *cci)
+{
+    ResettableClass *rc = RESETTABLE_GET_CLASS(obj);
+    ResettableState *s = rc->get_state(obj);
+
+    if (cci->pports.perst[pn].issued_assert_PERST || s->exit_phase_in_progress) {
+        return CXL_MBOX_INTERNAL_ERROR;
+    }
+
+    qemu_mutex_lock(&cci->pports.perst[pn].lock);
+    cci->pports.perst[pn].issued_assert_PERST = true;
+    cci->pports.pport_info[pn].link_state_flags |=
+        LINK_STATE_FLAG_PERST_ASSERTED;
+    resettable_assert_reset(obj, type);
+    qemu_mutex_unlock(&cci->pports.perst[pn].lock);
+
+    /* holding reset phase for 100ms */
+    while (cci->pports.perst[pn].asrt_time--) {
+        usleep(1000);
+    }
+    return CXL_MBOX_SUCCESS;
+}
+
+/*CXL r3.2 Section 7.6.7.1.3: Get Physical Port Control (Opcode 5102h)*/
+static CXLRetCode cmd_physical_port_control(const struct cxl_cmd *cmd,
+                                            uint8_t *payload_in,
+                                            size_t len_in,
+                                            uint8_t *payload_out,
+                                            size_t *len_out,
+                                            CXLCCI *cci)
+{
+    PCIBus *bus = &PCI_BRIDGE(cci->d)->sec_bus;
+    PCIDevice *dev;
+    struct cxl_fmapi_get_physical_port_control_req_pl {
+        uint8_t PPB_ID;
+        uint8_t Ports_Op;
+    } QEMU_PACKED *in;
+
+    in = (struct cxl_fmapi_get_physical_port_control_req_pl *)payload_in;
+
+    if (len_in < sizeof(*in)) {
+        return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
+    }
+
+    uint8_t pn = in->PPB_ID;
+    dev = cxl_find_port_dev(pn, bus);
+    if (!dev) {
+        return CXL_MBOX_INTERNAL_ERROR;
+    }
+
+    switch (in->Ports_Op) {
+    case 0:
+        assert_PERST(OBJECT(&dev->qdev), RESET_TYPE_COLD, pn, cci);
+        break;
+    case 1:
+        deassert_PERST(OBJECT(&dev->qdev), RESET_TYPE_COLD, pn, cci);
+        break;
+    case 2:
+        device_cold_reset(&dev->qdev);
+        break;
+    default:
+        return CXL_MBOX_INVALID_INPUT;
+    }
+    return CXL_MBOX_SUCCESS;
+}
+
 /* CXL r3.1 Section 8.2.9.1.2: Background Operation Status (Opcode 0002h) */
 static CXLRetCode cmd_infostat_bg_op_sts(const struct cxl_cmd *cmd,
                                          uint8_t *payload_in,
@@ -3637,6 +3749,9 @@ void cxl_init_cci(CXLCCI *cci, size_t payload_max)
 void cxl_destroy_cci(CXLCCI *cci)
 {
     qemu_mutex_destroy(&cci->bg.lock);
+    for (int i = 0; i < PCI_DEVFN_MAX; i++) {
+        qemu_mutex_destroy(&cci->pports.perst[i].lock);
+    }
     cci->initialized = false;
 }
 
@@ -3866,6 +3981,8 @@ static const struct cxl_cmd cxl_cmd_set_usp_mctp[256][256] = {
         cmd_identify_switch_device, 0, 0 },
     [PHYSICAL_SWITCH][GET_PHYSICAL_PORT_STATE] = { "SWITCH_PHYSICAL_PORT_STATS",
         cmd_get_physical_port_state, ~0, 0 },
+    [PHYSICAL_SWITCH][PHYSICAL_PORT_CONTROL] = { "SWITCH_PHYSICAL_PORT_CONTROL",
+        cmd_physical_port_control, 2, 0 },
     [TUNNEL][MANAGEMENT_COMMAND] = { "TUNNEL_MANAGEMENT_COMMAND",
                                      cmd_tunnel_management_cmd, ~0, 0 },
 };
@@ -3878,4 +3995,15 @@ void cxl_initialize_usp_mctpcci(CXLCCI *cci, DeviceState *d, DeviceState *intf,
     cci->intf = intf;
     cxl_init_cci(cci, payload_max);
     cxl_set_phy_port_info(cci); /* store port info */
+    /* physical port control */
+    for (int i = 0; i < PCI_DEVFN_MAX; i++) {
+        qemu_mutex_init(&cci->pports.perst[i].lock);
+        cci->pports.perst[i].issued_assert_PERST = false;
+        /* Assert PERST involves physical port to be in
+         * hold reset phase for minimum 100ms. No other calls
+         * are entertained until Deassert PERST command.
+         * https://patchwork.ozlabs.org/project/linux-pci/patch/20190523194409.17718-1-niklas.cassel@linaro.org/#2178369
+         */
+        cci->pports.perst[i].asrt_time = ASSERT_WAIT_TIME_MS;
+    }
 }
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 9eb128a1e8..f877d60b39 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -146,10 +146,18 @@ struct cxl_phy_port_info {
     uint8_t supported_ld_count;
 } QEMU_PACKED;
 
+/* assert-deassert PERST */
+struct pperst {
+    bool issued_assert_PERST;
+    int asrt_time;
+    QemuMutex lock;
+};
+
 struct phy_port {
     uint8_t num_ports;
     uint8_t active_port_bitmask[0x20];
     struct cxl_phy_port_info pport_info[PCI_DEVFN_MAX];
+    struct pperst perst[PCI_DEVFN_MAX];
 };
 
 /* CXL r3.1 Table 8-34: Command Return Codes */
-- 
2.34.1

