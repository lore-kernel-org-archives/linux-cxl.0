Received: from purple.birch.relay.mailchannels.net (purple.birch.relay.mailchannels.net [23.83.209.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8983FE7
	for <linux-cxl@vger.kernel.org>; Mon, 11 Aug 2025 03:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.209.150
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754883722; cv=pass; b=YFW3CynPlyLkTcjG804EdJq7CklSsUejSv7BLWFO9gZm/vk/CJ588DFZhpIkWGt4i2ioGZZgvgSZlnQHL46KIN7OX1oBYeYSfryyFrY5RnzxiCy7GBjW2VoXpmtVghV8TeotAwE+U+EUB4tGfqhZvCiA5KFBwezhePm14NRat5o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754883722; c=relaxed/simple;
	bh=mX3Fh7JMZ7ytjQLBZjRDihR2BO5v0iSpKLNDj7dj81Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tpAzkB5h4NHWISyjkc9VXZsADbxHZJo23yBsSUxr00ivKYwJ5ROFBMo0LDPKj7EIz68iTqwvXL2m1HM3Wjk/7ib/rso5S1askPNwmmqjs0sXJXz1QhZ3MhFUAgG+vGvfcRYNsWGskN+/9OLz5KCBg6mWoXxNZgAr2xxnCXH8zpk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=SCLBpNcv; arc=pass smtp.client-ip=23.83.209.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="SCLBpNcv"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id AB5038372E;
	Mon, 11 Aug 2025 03:34:27 +0000 (UTC)
Received: from pdx1-sub0-mail-a236.dreamhost.com (trex-blue-9.trex.outbound.svc.cluster.local [100.96.13.39])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 4CF28835A3;
	Mon, 11 Aug 2025 03:34:27 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1754883267; a=rsa-sha256;
	cv=none;
	b=PPK3ff2iawsnQZmZtQQ7dNV7oATvMmZnGeqzN277ZJ631IqdP1XoHGd9RDaJXuBvgS5/Ti
	VAKLxcyqbZyHHEJnc/ftjGFjzwZIlaXnQu4aWkB3dBss3CjaMq2qoBmu+WGIMFLSVZKfsW
	u8ZzwelBu1T3rhXCC4g4aW+HQ879qcNEp/DpmnqYDrHkJ6uLIrnB39SgHwNAlBCw+mP6TG
	GPlL9ww8R0KCoQqMhJ+QIvx0V7Goi9O90+uS+DX82yI4S887B5NU+srpWABsAs7WSypqmM
	ZSSrf13EL2rByTxhQkhPZSjG/CJdIRZTjSwUwJbGRSnGLMPoRsBjQ9DYxFq7NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1754883267;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=I6Q+CBhi62xj0DL71t7WBUgHDZofnn8/U3Qei8O+Gqk=;
	b=eXYpnHFyu5P5Mas49Hleer73KbkjB8rWqVdfd6byJIy/kuvGaDMWra4dSCR+c6CEHSpIDV
	K6Nw+sbtsiKiiSAw78MC+gQSAqg5bRUOOiYKHaC7RtvG5Xll7ZWnke+qrY9xpRUyALk6gE
	I9ijWCWoZGveitST9ZkcG3g2t62bIPD1cch19NsLqlIKVAljPQs9Xk8x6/SqpGvk9k1wD0
	uA4z8TxHgXz5o5BxZ+m1iZ99aWdPTAW+McBdwSyW9GaWV/UUmTgQtmKGIiv5OOXf1ESK7a
	MoE8aYVguPP6orfjERlufjwqHAQoQzFO6aAa5Eu4sxG7E1triQ4Qyx6fAwAQpw==
ARC-Authentication-Results: i=1;
	rspamd-698857ffff-fkw4h;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Relation-Arithmetic: 3fb6dc9e2e306baa_1754883267590_1525435007
X-MC-Loop-Signature: 1754883267590:1730140255
X-MC-Ingress-Time: 1754883267589
Received: from pdx1-sub0-mail-a236.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.96.13.39 (trex/7.1.3);
	Mon, 11 Aug 2025 03:34:27 +0000
Received: from offworld.lan (syn-076-167-199-067.res.spectrum.com [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a236.dreamhost.com (Postfix) with ESMTPSA id 4c0gH64m9Rz6v;
	Sun, 10 Aug 2025 20:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1754883267;
	bh=I6Q+CBhi62xj0DL71t7WBUgHDZofnn8/U3Qei8O+Gqk=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=SCLBpNcvFXyNo0TJNPZyR+tGPYf/mu/SDKsxfAQu60yuNIersYzdefRRjRETrmDGw
	 7QCry8P8QxG/8R4m2PKsXib+qypwWgMm5s6QDbhlNDtJ5FVHFeD0AhG7JkGsgwp59z
	 mHCw1hgpp9JTTxIF72x1cwBy+jUZojXWlXIXDqOvBgfNmKDpu4eE6gUedUgu3gRDzy
	 VisW4OsyqI4O92jX4H7ivAMQDuPpG7LZcbmc2awblWvZ6xEdAaoT74tNoGj1aK31BN
	 Aw6/Tx93X8Wg+BO6rmHawWp4edT3SE+x7gihl5s4I+2Tb4AwEQBVPXklUijbBcZFT4
	 i87AK0LEL9BtA==
From: Davidlohr Bueso <dave@stgolabs.net>
To: jonathan.cameron@huawei.com
Cc: ira.weiny@intel.com,
	alucerop@amd.com,
	a.manzanares@samsung.com,
	linux-cxl@vger.kernel.org,
	qemu-devel@nongnu.org,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 1/4] hw/pcie: Support enabling flit mode
Date: Sun, 10 Aug 2025 20:34:02 -0700
Message-Id: <20250811033405.332295-2-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250811033405.332295-1-dave@stgolabs.net>
References: <20250811033405.332295-1-dave@stgolabs.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As with the link speed and width training, have ad-hoc property for
setting the flit mode and allow CXL components to make use of it.

For the CXL root port and dsp cases, always report flit mode but
the actual value after 'training' will depend on the downstream
device configuration.

Suggested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 hw/mem/cxl_type3.c                        |  9 ++++++---
 hw/pci-bridge/cxl_downstream.c            | 11 +++++++----
 hw/pci-bridge/cxl_root_port.c             | 11 +++++++----
 hw/pci-bridge/cxl_upstream.c              | 19 +++++++++++--------
 hw/pci-bridge/gen_pcie_root_port.c        |  1 +
 hw/pci/pcie.c                             | 23 +++++++++++++++++++----
 include/hw/cxl/cxl_device.h               |  1 +
 include/hw/pci-bridge/cxl_upstream_port.h |  1 +
 include/hw/pci/pcie.h                     |  2 +-
 include/hw/pci/pcie_port.h                |  1 +
 10 files changed, 55 insertions(+), 24 deletions(-)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index c4658e0955d5..ecd3a7703b35 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -533,9 +533,10 @@ static void build_dvsecs(CXLType3Dev *ct3d)
                                GPF_DEVICE_DVSEC_REVID, dvsec);
 
     dvsec = (uint8_t *)&(CXLDVSECPortFlexBus){
-        .cap                     = 0x26, /* 68B, IO, Mem, non-MLD */
+                                   /* 68B (maybe), IO, Mem, non-MLD */
+        .cap                     = ct3d->flitmode ? 0x6 : 0x26,
         .ctrl                    = 0x02, /* IO always enabled */
-        .status                  = 0x26, /* same as capabilities */
+        .status                  = ct3d->flitmode ? 0x6 : 0x26, /* same */
         .rcvd_mod_ts_data_phase1 = 0xef, /* WTF? */
     };
     cxl_component_create_dvsec(cxl_cstate, CXL2_TYPE3_DEVICE,
@@ -1501,7 +1502,8 @@ void ct3d_reset(DeviceState *dev)
     uint32_t *reg_state = ct3d->cxl_cstate.crb.cache_mem_registers;
     uint32_t *write_msk = ct3d->cxl_cstate.crb.cache_mem_regs_write_mask;
 
-    pcie_cap_fill_link_ep_usp(PCI_DEVICE(dev), ct3d->width, ct3d->speed);
+    pcie_cap_fill_link_ep_usp(PCI_DEVICE(dev), ct3d->width, ct3d->speed,
+                              ct3d->flitmode);
     cxl_component_register_init_common(reg_state, write_msk, CXL2_TYPE3_DEVICE);
     cxl_device_register_init_t3(ct3d, CXL_T3_MSIX_MBOX);
 
@@ -1540,6 +1542,7 @@ static const Property ct3_props[] = {
                                 speed, PCIE_LINK_SPEED_32),
     DEFINE_PROP_PCIE_LINK_WIDTH("x-width", CXLType3Dev,
                                 width, PCIE_LINK_WIDTH_16),
+    DEFINE_PROP_BOOL("256b-flit", CXLType3Dev, flitmode, false),
     DEFINE_PROP_UINT16("chmu-port", CXLType3Dev, cxl_dstate.chmu[0].port, 0),
 };
 
diff --git a/hw/pci-bridge/cxl_downstream.c b/hw/pci-bridge/cxl_downstream.c
index 6aa8586f0161..94dcd52a8017 100644
--- a/hw/pci-bridge/cxl_downstream.c
+++ b/hw/pci-bridge/cxl_downstream.c
@@ -116,8 +116,9 @@ static void cxl_dsp_reset(DeviceState *qdev)
     latch_registers(dsp);
 }
 
-static void build_dvsecs(CXLComponentState *cxl)
+static void build_dvsecs(PCIDevice *d, CXLComponentState *cxl)
 {
+    PCIESlot *s = PCIE_SLOT(d);
     CXLDVSECRegisterLocator *regloc_dvsec;
     uint8_t *dvsec;
     int i;
@@ -129,9 +130,10 @@ static void build_dvsecs(CXLComponentState *cxl)
                                EXTENSIONS_PORT_DVSEC_REVID, dvsec);
 
     dvsec = (uint8_t *)&(CXLDVSECPortFlexBus){
-        .cap                     = 0x27, /* Cache, IO, Mem, non-MLD */
+                                   /* 68B (maybe), IO, Mem, non-MLD */
+        .cap                     = s->flitmode ? 0x7 : 0x27,
         .ctrl                    = 0x02, /* IO always enabled */
-        .status                  = 0x26, /* same */
+        .status                  = s->flitmode ? 0x6 : 0x26, /* same */
         .rcvd_mod_ts_data_phase1 = 0xef, /* WTF? */
     };
     cxl_component_create_dvsec(cxl, CXL2_DOWNSTREAM_PORT,
@@ -212,7 +214,7 @@ static void cxl_dsp_realize(PCIDevice *d, Error **errp)
 
     cxl_cstate->dvsec_offset = CXL_DOWNSTREAM_PORT_DVSEC_OFFSET;
     cxl_cstate->pdev = d;
-    build_dvsecs(cxl_cstate);
+    build_dvsecs(d, cxl_cstate);
     cxl_component_register_block_init(OBJECT(d), cxl_cstate, TYPE_CXL_DSP);
     memory_region_init(&dsp->bar, OBJECT(d), "registers", (2 << 16));
     memory_region_add_subregion(&dsp->bar, 0, component_bar);
@@ -257,6 +259,7 @@ static const Property cxl_dsp_props[] = {
                                 speed, PCIE_LINK_SPEED_64),
     DEFINE_PROP_PCIE_LINK_WIDTH("x-width", PCIESlot,
                                 width, PCIE_LINK_WIDTH_16),
+    DEFINE_PROP_BOOL("256b-flit", PCIESlot, flitmode, true),
 };
 
 static void cxl_dsp_class_init(ObjectClass *oc, const void *data)
diff --git a/hw/pci-bridge/cxl_root_port.c b/hw/pci-bridge/cxl_root_port.c
index f035987b6f1f..fd992b808355 100644
--- a/hw/pci-bridge/cxl_root_port.c
+++ b/hw/pci-bridge/cxl_root_port.c
@@ -109,8 +109,9 @@ static void latch_registers(CXLRootPort *crp)
     cxl_component_register_init_common(reg_state, write_msk, CXL2_ROOT_PORT);
 }
 
-static void build_dvsecs(CXLComponentState *cxl)
+static void build_dvsecs(PCIDevice *d, CXLComponentState *cxl)
 {
+    PCIESlot *s = PCIE_SLOT(d);
     CXLDVSECRegisterLocator *regloc_dvsec;
     uint8_t *dvsec;
     int i;
@@ -131,9 +132,10 @@ static void build_dvsecs(CXLComponentState *cxl)
                                GPF_PORT_DVSEC_REVID, dvsec);
 
     dvsec = (uint8_t *)&(CXLDVSECPortFlexBus){
-        .cap                     = 0x26, /* IO, Mem, non-MLD */
+                                   /* 68B (maybe), IO, Mem, non-MLD */
+        .cap                     = s->flitmode ? 0x6 : 0x26,
         .ctrl                    = 0x2,
-        .status                  = 0x26, /* same */
+        .status                  = s->flitmode ? 0x6 : 0x26, /* same */
         .rcvd_mod_ts_data_phase1 = 0xef,
     };
     cxl_component_create_dvsec(cxl, CXL2_ROOT_PORT,
@@ -189,7 +191,7 @@ static void cxl_rp_realize(DeviceState *dev, Error **errp)
 
     cxl_cstate->dvsec_offset = CXL_ROOT_PORT_DVSEC_OFFSET;
     cxl_cstate->pdev = pci_dev;
-    build_dvsecs(cxl_cstate);
+    build_dvsecs(pci_dev, cxl_cstate);
 
     cxl_component_register_block_init(OBJECT(pci_dev), cxl_cstate,
                                       TYPE_CXL_ROOT_PORT);
@@ -235,6 +237,7 @@ static const Property gen_rp_props[] = {
                                 speed, PCIE_LINK_SPEED_64),
     DEFINE_PROP_PCIE_LINK_WIDTH("x-width", PCIESlot,
                                 width, PCIE_LINK_WIDTH_32),
+    DEFINE_PROP_BOOL("256b-flit", PCIESlot, flitmode, true),
 };
 
 static void cxl_rp_dvsec_write_config(PCIDevice *dev, uint32_t addr,
diff --git a/hw/pci-bridge/cxl_upstream.c b/hw/pci-bridge/cxl_upstream.c
index c2150afff39b..6269276408b8 100644
--- a/hw/pci-bridge/cxl_upstream.c
+++ b/hw/pci-bridge/cxl_upstream.c
@@ -147,12 +147,13 @@ static void cxl_usp_reset(DeviceState *qdev)
 
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
     CXLDVSECRegisterLocator *regloc_dvsec;
     uint8_t *dvsec;
     int i;
@@ -160,17 +161,18 @@ static void build_dvsecs(CXLComponentState *cxl)
     dvsec = (uint8_t *)&(CXLDVSECPortExt){
         .status = 0x1, /* Port Power Management Init Complete */
     };
-    cxl_component_create_dvsec(cxl, CXL2_UPSTREAM_PORT,
+    cxl_component_create_dvsec(cxl_cstate, CXL2_UPSTREAM_PORT,
                                EXTENSIONS_PORT_DVSEC_LENGTH,
                                EXTENSIONS_PORT_DVSEC,
                                EXTENSIONS_PORT_DVSEC_REVID, dvsec);
     dvsec = (uint8_t *)&(CXLDVSECPortFlexBus){
-        .cap                     = 0x27, /* Cache, IO, Mem, non-MLD */
+                                 /* 68B (maybe), Cache, IO, Mem, non-MLD */
+        .cap                     = usp->flitmode ? 0x7 : 0x27,
         .ctrl                    = 0x27, /* Cache, IO, Mem */
-        .status                  = 0x26, /* same */
+        .status                  = usp->flitmode ? 0x6 : 0x26, /* same */
         .rcvd_mod_ts_data_phase1 = 0xef, /* WTF? */
     };
-    cxl_component_create_dvsec(cxl, CXL2_UPSTREAM_PORT,
+    cxl_component_create_dvsec(cxl_cstate, CXL2_UPSTREAM_PORT,
                                PCIE_CXL3_FLEXBUS_PORT_DVSEC_LENGTH,
                                PCIE_FLEXBUS_PORT_DVSEC,
                                PCIE_CXL3_FLEXBUS_PORT_DVSEC_REVID, dvsec);
@@ -186,7 +188,7 @@ static void build_dvsecs(CXLComponentState *cxl)
             RBI_CXL_CPMU_REG | 0; /* Port so only one 64 bit bar */
         regloc_dvsec->reg_base[1 + i].hi = 0;
     }
-    cxl_component_create_dvsec(cxl, CXL2_UPSTREAM_PORT,
+    cxl_component_create_dvsec(cxl_cstate, CXL2_UPSTREAM_PORT,
                                REG_LOC_DVSEC_LENGTH, REG_LOC_DVSEC,
                                REG_LOC_DVSEC_REVID, (uint8_t *)regloc_dvsec);
 }
@@ -381,7 +383,7 @@ static void cxl_usp_realize(PCIDevice *d, Error **errp)
     }
     cxl_cstate->dvsec_offset = CXL_UPSTREAM_PORT_DVSEC_OFFSET;
     cxl_cstate->pdev = d;
-    build_dvsecs(cxl_cstate);
+    build_dvsecs(usp);
     cxl_component_register_block_init(OBJECT(d), cxl_cstate, TYPE_CXL_USP);
     memory_region_init(&usp->bar, OBJECT(d), "registers", (2 << 16));
     memory_region_add_subregion(&usp->bar, 0, component_bar);
@@ -433,6 +435,7 @@ static const Property cxl_upstream_props[] = {
                                 speed, PCIE_LINK_SPEED_32),
     DEFINE_PROP_PCIE_LINK_WIDTH("x-width", CXLUpstreamPort,
                                 width, PCIE_LINK_WIDTH_16),
+    DEFINE_PROP_BOOL("256b-flit", CXLUpstreamPort, flitmode, false),
 };
 
 static void cxl_upstream_class_init(ObjectClass *oc, const void *data)
diff --git a/hw/pci-bridge/gen_pcie_root_port.c b/hw/pci-bridge/gen_pcie_root_port.c
index d9078e783bf0..b092463d471e 100644
--- a/hw/pci-bridge/gen_pcie_root_port.c
+++ b/hw/pci-bridge/gen_pcie_root_port.c
@@ -145,6 +145,7 @@ static const Property gen_rp_props[] = {
                                 speed, PCIE_LINK_SPEED_16),
     DEFINE_PROP_PCIE_LINK_WIDTH("x-width", PCIESlot,
                                 width, PCIE_LINK_WIDTH_32),
+    DEFINE_PROP_BOOL("256b-flit", PCIESlot, flitmode, false),
 };
 
 static void gen_rp_dev_class_init(ObjectClass *klass, const void *data)
diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
index eaeb68894e6e..cc8e7c3cbf3f 100644
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
@@ -1106,6 +1111,8 @@ void pcie_sync_bridge_lnk(PCIDevice *bridge_dev)
     if (!target || !target->exp.exp_cap) {
         lnksta = lnkcap;
     } else {
+        uint16_t lnksta2;
+
         lnksta = target->config_read(target,
                                      target->exp.exp_cap + PCI_EXP_LNKSTA,
                                      sizeof(lnksta));
@@ -1119,6 +1126,14 @@ void pcie_sync_bridge_lnk(PCIDevice *bridge_dev)
             lnksta &= ~PCI_EXP_LNKSTA_CLS;
             lnksta |= lnkcap & PCI_EXP_LNKCAP_SLS;
         }
+
+        lnksta2 = target->config_read(target,
+                                      target->exp.exp_cap + PCI_EXP_LNKSTA2,
+                                      sizeof(lnksta2));
+        pci_word_test_and_clear_mask(exp_cap + PCI_EXP_LNKSTA2,
+                                     PCI_EXP_LNKSTA2_FLIT);
+        pci_word_test_and_set_mask(exp_cap + PCI_EXP_LNKSTA2, lnksta2 &
+                                   PCI_EXP_LNKSTA2_FLIT);
     }
 
     if (!(lnksta & PCI_EXP_LNKSTA_NLW)) {
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 068c20d61ebc..0abfd678b875 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -796,6 +796,7 @@ struct CXLType3Dev {
     /* PCIe link characteristics */
     PCIExpLinkSpeed speed;
     PCIExpLinkWidth width;
+    bool flitmode;
 
     /* DOE */
     DOECap doe_cdat;
diff --git a/include/hw/pci-bridge/cxl_upstream_port.h b/include/hw/pci-bridge/cxl_upstream_port.h
index db1dfb6afd98..4862601b2a60 100644
--- a/include/hw/pci-bridge/cxl_upstream_port.h
+++ b/include/hw/pci-bridge/cxl_upstream_port.h
@@ -20,6 +20,7 @@ typedef struct CXLUpstreamPort {
 
     PCIExpLinkSpeed speed;
     PCIExpLinkWidth width;
+    bool flitmode;
 
     DOECap doe_cdat;
     uint64_t sn;
diff --git a/include/hw/pci/pcie.h b/include/hw/pci/pcie.h
index ff6ce08e135a..358374b1df81 100644
--- a/include/hw/pci/pcie.h
+++ b/include/hw/pci/pcie.h
@@ -142,7 +142,7 @@ void pcie_ari_init(PCIDevice *dev, uint16_t offset);
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
-- 
2.39.5

