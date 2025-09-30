Received: from cornsilk.maple.relay.mailchannels.net (cornsilk.maple.relay.mailchannels.net [23.83.214.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E772940D
	for <linux-cxl@vger.kernel.org>; Tue, 30 Sep 2025 03:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.214.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759202563; cv=pass; b=LFzWQkLOFMMCoNEycjVcXfRYwyJSXh884XZafSglE2P/srENiHYZ9hUTLgtL8Hfvv2GuT9arzo0Mw/TSDz+hJkgv9Keu7J9QhYnKuPVjt7Rw7ySCeBZnhtppYxzxhqx1V1smmyPU4LQUWCP53U6W1RFKAjvaJJ9yVxP9ul3LHC4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759202563; c=relaxed/simple;
	bh=c6+S0brNY0sW7z1zdpUxBb88vMbFVuc/o/VnbdeVx5A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o4rhpMmcWTY/4chZleO5T80cI6OKfE+3PT2dTTybx5Cq6IGOv1gJowRJXHO0EpUEaq8PpLPP9DwoPBMCbP7H9E/WPTCXhSmASQS0vx21jn2O2h5+oFcQzlGEWvG2MRd9TzRC2KVZeoNUMGWLwmpIXT/zuQ+nxvAdTjBn9eC2JTw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=LM+PgACd; arc=pass smtp.client-ip=23.83.214.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="LM+PgACd"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id DE9A71021B2;
	Tue, 30 Sep 2025 03:22:33 +0000 (UTC)
Received: from pdx1-sub0-mail-a315.dreamhost.com (trex-blue-7.trex.outbound.svc.cluster.local [100.113.91.2])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 7A8DA1022B8;
	Tue, 30 Sep 2025 03:22:33 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1759202553; a=rsa-sha256;
	cv=none;
	b=S6HZkiljcq5t6HKv2hj8/H+hDywbVqM2XL0Gu0MfPq26So3E2gg+WroInfnvgX07ZPtWfx
	X2N66GgR8orZXq/DwWGv/r2cHUo5orY59k1xeV+oMhnrWlaba0EgkmtjGGyxcoKvTneZPY
	rAcw2TCiUXP2AexIaWfm97oQEzM91pU+fMIfHb1uw7RGSh/Rr2PnouSoUS+1AqOrjM1hIc
	kXJPV5T8SZ6AZG24Z9qolzNGg0ATiomiZYRZKE9w2dAT1RU5RtWbI5Sfz5ajS+eqBQ/awQ
	HMECUed0JhaMUy4lcTNBRuCiAqVLVQvumnjdQTAqKKFxLNa7czc/WHOnw5Nxjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1759202553;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=OrYCW4VC8LmZTyulqwgO+AoqcZI4Z3iXAmxfpRYSxEw=;
	b=rGllmQOev0CNgnvmkBuTQHe7ZxvdyU50cJN8k/5M0TWR7Wyd4xsBFTp4C8q2U5rVuCNJH6
	OF0Th5ynMN8KuvlT5M9Q6tTjUoJEfsFhBu0ogqLluSinQ0hoNBVfHAoH2qQcpBFXnMPjQi
	weQ+Mh8C9cUr9oP/PzQCAXmwSOJn/bv4JB2ObcoX3Yc40GhCv9amAt63YZ/dbPjsUGKBHU
	YwyZ7d2f/Z0k1JgAPCH4kxEeH/DgMW5Axw5Z4FCoIjo+eZ8IVq6K7MMWCyfgWUBU0cby6N
	tbDCitkv9ukMrx883Ie8OHzJ2JZE57qR/uU8Mr+9LXU/eTzBqb10ysw1b9ug6g==
ARC-Authentication-Results: i=1;
	rspamd-867694b6c6-mltlx;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Chief-Bitter: 6aeee4c557c13171_1759202553809_1165532815
X-MC-Loop-Signature: 1759202553809:886246471
X-MC-Ingress-Time: 1759202553809
Received: from pdx1-sub0-mail-a315.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.113.91.2 (trex/7.1.3);
	Tue, 30 Sep 2025 03:22:33 +0000
Received: from offworld.lan (syn-076-167-199-067.res.spectrum.com [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a315.dreamhost.com (Postfix) with ESMTPSA id 4cbNfJ5KJGzNt;
	Mon, 29 Sep 2025 20:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1759202553;
	bh=OrYCW4VC8LmZTyulqwgO+AoqcZI4Z3iXAmxfpRYSxEw=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=LM+PgACd1x7TrIv6/kj/5oCP2lWVyIsf67q267dQptbFwD3sODG6KYWfphwKYjkOo
	 K6f/WP2Vw/ypKYLdDZ1asSe9qSPBbwWBq70+Ww0a1IRexpI3r41lf2ZMISPcT0J3eN
	 iR1bPmbOMfAmoT+mN0IkmGxLn1MlpF2GeYGCnN8cRbQ0xwk4zilJ7uwttMPa6akI2O
	 XEeCi2q2fjWK5L6y/dZrpVeEDYiZtZOxXirOyTQt0/luGvyNHOrCPO0/x1mVGQe/he
	 9/jArliNAbKNv3ECWNSb0dCyO1KNcamcwwNATXuNU9yvNI5Lx5FbyedbUVjT/4JAtR
	 4TebWJV55Q2mQ==
From: Davidlohr Bueso <dave@stgolabs.net>
To: jonathan.cameron@huawei.com
Cc: ira.weiny@intel.com,
	lucerop@amd.com,
	a.manzanares@samsung.com,
	mst@redhat.com,
	marcel.apfelbaum@gmail.com,
	armbru@redhat.com,
	linux-cxl@vger.kernel.org,
	qemu-devel@nongnu.org,
	dave@stgolabs.net,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 1/5] hw/pcie: Support enabling flit mode
Date: Mon, 29 Sep 2025 20:21:49 -0700
Message-Id: <20250930032153.1127773-2-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250930032153.1127773-1-dave@stgolabs.net>
References: <20250930032153.1127773-1-dave@stgolabs.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
index c4658e0955d5..891b75618892 100644
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
+    DEFINE_PROP_BOOL("x-256b-flit", CXLType3Dev, flitmode, false),
     DEFINE_PROP_UINT16("chmu-port", CXLType3Dev, cxl_dstate.chmu[0].port, 0),
 };
 
diff --git a/hw/pci-bridge/cxl_downstream.c b/hw/pci-bridge/cxl_downstream.c
index 6aa8586f0161..f8d64263ac08 100644
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
+    DEFINE_PROP_BOOL("x-256b-flit", PCIESlot, flitmode, true),
 };
 
 static void cxl_dsp_class_init(ObjectClass *oc, const void *data)
diff --git a/hw/pci-bridge/cxl_root_port.c b/hw/pci-bridge/cxl_root_port.c
index f035987b6f1f..f3472f081707 100644
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
+    DEFINE_PROP_BOOL("x-256b-flit", PCIESlot, flitmode, true),
 };
 
 static void cxl_rp_dvsec_write_config(PCIDevice *dev, uint32_t addr,
diff --git a/hw/pci-bridge/cxl_upstream.c b/hw/pci-bridge/cxl_upstream.c
index c2150afff39b..e5a0d1fb308c 100644
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
+    DEFINE_PROP_BOOL("x-256b-flit", CXLUpstreamPort, flitmode, false),
 };
 
 static void cxl_upstream_class_init(ObjectClass *oc, const void *data)
diff --git a/hw/pci-bridge/gen_pcie_root_port.c b/hw/pci-bridge/gen_pcie_root_port.c
index d9078e783bf0..6b97da0b4cbb 100644
--- a/hw/pci-bridge/gen_pcie_root_port.c
+++ b/hw/pci-bridge/gen_pcie_root_port.c
@@ -145,6 +145,7 @@ static const Property gen_rp_props[] = {
                                 speed, PCIE_LINK_SPEED_16),
     DEFINE_PROP_PCIE_LINK_WIDTH("x-width", PCIESlot,
                                 width, PCIE_LINK_WIDTH_32),
+    DEFINE_PROP_BOOL("x-256b-flit", PCIESlot, flitmode, false),
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

