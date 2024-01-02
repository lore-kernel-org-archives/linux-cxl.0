Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F76E154A9
	for <linux-cxl@vger.kernel.org>; Tue,  2 Jan 2024 17:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="acBqwVjP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704217509; x=1735753509;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ZeP3rHvyDmGVgfm1cIxQWaApk2u27+EVcJxEOqeFu1A=;
  b=acBqwVjP2LIL4b/RRex10iZCwN+i3IBXMlJDIjZfBdIomi97kPfuXZTw
   6CDZHTubD5VaFQwCpQgtfuosgTR5O3nqEJdsFPo9ejWT1cKHb+FmdYrk9
   Oqf59ytj1Ebko2MRJ8EK62xXQ1118M72Wi74gDxZjKwyA720ay+tVRK6g
   xi5GWdbWtIcOMAnUhL9aDBeWsQJvS2eOWdFWxpZNyv9xFU86MfaZzQoYl
   jjWBZKQw5RfGx96LREs+M39ZbpMykOWWZagc991/HH2RmY/ZZoSAHml7z
   C5iFrE99Lz8zl8PW2OHnOrSrMYUn1YBg6FGtt8+d1v6mmLqpOgkFNOlEs
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="461210653"
X-IronPort-AV: E=Sophos;i="6.04,325,1695711600"; 
   d="scan'208";a="461210653"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2024 09:45:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="808564551"
X-IronPort-AV: E=Sophos;i="6.04,325,1695711600"; 
   d="scan'208";a="808564551"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.212.157.88])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2024 09:45:08 -0800
From: alison.schofield@intel.com
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org,
	Fan Ni <fan.ni@samsung.com>
Subject: [PATCH v4] cxl/region: Add dev_dbg() detail on failure to allocate HPA space
Date: Tue,  2 Jan 2024 09:45:05 -0800
Message-Id: <20240102174505.1489656-1-alison.schofield@intel.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alison Schofield <alison.schofield@intel.com>

When the region driver fails while allocating HPA space for a
new region it can be because the parent resource, the CXL Window,
has no more available space.

In that case, the debug user sees this message:
cxl_core:alloc_hpa:555: cxl region2: failed to allocate HPA: -34

Expand the message like this:
cxl_core:alloc_hpa:555: cxl region8: HPA allocation error (-34) for size:0x20000000 in CXL Window 0 [mem 0xf010000000-0xf04fffffff flags 0x200]

Now the debug user can examine /proc/iomem and consider actions
like removing other allocations in that space or reducing the
size of their region request.

Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Vishal Verma <vishal.l.verma@intel.com>
Reviewed-by: Fan Ni <fan.ni@samsung.com>
Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
---

Dan - Let me know if you need a separate patch as this is already
in cxl/next

Change in v4:
- Use %pa format specifier for printing resource_size_t  (0-day)

Link to v3:
https://lore.kernel.org/linux-cxl/20231223004740.1401858-1-alison.schofield@intel.com/


 drivers/cxl/core/region.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 56e575c79bb4..9dc26b17c8ba 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -552,8 +552,9 @@ static int alloc_hpa(struct cxl_region *cxlr, resource_size_t size)
 	res = alloc_free_mem_region(cxlrd->res, size, SZ_256M,
 				    dev_name(&cxlr->dev));
 	if (IS_ERR(res)) {
-		dev_dbg(&cxlr->dev, "failed to allocate HPA: %ld\n",
-			PTR_ERR(res));
+		dev_dbg(&cxlr->dev,
+			"HPA allocation error (%ld) for size:%pa in %s %pr\n",
+			PTR_ERR(res), &size, cxlrd->res->name, cxlrd->res);
 		return PTR_ERR(res);
 	}
 

base-commit: b85ea95d086471afb4ad062012a4d73cd328fa86
-- 
2.37.3

