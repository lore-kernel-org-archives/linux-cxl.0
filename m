Received: from bisque.elm.relay.mailchannels.net (bisque.elm.relay.mailchannels.net [23.83.212.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A201B3A3815
	for <linux-cxl@vger.kernel.org>; Tue, 28 Jul 2026 14:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.212.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785249711; cv=none; b=u6tCpxfngJ1fskII/DSiqUT2uyThjzsAMydV1Y18RUx/0+qFjTKZrD+wMooH5ZIwH3OuoSb9PTlv1vNmqeCMPP8sHufwzvNIP0N76svVpunSQgxa+JI+yraYNhFnw8e+y5EmcvJ0iUehCrvtPTnAJxM0Yh7TqEnjRfgUSsADP6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785249711; c=relaxed/simple;
	bh=jSghqKCsmgAjvwKuCATmolFgso7QI6jAGdhpTsBW1DM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HYTX0Tr61XNvW8TpY8KzjfYQWPmeex23GZZDwLd/M7o9uU39gmX3LEb8VBO4mFS56Lp4INs8yduxWzF8U7QzkmlyrUTO6lghb/NXzMEwIMDOAcAkhSKZ9quyzrhhI7TFTERfQ0hJBdvvRrgfqFoh01jQeUUVP2Ol9LRKGFL9BAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=gJQfOYU4; arc=none smtp.client-ip=23.83.212.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="gJQfOYU4"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 0AC724C279A;
	Tue, 28 Jul 2026 14:41:48 +0000 (UTC)
Received: from pdx1-sub0-mail-a216.dreamhost.com (trex-green-9.trex.outbound.svc.cluster.local [100.106.248.197])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id D09C64C0227;
	Tue, 28 Jul 2026 14:41:47 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Imminent-Absorbed: 2d10371b206a7df7_1785249707989_2605754103
X-MC-Loop-Signature: 1785249707989:234392946
X-MC-Ingress-Time: 1785249707988
Received: from pdx1-sub0-mail-a216.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.106.248.197 (trex/8.0.2);
	Tue, 28 Jul 2026 14:41:47 +0000
Received: from offworld.lan (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a216.dreamhost.com (Postfix) with ESMTPSA id 4h8dT71FSPz18l;
	Tue, 28 Jul 2026 07:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1785249707;
	bh=JLBcrpDxSZGs0k/Jp8pkvSFnopSZNG0YQr5TZ9TsLNY=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=gJQfOYU40dgEf2MChqdXtaCeEm5c1Xv4qzJuV+OBwUmBx0oe1lK5OKMbcUfFj8qVT
	 bqqUv50WPJ0K03c8O8GGVwvtEH5eI9oAz/DZbM4I6kMs/rKa2ST46/xD3Ziu5Ol6zf
	 opZ+4h3Dr9q1HNtG79LK3GwzZZI33ts0IDmjsch/e+Z0Fvvqsbt3mqia6bm7SMKglm
	 thpbF0PTWZW3J5eQi5lRRo3MYvJqOHI86c1JgwhZ00x1eR2AytnzGYe/FXi8Yc3tHd
	 XqPUeAogXnDlHlw5gKNPSd7V3e1qySSw9b1M30a40mqanRQxubrjeiU0YEBiqIpO2T
	 62N7LuXy6bL3g==
From: Davidlohr Bueso <dave@stgolabs.net>
To: dave.jiang@intel.com
Cc: jic23@kernel.org,
	alison.schofield@intel.com,
	icheng@nvidia.com,
	benjamin.cheatham@amd.com,
	alucerop@amd.com,
	dongjoo.seo1@samsung.com,
	dave@stgolabs.net,
	linux-cxl@vger.kernel.org
Subject: [PATCH v7 2/8] cxl/pci: Add BI topology enable/disable
Date: Tue, 28 Jul 2026 07:41:30 -0700
Message-Id: <20260728144136.709882-3-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260728144136.709882-1-dave@stgolabs.net>
References: <20260728144136.709882-1-dave@stgolabs.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement cxl_bi_setup() to enable BI flows on the device and every
component in the path, and its teardown counterpart cxl_bi_dealloc().
Both run from cxl_endpoint_port_probe(): the BI-ID and path
enablement belong to the endpoint port's lifetime.

Setup is safe in endpoint port probe context: the port probes
synchronously from cxl_mem_probe(), pinning the memdev state the
walk consumes, and the whole ancestor path already exists with BI
registers mapped (dports at dport-add time, the switch USP RT at
first-dport setup) because devm_cxl_enumerate_ports() completes
before the endpoint is created.

Dealloc is safe in endpoint devres context: both setup and dealloc
walk the endpoint's parent_dport topology rather than getting the
port by bus lookup - an ancestor teardown delists the parent port
before the endpoint's devres runs.

The topology walk is stable as parent_dport pointers are fixed at
port creation; ancestors cannot be reaped while holding this
memdev's cxl_ep; and their own teardown frees dports only after
the endpoint is gone.

The device state holds up as well: cxlmd->cxlds is nulled only
after cxl_memdev_unregister() has torn the endpoint down, and
delete_endpoint() clears cxlmd->endpoint only after the endpoint
devres has run.

With dealloc in the endpoint's devres, delete_endpoint() already
holds the parent port's device lock, so to avoid deadlocking, add a
per-port bi_lock, serializing only dports that share state (ie:
sibling nr_bi on a root port, the switch USP's BI RT).

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 drivers/cxl/core/pci.c  | 379 ++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/core/port.c |   1 +
 drivers/cxl/cxl.h       |  30 ++++
 drivers/cxl/port.c      |   4 +
 include/cxl/cxl.h       |   2 +
 5 files changed, 416 insertions(+)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index f82559d8a8c5..a87c2ad9ac53 100644
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
@@ -964,3 +966,380 @@ void devm_cxl_dport_bi_setup(struct cxl_dport *dport)
 		break;
 	}
 }
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
+	guard(mutex)(&port->bi_lock);
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
+ * devm teardown on endpoint port destruction. Endpoint decoders may
+ * still be committed here (cxl_workqueue tears them down
+ * asynchronously), but memory access has been quiesced.
+ */
+static void cxl_bi_dealloc(void *data)
+{
+	struct cxl_port *endpoint = data;
+	struct cxl_memdev *cxlmd = to_cxl_memdev(endpoint->uport_dev);
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+	struct cxl_dport *dport_iter;
+	struct cxl_port *port_iter;
+
+	if (!cxlds->bi)
+		return;
+
+	scoped_guard(rwsem_read, &cxl_rwsem.region)
+		cxl_bi_ctrl_endpoint_disable(cxlds);
+
+	/*
+	 * Walk the same parent_dport chain that enabled the path. A bus
+	 * lookup cannot stand in for it: an ancestor-driven teardown
+	 * delists the parent port before this devres action runs.
+	 */
+	dport_iter = endpoint->parent_dport;
+	port_iter = dport_iter->port;
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
+/*
+ * Enable BI on every dport in the path, then on the device itself.
+ * On failure, unwind only the dports that fully enabled.
+ */
+static int cxl_bi_enable_path(struct cxl_dev_state *cxlds,
+			      struct cxl_port *port, struct cxl_dport *dport)
+{
+	struct cxl_dport *dport_iter, *failed;
+	struct cxl_port *port_iter;
+	int rc;
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
+	return 0;
+
+err_rollback:
+	failed = dport_iter;
+	dport_iter = dport;
+	port_iter = port;
+	while (!is_cxl_root(port_iter) && dport_iter != failed) {
+		cxl_bi_ctrl_dport_disable(dport_iter);
+		dport_iter = port_iter->parent_dport;
+		port_iter = dport_iter->port;
+	}
+	return rc;
+}
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
+	/* walkup the topology twice, first to check, then to enable */
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
+	rc = cxl_bi_enable_path(cxlds, dport->port, dport);
+	if (rc)
+		return rc;
+
+	return devm_add_action_or_reset(&endpoint->dev, cxl_bi_dealloc,
+					endpoint);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_bi_setup, "CXL");
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index b2f8fb9547d3..7817109026b1 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -741,6 +741,7 @@ static struct cxl_port *cxl_port_alloc(struct device *uport_dev,
 	xa_init(&port->dports);
 	xa_init(&port->endpoints);
 	xa_init(&port->regions);
+	mutex_init(&port->bi_lock);
 	port->component_reg_phys = CXL_RESOURCE_NONE;
 
 	device_initialize(dev);
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index f9fcb6387fc8..d00b8b7b778a 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -180,6 +180,31 @@ static inline int ways_to_eiw(unsigned int ways, u8 *eiw)
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
@@ -562,6 +587,7 @@ struct cxl_dax_region {
  * @decoder_ida: allocator for decoder ids
  * @reg_map: component and ras register mapping parameters
  * @regs: mapped component registers
+ * @bi_lock: serializes BI Decoder/RT state of this port's dports
  * @nr_dports: number of entries in @dports
  * @hdm_end: track last allocated HDM decoder instance for allocation ordering
  * @commit_end: cursor to track highest committed decoder for commit ordering
@@ -584,6 +610,7 @@ struct cxl_port {
 	struct ida decoder_ida;
 	struct cxl_register_map reg_map;
 	struct cxl_component_regs regs;
+	struct mutex bi_lock;
 	int nr_dports;
 	int hdm_end;
 	int commit_end;
@@ -647,6 +674,7 @@ struct cxl_rcrb_info {
  * @coord: access coordinates (bandwidth and latency performance attributes)
  * @link_latency: calculated PCIe downstream latency
  * @gpf_dvsec: Cached GPF port DVSEC
+ * @nr_bi: number of BI-enabled endpoints below this dport
  */
 struct cxl_dport {
 	struct device *dport_dev;
@@ -659,6 +687,7 @@ struct cxl_dport {
 	struct access_coordinate coord[ACCESS_COORDINATE_MAX];
 	long link_latency;
 	int gpf_dvsec;
+	int nr_bi;
 };
 
 /**
@@ -923,6 +952,7 @@ void cxl_coordinates_combine(struct access_coordinate *out,
 			     struct access_coordinate *c2);
 
 bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port);
+int cxl_bi_setup(struct cxl_port *endpoint);
 struct cxl_dport *devm_cxl_add_dport_by_dev(struct cxl_port *port,
 					    struct device *dport_dev);
 
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index a527dd13fb68..22bd4254ba8d 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -180,6 +180,10 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
 	if (rc)
 		return rc;
 
+	rc = cxl_bi_setup(port);
+	if (rc)
+		dev_dbg(&port->dev, "BI setup failed rc=%d\n", rc);
+
 	/*
 	 * With VH (CXL Virtual Host) topology the cxl_port::add_dport() method
 	 * handles RAS setup for downstream ports. With RCH (CXL Restricted CXL
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index 2816954680b3..e507cb0f777f 100644
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

