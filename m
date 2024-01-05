Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6D71E4AE
	for <linux-cxl@vger.kernel.org>; Fri,  5 Jan 2024 22:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WUJ1Ig12"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704492475; x=1736028475;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qcI+jdw16LOCZ9SHkzlxewXjrJbAF++MPplCn7CNzSU=;
  b=WUJ1Ig125faW36eRkGOE+x9T0Z+mNg6hosn50+q0OnLDf9rh8b9jnoSE
   jnQvTkbMxRGi3bYlkPQsDAY6f/IVwM9xAf1+k5en6c4VsQMd2KB9n2lzF
   vcBZ9aJc0s7EyBLZyWvwBRr0vjJLLWVac4r0UmmqDKoG/IbMRv4xHzSaX
   Y0nXpeF86HNsQ+EdWCnfZgPPKBr69pZZSQXKMXJo+6zk26e0FbvZQJqJE
   +AveDwI0iqGtLtemNs5sARvlDF1TNXJpM3RBXcRSijYegr1hVqQiWPM6j
   ocZb+fbebQIsavF3C6RIUhrCINvC63CbFQOynSTsIunpRr3mTqCSgyyXn
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10944"; a="4957504"
X-IronPort-AV: E=Sophos;i="6.04,335,1695711600"; 
   d="scan'208";a="4957504"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2024 14:07:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10944"; a="904260081"
X-IronPort-AV: E=Sophos;i="6.04,335,1695711600"; 
   d="scan'208";a="904260081"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.109.135])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2024 14:07:54 -0800
Subject: [PATCH v6 4/5] cxl: Refactor to use __free() for cxl_root allocation
 in cxl_find_nvdimm_bridge()
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: Ira Weiny <ira.weiny@intel.com>, dan.j.williams@intel.com,
 ira.weiny@intel.com, vishal.l.verma@intel.com, alison.schofield@intel.com,
 Jonathan.Cameron@huawei.com, dave@stgolabs.net, rrichter@amd.com
Date: Fri, 05 Jan 2024 15:07:53 -0700
Message-ID: <170449247353.3779673.5963704495491343135.stgit@djiang5-mobl3>
In-Reply-To: <170449229696.3779673.18384234151739803343.stgit@djiang5-mobl3>
References: <170449229696.3779673.18384234151739803343.stgit@djiang5-mobl3>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Use scope-based resource management __free() macro to drop the open coded
put_device() in cxl_find_nvdimm_bridge().

Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
v6:
- Cleanup put_device()
v5
- Update commit log (Dan)
---
 drivers/cxl/core/pmem.c |    8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/cxl/core/pmem.c b/drivers/cxl/core/pmem.c
index da92a901b9e8..e69625a8d6a1 100644
--- a/drivers/cxl/core/pmem.c
+++ b/drivers/cxl/core/pmem.c
@@ -64,16 +64,14 @@ static int match_nvdimm_bridge(struct device *dev, void *data)
 
 struct cxl_nvdimm_bridge *cxl_find_nvdimm_bridge(struct cxl_memdev *cxlmd)
 {
-	struct cxl_root *cxl_root = find_cxl_root(cxlmd->endpoint);
-	struct cxl_port *port;
+	struct cxl_root *cxl_root __free(put_cxl_root) =
+		find_cxl_root(cxlmd->endpoint);
 	struct device *dev;
 
 	if (!cxl_root)
 		return NULL;
 
-	port = &cxl_root->port;
-	dev = device_find_child(&port->dev, NULL, match_nvdimm_bridge);
-	put_device(&port->dev);
+	dev = device_find_child(&cxl_root->port.dev, NULL, match_nvdimm_bridge);
 
 	if (!dev)
 		return NULL;


