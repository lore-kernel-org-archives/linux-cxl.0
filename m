Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947EF1860
	for <linux-cxl@vger.kernel.org>; Fri,  5 Jan 2024 01:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IScGFLap"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704417646; x=1735953646;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mMuaGbOHyJt6sZ7HNy8/09Hlwh6D+SNqr9gXoaXlj5Q=;
  b=IScGFLapDJCaksWQY4Fv1NlU6Q9HqJYWhS0xJtFgr/rp3y5A0pSJTPyE
   JsdhTnbK2mj+alAgAN3ouR4pRfLLDkX0g1W0oYsGncViGeUIlkSGvUrgr
   /lYftzWSAFC9tfSXjO7ydzXDOvQJzK7RnN3QykBHv8OIzNlAr7/ngkrL+
   pEBLJe/LrqiXJy3R+sj5a0RFyR5aKjhwawfibahzgVqc3uo50shxSrsjQ
   HBycO4YelyDqCsGTm4qj259YosDtgcpsUSKYZONge16lsR8wJZ/WdsYQ/
   CuqlS2VyHvUhX6yWSnUr0izaVUIzJbiAOOEk1cz4yfiWhShSCzmSZs3JX
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="461708805"
X-IronPort-AV: E=Sophos;i="6.04,332,1695711600"; 
   d="scan'208";a="461708805"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 17:18:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="904006766"
X-IronPort-AV: E=Sophos;i="6.04,332,1695711600"; 
   d="scan'208";a="904006766"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.121.50])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 17:18:32 -0800
Subject: [PATCH v4 5/6] cxl: Refactor to use __free() for cxl_root allocation
 in cxl_find_nvdimm_bridge()
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dan.j.williams@intel.com, ira.weiny@intel.com, vishal.l.verma@intel.com,
 alison.schofield@intel.com, Jonathan.Cameron@huawei.com, dave@stgolabs.net,
 rrichter@amd.com
Date: Thu, 04 Jan 2024 18:18:31 -0700
Message-ID: <170441751181.3632067.5542037427417510907.stgit@djiang5-mobl3>
In-Reply-To: <170441738812.3632067.2103652995360101907.stgit@djiang5-mobl3>
References: <170441738812.3632067.2103652995360101907.stgit@djiang5-mobl3>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Use scope-based resource management __free() macro to make cxl_root
allocation safer in cxl_find_nvdimm_bridge().

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/pmem.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/pmem.c b/drivers/cxl/core/pmem.c
index 57b777a088f6..df3d11257511 100644
--- a/drivers/cxl/core/pmem.c
+++ b/drivers/cxl/core/pmem.c
@@ -64,7 +64,8 @@ static int match_nvdimm_bridge(struct device *dev, void *data)
 
 struct cxl_nvdimm_bridge *cxl_find_nvdimm_bridge(struct cxl_memdev *cxlmd)
 {
-	struct cxl_root *cxl_root = find_cxl_root(cxlmd->endpoint);
+	struct cxl_root *cxl_root __free(put_cxl_root) =
+		find_cxl_root(cxlmd->endpoint);
 	struct cxl_port *port;
 	struct device *dev;
 
@@ -73,7 +74,6 @@ struct cxl_nvdimm_bridge *cxl_find_nvdimm_bridge(struct cxl_memdev *cxlmd)
 
 	port = &cxl_root->port;
 	dev = device_find_child(&port->dev, NULL, match_nvdimm_bridge);
-	put_cxl_root(cxl_root);
 
 	if (!dev)
 		return NULL;


