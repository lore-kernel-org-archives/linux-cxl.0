Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78EBB1B47AF;
	Tue, 18 Jun 2024 08:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718700427; cv=none; b=a+fqOThj04vfxoQcZZF9Lze1CIaV0KkeCbloVPqgXDDTe1KpS5B2MBjvtJqdoix1Gbbsse0TL8DZeY896Xrn6WGNUJ4SPx2SoVJ3jCrqP1NYUTJ1Xe8oGsTx1RqaFEbu6YtrcYBXuHjmLS3gHTL3GFk5FLpF4VfLKeNQrL1StUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718700427; c=relaxed/simple;
	bh=yvDV6rkVOu8P+lVXQDeRsjn3mWeP51TtXp+eTIfxlKM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WjugFk7DfGo7MCeRuLwjAhzXYDy1QMQemf8qvYrHWNVIDy0SL5lWWUkEo2AGt+FcEY7Lopkubt0xbMbisrBWgcpXMKlxXQ3t+QXarwVCescD0gp6gh4QY17Nt3aDwLHI08EuyLz77JKuYHjKSoGk8D3yCBp7OteDVR40Yole+k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RMUh02+q; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RMUh02+q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718700426; x=1750236426;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yvDV6rkVOu8P+lVXQDeRsjn3mWeP51TtXp+eTIfxlKM=;
  b=RMUh02+q63erZLKce4NHL94jrBNqt4P0ViaSjM60YRO7Y12HiTn7Sehc
   gXuuKzX65xb3fCiz+wapIM1PlpEs6unzFNgXUOChF3nOHIwRqwZ9ppNZ9
   2RQed4sc7Doq4hxePPIh8ip60wa5V/PuF+m8+O6cG39RUAOwZAh1V7f8E
   LMjrhNxejOykp0egpShJ5Kt4FO0nSdmY1DSaQwTuzJHPSGvVDLCMZVVDy
   YFNRrJoHacTfGNEnxxwotgWpNfS8zl3JP+tcLZzjq+NMCXX8tpLPROssZ
   GF4tj+S8sMH8COhSMyxk6ENUajgG995SOybOni8sDumq7GV19daPL2RSv
   w==;
X-CSE-ConnectionGUID: FgMccW4ORoe+ieCVFAnQZQ==
X-CSE-MsgGUID: lkU/WpRHQbuwWuKAtlmrYg==
X-IronPort-AV: E=McAfee;i="6700,10204,11106"; a="15431626"
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="15431626"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 01:47:05 -0700
X-CSE-ConnectionGUID: uwH9aXqWR7eUp36iAtGaSQ==
X-CSE-MsgGUID: lBOFY5XPQgOGQN4wMCAlqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="78933659"
Received: from shilinmu-mobl.ccr.corp.intel.com (HELO yhuang6-mobl2.ccr.corp.intel.com) ([10.255.28.204])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 01:47:02 -0700
From: Huang Ying <ying.huang@intel.com>
To: Dan Williams <dan.j.williams@intel.com>,
	Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Huang Ying <ying.huang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Bharata B Rao <bharata@amd.com>,
	Alistair Popple <apopple@nvidia.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH v3 3/3] cxl/region: Simplify cxl_region_nid()
Date: Tue, 18 Jun 2024 16:46:39 +0800
Message-Id: <20240618084639.1419629-4-ying.huang@intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240618084639.1419629-1-ying.huang@intel.com>
References: <20240618084639.1419629-1-ying.huang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The node ID of the region can be gotten via resource start address
directly.  This simplifies the implementation of cxl_region_nid().

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Suggested-by: Alison Schofield <alison.schofield@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Bharata B Rao <bharata@amd.com>
Cc: Alistair Popple <apopple@nvidia.com>
Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>
---
 drivers/cxl/core/region.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index dc15ceba7ab7..605efe3562c6 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2309,15 +2309,13 @@ static bool cxl_region_update_coordinates(struct cxl_region *cxlr, int nid)
 static int cxl_region_nid(struct cxl_region *cxlr)
 {
 	struct cxl_region_params *p = &cxlr->params;
-	struct cxl_endpoint_decoder *cxled;
-	struct cxl_decoder *cxld;
+	struct resource *res;
 
 	guard(rwsem_read)(&cxl_region_rwsem);
-	cxled = p->targets[0];
-	if (!cxled)
+        res = p->res;
+	if (!res)
 		return NUMA_NO_NODE;
-	cxld = &cxled->cxld;
-	return phys_to_target_node(cxld->hpa_range.start);
+	return phys_to_target_node(res->start);
 }
 
 static int cxl_region_perf_attrs_callback(struct notifier_block *nb,
-- 
2.39.2

