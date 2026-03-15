Received: from iguana.tulip.relay.mailchannels.net (iguana.tulip.relay.mailchannels.net [23.83.218.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDDF1E9906
	for <linux-cxl@vger.kernel.org>; Sun, 15 Mar 2026 21:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.253
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773608754; cv=pass; b=lG1Y/p8m6jSPQLAllvfP47An7kzgETkNpFwq9rlTG5mdMXzPUNr/QvXM6xWpPn5rLOAJ66TIXZz5qKawj60RrcMFRiHXgsXVq0SMlqUy3Jol7ewLgcT/58aGJsL67iBIo6CI1JANmxiN5Olm0dcRBjs+sovSh9JsvFbzDacCjzI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773608754; c=relaxed/simple;
	bh=ik4qbCLEN/ERWNCIYJd0IEc4GCUg4owU7rq9m6gLB1k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J+h8FzrAmta3sCM+EWOn2Czo+ou74mTV37PZKaa6S1vFuZcwljlpY/PoodYRFyVPqLHClYpTkduImZ1GYjrsoYRMYuR/YfRQXQIyhwkeHOKa6XT+cE//XShpWXAWT95/qUp3QhHe7rraZiDjy44gEQt7xS07rlA+zkXcFnKFGes=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=GdchLyaZ; arc=pass smtp.client-ip=23.83.218.253
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="GdchLyaZ"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 546D682206B;
	Sun, 15 Mar 2026 20:27:46 +0000 (UTC)
Received: from pdx1-sub0-mail-a246.dreamhost.com (100-115-116-98.trex-nlb.outbound.svc.cluster.local [100.115.116.98])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 08480822041;
	Sun, 15 Mar 2026 20:27:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1773606466;
	b=8KnLxYL41m4pgk3vH52DdfESm93WqyMOO08X+A5m/U9/TLwwAdZzIaLQuTKCxVNaJD6yh2
	xS84GhzK/uiri48yHASL9yuPXLRSrOgptQLF9ovBzgGeaJyKpB90ya4HWyc9KfcH+9KLXJ
	RtSqVzhBOnR6TFMvrBQbi4Hk2cbkkW1AKveR+uus0L0KYeQ9zZJgzeV/tiBLNkJxpjFf4P
	I7koHe9t/lxwVQ608AwjO8x6QLjmjC++hIowwn1w3iSYbtIg0dEs1tH1aIYW5WwvyvKRaW
	n+8I2vYCECr44XJ2/otdb9iDUF1gZq+YjdeDbteOdJULc42waw9jQQSRHK7Nfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1773606466;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=DxgyRYDNuMJrTLnGozrqfAFFgXwD1mrgiN+fKET6pkI=;
	b=DZ+92HCj7qAtzp7hvvBTCGAVzjPJuOMS7iWPpwS9fcon+w30VNr1tCdOYEs9f5SAyFLAIK
	gdKcCOHH2FwKCrwRPS9ChMHERLvJ/EODhn61ydUNZR6niol7gNuDBAy2lsBmkjV71qQTWL
	7CKAMFk2cCMkZSJdi5zmvVlK518b+4++r/bbnm441OgnG/+ryLCIZUpUu+tBaJD90sT6Ko
	0f3K1Fae3mRGAF/HAiRvQBG0AVJRqvkvcnNzn36eP2isMsS9afmEO/ohEBe8ykMwpGh62C
	DKzRNHbM5OgkmGpFqlb0r6WYGr/hoD6AV2Nxn3CYErBz1cDRaQriqxMJR6bVXw==
ARC-Authentication-Results: i=1;
	rspamd-c9674b64d-6ngsr;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Eight-Abaft: 61c9265c1ed93140_1773606466295_2280083736
X-MC-Loop-Signature: 1773606466295:1971614171
X-MC-Ingress-Time: 1773606466295
Received: from pdx1-sub0-mail-a246.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.115.116.98 (trex/7.1.5);
	Sun, 15 Mar 2026 20:27:46 +0000
Received: from offworld.lan (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a246.dreamhost.com (Postfix) with ESMTPSA id 4fYqXd2TLKz107r;
	Sun, 15 Mar 2026 13:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1773606465;
	bh=DxgyRYDNuMJrTLnGozrqfAFFgXwD1mrgiN+fKET6pkI=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=GdchLyaZKpYPblq8mLfFbtpL/5uFBQIQ0NgYGw0PFEndj30wAudeDh8bB2iqn3TJ3
	 27MzxJvpJ8RVBBCqP3XsVIermA4uBegNjIFOiuS/5elRaFRQNakWOz7RIfy9q7qzVQ
	 0qWFEhpHeclqeNiv4uq/iS6WDbIWqDUWAqjbtHACeP1TYWcO4hh4wGsKoRykm2vbY8
	 rH4Urv1750QhznOFjxxaendXgabCLweifvGB+XYS+7gFDt12ZrTsQOE832mhtlshSk
	 KqBSAsNqAgCzuPvJ6LwIxJhQOEJ23JjyeDQ3teDBIKpR1QBtur4tTMD373L4OBxdDm
	 1WPoDBjY5oNbw==
From: Davidlohr Bueso <dave@stgolabs.net>
To: dave.jiang@intel.com,
	dan.j.williams@intel.com
Cc: jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	ira.weiny@intel.com,
	gourry@gourry.net,
	dongjoo.seo1@samsung.com,
	anisa.su@samsung.com,
	linux-cxl@vger.kernel.org,
	Davidlohr Bueso <dave@stgolabs.net>
Subject: [PATCH 3/6] cxl/pci: Add Back-Invalidate topology enable/disable
Date: Sun, 15 Mar 2026 13:27:38 -0700
Message-Id: <20260315202741.3264295-4-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260315202741.3264295-1-dave@stgolabs.net>
References: <20260315202741.3264295-1-dave@stgolabs.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement cxl_bi_setup() and cxl_bi_dealloc() which walk the CXL port
topology to enable/disable BI flows on all components in the path.

Upon a successful setup, this enablement does not influence the current
HDM decoder setup by enabling the BI bit, and therefore the device is left
in a BI capable state, but not making use of it in the decode coherence.
Upon a BI-ID removal event, it is expected for the device to be offline.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 drivers/cxl/core/pci.c | 339 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 339 insertions(+)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index d1f487b3d809..5f0226397dfa 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -926,3 +926,342 @@ int cxl_port_get_possible_dports(struct cxl_port *port)
 
 	return ctx.count;
 }
+
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
+static unsigned long __cxl_bi_get_timeout_us(struct device *dev,
+					     int scale, int base)
+{
+	static const unsigned long scale_tbl[] = {
+		1, 10, 100, 1000, 10000, 100000, 1000000, 10000000,
+	};
+
+	if (scale >= ARRAY_SIZE(scale_tbl)) {
+		dev_dbg(dev, "Invalid BI commit timeout scale: %d\n", scale);
+		return CXL_BI_COMMIT_MAXTMO_US;
+	}
+
+	return scale_tbl[scale] * base;
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
+		       __cxl_bi_get_timeout_us((dev), scale, base));	\
+	poll_us = tmo_us / 10; /* arbitrary 10% of timeout */		\
+	start = now = ktime_get();					\
+	tmo = ktime_add_us(now, tmo_us);				\
+	while (!FIELD_GET(CXL_BI_##ctype##_STATUS_BI_COMMITTED, status) && \
+	       !FIELD_GET(CXL_BI_##ctype##_STATUS_BI_ERR_NOT_COMMITTED,	\
+			  status)) {					\
+		if (ktime_after(now, tmo)) {				\
+			dev_dbg((dev), "BI-ID commit timed out (%luus)\n", \
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
+	dev_dbg((dev), "BI-ID commit wait took %lluus\n",		\
+		ktime_to_us(ktime_sub(now, start)));			\
+} while (0)
+
+static int __cxl_bi_commit_rt(struct device *dev, void __iomem *bi)
+{
+	if (!bi)
+		return 0;
+
+	if (FIELD_GET(CXL_BI_RT_CAPS_EXPLICIT_COMMIT_REQ,
+		      readl(bi + CXL_BI_RT_CAPS_OFFSET)))
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
+static int cxl_bi_ctrl_dport(struct cxl_dport *dport, bool enable)
+{
+	u32 ctrl, value;
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
+	switch (pci_pcie_type(pdev)) {
+	case PCI_EXP_TYPE_ROOT_PORT:
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
+			if (WARN_ON_ONCE(port->nr_bi == 0))
+				return -EINVAL;
+			if (--port->nr_bi > 0)
+				return 0;
+
+			value = ctrl & ~CXL_BI_DECODER_CTRL_BI_FW;
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
+
+			value = ctrl & ~CXL_BI_DECODER_CTRL_BI_ENABLE;
+		}
+
+		writel(value, bi + CXL_BI_DECODER_CTRL_OFFSET);
+
+		if (FIELD_GET(CXL_BI_DECODER_CAPS_EXPLICIT_COMMIT_REQ,
+			      readl(bi + CXL_BI_DECODER_CAPS_OFFSET))) {
+			int rc = __cxl_bi_commit(dport->dport_dev,
+						 dport->regs.bi);
+			if (rc)
+				return rc;
+		}
+
+		return __cxl_bi_commit_rt(&port->dev, port->uport_regs.bi);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int cxl_bi_ctrl_endpoint(struct cxl_dev_state *cxlds, bool enable)
+{
+	u32 ctrl, val;
+	struct cxl_port *endpoint = cxlds->cxlmd->endpoint;
+	void __iomem *bi = endpoint->regs.bi;
+
+	if (!bi)
+		return -EINVAL;
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
+		enable ? "" : "in");
+
+	return 0;
+}
+
+int cxl_bi_setup(struct cxl_dev_state *cxlds)
+{
+	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
+	struct cxl_port *endpoint = cxlds->cxlmd->endpoint;
+	struct cxl_dport *dport, *_dport, *failed;
+	struct cxl_port *parent_port, *port;
+	int rc;
+
+	struct cxl_port *_port __free(put_cxl_port) =
+		cxl_pci_find_port(pdev, &_dport);
+
+	if (!_port)
+		return -EINVAL;
+
+	if (!cxl_is_bi_capable(pdev, endpoint->regs.bi))
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
+		parent_port = to_cxl_port(port->dev.parent);
+
+		rc = cxl_bi_ctrl_dport(dport, true);
+		if (rc)
+			goto err_rollback;
+
+		if (is_cxl_root(parent_port))
+			break;
+
+		dport = port->parent_dport;
+		port = parent_port;
+	}
+
+	/* finally, enable BI on the device */
+	cxl_bi_ctrl_endpoint(cxlds, true);
+	return 0;
+
+err_rollback:
+	/*
+	 * Undo all dports enabled so far by re-walking from the bottom
+	 * up to (but not including) the failed dport.
+	 */
+	failed = dport;
+	dport = _dport;
+	port = _port;
+	while (dport != failed) {
+		parent_port = to_cxl_port(port->dev.parent);
+
+		cxl_bi_ctrl_dport(dport, false);
+		if (is_cxl_root(parent_port))
+			break;
+		dport = port->parent_dport;
+		port = parent_port;
+	}
+	return rc;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_bi_setup, "CXL");
+
+int cxl_bi_dealloc(struct cxl_dev_state *cxlds)
+{
+	struct cxl_memdev *cxlmd = cxlds->cxlmd;
+	struct cxl_port *endpoint = cxlmd->endpoint;
+	struct cxl_port *parent_port, *port;
+	struct cxl_dport *dport, *_dport;
+
+	struct cxl_port *_port __free(put_cxl_port) =
+		cxl_pci_find_port(to_pci_dev(cxlds->dev), &_dport);
+
+	if (!_port)
+		return -EINVAL;
+
+	if (!cxlds->bi)
+		return 0;
+
+	if (endpoint) {
+		/* ensure the device is offline and unmapped */
+		scoped_guard(rwsem_read, &cxl_rwsem.region) {
+			if (cxl_num_decoders_committed(endpoint) > 0)
+				return -EBUSY;
+		}
+
+		/* first, disable BI on the device */
+		cxl_bi_ctrl_endpoint(cxlds, false);
+	} else {
+		/*
+		 * Teardown path: the endpoint was already removed, which
+		 * tears down regions and uncommits decoders. The endpoint
+		 * BI registers are no longer mapped so just clear the flag
+		 * and walk the dports below.
+		 */
+		cxlds->bi = false;
+	}
+
+	port = _port;
+	dport = _dport;
+	while (1) {
+		int rc;
+
+		parent_port = to_cxl_port(port->dev.parent);
+
+		rc = cxl_bi_ctrl_dport(dport, false);
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
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_bi_dealloc, "CXL");
-- 
2.39.5

