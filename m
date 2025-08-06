Received: from crocodile.elm.relay.mailchannels.net (crocodile.elm.relay.mailchannels.net [23.83.212.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BEBE171C9
	for <linux-cxl@vger.kernel.org>; Wed,  6 Aug 2025 07:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.212.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754464597; cv=pass; b=AMAyS+x0div/wNqaLCI/oIuCK5sZ4vHHhpZYaHKX8GMWQCBP6Q1OFJ/Pxd/RPCL8CRpG0JoWmlIzqqFfLwtaRt9MS8SYxFgd7e8SotXmFGuMAEXFOoE19xFG2QVjPULhUWgkg3K+dv6mRJAJWtkpYN5n6Zvy8c+cXwD5GxKeQA0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754464597; c=relaxed/simple;
	bh=xLrVr43RRUEvPgbn9a5BhcbNTl+Xp7KnSxhY0iuv1qU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BGpHtjAoL/I38S9EFfOimlaYt5JrPclwpWab9k+tJHQELVcgkylWcp9G74/Ef7FOmQILIWo68l9+gPLVGsywxyhhdoOX4V0oL9zECu2iyND4sgzjJZ5s4rAbsW4lA/nzeLUZi5Q86rxPOEVw45sp0/JBxSBVCq4zWYl8CldVWIc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=VQ4vAMsn; arc=pass smtp.client-ip=23.83.212.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="VQ4vAMsn"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 7BFD02C48ED;
	Wed,  6 Aug 2025 05:57:23 +0000 (UTC)
Received: from pdx1-sub0-mail-a291.dreamhost.com (trex-blue-1.trex.outbound.svc.cluster.local [100.96.40.151])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 1BD5F2C5666;
	Wed,  6 Aug 2025 05:57:23 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1754459843; a=rsa-sha256;
	cv=none;
	b=qW/Uahz5Eo9Jzt1zRI6WtqB0smONXEjppP8YRf0fI7Q5L7Nad6U3KwRhcsNUeZWx6nDLik
	dPj69yoSG1IpYU9LB7ypCRrTU+jMmGkGom7aKvldqfWKIk3S8n+j6/S5pdp+99GBJp3SlN
	EUbPY0VFFMNJOddjbr3G4VD8fnhP++IQCOVImQie6np5dTKU66b9rka30DxYKd7nAQGt7B
	avzEN+Xut0x/GhSWIXdE/4vqXcQm544imaeu1Fy+duA6mJFHvOUKcOL2mLS2UrypL/HRqV
	Kjq13C4Qnb8AaKijdBYg71sJaNOkhXi/E/JCUtMWr2KYagihUr76hbQfE8d10A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1754459843;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=JXxgqZuGbutG28XkrBGlw+oxu1u/Ig8R+KhwSol6kCE=;
	b=Qk8V7QUTOVb4Pmo7w7wA8iBzR29Me95wssbOIp5sVke24Y/rUbLhsBYPC8wOwUHroiTqQE
	RDUNU7j9OphQsWgnId0b5+X2LR55Y60bagms5QhMHO9lMtPI5k68DjurIu0Gi0dsQBKDNA
	ZSD2HAESmrBRVIg6M+jlrQ69dEC4WZC2ol1uGkqjaJWePUHoyq2Ok7yipDGWigAxFh+0Yx
	0x3/MExKSacwvBsa1tWAxj8qc05uKvShova8HGSCaMrjDxHHrprpp5nvJHt8vWX8NAJS2T
	9+Lkcu7OAcxpO5j3uFkTtLfORKw89LEWw4Lqj5BhheMlQng7FGNtIOtc9smn0Q==
ARC-Authentication-Results: i=1;
	rspamd-648c9d5b94-xdgrc;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Sponge-Little: 5a303bc45940b41d_1754459843386_2902602647
X-MC-Loop-Signature: 1754459843386:3947028736
X-MC-Ingress-Time: 1754459843386
Received: from pdx1-sub0-mail-a291.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.96.40.151 (trex/7.1.3);
	Wed, 06 Aug 2025 05:57:23 +0000
Received: from localhost.localdomain (syn-076-167-199-067.res.spectrum.com [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a291.dreamhost.com (Postfix) with ESMTPSA id 4bxfhL3XgMz55;
	Tue,  5 Aug 2025 22:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1754459843;
	bh=JXxgqZuGbutG28XkrBGlw+oxu1u/Ig8R+KhwSol6kCE=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=VQ4vAMsnMI5/kvg8/6ZnzJJC/kNl6cR2fUFcKqix0yoedRJ1LrBBb7qipREWoIkxz
	 /OpLbzgpIJPbc3qadSGxqzzq34wSfejYdF6rXuc+ojx6Ow0bV4+khbTII3M9LN9iAc
	 ovTeOHUDl8HQlExv8Lxx0ch9SDiIv5Ter04LFVsEhtbsiyvU/qCQeHpvF9RAa+XEwO
	 RTkpF/pP37reSPN6Q7RmUAfkAnQPq/vftlgbjLO3ZGASxK9YioKH9D1oWRcjY+CLav
	 P0zpqzeKg5dwtsx9CiIIG2bC2dL6u031J8LP+N14kFNScdAngMl2SeHaaue+HWuY7O
	 ANJzLPEW+5QtQ==
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
Date: Tue,  5 Aug 2025 22:57:05 -0700
Message-Id: <20250806055708.196851-2-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250806055708.196851-1-dave@stgolabs.net>
References: <20250806055708.196851-1-dave@stgolabs.net>
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
 hw/core/qdev-properties-system.c          | 11 +++++++++++
 hw/mem/cxl_type3.c                        |  4 +++-
 hw/pci-bridge/cxl_downstream.c            |  1 +
 hw/pci-bridge/cxl_root_port.c             |  1 +
 hw/pci-bridge/cxl_upstream.c              |  3 ++-
 hw/pci-bridge/gen_pcie_root_port.c        |  1 +
 hw/pci/pcie.c                             | 13 +++++++++----
 include/hw/cxl/cxl_device.h               |  1 +
 include/hw/pci-bridge/cxl_upstream_port.h |  1 +
 include/hw/pci/pcie.h                     |  2 +-
 include/hw/pci/pcie_port.h                |  1 +
 include/hw/qdev-properties-system.h       |  3 +++
 qapi/common.json                          | 14 ++++++++++++++
 13 files changed, 49 insertions(+), 7 deletions(-)

diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
index 24e145d87001..94a1b754ecdc 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -1172,6 +1172,17 @@ const PropertyInfo qdev_prop_pcie_link_width = {
     .set_default_value = qdev_propinfo_set_default_value_enum,
 };
 
+/* --- Flit mode --- */
+
+const PropertyInfo qdev_prop_pcie_link_flit = {
+    .type = "PCIELinkFlit",
+    .description = "off/on",
+    .enum_table = &PCIELinkFlit_lookup,
+    .get   = qdev_propinfo_get_enum,
+    .set   = qdev_propinfo_set_enum,
+    .set_default_value = qdev_propinfo_set_default_value_enum,
+};
+
 /* --- UUID --- */
 
 static void get_uuid(Object *obj, Visitor *v, const char *name, void *opaque,
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index c4658e0955d5..324cf62e8141 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1501,7 +1501,8 @@ void ct3d_reset(DeviceState *dev)
     uint32_t *reg_state = ct3d->cxl_cstate.crb.cache_mem_registers;
     uint32_t *write_msk = ct3d->cxl_cstate.crb.cache_mem_regs_write_mask;
 
-    pcie_cap_fill_link_ep_usp(PCI_DEVICE(dev), ct3d->width, ct3d->speed);
+    pcie_cap_fill_link_ep_usp(PCI_DEVICE(dev), ct3d->width, ct3d->speed,
+                              ct3d->flitmode);
     cxl_component_register_init_common(reg_state, write_msk, CXL2_TYPE3_DEVICE);
     cxl_device_register_init_t3(ct3d, CXL_T3_MSIX_MBOX);
 
@@ -1540,6 +1541,7 @@ static const Property ct3_props[] = {
                                 speed, PCIE_LINK_SPEED_32),
     DEFINE_PROP_PCIE_LINK_WIDTH("x-width", CXLType3Dev,
                                 width, PCIE_LINK_WIDTH_16),
+    DEFINE_PROP_PCIE_LINK_FLIT("256b-flit", CXLType3Dev, flitmode, 0),
     DEFINE_PROP_UINT16("chmu-port", CXLType3Dev, cxl_dstate.chmu[0].port, 0),
 };
 
diff --git a/hw/pci-bridge/cxl_downstream.c b/hw/pci-bridge/cxl_downstream.c
index 6aa8586f0161..82e6618b111c 100644
--- a/hw/pci-bridge/cxl_downstream.c
+++ b/hw/pci-bridge/cxl_downstream.c
@@ -257,6 +257,7 @@ static const Property cxl_dsp_props[] = {
                                 speed, PCIE_LINK_SPEED_64),
     DEFINE_PROP_PCIE_LINK_WIDTH("x-width", PCIESlot,
                                 width, PCIE_LINK_WIDTH_16),
+    DEFINE_PROP_PCIE_LINK_FLIT("256b-flit", PCIESlot, flitmode, 1),
 };
 
 static void cxl_dsp_class_init(ObjectClass *oc, const void *data)
diff --git a/hw/pci-bridge/cxl_root_port.c b/hw/pci-bridge/cxl_root_port.c
index f035987b6f1f..721dc3981fd2 100644
--- a/hw/pci-bridge/cxl_root_port.c
+++ b/hw/pci-bridge/cxl_root_port.c
@@ -235,6 +235,7 @@ static const Property gen_rp_props[] = {
                                 speed, PCIE_LINK_SPEED_64),
     DEFINE_PROP_PCIE_LINK_WIDTH("x-width", PCIESlot,
                                 width, PCIE_LINK_WIDTH_32),
+    DEFINE_PROP_PCIE_LINK_FLIT("256b-flit", PCIESlot, flitmode, 1),
 };
 
 static void cxl_rp_dvsec_write_config(PCIDevice *dev, uint32_t addr,
diff --git a/hw/pci-bridge/cxl_upstream.c b/hw/pci-bridge/cxl_upstream.c
index c2150afff39b..5e6d559a3215 100644
--- a/hw/pci-bridge/cxl_upstream.c
+++ b/hw/pci-bridge/cxl_upstream.c
@@ -147,7 +147,7 @@ static void cxl_usp_reset(DeviceState *qdev)
 
     pci_bridge_reset(qdev);
     pcie_cap_deverr_reset(d);
-    pcie_cap_fill_link_ep_usp(d, usp->width, usp->speed);
+    pcie_cap_fill_link_ep_usp(d, usp->width, usp->speed, usp->flitmode);
     latch_registers(usp);
 }
 
@@ -433,6 +433,7 @@ static const Property cxl_upstream_props[] = {
                                 speed, PCIE_LINK_SPEED_32),
     DEFINE_PROP_PCIE_LINK_WIDTH("x-width", CXLUpstreamPort,
                                 width, PCIE_LINK_WIDTH_16),
+    DEFINE_PROP_PCIE_LINK_FLIT("256b-flit", CXLUpstreamPort, flitmode, 0),
 };
 
 static void cxl_upstream_class_init(ObjectClass *oc, const void *data)
diff --git a/hw/pci-bridge/gen_pcie_root_port.c b/hw/pci-bridge/gen_pcie_root_port.c
index d9078e783bf0..c00be8147c2a 100644
--- a/hw/pci-bridge/gen_pcie_root_port.c
+++ b/hw/pci-bridge/gen_pcie_root_port.c
@@ -145,6 +145,7 @@ static const Property gen_rp_props[] = {
                                 speed, PCIE_LINK_SPEED_16),
     DEFINE_PROP_PCIE_LINK_WIDTH("x-width", PCIESlot,
                                 width, PCIE_LINK_WIDTH_32),
+    DEFINE_PROP_PCIE_LINK_FLIT("256b-flit", PCIESlot, flitmode, 0),
 };
 
 static void gen_rp_dev_class_init(ObjectClass *klass, const void *data)
diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
index eaeb68894e6e..55e0f7110ae5 100644
--- a/hw/pci/pcie.c
+++ b/hw/pci/pcie.c
@@ -113,7 +113,7 @@ pcie_cap_v1_fill(PCIDevice *dev, uint8_t port, uint8_t type, uint8_t version)
 
 /* Includes setting the target speed default */
 static void pcie_cap_fill_lnk(uint8_t *exp_cap, PCIExpLinkWidth width,
-                              PCIExpLinkSpeed speed)
+                              PCIExpLinkSpeed speed, PCIELinkFlit flitmode)
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
+                               PCIExpLinkSpeed speed, PCIELinkFlit flitmode)
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
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 068c20d61ebc..4c9d2247cf02 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -796,6 +796,7 @@ struct CXLType3Dev {
     /* PCIe link characteristics */
     PCIExpLinkSpeed speed;
     PCIExpLinkWidth width;
+    PCIELinkFlit flitmode;
 
     /* DOE */
     DOECap doe_cdat;
diff --git a/include/hw/pci-bridge/cxl_upstream_port.h b/include/hw/pci-bridge/cxl_upstream_port.h
index db1dfb6afd98..584e43c37291 100644
--- a/include/hw/pci-bridge/cxl_upstream_port.h
+++ b/include/hw/pci-bridge/cxl_upstream_port.h
@@ -20,6 +20,7 @@ typedef struct CXLUpstreamPort {
 
     PCIExpLinkSpeed speed;
     PCIExpLinkWidth width;
+    PCIELinkFlit flitmode;
 
     DOECap doe_cdat;
     uint64_t sn;
diff --git a/include/hw/pci/pcie.h b/include/hw/pci/pcie.h
index ff6ce08e135a..82fcbc9f8823 100644
--- a/include/hw/pci/pcie.h
+++ b/include/hw/pci/pcie.h
@@ -142,7 +142,7 @@ void pcie_ari_init(PCIDevice *dev, uint16_t offset);
 void pcie_dev_ser_num_init(PCIDevice *dev, uint16_t offset, uint64_t ser_num);
 void pcie_ats_init(PCIDevice *dev, uint16_t offset, bool aligned);
 void pcie_cap_fill_link_ep_usp(PCIDevice *dev, PCIExpLinkWidth width,
-                               PCIExpLinkSpeed speed);
+                               PCIExpLinkSpeed speed, PCIELinkFlit flitmode);
 
 void pcie_cap_slot_pre_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
                                Error **errp);
diff --git a/include/hw/pci/pcie_port.h b/include/hw/pci/pcie_port.h
index 7cd7af8cfa4b..2f96fc685729 100644
--- a/include/hw/pci/pcie_port.h
+++ b/include/hw/pci/pcie_port.h
@@ -58,6 +58,7 @@ struct PCIESlot {
 
     PCIExpLinkSpeed speed;
     PCIExpLinkWidth width;
+    PCIELinkFlit flitmode;
 
     /* Disable ACS (really for a pcie_root_port) */
     bool        disable_acs;
diff --git a/include/hw/qdev-properties-system.h b/include/hw/qdev-properties-system.h
index b921392c5256..dd5dc4515ea7 100644
--- a/include/hw/qdev-properties-system.h
+++ b/include/hw/qdev-properties-system.h
@@ -28,6 +28,7 @@ extern const PropertyInfo qdev_prop_audiodev;
 extern const PropertyInfo qdev_prop_off_auto_pcibar;
 extern const PropertyInfo qdev_prop_pcie_link_speed;
 extern const PropertyInfo qdev_prop_pcie_link_width;
+extern const PropertyInfo qdev_prop_pcie_link_flit;
 extern const PropertyInfo qdev_prop_cpus390entitlement;
 extern const PropertyInfo qdev_prop_iothread_vq_mapping_list;
 extern const PropertyInfo qdev_prop_endian_mode;
@@ -80,6 +81,8 @@ extern const PropertyInfo qdev_prop_vmapple_virtio_blk_variant;
 #define DEFINE_PROP_PCIE_LINK_WIDTH(_n, _s, _f, _d) \
     DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_pcie_link_width, \
                         PCIExpLinkWidth)
+#define DEFINE_PROP_PCIE_LINK_FLIT(_n, _s, _f, _d) \
+    DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_pcie_link_flit, PCIELinkFlit)
 
 #define DEFINE_PROP_UUID(_name, _state, _field) \
     DEFINE_PROP(_name, _state, _field, qdev_prop_uuid, QemuUUID, \
diff --git a/qapi/common.json b/qapi/common.json
index 0e3a0bbbfb0b..da047fbf874f 100644
--- a/qapi/common.json
+++ b/qapi/common.json
@@ -140,6 +140,20 @@
 { 'enum': 'PCIELinkWidth',
   'data': [ '1', '2', '4', '8', '12', '16', '32' ] }
 
+##
+# @PCIELinkFlit:
+#
+# An enumeration of PCIe link FLIT mode
+#
+# @off: the link is not operating in FLIT mode
+#
+# @on: each FLIT is a fixed 256 bytes in size
+#
+# Since: 10.0
+##
+{ 'enum': 'PCIELinkFlit',
+  'data': [ 'off', 'on'] }
+
 ##
 # @HostMemPolicy:
 #
-- 
2.39.5

