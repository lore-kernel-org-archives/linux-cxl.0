Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.83.222.62
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794175696;
	b=JwvEkQ3VK+pBQ/h22fKDvGBTeWNX9LdmwvPefb5bTRcbrQ8UbPY0o5kQCCTRGD5OBbK2
	 63cgCUZCI5DRlAM3FxglNBRJ1BFzB0NbCixpXF8TidxZEsZoZBpRq5d0viZIR5e3zhpkI
	 3A2H+ZYyVpXMpi2vFJgPWsMi8Nu3oytCumpl6xhQmHtF4S6WQdtmU2D2Kyg9pSYMy39uO
	 3hON7nf5dom2peapk0CWzKSSoh1tdWyETs5oTnVivm2NJORGt5oZrJV5m6eFgPaOn6MIe
	 p1+LJD/aKH2K2DtA4QB/HfZX7QU8k6F7xn458cR+o6sKwj19pF2/iLioIileVIpCG2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794175696;
	h=DMARC-Filter:X-Sender-Id:Received:Received:X-Sender-Id:X-MC-Relay:
	 X-MailChannels-SenderId:X-MailChannels-Auth-Id:X-Wiry-Macabre:
	 X-MC-Loop-Signature:X-MC-Ingress-Time:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=heKkH6aJCRh3otutKvgUI0JyMcE6VtihxCEtvJRGgTI=;
	b=tqndMN/RaltmY7CELJvFrL638ZepsjFc3GQU1Nx3OobWJA9j2Yp+tVtIXRudpESfoqS8
	 SgAXqcCgJY4d7IlPSotgyI8T2cWOKzwTBwvEjjZQ3S4afrkZGj0apeWuQo4mY9tlTNRQS
	 iRyta6y1FNJE5AOnoRimJRAQCtX9eSAc2rct/RoDUr5Ku7/a/k5tbqEyIUq8Im6hdxj5P
	 I2jyQLWxf5kaEO5AZoJULbjolEbV69myUiu38nVN2YkwFzxakO05NO4VUm4AxY2T+zI63
	 Xz0ql2HiXoJNNwCdb13z7X4YpYqHeaNAUHkQ5S6alxagFE8unjNFK4TkYTucb2cEGHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=stgolabs.net;
	spf=fail smtp.mailfrom=stgolabs.net;
	dkim=pass header.d=stgolabs.net header.i=@stgolabs.net header.a=rsa-sha256 header.s=dreamhost header.b=OlCZJkIe;
	arc=none smtp.remote-ip=23.83.222.62
Received: from fossa.ash.relay.mailchannels.net (fossa.ash.relay.mailchannels.net [23.83.222.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9A1606A31C
	for <linux-cxl@vger.kernel.org>; Sun,  8 Nov 2026 22:08:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DB9A1606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.a=rsa-sha256 header.s=dreamhost header.b=OlCZJkIe
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 5E5AD401FA0;
	Sun, 08 Nov 2026 22:08:09 +0000 (UTC)
Received: from pdx1-sub0-mail-a246.dreamhost.com (100-99-178-124.trex-nlb.outbound.svc.cluster.local [100.99.178.124])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 1FB33402353;
	Sun, 08 Nov 2026 22:08:09 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Wiry-Macabre: 30d1e65b0d297bd9_1794175689223_3159869805
X-MC-Loop-Signature: 1794175689223:1891338844
X-MC-Ingress-Time: 1794175689223
Received: from pdx1-sub0-mail-a246.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.99.178.124 (trex/8.0.2);
	Sun, 08 Nov 2026 22:08:09 +0000
Received: from offworld.tailf5af7a.ts.net (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a246.dreamhost.com (Postfix) with ESMTPSA id 4jN6Vc2QCkz1056;
	Sun,  8 Nov 2026 14:08:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1794175688;
	bh=heKkH6aJCRh3otutKvgUI0JyMcE6VtihxCEtvJRGgTI=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=OlCZJkIekyg+yf8UtPuj8ZUiEDsNRcozXMysEfGinhGeTQmhcqBYIIzaw5Yjod7d0
	 7rFpaUv9aNlh8A5j5+tZwUUNyG+RiF/35Mfjc8vn5Vb5ytMDpsF6KJOSSfJ+XQx/vy
	 EtbEesoPBkGMGa09dAVYmfR2JpGsLzHNXp51R4UJYoTZkBgzB4Q6REPSNHk5OhH33/
	 kr53dSvHMWaEpn5q+6n/B55+mp7PpClP8PAqW5z6oJNOwAe9O1e5XCj2xIJjfLeI+s
	 jN3Oe+Nnh/CZll7EzCHLIxDuPNYD0pOriGDxkygK+z3urVf+VscUOr6z/z3LpJrzXL
	 jolxDt9iX1ReQ==
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
Subject: [PATCH v11 03/10] cxl/hdm: Add BI coherency support for endpoint decoders
Date: Sun,  8 Nov 2026 14:07:32 -0800
Message-Id: <ffffd67bc63fe0b6fcd60f9d64d8e5467a5eff1c.1794172701.git.dave@stgolabs.net>
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

Cache the HDM decoder's Supported Coherency Models on struct cxl_hdm.
A later patch has region attach consult it to verify the HDM supports
the region's coherency type.

For uncommitted endpoint decoders, init_hdm_decoder() defaults
target_type from supported_coherency: Type 3 devices default to
HDM-DB when the HDM is device-coherent-only, HDM-H otherwise.

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Reviewed-by: Li Ming <ming.li@zohomail.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 drivers/cxl/core/core.h |  1 +
 drivers/cxl/core/hdm.c  | 27 ++++++++++++++++-----------
 drivers/cxl/cxl.h       |  7 ++++++-
 drivers/cxl/cxlmem.h    |  2 ++
 4 files changed, 25 insertions(+), 12 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 72be96df57f5..041c86c43d19 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -218,6 +218,7 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
 			struct cxl_endpoint_dvsec_info *info);
 bool cxl_hdm_bi_committed(struct cxl_port *endpoint);
 int cxl_port_get_possible_dports(struct cxl_port *port);
+enum cxl_decoder_type cxled_default_type(struct cxl_endpoint_decoder *cxled);
 
 #ifdef CONFIG_CXL_FEATURES
 struct cxl_feat_entry *
diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index f8fe1b12de3d..0fe86a3e187c 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -90,6 +90,8 @@ static void parse_hdm_decoder_caps(struct cxl_hdm *cxlhdm)
 		cxlhdm->iw_cap_mask |= BIT(3) | BIT(6) | BIT(12);
 	if (FIELD_GET(CXL_HDM_DECODER_INTERLEAVE_16_WAY, hdm_cap))
 		cxlhdm->iw_cap_mask |= BIT(16);
+	cxlhdm->supported_coherency =
+		FIELD_GET(CXL_HDM_DECODER_SUPPORTED_COHERENCY_MASK, hdm_cap);
 }
 
 static bool should_emulate_decoders(struct cxl_endpoint_dvsec_info *info)
@@ -1054,6 +1056,19 @@ static int cxl_setup_hdm_decoder_from_dvsec(
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
@@ -1117,17 +1132,7 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
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
index f22478c340bd..176c359bd68c 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -53,7 +53,7 @@ extern const struct nvdimm_security_ops *cxl_security_ops;
 #define CXL_BI_RT_CAPABILITY_LENGTH 0xC
 #define CXL_BI_DECODER_CAPABILITY_LENGTH 0xC
 
-/* HDM decoders CXL 2.0 8.2.5.12 CXL HDM Decoder Capability Structure */
+/* HDM decoders CXL 4.0 8.2.4.20 CXL HDM Decoder Capability Structure */
 #define CXL_HDM_DECODER_CAP_OFFSET 0x0
 #define   CXL_HDM_DECODER_COUNT_MASK GENMASK(3, 0)
 #define   CXL_HDM_DECODER_TARGET_COUNT_MASK GENMASK(7, 4)
@@ -61,6 +61,11 @@ extern const struct nvdimm_security_ops *cxl_security_ops;
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
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 35268d1c387c..348e63aef804 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -933,6 +933,7 @@ int cxl_mem_sanitize(struct cxl_memdev *cxlmd, u16 cmd);
  * @target_count: for switch decoders, max downstream port targets
  * @interleave_mask: interleave granularity capability, see check_interleave_cap()
  * @iw_cap_mask: bitmask of supported interleave ways, see check_interleave_cap()
+ * @supported_coherency: HDM Decoder Capability supported coherency models
  * @port: mapped cxl_port, see devm_cxl_setup_hdm()
  */
 struct cxl_hdm {
@@ -941,6 +942,7 @@ struct cxl_hdm {
 	unsigned int target_count;
 	unsigned int interleave_mask;
 	unsigned long iw_cap_mask;
+	unsigned int supported_coherency;
 	struct cxl_port *port;
 };
 
-- 
2.39.5

