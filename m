Received: from seashell.cherry.relay.mailchannels.net (seashell.cherry.relay.mailchannels.net [23.83.223.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6061A261B70
	for <linux-cxl@vger.kernel.org>; Sat, 16 May 2026 02:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.223.162
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778898077; cv=pass; b=hCOThW7u9KYbpWzeOEP0ThMbatd04wQH2zLW6vn8Jouwe5PE37XBm61Q2evUr50Ys7ZMgfTIArpt0S3FYG5uvuwJa87q/Wsnu5xTeWeSvAieAz0ZBeV3L1Ufq5imTYV4miLz1fuJTqfV+a92ifxZfM52ILCH1hCE3BQacuKAroQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778898077; c=relaxed/simple;
	bh=qwnj0Z8Tq8wlPkJx+8HGvol28nowFqYAP5vHsI2iN6U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hk9LKAomfZ4lTuHlexG38CYXXopta5WTxdJleoP65i6pXnaGGAekWq0lg01/kfVY9KKHdk5zHqs3pDx5BogAYbf73qwYIQ3TseJYPh16NIijoBgXgQJviLgjcytsVUf9FCq+vTSQinBN012FRt29+KVc1m3kf9pRPdLBygQYewU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=MouwbgU8; arc=pass smtp.client-ip=23.83.223.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="MouwbgU8"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 2F4CD40011D;
	Sat, 16 May 2026 02:21:10 +0000 (UTC)
Received: from pdx1-sub0-mail-a238.dreamhost.com (trex-green-6.trex.outbound.svc.cluster.local [100.98.6.107])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id C028840142D;
	Sat, 16 May 2026 02:21:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1778898069;
	b=V7m7oy5m4IludXX3CV38fTATXmJ/Tyh6XnAby79IXGZqpXRxWTXNdtfJ2bjLNCbKiXX4qz
	Hz9qAlRNqzCNBddi8W6Fqujll1d4M3tWRudJ0Lvs+27TozBw1HqVrpGfYIdcvfgGAcgJn0
	v2JOsM+noGCR4ME2YWt5HZw5oLUX0yp3uww7GjYX0MvJH8Pw1HSgc1M5hFlBEx8morh96V
	1BSxvQkdZDgUUu4TYQyl+MFCj8qOz/iscTlrVVBNqaieXHiL/rkaUiHm5vrhbETJkUA706
	xMcEFo091kVcJJdOLUaIW0+L3H2OPWIBTBmaB9vDhUJJgFvSpdupPpJoKN4HkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1778898069;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=vB+8TME3YPf+pPcES0tNGbH1N/91WojZioa07iqmaIs=;
	b=Xjj6k0YSUwt3w9cNx01VZFBSNXu89+HtbVqjDWE26ex3zcLK+pWiA8zqa6uy6bGVdZW7Qk
	KzWY6b5BytKDnEYQceENm6cu7VJLYFChzfAPViSc1ughut/ntSERF4CPq1atOz0yyawhy1
	iB50tubwnW5mTBUcHNVsutgcu3SYYGyED7LKsQbx54+mLD5OKHydfBlYUt82qwm5vIDgj0
	FohYAkeAnyvKIuV9wNnDlQnZFIRiq0O/s0Jp1L0HmKNrhlSGwWFnoWiawsNsXXkAfdfFnm
	duEe540HDJuwcn9GakhAZUKqfiwfQ26Z85GRSVouKR9OeTq073xb02w7jTpnKw==
ARC-Authentication-Results: i=1;
	rspamd-5c5444c55f-8hmkz;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Scare-Duck: 5642a1e5263a72ee_1778898070058_1709833348
X-MC-Loop-Signature: 1778898070058:2171181252
X-MC-Ingress-Time: 1778898070058
Received: from pdx1-sub0-mail-a238.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.98.6.107 (trex/7.1.5);
	Sat, 16 May 2026 02:21:10 +0000
Received: from offworld.lan (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a238.dreamhost.com (Postfix) with ESMTPSA id 4gHSVF0L4SzyqP;
	Fri, 15 May 2026 19:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1778898069;
	bh=vB+8TME3YPf+pPcES0tNGbH1N/91WojZioa07iqmaIs=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=MouwbgU8xlk/dyaDJeUlO2zH8YpYaTwPoEaTR/Smp08XAmE6iTx2U2+t/vzABhRPs
	 8uQb+6bDOa76zd+dhtbQtA9JMUd/CvR5A5bmX08BVgEcDLx14ph2tRQQrM0YrihzSY
	 uNyS9Kopx07CGMhN8ktRNOu/1WTf09TjOqYNPSW5TO/8cIg9tMVykOHo4ioM9mrIrL
	 qBZbHrOo+7bUlXLKoW3IKQ2JRiNFPakLOQJrWtzH4JXB5jXVZFfxjJCG0c79Z0SBwv
	 DvZYfkikoSmkOGXqqcOU98zmrm2GDK3Vo5n5ofbB/+56h1YQthb8n3Wzpyj82lrcVJ
	 6Wi1Huv4w8l/w==
From: Davidlohr Bueso <dave@stgolabs.net>
To: dave.jiang@intel.com,
	djbw@kernel.org
Cc: jic23@kernel.org,
	benjamin.cheatham@amd.com,
	alucerop@amd.com,
	alison.schofield@intel.com,
	ira.weiny@intel.com,
	gourry@gourry.net,
	dongjoo.seo1@samsung.com,
	anisa.su@samsung.com,
	dave@stgolabs.net,
	linux-cxl@vger.kernel.org
Subject: [PATCH v3 3/5] cxl/hdm: Add BI coherency support for endpoint decoders
Date: Fri, 15 May 2026 19:20:34 -0700
Message-Id: <20260516022037.1761453-4-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260516022037.1761453-1-dave@stgolabs.net>
References: <20260516022037.1761453-1-dave@stgolabs.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add cxl_dpa_set_coherence() to set an endpoint decoder's coherency
type, validated against the HDM's supported coherency models and
the device's BI readiness (cxlds->bi). Program the BI bit in the
HDM decoder control register at commit time.

For uncommitted decoders, init_hdm_decoder() defaults target_type
from supported_coherency: Type 3 devices default to HDM-DB when the
HDM is DEV-only, HDM-H otherwise.

Pre-committed decoders with the BI bit set are not supported because
endpoint and port enumerations are independent -- at decoder
enumeration cxlds->bi is not yet known, so the topology cannot be
verified.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 drivers/cxl/core/core.h |  2 ++
 drivers/cxl/core/hdm.c  | 53 ++++++++++++++++++++++++++++++++++++++---
 drivers/cxl/cxl.h       |  6 +++++
 drivers/cxl/cxlmem.h    |  2 ++
 4 files changed, 60 insertions(+), 3 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 82ca3a476708..9c4ba9e7717f 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -99,6 +99,8 @@ void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
 struct dentry *cxl_debugfs_create_dir(const char *dir);
 int cxl_dpa_set_part(struct cxl_endpoint_decoder *cxled,
 		     enum cxl_partition_mode mode);
+int cxl_dpa_set_coherence(struct cxl_endpoint_decoder *cxled,
+			  enum cxl_decoder_type type);
 int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, u64 size);
 int cxl_dpa_free(struct cxl_endpoint_decoder *cxled);
 resource_size_t cxl_dpa_size(struct cxl_endpoint_decoder *cxled);
diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 0c80b76a5f9b..42e589fe9063 100644
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
@@ -596,6 +598,34 @@ int cxl_dpa_set_part(struct cxl_endpoint_decoder *cxled,
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
+	/* device-coherent-only HDM cannot serve host-only regions */
+	if (type == CXL_DECODER_HOSTONLYMEM &&
+	    cxlhdm->supported_coherency == CXL_HDM_DECODER_COHERENCY_DEV)
+		return -EINVAL;
+	/* host-only-coherent HDM cannot serve device-coherent regions */
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
@@ -706,6 +736,9 @@ static void cxld_set_type(struct cxl_decoder *cxld, u32 *ctrl)
 	u32p_replace_bits(ctrl,
 			  !!(cxld->target_type == CXL_DECODER_HOSTONLYMEM),
 			  CXL_HDM_DECODER0_CTRL_HOSTONLY);
+	u32p_replace_bits(ctrl,
+			  !!(cxld->target_type == CXL_DECODER_DEVMEM),
+			  CXL_HDM_DECODER0_CTRL_BI);
 }
 
 static void cxlsd_set_targets(struct cxl_switch_decoder *cxlsd, u64 *tgt)
@@ -1023,6 +1056,14 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 		else
 			cxld->target_type = CXL_DECODER_DEVMEM;
 
+		/*
+		 * Autocommit BI-enabled decoders is not supported.
+		 * At this point cxlds->bi is not yet setup, so there
+		 * are no guarantees that the platform supports BI.
+		 */
+		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_BI, ctrl))
+			return -ENXIO;
+
 		guard(rwsem_write)(&cxl_rwsem.region);
 		if (cxld->id != cxl_num_decoders_committed(port)) {
 			dev_warn(&port->dev,
@@ -1042,12 +1083,18 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 		if (cxled) {
 			struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
 			struct cxl_dev_state *cxlds = cxlmd->cxlds;
+			struct cxl_hdm *cxlhdm = dev_get_drvdata(&port->dev);
+			bool dev_coherent = cxlhdm->supported_coherency ==
+					    CXL_HDM_DECODER_COHERENCY_DEV;
 
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
+			if (cxlds->type == CXL_DEVTYPE_CLASSMEM && !dev_coherent)
 				cxld->target_type = CXL_DECODER_HOSTONLYMEM;
 			else
 				cxld->target_type = CXL_DECODER_DEVMEM;
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 564cdcd9409e..8f7c3fe31f65 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -57,6 +57,11 @@ extern const struct nvdimm_security_ops *cxl_security_ops;
 #define   CXL_HDM_DECODER_INTERLEAVE_14_12 BIT(9)
 #define   CXL_HDM_DECODER_INTERLEAVE_3_6_12_WAY BIT(11)
 #define   CXL_HDM_DECODER_INTERLEAVE_16_WAY BIT(12)
+#define   CXL_HDM_DECODER_SUPPORTED_COHERENCY_MASK GENMASK(22, 21)
+#define     CXL_HDM_DECODER_COHERENCY_NONE 0x0
+#define     CXL_HDM_DECODER_COHERENCY_DEV 0x1
+#define     CXL_HDM_DECODER_COHERENCY_HOST 0x2
+#define     CXL_HDM_DECODER_COHERENCY_BOTH 0x3
 #define CXL_HDM_DECODER_CTRL_OFFSET 0x4
 #define   CXL_HDM_DECODER_ENABLE BIT(1)
 #define CXL_HDM_DECODER0_BASE_LOW_OFFSET(i) (0x20 * (i) + 0x10)
@@ -71,6 +76,7 @@ extern const struct nvdimm_security_ops *cxl_security_ops;
 #define   CXL_HDM_DECODER0_CTRL_COMMITTED BIT(10)
 #define   CXL_HDM_DECODER0_CTRL_COMMIT_ERROR BIT(11)
 #define   CXL_HDM_DECODER0_CTRL_HOSTONLY BIT(12)
+#define   CXL_HDM_DECODER0_CTRL_BI BIT(13)
 #define CXL_HDM_DECODER0_TL_LOW(i) (0x20 * (i) + 0x24)
 #define CXL_HDM_DECODER0_TL_HIGH(i) (0x20 * (i) + 0x28)
 #define CXL_HDM_DECODER0_SKIP_LOW(i) CXL_HDM_DECODER0_TL_LOW(i)
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 776c50d1db51..f41d39cc3795 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -837,6 +837,7 @@ int cxl_mem_sanitize(struct cxl_memdev *cxlmd, u16 cmd);
  * @target_count: for switch decoders, max downstream port targets
  * @interleave_mask: interleave granularity capability, see check_interleave_cap()
  * @iw_cap_mask: bitmask of supported interleave ways, see check_interleave_cap()
+ * @supported_coherency: HDM Decoder Capability supported coherency mask
  * @port: mapped cxl_port, see devm_cxl_setup_hdm()
  */
 struct cxl_hdm {
@@ -845,6 +846,7 @@ struct cxl_hdm {
 	unsigned int target_count;
 	unsigned int interleave_mask;
 	unsigned long iw_cap_mask;
+	unsigned int supported_coherency;
 	struct cxl_port *port;
 };
 
-- 
2.39.5

