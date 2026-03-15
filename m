Received: from toucan.tulip.relay.mailchannels.net (toucan.tulip.relay.mailchannels.net [23.83.218.254])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C68C220F38
	for <linux-cxl@vger.kernel.org>; Sun, 15 Mar 2026 20:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.254
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773606474; cv=pass; b=W5zfhlcjjTTZZJ7SuU3k1PZrzQifUaxFRQKj5BLbmZUL9Kc1Yj3NsOcjnDiP3mKGTdgBddrn9fkHkcCj41IxTHLdcH4b2IhIDkXIGMa0RT2I6RtrtNOkPuXaOUKOefN/HPk43kKW9ll8ObJ1TmI5zJVqxHIM8ZBzM8DGI/TjNw0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773606474; c=relaxed/simple;
	bh=V0/7zQifq3kJCBH6UPC4T3ClJ8kDwHu9bSMQz0396o0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GpIcGNTCfkEq6PxjEB94NI28vXkel90grXUd+TxN6cdl8LZKwiXI5vVjq6oC3K8BF3IeGSpxyf+3MFLpKJo9n32ma0AuWPIIcyWv6eebeNz7NXXyxyneHav4VIoRuRoLzH+0ONn5ozMY8JOgOv91H4Lhj/mXbSu+JNH0EvYfzy4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=g8Nacr6k; arc=pass smtp.client-ip=23.83.218.254
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="g8Nacr6k"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id C2E087E28AF;
	Sun, 15 Mar 2026 20:27:47 +0000 (UTC)
Received: from pdx1-sub0-mail-a246.dreamhost.com (100-112-160-86.trex-nlb.outbound.svc.cluster.local [100.112.160.86])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 677507E24D2;
	Sun, 15 Mar 2026 20:27:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1773606467;
	b=zqlMsL+5mKR3nPYtJRoBFUN+N3/4F1AaxLdCNPfY24hiNfhUM0lsKT8+Ce7wpTEGT0MS54
	qbPD4GICPQzrqBz65juJXYhJj0ouAoqUN2auokcjcfDIGlGmaI6sz/AcWhb4VvzFPf6zdu
	Mq5xAeCXcCnUflQLhwdPG2pzbaILTBpfW4Ns6VU182JMAXI5tCPdrh5jOQULEOciWbav1S
	3xViP2/KdSkCQdkoQv/Sdf2Hsxr8mRkdzVfNOsqCODZAeyk8t+07+YGlhHgyndDxjJTF3m
	WWyQr5JMLsIZiP406r3I0f8JP8p54+wSQ0nKJifdNyRt+Wm1pvoJ9jovF0u5FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1773606467;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=cJ2dYG2t5LkIVlHsAJUoaySbrFdt1KKfqMi8HBvAtAI=;
	b=rvk+0SwKVg/KW1mK2Y1gL5I+r2c/rGfeTg5OGu6dW+42oTOqkxSaibhQpv90ALvl1FVN2B
	Z5XnoIkwgdzQDM/nNHmClq9wOT8/AojREyyLnqA19RdL2eddryhlLMvyYhRaF9m+nGS0TU
	wFC1XEUBtD2f97nfJRq0M4OHOjTBS8tGfLIHA7ncf02hMW7Rsi55qC7qfJv1sapMD3YjXR
	vtY9gC80cNwgAK/QCq1+OCbeP/ZV4QXIkuq8Qw7vZAzkVNzAVbJrZuTuGgjVUN2K1RPRCs
	1omSSDS9gyoT4BBqTE8Z+/6bwcd8mPaExJOxNUDexO12hcdo/yo1q+ChQCFAQw==
ARC-Authentication-Results: i=1;
	rspamd-c9674b64d-sg786;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Callous-Tasty: 0e8b5c1250b44dc0_1773606467700_2469245356
X-MC-Loop-Signature: 1773606467700:3802430918
X-MC-Ingress-Time: 1773606467700
Received: from pdx1-sub0-mail-a246.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.112.160.86 (trex/7.1.5);
	Sun, 15 Mar 2026 20:27:47 +0000
Received: from offworld.lan (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a246.dreamhost.com (Postfix) with ESMTPSA id 4fYqXf57r1z107M;
	Sun, 15 Mar 2026 13:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1773606467;
	bh=cJ2dYG2t5LkIVlHsAJUoaySbrFdt1KKfqMi8HBvAtAI=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=g8Nacr6k3sFIBeglyjJgpBv0tiIc8qQWDO+msJm3R+W1XqjneU9EtbOj6f6GHdHob
	 MqRzApU1C2KzXW/cOKzkwm9dldRrxmn3OJcadr0TT0GBPnr17X2tMWI3n3NJio9cdM
	 ZZsV5rly7M9ywg5duZIPjbfTZtQpJ90a+DN5eAP4Alz4206XV79z2/cFA4oEkZ5ko7
	 82KXpMrBYzGSZJgsld6SeXOek28yFGYuOjOhDsuT9Rkt/S3kO2HpMCAXmrR5BLdbRa
	 QUuOFVlmCXDQPuVuY/MDCJ5GBMCaPz1dWkc1QWAZli693fkMTYl90MVURzf5oewLLw
	 redJFvPNfrTlg==
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
Subject: [PATCH 5/6] cxl/hdm: Add BI coherency support for endpoint decoders
Date: Sun, 15 Mar 2026 13:27:40 -0700
Message-Id: <20260315202741.3264295-6-dave@stgolabs.net>
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

Add cxl_dpa_set_coherence() to allow setting the coherency type of an
endpoint decoder, with validation against hardware capabilities. Other
than the HDM decoder supported coherency models, the main dependency
to create these regions is for the device state to be BI-ready (cxlds->bi),
for which already committed HDM decoders with the BI bit set detected during
enumeration is currently not supported because endpoint and port enumerations
are independent. Program the BI bit in the HDM decoder control register at
commit time.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 drivers/cxl/core/core.h |  2 ++
 drivers/cxl/core/hdm.c  | 60 +++++++++++++++++++++++++++++++++++++----
 2 files changed, 57 insertions(+), 5 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 19494a8615d3..da4c094b6702 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -97,6 +97,8 @@ void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
 struct dentry *cxl_debugfs_create_dir(const char *dir);
 int cxl_dpa_set_part(struct cxl_endpoint_decoder *cxled,
 		     enum cxl_partition_mode mode);
+int cxl_dpa_set_coherence(struct cxl_endpoint_decoder *cxled,
+			  enum cxl_decoder_type type);
 int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, u64 size);
 int cxl_dpa_free(struct cxl_endpoint_decoder *cxled);
 resource_size_t cxl_dpa_size(struct cxl_endpoint_decoder *cxled);
diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index b2db5967f5c0..6a6071b1f1dd 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -87,6 +87,8 @@ static void parse_hdm_decoder_caps(struct cxl_hdm *cxlhdm)
 		cxlhdm->iw_cap_mask |= BIT(3) | BIT(6) | BIT(12);
 	if (FIELD_GET(CXL_HDM_DECODER_INTERLEAVE_16_WAY, hdm_cap))
 		cxlhdm->iw_cap_mask |= BIT(16);
+	cxlhdm->supported_coherency =
+		FIELD_GET(CXL_HDM_DECODER_SUPPORTED_COHERENCY_MASK, hdm_cap);
 }
 
 static bool should_emulate_decoders(struct cxl_endpoint_dvsec_info *info)
@@ -603,6 +605,34 @@ int cxl_dpa_set_part(struct cxl_endpoint_decoder *cxled,
 	return 0;
 }
 
+int cxl_dpa_set_coherence(struct cxl_endpoint_decoder *cxled,
+			  enum cxl_decoder_type type)
+{
+	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+	struct cxl_port *port = to_cxl_port(cxled->cxld.dev.parent);
+	struct cxl_hdm *cxlhdm = dev_get_drvdata(&port->dev);
+
+	guard(rwsem_write)(&cxl_rwsem.dpa);
+	if (cxled->cxld.flags & CXL_DECODER_F_ENABLE)
+		return -EBUSY;
+
+	if (!cxlds->bi && type == CXL_DECODER_DEVMEM)
+		return -EINVAL;
+
+	/* Device coherent only cannot be set to host-only */
+	if (type == CXL_DECODER_HOSTONLYMEM &&
+	    cxlhdm->supported_coherency == CXL_HDM_DECODER_COHERENCY_DEV)
+		return -EINVAL;
+	/* Host-only coherent cannot be set to device coherent */
+	if (type == CXL_DECODER_DEVMEM &&
+	    cxlhdm->supported_coherency == CXL_HDM_DECODER_COHERENCY_HOST)
+		return -EINVAL;
+
+	cxled->cxld.target_type = type;
+	return 0;
+}
+
 static int __cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, u64 size)
 {
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
@@ -713,6 +743,9 @@ static void cxld_set_type(struct cxl_decoder *cxld, u32 *ctrl)
 	u32p_replace_bits(ctrl,
 			  !!(cxld->target_type == CXL_DECODER_HOSTONLYMEM),
 			  CXL_HDM_DECODER0_CTRL_HOSTONLY);
+	u32p_replace_bits(ctrl,
+			  !!(cxld->target_type == CXL_DECODER_DEVMEM),
+			  CXL_HDM_DECODER0_CTRL_BI);
 }
 
 static void cxlsd_set_targets(struct cxl_switch_decoder *cxlsd, u64 *tgt)
@@ -1030,6 +1063,14 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 		else
 			cxld->target_type = CXL_DECODER_DEVMEM;
 
+		/*
+		 * Autocommit BI-enabled decoders is not supported.
+		 * At this point ->bi is not yet setup, so there
+		 * are no guarantees that the platform supports BI.
+		 */
+		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_BI, ctrl))
+			return -ENXIO;
+
 		guard(rwsem_write)(&cxl_rwsem.region);
 		if (cxld->id != cxl_num_decoders_committed(port)) {
 			dev_warn(&port->dev,
@@ -1049,16 +1090,24 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 		if (cxled) {
 			struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
 			struct cxl_dev_state *cxlds = cxlmd->cxlds;
+			struct cxl_port *ep_port = to_cxl_port(cxld->dev.parent);
+			struct cxl_hdm *cxlhdm = dev_get_drvdata(&ep_port->dev);
 
 			/*
-			 * Default by devtype until a device arrives that needs
-			 * more precision.
+			 * For type3 HDM-DB devices, users can later change the
+			 * target_type, if supported by the HDM decoder.
+			 *
+			 * Devices that support both coherency modes default
+			 * to host-only.
 			 */
-			if (cxlds->type == CXL_DEVTYPE_CLASSMEM)
-				cxld->target_type = CXL_DECODER_HOSTONLYMEM;
-			else
+			if (cxlds->type == CXL_DEVTYPE_CLASSMEM) {
+				if (cxlhdm->supported_coherency == CXL_HDM_DECODER_COHERENCY_DEV)
+					cxld->target_type = CXL_DECODER_DEVMEM;
+				else
+					cxld->target_type = CXL_DECODER_HOSTONLYMEM;
+			} else {
 				cxld->target_type = CXL_DECODER_DEVMEM;
+			}
 		} else {
 			/* To be overridden by region type at commit time */
 			cxld->target_type = CXL_DECODER_HOSTONLYMEM;
--
2.39.5

