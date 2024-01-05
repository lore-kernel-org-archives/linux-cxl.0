Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50FF51FAD
	for <linux-cxl@vger.kernel.org>; Fri,  5 Jan 2024 01:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YS7lk4HM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704417507; x=1735953507;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GPYlDuuUQfp5C8aj7jb9ockFHkCLSnVK6kwS2BOOxeg=;
  b=YS7lk4HMydqMPeF0yc2J/PMEgdifOXDU7M4rTryuhXZ78stlZbVS433P
   qrv1brVd1JY7wVX+FNBs/SKR11Xx2r53vfLiOsn81wGT+WXd28fUuZZFN
   Vh1nBj1qlns+JcLCQZn0kvAEhln4bmcm8Xt88TFayOXLT1sP3Slqg7lyZ
   Ub8Ruq1rZoNr0z3LGRLnVuiTj9DnEU84wjoXNDOQtfjq6RHm7zburKJ1D
   jx2rJxe7rB6JR+GYgxaREpBTXLdRSO/RVftWqGfpY1t6F+P3Ds4IRGNMC
   2HtvrB2iD+waQNbgWU/14HPFFn8pRDqCWIT4EtEde9EjZQxql26fbxhsz
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="463802274"
X-IronPort-AV: E=Sophos;i="6.04,332,1695711600"; 
   d="scan'208";a="463802274"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 17:18:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="1027613369"
X-IronPort-AV: E=Sophos;i="6.04,332,1695711600"; 
   d="scan'208";a="1027613369"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.121.50])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 17:18:26 -0800
Subject: [PATCH v4 4/6] cxl: Fix missing dereference of 'struct device' in
 cxl_port_perf_data_calculate()
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dan.j.williams@intel.com, ira.weiny@intel.com, vishal.l.verma@intel.com,
 alison.schofield@intel.com, Jonathan.Cameron@huawei.com, dave@stgolabs.net,
 rrichter@amd.com
Date: Thu, 04 Jan 2024 18:18:26 -0700
Message-ID: <170441750612.3632067.3372196682717758963.stgit@djiang5-mobl3>
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

cxl_port_perf_data_calculate() calls find_cxl_root() and does not
dereference the 'struct device' in the cxl_root->port. find_cxl_root()
calls get_device() and takes a reference on the port 'struct device'
member. Use the __free() macro to ensure the dereference happens.

Fixes: 7a4f148dd8d5 ("cxl: Compute the entire CXL path latency and bandwidth data")
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
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
 


