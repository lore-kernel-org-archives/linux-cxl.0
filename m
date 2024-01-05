Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94F3328BD
	for <linux-cxl@vger.kernel.org>; Fri,  5 Jan 2024 18:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WiACTKhn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704477805; x=1736013805;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Esv3MnknffmPqdGLatDPw9oWAzQh8iD1kz9bAD0+SQ8=;
  b=WiACTKhn1SSoQb4VmgLif4u4AHxYcu4Q15EJXgOlgKnsjEDQevQcRGKL
   4TzrOOJhj/nfXkiT0khSX4Y9GR6GuDT4poelFBGzq7yoLYzt/BaDbf6ow
   gUl8Gyh+FNlHYkPnZ0/aLY9WW1V20tc0ifjBegHAjYVKHVD/b+UdPlGAn
   D9nTR6LEOXJBFAMJ3hduIGs+NZ+vrPWI8Vzi9UHy+CbSBdLjuf39a/YzJ
   S2QFZFevEW1jrRMNFndSydgT3EZ8jWnZwpsgDgJakEt/aVy735zMuepdP
   CXf0M06DZVyF1TQVL9XlreZt56qrk0savZ9u7XagHSDkuDTFLWn++BtHt
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10944"; a="382528528"
X-IronPort-AV: E=Sophos;i="6.04,334,1695711600"; 
   d="scan'208";a="382528528"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2024 10:03:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10944"; a="924277928"
X-IronPort-AV: E=Sophos;i="6.04,334,1695711600"; 
   d="scan'208";a="924277928"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.109.135])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2024 10:03:24 -0800
Subject: [PATCH v5 4/5] cxl: Refactor to use __free() for cxl_root allocation
 in cxl_find_nvdimm_bridge()
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dan.j.williams@intel.com, ira.weiny@intel.com, vishal.l.verma@intel.com,
 alison.schofield@intel.com, Jonathan.Cameron@huawei.com, dave@stgolabs.net,
 rrichter@amd.com
Date: Fri, 05 Jan 2024 11:03:23 -0700
Message-ID: <170447780395.3687480.12988681766480964910.stgit@djiang5-mobl3>
In-Reply-To: <170447769575.3687480.11698914923419362733.stgit@djiang5-mobl3>
References: <170447769575.3687480.11698914923419362733.stgit@djiang5-mobl3>
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

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
v5
- Update commit log (Dan)
---
 drivers/cxl/core/pmem.c |    8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/cxl/core/pmem.c b/drivers/cxl/core/pmem.c
index 57b777a088f6..e69625a8d6a1 100644
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
-	put_cxl_root(cxl_root);
+	dev = device_find_child(&cxl_root->port.dev, NULL, match_nvdimm_bridge);
 
 	if (!dev)
 		return NULL;


