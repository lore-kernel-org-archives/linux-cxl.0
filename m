Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3092EBBAF
	for <linux-cxl@vger.kernel.org>; Tue, 29 Sep 2026 00:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790643394; cv=none; b=ZII+86XsTAco6J+v5Sm+4wozK4oIoGSRlaN7t/rhZYCxUQkWtbXC/WcJUdFYVMCblv9+jNzcuXD6KAIQ0rPkwZV2oeim0A8WD6ZGndVuxwjrKXKF2I9/Lqb0niR0sW96uMNrgxN1+o3m/mcgRvkgBhjwinM2MybKTK9/QM235iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790643394; c=relaxed/simple;
	bh=BIiAQ8/6GnYIoNrH8efemRR+oatI6XQ4TjdcxFliL/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q8l5DJYqNkzkFLhhD+xRjwwaCY+YVfZgyfgV1yuB5eSwZ15IRVXQ/fCcyp1RNxQyN1n6wRBHb1C82/YZPkYbwnpF2X5t1QfY+5CYZwUkKFbr17ge/6Hwanjrzx/bgGzVJHIe+I106vOitcB9qRsqvVuiZEa42vnCom/gokEhsFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nZfT4Xx0; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nZfT4Xx0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790643391; x=1822179391;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BIiAQ8/6GnYIoNrH8efemRR+oatI6XQ4TjdcxFliL/g=;
  b=nZfT4Xx0PSonHbu9WUFBLV0k+JaKOsDI8ypv/QCFmY34UV7IhoUQMBB6
   nnBJJJvF4BO/GTdZZ+36yOoddHgoEDkvST1UdHz8GOY9fAIiEPouWSn7+
   LINt/tg07O61XJ3VS6EKyFtX2FHIWbYzNkI2eAeMs/7yUadSdX/3dc7Xd
   2ZPNrmlDKqF66XADcjabslAxU2slRs/7ouoZCUz0DUjYr2lXoIJyb1n1I
   HBcLpDYNQtgI9zRiXrm22vE+344Aumy5yrPHlr1x6OXXt/ZkwH/UDKFU5
   6fa+nZf4vzxgXTWgEejSXVBKl+uu4yYKyCvLujBryAzLk502ArZCVSXq8
   A==;
X-CSE-ConnectionGUID: sSlr+ZLfQWCoJEyh1pjypQ==
X-CSE-MsgGUID: EATW5GcsR4O1xb4l6CzhTA==
X-IronPort-AV: E=McAfee;i="6800,10657,11919"; a="101923934"
X-IronPort-AV: E=Sophos;i="6.27,129,1787036400"; 
   d="scan'208";a="101923934"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 17:56:31 -0700
X-CSE-ConnectionGUID: xvr0YP8YSce6ic8NU19N6A==
X-CSE-MsgGUID: eLbLUsyhQb6a8EOQx0kMPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,129,1787036400"; 
   d="scan'208";a="273012215"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.222.149])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 17:56:30 -0700
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
Subject: [PATCH 2/3] tools/testing/cxl: Skip the auto region when no volatile window is active
Date: Mon, 28 Sep 2026 17:56:17 -0700
Message-ID: <ccc11aec8658ff29e604aded94ac4ce0da7b5fb8.1790641236.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1790641236.git.alison.schofield@intel.com>
References: <cover.1790641236.git.alison.schofield@intel.com>
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
 tools/testing/cxl/test/cxl.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index aa140307e0c3..9d844932f0c6 100644
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
@@ -1114,6 +1126,10 @@ static enum cxld_init_type get_decoder_init_type(struct cxl_decoder *cxld,
 	    pdev->id > 4 || cxld->id > 0)
 		return MOCK_DECODER_INIT_DEFAULT;
 
+	/* XOR windows are all pmem, no window to host the RAM region */
+	if (!mock_auto_region_cfmws())
+		return MOCK_DECODER_INIT_DEFAULT;
+
 	return type2_test ? MOCK_DECODER_INIT_TYPE2_AUTO :
 			    MOCK_DECODER_INIT_TYPE3_AUTO;
 }
@@ -1137,7 +1153,7 @@ static bool mock_decoder_handle_saved(struct cxl_decoder *cxld, struct cxl_test_
 static void mock_init_hdm_type2_cxled(struct cxl_endpoint_decoder *cxled,
 				      struct cxl_port *port)
 {
-	struct acpi_cedt_cfmws *window = mock_cfmws[0];
+	struct acpi_cedt_cfmws *window = mock_auto_region_cfmws();
 	struct cxl_decoder *cxld = &cxled->cxld;
 	struct cxl_switch_decoder *cxlsd;
 	struct cxl_dport *dport;
@@ -1211,7 +1227,7 @@ static void mock_init_hdm_type3_cxled(struct cxl_endpoint_decoder *cxled,
 				      struct platform_device *pdev,
 				      bool hb0)
 {
-	struct acpi_cedt_cfmws *window = mock_cfmws[0];
+	struct acpi_cedt_cfmws *window = mock_auto_region_cfmws();
 	struct cxl_decoder *cxld = &cxled->cxld;
 	struct cxl_switch_decoder *cxlsd;
 	struct cxl_dport *dport;
-- 
2.37.3

