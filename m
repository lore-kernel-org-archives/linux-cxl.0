Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582D9185B
	for <linux-cxl@vger.kernel.org>; Fri,  5 Jan 2024 01:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JP3kX4er"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704417648; x=1735953648;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8d+yZXMHnByfoCbCIgAmBBTnZo+J+B13YMbRoqLlIEQ=;
  b=JP3kX4erY4AZsGxykT1JUonvuzzWL7bSibR3GgQ/2JLgZN0lGJFmk3Wx
   62WSqfh6Jm9eCN3QJPZA9xQ7gpF8OzAdbIkY5sQwjPgezso4rQJN99BHS
   DadZ8Nx4YMOMwIlUGPYRoL1mFad/o3c5hCxYqRMCp341Bfm9H8lRtLjPt
   exGjculuY6sTQODu+URQYmnp8sF5ia8iZiWTSWaCYYImjkVvsy8JL63Dx
   RtcI7mDxDavF0rTjKPQop8GVe/OmDOtxeHeQiTU784nb3jie2ga8TiwQg
   xFHSgbj5krO5XjWBlBTBL5vVZUVaGE3FKFZaKptCVzuGxYM2Qb9zen5TP
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="461708845"
X-IronPort-AV: E=Sophos;i="6.04,332,1695711600"; 
   d="scan'208";a="461708845"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 17:18:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="904006801"
X-IronPort-AV: E=Sophos;i="6.04,332,1695711600"; 
   d="scan'208";a="904006801"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.121.50])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 17:18:38 -0800
Subject: [PATCH v4 6/6] cxl: Refactor to use __free() for cxl_root allocation
 in cxl_endpoint_port_probe()
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dan.j.williams@intel.com, ira.weiny@intel.com, vishal.l.verma@intel.com,
 alison.schofield@intel.com, Jonathan.Cameron@huawei.com, dave@stgolabs.net,
 rrichter@amd.com
Date: Thu, 04 Jan 2024 18:18:38 -0700
Message-ID: <170441751817.3632067.18926893176028509.stgit@djiang5-mobl3>
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
allocation simpler and safer in cxl_endpoint_port_probe().

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
v4:
- Don't check return value of find_cxl_root() per comment. (Dan)
---
 drivers/cxl/port.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index ddbb42f0fd70..89d303f048e7 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -95,7 +95,6 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
 	struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport_dev);
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
 	struct cxl_hdm *cxlhdm;
-	struct cxl_root *cxl_root;
 	struct cxl_port *root_port;
 	int rc;
 
@@ -131,7 +130,8 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
 	 * This can't fail in practice as CXL root exit unregisters all
 	 * descendant ports and that in turn synchronizes with cxl_port_probe()
 	 */
-	cxl_root = find_cxl_root(port);
+	struct cxl_root *cxl_root __free(put_cxl_root) = find_cxl_root(port);
+
 	root_port = &cxl_root->port;
 
 	/*
@@ -139,7 +139,6 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
 	 * assemble regions from committed decoders
 	 */
 	device_for_each_child(&root_port->dev, root_port, discover_region);
-	put_cxl_root(cxl_root);
 
 	return 0;
 }


