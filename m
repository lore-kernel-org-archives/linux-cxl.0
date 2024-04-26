Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCBED2F5
	for <linux-cxl@vger.kernel.org>; Fri, 26 Apr 2024 19:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714161074; cv=none; b=Uuy4a0AAGHtanvKPb6IYWdMru5AbnHIioRWqjScbKlDdd4dr8KqmPp3Uq3JBpCS5JAwyInoUX6bBeUBhOKUyjU30Lj3llcyg8H/ZUE9+5rbLJjl50bvrzyOxws/6H+YxPIjneRz0yckCDqShPe6M4PfJwN5w0T+Ae59t/tqO8OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714161074; c=relaxed/simple;
	bh=bPPqohybR9osMhS8+ExmDkXQ9CYA79HqeVj31gqBBfE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KcNVs1xaNZRGoREwO6bRmpKrHqPLJboXnddQyl+t7tyxPK5mtyA4l3NaeC8KFBKf2wAQw+HD/jI8HGkRbb/uODmidSLy8bR/GyHV3zX+AaydmPvDA0V6HeiuxeMX7A6GQOei21QakznrwIc053LoBOS+b9E1GLjNWyXyRohXAdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DGSut28W; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DGSut28W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714161073; x=1745697073;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bPPqohybR9osMhS8+ExmDkXQ9CYA79HqeVj31gqBBfE=;
  b=DGSut28WYeIpl+ew0CqWmrMc4GukOTZdx21ben4uvMU8G2Iz3qdNk8CN
   AqgbtMGWiD8EdvrK2SUh+M6ioPDbL+Ag3jB8BrMGZ6oUlGR3Ngg2Hy3hT
   p1hwg+J2poUmKl1Y2gH0QZRnklxNJ+eI5zHYHU1DkxoVR6fSpsvSGo+HF
   DwR7fHY9QZwsfJTZd0rW+5CT0Q33NyN6tnGUNDAyQ1f0DnWzoYBNLNov/
   HFj3fq1VH+4KfUeHTYt+l3nF8IWbmH/Ohv3NyZUb9aofX3ERSQPwQdHCT
   EAVcFP7f/ltZlVUnx1aaAxIqsXURcdZxii+h50HtNHhh2gZ3AcG7xQyaw
   Q==;
X-CSE-ConnectionGUID: WAkNdeXdTVaZHugdpYU3Tg==
X-CSE-MsgGUID: 0o29ck+HRp+pDh974FLbAg==
X-IronPort-AV: E=McAfee;i="6600,9927,11056"; a="10067043"
X-IronPort-AV: E=Sophos;i="6.07,233,1708416000"; 
   d="scan'208";a="10067043"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 12:51:12 -0700
X-CSE-ConnectionGUID: cJebSmnyRgKZSWHdPi3yEw==
X-CSE-MsgGUID: B/bldb9mT2mfeWxgHmL6vw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,233,1708416000"; 
   d="scan'208";a="56432095"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.212.224.120])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 12:51:11 -0700
From: alison.schofield@intel.com
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH 2/3] cxl/region: Verify target positions using the ordered target list
Date: Fri, 26 Apr 2024 12:51:06 -0700
Message-Id: <a5121a8d37dd62581015452a77113f88df2ede25.1714159486.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1714159486.git.alison.schofield@intel.com>
References: <cover.1714159486.git.alison.schofield@intel.com>
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
For XOR arithmetic this is a fix for HB IW of 6,12.

Fixes: f9db85bfec0d ("cxl/acpi: Support CXL XOR Interleave Math (CXIMS)")
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/core/region.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 5c186e0a39b9..3c20f8364b26 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1559,10 +1559,17 @@ static int cxl_region_attach_position(struct cxl_region *cxlr,
 				      const struct cxl_dport *dport, int pos)
 {
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
+	struct cxl_switch_decoder *cxlsd = &cxlrd->cxlsd;
+	struct cxl_decoder *cxld = &cxlsd->cxld;
+	int iw = cxld->interleave_ways;
 	struct cxl_port *iter;
 	int rc;
 
-	if (cxlrd->calc_hb(cxlrd, pos) != dport) {
+	if (dev_WARN_ONCE(&cxld->dev, iw != cxlsd->nr_targets,
+			  "misconfigured root decoder\n"))
+		return -ENXIO;
+
+	if (dport != cxlrd->cxlsd.target[pos % iw]) {
 		dev_dbg(&cxlr->dev, "%s:%s invalid target position for %s\n",
 			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
 			dev_name(&cxlrd->cxlsd.cxld.dev));
-- 
2.37.3

