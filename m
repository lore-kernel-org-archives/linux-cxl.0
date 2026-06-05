Received: from poodle.tulip.relay.mailchannels.net (poodle.tulip.relay.mailchannels.net [23.83.218.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8DC32030A
	for <linux-cxl@vger.kernel.org>; Fri,  5 Jun 2026 00:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.218.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780620014; cv=none; b=B1q8Mi3BMVj8kjUy80QTDYrs2aUXJOyMjpy86cVxC1nMrMbgwSSOSpEAsGZQgXDMPkxTH9glV/KXz8QuAFMCKNHRiuV+1AwlA6Z2fk9x3gOoA7b0R5OpX1gDDnrnr+IyUTUUJmUsy+zYa7gJ5RkocobxuSlEwg6hViDpRLFqZ6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780620014; c=relaxed/simple;
	bh=xFU21bl1ZyW6vYXgk8X2oI35g2z0kkxprR/uIpfzUQ4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MQQqn3Zwh9THTQ3BV2K8eoVqdWNvC95AjZBTiICAUlVAR4fqdLW0ika5urwK+3mPoEx14zJWQ0sipLyJz2I43BFIyzW4hTDW0sb+0zBzUb1emg0iH45citipATpBNCLk0QGXm/ospANPyB/WEaoPG+Giz0TYxOXPgU61z0wuL4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=E8FmEspi; arc=none smtp.client-ip=23.83.218.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="E8FmEspi"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 58146801667;
	Fri, 05 Jun 2026 00:34:15 +0000 (UTC)
Received: from pdx1-sub0-mail-a258.dreamhost.com (100-114-96-96.trex-nlb.outbound.svc.cluster.local [100.114.96.96])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 0393A801668;
	Fri, 05 Jun 2026 00:34:15 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Reaction-Society: 2caf0c8c55f32744_1780619655296_1467051840
X-MC-Loop-Signature: 1780619655296:2819244347
X-MC-Ingress-Time: 1780619655296
Received: from pdx1-sub0-mail-a258.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.114.96.96 (trex/7.1.5);
	Fri, 05 Jun 2026 00:34:15 +0000
Received: from localhost.localdomain (186-79-219-2.fo.baf.movistar.cl [186.79.219.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a258.dreamhost.com (Postfix) with ESMTPSA id 4gWj9b0ZtKz1040;
	Thu,  4 Jun 2026 17:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1780619654;
	bh=SRb/iwZHQjsTS13QqE3GVAm70L4O27fppr8Q5HEf5D4=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=E8FmEspiHXHf5l6mCti08BQlCIpDaf++wPQdwNOBCl7pqdaLwhh7EvTSXa2KcpQky
	 qGvOWWcspAiqWHKJRKBgY4rz/EP65vRmYDeu8ZlsmTuw7HnkZ/QAhZ85fFM2MZllWt
	 pXvePfjlsnTeZSLWHbwuzUk9QalH5mT5EbiRe22MjlstGFZ3Jv3auiRZeGttikHZ9z
	 SjYB/bo40rQs/dtUFY8oAOQnFjXy2xgatfDUIKY7mvMssw0V00iej3VjU1xRtcHjVY
	 Li+q1RfqrgJCWvdLqp3UkhNYNCBHpGHiPitEKDZMMkgvybpn2QONK2XeP5Fjja1XNP
	 Tp2ko3rAL41/A==
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
Subject: [PATCH 4/5] cxl: Add HDM-DB region creation
Date: Thu,  4 Jun 2026 17:33:28 -0700
Message-Id: <20260605003329.2584012-5-dave@stgolabs.net>
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

A region inherits its coherency from the chosen root decoder: HDM-DB
if the root has CXL_DECODER_F_BI, otherwise HDM-H.

Surface the topology through read-only sysfs:

  - decoderX.Y/cap_bi (root): CFMWS BI restriction.
  - decoderX.Y/bi (endpoint): '1' when configured for HDM-DB.

cxl_region_attach() rejects endpoints whose device or HDM cannot
serve the region's type; target_type is inherited from cxlr->type
in cxl_rr_assign_decoder().

The HDM Decoder Control BI bit is set at commit time only when the
target_type is DEVMEM and the BI capability is advertised
(cxlds->bi for endpoints, root F_BI for switches).

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 Documentation/ABI/testing/sysfs-bus-cxl | 18 +++++++--
 drivers/cxl/acpi.c                      | 11 +++++-
 drivers/cxl/core/hdm.c                  | 14 +++++++
 drivers/cxl/core/port.c                 | 29 ++++++++++++--
 drivers/cxl/core/region.c               | 51 +++++++++++++++++--------
 drivers/cxl/cxl.h                       |  1 +
 6 files changed, 100 insertions(+), 24 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
index 16a9b3d2e2c0..f631a94f098d 100644
--- a/Documentation/ABI/testing/sysfs-bus-cxl
+++ b/Documentation/ABI/testing/sysfs-bus-cxl
@@ -297,7 +297,7 @@ Description:
 		Each entry in the list is a dport id.
 
 
-What:		/sys/bus/cxl/devices/decoderX.Y/cap_{pmem,ram,type2,type3}
+What:		/sys/bus/cxl/devices/decoderX.Y/cap_{pmem,ram,type2,type3,bi}
 Date:		June, 2021
 KernelVersion:	v5.14
 Contact:	linux-cxl@vger.kernel.org
@@ -306,8 +306,9 @@ Description:
 		represents a fixed memory window identified by platform
 		firmware. A fixed window may only support a subset of memory
 		types. The 'cap_*' attributes indicate whether persistent
-		memory, volatile memory, accelerator memory, and / or expander
-		memory may be mapped behind this decoder's memory window.
+		memory, volatile memory, accelerator memory, expander memory,
+		and / or back-invalidate (HDM-DB) memory may be mapped behind
+		this decoder's memory window.
 
 
 What:		/sys/bus/cxl/devices/decoderX.Y/target_type
@@ -426,6 +427,17 @@ Description:
 		current cached value.
 
 
+What:		/sys/bus/cxl/devices/decoderX.Y/bi
+Date:		June, 2026
+KernelVersion:	v7.2
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(RO) Shows '1' if this endpoint decoder is currently configured
+		for HDM-DB (device-managed coherency with back-invalidate).
+		The HDM-DB state is inherited from the region the decoder is
+		attached to, which is in turn set from the chosen root
+		decoder's CFMWS BI restriction (see cap_bi).
+
 What:		/sys/bus/cxl/devices/decoderX.Y/delete_region
 Date:		May, 2022
 KernelVersion:	v6.0
diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 127537628817..6a9ba82719e9 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -152,6 +152,8 @@ static unsigned long cfmws_to_decoder_flags(int restrictions)
 		flags |= CXL_DECODER_F_PMEM;
 	if (restrictions & ACPI_CEDT_CFMWS_RESTRICT_FIXED)
 		flags |= CXL_DECODER_F_LOCK;
+	if (restrictions & ACPI_CEDT_CFMWS_RESTRICT_BI)
+		flags |= CXL_DECODER_F_BI;
 
 	return flags;
 }
@@ -198,6 +200,12 @@ static int cxl_acpi_cfmws_verify(struct device *dev,
 		dev_dbg(dev, "CFMWS length %d greater than expected %d\n",
 			cfmws->header.length, expected_len);
 
+	if ((cfmws->restrictions & ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM) &&
+	    (cfmws->restrictions & ACPI_CEDT_CFMWS_RESTRICT_BI)) {
+		dev_err(dev, "CFMWS cannot have both HDM-H and HDM-DB\n");
+		return -EINVAL;
+	}
+
 	return 0;
 }
 
@@ -437,7 +445,8 @@ static int __cxl_parse_cfmws(struct acpi_cedt_cfmws *cfmws,
 
 	cxld = &cxlrd->cxlsd.cxld;
 	cxld->flags = cfmws_to_decoder_flags(cfmws->restrictions);
-	cxld->target_type = CXL_DECODER_HOSTONLYMEM;
+	cxld->target_type = (cxld->flags & CXL_DECODER_F_TYPE2) ?
+		CXL_DECODER_DEVMEM : CXL_DECODER_HOSTONLYMEM;
 	cxld->hpa_range = (struct range) {
 		.start = cfmws->base_hpa,
 		.end = cfmws->base_hpa + cfmws->window_size - 1,
diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 4a41cde9fdba..70c797c77b70 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -705,9 +705,23 @@ static void cxld_set_interleave(struct cxl_decoder *cxld, u32 *ctrl)
 
 static void cxld_set_type(struct cxl_decoder *cxld, u32 *ctrl)
 {
+	bool bi = cxld->target_type == CXL_DECODER_DEVMEM;
+
+	if (is_endpoint_decoder(&cxld->dev)) {
+		struct cxl_endpoint_decoder *cxled = to_cxl_endpoint_decoder(&cxld->dev);
+		struct cxl_dev_state *cxlds = cxled_to_memdev(cxled)->cxlds;
+
+		bi = bi && cxlds->bi;
+	} else if (cxld->region) {
+		struct cxl_root_decoder *cxlrd = cxld->region->cxlrd;
+
+		bi = bi && (cxlrd->cxlsd.cxld.flags & CXL_DECODER_F_BI);
+	}
+
 	u32p_replace_bits(ctrl,
 			  !!(cxld->target_type == CXL_DECODER_HOSTONLYMEM),
 			  CXL_HDM_DECODER0_CTRL_HOSTONLY);
+	u32p_replace_bits(ctrl, bi, CXL_HDM_DECODER0_CTRL_BI);
 }
 
 static void cxlsd_set_targets(struct cxl_switch_decoder *cxlsd, u64 *tgt)
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index c5aacd7054f1..2b463a8b06a7 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -131,6 +131,7 @@ CXL_DECODER_FLAG_ATTR(cap_ram, CXL_DECODER_F_RAM);
 CXL_DECODER_FLAG_ATTR(cap_type2, CXL_DECODER_F_TYPE2);
 CXL_DECODER_FLAG_ATTR(cap_type3, CXL_DECODER_F_TYPE3);
 CXL_DECODER_FLAG_ATTR(locked, CXL_DECODER_F_LOCK);
+CXL_DECODER_FLAG_ATTR(cap_bi, CXL_DECODER_F_BI);
 
 static ssize_t target_type_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
@@ -233,6 +234,18 @@ static ssize_t mode_store(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RW(mode);
 
+static ssize_t bi_show(struct device *dev, struct device_attribute *attr,
+		       char *buf)
+{
+	struct cxl_endpoint_decoder *cxled = to_cxl_endpoint_decoder(dev);
+	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+
+	return sysfs_emit(buf, "%d\n", cxlds->bi && cxled->cxld.region &&
+			  cxled->cxld.target_type == CXL_DECODER_DEVMEM);
+}
+static DEVICE_ATTR_RO(bi);
+
 static ssize_t dpa_resource_show(struct device *dev, struct device_attribute *attr,
 			    char *buf)
 {
@@ -329,6 +342,7 @@ static struct attribute *cxl_decoder_root_attrs[] = {
 	&dev_attr_cap_ram.attr,
 	&dev_attr_cap_type2.attr,
 	&dev_attr_cap_type3.attr,
+	&dev_attr_cap_bi.attr,
 	&dev_attr_target_list.attr,
 	&dev_attr_qos_class.attr,
 	SET_CXL_REGION_ATTR(create_pmem_region)
@@ -339,16 +353,22 @@ static struct attribute *cxl_decoder_root_attrs[] = {
 
 static bool can_create_pmem(struct cxl_root_decoder *cxlrd)
 {
-	unsigned long flags = CXL_DECODER_F_TYPE3 | CXL_DECODER_F_PMEM;
+	unsigned long flags = cxlrd->cxlsd.cxld.flags;
+	unsigned long hdm_h = CXL_DECODER_F_TYPE3 | CXL_DECODER_F_PMEM;
+	unsigned long hdm_db = CXL_DECODER_F_TYPE2 | CXL_DECODER_F_BI |
+			       CXL_DECODER_F_PMEM;
 
-	return (cxlrd->cxlsd.cxld.flags & flags) == flags;
+	return (flags & hdm_h) == hdm_h || (flags & hdm_db) == hdm_db;
 }
 
 static bool can_create_ram(struct cxl_root_decoder *cxlrd)
 {
-	unsigned long flags = CXL_DECODER_F_TYPE3 | CXL_DECODER_F_RAM;
+	unsigned long flags = cxlrd->cxlsd.cxld.flags;
+	unsigned long hdm_h = CXL_DECODER_F_TYPE3 | CXL_DECODER_F_RAM;
+	unsigned long hdm_db = CXL_DECODER_F_TYPE2 | CXL_DECODER_F_BI |
+			       CXL_DECODER_F_RAM;
 
-	return (cxlrd->cxlsd.cxld.flags & flags) == flags;
+	return (flags & hdm_h) == hdm_h || (flags & hdm_db) == hdm_db;
 }
 
 static umode_t cxl_root_decoder_visible(struct kobject *kobj, struct attribute *a, int n)
@@ -402,6 +422,7 @@ static const struct attribute_group *cxl_decoder_switch_attribute_groups[] = {
 static struct attribute *cxl_decoder_endpoint_attrs[] = {
 	&dev_attr_target_type.attr,
 	&dev_attr_mode.attr,
+	&dev_attr_bi.attr,
 	&dev_attr_dpa_size.attr,
 	&dev_attr_dpa_resource.attr,
 	SET_CXL_REGION_ATTR(region)
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index e50dc716d4e8..3f9ddacfae4e 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1129,17 +1129,6 @@ static int cxl_rr_assign_decoder(struct cxl_port *port, struct cxl_region *cxlr,
 		return -EBUSY;
 	}
 
-	/*
-	 * Endpoints should already match the region type, but backstop that
-	 * assumption with an assertion. Switch-decoders change mapping-type
-	 * based on what is mapped when they are assigned to a region.
-	 */
-	dev_WARN_ONCE(&cxlr->dev,
-		      port == cxled_to_port(cxled) &&
-			      cxld->target_type != cxlr->type,
-		      "%s:%s mismatch decoder type %d -> %d\n",
-		      dev_name(&cxled_to_memdev(cxled)->dev),
-		      dev_name(&cxld->dev), cxld->target_type, cxlr->type);
 	cxld->target_type = cxlr->type;
 	cxl_rr->decoder = cxld;
 	return 0;
@@ -2034,6 +2023,7 @@ static int cxl_region_attach(struct cxl_region *cxlr,
 	struct cxl_region_params *p = &cxlr->params;
 	struct cxl_port *ep_port, *root_port;
 	struct cxl_dport *dport;
+	struct cxl_hdm *cxlhdm;
 	int rc = -ENXIO;
 
 	rc = check_interleave_cap(&cxled->cxld, p->interleave_ways,
@@ -2083,10 +2073,31 @@ static int cxl_region_attach(struct cxl_region *cxlr,
 		return -ENXIO;
 	}
 
-	if (cxled->cxld.target_type != cxlr->type) {
-		dev_dbg(&cxlr->dev, "%s:%s type mismatch: %d vs %d\n",
-			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
-			cxled->cxld.target_type, cxlr->type);
+	/*
+	 * Verify the device and HDM are capable of the region's flavor before
+	 * proceeding. The endpoint decoder's target_type is then inherited
+	 * from cxlr->type later in cxl_rr_assign_decoder().
+	 */
+	if (cxlr->type == CXL_DECODER_DEVMEM &&
+	    cxlds->type == CXL_DEVTYPE_CLASSMEM && !cxlds->bi) {
+		dev_err(&cxlr->dev, "%s:%s BI not enabled on device\n",
+			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev));
+		return -ENXIO;
+	}
+
+	cxlhdm = dev_get_drvdata(&ep_port->dev);
+	if (!cxlhdm)
+		return -ENXIO;
+	if (cxlr->type == CXL_DECODER_HOSTONLYMEM &&
+	    cxlhdm->supported_coherency == CXL_HDM_DECODER_COHERENCY_DEV) {
+		dev_dbg(&cxlr->dev, "%s:%s HDM is device-coherent only\n",
+			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev));
+		return -ENXIO;
+	}
+	if (cxlr->type == CXL_DECODER_DEVMEM &&
+	    cxlhdm->supported_coherency == CXL_HDM_DECODER_COHERENCY_HOST) {
+		dev_dbg(&cxlr->dev, "%s:%s HDM is host-only coherent\n",
+			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev));
 		return -ENXIO;
 	}
 
@@ -2772,6 +2783,7 @@ static ssize_t create_region_store(struct device *dev, const char *buf,
 				   size_t len, enum cxl_partition_mode mode)
 {
 	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(dev);
+	enum cxl_decoder_type target_type;
 	struct cxl_region *cxlr;
 	int rc, id;
 
@@ -2779,7 +2791,14 @@ static ssize_t create_region_store(struct device *dev, const char *buf,
 	if (rc != 1)
 		return -EINVAL;
 
-	cxlr = __create_region(cxlrd, mode, id, CXL_DECODER_HOSTONLYMEM);
+	/*
+	 * The CFMWS dictates endpoint coherency: a BI-restricted window
+	 * produces an HDM-DB region; otherwise HDM-H.
+	 */
+	target_type = (cxlrd->cxlsd.cxld.flags & CXL_DECODER_F_BI) ?
+			CXL_DECODER_DEVMEM : CXL_DECODER_HOSTONLYMEM;
+
+	cxlr = __create_region(cxlrd, mode, id, target_type);
 	if (IS_ERR(cxlr))
 		return PTR_ERR(cxlr);
 
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 917a6aee5936..73d4d2d4616d 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -287,6 +287,7 @@ int cxl_dport_map_rcd_linkcap(struct pci_dev *pdev, struct cxl_dport *dport);
 #define CXL_DECODER_F_LOCK  BIT(4)
 #define CXL_DECODER_F_ENABLE    BIT(5)
 #define CXL_DECODER_F_NORMALIZED_ADDRESSING BIT(6)
+#define CXL_DECODER_F_BI    BIT(7)
 #define CXL_DECODER_F_RESET_MASK (CXL_DECODER_F_ENABLE | CXL_DECODER_F_LOCK)
 
 enum cxl_decoder_type {
-- 
2.39.5

