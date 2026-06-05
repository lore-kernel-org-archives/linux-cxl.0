Received: from black.elm.relay.mailchannels.net (black.elm.relay.mailchannels.net [23.83.212.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5FD7282F27
	for <linux-cxl@vger.kernel.org>; Fri,  5 Jun 2026 01:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.212.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780621974; cv=none; b=U4zc/exsDE4JQtfLTh8pBaNjkUmnStl6DHQZ6pIJjFXLpBoV+jxlfg4KoRpIBjvNfQwtEy/xcAjeOKz6hiFaeF92lQF5KSL4cL1n9NHHsPoxgScd/SB8wFD3kIMFGiYjxARJDt8/voHdVPGsZPn54W6KEvj3GEzugFklgQDFEz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780621974; c=relaxed/simple;
	bh=sd3crRqXWTOb7aaDTz0QYqfp+hu1w80BF6+STJceKJs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gRBWxZiHSbZCCjCaHJxR3zUirLOEHXByyrvZi62wM3QF4Jfl4RHgzJbTw9pnNMn6rYwQGcNWOb2fQ/41nVKq0YOmvsiMU6cUPFGFShWdz3uhl8GUxMRCo4ylEEJkAxXBBZQS2l+yHp2VOW//v9aTbR4NId2T/aQueIaCG/AsSuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=NT7ylcG3; arc=none smtp.client-ip=23.83.212.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="NT7ylcG3"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id F000D7A12EB;
	Fri, 05 Jun 2026 00:34:10 +0000 (UTC)
Received: from pdx1-sub0-mail-a258.dreamhost.com (trex-green-5.trex.outbound.svc.cluster.local [100.116.151.109])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 946F57A124C;
	Fri, 05 Jun 2026 00:34:10 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Tangy-Wipe: 53bdc4b21fef3012_1780619650890_2460513016
X-MC-Loop-Signature: 1780619650890:2474125717
X-MC-Ingress-Time: 1780619650890
Received: from pdx1-sub0-mail-a258.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.116.151.109 (trex/7.1.5);
	Fri, 05 Jun 2026 00:34:10 +0000
Received: from localhost.localdomain (186-79-219-2.fo.baf.movistar.cl [186.79.219.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a258.dreamhost.com (Postfix) with ESMTPSA id 4gWj9V5hQgz1040;
	Thu,  4 Jun 2026 17:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1780619650;
	bh=N2WO0R5l8L6mzOKVxX/ppAc5uGpJZVj8XUGcUQS5k2k=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=NT7ylcG3BbW/mEwbVWDJUVuBP3/ct8f4hAVXPoNq9CTxD6mJJcjarCefZDd8GVYSG
	 Rx3uGmiRhLa/Jm811ePt7y7GMNxI1J8uvbkYTO6BVG8tG+y7weTrSkcbx3MkQU20kU
	 lN3HML2yzzWu4IsO0t+nTIrWiO0B7IumUE+xZQmtZ1PLPyEQiOwHNVoW3Yem3HBVWb
	 JPc3qGWMmf/OWoDX4OW9BVASX8iwFz7z71hzJyWhiV4K5H/brVMYZ9cMoeWAK+nuMS
	 F2ZM+casE+lmNMb07cYiTDWwDk5oQzhkD6szsz7UN0lffyg3RGWU80yXpaqteCa0Ky
	 Wtk5AAwhBgX9w==
From: Davidlohr Bueso <dave@stgolabs.net>
To: dave.jiang@intel.com,
	djbw@kernel.org
Cc: jic23@kernel.org,
	benjamin.cheatham@amd.com,
	alucerop@amd.com,
	alison.schofield@intel.com,
	gourry@gourry.net,
	dongjoo.seo1@samsung.com,
	dave@stgolabs.net,
	linux-cxl@vger.kernel.org
Subject: [PATCH 3/5] cxl/hdm: Add BI coherency support for endpoint decoders
Date: Thu,  4 Jun 2026 17:33:27 -0700
Message-Id: <20260605003329.2584012-4-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260605003329.2584012-1-dave@stgolabs.net>
References: <20260605003329.2584012-1-dave@stgolabs.net>
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

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 drivers/cxl/core/hdm.c | 24 +++++++++++++++++++++---
 drivers/cxl/cxl.h      |  6 ++++++
 drivers/cxl/cxlmem.h   |  2 ++
 3 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 0c80b76a5f9b..4a41cde9fdba 100644
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
@@ -1023,6 +1025,14 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
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
@@ -1042,12 +1052,20 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 		if (cxled) {
 			struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
 			struct cxl_dev_state *cxlds = cxlmd->cxlds;
+			struct cxl_hdm *cxlhdm = dev_get_drvdata(&port->dev);
 
 			/*
-			 * Default by devtype until a device arrives that needs
-			 * more precision.
+			 * HDMs that advertise support for both coherency
+			 * modes (CXL_HDM_DECODER_COHERENCY_BOTH) default to
+			 * host-only here; the region attach path will switch
+			 * target_type to device-coherent if the region's
+			 * root decoder has the CFMWS BI bit set. Only HDMs
+			 * that strictly support device-coherent mode default
+			 * to HDM-DB.
 			 */
-			if (cxlds->type == CXL_DEVTYPE_CLASSMEM)
+			if (cxlds->type == CXL_DEVTYPE_CLASSMEM &&
+			    cxlhdm->supported_coherency !=
+			    CXL_HDM_DECODER_COHERENCY_DEV)
 				cxld->target_type = CXL_DECODER_HOSTONLYMEM;
 			else
 				cxld->target_type = CXL_DECODER_DEVMEM;
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 89c0c6ce24a3..917a6aee5936 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -57,6 +57,11 @@ extern const struct nvdimm_security_ops *cxl_security_ops;
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

