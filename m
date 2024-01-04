Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3804A2D60A
	for <linux-cxl@vger.kernel.org>; Thu,  4 Jan 2024 23:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hq1elv5O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704409245; x=1735945245;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5oVHEKSVeqJ5V9NFft7Okq63JdBPytenPTERDHI/xZk=;
  b=Hq1elv5O68jBuaI6dZCr9Qbs/uJ//z3gFqvAljWBacSWlfNooiQPR0Z5
   zD3qxFE8gafeiIVtsjedq7aoY/Mbtw97Y9DEdE+/ZMPvWQ0/+A25YHPLr
   9T97dPXnan3Lg7nuYihAxxNFFWwsbinO2saD9F1w2ceZF5z+uIvPR/vFN
   GEJDGq9Py5bRAger2/BVCvFrcKX/hf32wmN4ZYbzwKEkOwsXkJ5cxVMoY
   OKRvkCsOyhsNva5Arv1N10S1eAo09dKCkGcXCQ1RamoiXP6EcXggCmqqC
   3ZLYc2RpKG5BlkXfHzVJyKv1/GyiwWzeuFF2A0j6OAoVAXWMbWpyTTbHQ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="387831510"
X-IronPort-AV: E=Sophos;i="6.04,332,1695711600"; 
   d="scan'208";a="387831510"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 15:00:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="924060527"
X-IronPort-AV: E=Sophos;i="6.04,332,1695711600"; 
   d="scan'208";a="924060527"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.121.50])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 15:00:43 -0800
Subject: [PATCH v3 1/4] cxl: Add check for NULL ptr after calling
 find_cxl_root()
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dan.j.williams@intel.com, ira.weiny@intel.com, vishal.l.verma@intel.com,
 alison.schofield@intel.com, Jonathan.Cameron@huawei.com, dave@stgolabs.net,
 rrichter@amd.com
Date: Thu, 04 Jan 2024 16:00:43 -0700
Message-ID: <170440924347.3570725.6271367271629367301.stgit@djiang5-mobl3>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

In cxl_port_perf_data_calculate, the function fails to check for NULL ptr
after calling find_cxl_root(). Add check to avoid NULL ptr dereferencing.

Fixes: 7a4f148dd8d5 ("cxl: Compute the entire CXL path latency and bandwidth data")
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/cdat.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
index cd84d87f597a..3dce4a201ddd 100644
--- a/drivers/cxl/core/cdat.c
+++ b/drivers/cxl/core/cdat.c
@@ -176,6 +176,9 @@ static int cxl_port_perf_data_calculate(struct cxl_port *port,
 	}
 
 	root_port = find_cxl_root(port);
+	if (!root_port)
+		return -ENODEV;
+
 	cxl_root = to_cxl_root(root_port);
 	if (!cxl_root->ops || !cxl_root->ops->qos_class)
 		return -EOPNOTSUPP;


