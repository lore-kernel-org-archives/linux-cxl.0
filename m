Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483481E4AE
	for <linux-cxl@vger.kernel.org>; Fri,  5 Jan 2024 22:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WPTfqi3f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704492481; x=1736028481;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=O+VUXM4yELYB8q50EARA0Lqt8r/+ZhrOf7mCZVLR6sU=;
  b=WPTfqi3fseXWlmWXcbHAP3qTydUzi4NTwsWo7f9mT2TfYyWCrWHFzT9L
   Sa+Gehmoab9MKL8gBL5YToXH4Q3mv7KEDqXZo0eB5ZaMHco4m1wMjJrkq
   hZMhSMEQB0AwZVaZa6vazBNHF1hJ+7XUbQYRSK2n2ZglpXsP3R5NWogXd
   WM7DiMVOawT+T+F6dpqfMy1UWqzoZeIQskls14Kdp/09t+xvARpw1yowq
   gNRN24fcihXuLWEV3mcyZYb/DKPj8Vzhm4xP/wTjSuil1Je0Sk6T9Av8R
   s4uDerBTX1y0taAWnz9qf5y5n49hirSKP350PgAQ8rAneT0PlJt1Aqn36
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10944"; a="4957568"
X-IronPort-AV: E=Sophos;i="6.04,335,1695711600"; 
   d="scan'208";a="4957568"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2024 14:08:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10944"; a="904260095"
X-IronPort-AV: E=Sophos;i="6.04,335,1695711600"; 
   d="scan'208";a="904260095"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.109.135])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2024 14:08:00 -0800
Subject: [PATCH v6 5/5] cxl: Refactor to use __free() for cxl_root allocation
 in cxl_endpoint_port_probe()
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: Ira Weiny <ira.weiny@intel.com>, dan.j.williams@intel.com,
 ira.weiny@intel.com, vishal.l.verma@intel.com, alison.schofield@intel.com,
 Jonathan.Cameron@huawei.com, dave@stgolabs.net, rrichter@amd.com
Date: Fri, 05 Jan 2024 15:07:59 -0700
Message-ID: <170449247973.3779673.15088722836135359275.stgit@djiang5-mobl3>
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
put_device() in cxl_endpoint_port_probe().

Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
v6:
- Cleanup put_device()
v5:
- Update commit log (Dan)
v4:
- Don't check return value of find_cxl_root() per comment. (Dan)
---
 drivers/cxl/port.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index 4f3a08fdc9e9..97c21566677a 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -94,7 +94,6 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
 	struct cxl_endpoint_dvsec_info info = { .port = port };
 	struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport_dev);
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
-	struct cxl_root *cxl_root;
 	struct cxl_hdm *cxlhdm;
 	struct cxl_port *root;
 	int rc;
@@ -131,7 +130,8 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
 	 * This can't fail in practice as CXL root exit unregisters all
 	 * descendant ports and that in turn synchronizes with cxl_port_probe()
 	 */
-	cxl_root = find_cxl_root(port);
+	struct cxl_root *cxl_root __free(put_cxl_root) = find_cxl_root(port);
+
 	root = &cxl_root->port;
 
 	/*
@@ -139,7 +139,6 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
 	 * assemble regions from committed decoders
 	 */
 	device_for_each_child(&port->dev, root, discover_region);
-	put_device(&root->dev);
 
 	return 0;
 }


