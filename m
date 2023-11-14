Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2938F6D
	for <linux-cxl@vger.kernel.org>; Tue, 14 Nov 2023 04:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HAAR+lRn"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B031894
	for <linux-cxl@vger.kernel.org>; Mon, 13 Nov 2023 20:01:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699934511; x=1731470511;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/9Jt9h2Zhn8mgg/hLROhv9K3Pr7hErnxHjN3DHTe44I=;
  b=HAAR+lRn3Iyzn+5jDLTgE27o1hHXWutrjaviwM0uCdbl0kwaHB3pnezs
   d5NQAB2NhSDiXJyGSmPdztcsO4B3LPEmvOhlpmeWL4jRks3ibbDJ62bCS
   tiZ+YyiYWgWutS/lW5jXxImbh90vI6u5Dye/1FY+4MEzl+KD22Ae7zBFw
   SO0LZeWdN+Qg2zNocLUFisgw+8kSckU+jY5jnDMCvzGyC9aRdm1U92DWS
   82boc2T8XHuAqGZRX1pGgQXkStckS8pmOqMClWtwkeWKzbQwEV0Oidw24
   QUikQtp9ro8FRn2OTd5HEvRYp4euStGIxiQI0WyAzaTamukgdSiRvi5hc
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="476786188"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="476786188"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 20:01:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="834895137"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="834895137"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.212.206.59])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 20:01:48 -0800
From: alison.schofield@intel.com
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH] cxl/region: Add dev_dbg() detail on failure to allocate HPA space
Date: Mon, 13 Nov 2023 20:01:47 -0800
Message-Id: <20231114040147.1124696-1-alison.schofield@intel.com>
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
cxl_core:alloc_hpa:555: cxl region8: failed to allocate HPA:-34 size:0x20000000 in CXL Window 0 [mem 0xf010000000-0xf04fffffff flags 0x200]

Now the debug user can examine /proc/iomem and consider actions
like removing other allocations in that space or reducing the
size of their region request.

Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/core/region.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 56e575c79bb4..0e6a378f1913 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -552,8 +552,9 @@ static int alloc_hpa(struct cxl_region *cxlr, resource_size_t size)
 	res = alloc_free_mem_region(cxlrd->res, size, SZ_256M,
 				    dev_name(&cxlr->dev));
 	if (IS_ERR(res)) {
-		dev_dbg(&cxlr->dev, "failed to allocate HPA: %ld\n",
-			PTR_ERR(res));
+		dev_dbg(&cxlr->dev,
+			"failed to allocate HPA:%ld size:%#llx in %s %pr\n",
+			PTR_ERR(res), size, cxlrd->res->name, cxlrd->res);
 		return PTR_ERR(res);
 	}
 

base-commit: b85ea95d086471afb4ad062012a4d73cd328fa86
-- 
2.37.3

