Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA16F1E4AE
	for <linux-cxl@vger.kernel.org>; Fri,  5 Jan 2024 22:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lhlPgept"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704492468; x=1736028468;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=y3+eTFeBRJ7HkdCG6z95DPgB7uHD+QkAHkgWnalW3Ts=;
  b=lhlPgept6n+rWN6FWiP7cz38LoxOuAOyj3bdI7zDeXsVFqZe1GWSWhuE
   r7sPgBqCAOYgSQaCCsUp9v4AXLeAjgfkiNIf7v3m+Ue0EpfytylYYqvmM
   yZBZ5KehHoVKG1oY4SDrSgq9guQInQ+VhFxg2hG5rI0q1UVOJ1lOppdwX
   JiRdlGVoVt+SB3fKXzxHz2tZ5e8HJUhL9UuMW5j7JOJjlg1HAWu21OfO0
   CfXo6fjPnqCbbP+eQK9MOf5Lw/Lu2sDUCh2dUVxaCwTod4a2+EVcJEaf4
   WXtNgz/EipnLoeOiFQPUvP5y8QZPcOSdTSGwjaIzoyiuLwx3NnUn4In5A
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10944"; a="4957475"
X-IronPort-AV: E=Sophos;i="6.04,335,1695711600"; 
   d="scan'208";a="4957475"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2024 14:07:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10944"; a="904260074"
X-IronPort-AV: E=Sophos;i="6.04,335,1695711600"; 
   d="scan'208";a="904260074"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.109.135])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2024 14:07:47 -0800
Subject: [PATCH v6 3/5] cxl: Fix device reference leak in
 cxl_port_perf_data_calculate()
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: Ira Weiny <ira.weiny@intel.com>, dan.j.williams@intel.com,
 ira.weiny@intel.com, vishal.l.verma@intel.com, alison.schofield@intel.com,
 Jonathan.Cameron@huawei.com, dave@stgolabs.net, rrichter@amd.com
Date: Fri, 05 Jan 2024 15:07:46 -0700
Message-ID: <170449246681.3779673.2288926019977963333.stgit@djiang5-mobl3>
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

cxl_port_perf_data_calculate() calls find_cxl_root() and does not
dereference the 'struct device' in the cxl_root->port. find_cxl_root()
calls get_device() and takes a reference on the port 'struct device'
member. Use the __free() macro to ensure the dereference happens.

Fixes: 7a4f148dd8d5 ("cxl: Compute the entire CXL path latency and bandwidth data")
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
v5:
- Update patch title (Dan)
---
 drivers/cxl/core/cdat.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
index 0df5379cf02f..c6208aab452f 100644
--- a/drivers/cxl/core/cdat.c
+++ b/drivers/cxl/core/cdat.c
@@ -162,7 +162,6 @@ static int cxl_port_perf_data_calculate(struct cxl_port *port,
 					struct xarray *dsmas_xa)
 {
 	struct access_coordinate c;
-	struct cxl_root *cxl_root;
 	struct dsmas_entry *dent;
 	int valid_entries = 0;
 	unsigned long index;
@@ -174,7 +173,11 @@ static int cxl_port_perf_data_calculate(struct cxl_port *port,
 		return rc;
 	}
 
-	cxl_root = find_cxl_root(port);
+	struct cxl_root *cxl_root __free(put_cxl_root) = find_cxl_root(port);
+
+	if (!cxl_root)
+		return -ENODEV;
+
 	if (!cxl_root->ops || !cxl_root->ops->qos_class)
 		return -EOPNOTSUPP;
 


