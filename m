Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999BD2D03D
	for <linux-cxl@vger.kernel.org>; Thu,  4 Jan 2024 23:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A7r7lOnl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704409250; x=1735945250;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=u/F9usMiwF4Ru0j9nvIR5fNOEh0aoZ141cb1CBnDeAo=;
  b=A7r7lOnlCATTD3ymrl44bYO1zHtjUgcN6r/XP7lcXaM9gftfWVcUckvL
   h7cNz/iJfM4j7bHIlwKpC877DxZMkUM3wWJcYzVGez9cbcrRWm4gfyy/1
   HyESNW1wOMCRE2nDPfsPoovL6vAn236Vfz6ZdXdHADf2TK+1eY4W9lqGz
   zzYbO3TUN+sosk9JZ/9akOtxaTaFCWnnFJT3U/AokXy218BG/ZihPd3Si
   YyI3upZ1LsFU8E5YI8O6Ie4LcTVfMG3kgYA+zXi/znIN2cwiZ56MRXNJq
   YQ2rgMq0MS7ze+yeCM7TKJ35bQkkHr3hQAsyliLLpcXtqoRVsf4hQE0b9
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="387831525"
X-IronPort-AV: E=Sophos;i="6.04,332,1695711600"; 
   d="scan'208";a="387831525"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 15:00:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="846392333"
X-IronPort-AV: E=Sophos;i="6.04,332,1695711600"; 
   d="scan'208";a="846392333"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.121.50])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 15:00:49 -0800
Subject: [PATCH v3 2/4] cxl: Add missing device dereference after
 find_cxl_root()
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dan.j.williams@intel.com, ira.weiny@intel.com, vishal.l.verma@intel.com,
 alison.schofield@intel.com, Jonathan.Cameron@huawei.com, dave@stgolabs.net,
 rrichter@amd.com
Date: Thu, 04 Jan 2024 16:00:49 -0700
Message-ID: <170440924930.3570725.10428771109298188521.stgit@djiang5-mobl3>
In-Reply-To: <170440924347.3570725.6271367271629367301.stgit@djiang5-mobl3>
References: <170440924347.3570725.6271367271629367301.stgit@djiang5-mobl3>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

find_cxl_root() takes a reference on the 'struct device' before returning.
A put_device() is needed when once the root port is no longer needed.
cxl_port_perf_data_calculate() fails to dereference device. Add a __free()
call to make sure the device reference is decremented when done.

Fixes: 7a4f148dd8d5 ("cxl: Compute the entire CXL path latency and bandwidth data")
Signed-off-by: Dave Jiang <dave.jiang@intel.com>

---
v3:
- Declare root_port at the allocation point.
---
 drivers/cxl/core/cdat.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
index 3dce4a201ddd..c5031e90bb96 100644
--- a/drivers/cxl/core/cdat.c
+++ b/drivers/cxl/core/cdat.c
@@ -162,7 +162,6 @@ static int cxl_port_perf_data_calculate(struct cxl_port *port,
 					struct xarray *dsmas_xa)
 {
 	struct access_coordinate c;
-	struct cxl_port *root_port;
 	struct cxl_root *cxl_root;
 	struct dsmas_entry *dent;
 	int valid_entries = 0;
@@ -175,7 +174,8 @@ static int cxl_port_perf_data_calculate(struct cxl_port *port,
 		return rc;
 	}
 
-	root_port = find_cxl_root(port);
+	struct cxl_port *root_port __free(put_device) = find_cxl_root(port);
+
 	if (!root_port)
 		return -ENODEV;
 


