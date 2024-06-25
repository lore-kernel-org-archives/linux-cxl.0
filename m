Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABAC5101D5
	for <linux-cxl@vger.kernel.org>; Tue, 25 Jun 2024 00:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719276964; cv=none; b=cDWgU3zHNTRuqtl0nAYRnzGZX91kg3fcFTw2KPnTs299Vzw221hBt3wUap3LHCQYzTUR5uUGce23l2MRyOR8EkZqh1JzWbjjthQFvH5wYc2BPem9dWXUOXzP9ZtP8vf46KTt8jhRIcDIDtLgD9yA9arK+dK/RDXG7kLBDh03weA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719276964; c=relaxed/simple;
	bh=I+KPXGBHQlJw0gwQp2mFlbULC0fRGcUGC2J9SkvBP30=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M1RCJqxa/8WAOUoX4F1mWpNscwZv4tAlRZFg1T6dVAKuilHUehfksZyxLmi9dljsiM23b5OFSELllJmjtvStfE+ANGVh9O/oBR4HZJ0R4j3z46oT+HzWgfOh9Oz05Hznk8Pv1/rs5RCjKpt8jdrIAxsXmwHrZxFCw9CY0jIArRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cLMnZ4EF; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cLMnZ4EF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719276963; x=1750812963;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=I+KPXGBHQlJw0gwQp2mFlbULC0fRGcUGC2J9SkvBP30=;
  b=cLMnZ4EFG12RIM2wgbxiDmsZiUq7fUFVWnHEyDQ+2i/s16JRxpgcmIR2
   FlqfRtqsHsPJXs/NmttgCw5PjjQOdRtCXZJr2+DS9+ua3Pu7/GmQlTSls
   cL5WN7oghzDv35Tuduk+M+OjxTLjXxLjhl4I3Q8MiIOclTGVOjRYTarRb
   g3GS/+BXkwOsQSDxFb88Uh/7A0JtjvyVpUANlp8IRtPvq8y+ZKLTe04mC
   Qt+vDpyoolxHycJ7n2ecPZLaGucleLLxfGi0CWWBwn8bddb5sB4he6At0
   ckvmduprFVR6TlhPso/smYigOBFE8fjxw0G5o/AzRbnZKeXEeRTOExHTB
   g==;
X-CSE-ConnectionGUID: y8GTze5QRxeo9jGONE5P2g==
X-CSE-MsgGUID: RvHpdS3ESASAFJ7VQZsB0g==
X-IronPort-AV: E=McAfee;i="6700,10204,11113"; a="16028476"
X-IronPort-AV: E=Sophos;i="6.08,263,1712646000"; 
   d="scan'208";a="16028476"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 17:56:02 -0700
X-CSE-ConnectionGUID: CobyMAdnSRiXgMhBIcJ+/w==
X-CSE-MsgGUID: 807MzfM8T3GCT+ODcZHtwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,263,1712646000"; 
   d="scan'208";a="66697330"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.209.55.37])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 17:56:01 -0700
From: alison.schofield@intel.com
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH v3 3/4] cxl/region: Verify target positions using the ordered target list
Date: Mon, 24 Jun 2024 17:55:54 -0700
Message-Id: <21ab14f3eb9c4080e45553cd98684d7cf726b513.1719275633.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1719275633.git.alison.schofield@intel.com>
References: <cover.1719275633.git.alison.schofield@intel.com>
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
---
 drivers/cxl/core/region.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index bdb06dbe98a8..77aa74250c87 100644
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

