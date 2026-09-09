Received: from donkey.ash.relay.mailchannels.net (donkey.ash.relay.mailchannels.net [23.83.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927C337C929
	for <linux-cxl@vger.kernel.org>; Wed,  9 Sep 2026 17:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788974959; cv=none; b=oyLi2pmUtA+bZ4y6C9IuSqs4TT64BvD08wz97WLYFHtDL6DHejGGJih1uhETOx4rz5VvJmgovNV4kTNKDPQT19wmwOfp5ih09E1bc2+u6Uv+8nrewCch2gLqTx/UaOojPl4T5ZHIpZBFKqAQkaaQvTIXKgbGaFQy5Ei6onwT+FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788974959; c=relaxed/simple;
	bh=ew277S2nLYedsPoUIuAMPZAajh7Qw+8z/U4QDeVCphE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sz3/mAuqjAkIdDLcml0ozZqOg3J3iKyDPG0PUra/8PFVMT4fPBnd21bdKdXujfBjCr0WuzZVTRseMFSTma7YOdyzxqu7nXs3tD6t7T2T89Hn96E1/D67ywkab/QHk6qCRXwYFjMvF/11YqtCQq5n5VhJMM6Zddm+1t9Jg20jNTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=S/1RuG4s; arc=none smtp.client-ip=23.83.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="S/1RuG4s"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id AA801637BD;
	Wed, 09 Sep 2026 17:03:30 +0000 (UTC)
Received: from pdx1-sub0-mail-a213.dreamhost.com (100-98-23-243.trex-nlb.outbound.svc.cluster.local [100.98.23.243])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 75C2D6301E;
	Wed, 09 Sep 2026 17:03:30 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Spill-Stupid: 01575ab91cbafe80_1788973410585_3409886409
X-MC-Loop-Signature: 1788973410584:216304309
X-MC-Ingress-Time: 1788973410584
Received: from pdx1-sub0-mail-a213.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.98.23.243 (trex/8.0.2);
	Wed, 09 Sep 2026 17:03:30 +0000
Received: from offworld.lan (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a213.dreamhost.com (Postfix) with ESMTPSA id 4hg6Zn62gHz1S9;
	Wed,  9 Sep 2026 10:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1788973410;
	bh=rB29ysaWULxsbCtD7nfFpmaqyWXQ858O4nq3VVsUzUM=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=S/1RuG4snBiodccTu2OBcrr+7MTHU9x5nDoDGVdNkGzaLenf31G89dTVknWnswecc
	 rvh7/UEUkEewGjrU8rePxyheeKmqbu+QRRxD2m1sjbur8h/1CvdD1fBD3eGINVAuHn
	 ULGxXNgUIvYX2ZLvNIojHUxvx7+YDMpqXLDe20lM0e2krgyLE4ocHBnxRb2BCfcDoT
	 oF6cppnuUj+8DVkTRSG4r/QqsBciJuazYmS8N6c17mYZHaoETTOi2UAwsjcznKbBOY
	 hzK9kjuSte9dz2gJ2FRn5EuatznXMNAD/2M4Tgk5SuaQ/jjlK+irGk21gEbroSdzyU
	 Nr/sxphUJm53g==
From: Davidlohr Bueso <dave@stgolabs.net>
To: dave.jiang@intel.com
Cc: jic23@kernel.org,
	alison.schofield@intel.com,
	icheng@nvidia.com,
	ming.li@zohomail.com,
	benjamin.cheatham@amd.com,
	alucerop@amd.com,
	dave@stgolabs.net,
	linux-cxl@vger.kernel.org
Subject: [PATCH v8 03/10] cxl/hdm: Add BI coherency support for endpoint decoders
Date: Wed,  9 Sep 2026 10:02:55 -0700
Message-Id: <20260909170302.1550680-4-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260909170302.1550680-1-dave@stgolabs.net>
References: <20260909170302.1550680-1-dave@stgolabs.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Cache the HDM decoder's Supported Coherency Models on struct cxl_hdm.
A later patch has region attach consult it to verify the HDM supports
the region's coherency type.

For uncommitted endpoint decoders, init_hdm_decoder() defaults
target_type from supported_coherency: Type 3 devices default to
HDM-DB when the HDM is device-coherent-only, HDM-H otherwise.

Pre-committed decoders with the BI bit set are not supported because
endpoint and port enumerations are independent -- at decoder
enumeration cxlds->bi is not yet known, so the topology cannot be
verified.

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 drivers/cxl/core/core.h |  1 +
 drivers/cxl/core/hdm.c  | 35 ++++++++++++++++++++++++-----------
 drivers/cxl/cxl.h       |  8 +++++++-
 drivers/cxl/cxlmem.h    |  2 ++
 4 files changed, 34 insertions(+), 12 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 384bad8cb70f..c57c6474a8a1 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -214,6 +214,7 @@ struct cxl_hdm;
 int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
 			struct cxl_endpoint_dvsec_info *info);
 int cxl_port_get_possible_dports(struct cxl_port *port);
+enum cxl_decoder_type cxled_default_type(struct cxl_endpoint_decoder *cxled);
 
 #ifdef CONFIG_CXL_FEATURES
 struct cxl_feat_entry *
diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 0e9d652b568e..3ac16d3f873a 100644
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
@@ -968,6 +970,19 @@ static int cxl_setup_hdm_decoder_from_dvsec(
 	return 0;
 }
 
+enum cxl_decoder_type cxled_default_type(struct cxl_endpoint_decoder *cxled)
+{
+	struct cxl_dev_state *cxlds = cxled_to_memdev(cxled)->cxlds;
+	struct cxl_port *port = cxled_to_port(cxled);
+	struct cxl_hdm *cxlhdm = dev_get_drvdata(&port->dev);
+
+	if (cxlds->type == CXL_DEVTYPE_CLASSMEM &&
+	    cxlhdm->supported_coherency != CXL_HDM_DECODER_COHERENCY_DEV)
+		return CXL_DECODER_HOSTONLYMEM;
+
+	return CXL_DECODER_DEVMEM;
+}
+
 static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 			    void __iomem *hdm, int which,
 			    u64 *dpa_base, struct cxl_endpoint_dvsec_info *info)
@@ -1023,6 +1038,14 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
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
@@ -1040,17 +1063,7 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 		port->commit_end = cxld->id;
 	} else {
 		if (cxled) {
-			struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
-			struct cxl_dev_state *cxlds = cxlmd->cxlds;
-
-			/*
-			 * Default by devtype until a device arrives that needs
-			 * more precision.
-			 */
-			if (cxlds->type == CXL_DEVTYPE_CLASSMEM)
-				cxld->target_type = CXL_DECODER_HOSTONLYMEM;
-			else
-				cxld->target_type = CXL_DECODER_DEVMEM;
+			cxld->target_type = cxled_default_type(cxled);
 		} else {
 			/* To be overridden by region type at commit time */
 			cxld->target_type = CXL_DECODER_HOSTONLYMEM;
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index ad7c991f0f9b..a990ed41edef 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -50,7 +50,7 @@ extern const struct nvdimm_security_ops *cxl_security_ops;
 #define CXL_BI_RT_CAPABILITY_LENGTH 0xC
 #define CXL_BI_DECODER_CAPABILITY_LENGTH 0xC
 
-/* HDM decoders CXL 2.0 8.2.5.12 CXL HDM Decoder Capability Structure */
+/* HDM decoders CXL 4.0 8.2.4.20 CXL HDM Decoder Capability Structure */
 #define CXL_HDM_DECODER_CAP_OFFSET 0x0
 #define   CXL_HDM_DECODER_COUNT_MASK GENMASK(3, 0)
 #define   CXL_HDM_DECODER_TARGET_COUNT_MASK GENMASK(7, 4)
@@ -58,6 +58,11 @@ extern const struct nvdimm_security_ops *cxl_security_ops;
 #define   CXL_HDM_DECODER_INTERLEAVE_14_12 BIT(9)
 #define   CXL_HDM_DECODER_INTERLEAVE_3_6_12_WAY BIT(11)
 #define   CXL_HDM_DECODER_INTERLEAVE_16_WAY BIT(12)
+#define   CXL_HDM_DECODER_SUPPORTED_COHERENCY_MASK GENMASK(22, 21)
+#define     CXL_HDM_DECODER_COHERENCY_UNKNOWN 0x0
+#define     CXL_HDM_DECODER_COHERENCY_DEV 0x1
+#define     CXL_HDM_DECODER_COHERENCY_HOST 0x2
+#define     CXL_HDM_DECODER_COHERENCY_BOTH 0x3
 #define CXL_HDM_DECODER_CTRL_OFFSET 0x4
 #define   CXL_HDM_DECODER_ENABLE BIT(1)
 #define CXL_HDM_DECODER0_BASE_LOW_OFFSET(i) (0x20 * (i) + 0x10)
@@ -72,6 +77,7 @@ extern const struct nvdimm_security_ops *cxl_security_ops;
 #define   CXL_HDM_DECODER0_CTRL_COMMITTED BIT(10)
 #define   CXL_HDM_DECODER0_CTRL_COMMIT_ERROR BIT(11)
 #define   CXL_HDM_DECODER0_CTRL_HOSTONLY BIT(12)
+#define   CXL_HDM_DECODER0_CTRL_BI BIT(13)
 #define CXL_HDM_DECODER0_TL_LOW(i) (0x20 * (i) + 0x24)
 #define CXL_HDM_DECODER0_TL_HIGH(i) (0x20 * (i) + 0x28)
 #define CXL_HDM_DECODER0_SKIP_LOW(i) CXL_HDM_DECODER0_TL_LOW(i)
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index c401e3a1af06..33bac6bbdb59 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -857,6 +857,7 @@ int cxl_mem_sanitize(struct cxl_memdev *cxlmd, u16 cmd);
  * @target_count: for switch decoders, max downstream port targets
  * @interleave_mask: interleave granularity capability, see check_interleave_cap()
  * @iw_cap_mask: bitmask of supported interleave ways, see check_interleave_cap()
+ * @supported_coherency: HDM Decoder Capability supported coherency models
  * @port: mapped cxl_port, see devm_cxl_setup_hdm()
  */
 struct cxl_hdm {
@@ -865,6 +866,7 @@ struct cxl_hdm {
 	unsigned int target_count;
 	unsigned int interleave_mask;
 	unsigned long iw_cap_mask;
+	unsigned int supported_coherency;
 	struct cxl_port *port;
 };
 
-- 
2.39.5

