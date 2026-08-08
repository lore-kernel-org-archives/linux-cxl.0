Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6DF1862
	for <linux-cxl@vger.kernel.org>; Sat,  8 Aug 2026 00:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786147560; cv=none; b=TFDFEuZuodgS5RnJoTpY/tafJOWITfwUGmlJvPyj8S4tzgH/H6Vvl7PomOOhEUHVgr1pvHBYHeCyLcvnHyyM4vjKK13ez+5hdEljhh2k9uAaAZ6Eiz2CBBvk5tqO6tspy3oazvSDxIJJJd7SonEBDygmoVUq9wUD2Fqtk4l2PgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786147560; c=relaxed/simple;
	bh=SHLuCcAGC0l0C5Ju/aWOP8lMJj0ZZFw1hgFQ9HiBm48=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cy16hXP6710Nyh3OdmkU38yG7uhW3PHRTftF5ZXZ/HY97MkbM22PJpCYRv9U+eY4YeEwrgCbdvJt2MswZbp2O53SHqWF8WlLEH4rGAl8xeaJACTCdueu1LVcMNY/vacskDWSyC+Q+5y0N8pltQ97zozZ2eMyz2JjCmlOLg94r60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JfPPoMgn; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JfPPoMgn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786147559; x=1817683559;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SHLuCcAGC0l0C5Ju/aWOP8lMJj0ZZFw1hgFQ9HiBm48=;
  b=JfPPoMgnopXnFgKSlhwCEK7emaZVZzW2SkBSddKWrb7NjCHnJ3VxgSbH
   LeGa/s1y7JfVRpHfllQ+McluIExSssy3Mr8NsWX6RHoTouZD46bR1+6Un
   vQCTTbS3TV6tfSCNTAuzxC0yFHNLPkFOjsDd4zEnsNyQv+SOKoXbumpih
   KJ9Kqu2Lw6jBAVRIN/1EBPk9uNLecWDIuTRXNkdahqst4v4LLOCipt8EI
   uzkQa8Ius5uMGAtu9zX0I3dJ7n5WmxviuRv72z7D2To8rDqF6FDPsQa8U
   s1rt+yPtMBgwGZ953acxuZXvu0OMa1N7ChV3Zt8V46RZ0I/EJhLTjcrFX
   g==;
X-CSE-ConnectionGUID: IoTrGGfJQ2eaGvtZxINwSQ==
X-CSE-MsgGUID: 1WFPqFHUTgi2pTpb7vKVuA==
X-IronPort-AV: E=McAfee;i="6800,10657,11868"; a="90441179"
X-IronPort-AV: E=Sophos;i="6.25,211,1779174000"; 
   d="scan'208";a="90441179"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2026 17:05:59 -0700
X-CSE-ConnectionGUID: oQdSxsYDRV6wxBIOLFTKkQ==
X-CSE-MsgGUID: o7sofpsMSkqgON/ZVdlXXg==
X-ExtLoop1: 1
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.222.80])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2026 17:05:57 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>
Cc: linux-cxl@vger.kernel.org,
	Srirangan Madhavan <smadhavan@nvidia.com>,
	Richard Cheng <icheng@nvidia.com>
Subject: [PATCH v5 1/4] cxl/hdm: Reject switch decoder interleave ways that overflow targets
Date: Fri,  7 Aug 2026 17:05:48 -0700
Message-ID: <af094094813d7f51d86cbf608936270b7d85526e.1786143520.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1786143520.git.alison.schofield@intel.com>
References: <cover.1786143520.git.alison.schofield@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Switch decoder enumeration validates that the interleave ways encoding
is legal, but not that the resulting number of ways fits the available
targets. This can overrun the target array (target_list.target_id[])
during enumeration of 12 or 16 way interleaves.

Bound the target count where it is established rather than at each use.
Reject an HDM capability whose reported target count is zero or exceeds
the target list register capacity, and reject a zero target switch
decoder allocation in cxl_switch_decoder_init(). Enumeration is then
left with a single check: reject a decoder whose interleave ways exceed
the targets it has.

Add a clarifying comment that target_count is a direct count, not
0-based like decoder_count.

Link: https://sashiko.dev/#/patchset/20260711180755.1779002-1-alison.schofield@intel.com?part=1
Fixes: d17d0540a0db ("cxl/core/hdm: Add CXL standard decoder enumeration to the core")
Tested-by: Davidlohr Bueso <dave@stgolabs.net>
Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
Reviewed-by: Richard Cheng <icheng@nvidia.com>
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/core/hdm.c  | 24 ++++++++++++++++++++++++
 drivers/cxl/core/port.c |  2 +-
 drivers/cxl/cxl.h       |  2 ++
 3 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 0c80b76a5f9b..c394b3d54d36 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -76,6 +76,8 @@ static void parse_hdm_decoder_caps(struct cxl_hdm *cxlhdm)
 
 	hdm_cap = readl(cxlhdm->regs.hdm_decoder + CXL_HDM_DECODER_CAP_OFFSET);
 	cxlhdm->decoder_count = cxl_hdm_decoder_count(hdm_cap);
+
+	/* target_count is a direct count (1h..8h), not 0-based like decoder_count */
 	cxlhdm->target_count =
 		FIELD_GET(CXL_HDM_DECODER_TARGET_COUNT_MASK, hdm_cap);
 	if (FIELD_GET(CXL_HDM_DECODER_INTERLEAVE_11_8, hdm_cap))
@@ -1084,6 +1086,16 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 		cxld->interleave_ways, cxld->interleave_granularity);
 
 	if (!cxled) {
+		struct cxl_switch_decoder *cxlsd = to_cxl_switch_decoder(&cxld->dev);
+
+		if (cxld->interleave_ways > cxlsd->nr_targets) {
+			dev_err(&port->dev,
+				"decoder%d.%d: interleave ways: %d exceeds targets: %d\n",
+				port->id, cxld->id, cxld->interleave_ways,
+				cxlsd->nr_targets);
+			return -ENXIO;
+		}
+
 		lo = readl(hdm + CXL_HDM_DECODER0_TL_LOW(which));
 		hi = readl(hdm + CXL_HDM_DECODER0_TL_HIGH(which));
 		target_list.value = (hi << 32) + lo;
@@ -1161,6 +1173,18 @@ static int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
 	int i;
 	u64 dpa_base = 0;
 
+	/*
+	 * Per CXL 4.0 8.2.4.20.1 Target Count is the number of target ports
+	 * per decoder, max 8. Endpoint decoders have no targets.
+	 */
+	if (!is_cxl_endpoint(port) &&
+	    (cxlhdm->target_count < 1 ||
+	     cxlhdm->target_count > CXL_HDM_DECODER0_TL_TARGETS)) {
+		dev_err(&port->dev, "Invalid decoder target count: %u\n",
+			cxlhdm->target_count);
+		return -ENXIO;
+	}
+
 	cxl_settle_decoders(cxlhdm);
 
 	for (i = 0; i < cxlhdm->decoder_count; i++) {
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 1215ee4f4035..28eccfdd75b8 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1979,7 +1979,7 @@ static int cxl_switch_decoder_init(struct cxl_port *port,
 				   struct cxl_switch_decoder *cxlsd,
 				   int nr_targets)
 {
-	if (nr_targets > CXL_DECODER_MAX_INTERLEAVE)
+	if (nr_targets < 1 || nr_targets > CXL_DECODER_MAX_INTERLEAVE)
 		return -EINVAL;
 
 	cxlsd->nr_targets = nr_targets;
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index c0e5308e4d1b..a1f32d39b24c 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -67,6 +67,8 @@ extern const struct nvdimm_security_ops *cxl_security_ops;
 #define   CXL_HDM_DECODER0_CTRL_HOSTONLY BIT(12)
 #define CXL_HDM_DECODER0_TL_LOW(i) (0x20 * (i) + 0x24)
 #define CXL_HDM_DECODER0_TL_HIGH(i) (0x20 * (i) + 0x28)
+/* Target list capacity, i.e. max interleave ways for a non-endpoint decoder */
+#define CXL_HDM_DECODER0_TL_TARGETS 8
 #define CXL_HDM_DECODER0_SKIP_LOW(i) CXL_HDM_DECODER0_TL_LOW(i)
 #define CXL_HDM_DECODER0_SKIP_HIGH(i) CXL_HDM_DECODER0_TL_HIGH(i)
 
-- 
2.37.3

