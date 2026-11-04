Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.254.224.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793792288;
	b=SsKcrEsK5Vx5Zt7Z25gRtDrfvL+iZvaQI32ejkNF6BFp3dOuOCBHWL6SFfLTMLQxm8h8
	 /XfDGIyzZtra4Sx4kitKIVvl1msmAaucvu0uz9AzaTWwJcdxIHrogbc4GlhTdUDu/v2bL
	 wsy5rFKlnpN5pUBHRvd9ujYZYG8K1nHGOk2kOEXQCX6ZU4ktp3c+ihqdR7EoH5u+KYJ92
	 lMlzne0U5TzI1Wt5ZhLTlOaKL55RYqz1EEJWq9WCTsG8jnzbZaQs4XWPnA2egq21yH/3r
	 vbHGXEXIIe+Plv6f50IPzPHWATrq5T9tv2yH2OloF4ICAC6J66E5O2m12PwxZVU3igQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793792288;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Received:Received:
	 Received:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:MIME-Version:Content-Transfer-Encoding:X-CMS-MailID:
	 X-Msg-Generator:Content-Type:X-Sendblock-Type:CMS-TYPE:X-CPGSPASS:
	 X-Hop-Count:X-CMS-RootMailID:References;
	bh=Y0cXYnQbjOYdGcbACGdlf2bwol3eJbmmbFa1s2CZHWU=;
	b=aSXFXmfkE43c+eXuTLuquoMH97pZxGPZUJrzyybHAe3PxIGje23l3puiQn+xPG1tpkcP
	 0pEP7xXuQwoUFC6BNUyefVvi2WH8M0OfZGLNmw6p0BkSl592H+NCUfpps/SXzIL7EfQGD
	 hUykFYZf5cR47rh31JUJ3CWcR0oGpEWFO5FV3+Y9P+A8QZYNCOEyuJKg6PUzRl9juIZMO
	 6I/yzeQvmArMMFPg+Eq6lu5oGbFdx015xVs3ybOMhPt8W2l60mTwIMknlzfV2c7eQ0j59
	 BFqqr5Y/9lScTCZLsgDUk14Pvxn+qbt0zqtEdg6FCkmg+3d8oSOH1J/b6W8+RdZ/5aA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=samsung.com;
	spf=pass smtp.mailfrom=samsung.com;
	dkim=pass header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=lNOiN9kv;
	arc=none smtp.remote-ip=203.254.224.34
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A18606A33F
	for <linux-cxl@vger.kernel.org>; Wed,  4 Nov 2026 11:38:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 57A18606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=lNOiN9kv
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20261104113804epoutp046eea880a3ebf97a87fe4bee6d9c265d9~k1JQ4pYmu2603026030epoutp04I
	for <linux-cxl@vger.kernel.org>; Wed,  4 Nov 2026 11:38:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20261104113804epoutp046eea880a3ebf97a87fe4bee6d9c265d9~k1JQ4pYmu2603026030epoutp04I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1793792284;
	bh=Y0cXYnQbjOYdGcbACGdlf2bwol3eJbmmbFa1s2CZHWU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lNOiN9kvaaD5FvIdMohf6CIeRLQ/ao6+Qpp5GUsVaJdr+JkihFT9QLoFx0516j4Ry
	 HkiADbw+G9qQzw6Tc8nTRS/TWyTugBbUQPN6AInl8OP8YzrFrCw+uk8xVu+0rZNiW9
	 G5AGQvmbhDlJ/PMWenRaEST459xVA/CIl4ttAC9I=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
	20261104113803epcas5p1f6449e8059362c272ce0b9d6d450b881~k1JQGbKgu2444724447epcas5p1t;
	Wed,  4 Nov 2026 11:38:03 +0000 (GMT)
Received: from epcpadp2new (unknown [182.195.40.142]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4jKNjR5dkkz2SSKX; Wed,  4 Nov
	2026 11:38:03 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20261104113014epcas5p1dbf4b09e2849d28b46eb39db7990a54f~k1Ca--Rd50210802108epcas5p1A;
	Wed,  4 Nov 2026 11:30:14 +0000 (GMT)
Received: from unvme-SYS-221H-TN24R.samsungds.net (unknown [107.99.40.127])
	by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20261104113012epsmtip1ca93aed51b3be29c21f0b709647aa5c8~k1CYtrxjj2364123641epsmtip1L;
	Wed,  4 Nov 2026 11:30:11 +0000 (GMT)
From: Shrihari E S <shrihari.s@samsung.com>
To: jic23@kernel.org, junjie.cao@linux.dev, linux-cxl@vger.kernel.org,
	linux-pci@vger.kernel.org, qemu-devel@nongnu.org, anisa.su887@gmail.com,
	mst@redhat.com, marcel.apfelbaum@gmail.com
Cc: shrihari.s@samsung.com, arun.george@samsung.com, cpgs@samsung.com,
	dave@stgolabs.net, dongjoo.seo1@samsung.com, gost.dev@samsung.com,
	s.neeraj@samsung.com, vikash.k5@samsung.com, anisa.su@samsung.com,
	junjie.cao@intel.com
Subject: [PATCH qemu v1 1/8] hw/pci: Refactor flitmode from PCIESlot to
 PCIEPort
Date: Wed,  4 Nov 2026 17:22:35 +0530
Message-Id: <282821294.121793792283779.JavaMail.epsvc@epcpadp2new>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261104115242.2035807-1-shrihari.s@samsung.com>
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20261104113014epcas5p1dbf4b09e2849d28b46eb39db7990a54f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CPGSPASS: Y
X-Hop-Count: 3
X-CMS-RootMailID: 20261104113014epcas5p1dbf4b09e2849d28b46eb39db7990a54f
References: <20261104115242.2035807-1-shrihari.s@samsung.com>
	<CGME20261104113014epcas5p1dbf4b09e2849d28b46eb39db7990a54f@epcas5p1.samsung.com>

Move the 'flitmode' field from PCIESlot to its parent PCIEPort so
that all the derived port types carry the 256-byte flit mode state
in a single field. The 'x-256b-flit' property defaults to off on
all the port types.

The x-256b-flit property is based on a patch series from Davidlohr
Bueso that adds flit mode signaling for CXL ports[1].

[1]: https://lore.kernel.org/all/20251103195209.1319917-2-dave@stgolabs.net/

Signed-off-by: Shrihari E S <shrihari.s@samsung.com>
---
 hw/pci-bridge/cxl_downstream.c            |  6 +++---
 hw/pci-bridge/cxl_root_port.c             |  6 +++---
 hw/pci-bridge/cxl_upstream.c              | 11 +++++++----
 hw/pci/pcie.c                             |  2 +-
 include/hw/pci-bridge/cxl_upstream_port.h |  1 -
 include/hw/pci/pcie_port.h                |  2 +-
 6 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/hw/pci-bridge/cxl_downstream.c b/hw/pci-bridge/cxl_downstream.c
index d1e27994a3..134b91220a 100644
--- a/hw/pci-bridge/cxl_downstream.c
+++ b/hw/pci-bridge/cxl_downstream.c
@@ -118,7 +118,7 @@ static void cxl_dsp_reset(DeviceState *qdev)
 
 static void build_dvsecs(PCIDevice *d, CXLComponentState *cxl)
 {
-    PCIESlot *s = PCIE_SLOT(d);
+    PCIEPort *p = PCIE_PORT(d);
     CXLDVSECRegisterLocator *regloc_dvsec;
     uint8_t *dvsec;
     int i;
@@ -132,7 +132,7 @@ static void build_dvsecs(PCIDevice *d, CXLComponentState *cxl)
     dvsec = (uint8_t *)&(CXLDVSECPortFlexBus){
         .cap                     = 0x27, /* Cache, IO, Mem, non-MLD */
         .ctrl                    = 0x02, /* IO always enabled */
-        .status                  = s->flitmode ? 0x6 : 0x26, /* lack of 68B */
+        .status                  = p->flitmode ? 0x6 : 0x26, /* lack of 68B */
         .rcvd_mod_ts_data_phase1 = 0xef, /* WTF? */
     };
     cxl_component_create_dvsec(cxl, CXL2_DOWNSTREAM_PORT,
@@ -259,7 +259,7 @@ static const Property cxl_dsp_props[] = {
                                 speed, PCIE_LINK_SPEED_64),
     DEFINE_PROP_PCIE_LINK_WIDTH("x-width", PCIESlot,
                                 width, PCIE_LINK_WIDTH_16),
-    DEFINE_PROP_BOOL("x-256b-flit", PCIESlot, flitmode, true),
+    DEFINE_PROP_BOOL("x-256b-flit", PCIEPort, flitmode, false),
 };
 
 static void cxl_dsp_class_init(ObjectClass *oc, const void *data)
diff --git a/hw/pci-bridge/cxl_root_port.c b/hw/pci-bridge/cxl_root_port.c
index 0ee18ef5c3..01463dbb07 100644
--- a/hw/pci-bridge/cxl_root_port.c
+++ b/hw/pci-bridge/cxl_root_port.c
@@ -112,7 +112,7 @@ static void latch_registers(CXLRootPort *crp)
 
 static void build_dvsecs(PCIDevice *d, CXLComponentState *cxl)
 {
-    PCIESlot *s = PCIE_SLOT(d);
+    PCIEPort *p = PCIE_PORT(d);
     CXLDVSECRegisterLocator *regloc_dvsec;
     uint8_t *dvsec;
     int i;
@@ -135,7 +135,7 @@ static void build_dvsecs(PCIDevice *d, CXLComponentState *cxl)
     dvsec = (uint8_t *)&(CXLDVSECPortFlexBus){
         .cap                     = 0x26, /* IO, Mem, non-MLD */
         .ctrl                    = 0x2,
-        .status                  = s->flitmode ? 0x6 : 0x26, /* lack of 68B */
+        .status                  = p->flitmode ? 0x6 : 0x26, /* lack of 68B */
         .rcvd_mod_ts_data_phase1 = 0xef,
     };
     cxl_component_create_dvsec(cxl, CXL2_ROOT_PORT,
@@ -237,7 +237,7 @@ static const Property gen_rp_props[] = {
                                 speed, PCIE_LINK_SPEED_64),
     DEFINE_PROP_PCIE_LINK_WIDTH("x-width", PCIESlot,
                                 width, PCIE_LINK_WIDTH_32),
-    DEFINE_PROP_BOOL("x-256b-flit", PCIESlot, flitmode, true),
+    DEFINE_PROP_BOOL("x-256b-flit", PCIEPort, flitmode, false),
 };
 
 static void cxl_rp_dvsec_write_config(PCIDevice *dev, uint32_t addr,
diff --git a/hw/pci-bridge/cxl_upstream.c b/hw/pci-bridge/cxl_upstream.c
index ef5480b116..0b1fa9594b 100644
--- a/hw/pci-bridge/cxl_upstream.c
+++ b/hw/pci-bridge/cxl_upstream.c
@@ -136,7 +136,8 @@ static void latch_registers(CXLUpstreamPort *usp)
     uint32_t *write_msk = usp->cxl_cstate.crb.cache_mem_regs_write_mask;
 
     cxl_component_register_init_common(reg_state, write_msk,
-                                       CXL2_UPSTREAM_PORT, usp->flitmode);
+                                       CXL2_UPSTREAM_PORT,
+                                       PCIE_PORT(usp)->flitmode);
     ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, TARGET_COUNT, 8);
 }
 
@@ -147,7 +148,8 @@ static void cxl_usp_reset(DeviceState *qdev)
 
     pci_bridge_reset(qdev);
     pcie_cap_deverr_reset(d);
-    pcie_cap_fill_link_ep_usp(d, usp->width, usp->speed, usp->flitmode);
+    pcie_cap_fill_link_ep_usp(d, usp->width, usp->speed,
+                              PCIE_PORT(usp)->flitmode);
     latch_registers(usp);
 }
 
@@ -168,7 +170,8 @@ static void build_dvsecs(CXLUpstreamPort *usp)
     dvsec = (uint8_t *)&(CXLDVSECPortFlexBus){
         .cap                     = 0x27, /* Cache, IO, Mem, non-MLD */
         .ctrl                    = 0x27, /* Cache, IO, Mem */
-        .status                  = usp->flitmode ? 0x6 : 0x26, /* lack of 68B */
+        .status                  = PCIE_PORT(usp)->flitmode ?
+                                  0x6 : 0x26, /* lack of 68B */
         .rcvd_mod_ts_data_phase1 = 0xef, /* WTF? */
     };
     cxl_component_create_dvsec(cxl_cstate, CXL2_UPSTREAM_PORT,
@@ -436,7 +439,7 @@ static const Property cxl_upstream_props[] = {
                                 speed, PCIE_LINK_SPEED_32),
     DEFINE_PROP_PCIE_LINK_WIDTH("x-width", CXLUpstreamPort,
                                 width, PCIE_LINK_WIDTH_16),
-    DEFINE_PROP_BOOL("x-256b-flit", CXLUpstreamPort, flitmode, false),
+    DEFINE_PROP_BOOL("x-256b-flit", PCIEPort, flitmode, false),
 };
 
 static void cxl_upstream_class_init(ObjectClass *oc, const void *data)
diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
index 1de0b1e4fd..4f6fc9db61 100644
--- a/hw/pci/pcie.c
+++ b/hw/pci/pcie.c
@@ -217,7 +217,7 @@ static void pcie_cap_fill_slot_lnk(PCIDevice *dev)
         /* the PCI_EXP_LNKSTA_DLLLA will be set in the hotplug function */
     }
 
-    pcie_cap_fill_lnk(exp_cap, s->width, s->speed, s->flitmode);
+    pcie_cap_fill_lnk(exp_cap, s->width, s->speed, PCIE_PORT(s)->flitmode);
 }
 
 int pcie_cap_init(PCIDevice *dev, uint8_t offset,
diff --git a/include/hw/pci-bridge/cxl_upstream_port.h b/include/hw/pci-bridge/cxl_upstream_port.h
index d4186234c8..e8f5e43faf 100644
--- a/include/hw/pci-bridge/cxl_upstream_port.h
+++ b/include/hw/pci-bridge/cxl_upstream_port.h
@@ -21,7 +21,6 @@ typedef struct CXLUpstreamPort {
 
     PCIExpLinkSpeed speed;
     PCIExpLinkWidth width;
-    bool flitmode;
 
     DOECap doe_cdat;
     uint64_t sn;
diff --git a/include/hw/pci/pcie_port.h b/include/hw/pci/pcie_port.h
index 53cd64c5ed..1bcc734649 100644
--- a/include/hw/pci/pcie_port.h
+++ b/include/hw/pci/pcie_port.h
@@ -33,6 +33,7 @@ struct PCIEPort {
     /*< private >*/
     PCIBridge   parent_obj;
     /*< public >*/
+    bool flitmode;
 
     /* pci express switch port */
     uint8_t     port;
@@ -58,7 +59,6 @@ struct PCIESlot {
 
     PCIExpLinkSpeed speed;
     PCIExpLinkWidth width;
-    bool flitmode;
 
     /* Disable ACS (really for a pcie_root_port) */
     bool        disable_acs;
-- 
2.34.1


