Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB171DE89D;
	Fri, 22 Nov 2024 15:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732290776; cv=none; b=XoJ+szKcGoP7WZexifczpWvoENqgrMGRhXbbbJCBb+u8m9yzF9BBhXGra+FbjmI2ykYTqQcOoLD9LlsTe4GpRzlgTst4fo9QjNVb6ckdVCcnV3/9pXNBv5Msn7d4fPdqPM4rH/HxOLRjPwI0D5ZQS2sE2zDlm9E55lxKAPanO50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732290776; c=relaxed/simple;
	bh=uB8mC0rCa+UubCEmLbOAjXaMwTlwNwi3HtKc/E3Iljs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pJTNEf1yEthPl13PXiLXSzgYuP2GHYhhmwVpTjYCEw5V8TuLzb9ZmYbtpBDUD6XwovbW9v6eE+h9CidngF1uEuASQ+GjgrDb5iVDKSBI1TqY9fKme/Zl6EXFzcP3qb9aip7BM3xkRp8x15/vYi0I/Vl9ruEbXaSX6dXYJJj9QDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O5Wtwwvl; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O5Wtwwvl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732290775; x=1763826775;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=uB8mC0rCa+UubCEmLbOAjXaMwTlwNwi3HtKc/E3Iljs=;
  b=O5Wtwwvlx3ivu8lVbHZrtq690PutjKR27uAz1E4uhEmBoLpAuKu1ap7u
   eJVhDQ/JdY8rbAjd3b086e3lJdPeJnX4H/ndHcOI+QJBgx3kH6CNWVIgo
   M5IKBBnWY+vSsrC0oWopvhBd0vsX5BcBIyoisMlSBd1nbZzUugNkz7w7f
   SAZBvNlWZ/mBZA4MomTzh0xMnTyOGrpl2GesDnttfzbyL9cgFULjbv66o
   PPn7ea9Iq6NtaPjzX9wXcQMJ6i2BknXraUPTKgwcDd9zgwJXbIL2oE7XV
   UzG+A4L1wgIVNDVYb017oE47qrU7Vr32ScJGtCGAAa4kRpidj8Tr429B3
   g==;
X-CSE-ConnectionGUID: kokJA5Z2R0aTSlOv5UPgTg==
X-CSE-MsgGUID: s/xdTcmlSGOPsIMHwKwZ7g==
X-IronPort-AV: E=McAfee;i="6700,10204,11264"; a="32386572"
X-IronPort-AV: E=Sophos;i="6.12,176,1728975600"; 
   d="scan'208";a="32386572"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2024 07:52:54 -0800
X-CSE-ConnectionGUID: h6TCyaBRQaa5vh0tseeMdg==
X-CSE-MsgGUID: 49tCCmc1RZGhXaGlgaTFow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,176,1728975600"; 
   d="scan'208";a="91408755"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.intel.com) ([10.245.244.64])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2024 07:52:50 -0800
From: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Huang Ying <ying.huang@intel.com>,
	Yao Xingtao <yaoxt.fnst@fujitsu.com>,
	Li Ming <ming4.li@intel.com>,
	linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org
Subject: [PATCH 1/3] cxl/core: Change match_*_by_range() calling convention
Date: Fri, 22 Nov 2024 16:51:52 +0100
Message-ID: <20241122155226.2068287-2-fabio.m.de.francesco@linux.intel.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241122155226.2068287-1-fabio.m.de.francesco@linux.intel.com>
References: <20241122155226.2068287-1-fabio.m.de.francesco@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for a patch that supports matching between Decoders that may
have larger HPA ranges than their corresponding Root Decoders or Regions,
change the calling convention of three match_*_by_range() to take CXL
Endpoint Decoders as their second arguments which later will be reused by
two new functions (arch_match_spa() and arch_match_region()).

Cc: Alison Schofield <alison.schofield@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
---
 drivers/cxl/core/region.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index dff618c708dc..ac2c486c16e9 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1724,23 +1724,27 @@ static struct cxl_port *next_port(struct cxl_port *port)
 
 static int match_switch_decoder_by_range(struct device *dev, void *data)
 {
+	struct cxl_endpoint_decoder *cxled = data;
 	struct cxl_switch_decoder *cxlsd;
-	struct range *r1, *r2 = data;
+	struct range *r1, *r2;
 
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
@@ -1750,7 +1754,7 @@ static int find_pos_and_ways(struct cxl_port *port, struct range *range,
 	if (!parent)
 		return rc;
 
-	dev = device_find_child(&parent->dev, range,
+	dev = device_find_child(&parent->dev, cxled,
 				match_switch_decoder_by_range);
 	if (!dev) {
 		dev_err(port->uport_dev,
@@ -1830,7 +1834,7 @@ static int cxl_calc_interleave_pos(struct cxl_endpoint_decoder *cxled)
 		if (is_cxl_root(iter))
 			break;
 
-		rc = find_pos_and_ways(iter, range, &parent_pos, &parent_ways);
+		rc = find_pos_and_ways(iter, cxled, &parent_pos, &parent_ways);
 		if (rc)
 			return rc;
 
@@ -3184,22 +3188,26 @@ static int devm_cxl_add_dax_region(struct cxl_region *cxlr)
 
 static int match_root_decoder_by_range(struct device *dev, void *data)
 {
-	struct range *r1, *r2 = data;
+	struct cxl_endpoint_decoder *cxled = data;
 	struct cxl_root_decoder *cxlrd;
+	struct range *r1, *r2;
 
 	if (!is_root_decoder(dev))
 		return 0;
 
 	cxlrd = to_cxl_root_decoder(dev);
 	r1 = &cxlrd->cxlsd.cxld.hpa_range;
+	r2 = &cxled->cxld.hpa_range;
+
 	return range_contains(r1, r2);
 }
 
 static int match_region_by_range(struct device *dev, void *data)
 {
+	struct cxl_endpoint_decoder *cxled = data;
+	struct range *r = &cxled->cxld.hpa_range;
 	struct cxl_region_params *p;
 	struct cxl_region *cxlr;
-	struct range *r = data;
 	int rc = 0;
 
 	if (!is_cxl_region(dev))
@@ -3303,7 +3311,6 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 int cxl_add_to_region(struct cxl_port *root, struct cxl_endpoint_decoder *cxled)
 {
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
-	struct range *hpa = &cxled->cxld.hpa_range;
 	struct cxl_decoder *cxld = &cxled->cxld;
 	struct device *cxlrd_dev, *region_dev;
 	struct cxl_root_decoder *cxlrd;
@@ -3312,7 +3319,7 @@ int cxl_add_to_region(struct cxl_port *root, struct cxl_endpoint_decoder *cxled)
 	bool attach = false;
 	int rc;
 
-	cxlrd_dev = device_find_child(&root->dev, &cxld->hpa_range,
+	cxlrd_dev = device_find_child(&root->dev, cxled,
 				      match_root_decoder_by_range);
 	if (!cxlrd_dev) {
 		dev_err(cxlmd->dev.parent,
@@ -3329,7 +3336,7 @@ int cxl_add_to_region(struct cxl_port *root, struct cxl_endpoint_decoder *cxled)
 	 * one does the construction and the others add to that.
 	 */
 	mutex_lock(&cxlrd->range_lock);
-	region_dev = device_find_child(&cxlrd->cxlsd.cxld.dev, hpa,
+	region_dev = device_find_child(&cxlrd->cxlsd.cxld.dev, cxled,
 				       match_region_by_range);
 	if (!region_dev) {
 		cxlr = construct_region(cxlrd, cxled);
-- 
2.46.2

