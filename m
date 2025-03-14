Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7998D1FE44A;
	Fri, 14 Mar 2025 11:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741952246; cv=none; b=hT/G14MQw/p9FFGj1D6WcjUJCC7dov/G3QJwS3Z9b3M8gj+/1ISy6qD6CIs5qNtNwVamuWi0rZ9j3cz5nq6w0VUv0k34CX8XPLQS/KcsR9Ko3a8HiGA10UB+Zfceb8EnQOKRBwbuOxRJfoL/FsPu5Q3kn1gUp3LalEopvU/OpJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741952246; c=relaxed/simple;
	bh=T0MfISOxzp9AQ3AZkONnyle+eJsV7ePPX5I+qixDcyk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tVlS35CzBFXk9dY1gIo8vcG9rRUmUD3/LeOzYAEFo2NfywZsiHXLsW7oSRFY7w1AJFue48YpqFlrMM6y4vXXOOiSHhArGslNDCoHB2RXU9/na42kXDDTLsfyNpNniqOOu5gtwtY4YYtItFRJ45KNl4ca3WeKXS2y8UsCjJHdvLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e/Ssx6ce; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e/Ssx6ce"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741952245; x=1773488245;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=T0MfISOxzp9AQ3AZkONnyle+eJsV7ePPX5I+qixDcyk=;
  b=e/Ssx6cep9dyzuJMp668ZhI95d1TTrycE5u+dO/EhnLjxJNAwDXeJF7+
   jlO0DK5R3OP+8uVR57Dt74zWu4AJZeBmYFEf+ZDT31KltVjhYusxOMjPD
   VUy3I0khYcmE/Frg+UG1uzAMGGMvc1s+6kA51BgBHcbeie0oLcOSxucPr
   AP/Fiz9xl0RMid6H0zxWACbGx//ysHgYnq1UFw7W91cbolQbMxXUaWg4Z
   sjXCYeaBxXhW1CYUBF94k9Y7zra2pMHi72yG9QIFGrBLgwiAYSVGTmISK
   R6GbAfrKI2jfPcAwpQppP9Y0U2OR+w6ER7BPHdLM4w0RGIckMyIiKQQCk
   g==;
X-CSE-ConnectionGUID: +DlsohAMQzyCDgFGxLl6vw==
X-CSE-MsgGUID: 1nzUZnpdTLmpW5A1e8lMiQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="60497537"
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="60497537"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2025 04:37:25 -0700
X-CSE-ConnectionGUID: UdPYbT6VQZ6zI3I+Kvsk6w==
X-CSE-MsgGUID: rtXObhvjQYWp7M946mVtPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="121751397"
Received: from jkrzyszt-mobl2.ger.corp.intel.com (HELO fdefranc-mobl3.intel.com) ([10.245.246.211])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2025 04:37:21 -0700
From: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: Robert Richter <rrichter@amd.com>,
	ming.li@zohomail.com,
	linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
Subject: [PATCH 1/4 v3] cxl/core: Change match_*_by_range() calling convention
Date: Fri, 14 Mar 2025 12:36:30 +0100
Message-ID: <20250314113708.759808-2-fabio.m.de.francesco@linux.intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250314113708.759808-1-fabio.m.de.francesco@linux.intel.com>
References: <20250314113708.759808-1-fabio.m.de.francesco@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace struct range parameter with struct cxl_endpoint_decoder of
which range is a member in the match_*_by_range() functions.

This is in preparation for expanding these helpers to perform arch
specific region matching that requires a cxl_endpoint_decoder.

No functional changes.

Cc: Alison Schofield <alison.schofield@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
---
 drivers/cxl/core/region.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index b3260d433ec7..97122d645cc1 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1758,24 +1758,27 @@ static struct cxl_port *next_port(struct cxl_port *port)
 static int match_switch_decoder_by_range(struct device *dev,
 					 const void *data)
 {
+	const struct cxl_endpoint_decoder *cxled = data;
 	struct cxl_switch_decoder *cxlsd;
-	const struct range *r1, *r2 = data;
-
+	const struct range *r1, *r2;
 
 	if (!is_switch_decoder(dev))
 		return 0;
 
 	cxlsd = to_cxl_switch_decoder(dev);
 	r1 = &cxlsd->cxld.hpa_range;
+	r2 = &cxled->cxld.hpa_range;
 
 	if (is_root_decoder(dev))
 		return range_contains(r1, r2);
 	return (r1->start == r2->start && r1->end == r2->end);
 }
 
-static int find_pos_and_ways(struct cxl_port *port, struct range *range,
+static int find_pos_and_ways(struct cxl_port *port,
+			     struct cxl_endpoint_decoder *cxled,
 			     int *pos, int *ways)
 {
+	struct range *range = &cxled->cxld.hpa_range;
 	struct cxl_switch_decoder *cxlsd;
 	struct cxl_port *parent;
 	struct device *dev;
@@ -1785,7 +1788,7 @@ static int find_pos_and_ways(struct cxl_port *port, struct range *range,
 	if (!parent)
 		return rc;
 
-	dev = device_find_child(&parent->dev, range,
+	dev = device_find_child(&parent->dev, cxled,
 				match_switch_decoder_by_range);
 	if (!dev) {
 		dev_err(port->uport_dev,
@@ -1865,7 +1868,7 @@ static int cxl_calc_interleave_pos(struct cxl_endpoint_decoder *cxled)
 		if (is_cxl_root(iter))
 			break;
 
-		rc = find_pos_and_ways(iter, range, &parent_pos, &parent_ways);
+		rc = find_pos_and_ways(iter, cxled, &parent_pos, &parent_ways);
 		if (rc)
 			return rc;
 
@@ -3199,22 +3202,26 @@ static int devm_cxl_add_dax_region(struct cxl_region *cxlr)
 static int match_root_decoder_by_range(struct device *dev,
 				       const void *data)
 {
-	const struct range *r1, *r2 = data;
+	const struct cxl_endpoint_decoder *cxled = data;
 	struct cxl_root_decoder *cxlrd;
+	const struct range *r1, *r2;
 
 	if (!is_root_decoder(dev))
 		return 0;
 
 	cxlrd = to_cxl_root_decoder(dev);
 	r1 = &cxlrd->cxlsd.cxld.hpa_range;
+	r2 = &cxled->cxld.hpa_range;
+
 	return range_contains(r1, r2);
 }
 
 static int match_region_by_range(struct device *dev, const void *data)
 {
+	const struct cxl_endpoint_decoder *cxled = data;
+	const struct range *r = &cxled->cxld.hpa_range;
 	struct cxl_region_params *p;
 	struct cxl_region *cxlr;
-	const struct range *r = data;
 
 	if (!is_cxl_region(dev))
 		return 0;
@@ -3382,7 +3389,6 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 int cxl_add_to_region(struct cxl_port *root, struct cxl_endpoint_decoder *cxled)
 {
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
-	struct range *hpa = &cxled->cxld.hpa_range;
 	struct cxl_decoder *cxld = &cxled->cxld;
 	struct device *cxlrd_dev, *region_dev;
 	struct cxl_root_decoder *cxlrd;
@@ -3391,7 +3397,7 @@ int cxl_add_to_region(struct cxl_port *root, struct cxl_endpoint_decoder *cxled)
 	bool attach = false;
 	int rc;
 
-	cxlrd_dev = device_find_child(&root->dev, &cxld->hpa_range,
+	cxlrd_dev = device_find_child(&root->dev, cxled,
 				      match_root_decoder_by_range);
 	if (!cxlrd_dev) {
 		dev_err(cxlmd->dev.parent,
@@ -3408,7 +3414,7 @@ int cxl_add_to_region(struct cxl_port *root, struct cxl_endpoint_decoder *cxled)
 	 * one does the construction and the others add to that.
 	 */
 	mutex_lock(&cxlrd->range_lock);
-	region_dev = device_find_child(&cxlrd->cxlsd.cxld.dev, hpa,
+	region_dev = device_find_child(&cxlrd->cxlsd.cxld.dev, cxled,
 				       match_region_by_range);
 	if (!region_dev) {
 		cxlr = construct_region(cxlrd, cxled);
-- 
2.48.1

