Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31CC417C60
	for <linux-cxl@vger.kernel.org>; Wed,  3 Jul 2024 05:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719984601; cv=none; b=C1nVMfwWnvABiOGRqsWYQgCgZxkRDNc4R90/1LCci7iMNJ5/b7npTONufxYNOZ1jNJHi4dWpWt8+SVNW3YIODXJ3ZLk8ByA64sG9JXv2MGneJD+0wel72EQpNDUPlIpxjl+4NsN60XCLVs5KbaAiTBqWuyzHv/t6sWXl9yAJ7bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719984601; c=relaxed/simple;
	bh=MKl9qf4BGsVU/XAZphSL3c3PNYJkjA3RqiB/Rt2xuAM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ukluLseqNXYvFEYHxnBwC+uzrUbLnmswav8AbWUjeaXmhH169gmlJL8utOzPPTJ1QK0XFdlvN/ze0gXhSijP0aQ219LE0JXiFYNGOOcSEIAkqlopfJW3R+h0m0a+hS+irqOsGZnha6tll7hOw+D2AOwMxeL+sYHQ1I3ZK31I3ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yn9bQ2Sm; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yn9bQ2Sm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719984599; x=1751520599;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MKl9qf4BGsVU/XAZphSL3c3PNYJkjA3RqiB/Rt2xuAM=;
  b=Yn9bQ2SmiF2wgg8aBFr20wd/Fzhdxawf7ypTbq9XIk7+/9GleGyT4K96
   Ih5t2MuQSNke4oavoUSyBbHeuOnS4yHltraGQEltH3RCbLmdJS71ALwkO
   nWJrICEHDTIRi1iqb/QK9ZxRMF9awrEDMVI9yVF4p0EzGidz7tUT+7Mc0
   SHMPe4scVdJ3xYJKesX3ogpqnjzcuay869qxmLnQV3aYvNnxkRMt2Q3vT
   DfOUhSZ+v8mwQGJdBHrhDHglf7ydr6GO991tplqBYzkBPt91FXtSeL1/M
   vqqwCeg/5oxt6mY3Vhrqods+1niiNCj4+jrPCZdKI7Y4beJw5VNdGdvr4
   Q==;
X-CSE-ConnectionGUID: BTCxKW3qS2iH2A1u2DAbKw==
X-CSE-MsgGUID: QBjl+W2QRnSvShV+g/0U8A==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="28326352"
X-IronPort-AV: E=Sophos;i="6.09,181,1716274800"; 
   d="scan'208";a="28326352"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2024 22:29:58 -0700
X-CSE-ConnectionGUID: ANBtWj4rRte3U02Q50C+xA==
X-CSE-MsgGUID: OhqvjSzMQhCSMPmkRKIR1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,181,1716274800"; 
   d="scan'208";a="46004085"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.209.8.146])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2024 22:29:58 -0700
From: alison.schofield@intel.com
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH v4 3/4] cxl/region: Verify target positions using the ordered target list
Date: Tue,  2 Jul 2024 22:29:51 -0700
Message-Id: <35d08d3aba08fee0f9b86ab1cef0c25116ca8a55.1719980933.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1719980933.git.alison.schofield@intel.com>
References: <cover.1719980933.git.alison.schofield@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alison Schofield <alison.schofield@intel.com>

When a root decoder is configured the interleave target list is read
from the BIOS populated CFMWS structure. Per the CXL spec 3.1 Table
9-22 the target list is in interleave order. The CXL driver populates
its decoder target list in the same order and stores it in 'struct
cxl_switch_decoder' field "@target: active ordered target list in
current decoder configuration"

Given the promise of an ordered list, the driver can stop duplicating
the work of BIOS and simply check target positions against the ordered
list during region configuration.

The simplified check against the ordered list is presented here.
A follow-on patch will remove the unused code.

For Modulo arithmetic this is not a fix, only a simplification.
For XOR arithmetic this is a fix for HB IW of 3,6,12.

Fixes: f9db85bfec0d ("cxl/acpi: Support CXL XOR Interleave Math (CXIMS)")
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/cxl/core/region.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 23abd0f7b856..2772828ca6ca 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1559,10 +1559,13 @@ static int cxl_region_attach_position(struct cxl_region *cxlr,
 				      const struct cxl_dport *dport, int pos)
 {
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
+	struct cxl_switch_decoder *cxlsd = &cxlrd->cxlsd;
+	struct cxl_decoder *cxld = &cxlsd->cxld;
+	int iw = cxld->interleave_ways;
 	struct cxl_port *iter;
 	int rc;
 
-	if (cxlrd->calc_hb(cxlrd, pos) != dport) {
+	if (dport != cxlrd->cxlsd.target[pos % iw]) {
 		dev_dbg(&cxlr->dev, "%s:%s invalid target position for %s\n",
 			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
 			dev_name(&cxlrd->cxlsd.cxld.dev));
-- 
2.37.3

