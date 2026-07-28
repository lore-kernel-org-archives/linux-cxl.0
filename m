Received: from seahorse.cherry.relay.mailchannels.net (seahorse.cherry.relay.mailchannels.net [23.83.223.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B422C11E8
	for <linux-cxl@vger.kernel.org>; Tue, 28 Jul 2026 14:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.223.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785250192; cv=none; b=DWfc2xsxMLD0FkctW6qIB97Z90oiOwZe9SuNFCdD60UJweZrY5EDO6jrTqH0cIn7OtkBBaNVLDsBj9P7DZ1HWoHW3yhIN8/bhFQoww7dFDXQ7kc+u2I0BI4GeF+W2NvhA6vy71Fv5Wk42WXPKOcXmw4etIinY99jZDcaPJaQ6SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785250192; c=relaxed/simple;
	bh=pK9FAlfDpyL1qe96oi2RxQ2wIiLYgTyg/AtTQXBCAhk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=osN22ijfYO4hMiWn1jvfGJh4xTVzILfWgzWhT6FMeOa1ynZnBbnboj7eP9zd7A2QMqqphWiiRy5N9H+Oi1fBsU2n1KgWJ7b2ueZNeqBMlvxbcNZsyp4m3fkeV2xvkyH6Zsl5vpZndfGZkk/GRhACrMasajdn/0idLzrys0OOqxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=me0fu3Lk; arc=none smtp.client-ip=23.83.223.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="me0fu3Lk"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id EC3B24628D7;
	Tue, 28 Jul 2026 14:41:51 +0000 (UTC)
Received: from pdx1-sub0-mail-a216.dreamhost.com (trex-green-5.trex.outbound.svc.cluster.local [100.111.253.9])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id BB0F6462AAE;
	Tue, 28 Jul 2026 14:41:51 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Snatch-Dime: 11dbe25773cf3ba6_1785249711868_3924367046
X-MC-Loop-Signature: 1785249711868:4109638177
X-MC-Ingress-Time: 1785249711867
Received: from pdx1-sub0-mail-a216.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.111.253.9 (trex/8.0.2);
	Tue, 28 Jul 2026 14:41:51 +0000
Received: from offworld.lan (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a216.dreamhost.com (Postfix) with ESMTPSA id 4h8dTC0yCMz18l;
	Tue, 28 Jul 2026 07:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1785249711;
	bh=d6QrWZ4Qed+sMSCLM3AMfjYdrEQJMHk1GVCdnt0Ryqk=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=me0fu3LkPFGIDXtn/LjonDrp5uUZI1r/UsaBICEaHo/xyizR7nVX9wJHtWnwC7ap2
	 izEtm3rO9OejFMD5wf7zNs2XDqFg/FVXBnAClY3oxdWuAvtXKeBCGD+6KPspGFuOl1
	 xPQzQxiK6PDQJRfKsBV/zthaZAbHnOWjjDrrTLMosJ6JHrqZIX4b25nWvchQlXsV19
	 h7+ASkEiu1gDA2PGaJ9TAZyMxH6UaAtWVNrpljc0rKLNLCvsAuDZyiekDh3892zraj
	 vmzI/yjcMng2Q3ACkX6mSQvgf3c9CkIa9Uyq9yPINaVYzKb2/d+MG52Hngyjo3htZj
	 ESKj5fLcWhjkQ==
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
Subject: [PATCH v7 8/8] cxl: Allow auto-committed BI hdm decoders
Date: Tue, 28 Jul 2026 07:41:36 -0700
Message-Id: <20260728144136.709882-9-dave@stgolabs.net>
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

Allow auto-committed BI hdm decoders on sane platforms, rejecting
only broken paths (ie: one that cannot route BISnp, or BI paired
with a host-only target range type).

The respective region creation is done like any other committed
decoder - with cxlds->bi set by the time an decoder attaches.

A committed BI decoder under a window without the BI restriction is
refused (undefined behavior per the CFMWS Window Restrictions), as
is a committed decoder attaching to a region of a different
coherency model.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 drivers/cxl/core/hdm.c    | 24 +++++++++++++++++-------
 drivers/cxl/core/pci.c    | 36 +++++++++++++++++++++++++++++-------
 drivers/cxl/core/region.c | 33 +++++++++++++++++++++++++++++++++
 drivers/cxl/port.c        |  4 ++++
 4 files changed, 83 insertions(+), 14 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index f437fe15c6df..c5be6fe4c77a 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -1061,13 +1061,23 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 		else
 			cxld->target_type = CXL_DECODER_DEVMEM;
 
-		/*
-		 * Autocommit BI-enabled decoders is not supported.
-		 * At this point cxlds->bi is not yet setup, so there
-		 * are no guarantees that the platform supports BI.
-		 */
-		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_BI, ctrl))
-			return -ENXIO;
+		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_BI, ctrl)) {
+			struct cxl_dev_state *cxlds = cxled ?
+				cxled_to_memdev(cxled)->cxlds : NULL;
+
+			if (cxld->target_type == CXL_DECODER_HOSTONLYMEM) {
+				dev_warn(&port->dev,
+					 "decoder%d.%d: BI with host-only\n",
+					 port->id, cxld->id);
+				return -ENXIO;
+			}
+			if (cxlds && !cxlds->bi_capable) {
+				dev_warn(&port->dev,
+					 "decoder%d.%d: path not BI capable\n",
+					 port->id, cxld->id);
+				return -ENXIO;
+			}
+		}
 
 		guard(rwsem_write)(&cxl_rwsem.region);
 		if (cxld->id != cxl_num_decoders_committed(port)) {
diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 554058ccb1e9..8d2651e06a79 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -1083,6 +1083,18 @@ static int __cxl_bi_commit_decoder(struct device *dev, void __iomem *bi)
 				    scale, base);
 }
 
+/* Committed, or no explicit commit required */
+static bool cxl_bi_decoder_committed(void __iomem *bi)
+{
+	u32 caps = readl(bi + CXL_BI_DECODER_CAPS_OFFSET);
+	u32 sts = readl(bi + CXL_BI_DECODER_STATUS_OFFSET);
+
+	if (!FIELD_GET(CXL_BI_DECODER_CAPS_EXPLICIT_COMMIT_REQ, caps))
+		return true;
+
+	return FIELD_GET(CXL_BI_DECODER_STATUS_BI_COMMITTED, sts);
+}
+
 /* Enable or dealloc BI-ID changes in the given level of the topology. */
 static int __cxl_bi_ctrl_dport(struct cxl_dport *dport, bool enable)
 {
@@ -1127,6 +1139,16 @@ static int __cxl_bi_ctrl_dport(struct cxl_dport *dport, bool enable)
 		return 0;
 	case PCI_EXP_TYPE_DOWNSTREAM:
 		if (enable) {
+			/*
+			 * Adopt a dport that was already programmed and
+			 * committed by firmware: nothing new is enabled
+			 * below it, so no commit is due.
+			 */
+			if (FIELD_GET(CXL_BI_DECODER_CTRL_BI_ENABLE, ctrl) &&
+			    !FIELD_GET(CXL_BI_DECODER_CTRL_BI_FW, ctrl) &&
+			    cxl_bi_decoder_committed(bi))
+				return 0;
+
 			value = ctrl & ~CXL_BI_DECODER_CTRL_BI_FW;
 			value |= CXL_BI_DECODER_CTRL_BI_ENABLE;
 		} else {
@@ -1173,11 +1195,11 @@ static int __cxl_bi_ctrl_endpoint(struct cxl_dev_state *cxlds, bool enable)
 
 	if (enable) {
 		if (FIELD_GET(CXL_BI_DECODER_CTRL_BI_ENABLE, ctrl)) {
-			if (cxlds->bi)
-				return 0;
-			dev_err(cxlds->dev,
-				"BI already enabled in hardware\n");
-			return -EBUSY;
+			/* adopt firmware enabled */
+			if (!cxlds->bi)
+				dev_dbg(cxlds->dev,
+					"adopting firmware-enabled BI\n");
+			goto done;
 		}
 		val = ctrl | CXL_BI_DECODER_CTRL_BI_ENABLE;
 	} else {
@@ -1192,11 +1214,11 @@ static int __cxl_bi_ctrl_endpoint(struct cxl_dev_state *cxlds, bool enable)
 	}
 
 	writel(val, bi + CXL_BI_DECODER_CTRL_OFFSET);
-	cxlds->bi = enable;
 
 	dev_dbg(cxlds->dev, "BI requests %s\n",
 		str_enabled_disabled(enable));
-
+done:
+	cxlds->bi = enable;
 	return 0;
 }
 
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 76c6dc28a407..5578ef68034d 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1827,6 +1827,21 @@ static int cxl_region_attach_position(struct cxl_region *cxlr,
 	return rc;
 }
 
+/* Read back the committed BI bit of an auto-discovered decoder */
+static bool cxled_committed_bi(struct cxl_endpoint_decoder *cxled)
+{
+	struct cxl_port *port = cxled_to_port(cxled);
+	struct cxl_hdm *cxlhdm = dev_get_drvdata(&port->dev);
+	u32 ctrl;
+
+	if (!cxlhdm || !cxlhdm->regs.hdm_decoder)
+		return false;
+
+	ctrl = readl(cxlhdm->regs.hdm_decoder +
+		     CXL_HDM_DECODER0_CTRL_OFFSET(cxled->cxld.id));
+	return FIELD_GET(CXL_HDM_DECODER0_CTRL_BI, ctrl);
+}
+
 static int cxl_region_attach_auto(struct cxl_region *cxlr,
 				  struct cxl_endpoint_decoder *cxled, int pos)
 {
@@ -1839,6 +1854,16 @@ static int cxl_region_attach_auto(struct cxl_region *cxlr,
 		return -EINVAL;
 	}
 
+	/* A committed decoder may only join a region of its own flavor */
+	if (cxled_committed_bi(cxled) !=
+	    (cxlr->type == CXL_DECODER_DEVMEM &&
+	     cxl_root_decoder_is_bi(cxlr->cxlrd))) {
+		dev_err(&cxlr->dev, "%s:%s coherency model mismatch\n",
+			dev_name(&cxled_to_memdev(cxled)->dev),
+			dev_name(&cxled->cxld.dev));
+		return -ENXIO;
+	}
+
 	if (pos >= 0) {
 		dev_dbg(&cxlr->dev, "%s: expected auto position, not %d\n",
 			dev_name(&cxled->cxld.dev), pos);
@@ -3806,6 +3831,14 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 	if (part < 0)
 		return ERR_PTR(-EBUSY);
 
+	/* avoid UB */
+	if (cxled_committed_bi(cxled) && !cxl_root_decoder_is_bi(cxlrd)) {
+		dev_err(cxlmd->dev.parent,
+			"%s:%s BI decoder in a non-BI window\n",
+			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev));
+		return ERR_PTR(-ENXIO);
+	}
+
 	do {
 		cxlr = __create_region(cxlrd, cxlds->part[part].mode,
 				       atomic_read(&cxlrd->region_id),
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index ab3317fc1388..0c666ce00aa2 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -181,6 +181,10 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
 	if (rc)
 		return rc;
 
+	/*
+	 * Must precede region discovery so that any firmware-committed BI
+	 * decoder is adopted before its region is assembled.
+	 */
 	rc = cxl_bi_setup(port);
 	if (rc)
 		dev_dbg(&port->dev, "BI setup failed rc=%d\n", rc);
-- 
2.39.5

