Received: from dog.elm.relay.mailchannels.net (dog.elm.relay.mailchannels.net [23.83.212.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7C8126BF7
	for <linux-cxl@vger.kernel.org>; Sun, 15 Mar 2026 20:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.212.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773607612; cv=pass; b=RwZ2VaarG2sxo1MCaI6UGkyMb5qcDO2F7KNCw2Zy8R72yvAD9MoiYTThbcYAlbCGz4Gy+tghZAr8DBSRicUTugJxmO7xcNKj3rOlGsVGh49VpgHyVxrA0t8pno6rkETMMRqZmQEw2W6jNfyy8euUNEqMhPgcbh4154tghmyG5Zo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773607612; c=relaxed/simple;
	bh=SShNfpm4xt4gZSl/0e19Zutg1LqeP2VowBEFISgc1rc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UZvwjHQGH9WrZS/5j6B7sdKqNDOWkMB/aQtJGljhReC7F9DBq0iPXCs4xOCnT0qn6HPVTWRze2BMUT7PXM0MU5+RGZd3Mqv7ugMoOGayMEXrRGgivV8e3aHC+WZnXR9dbLH2S/q1irzIbEqo/p8zcnaZ9nMzxQLIi+q5v6utyuQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=qJx2hrCf; arc=pass smtp.client-ip=23.83.212.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="qJx2hrCf"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 522201813C8;
	Sun, 15 Mar 2026 20:27:46 +0000 (UTC)
Received: from pdx1-sub0-mail-a246.dreamhost.com (100-113-205-4.trex-nlb.outbound.svc.cluster.local [100.113.205.4])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 9E9D2181A96;
	Sun, 15 Mar 2026 20:27:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1773606464;
	b=g0wVkvxYAhSGta/mAhldiumi68WSGCPFYr6zKkfwHRw/KTYuUT2D+dVix8WU5WvSyfL0ez
	qTnrwA0oba1SHqmyGkB183R2mXQI9LS4Iwd8pEF7JmNZHTg/D7savyLx4TNoOlktVXPi5m
	eFl5VeTkboiYU92zZybnZmxtsMM3cHTFfyRpdSJElqUBbtPsyh0OxblbZ341iN56VHsGyP
	IZ42TRbakeB/q3pJNHI0+T8xt0Y0jOMvmZedLww27k8KjRrdcZaYuO+jZIv+XXWHkrzfjM
	ZtUGp1T1LSLiZzeFa6u2x/2wQOQ8oC3ulb+uKItDpzy7Yr6i6TEubttjqWGywQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1773606464;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=3A6xQSBxP0qwC8BrzXhjlfB4vAUPD0IY1OC4KDXhZvE=;
	b=mmXA54SWOi41m9s3BY5xj1INuCnsqWjQAKFOizhlzA00MwjUW3w5458IeSfH0K3vFelsKA
	WtKfR9q1Mi6WMgk/cWsZwzFz7nnyKzVkxu2w93UQuzWERoBBxe5ha4LY+uDuUG9UYwsA7a
	bK2A8vCAsWTPDumXwAhBv6zG05h8lN8eEbDQ8aCqxZSEcy73rw9Adb8zgeGONh1HLh+A4S
	eQR7FUgmug+SCqj70HfKM/uJ8lJloyv1hOqD4QZzNJt8UoIjOMgE7UH11hyywyyM8HnSH8
	SAluKMoYXAszaOoHyI8NtzfuLnNkLx8VZhuSX/Kcgjc9VjBZ5nvHbS0wCdXkrw==
ARC-Authentication-Results: i=1;
	rspamd-c9674b64d-khjlw;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Shade-Shelf: 3bd93999040a2f94_1773606464924_3004841621
X-MC-Loop-Signature: 1773606464924:464812912
X-MC-Ingress-Time: 1773606464924
Received: from pdx1-sub0-mail-a246.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.113.205.4 (trex/7.1.5);
	Sun, 15 Mar 2026 20:27:44 +0000
Received: from offworld.lan (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a246.dreamhost.com (Postfix) with ESMTPSA id 4fYqXb6spyz107h;
	Sun, 15 Mar 2026 13:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1773606464;
	bh=3A6xQSBxP0qwC8BrzXhjlfB4vAUPD0IY1OC4KDXhZvE=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=qJx2hrCf/vdGZClxsTIGfnEcOfqnU4t3649o2T6kvsjLW8enEbR7p8jWxsLHit+55
	 pfrBLaYciVdzydtDfRnR1AFsscZcLsxUE9vFtbJKqgUBezuCivw0AnxakoxA8r6vIJ
	 68uG5u6gftAU7NPY+tDJSPMZRFXJOp67gSroxHDWZOLVvrSXgu7Tvc6xyXU5YAX2Eb
	 kE5EK38sXZD6EjIlpLQ0jA7W/K+6DPeFwEX0dxnE+9/aBWXyIV2Px4g1N2cW/2NLwq
	 +h8MwriFqbDPMW3sR4/TMD9b9eWwhTEBIlRNj90Z99BhbqjQtz4xSm+ZQgHVq8SREr
	 ucBCeBJFDZSCA==
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
Subject: [PATCH 1/6] cxl: Add Back-Invalidate register definitions and structures
Date: Sun, 15 Mar 2026 13:27:36 -0700
Message-Id: <20260315202741.3264295-2-dave@stgolabs.net>
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

Add CXL Back-Invalidate (BI) capability IDs, register definitions for
the BI Route Table and BI Decoder capability structures, and associated
fields. This includes HDM decoder coherency capability and control fields
needed to support HDM-DB (device-managed coherency with back-invalidate).

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 drivers/cxl/cxl.h    | 41 +++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxlmem.h |  2 ++
 include/cxl/cxl.h    |  5 +++++
 3 files changed, 48 insertions(+)

diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 031846eab02c..efe06d60b364 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -42,6 +42,8 @@ extern const struct nvdimm_security_ops *cxl_security_ops;
 #define   CXL_CM_CAP_CAP_ID_RAS 0x2
 #define   CXL_CM_CAP_CAP_ID_HDM 0x5
 #define   CXL_CM_CAP_CAP_HDM_VERSION 1
+#define   CXL_CM_CAP_CAP_ID_BI_RT 0xB
+#define   CXL_CM_CAP_CAP_ID_BI_DECODER 0xC
 
 /* HDM decoders CXL 2.0 8.2.5.12 CXL HDM Decoder Capability Structure */
 #define CXL_HDM_DECODER_CAP_OFFSET 0x0
@@ -51,6 +53,10 @@ extern const struct nvdimm_security_ops *cxl_security_ops;
 #define   CXL_HDM_DECODER_INTERLEAVE_14_12 BIT(9)
 #define   CXL_HDM_DECODER_INTERLEAVE_3_6_12_WAY BIT(11)
 #define   CXL_HDM_DECODER_INTERLEAVE_16_WAY BIT(12)
+#define   CXL_HDM_DECODER_SUPPORTED_COHERENCY_MASK GENMASK(22, 21)
+#define     CXL_HDM_DECODER_COHERENCY_DEV 0x1
+#define     CXL_HDM_DECODER_COHERENCY_HOST 0x2
+#define     CXL_HDM_DECODER_COHERENCY_BOTH 0x3
 #define CXL_HDM_DECODER_CTRL_OFFSET 0x4
 #define   CXL_HDM_DECODER_ENABLE BIT(1)
 #define CXL_HDM_DECODER0_BASE_LOW_OFFSET(i) (0x20 * (i) + 0x10)
@@ -65,6 +71,7 @@ extern const struct nvdimm_security_ops *cxl_security_ops;
 #define   CXL_HDM_DECODER0_CTRL_COMMITTED BIT(10)
 #define   CXL_HDM_DECODER0_CTRL_COMMIT_ERROR BIT(11)
 #define   CXL_HDM_DECODER0_CTRL_HOSTONLY BIT(12)
+#define   CXL_HDM_DECODER0_CTRL_BI BIT(13)
 #define CXL_HDM_DECODER0_TL_LOW(i) (0x20 * (i) + 0x24)
 #define CXL_HDM_DECODER0_TL_HIGH(i) (0x20 * (i) + 0x28)
 #define CXL_HDM_DECODER0_SKIP_LOW(i) CXL_HDM_DECODER0_TL_LOW(i)
@@ -152,6 +159,33 @@ static inline int ways_to_eiw(unsigned int ways, u8 *eiw)
 #define CXL_HEADERLOG_SIZE SZ_512
 #define CXL_HEADERLOG_SIZE_U32 SZ_512 / sizeof(u32)
 
+/* CXL 3.2 8.2.4.26 CXL BI Route Table Capability Structure */
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
@@ -241,6 +275,7 @@ int cxl_dport_map_rcd_linkcap(struct pci_dev *pdev, struct cxl_dport *dport);
 #define CXL_DECODER_F_LOCK  BIT(4)
 #define CXL_DECODER_F_ENABLE    BIT(5)
 #define CXL_DECODER_F_NORMALIZED_ADDRESSING BIT(6)
+#define CXL_DECODER_F_BI    BIT(7)
 
 enum cxl_decoder_type {
 	CXL_DECODER_DEVMEM = 2,
@@ -522,6 +557,7 @@ struct cxl_dax_region {
  * @decoder_ida: allocator for decoder ids
  * @reg_map: component and ras register mapping parameters
  * @regs: mapped component registers
+ * @uport_regs: mapped upstream port component registers (BI RT)
  * @nr_dports: number of entries in @dports
  * @hdm_end: track last allocated HDM decoder instance for allocation ordering
  * @commit_end: cursor to track highest committed decoder for commit ordering
@@ -530,6 +566,7 @@ struct cxl_dax_region {
  * @cdat: Cached CDAT data
  * @cdat_available: Should a CDAT attribute be available in sysfs
  * @pci_latency: Upstream latency in picoseconds
+ * @nr_bi: number of BI-enabled endpoints below this port
  * @component_reg_phys: Physical address of component register
  */
 struct cxl_port {
@@ -544,6 +581,7 @@ struct cxl_port {
 	struct ida decoder_ida;
 	struct cxl_register_map reg_map;
 	struct cxl_component_regs regs;
+	struct cxl_component_regs uport_regs;
 	int nr_dports;
 	int hdm_end;
 	int commit_end;
@@ -555,6 +593,7 @@ struct cxl_port {
 	} cdat;
 	bool cdat_available;
 	long pci_latency;
+	int nr_bi;
 	resource_size_t component_reg_phys;
 };
 
@@ -875,6 +914,8 @@ void cxl_coordinates_combine(struct access_coordinate *out,
 			     struct access_coordinate *c2);
 
 bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port);
+int cxl_bi_setup(struct cxl_dev_state *cxlds);
+int cxl_bi_dealloc(struct cxl_dev_state *cxlds);
 struct cxl_dport *devm_cxl_add_dport_by_dev(struct cxl_port *port,
 					    struct device *dport_dev);
 
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 281546de426e..efab65f68575 100644
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
 
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index fa7269154620..74be940364e1 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -34,10 +34,12 @@ struct cxl_regs {
 	 * Common set of CXL Component register block base pointers
 	 * @hdm_decoder: CXL 2.0 8.2.5.12 CXL HDM Decoder Capability Structure
 	 * @ras: CXL 2.0 8.2.5.9 CXL RAS Capability Structure
+	 * @bi: CXL 3.2 8.2.4.26/27 CXL BI Capability Structure
 	 */
 	struct_group_tagged(cxl_component_regs, component,
 		void __iomem *hdm_decoder;
 		void __iomem *ras;
+		void __iomem *bi;
 	);
 	/*
 	 * Common set of CXL Device register block base pointers
@@ -80,6 +82,7 @@ struct cxl_reg_map {
 struct cxl_component_reg_map {
 	struct cxl_reg_map hdm_decoder;
 	struct cxl_reg_map ras;
+	struct cxl_reg_map bi;
 };
 
 struct cxl_device_reg_map {
@@ -162,6 +165,7 @@ struct cxl_dpa_partition {
  * @regs: Parsed register blocks
  * @cxl_dvsec: Offset to the PCIe device DVSEC
  * @rcd: operating in RCD mode (CXL 3.0 9.11.8 CXL Devices Attached to an RCH)
+ * @bi: device is BI (Back-Invalidate) enabled
  * @media_ready: Indicate whether the device media is usable
  * @dpa_res: Overall DPA resource tree for the device
  * @part: DPA partition array
@@ -181,6 +185,7 @@ struct cxl_dev_state {
 	struct cxl_device_regs regs;
 	int cxl_dvsec;
 	bool rcd;
+	bool bi;
 	bool media_ready;
 	struct resource dpa_res;
 	struct cxl_dpa_partition part[CXL_NR_PARTITIONS_MAX];
-- 
2.39.5

