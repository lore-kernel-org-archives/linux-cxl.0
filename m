Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B5B2D610
	for <linux-cxl@vger.kernel.org>; Thu,  4 Jan 2024 19:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IojB2DD0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704397425; x=1735933425;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5oVHEKSVeqJ5V9NFft7Okq63JdBPytenPTERDHI/xZk=;
  b=IojB2DD0ZAGaMKALL3bKsr+fO2JZpndLgVQHEclskKq3UnThVt4l6G+B
   FrorfuQ1Hadc6W0RVA3uf9935DGK008h34gF7ge78SC5GvvTMR2sziVFD
   iE5KDhY8kB/e4ToK9cF/KutZtcRAVnjxvdC6iRFwhiS8/E2H95JKARufV
   xnSa4cVMCE2RruUSin533LqUK69+/bD7S+R+pKO4zd7jvd50wLiNEW0uB
   JljVr/WUAkX+EBQYg8vPpmK9K6f4f7dcEJo9r2pMIs1MOVrj3R9Sq48c2
   JDBJq+2UNIDPJhr2J+8M1Oy9ihcJeLfW2O77XHLyEmpE1l+4zONK+7lUC
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="4454324"
X-IronPort-AV: E=Sophos;i="6.04,331,1695711600"; 
   d="scan'208";a="4454324"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 11:43:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="899408752"
X-IronPort-AV: E=Sophos;i="6.04,331,1695711600"; 
   d="scan'208";a="899408752"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.121.50])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 11:43:41 -0800
Subject: [PATCH v2 1/3] cxl: Add check for NULL ptr after calling
 find_cxl_root()
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dan.j.williams@intel.com, ira.weiny@intel.com, vishal.l.verma@intel.com,
 alison.schofield@intel.com, Jonathan.Cameron@huawei.com, dave@stgolabs.net,
 rrichter@amd.com
Date: Thu, 04 Jan 2024 12:43:41 -0700
Message-ID: <170439742132.3519628.18244037289884549403.stgit@djiang5-mobl3>
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


