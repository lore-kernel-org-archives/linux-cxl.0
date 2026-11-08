Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.83.214.25
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794175696;
	b=TkhdSetCyyee3ub4vAcOn6vbDvpvYX0VwfD5oG3cWlJ8BT0JqLuM0r9eTisJWlVFEXp5
	 WeMCDK3osRshOstMcUAgSc6dSiih1DS9PBysfG/fnOYNztBXJAKJKviNs9D7y6BarLtH8
	 FwwmltIAf3XmR6mJCXS9pmNSSMfo0Gd+GdMC5oljw0pz7Z7kQuwZmQm5zareXW7eioZpO
	 X9CMW2lg8xvIEk/Royqz+XQbY0wmlWJEm4leyWV6X9mdNpHxc+88KZvHSz3LWa5r8noZu
	 CxlQ5Rj3jCUKDpLELdVncBs1P0buRNy+M33+nvt1UTLV8pnFvhaZDo9kLpRWnAKZl6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794175696;
	h=DMARC-Filter:X-Sender-Id:Received:Received:X-Sender-Id:X-MC-Relay:
	 X-MailChannels-SenderId:X-MailChannels-Auth-Id:X-Harmony-Shoe:
	 X-MC-Loop-Signature:X-MC-Ingress-Time:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=2497vGUd+yUoRIsSuqG5kZU+bOSLHbxFdTDrOIC6vCk=;
	b=eUq6Pjln+GHgaF09WP5/P+7B9BSNLrdDaZis+LC21Saou2KQg1N84U1V1mqdrKtIszCz
	 KGWVWuSTr8pBzumX/7ynSvdxNnwBSidJKwHizJXnLyp29XCvolBryzOS9p5a3bFgHQXAg
	 hm5nrcnmUspfdnYNJF1hWofXspPqFpEt8S09G7DGbr3EbiERYyOWolPF92/g3l4YL6hiJ
	 apc5/5Ctxe5OrXTtzIWQgtRX71PVmRmDLVHT2HHWlp0IdsW4kOwMK0MXOejb67mFsACKt
	 EgRIYWS548/G9JuJaMgsuc1DGT2STVt0uG1bRuD4WvnjYZf8zsukcQxykkYjHiAsXQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=stgolabs.net;
	spf=fail smtp.mailfrom=stgolabs.net;
	dkim=pass header.d=stgolabs.net header.i=@stgolabs.net header.a=rsa-sha256 header.s=dreamhost header.b=lrIwtyvv;
	arc=none smtp.remote-ip=23.83.214.25
Received: from bumble.maple.relay.mailchannels.net (bumble.maple.relay.mailchannels.net [23.83.214.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412DD606A325
	for <linux-cxl@vger.kernel.org>; Sun,  8 Nov 2026 22:08:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 412DD606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.a=rsa-sha256 header.s=dreamhost header.b=lrIwtyvv
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 6FA234C225D;
	Sun, 08 Nov 2026 22:08:08 +0000 (UTC)
Received: from pdx1-sub0-mail-a246.dreamhost.com (100-99-181-132.trex-nlb.outbound.svc.cluster.local [100.99.181.132])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 49FA94C217E;
	Sun, 08 Nov 2026 22:08:08 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Harmony-Shoe: 648b96953257cc3a_1794175688418_1336023658
X-MC-Loop-Signature: 1794175688418:3368208994
X-MC-Ingress-Time: 1794175688418
Received: from pdx1-sub0-mail-a246.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.99.181.132 (trex/8.0.2);
	Sun, 08 Nov 2026 22:08:08 +0000
Received: from offworld.tailf5af7a.ts.net (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a246.dreamhost.com (Postfix) with ESMTPSA id 4jN6VZ5lbLz1076;
	Sun,  8 Nov 2026 14:08:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1794175688;
	bh=2497vGUd+yUoRIsSuqG5kZU+bOSLHbxFdTDrOIC6vCk=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=lrIwtyvvk7wEBjbSxpZy4JoAHhYs/qiI9NnNLLaPCRhqEX4YSnmFxVPtrrdaC4p66
	 lG2H7gT37RadX+77xDgHIvwHt4hiFGLTXH/VU7e+xuKlQjxmmdeKgvmaGBtcEyCgEP
	 jTje50do99HGFLfB5oXyJFRgQ2HDkTUlhbE30hLt2KlJkdwfm1s1WVdR7uUweycQuT
	 6G6MZkfT4X6cN4qvqz3yhwSag5sD8l1hlLkee4ZKH+a4SFlI5LGE0/lojkhNwGGogn
	 N62n7KpDKhkaCliNzIZRrZqsxNEO3M1qCGC+Rzbehb1Jj5VJMgiq0iJq8G2tNoHeaC
	 2KlSCK+ARXT7g==
From: Davidlohr Bueso <dave@stgolabs.net>
To: dave.jiang@intel.com
Cc: jic23@kernel.org,
	alison.schofield@intel.com,
	ming.li@zohomail.com,
	icheng@nvidia.com,
	benjamin.cheatham@amd.com,
	linux-cxl@vger.kernel.org,
	dave@stgolabs.net,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: [PATCH v11 02/10] cxl/pci: Add BI topology enable/disable
Date: Sun,  8 Nov 2026 14:07:31 -0800
Message-Id: <613ce49db78d0ae09443dc48730eff1f6a2d0223.1794172701.git.dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1794172701.git.dave@stgolabs.net>
References: <cover.1794172701.git.dave@stgolabs.net>
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

Implement cxl_bi_setup() to enable BI flows on the device and every
component in the path, and its teardown counterpart cxl_bi_dealloc().
Setup runs from devm_cxl_endpoint_decoders_setup(), between the
port's HDM state and its decoders. Registered there, its devres
teardown brings BI down after the decoders quiesce and before the
HDM state is freed, and BI is settled before the decoders, and later
the regions, are looked at. The BI-ID and path enablement belong to
the endpoint port's lifetime.

Setup is safe in endpoint port probe context. The port probes
synchronously from cxl_mem_probe(), pinning the memdev state the
walk consumes, and the whole ancestor path already exists with BI
registers mapped (dports at dport-add time, the switch USP RT at
first-dport setup) because devm_cxl_enumerate_ports() completes
before the endpoint is created.

Dealloc is safe in endpoint devres context. Both setup and dealloc
walk the endpoint's parent_dport topology rather than getting the
port by bus lookup - an ancestor teardown delists the parent port
before the endpoint's devres runs.

The topology walk is stable as parent_dport pointers are fixed at
port creation; ancestors cannot be reaped while holding this
memdev's cxl_ep; and their own teardown frees dports only after
the endpoint is gone.

Likewise, the device state outlives the walk - cxlmd->cxlds is
nulled only after cxl_memdev_unregister() has torn the endpoint
down, and delete_endpoint() clears cxlmd->endpoint only after the
endpoint devres has run.

Each dport is programmed by its position - the one immediately above
the device takes BI Enable, every dport above it takes BI Forward
(Table 8-157, Table 9-13), at any switch depth (Table 7-97). Any
level can be shared, so nr_bi refcounts endpoints at every dport.
Registers are written on the first endpoint and cleared on the last,
but only downstream ports commit (Table 8-156), once per endpoint
(Table 8-152), and a failed commit undoes its write and commits the
undo. A USP advertising a BI Route Table that failed to map is
refused rather than treated as absent. nr_bi counts only the
endpoints this driver enabled; a level firmware brought up is kept,
see below.

A device firmware already enabled is taken up as found, with no
write.

A reset may wipe the device's BI Enable, whose reset default is 0
(Table 8-157). .reset_done reads the hardware rather than assume
which reset ran, and invalidates cxlds->bi, failing closed with
recovery by rebind as for decoder loss; dealloc unwinds the dport
refcounts regardless. It also clears cxlds->bi unconditionally - the
endpoint disable fails when the hardware already shows BI Enable
clear, from a reset .reset_done never saw, and the flag must not
outlive the BI Decoder mapping it describes, which the endpoint port
releases moments later.

With dealloc in the endpoint's devres, delete_endpoint() already
holds the parent port's device lock, so to avoid deadlocking, add a
per-port bi_lock, serializing the dports that share state (nr_bi and
the control register at any shared level, the switch USP's BI RT).

A locked HDM decoder is the main reason release cannot simply turn BI
off: once committed with Lock On Commit set (CXL 4.0 8.2.4.20.13) it
cannot be reset, so it keeps decoding after this driver lets go, as
does a committed decoder that never joined a region. While its BI bit
is set, the device still needs BI Enable to snoop that range.

So setup's unwind and teardown share one release, which reads the
decoders from the hardware. If one is still committed with BI set,
the device keeps BI Enable and every level on its path is held: each
level's nr_bi reference is dropped, but a held level is never
cleared, so a rebind finds the path enabled. An unwind holds nothing,
since the device's BI was never taken up.

A level found already up, with nothing this driver enabled below it,
is held too: firmware may have brought it up, or its dport was
re-created and cannot tell whether a device below still decodes. Only
a level this driver brought up from zero is ever cleared.

The BI Decoder mapping belongs to the endpoint port, which an unbind
of that port alone releases, so .reset_done reads it only while
holding the port with its driver still bound.

Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
Reviewed-by: Li Ming <ming.li@zohomail.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 drivers/cxl/core/core.h |   8 +
 drivers/cxl/core/hdm.c  |  42 ++++
 drivers/cxl/core/pci.c  | 473 ++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/core/port.c |   1 +
 drivers/cxl/cxl.h       |  34 +++
 drivers/cxl/pci.c       |   8 +-
 include/cxl/cxl.h       |   2 +
 7 files changed, 566 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 73478ebaf47e..72be96df57f5 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -206,9 +206,17 @@ static inline void devm_cxl_dport_ras_setup(struct cxl_dport *dport) { }
 int cxl_gpf_port_setup(struct cxl_dport *dport);
 void devm_cxl_dport_bi_setup(struct cxl_dport *dport);
 
+static inline bool cxl_bi_decoder_enabled(struct cxl_port *port)
+{
+	return FIELD_GET(CXL_BI_DECODER_CTRL_BI_ENABLE,
+			 readl(port->regs.bi_decoder +
+			       CXL_BI_DECODER_CTRL_OFFSET));
+}
+
 struct cxl_hdm;
 int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
 			struct cxl_endpoint_dvsec_info *info);
+bool cxl_hdm_bi_committed(struct cxl_port *endpoint);
 int cxl_port_get_possible_dports(struct cxl_port *port);
 
 #ifdef CONFIG_CXL_FEATURES
diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index fdcef20e01ba..f8fe1b12de3d 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -191,6 +191,38 @@ static struct cxl_hdm *devm_cxl_setup_hdm(struct cxl_port *port,
 	return cxlhdm;
 }
 
+/*
+ * Whether any of the endpoint's HDM decoders still decodes with its BI
+ * bit set, read from the hardware: a decoder can outlive the driver's
+ * teardown committed, whether locked, in a region that is never reset,
+ * or never in a region at all.
+ */
+bool cxl_hdm_bi_committed(struct cxl_port *endpoint)
+{
+	struct cxl_hdm *cxlhdm = dev_get_drvdata(&endpoint->dev);
+	void __iomem *hdm;
+	u32 ctrl;
+	int i;
+
+	if (!cxlhdm || !cxlhdm->regs.hdm_decoder)
+		return false;
+	hdm = cxlhdm->regs.hdm_decoder;
+
+	/* nothing decodes with decoding off, emulated, or the device gone */
+	ctrl = readl(hdm + CXL_HDM_DECODER_CTRL_OFFSET);
+	if (ctrl == U32_MAX || !(ctrl & CXL_HDM_DECODER_ENABLE))
+		return false;
+
+	for (i = 0; i < cxlhdm->decoder_count; i++) {
+		ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(i));
+		if ((ctrl & CXL_HDM_DECODER0_CTRL_COMMITTED) &&
+		    (ctrl & CXL_HDM_DECODER0_CTRL_BI))
+			return true;
+	}
+
+	return false;
+}
+
 static void __cxl_dpa_debug(struct seq_file *file, struct resource *r, int depth)
 {
 	unsigned long long start = r->start, end = r->end;
@@ -1358,6 +1390,16 @@ int devm_cxl_endpoint_decoders_setup(struct cxl_port *port)
 	if (rc)
 		return rc;
 
+	/*
+	 * Between the port's HDM state and its decoders: devres,
+	 * unwinding in reverse, brings BI down only after the decoders
+	 * quiesce, while its slow walk still precedes the HDM state
+	 * free.
+	 */
+	rc = cxl_bi_setup(port);
+	if (rc)
+		dev_dbg(&port->dev, "BI setup failed rc=%d\n", rc);
+
 	return devm_cxl_enumerate_decoders(cxlhdm, &info);
 }
 EXPORT_SYMBOL_NS_GPL(devm_cxl_endpoint_decoders_setup, "CXL");
diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 80fda8acdf17..c443abb57c93 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -2,12 +2,14 @@
 /* Copyright(c) 2021 Intel Corporation. All rights reserved. */
 #include <linux/units.h>
 #include <linux/io-64-nonatomic-lo-hi.h>
+#include <linux/iopoll.h>
 #include <linux/device.h>
 #include <linux/delay.h>
 #include <linux/pci.h>
 #include <linux/pci-doe.h>
 #include <cxl/pci.h>
 #include <linux/aer.h>
+#include <linux/string_choices.h>
 #include <cxlpci.h>
 #include <cxlmem.h>
 #include <cxl.h>
@@ -987,3 +989,474 @@ void devm_cxl_dport_bi_setup(struct cxl_dport *dport)
 		break;
 	}
 }
+
+/*
+ * BI requires 256B Flit operation on the link. RP/DSP/endpoint must
+ * also have the BI Decoder cap mapped (@bi); for USPs the BI RT cap
+ * is optional per CXL 4.0 8.2.4.26, so absent @bi is allowed.
+ */
+static bool cxl_is_bi_capable(struct pci_dev *pdev, void __iomem *bi)
+{
+	if (!cxl_pci_flit_256(pdev))
+		return false;
+
+	if (pci_pcie_type(pdev) != PCI_EXP_TYPE_UPSTREAM && !bi) {
+		dev_dbg(&pdev->dev, "No BI Decoder registers.\n");
+		return false;
+	}
+
+	return true;
+}
+
+/* limit any insane timeouts from hw */
+#define CXL_BI_COMMIT_MAXTMO_US (20 * USEC_PER_SEC)
+
+static unsigned long __cxl_bi_get_timeout_us(struct device *dev,
+					     unsigned int scale,
+					     unsigned int base)
+{
+	static const unsigned long scale_tbl[] = {
+		1, 10, 100, 1000, 10000, 100000, 1000000, 10000000,
+	};
+
+	if (scale >= ARRAY_SIZE(scale_tbl) || !base) {
+		dev_dbg(dev, "Invalid BI commit timeout: scale=%u base=%u\n",
+			scale, base);
+		return CXL_BI_COMMIT_MAXTMO_US;
+	}
+
+	return scale_tbl[scale] * base;
+}
+
+static int __cxl_bi_wait_commit(struct device *dev, void __iomem *status_reg,
+				u32 committed_bit, u32 err_bit,
+				unsigned int scale, unsigned int base)
+{
+	unsigned long tmo_us, poll_us;
+	ktime_t start;
+	u32 status;
+	int rc;
+
+	tmo_us = min_t(unsigned long, CXL_BI_COMMIT_MAXTMO_US,
+		       __cxl_bi_get_timeout_us(dev, scale, base));
+	poll_us = max_t(unsigned long, tmo_us / 10, 1); /* ~10% */
+	start = ktime_get();
+
+	rc = readx_poll_timeout(readl, status_reg, status,
+				status & (committed_bit | err_bit),
+				poll_us, tmo_us);
+	if (rc) {
+		dev_err(dev, "BI-ID commit timed out (%luus)\n", tmo_us);
+		return rc; /* -ETIMEDOUT */
+	}
+
+	if (status & err_bit) {
+		dev_err(dev, "BI-ID commit rejected by hardware\n");
+		return -EIO;
+	}
+
+	dev_dbg(dev, "BI-ID commit wait took %lluus\n",
+		ktime_to_us(ktime_sub(ktime_get(), start)));
+	return 0;
+}
+
+/* BI RT only exists on switch upstream ports. */
+static int __cxl_bi_commit_rt(struct device *dev, void __iomem *bi)
+{
+	u32 status, ctrl;
+	unsigned int scale, base;
+
+	if (!FIELD_GET(CXL_BI_RT_CAPS_EXPLICIT_COMMIT_REQ,
+		       readl(bi + CXL_BI_RT_CAPS_OFFSET)))
+		return 0;
+
+	ctrl = readl(bi + CXL_BI_RT_CTRL_OFFSET);
+	writel(ctrl & ~CXL_BI_RT_CTRL_BI_COMMIT, bi + CXL_BI_RT_CTRL_OFFSET);
+	writel(ctrl | CXL_BI_RT_CTRL_BI_COMMIT, bi + CXL_BI_RT_CTRL_OFFSET);
+
+	status = readl(bi + CXL_BI_RT_STATUS_OFFSET);
+	scale = FIELD_GET(CXL_BI_RT_STATUS_BI_COMMIT_TM_SCALE, status);
+	base = FIELD_GET(CXL_BI_RT_STATUS_BI_COMMIT_TM_BASE, status);
+
+	return __cxl_bi_wait_commit(dev, bi + CXL_BI_RT_STATUS_OFFSET,
+				    CXL_BI_RT_STATUS_BI_COMMITTED,
+				    CXL_BI_RT_STATUS_BI_ERR_NOT_COMMITTED,
+				    scale, base);
+}
+
+static int __cxl_bi_commit_decoder(struct device *dev, void __iomem *bi)
+{
+	u32 status, ctrl;
+	unsigned int scale, base;
+
+	if (!FIELD_GET(CXL_BI_DECODER_CAPS_EXPLICIT_COMMIT_REQ,
+		       readl(bi + CXL_BI_DECODER_CAPS_OFFSET)))
+		return 0;
+
+	ctrl = readl(bi + CXL_BI_DECODER_CTRL_OFFSET);
+	writel(ctrl & ~CXL_BI_DECODER_CTRL_BI_COMMIT,
+	       bi + CXL_BI_DECODER_CTRL_OFFSET);
+	writel(ctrl | CXL_BI_DECODER_CTRL_BI_COMMIT,
+	       bi + CXL_BI_DECODER_CTRL_OFFSET);
+
+	status = readl(bi + CXL_BI_DECODER_STATUS_OFFSET);
+	scale = FIELD_GET(CXL_BI_DECODER_STATUS_BI_COMMIT_TM_SCALE, status);
+	base = FIELD_GET(CXL_BI_DECODER_STATUS_BI_COMMIT_TM_BASE, status);
+
+	return __cxl_bi_wait_commit(dev, bi + CXL_BI_DECODER_STATUS_OFFSET,
+				    CXL_BI_DECODER_STATUS_BI_COMMITTED,
+				    CXL_BI_DECODER_STATUS_BI_ERR_NOT_COMMITTED,
+				    scale, base);
+}
+
+static int cxl_bi_commit_dport(struct cxl_dport *dport)
+{
+	struct cxl_port *port = dport->port;
+	int rc;
+
+	lockdep_assert_held(&port->bi_lock);
+
+	/* root ports never require the explicit commit */
+	if (pci_pcie_type(to_pci_dev(dport->dport_dev)) !=
+	    PCI_EXP_TYPE_DOWNSTREAM)
+		return 0;
+
+	rc = __cxl_bi_commit_decoder(dport->dport_dev, dport->regs.bi_decoder);
+	if (rc)
+		return rc;
+
+	if (port->regs.bi_rt)
+		rc = __cxl_bi_commit_rt(&port->dev, port->regs.bi_rt);
+
+	return rc;
+}
+
+/*
+ * Enable BI-ID changes in the given level of the topology.
+ * @direct says the device is connected directly to this dport, which
+ * takes BI Enable; every dport above it takes BI Forward.
+ */
+static int cxl_bi_ctrl_dport_enable(struct cxl_dport *dport, bool direct)
+{
+	struct cxl_port *port = dport->port;
+	u32 ctrl, value, set, clr;
+	void __iomem *bi;
+	int rc;
+
+	guard(mutex)(&port->bi_lock);
+
+	bi = dport->regs.bi_decoder;
+	if (!bi)
+		return -EINVAL;
+
+	ctrl = readl(bi + CXL_BI_DECODER_CTRL_OFFSET);
+
+	/*
+	 * First reference through a level already up: firmware brought
+	 * it up, or this driver did for a device it let go of while it
+	 * still decoded with BI, which a dport re-created since cannot
+	 * otherwise know. Either way it is not this driver's to take
+	 * down: only a level it brought up from zero is ever cleared.
+	 */
+	if (!dport->nr_bi &&
+	    (ctrl & (CXL_BI_DECODER_CTRL_BI_FW | CXL_BI_DECODER_CTRL_BI_ENABLE)))
+		dport->bi_held = true;
+
+	set = direct ? CXL_BI_DECODER_CTRL_BI_ENABLE :
+		       CXL_BI_DECODER_CTRL_BI_FW;
+	clr = direct ? CXL_BI_DECODER_CTRL_BI_FW :
+		       CXL_BI_DECODER_CTRL_BI_ENABLE;
+
+	value = (ctrl | set) & ~clr;
+	if (value != ctrl)
+		writel(value, bi + CXL_BI_DECODER_CTRL_OFFSET);
+
+	/* owed per new device below, not per register change */
+	rc = cxl_bi_commit_dport(dport);
+	if (rc) {
+		if (value != ctrl) {
+			/* the undo is a BI-ID change owing its own commit */
+			writel(ctrl, bi + CXL_BI_DECODER_CTRL_OFFSET);
+			cxl_bi_commit_dport(dport);
+		}
+		return rc;
+	}
+	dport->nr_bi++;
+
+	return 0;
+}
+
+/*
+ * Dealloc BI-ID changes in the given level of the topology. Called
+ * once per endpoint that enabled this level: on teardown, or to
+ * unwind a path that failed partway up. @hold marks the level for a
+ * device below that still decodes with BI, so that no teardown
+ * reaching zero clears it.
+ */
+static int cxl_bi_ctrl_dport_disable(struct cxl_dport *dport, bool hold)
+{
+	struct cxl_port *port = dport->port;
+	void __iomem *bi;
+	u32 ctrl;
+
+	guard(mutex)(&port->bi_lock);
+
+	bi = dport->regs.bi_decoder;
+	if (!bi)
+		return -EINVAL;
+
+	if (WARN_ON_ONCE(dport->nr_bi == 0))
+		return -EINVAL;
+
+	if (hold)
+		dport->bi_held = true;
+
+	/* others below still need this level */
+	if (--dport->nr_bi > 0)
+		return 0;
+
+	/* found up, or a device below still decodes with BI */
+	if (dport->bi_held)
+		return 0;
+
+	ctrl = readl(bi + CXL_BI_DECODER_CTRL_OFFSET);
+	writel(ctrl & ~(CXL_BI_DECODER_CTRL_BI_FW |
+			CXL_BI_DECODER_CTRL_BI_ENABLE),
+	       bi + CXL_BI_DECODER_CTRL_OFFSET);
+
+	return cxl_bi_commit_dport(dport);
+}
+
+static int __cxl_bi_ctrl_endpoint(struct cxl_dev_state *cxlds, bool enable)
+{
+	struct cxl_port *endpoint = cxlds->cxlmd->endpoint;
+	void __iomem *bi = endpoint->regs.bi_decoder;
+	u32 ctrl;
+
+	if (!bi)
+		return -EINVAL;
+
+	ctrl = readl(bi + CXL_BI_DECODER_CTRL_OFFSET);
+
+	if (enable) {
+		if (FIELD_GET(CXL_BI_DECODER_CTRL_BI_ENABLE, ctrl)) {
+			if (!cxlds->bi) /* adopt firmware enabled */
+				dev_dbg(cxlds->dev,
+					"adopting firmware-enabled BI\n");
+			goto done;
+		}
+	} else {
+		if (!FIELD_GET(CXL_BI_DECODER_CTRL_BI_ENABLE, ctrl)) {
+			if (!cxlds->bi)
+				return 0;
+			dev_err(cxlds->dev,
+				"BI already disabled in hardware\n");
+			return -EBUSY;
+		}
+	}
+
+	FIELD_MODIFY(CXL_BI_DECODER_CTRL_BI_ENABLE, &ctrl, enable);
+	writel(ctrl, bi + CXL_BI_DECODER_CTRL_OFFSET);
+
+	dev_dbg(cxlds->dev, "BI requests %s\n", str_enabled_disabled(enable));
+done:
+	cxlds->bi = enable;
+	return 0;
+}
+
+static int cxl_bi_ctrl_endpoint_enable(struct cxl_dev_state *cxlds)
+{
+	return __cxl_bi_ctrl_endpoint(cxlds, true);
+}
+
+static int cxl_bi_ctrl_endpoint_disable(struct cxl_dev_state *cxlds)
+{
+	return __cxl_bi_ctrl_endpoint(cxlds, false);
+}
+
+/*
+ * Release the device's BI, then each dport up the path short of @stop,
+ * following the deallocate sequence in the implementation notes of
+ * CXL 4.0 9.14.2. Setup's unwind and teardown alike.
+ *
+ * A decoder that still decodes with its BI bit set needs BI Enable,
+ * the device-wide permission behind it, so the device keeps it. The
+ * references are still released - @nr_bi has to stay true to the
+ * endpoints below - and each level is held instead, so a later
+ * teardown reaching zero leaves it alone. An unwind never holds: the
+ * walk failed before the device's BI was taken up, so no path is left
+ * to keep up for it.
+ */
+static void cxl_bi_release(struct cxl_dev_state *cxlds, struct cxl_dport *stop)
+{
+	struct cxl_port *endpoint = cxlds->cxlmd->endpoint;
+	bool live = cxl_hdm_bi_committed(endpoint);
+	bool hold = live && cxlds->bi;
+	struct cxl_dport *dport_iter;
+	struct cxl_port *port_iter;
+
+	/* only the binding that took up the device's BI releases it */
+	if (cxlds->bi && !live)
+		cxl_bi_ctrl_endpoint_disable(cxlds);
+	cxlds->bi = false;
+
+	/*
+	 * Walk the same parent_dport chain that enabled the path. A bus
+	 * lookup cannot stand in for it: an ancestor-driven teardown
+	 * delists the parent port before this devres action runs.
+	 */
+	dport_iter = endpoint->parent_dport;
+	port_iter = dport_iter->port;
+	while (!is_cxl_root(port_iter) && dport_iter != stop) {
+		int rc = cxl_bi_ctrl_dport_disable(dport_iter, hold);
+
+		/* best effort */
+		if (rc)
+			dev_dbg(&port_iter->dev,
+				"BI dport disable failed: %d\n", rc);
+
+		dport_iter = port_iter->parent_dport;
+		port_iter = dport_iter->port;
+	}
+}
+
+/*
+ * devm teardown on endpoint port destruction. Registered before the
+ * decoders, so devres runs it after them: regions are detached and
+ * decoders unregistered by the time BI comes down.
+ */
+static void cxl_bi_dealloc(void *data)
+{
+	struct cxl_port *endpoint = data;
+	struct cxl_memdev *cxlmd = to_cxl_memdev(endpoint->uport_dev);
+
+	cxl_bi_release(cxlmd->cxlds, NULL);
+}
+
+/*
+ * Enable BI on every dport in the path, then on the device itself,
+ * following the allocate sequence in the implementation notes of
+ * CXL 4.0 9.14.2. On failure, unwind only the dports that enabled.
+ */
+static int cxl_bi_enable_path(struct cxl_dev_state *cxlds,
+			      struct cxl_port *port, struct cxl_dport *dport)
+{
+	struct cxl_dport *dport_iter;
+	struct cxl_port *port_iter;
+	int rc;
+
+	port_iter = port;
+	dport_iter = dport;
+	while (!is_cxl_root(port_iter)) {
+		rc = cxl_bi_ctrl_dport_enable(dport_iter, dport_iter == dport);
+		if (rc)
+			goto err_rollback;
+
+		dport_iter = port_iter->parent_dport;
+		port_iter = dport_iter->port;
+	}
+
+	rc = cxl_bi_ctrl_endpoint_enable(cxlds);
+	if (rc)
+		goto err_rollback;
+
+	return 0;
+
+err_rollback:
+	/* the failed level, and any above it, took no reference */
+	cxl_bi_release(cxlds, dport_iter);
+	return rc;
+}
+
+/*
+ * An SBR wipes the device's BI Enable; an FLR leaves it alone.
+ * The check is against the hardware, not decoder state: BI is
+ * enabled at probe, so it can be wiped with no decoder ever
+ * committed. A wipe invalidates the software state; BI is never
+ * re-enabled here.
+ */
+void cxl_bi_reset_detected(struct cxl_port *endpoint)
+{
+	struct cxl_memdev *cxlmd = to_cxl_memdev(endpoint->uport_dev);
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+
+	/*
+	 * The BI Decoder mapping belongs to the endpoint port, and an
+	 * unbind of that port alone releases it: hold the port while it
+	 * is read, and read nothing once the port driver is gone.
+	 */
+	guard(device)(&endpoint->dev);
+	if (!endpoint->dev.driver)
+		return;
+
+	if (!READ_ONCE(cxlds->bi))
+		return;
+
+	if (cxl_bi_decoder_enabled(endpoint))
+		return;
+
+	dev_warn(cxlds->dev, "BI disabled by reset\n");
+	WRITE_ONCE(cxlds->bi, false);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_bi_reset_detected, "CXL");
+
+int cxl_bi_setup(struct cxl_port *endpoint)
+{
+	struct cxl_memdev *cxlmd = to_cxl_memdev(endpoint->uport_dev);
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+	struct cxl_dport *dport = endpoint->parent_dport;
+	struct cxl_dport *dport_iter;
+	struct cxl_port *port_iter;
+	int rc;
+
+	if (!dev_is_pci(cxlds->dev))
+		return 0;
+
+	/* BI is VH-only */
+	if (cxlds->rcd)
+		return 0;
+
+	if (!cxl_is_bi_capable(to_pci_dev(cxlds->dev),
+			       endpoint->regs.bi_decoder))
+		return 0;
+
+	port_iter = dport->port;
+	dport_iter = dport;
+	while (!is_cxl_root(port_iter)) {
+		/* check rp, dsp */
+		if (!cxl_is_bi_capable(to_pci_dev(dport_iter->dport_dev),
+				       dport_iter->regs.bi_decoder)) {
+			dev_dbg(cxlds->dev, "BI not supported by topology\n");
+			return 0;
+		}
+
+		/* check usp */
+		if (dev_is_pci(port_iter->uport_dev) &&
+		    pci_pcie_type(to_pci_dev(port_iter->uport_dev)) ==
+			    PCI_EXP_TYPE_UPSTREAM) {
+			if (!cxl_is_bi_capable(to_pci_dev(port_iter->uport_dev),
+					       NULL)) {
+				dev_dbg(cxlds->dev,
+					"BI not supported by USP\n");
+				return 0;
+			}
+			if (port_iter->reg_map.component_map.bi_rt.valid &&
+			    !port_iter->regs.bi_rt) {
+				dev_dbg(cxlds->dev,
+					"BI RT advertised but unmapped\n");
+				return 0;
+			}
+		}
+
+		dport_iter = port_iter->parent_dport;
+		port_iter = dport_iter->port;
+	}
+
+	rc = cxl_bi_enable_path(cxlds, dport->port, dport);
+	if (rc)
+		return rc;
+
+	return devm_add_action_or_reset(&endpoint->dev, cxl_bi_dealloc,
+					endpoint);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_bi_setup, "CXL");
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 3371b2d9ba9a..5c33fcb5240f 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -751,6 +751,7 @@ static struct cxl_port *cxl_port_alloc(struct device *uport_dev,
 	xa_init(&port->dports);
 	xa_init(&port->endpoints);
 	xa_init(&port->regions);
+	mutex_init(&port->bi_lock);
 	port->component_reg_phys = CXL_RESOURCE_NONE;
 
 	device_initialize(dev);
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 33fadf4dda52..f22478c340bd 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -75,6 +75,7 @@ extern const struct nvdimm_security_ops *cxl_security_ops;
 #define   CXL_HDM_DECODER0_CTRL_COMMITTED BIT(10)
 #define   CXL_HDM_DECODER0_CTRL_COMMIT_ERROR BIT(11)
 #define   CXL_HDM_DECODER0_CTRL_HOSTONLY BIT(12)
+#define   CXL_HDM_DECODER0_CTRL_BI BIT(13)
 #define CXL_HDM_DECODER0_TL_LOW(i) (0x20 * (i) + 0x24)
 #define CXL_HDM_DECODER0_TL_HIGH(i) (0x20 * (i) + 0x28)
 /* Target list capacity, i.e. max interleave ways for a non-endpoint decoder */
@@ -185,6 +186,31 @@ static inline int ways_to_eiw(unsigned int ways, u8 *eiw)
 #define CXL_HEADERLOG_TRACE_SIZE SZ_512
 #define CXL_HEADERLOG_TRACE_SIZE_U32 (CXL_HEADERLOG_TRACE_SIZE / sizeof(u32))
 
+/* CXL 4.0 8.2.4.26 CXL BI Route Table Capability Structure */
+#define CXL_BI_RT_CAPS_OFFSET 0x0
+#define   CXL_BI_RT_CAPS_EXPLICIT_COMMIT_REQ BIT(0)
+#define CXL_BI_RT_CTRL_OFFSET 0x4
+#define   CXL_BI_RT_CTRL_BI_COMMIT BIT(0)
+#define CXL_BI_RT_STATUS_OFFSET 0x8
+#define   CXL_BI_RT_STATUS_BI_COMMITTED BIT(0)
+#define   CXL_BI_RT_STATUS_BI_ERR_NOT_COMMITTED BIT(1)
+#define   CXL_BI_RT_STATUS_BI_COMMIT_TM_SCALE GENMASK(11, 8)
+#define   CXL_BI_RT_STATUS_BI_COMMIT_TM_BASE GENMASK(15, 12)
+
+/* CXL 4.0 8.2.4.27 CXL BI Decoder Capability Structure */
+#define CXL_BI_DECODER_CAPS_OFFSET 0x0
+#define   CXL_BI_DECODER_CAPS_HDMD_CAP BIT(0)
+#define   CXL_BI_DECODER_CAPS_EXPLICIT_COMMIT_REQ BIT(1)
+#define CXL_BI_DECODER_CTRL_OFFSET 0x4
+#define   CXL_BI_DECODER_CTRL_BI_FW BIT(0)
+#define   CXL_BI_DECODER_CTRL_BI_ENABLE BIT(1)
+#define   CXL_BI_DECODER_CTRL_BI_COMMIT BIT(2)
+#define CXL_BI_DECODER_STATUS_OFFSET 0x8
+#define   CXL_BI_DECODER_STATUS_BI_COMMITTED BIT(0)
+#define   CXL_BI_DECODER_STATUS_BI_ERR_NOT_COMMITTED BIT(1)
+#define   CXL_BI_DECODER_STATUS_BI_COMMIT_TM_SCALE GENMASK(11, 8)
+#define   CXL_BI_DECODER_STATUS_BI_COMMIT_TM_BASE GENMASK(15, 12)
+
 /* CXL 2.0 8.2.8.1 Device Capabilities Array Register */
 #define CXLDEV_CAP_ARRAY_OFFSET 0x0
 #define   CXLDEV_CAP_ARRAY_CAP_ID 0
@@ -584,6 +610,7 @@ struct cxl_dax_region {
  * @decoder_ida: allocator for decoder ids
  * @reg_map: component and ras register mapping parameters
  * @regs: mapped component registers
+ * @bi_lock: serializes BI Decoder/RT state of this port's dports
  * @nr_dports: number of entries in @dports
  * @hdm_end: track last allocated HDM decoder instance for allocation ordering
  * @commit_end: cursor to track highest committed decoder for commit ordering
@@ -606,6 +633,7 @@ struct cxl_port {
 	struct ida decoder_ida;
 	struct cxl_register_map reg_map;
 	struct cxl_component_regs regs;
+	struct mutex bi_lock; /* dport BI state shared below this port */
 	int nr_dports;
 	int hdm_end;
 	int commit_end;
@@ -669,6 +697,8 @@ struct cxl_rcrb_info {
  * @coord: access coordinates (bandwidth and latency performance attributes)
  * @link_latency: calculated PCIe downstream latency
  * @gpf_dvsec: Cached GPF port DVSEC
+ * @nr_bi: number of BI-enabled endpoints below this dport
+ * @bi_held: found up on first use, or kept up for a device below: never cleared
  */
 struct cxl_dport {
 	struct device *dport_dev;
@@ -681,6 +711,8 @@ struct cxl_dport {
 	struct access_coordinate coord[ACCESS_COORDINATE_MAX];
 	long link_latency;
 	int gpf_dvsec;
+	int nr_bi;
+	bool bi_held;
 };
 
 /**
@@ -953,6 +985,8 @@ void cxl_coordinates_combine(struct access_coordinate *out,
 			     struct access_coordinate *c2);
 
 bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port);
+int cxl_bi_setup(struct cxl_port *endpoint);
+void cxl_bi_reset_detected(struct cxl_port *endpoint);
 struct cxl_dport *devm_cxl_add_dport_by_dev(struct cxl_port *port,
 					    struct device *dport_dev);
 
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 3ed7c3e70042..0fa97350fc88 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -1117,8 +1117,12 @@ static void cxl_reset_done(struct pci_dev *pdev)
 	if (!cxlmd->dev.driver)
 		return;
 
-	if (cxlmd->endpoint &&
-	    cxl_endpoint_decoder_reset_detected(cxlmd->endpoint)) {
+	if (!cxlmd->endpoint)
+		return;
+
+	cxl_bi_reset_detected(cxlmd->endpoint);
+
+	if (cxl_endpoint_decoder_reset_detected(cxlmd->endpoint)) {
 		device_for_each_child(&cxlmd->endpoint->dev, NULL,
 				      cxl_endpoint_decoder_clear_reset_flags);
 
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index 1df75fdefbfa..37a373eeb283 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -195,6 +195,7 @@ struct cxl_dpa_partition {
  * @regs: Parsed register blocks
  * @cxl_dvsec: Offset to the PCIe device DVSEC
  * @rcd: operating in RCD mode (CXL 3.0 9.11.8 CXL Devices Attached to an RCH)
+ * @bi: device is BI (Back-Invalidate) enabled
  * @media_ready: Indicate whether the device media is usable
  * @dpa_res: Overall DPA resource tree for the device
  * @part: DPA partition array
@@ -214,6 +215,7 @@ struct cxl_dev_state {
 	struct cxl_device_regs regs;
 	int cxl_dvsec;
 	bool rcd;
+	bool bi;
 	bool media_ready;
 	struct resource dpa_res;
 	struct cxl_dpa_partition part[CXL_NR_PARTITIONS_MAX];
-- 
2.39.5

