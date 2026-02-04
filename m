Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9126417C69
	for <linux-cxl@vger.kernel.org>; Wed,  4 Feb 2026 17:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770225011; cv=none; b=t+eUvGwy1YmzSWL0x2hBGoc/hRhtMxFOFpw9FoLSrqJ29uAOSqb3oxclQdkkZxm1p1S0QwuGWBB1/3oNjpMR1tqLQbmg2ndipQJceowcvt25qCNf0TdGmMQjAgqSpVHdPuvyyxnx0Ot1RbQ2XKnlnTo9+3IKnigWHpBmCFApr94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770225011; c=relaxed/simple;
	bh=RBwKdGbLA9WPoIA/62h3rqZcqWbX3pIU34lArEzEeR0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=glIcIgmIgpAnFENo0YVw3O+WDAj/sbcRPn6fhEEdhf4C5eQFcf6NwN6LzyhUaQDgn4w2EMBIvVXb20WnB9zwbNBPqpukn81liHo3AXS5KYQy0MjPyEeztC4nhPdi2BKJ9mrleJH4ZX+wJ93xSXsDcVTI5MbHfZb9IYPi/qQhJWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4f5n0b437kzHnGjn;
	Thu,  5 Feb 2026 01:10:07 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 6411740569;
	Thu,  5 Feb 2026 01:10:08 +0800 (CST)
Received: from SecurePC-101-06.huawei.com (10.122.19.247) by
 dubpeml500005.china.huawei.com (7.214.145.207) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 4 Feb 2026 17:10:07 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Michael Tsirkin <mst@redhat.com>, <qemu-devel@nongnu.org>, Davidlohr Bueso
	<dave@stgolabs.net>
CC: <linuxarm@huawei.com>, <linux-cxl@vger.kernel.org>, Ravi Shankar
	<venkataravis@micron.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
	Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>
Subject: [PATCH qemu v7 1/7] hw/pcie: Support enabling flit mode
Date: Wed, 4 Feb 2026 17:09:29 +0000
Message-ID: <20260204170936.43959-2-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260204170936.43959-1-Jonathan.Cameron@huawei.com>
References: <20260204170936.43959-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml500009.china.huawei.com (7.191.174.84) To
 dubpeml500005.china.huawei.com (7.214.145.207)

From: Davidlohr Bueso <dave@stgolabs.net>

PCIe Flit Mode, introduced with the PCIe 6.0 specification, is a
fundamental change in how data is transmitted over the bus to
improve transfer rates. It shifts from variable-sized Transaction
Layer Packets (TLPs) to fixed 256-byte Flow Control Units (FLITs).

As with the link speed and width training, have ad-hoc property for
setting the flit mode and allow CXL components to make use of it.

For the CXL root port and dsp cases, always report flit mode but
the actual value after 'training' will depend on the downstream
device configuration.

Suggested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Tested-by: Dongjoo Seo <dongjoo.seo1@samsung.com>
Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 include/hw/cxl/cxl_device.h               |  1 +
 include/hw/pci-bridge/cxl_upstream_port.h |  1 +
 include/hw/pci/pcie.h                     |  2 +-
 include/hw/pci/pcie_port.h                |  1 +
 hw/mem/cxl_type3.c                        |  6 ++++--
 hw/pci-bridge/cxl_downstream.c            |  8 +++++---
 hw/pci-bridge/cxl_root_port.c             |  8 +++++---
 hw/pci-bridge/cxl_upstream.c              | 16 +++++++++-------
 hw/pci/pcie.c                             | 23 +++++++++++++++++++----
 9 files changed, 46 insertions(+), 20 deletions(-)

diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index d5906afb19a5..7d9236db8c85 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -726,6 +726,7 @@ struct CXLType3Dev {
     /* PCIe link characteristics */
     PCIExpLinkSpeed speed;
     PCIExpLinkWidth width;
+    bool flitmode;
 
     /* DOE */
     DOECap doe_cdat;
diff --git a/include/hw/pci-bridge/cxl_upstream_port.h b/include/hw/pci-bridge/cxl_upstream_port.h
index f208397ffe96..e3d6a27acc86 100644
--- a/include/hw/pci-bridge/cxl_upstream_port.h
+++ b/include/hw/pci-bridge/cxl_upstream_port.h
@@ -15,6 +15,7 @@ typedef struct CXLUpstreamPort {
 
     PCIExpLinkSpeed speed;
     PCIExpLinkWidth width;
+    bool flitmode;
 
     DOECap doe_cdat;
     uint64_t sn;
diff --git a/include/hw/pci/pcie.h b/include/hw/pci/pcie.h
index fc02aeb169f1..0a1cbb8728f3 100644
--- a/include/hw/pci/pcie.h
+++ b/include/hw/pci/pcie.h
@@ -144,7 +144,7 @@ void pcie_ari_init(PCIDevice *dev, uint16_t offset);
 void pcie_dev_ser_num_init(PCIDevice *dev, uint16_t offset, uint64_t ser_num);
 void pcie_ats_init(PCIDevice *dev, uint16_t offset, bool aligned);
 void pcie_cap_fill_link_ep_usp(PCIDevice *dev, PCIExpLinkWidth width,
-                               PCIExpLinkSpeed speed);
+                               PCIExpLinkSpeed speed, bool flitmode);
 
 void pcie_cap_slot_pre_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
                                Error **errp);
diff --git a/include/hw/pci/pcie_port.h b/include/hw/pci/pcie_port.h
index 7cd7af8cfa4b..53cd64c5edff 100644
--- a/include/hw/pci/pcie_port.h
+++ b/include/hw/pci/pcie_port.h
@@ -58,6 +58,7 @@ struct PCIESlot {
 
     PCIExpLinkSpeed speed;
     PCIExpLinkWidth width;
+    bool flitmode;
 
     /* Disable ACS (really for a pcie_root_port) */
     bool        disable_acs;
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 85694707e2e4..3c7ecd8c48bc 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -405,7 +405,7 @@ static void build_dvsecs(CXLType3Dev *ct3d)
     dvsec = (uint8_t *)&(CXLDVSECPortFlexBus){
         .cap                     = 0x26, /* 68B, IO, Mem, non-MLD */
         .ctrl                    = 0x02, /* IO always enabled */
-        .status                  = 0x26, /* same as capabilities */
+        .status                  = ct3d->flitmode ? 0x6 : 0x26, /* lack of 68B */
         .rcvd_mod_ts_data_phase1 = 0xef, /* WTF? */
     };
     cxl_component_create_dvsec(cxl_cstate, CXL2_TYPE3_DEVICE,
@@ -1315,7 +1315,8 @@ static void ct3d_reset(DeviceState *dev)
     uint32_t *reg_state = ct3d->cxl_cstate.crb.cache_mem_registers;
     uint32_t *write_msk = ct3d->cxl_cstate.crb.cache_mem_regs_write_mask;
 
-    pcie_cap_fill_link_ep_usp(PCI_DEVICE(dev), ct3d->width, ct3d->speed);
+    pcie_cap_fill_link_ep_usp(PCI_DEVICE(dev), ct3d->width, ct3d->speed,
+                              ct3d->flitmode);
     cxl_component_register_init_common(reg_state, write_msk, CXL2_TYPE3_DEVICE);
     cxl_device_register_init_t3(ct3d, CXL_T3_MSIX_MBOX);
 
@@ -1354,6 +1355,7 @@ static const Property ct3_props[] = {
                                 speed, PCIE_LINK_SPEED_32),
     DEFINE_PROP_PCIE_LINK_WIDTH("x-width", CXLType3Dev,
                                 width, PCIE_LINK_WIDTH_16),
+    DEFINE_PROP_BOOL("x-256b-flit", CXLType3Dev, flitmode, false),
 };
 
 static uint64_t get_lsa_size(CXLType3Dev *ct3d)
diff --git a/hw/pci-bridge/cxl_downstream.c b/hw/pci-bridge/cxl_downstream.c
index f7b131e67e8e..64086d8ec2f2 100644
--- a/hw/pci-bridge/cxl_downstream.c
+++ b/hw/pci-bridge/cxl_downstream.c
@@ -94,8 +94,9 @@ static void cxl_dsp_reset(DeviceState *qdev)
     latch_registers(dsp);
 }
 
-static void build_dvsecs(CXLComponentState *cxl)
+static void build_dvsecs(PCIDevice *d, CXLComponentState *cxl)
 {
+    PCIESlot *s = PCIE_SLOT(d);
     uint8_t *dvsec;
 
     dvsec = (uint8_t *)&(CXLDVSECPortExt){ 0 };
@@ -107,7 +108,7 @@ static void build_dvsecs(CXLComponentState *cxl)
     dvsec = (uint8_t *)&(CXLDVSECPortFlexBus){
         .cap                     = 0x27, /* Cache, IO, Mem, non-MLD */
         .ctrl                    = 0x02, /* IO always enabled */
-        .status                  = 0x26, /* same */
+        .status                  = s->flitmode ? 0x6 : 0x26, /* lack of 68B */
         .rcvd_mod_ts_data_phase1 = 0xef, /* WTF? */
     };
     cxl_component_create_dvsec(cxl, CXL2_DOWNSTREAM_PORT,
@@ -182,7 +183,7 @@ static void cxl_dsp_realize(PCIDevice *d, Error **errp)
 
     cxl_cstate->dvsec_offset = CXL_DOWNSTREAM_PORT_DVSEC_OFFSET;
     cxl_cstate->pdev = d;
-    build_dvsecs(cxl_cstate);
+    build_dvsecs(d, cxl_cstate);
     cxl_component_register_block_init(OBJECT(d), cxl_cstate, TYPE_CXL_DSP);
     pci_register_bar(d, CXL_COMPONENT_REG_BAR_IDX,
                      PCI_BASE_ADDRESS_SPACE_MEMORY |
@@ -217,6 +218,7 @@ static const Property cxl_dsp_props[] = {
                                 speed, PCIE_LINK_SPEED_64),
     DEFINE_PROP_PCIE_LINK_WIDTH("x-width", PCIESlot,
                                 width, PCIE_LINK_WIDTH_16),
+    DEFINE_PROP_BOOL("x-256b-flit", PCIESlot, flitmode, true),
 };
 
 static void cxl_dsp_class_init(ObjectClass *oc, const void *data)
diff --git a/hw/pci-bridge/cxl_root_port.c b/hw/pci-bridge/cxl_root_port.c
index 197d3148d201..5641048084a4 100644
--- a/hw/pci-bridge/cxl_root_port.c
+++ b/hw/pci-bridge/cxl_root_port.c
@@ -104,8 +104,9 @@ static void latch_registers(CXLRootPort *crp)
     cxl_component_register_init_common(reg_state, write_msk, CXL2_ROOT_PORT);
 }
 
-static void build_dvsecs(CXLComponentState *cxl)
+static void build_dvsecs(PCIDevice *d, CXLComponentState *cxl)
 {
+    PCIESlot *s = PCIE_SLOT(d);
     uint8_t *dvsec;
 
     dvsec = (uint8_t *)&(CXLDVSECPortExt){ 0 };
@@ -126,7 +127,7 @@ static void build_dvsecs(CXLComponentState *cxl)
     dvsec = (uint8_t *)&(CXLDVSECPortFlexBus){
         .cap                     = 0x26, /* IO, Mem, non-MLD */
         .ctrl                    = 0x2,
-        .status                  = 0x26, /* same */
+        .status                  = s->flitmode ? 0x6 : 0x26, /* lack of 68B */
         .rcvd_mod_ts_data_phase1 = 0xef,
     };
     cxl_component_create_dvsec(cxl, CXL2_ROOT_PORT,
@@ -176,7 +177,7 @@ static void cxl_rp_realize(DeviceState *dev, Error **errp)
 
     cxl_cstate->dvsec_offset = CXL_ROOT_PORT_DVSEC_OFFSET;
     cxl_cstate->pdev = pci_dev;
-    build_dvsecs(cxl_cstate);
+    build_dvsecs(pci_dev, cxl_cstate);
 
     cxl_component_register_block_init(OBJECT(pci_dev), cxl_cstate,
                                       TYPE_CXL_ROOT_PORT);
@@ -211,6 +212,7 @@ static const Property gen_rp_props[] = {
                                 speed, PCIE_LINK_SPEED_64),
     DEFINE_PROP_PCIE_LINK_WIDTH("x-width", PCIESlot,
                                 width, PCIE_LINK_WIDTH_32),
+    DEFINE_PROP_BOOL("x-256b-flit", PCIESlot, flitmode, true),
 };
 
 static void cxl_rp_dvsec_write_config(PCIDevice *dev, uint32_t addr,
diff --git a/hw/pci-bridge/cxl_upstream.c b/hw/pci-bridge/cxl_upstream.c
index 6d708fadc253..c352d11dc7b7 100644
--- a/hw/pci-bridge/cxl_upstream.c
+++ b/hw/pci-bridge/cxl_upstream.c
@@ -101,28 +101,29 @@ static void cxl_usp_reset(DeviceState *qdev)
 
     pci_bridge_reset(qdev);
     pcie_cap_deverr_reset(d);
-    pcie_cap_fill_link_ep_usp(d, usp->width, usp->speed);
+    pcie_cap_fill_link_ep_usp(d, usp->width, usp->speed, usp->flitmode);
     latch_registers(usp);
 }
 
-static void build_dvsecs(CXLComponentState *cxl)
+static void build_dvsecs(CXLUpstreamPort *usp)
 {
+    CXLComponentState *cxl_cstate = &usp->cxl_cstate;
     uint8_t *dvsec;
 
     dvsec = (uint8_t *)&(CXLDVSECPortExt){
         .status = 0x1, /* Port Power Management Init Complete */
     };
-    cxl_component_create_dvsec(cxl, CXL2_UPSTREAM_PORT,
+    cxl_component_create_dvsec(cxl_cstate, CXL2_UPSTREAM_PORT,
                                EXTENSIONS_PORT_DVSEC_LENGTH,
                                EXTENSIONS_PORT_DVSEC,
                                EXTENSIONS_PORT_DVSEC_REVID, dvsec);
     dvsec = (uint8_t *)&(CXLDVSECPortFlexBus){
         .cap                     = 0x27, /* Cache, IO, Mem, non-MLD */
         .ctrl                    = 0x27, /* Cache, IO, Mem */
-        .status                  = 0x26, /* same */
+        .status                  = usp->flitmode ? 0x6 : 0x26, /* lack of 68B */
         .rcvd_mod_ts_data_phase1 = 0xef, /* WTF? */
     };
-    cxl_component_create_dvsec(cxl, CXL2_UPSTREAM_PORT,
+    cxl_component_create_dvsec(cxl_cstate, CXL2_UPSTREAM_PORT,
                                PCIE_CXL3_FLEXBUS_PORT_DVSEC_LENGTH,
                                PCIE_FLEXBUS_PORT_DVSEC,
                                PCIE_CXL3_FLEXBUS_PORT_DVSEC_REVID, dvsec);
@@ -132,7 +133,7 @@ static void build_dvsecs(CXLComponentState *cxl)
         .reg0_base_lo = RBI_COMPONENT_REG | CXL_COMPONENT_REG_BAR_IDX,
         .reg0_base_hi = 0,
     };
-    cxl_component_create_dvsec(cxl, CXL2_UPSTREAM_PORT,
+    cxl_component_create_dvsec(cxl_cstate, CXL2_UPSTREAM_PORT,
                                REG_LOC_DVSEC_LENGTH, REG_LOC_DVSEC,
                                REG_LOC_DVSEC_REVID, dvsec);
 }
@@ -327,7 +328,7 @@ static void cxl_usp_realize(PCIDevice *d, Error **errp)
     }
     cxl_cstate->dvsec_offset = CXL_UPSTREAM_PORT_DVSEC_OFFSET;
     cxl_cstate->pdev = d;
-    build_dvsecs(cxl_cstate);
+    build_dvsecs(usp);
     cxl_component_register_block_init(OBJECT(d), cxl_cstate, TYPE_CXL_USP);
     pci_register_bar(d, CXL_COMPONENT_REG_BAR_IDX,
                      PCI_BASE_ADDRESS_SPACE_MEMORY |
@@ -369,6 +370,7 @@ static const Property cxl_upstream_props[] = {
                                 speed, PCIE_LINK_SPEED_32),
     DEFINE_PROP_PCIE_LINK_WIDTH("x-width", CXLUpstreamPort,
                                 width, PCIE_LINK_WIDTH_16),
+    DEFINE_PROP_BOOL("x-256b-flit", CXLUpstreamPort, flitmode, false),
 };
 
 static void cxl_upstream_class_init(ObjectClass *oc, const void *data)
diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
index c481c16c0f57..6cc6e848b6bf 100644
--- a/hw/pci/pcie.c
+++ b/hw/pci/pcie.c
@@ -113,7 +113,7 @@ pcie_cap_v1_fill(PCIDevice *dev, uint8_t port, uint8_t type, uint8_t version)
 
 /* Includes setting the target speed default */
 static void pcie_cap_fill_lnk(uint8_t *exp_cap, PCIExpLinkWidth width,
-                              PCIExpLinkSpeed speed)
+                              PCIExpLinkSpeed speed, bool flitmode)
 {
     /* Clear and fill LNKCAP from what was configured above */
     pci_long_test_and_clear_mask(exp_cap + PCI_EXP_LNKCAP,
@@ -158,10 +158,15 @@ static void pcie_cap_fill_lnk(uint8_t *exp_cap, PCIExpLinkWidth width,
                                        PCI_EXP_LNKCAP2_SLS_64_0GB);
         }
     }
+
+    if (flitmode) {
+        pci_long_test_and_set_mask(exp_cap + PCI_EXP_LNKSTA2,
+                                   PCI_EXP_LNKSTA2_FLIT);
+    }
 }
 
 void pcie_cap_fill_link_ep_usp(PCIDevice *dev, PCIExpLinkWidth width,
-                               PCIExpLinkSpeed speed)
+                               PCIExpLinkSpeed speed, bool flitmode)
 {
     uint8_t *exp_cap = dev->config + dev->exp.exp_cap;
 
@@ -175,7 +180,7 @@ void pcie_cap_fill_link_ep_usp(PCIDevice *dev, PCIExpLinkWidth width,
                                QEMU_PCI_EXP_LNKSTA_NLW(width) |
                                QEMU_PCI_EXP_LNKSTA_CLS(speed));
 
-    pcie_cap_fill_lnk(exp_cap, width, speed);
+    pcie_cap_fill_lnk(exp_cap, width, speed, flitmode);
 }
 
 static void pcie_cap_fill_slot_lnk(PCIDevice *dev)
@@ -212,7 +217,7 @@ static void pcie_cap_fill_slot_lnk(PCIDevice *dev)
         /* the PCI_EXP_LNKSTA_DLLLA will be set in the hotplug function */
     }
 
-    pcie_cap_fill_lnk(exp_cap, s->width, s->speed);
+    pcie_cap_fill_lnk(exp_cap, s->width, s->speed, s->flitmode);
 }
 
 int pcie_cap_init(PCIDevice *dev, uint8_t offset,
@@ -1175,6 +1180,8 @@ void pcie_sync_bridge_lnk(PCIDevice *bridge_dev)
     if (!target || !target->exp.exp_cap) {
         lnksta = lnkcap;
     } else {
+        uint16_t lnksta2;
+
         lnksta = target->config_read(target,
                                      target->exp.exp_cap + PCI_EXP_LNKSTA,
                                      sizeof(lnksta));
@@ -1188,6 +1195,14 @@ void pcie_sync_bridge_lnk(PCIDevice *bridge_dev)
             lnksta &= ~PCI_EXP_LNKSTA_CLS;
             lnksta |= lnkcap & PCI_EXP_LNKCAP_SLS;
         }
+
+        lnksta2 = target->config_read(target,
+                                      target->exp.exp_cap + PCI_EXP_LNKSTA2,
+                                      sizeof(lnksta2));
+        pci_word_test_and_clear_mask(exp_cap + PCI_EXP_LNKSTA2,
+                                     PCI_EXP_LNKSTA2_FLIT);
+        pci_word_test_and_set_mask(exp_cap + PCI_EXP_LNKSTA2,
+                                   lnksta2 & PCI_EXP_LNKSTA2_FLIT);
     }
 
     if (!(lnksta & PCI_EXP_LNKSTA_NLW)) {
-- 
2.51.0

