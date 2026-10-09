Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D9E3D25CC
	for <linux-cxl@vger.kernel.org>; Fri,  9 Oct 2026 22:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791583941; cv=none; b=J8uAaMEj5BZACLst20RL2XCMQlxO3e5STVFZvrVUAesrzd8dNT3N1s7nVAeBra3nxgCdisPfLuKxkXL82isNTMn7QPu+G+g/BZ7tJRc4nqosRvktg31S3qo5iMCH1lMm1o/VGKoGpLsvnDdaIimCu1hbVvGoOd9Irwo3GqD7pOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791583941; c=relaxed/simple;
	bh=Mg0Hgg3a3ekPOmmfNTFi+s9JFn9Us8FC2wDUUxwpVo8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iClbtWmSgNfL3kl3SaKyVxGtipOWua2FCcBgfZHZBpgNC5Llw56/52W8MUHfLTZJ/i/aJIxafTJDZochVVEWz8ABn5O0RcFrhJsRT9MEG8lZ7I9twpV25GwXWbZHF9GSNTpfMd0Bu2DlXSdCiX5UMayOhzerC1aA6pOoN4dd410=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=fail smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P7eWqUCD; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P7eWqUCD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791583936; x=1823119936;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Mg0Hgg3a3ekPOmmfNTFi+s9JFn9Us8FC2wDUUxwpVo8=;
  b=P7eWqUCDCa4IP+J2zkjNDQf+hgcrHZ+KoRKEZpl+FplgaPo3hdwuYi2h
   WzAQsWxBf1VW9kGJrVC2u5nGxwL+c+HaTWm//BSAnfS3TcifRhXplsj/H
   gojDEEynLmoXNU2Z9gD2sx0iTeWU095+338/Un4DHDECtzD22jXZ2eyH6
   K9q8c5oxy0bNS9OpevaS2SRrC5BDyuxzFcyDGmQDccLbLjuzGMTIIcbDL
   XQuWusEcl61VJeZUBuxZnZ4eNR/tRzyfa8BSciIa9pkrfZMdA8yG0eDJa
   svwSc+3MW2ous6H/YwJzWtJRKwlrHSbPK41XcJszFkd5Zpn5JAmgBqV22
   A==;
X-CSE-ConnectionGUID: fLh+SpcBRRODta20IIxwHA==
X-CSE-MsgGUID: 0LWP8r6zQ5igLXQDtrwJyA==
X-IronPort-AV: E=McAfee;i="6800,10657,11930"; a="294833"
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="294833"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 15:11:33 -0700
X-CSE-ConnectionGUID: 9yBO7LWTRWyxoPxeHNnA5Q==
X-CSE-MsgGUID: AQisahguT2agArfh8dMKgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="505710"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.221.202])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 15:11:33 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>,
	Richard Cheng <icheng@nvidia.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH v2 2/3] tools/testing/cxl: Skip the auto region when no volatile window is active
Date: Fri,  9 Oct 2026 15:11:22 -0700
Message-ID: <08e082b7f77318f295fe700b2ec917e0e0815c08.1791582353.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1791582353.git.alison.schofield@intel.com>
References: <cover.1791582353.git.alison.schofield@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The mock auto region always uses CFMWS0. With XOR interleave arithmetic
that window is inactive, so its HPA base is never assigned and the
endpoint decoders are programmed at HPA 0.

No root decoder matches that range, leaving DPA allocated to endpoint
decoders that are not part of a region.

Set up the auto region only when a volatile window is active.

Assisted-by: LLM
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
Changes in v2:
- Avoid duplicate look up of auto region window (RichardC)
---
 tools/testing/cxl/test/cxl.c | 36 ++++++++++++++++++++++++++++--------
 1 file changed, 28 insertions(+), 8 deletions(-)

diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index aa140307e0c3..46a87633e962 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -423,6 +423,18 @@ struct acpi_cedt_cxims *mock_cxims[1] = {
 	[0] = &mock_cedt.cxims0.cxims,
 };
 
+static struct acpi_cedt_cfmws *mock_auto_region_cfmws(void)
+{
+	for (int i = cfmws_start; i <= cfmws_end; i++) {
+		struct acpi_cedt_cfmws *window = mock_cfmws[i];
+
+		if (window->restrictions & ACPI_CEDT_CFMWS_RESTRICT_VOLATILE)
+			return window;
+	}
+
+	return NULL;
+}
+
 struct cxl_mock_res {
 	struct list_head list;
 	struct range range;
@@ -1091,7 +1103,8 @@ enum cxld_init_type {
 static enum cxld_init_type get_decoder_init_type(struct cxl_decoder *cxld,
 						 struct platform_device *pdev,
 						 bool hb0,
-						 struct cxl_test_decoder **td)
+						 struct cxl_test_decoder **td,
+						 struct acpi_cedt_cfmws **window)
 {
 	struct cxl_test_decoder *found_td = cxld_registry_find(cxld);
 
@@ -1101,6 +1114,7 @@ static enum cxld_init_type get_decoder_init_type(struct cxl_decoder *cxld,
 	}
 
 	*td = NULL;
+	*window = NULL;
 
 	/*
 	 * The first decoder on the first 2 devices on the first switch
@@ -1114,6 +1128,11 @@ static enum cxld_init_type get_decoder_init_type(struct cxl_decoder *cxld,
 	    pdev->id > 4 || cxld->id > 0)
 		return MOCK_DECODER_INIT_DEFAULT;
 
+	/* XOR windows are all pmem, no window to host the RAM region */
+	*window = mock_auto_region_cfmws();
+	if (!*window)
+		return MOCK_DECODER_INIT_DEFAULT;
+
 	return type2_test ? MOCK_DECODER_INIT_TYPE2_AUTO :
 			    MOCK_DECODER_INIT_TYPE3_AUTO;
 }
@@ -1135,9 +1154,9 @@ static bool mock_decoder_handle_saved(struct cxl_decoder *cxld, struct cxl_test_
 }
 
 static void mock_init_hdm_type2_cxled(struct cxl_endpoint_decoder *cxled,
-				      struct cxl_port *port)
+				      struct cxl_port *port,
+				      struct acpi_cedt_cfmws *window)
 {
-	struct acpi_cedt_cfmws *window = mock_cfmws[0];
 	struct cxl_decoder *cxld = &cxled->cxld;
 	struct cxl_switch_decoder *cxlsd;
 	struct cxl_dport *dport;
@@ -1209,9 +1228,9 @@ static void mock_init_hdm_type2_cxled(struct cxl_endpoint_decoder *cxled,
 static void mock_init_hdm_type3_cxled(struct cxl_endpoint_decoder *cxled,
 				      struct cxl_port *port,
 				      struct platform_device *pdev,
-				      bool hb0)
+				      bool hb0,
+				      struct acpi_cedt_cfmws *window)
 {
-	struct acpi_cedt_cfmws *window = mock_cfmws[0];
 	struct cxl_decoder *cxld = &cxled->cxld;
 	struct cxl_switch_decoder *cxlsd;
 	struct cxl_dport *dport;
@@ -1326,6 +1345,7 @@ static bool mock_init_hdm_decoder(struct cxl_decoder *cxld)
 {
 	struct cxl_endpoint_decoder *cxled = NULL;
 	struct platform_device *pdev = NULL;
+	struct acpi_cedt_cfmws *window;
 	struct cxl_test_decoder *td;
 	struct cxl_memdev *cxlmd;
 	struct cxl_port *port;
@@ -1354,7 +1374,7 @@ static bool mock_init_hdm_decoder(struct cxl_decoder *cxld)
 		port = to_cxl_port(cxld->dev.parent);
 	}
 
-	switch (get_decoder_init_type(cxld, pdev, hb0, &td)) {
+	switch (get_decoder_init_type(cxld, pdev, hb0, &td, &window)) {
 	case MOCK_DECODER_INIT_SAVED:
 		if (WARN_ON(!td))
 			return false;
@@ -1367,10 +1387,10 @@ static bool mock_init_hdm_decoder(struct cxl_decoder *cxld)
 		default_mock_decoder(cxld);
 		return false;
 	case MOCK_DECODER_INIT_TYPE3_AUTO:
-		mock_init_hdm_type3_cxled(cxled, port, pdev, hb0);
+		mock_init_hdm_type3_cxled(cxled, port, pdev, hb0, window);
 		return false;
 	case MOCK_DECODER_INIT_TYPE2_AUTO:
-		mock_init_hdm_type2_cxled(cxled, port);
+		mock_init_hdm_type2_cxled(cxled, port, window);
 		return false;
 	default:
 		return false;
-- 
2.37.3

