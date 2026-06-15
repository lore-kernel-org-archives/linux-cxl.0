Received: from rusty.tulip.relay.mailchannels.net (rusty.tulip.relay.mailchannels.net [23.83.218.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25B8405C40
	for <linux-cxl@vger.kernel.org>; Mon, 15 Jun 2026 15:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.218.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781537561; cv=none; b=Xc71ffuxcesVtuull5uSg0J2QsmSDoFpnlnmw/W8/bOtFauskAx1nf3x795km4h2o/LuqTr9YojVfridbAKnmZd4SAsYF7C2T2TTInHBiOwq+TFgtwJ0w+MynDQ2ln6jB/gafFg/kpzuVrcK0ZvAxswuhS8DPb6QNPwzc/WDLko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781537561; c=relaxed/simple;
	bh=iaLdE1+SWyfLAaF3T/1SnnPGO/q3RI2wNK5KyJeRqhA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CVbZOzMcK+xLZLj3G16+hEmGPnC42STeezjEh/ls9s85YAO0x3NGEUPbTQrr3E8COu+8I62OE9vZD+gBKQuxUCIm4VQiEbUXLw7TAVOAibrpyogQvGv62gJoKr8u4+0jOPy9BIcowbpU3Yx/8TMCQU4oc3cX/n+ud2azr+RO8/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=DtqORRCs; arc=none smtp.client-ip=23.83.218.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="DtqORRCs"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 2F9804C1DAA;
	Mon, 15 Jun 2026 14:56:03 +0000 (UTC)
Received: from pdx1-sub0-mail-a208.dreamhost.com (trex-green-0.trex.outbound.svc.cluster.local [100.96.6.86])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 1E3664C24AB;
	Mon, 15 Jun 2026 14:56:02 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Plucky-Spot: 6eb77b8a24a1d68d_1781535363153_1042553860
X-MC-Loop-Signature: 1781535363153:2546548895
X-MC-Ingress-Time: 1781535363153
Received: from pdx1-sub0-mail-a208.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.96.6.86 (trex/7.1.5);
	Mon, 15 Jun 2026 14:56:03 +0000
Received: from offworld.lan (unknown [138.84.34.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a208.dreamhost.com (Postfix) with ESMTPSA id 4gfCqM0sHlz1gK;
	Mon, 15 Jun 2026 07:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1781535361;
	bh=qlIFbAzBh2qnt0nMEWCH6bSkV4Vla2+4eCTbvGuIUmU=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=DtqORRCsQ7AyBQb5P+450YZC6aIGwT/ukQHOxNgu0GFGuoUPpzbeVa+Gfhxo7IaHD
	 5gMvhxU8KY6VJqTYcfHkPOap/dyc0VvfykwOI3/5LTzs8DarbwiS+Ju6ISOZ2DYPvM
	 VltxURRbkfRh3Hcy3s1snFpS8bMv4VJCFKa1vov4JKv5SfLzh2D6EYZ9xbo1ZcPfR9
	 1zei8NnD4jcScsBCHRVxhlP1uMZcC0l7DmhRWSefBKdhFTedoRRfSPakSUMsqWfnhZ
	 TqhhY7JoTNhcmDpXNHJchFGuh5mm2douDoBXTk8wt2WZR/bKKpQLKDVRIAnTBgiNXh
	 7kGeRsMrrSJkw==
From: Davidlohr Bueso <dave@stgolabs.net>
To: dave.jiang@intel.com,
	djbw@kernel.org
Cc: jic23@kernel.org,
	benjamin.cheatham@amd.com,
	icheng@nvidia.com,
	alucerop@amd.com,
	alison.schofield@intel.com,
	gourry@gourry.net,
	dongjoo.seo1@samsung.com,
	dave@stgolabs.net,
	linux-cxl@vger.kernel.org
Subject: [PATCH v5 2/5] cxl/pci: Add BI topology enable/disable
Date: Mon, 15 Jun 2026 07:55:26 -0700
Message-Id: <20260615145529.13848-3-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260615145529.13848-1-dave@stgolabs.net>
References: <20260615145529.13848-1-dave@stgolabs.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement cxl_bi_setup(), which walks the CXL port topology to enable
BI flows on the device and every component in the path between the
device and the root port. The walk is two-pass: first to verify each
component advertises BI capability, then to write BI Enable on each
dport's BI Decoder Control register and on the device. On failure
during the enable pass, partially-enabled dports are rolled back.

The teardown counterpart, cxl_bi_dealloc(), runs automatically on
cxl_mem unbind.

cxl_bi_setup() does not touch HDM decoder configuration -- the BI bit
in each decoder is programmed separately at commit time. After a
successful setup the device is BI-capable but not yet using BI for
decode coherence.

Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 drivers/cxl/core/pci.c | 366 +++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxl.h      |  28 ++++
 drivers/cxl/mem.c      |   4 +
 include/cxl/cxl.h      |   2 +
 4 files changed, 400 insertions(+)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index e4338fd7e01b..cdb741d09b9e 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -2,11 +2,13 @@
 /* Copyright(c) 2021 Intel Corporation. All rights reserved. */
 #include <linux/units.h>
 #include <linux/io-64-nonatomic-lo-hi.h>
+#include <linux/iopoll.h>
 #include <linux/device.h>
 #include <linux/delay.h>
 #include <linux/pci.h>
 #include <linux/pci-doe.h>
 #include <linux/aer.h>
+#include <linux/string_choices.h>
 #include <cxlpci.h>
 #include <cxlmem.h>
 #include <cxl.h>
@@ -926,3 +928,367 @@ int cxl_port_get_possible_dports(struct cxl_port *port)
 
 	return ctx.count;
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
+	if (pci_pcie_type(pdev) != PCI_EXP_TYPE_UPSTREAM && !bi) {
+		dev_dbg(&pdev->dev, "No BI Decoder registers.\n");
+		return false;
+	}
+	return true;
+}
+
+/* limit any insane timeouts from hw */
+#define CXL_BI_COMMIT_MAXTMO_US (5 * USEC_PER_SEC)
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
+/* Enable or dealloc BI-ID changes in the given level of the topology. */
+static int __cxl_bi_ctrl_dport(struct cxl_dport *dport, bool enable)
+{
+	struct pci_dev *pdev = to_pci_dev(dport->dport_dev);
+	void __iomem *bi = dport->regs.bi_decoder;
+	struct cxl_port *port = dport->port;
+	u32 ctrl, value;
+	int rc;
+
+	guard(device)(&port->dev);
+	if (!bi)
+		return -EINVAL;
+
+	ctrl = readl(bi + CXL_BI_DECODER_CTRL_OFFSET);
+
+	switch (pci_pcie_type(pdev)) {
+	case PCI_EXP_TYPE_ROOT_PORT:
+		if (enable) {
+			/*
+			 * There is no point of failure from here on,
+			 * BI will be enabled on the endpoint device.
+			 */
+			dport->nr_bi++;
+
+			if (FIELD_GET(CXL_BI_DECODER_CTRL_BI_FW, ctrl) &&
+			    !FIELD_GET(CXL_BI_DECODER_CTRL_BI_ENABLE, ctrl))
+				return 0;
+
+			value = ctrl | CXL_BI_DECODER_CTRL_BI_FW;
+			value &= ~CXL_BI_DECODER_CTRL_BI_ENABLE;
+		} else {
+			if (WARN_ON_ONCE(dport->nr_bi == 0))
+				return -EINVAL;
+			if (--dport->nr_bi > 0)
+				return 0;
+
+			value = ctrl & ~(CXL_BI_DECODER_CTRL_BI_FW |
+					 CXL_BI_DECODER_CTRL_BI_ENABLE);
+		}
+
+		writel(value, bi + CXL_BI_DECODER_CTRL_OFFSET);
+		return 0;
+	case PCI_EXP_TYPE_DOWNSTREAM:
+		if (enable) {
+			value = ctrl & ~CXL_BI_DECODER_CTRL_BI_FW;
+			value |= CXL_BI_DECODER_CTRL_BI_ENABLE;
+		} else {
+			if (!FIELD_GET(CXL_BI_DECODER_CTRL_BI_ENABLE, ctrl))
+				return 0;
+			value = ctrl & ~(CXL_BI_DECODER_CTRL_BI_FW |
+					 CXL_BI_DECODER_CTRL_BI_ENABLE);
+		}
+
+		writel(value, bi + CXL_BI_DECODER_CTRL_OFFSET);
+
+		rc = __cxl_bi_commit_decoder(dport->dport_dev, bi);
+		if (rc)
+			return rc;
+
+		if (port->regs.bi_rt)
+			return __cxl_bi_commit_rt(&port->dev, port->regs.bi_rt);
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int cxl_bi_ctrl_dport_enable(struct cxl_dport *dport)
+{
+	return __cxl_bi_ctrl_dport(dport, true);
+}
+
+static int cxl_bi_ctrl_dport_disable(struct cxl_dport *dport)
+{
+	return __cxl_bi_ctrl_dport(dport, false);
+}
+
+static int __cxl_bi_ctrl_endpoint(struct cxl_dev_state *cxlds, bool enable)
+{
+	struct cxl_port *endpoint = cxlds->cxlmd->endpoint;
+	void __iomem *bi = endpoint->regs.bi_decoder;
+	u32 ctrl, val;
+
+	if (!bi)
+		return -EINVAL;
+
+	ctrl = readl(bi + CXL_BI_DECODER_CTRL_OFFSET);
+
+	if (enable) {
+		if (FIELD_GET(CXL_BI_DECODER_CTRL_BI_ENABLE, ctrl)) {
+			if (cxlds->bi)
+				return 0;
+			dev_err(cxlds->dev,
+				"BI already enabled in hardware\n");
+			return -EBUSY;
+		}
+		val = ctrl | CXL_BI_DECODER_CTRL_BI_ENABLE;
+	} else {
+		if (!FIELD_GET(CXL_BI_DECODER_CTRL_BI_ENABLE, ctrl)) {
+			if (!cxlds->bi)
+				return 0;
+			dev_err(cxlds->dev,
+				"BI already disabled in hardware\n");
+			return -EBUSY;
+		}
+		val = ctrl & ~CXL_BI_DECODER_CTRL_BI_ENABLE;
+	}
+
+	writel(val, bi + CXL_BI_DECODER_CTRL_OFFSET);
+	cxlds->bi = enable;
+
+	dev_dbg(cxlds->dev, "BI requests %s\n",
+		str_enabled_disabled(enable));
+
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
+ * devm teardown on cxl_mem unbind. Endpoint decoders may still be
+ * committed here (cxl_workqueue tears them down asynchronously), but
+ * memory access has been quiesced.
+ */
+static void cxl_bi_dealloc(void *data)
+{
+	struct cxl_dev_state *cxlds = data;
+	struct cxl_dport *dport_iter, *dport;
+	struct cxl_port *port_iter;
+
+	if (!dev_is_pci(cxlds->dev))
+		return;
+
+	struct cxl_port *port __free(put_cxl_port) =
+		cxl_pci_find_port(to_pci_dev(cxlds->dev), &dport);
+	if (!port || !cxlds->bi)
+		return;
+
+	scoped_guard(rwsem_read, &cxl_rwsem.region)
+		cxl_bi_ctrl_endpoint_disable(cxlds);
+
+	port_iter = port;
+	dport_iter = dport;
+	while (!is_cxl_root(port_iter)) {
+		int rc = cxl_bi_ctrl_dport_disable(dport_iter);
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
+int cxl_bi_setup(struct cxl_dev_state *cxlds)
+{
+	struct cxl_port *endpoint = cxlds->cxlmd->endpoint;
+	struct cxl_dport *dport_iter, *dport, *failed;
+	struct cxl_port *port_iter;
+	struct pci_dev *pdev;
+	int rc;
+
+	if (!dev_is_pci(cxlds->dev))
+		return 0;
+
+	pdev = to_pci_dev(cxlds->dev);
+	struct cxl_port *port __free(put_cxl_port) =
+		cxl_pci_find_port(pdev, &dport);
+
+	if (!port)
+		return -EINVAL;
+
+	if (!cxl_is_bi_capable(pdev, endpoint->regs.bi_decoder))
+		return 0;
+
+	/* walkup the topology twice, first to check, then to enable */
+	port_iter = port;
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
+			    PCI_EXP_TYPE_UPSTREAM &&
+		    !cxl_is_bi_capable(to_pci_dev(port_iter->uport_dev),
+				       port_iter->regs.bi_rt)) {
+			dev_dbg(cxlds->dev, "BI not supported by USP\n");
+			return 0;
+		}
+
+		dport_iter = port_iter->parent_dport;
+		port_iter = dport_iter->port;
+	}
+
+	port_iter = port;
+	dport_iter = dport;
+	while (!is_cxl_root(port_iter)) {
+		rc = cxl_bi_ctrl_dport_enable(dport_iter);
+		if (rc)
+			goto err_rollback;
+
+		dport_iter = port_iter->parent_dport;
+		port_iter = dport_iter->port;
+	}
+
+	/* finally, enable BI on the device */
+	rc = cxl_bi_ctrl_endpoint_enable(cxlds);
+	if (rc)
+		goto err_rollback;
+
+	return devm_add_action_or_reset(&cxlds->cxlmd->dev,
+					cxl_bi_dealloc, cxlds);
+
+err_rollback:
+	/*
+	 * Undo all dports enabled so far, including the failed one.
+	 */
+	failed = dport_iter;
+	dport_iter = dport;
+	port_iter = port;
+	while (!is_cxl_root(port_iter)) {
+		cxl_bi_ctrl_dport_disable(dport_iter);
+		if (dport_iter == failed)
+			break;
+		dport_iter = port_iter->parent_dport;
+		port_iter = dport_iter->port;
+	}
+	return rc;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_bi_setup, "CXL");
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 760f51b43891..89c0c6ce24a3 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -167,6 +167,31 @@ static inline int ways_to_eiw(unsigned int ways, u8 *eiw)
 #define CXL_HEADERLOG_SIZE SZ_512
 #define CXL_HEADERLOG_SIZE_U32 SZ_512 / sizeof(u32)
 
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
@@ -630,6 +655,7 @@ struct cxl_rcrb_info {
  * @coord: access coordinates (bandwidth and latency performance attributes)
  * @link_latency: calculated PCIe downstream latency
  * @gpf_dvsec: Cached GPF port DVSEC
+ * @nr_bi: number of BI-enabled endpoints below this dport
  */
 struct cxl_dport {
 	struct device *dport_dev;
@@ -642,6 +668,7 @@ struct cxl_dport {
 	struct access_coordinate coord[ACCESS_COORDINATE_MAX];
 	long link_latency;
 	int gpf_dvsec;
+	int nr_bi;
 };
 
 /**
@@ -906,6 +933,7 @@ void cxl_coordinates_combine(struct access_coordinate *out,
 			     struct access_coordinate *c2);
 
 bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port);
+int cxl_bi_setup(struct cxl_dev_state *cxlds);
 struct cxl_dport *devm_cxl_add_dport_by_dev(struct cxl_port *port,
 					    struct device *dport_dev);
 
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index ab88eaa31d1d..c40f482b7c14 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -160,6 +160,10 @@ static int cxl_mem_probe(struct device *dev)
 	if (rc)
 		dev_dbg(dev, "CXL memdev EDAC registration failed rc=%d\n", rc);
 
+	rc = cxl_bi_setup(cxlds);
+	if (rc)
+		dev_dbg(dev, "BI setup failed rc=%d\n", rc);
+
 	/*
 	 * The kernel may be operating out of CXL memory on this device,
 	 * there is no spec defined way to determine whether this device
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index 8ce9b4e9ca73..4938e93edb63 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -168,6 +168,7 @@ struct cxl_dpa_partition {
  * @regs: Parsed register blocks
  * @cxl_dvsec: Offset to the PCIe device DVSEC
  * @rcd: operating in RCD mode (CXL 3.0 9.11.8 CXL Devices Attached to an RCH)
+ * @bi: device is BI (Back-Invalidate) enabled
  * @media_ready: Indicate whether the device media is usable
  * @dpa_res: Overall DPA resource tree for the device
  * @part: DPA partition array
@@ -187,6 +188,7 @@ struct cxl_dev_state {
 	struct cxl_device_regs regs;
 	int cxl_dvsec;
 	bool rcd;
+	bool bi;
 	bool media_ready;
 	struct resource dpa_res;
 	struct cxl_dpa_partition part[CXL_NR_PARTITIONS_MAX];
-- 
2.39.5

