Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793851075;
	b=2DN2a1H6CMM9+HsvTywsn/k+FipZaNQKtqs7URb7vJaUAiQWOJ/kbPZ8Qx3K98BRQCj8
	 y3FPffvwVn3F47UTYKMXF6/zM6pwosGctf5gfJ23sbYoVKbjRqrrWL+GFNaVaExnR/A0F
	 x7EDcXKpFaSImpTuUQGKhplkTWAngXXqpZfeD4KqPRaXi+nw+4dm1u3fN33hoHc8DiAEk
	 mGXAjT3w+bPt77D+h/bP85ABYCscqSEPXhqOyEJW2VAwIaTbDJEP1f+eCWX706QvfH6GN
	 KoFnTdlcwvhBhT6k7sBdWDnFDB1fRG7ndAVbZrw5dVNtF7IAgQx2mggwXc8sRevvYjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793851075;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=FXfPFG2J9pueg32pCmr29fJyTDsWWKlwI8cye3tjdpE=;
	b=apl40i+fAdCH7F+em9rPb5kKa3sBtkMeEsEYkWGrUwQCVDleAMXkz0kdv0YOjBX39z0b
	 tc6GTX2sn9j38siQBiqV6rvnUQP46w3n4gWwQ1p94ZUOGlDta66KrB5GX2UvzrH+YaNWr
	 frfhysq7Xq5sI7EgNK1Xcvw2c8xSm5ZuedZeXWAelCtzcAaMeoKfL9DSZIq5fPmIFWyVz
	 EN/qSD6iuhCaENrSmTsY91gKZ+qOGexnVq/gIVUBLOEmAAxV9lC3GADyPCLXkG8y9DFgB
	 ZD+p9rl0fzbWgdxOMfcoOKXNZDVBQmNaCLMR9xd1JNKqyma8x1jiAqQJlzevP8gtRLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=dqrprb+w;
	arc=none smtp.remote-ip=192.198.163.16
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8677E606A329
	for <linux-cxl@vger.kernel.org>; Thu,  5 Nov 2026 03:57:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8677E606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=dqrprb+w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793851074; x=1825387074;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BthJSsiKJGSDiQEfjqAkya6Al/YRk92tGzI64uMuyqQ=;
  b=dqrprb+wJ4bVlvawv/gOe/zkvIgMkhOy1CSKmnNE6sHRK7fH2hxhyBQT
   ofvcs3+ToclDk/YO8wVsS8e3inoRVdDGtjOi1BbPZ58rbMuLzkvSBq4S6
   EFml6tAVPBCVrjiqvmgj+lrnKj5b0I71X2o2aVlS/JQsgvb7cjblhnZX/
   9metGxb4So3gLptjH/zlJLYOkQZ/YmsbuNIY7R1AuSnIi/mZe4ol2NDBQ
   mSNcRLgPU9oqEIzVfEcjkhmSoqAC6ocMx2xJTickafVAxDBit+RrNARui
   WAcyLQ95N310cflo1DZh4qH3bsxeudOSzPYrKtqqKKECGWcrNXS2xPO0U
   w==;
X-CSE-ConnectionGUID: oQMAiSv5S3GrIK4vw169eQ==
X-CSE-MsgGUID: JQ3ha7bsSiKijrtUrXQKFg==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2643978"
X-IronPort-AV: E=Sophos;i="6.27,196,1787036400"; 
   d="scan'208";a="2643978"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 19:57:53 -0800
X-CSE-ConnectionGUID: hvyrBTqBRtS4uFoSyirNbg==
X-CSE-MsgGUID: BhqbSS5cRsGFmdrLMNnvjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,196,1787036400"; 
   d="scan'208";a="6741087"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.125.110.56])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 19:57:52 -0800
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
Subject: [PATCH v3 2/3] tools/testing/cxl: Skip the auto region when no volatile window is active
Date: Wed,  4 Nov 2026 19:57:47 -0800
Message-ID: <aabf868d7cc2bb2793acaaac3c358de5c87a38e2.1793850480.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1793850480.git.alison.schofield@intel.com>
References: <cover.1793850480.git.alison.schofield@intel.com>
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

The mock auto region always uses CFMWS0. With XOR interleave arithmetic
that window is inactive, so its HPA base is never assigned and the
endpoint decoders are programmed at HPA 0.

No root decoder matches that range, leaving DPA allocated to endpoint
decoders that are not part of a region.

Set up the auto region only when a volatile window is active.

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 tools/testing/cxl/test/cxl.c | 36 ++++++++++++++++++++++++++++--------
 1 file changed, 28 insertions(+), 8 deletions(-)

diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index 6819143640a9..d0793961b0ee 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -424,6 +424,18 @@ struct acpi_cedt_cxims *mock_cxims[1] = {
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
@@ -1124,7 +1136,8 @@ enum cxld_init_type {
 static enum cxld_init_type get_decoder_init_type(struct cxl_decoder *cxld,
 						 struct platform_device *pdev,
 						 bool hb0,
-						 struct cxl_test_decoder **td)
+						 struct cxl_test_decoder **td,
+						 struct acpi_cedt_cfmws **window)
 {
 	struct cxl_test_decoder *found_td = cxld_registry_find(cxld);
 
@@ -1134,6 +1147,7 @@ static enum cxld_init_type get_decoder_init_type(struct cxl_decoder *cxld,
 	}
 
 	*td = NULL;
+	*window = NULL;
 
 	/*
 	 * The first decoder on the first 2 devices on the first switch
@@ -1147,6 +1161,11 @@ static enum cxld_init_type get_decoder_init_type(struct cxl_decoder *cxld,
 	    pdev->id > 4 || cxld->id > (mock_zero_size_decoders ? 2 : 0))
 		return MOCK_DECODER_INIT_DEFAULT;
 
+	/* XOR windows are all pmem, no window to host the RAM region */
+	*window = mock_auto_region_cfmws();
+	if (!*window)
+		return MOCK_DECODER_INIT_DEFAULT;
+
 	return type2_test ? MOCK_DECODER_INIT_TYPE2_AUTO :
 			    MOCK_DECODER_INIT_TYPE3_AUTO;
 }
@@ -1168,9 +1187,9 @@ static bool mock_decoder_handle_saved(struct cxl_decoder *cxld, struct cxl_test_
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
@@ -1243,9 +1262,9 @@ static void mock_init_hdm_type2_cxled(struct cxl_endpoint_decoder *cxled,
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
@@ -1396,6 +1415,7 @@ static bool mock_init_hdm_decoder(struct cxl_decoder *cxld)
 {
 	struct cxl_endpoint_decoder *cxled = NULL;
 	struct platform_device *pdev = NULL;
+	struct acpi_cedt_cfmws *window;
 	struct cxl_test_decoder *td;
 	struct cxl_memdev *cxlmd;
 	struct cxl_port *port;
@@ -1424,7 +1444,7 @@ static bool mock_init_hdm_decoder(struct cxl_decoder *cxld)
 		port = to_cxl_port(cxld->dev.parent);
 	}
 
-	switch (get_decoder_init_type(cxld, pdev, hb0, &td)) {
+	switch (get_decoder_init_type(cxld, pdev, hb0, &td, &window)) {
 	case MOCK_DECODER_INIT_SAVED:
 		if (WARN_ON(!td))
 			return false;
@@ -1437,10 +1457,10 @@ static bool mock_init_hdm_decoder(struct cxl_decoder *cxld)
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

