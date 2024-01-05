Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13976328C7
	for <linux-cxl@vger.kernel.org>; Fri,  5 Jan 2024 18:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ThDre2DR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704477800; x=1736013800;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fUnmACVf8I1K1+10srbk/em5Y/LaLCkGPEZWRZlVYCs=;
  b=ThDre2DR2N5xpk1lgq3Ej+gjerC8/rabn6UvtOJRF3gX4usMiWXF4+0H
   zOPYDR94GZQ1yWmse6mKmg7UpTLO+MHHuLEd4vQXRoimOSz8vtde4Ifq2
   rEFhaiZlbYwoP+BhQp0s79fYYF3c4mr7s+KPBK9iQysfmZw+Ck2ypkNPW
   VjAvTRueQ2I0lJCX/gRXEO7MIrXUKqxRxoioq5hS5ric60G48CbTgNpN2
   M453zfcM6gOnXJmyg2HyI33OuBwrmc04yoo6GG9ImMvBor1/civHIUGuu
   ojlARsfvJVreGfZ747Lk8fN3Hch4jcK2aimh3KZm4dzYONfLGPXuu1lYN
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10944"; a="19067962"
X-IronPort-AV: E=Sophos;i="6.04,334,1695711600"; 
   d="scan'208";a="19067962"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2024 10:03:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10944"; a="773905688"
X-IronPort-AV: E=Sophos;i="6.04,334,1695711600"; 
   d="scan'208";a="773905688"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.109.135])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2024 10:03:18 -0800
Subject: [PATCH v5 3/5] cxl: Fix device reference leak in
 cxl_port_perf_data_calculate()
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dan.j.williams@intel.com, ira.weiny@intel.com, vishal.l.verma@intel.com,
 alison.schofield@intel.com, Jonathan.Cameron@huawei.com, dave@stgolabs.net,
 rrichter@amd.com
Date: Fri, 05 Jan 2024 11:03:17 -0700
Message-ID: <170447779772.3687480.17784838254725684393.stgit@djiang5-mobl3>
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

cxl_port_perf_data_calculate() calls find_cxl_root() and does not
dereference the 'struct device' in the cxl_root->port. find_cxl_root()
calls get_device() and takes a reference on the port 'struct device'
member. Use the __free() macro to ensure the dereference happens.

Fixes: 7a4f148dd8d5 ("cxl: Compute the entire CXL path latency and bandwidth data")
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
 


