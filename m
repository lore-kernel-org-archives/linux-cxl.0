Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.254.224.24
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793792405;
	b=Ci8zeiKhVCmSox9j5onOKaNI47itevVdKEYJt1QqGiu3+XmkuTI9XxMitvwT5F/qyczQ
	 mYbtcLC5Yfp9ZLl1Dx4gHggabq6lg4Ca/WdLHj/78CiKbO43rylVn3Yc1HvoYvj/JKJnl
	 osfP3AYL94xA6Ou/ap6qp23IzZWj7RYjbTjD7HWsh0+AFPCpNdTQYTI6TEzOBV+cDpGge
	 4S4y4lzFkWDrSh4viO0dkvIbqG+pJ+ltdWabynQU96VeOkGsfho9mosacak2dHYsdctD1
	 PNEj4ptBk5xwpOxZQzZZMHGms68WkOYf8PPhPFgKf/SXhGWj6wfwegM38FaFts7X+hg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793792405;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Received:Received:
	 Received:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:MIME-Version:Content-Transfer-Encoding:X-CMS-MailID:
	 X-Msg-Generator:Content-Type:X-Sendblock-Type:CMS-TYPE:X-CPGSPASS:
	 X-Hop-Count:X-CMS-RootMailID:References;
	bh=CoNTGCBqnm0HhFbxIepmVNdSHPSkoUWvTheSsXhJglE=;
	b=hj9XLq8c7NqzHgsLjNfV10jAEBFKnsYeBGGPpN3rP5X3Wrci5CnkHGSh1JxlPE+J1j7A
	 AKAvVqYJj0Ia8npelWKIRsL2iNUpKiTy5ZJYqq1dfCrVgFcdlUogHRt7mDkk/dIm8Wkii
	 CH5mltAPZOQO+WIZH10E2CZZyAXRx2YYrKA0N+2YFWpMT6ot3ZB0JY5G7qNruMMM5ZYez
	 k4IYdDAWXUMAOqZ3Hf9G54iemIZqX8dZUFXhD1PcjPCbWApLh2WojrOpUNIN1dzXf2kue
	 uKy8EphNdJumbnoO34LyHqQkrs8qdygt4FKqmpqQtL99ja/RGpmrJWLmUT4koow1NMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=samsung.com;
	spf=pass smtp.mailfrom=samsung.com;
	dkim=pass header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=RFMkiY5o;
	arc=none smtp.remote-ip=203.254.224.24
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13FA606A31B
	for <linux-cxl@vger.kernel.org>; Wed,  4 Nov 2026 11:40:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D13FA606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=RFMkiY5o
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20261104114002epoutp012ddda27a3605ddfcf34d01c2b7a681b4~k1K-CZ-5Q2941529415epoutp01g
	for <linux-cxl@vger.kernel.org>; Wed,  4 Nov 2026 11:40:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20261104114002epoutp012ddda27a3605ddfcf34d01c2b7a681b4~k1K-CZ-5Q2941529415epoutp01g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1793792402;
	bh=CoNTGCBqnm0HhFbxIepmVNdSHPSkoUWvTheSsXhJglE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RFMkiY5o3/F79yLodyA0IIGDVlrbBDk2OoAwE0TP6azo0Ti/iz+z1D74r8uM4PjE0
	 KS7bwHrcx1OlARgKBDJugSCD6c8ez1KmgPxR8bmENE+rI6BHrcAgQK7IK/A4FiHzuU
	 Lk7NoElsrEz/zanWCTi5O2cXrEVYRS5fzLPxjrdY=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
	20261104114002epcas5p4cb0aee132221310d6c7df94b77aa5afe~k1K_cN0UN3192831928epcas5p45;
	Wed,  4 Nov 2026 11:40:02 +0000 (GMT)
Received: from epcpadp1new (unknown [182.195.40.141]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4jKNlk1vs9z6B9m6; Wed,  4 Nov
	2026 11:40:02 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20261104113035epcas5p41c69e872a13ffe10bd55bdfa00bc699b~k1CufJcXY2809328093epcas5p4M;
	Wed,  4 Nov 2026 11:30:35 +0000 (GMT)
Received: from unvme-SYS-221H-TN24R.samsungds.net (unknown [107.99.40.127])
	by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20261104113032epsmtip10c3c1e252953d844a702544fb823cf0f~k1CsNd_m02358823588epsmtip1U;
	Wed,  4 Nov 2026 11:30:32 +0000 (GMT)
From: Shrihari E S <shrihari.s@samsung.com>
To: jic23@kernel.org, junjie.cao@linux.dev, linux-cxl@vger.kernel.org,
	linux-pci@vger.kernel.org, qemu-devel@nongnu.org, anisa.su887@gmail.com,
	mst@redhat.com, marcel.apfelbaum@gmail.com
Cc: shrihari.s@samsung.com, arun.george@samsung.com, cpgs@samsung.com,
	dave@stgolabs.net, dongjoo.seo1@samsung.com, gost.dev@samsung.com,
	s.neeraj@samsung.com, vikash.k5@samsung.com, anisa.su@samsung.com,
	junjie.cao@intel.com
Subject: [PATCH qemu v1 5/8] hw/pci: Wire SVC initialization into port
 realize functions
Date: Wed,  4 Nov 2026 17:22:39 +0530
Message-Id: <360067785.01793792402254.JavaMail.epsvc@epcpadp1new>
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
X-CMS-MailID: 20261104113035epcas5p41c69e872a13ffe10bd55bdfa00bc699b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CPGSPASS: Y
X-Hop-Count: 3
X-CMS-RootMailID: 20261104113035epcas5p41c69e872a13ffe10bd55bdfa00bc699b
References: <20261104115242.2035807-1-shrihari.s@samsung.com>
	<CGME20261104113035epcas5p41c69e872a13ffe10bd55bdfa00bc699b@epcas5p4.samsung.com>

With the x-svc option, a port appends the SVC capability at the end
of its extended capability chain at realize time.

In the same realize path a CXL root port derives its UIO status: it
is UIO capable when the parent pxb-cxl host bridge carries x-uio and
its own SVC and 256-byte flit mode configuration carry it; a root
port on any other bus does not carry UIO.

PXB PCIe root ports, CXL root ports, CXL switch ports and PCIe
switch ports accept the x-svc option; the port types without a
reserved SVC capability offset do not carry it.

Signed-off-by: Shrihari E S <shrihari.s@samsung.com>
Signed-off-by: Dongjoo Seo <dongjoo.seo1@samsung.com>
---
 hw/pci-bridge/cxl_downstream.c     | 10 ++++++++++
 hw/pci-bridge/cxl_root_port.c      | 29 +++++++++++++++++++++++++++++
 hw/pci-bridge/cxl_upstream.c       | 14 ++++++++++++++
 hw/pci-bridge/gen_pcie_root_port.c |  3 +++
 hw/pci-bridge/pcie_root_port.c     | 14 ++++++++++++++
 hw/pci-bridge/xio3130_downstream.c |  6 ++++++
 hw/pci-bridge/xio3130_upstream.c   | 19 +++++++++++++++++++
 include/hw/pci/pcie_port.h         |  4 ++++
 8 files changed, 99 insertions(+)

diff --git a/hw/pci-bridge/cxl_downstream.c b/hw/pci-bridge/cxl_downstream.c
index bc1e65bc89..b710ce4f2c 100644
--- a/hw/pci-bridge/cxl_downstream.c
+++ b/hw/pci-bridge/cxl_downstream.c
@@ -229,6 +229,15 @@ static void cxl_dsp_realize(PCIDevice *d, Error **errp)
                      PCI_BASE_ADDRESS_SPACE_MEMORY |
                          PCI_BASE_ADDRESS_MEM_TYPE_64,
                      &dsp->bar);
+    if (p->svc) {
+        /*
+         * SVC is appended after the DVSECs so that the extended
+         * capability layout is unchanged when the port does not
+         * carry SVC.
+         */
+        pcie_svc_cap_init(d, cxl_cstate->dvsec_offset, p->flitmode,
+                          errp);
+    }
 
     return;
 
@@ -260,6 +269,7 @@ static const Property cxl_dsp_props[] = {
     DEFINE_PROP_PCIE_LINK_WIDTH("x-width", PCIESlot,
                                 width, PCIE_LINK_WIDTH_16),
     DEFINE_PROP_BOOL("x-256b-flit", PCIEPort, flitmode, false),
+    DEFINE_PROP_BOOL("x-svc", PCIEPort, svc, false),
 };
 
 static void cxl_dsp_class_init(ObjectClass *oc, const void *data)
diff --git a/hw/pci-bridge/cxl_root_port.c b/hw/pci-bridge/cxl_root_port.c
index 4be2b400f9..4e7eea9deb 100644
--- a/hw/pci-bridge/cxl_root_port.c
+++ b/hw/pci-bridge/cxl_root_port.c
@@ -164,7 +164,9 @@ static void cxl_rp_realize(DeviceState *dev, Error **errp)
 {
     PCIDevice *pci_dev     = PCI_DEVICE(dev);
     PCIERootPortClass *rpc = PCIE_ROOT_PORT_GET_CLASS(dev);
+    PCIEPort *p            = PCIE_PORT(dev);
     CXLRootPort *crp       = CXL_ROOT_PORT(dev);
+    PCIDevice *hb_dev;
     CXLComponentState *cxl_cstate = &crp->cxl_cstate;
     ComponentRegisters *cregs = &cxl_cstate->crb;
     MemoryRegion *component_bar = &cregs->component_registers;
@@ -212,6 +214,33 @@ static void cxl_rp_realize(DeviceState *dev, Error **errp)
                      PCI_BASE_ADDRESS_SPACE_MEMORY |
                      PCI_BASE_ADDRESS_MEM_TYPE_64,
                      &crp->bar);
+    /*
+     * The Host Bridge UIO Capable bit marks all the root ports
+     * within the Host Bridge as capable of routing UIO requests
+     * (CXL 3.2 8.2.4.20.1): a root port below a pxb-cxl host bridge
+     * carries the UIO capability when the host bridge carries x-uio
+     * and its own SVC and 256-byte flit mode configuration carries
+     * it. A root port on any other bus carries no pxb-cxl host
+     * bridge above it.
+     */
+    hb_dev = pci_get_bus(pci_dev)->parent_dev;
+    crp->uio_capable = hb_dev && object_dynamic_cast(OBJECT(hb_dev),
+                                                     TYPE_PXB_CXL_DEV) &&
+                       PXB_CXL_DEV(hb_dev)->uio_capable &&
+                       p->svc && p->flitmode;
+
+    /*
+     * SVC is appended after the DVSECs so that the extended
+     * capability layout is unchanged when the port does not carry
+     * SVC.
+     */
+    if (p->svc) {
+        rc = pcie_svc_cap_init(pci_dev, cxl_cstate->dvsec_offset,
+                               p->flitmode, errp);
+        if (rc < 0) {
+            return;
+        }
+    }
 }
 
 static void cxl_rp_reset_hold(Object *obj, ResetType type)
diff --git a/hw/pci-bridge/cxl_upstream.c b/hw/pci-bridge/cxl_upstream.c
index 63d2fd54d4..a16e2e9744 100644
--- a/hw/pci-bridge/cxl_upstream.c
+++ b/hw/pci-bridge/cxl_upstream.c
@@ -414,6 +414,19 @@ static void cxl_usp_realize(PCIDevice *d, Error **errp)
         goto err_cap;
     }
 
+    if (p->svc) {
+        /*
+         * SVC is appended after the DOE capability so that the
+         * extended capability layout is unchanged when the port
+         * does not carry SVC.
+         */
+        rc = pcie_svc_cap_init(d,
+                               cxl_cstate->dvsec_offset + PCI_DOE_SIZEOF,
+                               p->flitmode, errp);
+        if (p->flitmode && rc >= 0) {
+            usp->uio_capable = true;
+        }
+    }
     return;
 
 err_cap:
@@ -441,6 +454,7 @@ static const Property cxl_upstream_props[] = {
     DEFINE_PROP_PCIE_LINK_WIDTH("x-width", CXLUpstreamPort,
                                 width, PCIE_LINK_WIDTH_16),
     DEFINE_PROP_BOOL("x-256b-flit", PCIEPort, flitmode, false),
+    DEFINE_PROP_BOOL("x-svc", PCIEPort, svc, false),
 };
 
 static void cxl_upstream_class_init(ObjectClass *oc, const void *data)
diff --git a/hw/pci-bridge/gen_pcie_root_port.c b/hw/pci-bridge/gen_pcie_root_port.c
index 2f7257d166..d4df4a7c16 100644
--- a/hw/pci-bridge/gen_pcie_root_port.c
+++ b/hw/pci-bridge/gen_pcie_root_port.c
@@ -26,6 +26,8 @@ OBJECT_DECLARE_SIMPLE_TYPE(GenPCIERootPort, GEN_PCIE_ROOT_PORT)
 #define GEN_PCIE_ROOT_PORT_AER_OFFSET           0x100
 #define GEN_PCIE_ROOT_PORT_ACS_OFFSET \
         (GEN_PCIE_ROOT_PORT_AER_OFFSET + PCI_ERR_SIZEOF)
+#define GEN_PCIE_ROOT_PORT_SVC_OFFSET \
+        (GEN_PCIE_ROOT_PORT_ACS_OFFSET + PCI_ACS_SIZEOF)
 
 #define GEN_PCIE_ROOT_PORT_MSIX_NR_VECTOR       1
 #define GEN_PCIE_ROOT_DEFAULT_IO_RANGE          4096
@@ -166,6 +168,7 @@ static void gen_rp_dev_class_init(ObjectClass *klass, const void *data)
     rpc->interrupts_uninit = gen_rp_interrupts_uninit;
     rpc->aer_offset = GEN_PCIE_ROOT_PORT_AER_OFFSET;
     rpc->acs_offset = GEN_PCIE_ROOT_PORT_ACS_OFFSET;
+    rpc->svc_offset = GEN_PCIE_ROOT_PORT_SVC_OFFSET;
 }
 
 static const TypeInfo gen_rp_dev_info = {
diff --git a/hw/pci-bridge/pcie_root_port.c b/hw/pci-bridge/pcie_root_port.c
index bc173dbf30..645394310c 100644
--- a/hw/pci-bridge/pcie_root_port.c
+++ b/hw/pci-bridge/pcie_root_port.c
@@ -68,6 +68,15 @@ static void rp_realize(PCIDevice *d, Error **errp)
     int rc;
 
     pci_config_set_interrupt_pin(d->config, 1);
+    if (!pci_is_cxl(d) && p->svc && !rpc->svc_offset) {
+        /*
+         * Only root port types with a reserved offset for the SVC
+         * capability in their extended capability space support it.
+         */
+        error_setg(errp, "%s: SVC is not supported by this port type",
+                   object_get_typename(OBJECT(d)));
+        return;
+    }
     if (d->cap_present & QEMU_PCIE_CAP_CXL) {
         pci_bridge_initfn(d, TYPE_CXL_BUS);
     } else {
@@ -120,6 +129,10 @@ static void rp_realize(PCIDevice *d, Error **errp)
     if (rpc->acs_offset && !s->disable_acs) {
         pcie_acs_init(d, rpc->acs_offset);
     }
+    if (!pci_is_cxl(d) && p->svc) {
+        pcie_svc_cap_init(d, rpc->svc_offset, p->flitmode, errp);
+    }
+
     return;
 
 err:
@@ -153,6 +166,7 @@ static const Property rp_props[] = {
                     QEMU_PCIE_SLTCAP_PCP_BITNR, true),
     DEFINE_PROP_BOOL("disable-acs", PCIESlot, disable_acs, false),
     DEFINE_PROP_BOOL("x-256b-flit", PCIEPort, flitmode, false),
+    DEFINE_PROP_BOOL("x-svc", PCIEPort, svc, false),
 };
 
 static void rp_instance_post_init(Object *obj)
diff --git a/hw/pci-bridge/xio3130_downstream.c b/hw/pci-bridge/xio3130_downstream.c
index 0c3fed3053..af4bb5dc83 100644
--- a/hw/pci-bridge/xio3130_downstream.c
+++ b/hw/pci-bridge/xio3130_downstream.c
@@ -110,6 +110,10 @@ static void xio3130_downstream_realize(PCIDevice *d, Error **errp)
     if (rc < 0) {
         goto err;
     }
+    if (p->svc) {
+        pcie_svc_cap_init(d, XIO3130_AER_OFFSET + PCI_ERR_SIZEOF,
+                          p->flitmode, errp);
+    }
 
     return;
 
@@ -137,6 +141,8 @@ static void xio3130_downstream_exitfn(PCIDevice *d)
 static const Property xio3130_downstream_props[] = {
     DEFINE_PROP_BIT(COMPAT_PROP_PCP, PCIDevice, cap_present,
                     QEMU_PCIE_SLTCAP_PCP_BITNR, true),
+    DEFINE_PROP_BOOL("x-svc", PCIEPort, svc, false),
+    DEFINE_PROP_BOOL("x-256b-flit", PCIEPort, flitmode, false),
 };
 
 static const VMStateDescription vmstate_xio3130_downstream = {
diff --git a/hw/pci-bridge/xio3130_upstream.c b/hw/pci-bridge/xio3130_upstream.c
index 40057b749b..5ba234bc06 100644
--- a/hw/pci-bridge/xio3130_upstream.c
+++ b/hw/pci-bridge/xio3130_upstream.c
@@ -24,6 +24,7 @@
 #include "hw/pci/msi.h"
 #include "hw/pci/pcie.h"
 #include "hw/pci/pcie_port.h"
+#include "hw/core/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "qemu/module.h"
 
@@ -49,9 +50,17 @@ static void xio3130_upstream_write_config(PCIDevice *d, uint32_t address,
 static void xio3130_upstream_reset(DeviceState *qdev)
 {
     PCIDevice *d = PCI_DEVICE(qdev);
+    PCIEPort *p = PCIE_PORT(d);
 
     pci_bridge_reset(qdev);
     pcie_cap_deverr_reset(d);
+    /*
+     * An upstream port is not a PCIESlot, so the link capability
+     * and status registers are filled here from the port's
+     * configuration, the way the CXL upstream port does.
+     */
+    pcie_cap_fill_link_ep_usp(d, QEMU_PCI_EXP_LNK_X1,
+                              QEMU_PCI_EXP_LNK_2_5GT, p->flitmode);
 }
 
 static void xio3130_upstream_realize(PCIDevice *d, Error **errp)
@@ -91,6 +100,10 @@ static void xio3130_upstream_realize(PCIDevice *d, Error **errp)
     if (rc < 0) {
         goto err;
     }
+    if (p->svc) {
+        pcie_svc_cap_init(d, XIO3130_AER_OFFSET + PCI_ERR_SIZEOF,
+                          p->flitmode, errp);
+    }
 
     return;
 
@@ -123,6 +136,11 @@ static const VMStateDescription vmstate_xio3130_upstream = {
     }
 };
 
+static const Property xio3130_upstream_props[] = {
+    DEFINE_PROP_BOOL("x-svc", PCIEPort, svc, false),
+    DEFINE_PROP_BOOL("x-256b-flit", PCIEPort, flitmode, false),
+};
+
 static void xio3130_upstream_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -138,6 +156,7 @@ static void xio3130_upstream_class_init(ObjectClass *klass, const void *data)
     dc->desc = "TI X3130 Upstream Port of PCI Express Switch";
     device_class_set_legacy_reset(dc, xio3130_upstream_reset);
     dc->vmsd = &vmstate_xio3130_upstream;
+    device_class_set_props(dc, xio3130_upstream_props);
 }
 
 static const TypeInfo xio3130_upstream_info = {
diff --git a/include/hw/pci/pcie_port.h b/include/hw/pci/pcie_port.h
index 1bcc734649..492721ba43 100644
--- a/include/hw/pci/pcie_port.h
+++ b/include/hw/pci/pcie_port.h
@@ -35,6 +35,9 @@ struct PCIEPort {
     /*< public >*/
     bool flitmode;
 
+    /* Streamlined Virtual Channel (SVC) capability */
+    bool svc;
+
     /* pci express switch port */
     uint8_t     port;
 };
@@ -94,6 +97,7 @@ struct PCIERootPortClass {
     int aer_offset;
     int ssvid_offset;
     int acs_offset;    /* If nonzero, optional ACS capability offset */
+    int svc_offset;    /* optional SVC capability */
     int ssid;
 };
 
-- 
2.34.1


