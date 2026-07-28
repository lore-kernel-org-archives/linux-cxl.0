Received: from panther.cherry.relay.mailchannels.net (panther.cherry.relay.mailchannels.net [23.83.223.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC27123EA8B
	for <linux-cxl@vger.kernel.org>; Tue, 28 Jul 2026 14:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.223.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785250385; cv=none; b=Ubh1vfip+V4GqbHvBScGXbx1ZgEOIsoKh+5rrS9RkTGQRskGYE2/YQ0dcEfuZ4uPNthPtQCOBkw4YQLBGlRQFahZY6pvAkD0p5OLwi8RA5ZHfkiwHBfB7sSSWA4Z+oP/Rnu5x1pkN76Q+NGJVttM9sg7lNJovKBAVwuqXv4Jycs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785250385; c=relaxed/simple;
	bh=HIBy7pd8mMbjnAo8N3u2K9HRrCMclM82+PKCMScNSlg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eB98koSbuSnjgM79ktSayG1svt1Llf529e4wKNyxcJ1yM3uOSaBjBf3Mfnsv/neAWP6utkjhrjd0+q/MHR0MqeZGVp3w5QUGb8FyBIMqlx97SlPSiOqX0GrcOEZDEedRwNbnmEmLNUI2nQZFjyNwooW9vnhv1nNez6h4uhszZ2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=ltNmMfDQ; arc=none smtp.client-ip=23.83.223.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="ltNmMfDQ"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id A9CD1642645;
	Tue, 28 Jul 2026 14:41:48 +0000 (UTC)
Received: from pdx1-sub0-mail-a216.dreamhost.com (100-106-248-197.trex-nlb.outbound.svc.cluster.local [100.106.248.197])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 6D969642C5C;
	Tue, 28 Jul 2026 14:41:48 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Dime-Share: 58e09bfb4ae93687_1785249708566_3743675945
X-MC-Loop-Signature: 1785249708565:2717976525
X-MC-Ingress-Time: 1785249708565
Received: from pdx1-sub0-mail-a216.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.106.248.197 (trex/8.0.2);
	Tue, 28 Jul 2026 14:41:48 +0000
Received: from offworld.lan (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a216.dreamhost.com (Postfix) with ESMTPSA id 4h8dT75tBbz3K;
	Tue, 28 Jul 2026 07:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1785249708;
	bh=R4BysHCJqNwiFgBlrYy1sFs1Z7moJkX5OlfVnp8aXXg=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=ltNmMfDQ4M0n2hOTFEbnJTQDNrfblkEXPjeEfiuKS+O/s7Brk6c/jKhb2EJjMME/l
	 55M060wqMQHYmvmY14+3k0fnI5OC1QJR3OgGltH8dyDu0tCkmx3cAsHT+lqM3MxKkJ
	 dsDcDHUVpFN9/n+tAxXf+n0UaEZ9d7iDysppCkuNtb55gHR7jmAjLvP3t17eGtlOsU
	 QMn94DzudKg+I3/lbmuDhqRuD/zm0UXqLDAdb052G+NRftzS5g/xvk/Mw0+sHO4HEh
	 Xv3SkQj9NUnFNi5WXoRnhwGuy2fxJCu1aosroNG+WHkr1XjPHv7wFQyUkEq/pSSqn3
	 /dtzlwlaeLTvQ==
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
Subject: [PATCH v7 3/8] cxl/hdm: Add BI coherency support for endpoint decoders
Date: Tue, 28 Jul 2026 07:41:31 -0700
Message-Id: <20260728144136.709882-4-dave@stgolabs.net>
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

Cache the HDM decoder's Supported Coherency Models on struct cxl_hdm.
Region attach consults this to verify the HDM supports the region's
coherency type.

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
index e36b55fd63bd..b7757de83012 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -215,6 +215,7 @@ struct cxl_hdm;
 int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
 			struct cxl_endpoint_dvsec_info *info);
 int cxl_port_get_possible_dports(struct cxl_port *port);
+enum cxl_decoder_type cxled_default_type(struct cxl_endpoint_decoder *cxled);
 
 #ifdef CONFIG_CXL_FEATURES
 struct cxl_feat_entry *
diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 0c80b76a5f9b..9da8aa211609 100644
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
index d00b8b7b778a..c323c38d0da2 100644
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
index ed419d0c59f2..344424684cd6 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -859,6 +859,7 @@ int cxl_mem_sanitize(struct cxl_memdev *cxlmd, u16 cmd);
  * @target_count: for switch decoders, max downstream port targets
  * @interleave_mask: interleave granularity capability, see check_interleave_cap()
  * @iw_cap_mask: bitmask of supported interleave ways, see check_interleave_cap()
+ * @supported_coherency: HDM Decoder Capability supported coherency models
  * @port: mapped cxl_port, see devm_cxl_setup_hdm()
  */
 struct cxl_hdm {
@@ -867,6 +868,7 @@ struct cxl_hdm {
 	unsigned int target_count;
 	unsigned int interleave_mask;
 	unsigned long iw_cap_mask;
+	unsigned int supported_coherency;
 	struct cxl_port *port;
 };
 
-- 
2.39.5

