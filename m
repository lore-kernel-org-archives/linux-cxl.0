Received: from crocodile.elm.relay.mailchannels.net (crocodile.elm.relay.mailchannels.net [23.83.212.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67906F9EC
	for <linux-cxl@vger.kernel.org>; Tue, 12 Aug 2025 01:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.212.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754961688; cv=pass; b=ajHqXZuSeg+bLCSyXbMKBUQX3mHWx5aa8qmRcnT9m7oJtdjx6PI21ljtefqCUXSElY+/PNeYIsgSbobJ6UQ407UcqaUuMab+5e1Ly7UhKZUQ4Qx9bZ2lD/arJyROBgyBJvAvltxUUrwWowRvCHGCur/TOL4+nySRc9kQR3ez9qo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754961688; c=relaxed/simple;
	bh=+Kks7DAvdHMUuc2hUOsFtufXfDmo79w/hn/TAxRL+ac=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SoMqBWZn40momSPqVpMRZLouiMTT12vS/4/1mRLD/AgZ0KatVTXiAmpTGEvG2PfgOKADcToRkltVGOBtLvORZsKedGY7J4pYRf5k1nxY4tHnxGLLYIYIsvhxI2Yno/wmzI9X7X+xQFFXPFBlJ5AIL/krZWAA/FQZ7TuSBqYhP9c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=rPizVlZn; arc=pass smtp.client-ip=23.83.212.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="rPizVlZn"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 645321A47AB;
	Tue, 12 Aug 2025 01:02:32 +0000 (UTC)
Received: from pdx1-sub0-mail-a202.dreamhost.com (trex-blue-3.trex.outbound.svc.cluster.local [100.96.37.13])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 0B1941A489D;
	Tue, 12 Aug 2025 01:02:32 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1754960552; a=rsa-sha256;
	cv=none;
	b=YJxAPpcBVnl82Utz4QE216gvObeSuxQ7bYp7UyaKBpwiJw8WJ4uBn97PYhM4pTEH+1uTj8
	UzQwQRRYG2l4CRrC/i9KrfbUbVsx/KQtWEZ7ESrM5rFjzE4XNFzIWD99M//uiDjhQqGjUP
	buiRS2us/P9qLs5dAtp1dFau/6rxyPCcgeFmuvhoynWC/OWmDFFGpYWMTpa/JmX8ET54YA
	vo+nEpX1+49ZxXeUe9dcDtjZUdcg1NolR/yL506KgrrFvWa6ggf/8Io0Tq4lNlxEKVmYw+
	L6IwXCQXL8tYobDcSHPW0VYmIo5JbPCEHv49G8B6yoFhvD3DbsD6Y/Hj2KlhnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1754960552;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=x5qDgQ0flOk/f5cFd1eY5e3YlqQafRk7mTOo39xiOX4=;
	b=J9YQm0hx00pAcnIYnFHKRSNKCH3O+gzNN2GvROBy4Ly00wf4RKINnDCMNBsoQv9QdF5MSJ
	waHaZwBpV4ALpdOhBlHwyKkysBWNgyXxC99QC6tW+fUoxxHSOrKXr7hf3/fjLCKkG8q+gQ
	+eOmQVa1jWLwjeEsbjnQXwolV7rBMtVCVyl2uV/Q3tpxla8a9TAsDCU1K/QLiwe9lFo5th
	KR0mj4vdaU2yOO6kfaRn3CsQld3rrI+pBYH0rDKaCKZMmMHTZ33en0MNiVwOKJK9W5P2iQ
	7VhKTk9voAMt7qIcqc4cjFrMtVyCKu2vJbwJIodmYXmSXzhW0f+e4EpDwAaFug==
ARC-Authentication-Results: i=1;
	rspamd-865b9ccc6c-kbbxz;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Quick-Befitting: 770389162d41a2fa_1754960552333_3392014106
X-MC-Loop-Signature: 1754960552333:4163120683
X-MC-Ingress-Time: 1754960552333
Received: from pdx1-sub0-mail-a202.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.96.37.13 (trex/7.1.3);
	Tue, 12 Aug 2025 01:02:32 +0000
Received: from offworld.lan (syn-076-167-199-067.res.spectrum.com [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a202.dreamhost.com (Postfix) with ESMTPSA id 4c1CsM0djzzDF;
	Mon, 11 Aug 2025 18:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1754960551;
	bh=x5qDgQ0flOk/f5cFd1eY5e3YlqQafRk7mTOo39xiOX4=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=rPizVlZnzuB14IBOP3ARfB7DdUsGgLrYYLy4MDT2k2zFgvCE7OROaNjrWPpd1LNeV
	 Vafmz97jqV7hZlwcRK7XSE6ta6ORImxsB38R7tM0WCOSpUb2pDql2/2ywJV3RtQHH4
	 /rTpPoqNBEArpjj17ZPDEng1zCYjbe2Q7G6Lvhx5OHsN5fkromMn6AshwFNQuawo1e
	 1MKzW4CSeXK6lDQ5s+3HRa4UF11qHE3XwaNjYDReyHtFHF9ngZu2Z4iEQLTdaky5Sv
	 Rp+MFFhU04kVIvSPSHYQySrzPSRL8ox2nKSFJs0pQSbBd3q2w8YG2IpeierZh7riIA
	 djvmNx9rtsN7w==
From: Davidlohr Bueso <dave@stgolabs.net>
To: dave.jiang@intel.com,
	dan.j.williams@intel.com
Cc: jonathan.cameron@huawei.com,
	ira.weiny@intel.com,
	alison.schofield@intel.com,
	alucerop@amd.com,
	a.manzanares@samsung.com,
	anisa.su@samsung.com,
	linux-cxl@vger.kernel.org,
	dave@stgolabs.net
Subject: [PATCH 1/3] cxl/pci: Back-Invalidate device discovery and setup
Date: Mon, 11 Aug 2025 18:02:26 -0700
Message-Id: <20250812010228.2589787-2-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250812010228.2589787-1-dave@stgolabs.net>
References: <20250812010228.2589787-1-dave@stgolabs.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce two calls to enable/setup and disable/dealloc BI flows,
adding the general cachemem register plumbing.

  int cxl_bi_setup(struct cxl_dev_state *cxlds);
  int cxl_bi_dealloc(struct cxl_dev_state *cxlds);

Both do the required hierarchy iteration ensuring it is safe to
enable/disable BI for every component. Upon a successful setup,
this enablement does not influence the current HDM decoder setup
by enabling the BI bit, and therefore the device is left in a
BI capable state, but not making use of it in the decode coherence.
Upon a BI-ID removal event, it is expected for the device to
be offline.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 drivers/cxl/core/pci.c  | 318 ++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/core/port.c |   2 +
 drivers/cxl/core/regs.c |  13 ++
 drivers/cxl/cxl.h       |  40 +++++
 drivers/cxl/cxlmem.h    |   2 +
 drivers/cxl/mem.c       |   2 +
 drivers/cxl/pci.c       |   5 +
 drivers/cxl/port.c      |  67 +++++++++
 8 files changed, 449 insertions(+)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index b50551601c2e..d0218e240f0e 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -1069,6 +1069,324 @@ int cxl_pci_get_bandwidth(struct pci_dev *pdev, struct access_coordinate *c)
 	return 0;
 }
 
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
+#define CXL_BI_COMMIT_MAXTMO_US (5 * USEC_PER_SEC)
+
+static unsigned long __cxl_bi_get_timeout_us(int scale, int base)
+{
+	unsigned long tmo;
+
+	switch (scale) {
+	case 0: /* 1 us */
+		tmo = 1;
+		break;
+	case 1: /* 10 us */
+		tmo = 10UL;
+		break;
+	case 2: /* 100 us */
+		tmo = 100UL;
+		break;
+	case 3: /* 1 ms */
+		tmo = 1000UL;
+		break;
+	case 4: /* 10 ms */
+		tmo = 10000UL;
+		break;
+	case 5: /* 100 ms */
+		tmo = 100000UL;
+		break;
+	case 6: /* 1 s */
+		tmo = 1000000UL;
+		break;
+	case 7: /* 10 s */
+		tmo = 10000000UL;
+		break;
+	default:
+		tmo = 0;
+		break;
+	}
+
+	return tmo * base;
+}
+
+#define ___cxl_bi_commit(dev, bi, ctype)				\
+do {									\
+	u32 status, ctrl;						\
+	int scale, base;						\
+	ktime_t tmo, now, start;					\
+	unsigned long poll_us, tmo_us;					\
+									\
+	ctrl = readl(bi + CXL_BI_##ctype##_CTRL_OFFSET);		\
+	writel(ctrl & ~CXL_BI_##ctype##_CTRL_BI_COMMIT,			\
+	       (bi) + CXL_BI_##ctype##_CTRL_OFFSET);			\
+	writel(ctrl | CXL_BI_##ctype##_CTRL_BI_COMMIT,			\
+	       (bi) + CXL_BI_##ctype##_CTRL_OFFSET);			\
+									\
+	status = readl((bi) + CXL_BI_##ctype##_STATUS_OFFSET);		\
+	scale = FIELD_GET(CXL_BI_##ctype##_STATUS_BI_COMMIT_TM_SCALE,	\
+			  status);					\
+	base = FIELD_GET(CXL_BI_##ctype##_STATUS_BI_COMMIT_TM_BASE,	\
+			 status);					\
+									\
+	/* ... and poll */						\
+	tmo_us = min_t(unsigned long, CXL_BI_COMMIT_MAXTMO_US,		\
+		       __cxl_bi_get_timeout_us(scale, base));		\
+	poll_us = tmo_us / 10; /* arbitrary 10% of timeout */		\
+	start = now = ktime_get();					\
+	tmo = ktime_add_us(now, tmo_us);				\
+	while (!FIELD_GET(CXL_BI_##ctype##_STATUS_BI_COMMITTED,	status) && \
+	       !FIELD_GET(CXL_BI_##ctype##_STATUS_BI_ERR_NOT_COMMITTED,	\
+			  status)) {					\
+		if (ktime_after(now, tmo)) {				\
+			dev_dbg((dev), "BI-ID commit timedout (%luus)", \
+				tmo_us);				\
+			return -ETIMEDOUT;				\
+		}							\
+									\
+		fsleep(poll_us);					\
+		now = ktime_get();					\
+		status = readl((bi) + CXL_BI_##ctype##_STATUS_OFFSET);	\
+	}								\
+									\
+	if (FIELD_GET(CXL_BI_##ctype##_STATUS_BI_ERR_NOT_COMMITTED, status)) \
+		return -EIO;						\
+									\
+	dev_dbg((dev), "BI-ID commit wait took %lluus",			\
+		ktime_to_us(ktime_sub(now, start)));			\
+} while (0)
+
+static int __cxl_bi_commit_rt(struct device *dev, void __iomem *bi)
+{
+	if (bi) /* optional */
+		___cxl_bi_commit(dev, bi, RT);
+
+	return 0;
+}
+
+static int __cxl_bi_commit(struct device *dev, void __iomem *bi)
+{
+	if (!bi)
+		return -EINVAL;
+
+	___cxl_bi_commit(dev, bi, DECODER);
+	return 0;
+}
+
+/* enable or dealloc BI-ID changes in the given level of the topology */
+static int cxl_bi_toggle_dport(struct cxl_dport *dport, bool enable)
+{
+	u32 cap, ctrl, value;
+	void __iomem *bi = dport->regs.bi;
+	struct cxl_port *port = dport->port;
+	struct pci_dev *pdev = to_pci_dev(dport->dport_dev);
+
+	guard(device)(&port->dev);
+
+	if (!bi)
+		return -EINVAL;
+
+	ctrl = readl(bi + CXL_BI_DECODER_CTRL_OFFSET);
+
+	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT) {
+		if (enable) {
+			/*
+			 * There is no point of failure from here on,
+			 * BI will be enabled on the endpoint device.
+			 */
+			port->nr_bi++;
+
+			if (FIELD_GET(CXL_BI_DECODER_CTRL_BI_FW, ctrl))
+				return 0;
+
+			value = ctrl | CXL_BI_DECODER_CTRL_BI_FW;
+			value &= ~CXL_BI_DECODER_CTRL_BI_ENABLE;
+		} else {
+			if (--port->nr_bi > 0)
+				return 0;
+
+			value = ctrl & ~CXL_BI_DECODER_CTRL_BI_FW;
+		}
+
+		writel(value, bi + CXL_BI_DECODER_CTRL_OFFSET);
+	} else if (pci_pcie_type(pdev) == PCI_EXP_TYPE_DOWNSTREAM) {
+		int rc;
+
+		if (enable) {
+			value = ctrl & ~CXL_BI_DECODER_CTRL_BI_FW;
+			value |= CXL_BI_DECODER_CTRL_BI_ENABLE;
+		} else {
+			if (!FIELD_GET(CXL_BI_DECODER_CTRL_BI_ENABLE, ctrl))
+				return 0;
+
+			value = ctrl & ~CXL_BI_DECODER_CTRL_BI_ENABLE;
+		}
+
+		writel(value, bi + CXL_BI_DECODER_CTRL_OFFSET);
+
+		cap = readl(bi + CXL_BI_DECODER_CAPS_OFFSET);
+		if (FIELD_GET(CXL_BI_DECODER_CAPS_EXPLICIT_COMMIT_REQ, cap)) {
+			rc = __cxl_bi_commit(dport->dport_dev, dport->regs.bi);
+			if (rc)
+				return rc;
+		}
+
+		/* ... and the routing table, if any */
+		rc = __cxl_bi_commit_rt(&port->dev, port->uport_regs.bi);
+		if (rc)
+			return rc;
+	} else
+		return -EINVAL;
+
+	return 0;
+}
+
+static int cxl_bi_toggle_endpoint(struct cxl_dev_state *cxlds, bool enable)
+{
+	u32 ctrl, val;
+	void __iomem *bi = cxlds->regs.bi;
+
+	ctrl = readl(bi + CXL_BI_DECODER_CTRL_OFFSET);
+
+	if (enable) {
+		if (FIELD_GET(CXL_BI_DECODER_CTRL_BI_ENABLE, ctrl)) {
+			WARN_ON_ONCE(!cxlds->bi);
+			return 0;
+		}
+		val = ctrl | CXL_BI_DECODER_CTRL_BI_ENABLE;
+	} else {
+		if (!FIELD_GET(CXL_BI_DECODER_CTRL_BI_ENABLE, ctrl)) {
+			WARN_ON_ONCE(cxlds->bi);
+			return 0;
+		}
+		val = ctrl & ~CXL_BI_DECODER_CTRL_BI_ENABLE;
+	}
+
+	writel(val, bi + CXL_BI_DECODER_CTRL_OFFSET);
+	cxlds->bi = enable;
+
+	dev_dbg(cxlds->dev, "device %scapable of issuing BI requests\n",
+		enable ? "":"in");
+
+	return 0;
+}
+
+int cxl_bi_setup(struct cxl_dev_state *cxlds)
+{
+	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
+	struct cxl_dport *dport, *_dport;
+	struct cxl_port *parent_port, *port, *_port __free(put_cxl_port) =
+		cxl_pci_find_port(to_pci_dev(cxlds->dev), &_dport);
+
+	if (!_port)
+		return -EINVAL;
+
+	if (!cxl_is_bi_capable(pdev, cxlds->regs.bi))
+		return 0;
+
+	/* walkup the topology twice, first to check, then to enable */
+	port = _port;
+	dport = _dport;
+	while (1) {
+		parent_port = to_cxl_port(port->dev.parent);
+		/* check rp, dsp */
+		if (!cxl_is_bi_capable(to_pci_dev(dport->dport_dev),
+				       dport->regs.bi))
+			return -EINVAL;
+
+		/* check usp */
+		if (pci_pcie_type(to_pci_dev(dport->dport_dev)) ==
+		    PCI_EXP_TYPE_DOWNSTREAM) {
+			if (!cxl_is_bi_capable(to_pci_dev(port->uport_dev),
+					       port->uport_regs.bi))
+				return -EINVAL;
+		}
+
+		if (is_cxl_root(parent_port))
+			break;
+
+		dport = port->parent_dport;
+		port = parent_port;
+	}
+
+	port = _port;
+	dport = _dport;
+	while (1) {
+		int rc;
+
+		parent_port = to_cxl_port(port->dev.parent);
+
+		rc = cxl_bi_toggle_dport(dport, true);
+		if (rc)
+			return rc;
+
+		if (is_cxl_root(parent_port))
+			break;
+
+		dport = port->parent_dport;
+		port = parent_port;
+	}
+
+	/* finally, enable BI on the device */
+	cxl_bi_toggle_endpoint(cxlds, true);
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_bi_setup, "CXL");
+
+int cxl_bi_dealloc(struct cxl_dev_state *cxlds)
+{
+	struct cxl_dport *dport;
+	struct cxl_memdev *cxlmd = cxlds->cxlmd;
+	struct cxl_port *endpoint = cxlmd->endpoint;
+	struct cxl_port *parent_port, *port __free(put_cxl_port) =
+		cxl_pci_find_port(to_pci_dev(cxlds->dev), &dport);
+
+	if (!port)
+		return -EINVAL;
+
+	/* ensure the device is offline and unmapped */
+	if (!endpoint || cxl_num_decoders_committed(endpoint) > 0)
+		return -EBUSY;
+
+	if (!cxlds->bi)
+		return 0;
+
+	/* first, disable BI on the device */
+	cxl_bi_toggle_endpoint(cxlds, false);
+
+	while (1) {
+		int rc;
+
+		parent_port = to_cxl_port(port->dev.parent);
+
+		rc = cxl_bi_toggle_dport(dport, false);
+		if (rc)
+			return rc;
+
+		if (is_cxl_root(parent_port))
+			break;
+
+		dport = port->parent_dport;
+		port = parent_port;
+	}
+
+	cxlds->bi = false;
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_bi_dealloc, "CXL");
+
 /*
  * Set max timeout such that platforms will optimize GPF flow to avoid
  * the implied worst-case scenario delays. On a sane platform, all
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 29197376b18e..38f74bcbfec2 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1470,6 +1470,8 @@ static void cxl_detach_ep(void *data)
 {
 	struct cxl_memdev *cxlmd = data;
 
+	cxl_bi_dealloc(cxlmd->cxlds);
+
 	for (int i = cxlmd->depth - 1; i >= 1; i--) {
 		struct cxl_port *port, *parent_port;
 		struct detach_ctx ctx = {
diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index 5ca7b0eed568..19f4572981ab 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -92,6 +92,18 @@ void cxl_probe_component_regs(struct device *dev, void __iomem *base,
 			length = CXL_RAS_CAPABILITY_LENGTH;
 			rmap = &map->ras;
 			break;
+		case CXL_CM_CAP_CAP_ID_BI_RT:
+			dev_dbg(dev, "found BI RT capability (0x%x)\n",
+				offset);
+			length = CXL_BI_RT_CAPABILITY_LENGTH;
+			rmap = &map->bi;
+			break;
+		case CXL_CM_CAP_CAP_ID_BI_DECODER:
+			dev_dbg(dev, "found BI Decoder capability (0x%x)\n",
+				offset);
+			length = CXL_BI_DECODER_CAPABILITY_LENGTH;
+			rmap = &map->bi;
+			break;
 		default:
 			dev_dbg(dev, "Unknown CM cap ID: %d (0x%x)\n", cap_id,
 				offset);
@@ -211,6 +223,7 @@ int cxl_map_component_regs(const struct cxl_register_map *map,
 	} mapinfo[] = {
 		{ &map->component_map.hdm_decoder, &regs->hdm_decoder },
 		{ &map->component_map.ras, &regs->ras },
+		{ &map->component_map.bi, &regs->bi },
 	};
 	int i;
 
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index b7111e3568d0..6361365c5ce9 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -39,6 +39,8 @@ extern const struct nvdimm_security_ops *cxl_security_ops;
 
 #define   CXL_CM_CAP_CAP_ID_RAS 0x2
 #define   CXL_CM_CAP_CAP_ID_HDM 0x5
+#define   CXL_CM_CAP_CAP_ID_BI_RT 0xB
+#define   CXL_CM_CAP_CAP_ID_BI_DECODER 0xC
 #define   CXL_CM_CAP_CAP_HDM_VERSION 1
 
 /* HDM decoders CXL 2.0 8.2.5.12 CXL HDM Decoder Capability Structure */
@@ -150,6 +152,33 @@ static inline int ways_to_eiw(unsigned int ways, u8 *eiw)
 #define CXL_HEADERLOG_SIZE SZ_512
 #define CXL_HEADERLOG_SIZE_U32 SZ_512 / sizeof(u32)
 
+/* CXL 3.2 8.2.4.26 CXL BI Routing Table Capability Structure */
+#define CXL_BI_RT_CAPABILITY_LENGTH 0xC
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
+/* CXL 3.2 8.2.4.27 CXL BI Decoder Capability Structure */
+#define CXL_BI_DECODER_CAPABILITY_LENGTH 0xC
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
@@ -209,10 +238,13 @@ struct cxl_regs {
 	 * Common set of CXL Component register block base pointers
 	 * @hdm_decoder: CXL 2.0 8.2.5.12 CXL HDM Decoder Capability Structure
 	 * @ras: CXL 2.0 8.2.5.9 CXL RAS Capability Structure
+	 * @bi: CXL 3.2 8.2.4.26 CXL BI Routing Table Capability Structure, or
+	 *      CXL 3.2 8.2.4.27 CXL BI Decoder Capability Structure
 	 */
 	struct_group_tagged(cxl_component_regs, component,
 		void __iomem *hdm_decoder;
 		void __iomem *ras;
+		void __iomem *bi;
 	);
 	/*
 	 * Common set of CXL Device register block base pointers
@@ -255,6 +287,7 @@ struct cxl_reg_map {
 struct cxl_component_reg_map {
 	struct cxl_reg_map hdm_decoder;
 	struct cxl_reg_map ras;
+	struct cxl_reg_map bi;
 };
 
 struct cxl_device_reg_map {
@@ -586,6 +619,7 @@ struct cxl_dax_region {
  * @parent_dport: dport that points to this port in the parent
  * @decoder_ida: allocator for decoder ids
  * @reg_map: component and ras register mapping parameters
+ * @uport_regs: mapped component registers
  * @nr_dports: number of entries in @dports
  * @hdm_end: track last allocated HDM decoder instance for allocation ordering
  * @commit_end: cursor to track highest committed decoder for commit ordering
@@ -594,6 +628,7 @@ struct cxl_dax_region {
  * @cdat: Cached CDAT data
  * @cdat_available: Should a CDAT attribute be available in sysfs
  * @pci_latency: Upstream latency in picoseconds
+ * @num_bi: number of devices that are BI enabled under this port
  */
 struct cxl_port {
 	struct device dev;
@@ -606,6 +641,7 @@ struct cxl_port {
 	struct cxl_dport *parent_dport;
 	struct ida decoder_ida;
 	struct cxl_register_map reg_map;
+	struct cxl_component_regs uport_regs;
 	int nr_dports;
 	int hdm_end;
 	int commit_end;
@@ -617,6 +653,7 @@ struct cxl_port {
 	} cdat;
 	bool cdat_available;
 	long pci_latency;
+	int nr_bi;
 };
 
 /**
@@ -905,6 +942,9 @@ void cxl_coordinates_combine(struct access_coordinate *out,
 
 bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port);
 
+int cxl_bi_setup(struct cxl_dev_state *cxlds);
+int cxl_bi_dealloc(struct cxl_dev_state *cxlds);
+
 /*
  * Unit test builds overrides this to __weak, find the 'strong' version
  * of these symbols in tools/testing/cxl/.
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 751478dfc410..cc0a48031fdd 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -418,6 +418,7 @@ struct cxl_dpa_partition {
  * @regs: Parsed register blocks
  * @cxl_dvsec: Offset to the PCIe device DVSEC
  * @rcd: operating in RCD mode (CXL 3.0 9.11.8 CXL Devices Attached to an RCH)
+ * @bi: The device is capable of supporting back invalidate flows
  * @media_ready: Indicate whether the device media is usable
  * @dpa_res: Overall DPA resource tree for the device
  * @part: DPA partition array
@@ -434,6 +435,7 @@ struct cxl_dev_state {
 	struct cxl_regs regs;
 	int cxl_dvsec;
 	bool rcd;
+	bool bi;
 	bool media_ready;
 	struct resource dpa_res;
 	struct cxl_dpa_partition part[CXL_NR_PARTITIONS_MAX];
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 6e6777b7bafb..a5f3154dd5e3 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -184,6 +184,8 @@ static int cxl_mem_probe(struct device *dev)
 	if (rc)
 		dev_dbg(dev, "CXL memdev EDAC registration failed rc=%d\n", rc);
 
+	cxl_bi_setup(cxlds);
+
 	/*
 	 * The kernel may be operating out of CXL memory on this device,
 	 * there is no spec defined way to determine whether this device
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index bd100ac31672..870bd95752a3 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -962,6 +962,11 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (rc)
 		dev_dbg(&pdev->dev, "Failed to map RAS capability.\n");
 
+	rc = cxl_map_component_regs(&cxlds->reg_map, &cxlds->regs.component,
+				    BIT(CXL_CM_CAP_CAP_ID_BI_DECODER));
+	if (rc)
+		dev_dbg(&pdev->dev, "Failed to map BI decoder capability.\n");
+
 	rc = cxl_pci_type3_init_mailbox(cxlds);
 	if (rc)
 		return rc;
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index fe4b593331da..1c86198c190b 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -57,6 +57,69 @@ static int discover_region(struct device *dev, void *unused)
 	return 0;
 }
 
+static int cxl_dport_init_bi(struct cxl_dport *dport)
+{
+	struct cxl_register_map *map = &dport->reg_map;
+	struct device *dev = dport->dport_dev;
+
+	if (!cxl_pci_flit_256(to_pci_dev(dev)))
+		return 0;
+
+	if (!map->component_map.bi.valid) {
+		dev_dbg(dev, "BI decoder registers not found\n");
+		return 0;
+	}
+
+	if (cxl_map_component_regs(map, &dport->regs.component,
+				   BIT(CXL_CM_CAP_CAP_ID_BI_DECODER))) {
+		dev_dbg(dev, "Failed to map BI decoder capability.\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static void cxl_uport_init_bi(struct cxl_port *port, struct device *host)
+{
+	struct cxl_register_map *map = &port->reg_map;
+
+	if (!map->component_map.bi.valid) {
+		dev_dbg(host, "BI RT registers not found\n");
+		return;
+	}
+
+	map->host = host;
+	if (cxl_map_component_regs(map, &port->uport_regs,
+				   BIT(CXL_CM_CAP_CAP_ID_BI_RT)))
+		dev_dbg(&port->dev, "Failed to map BI RT capability\n");
+}
+
+static void cxl_switch_port_init_bi(struct cxl_port *port)
+{
+	struct cxl_dport *parent_dport = port->parent_dport;
+
+	if (is_cxl_root(to_cxl_port(port->dev.parent)))
+		return;
+
+	if (dev_is_pci(&port->dev) && !cxl_pci_flit_256(to_pci_dev(&port->dev)))
+		return;
+
+	if (parent_dport && dev_is_pci(parent_dport->dport_dev)) {
+		struct pci_dev *pdev = to_pci_dev(parent_dport->dport_dev);
+
+		switch (pci_pcie_type(pdev)) {
+		case PCI_EXP_TYPE_ROOT_PORT:
+		case PCI_EXP_TYPE_DOWNSTREAM:
+			cxl_dport_init_bi(parent_dport);
+			break;
+		default:
+			break;
+		}
+	}
+
+	cxl_uport_init_bi(port, &port->dev);
+}
+
 static int cxl_switch_port_probe(struct cxl_port *port)
 {
 	struct cxl_hdm *cxlhdm;
@@ -71,6 +134,8 @@ static int cxl_switch_port_probe(struct cxl_port *port)
 
 	cxl_switch_parse_cdat(port);
 
+	cxl_switch_port_init_bi(port);
+
 	cxlhdm = devm_cxl_setup_hdm(port, NULL);
 	if (!IS_ERR(cxlhdm))
 		return devm_cxl_enumerate_decoders(cxlhdm, NULL);
@@ -112,6 +177,8 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
 	read_cdat_data(port);
 	cxl_endpoint_parse_cdat(port);
 
+	cxl_dport_init_bi(port->parent_dport);
+
 	get_device(&cxlmd->dev);
 	rc = devm_add_action_or_reset(&port->dev, schedule_detach, cxlmd);
 	if (rc)
-- 
2.39.5

