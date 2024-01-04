Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2B92C1B0
	for <linux-cxl@vger.kernel.org>; Thu,  4 Jan 2024 19:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E7Vlvb1C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704397429; x=1735933429;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wcqIJeSQYrOzB+2fuA7DspV800uCmH3uhNyCHT71wjc=;
  b=E7Vlvb1Ct8lKkzafrrGw8woMo6A7fJQAzRYIgFhu6cqTYr9gSqfJFrUH
   tBOqAEcr9PMETWYLE40fi6jNKTqAu2UO5pZaT/F1iWoWviSsUIz9BK1ze
   2ykRkfLxTxZ2nmDGlJVywcfoK5qsqSQtQpXz8zu6s93BlnYO2GfeSXMTt
   bTcPBwy5tKV61W6CFwnz2VpB4kyJoCxsqGDg6VKsx9i2zAIpVlaFgbaXV
   hvlECV5/l5Ah96RC/UI9wnK4mLYNkaMFA/Q0xJVSO3lYR+xur1G8nnAD0
   IBsdVVABF/srM7CqNTBYIVYxQ5d4E8T91iJwXKOhqfRJgVDz61Y1jcQHP
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="4454342"
X-IronPort-AV: E=Sophos;i="6.04,331,1695711600"; 
   d="scan'208";a="4454342"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 11:43:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="899408786"
X-IronPort-AV: E=Sophos;i="6.04,331,1695711600"; 
   d="scan'208";a="899408786"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.121.50])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 11:43:48 -0800
Subject: [PATCH v2 2/3] cxl: Add missing device dereference after
 find_cxl_root()
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dan.j.williams@intel.com, ira.weiny@intel.com, vishal.l.verma@intel.com,
 alison.schofield@intel.com, Jonathan.Cameron@huawei.com, dave@stgolabs.net,
 rrichter@amd.com
Date: Thu, 04 Jan 2024 12:43:48 -0700
Message-ID: <170439742837.3519628.14026339143178956408.stgit@djiang5-mobl3>
In-Reply-To: <170439742132.3519628.18244037289884549403.stgit@djiang5-mobl3>
References: <170439742132.3519628.18244037289884549403.stgit@djiang5-mobl3>
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
 drivers/cxl/core/cdat.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
index 3dce4a201ddd..701ed53ce337 100644
--- a/drivers/cxl/core/cdat.c
+++ b/drivers/cxl/core/cdat.c
@@ -162,7 +162,7 @@ static int cxl_port_perf_data_calculate(struct cxl_port *port,
 					struct xarray *dsmas_xa)
 {
 	struct access_coordinate c;
-	struct cxl_port *root_port;
+	struct cxl_port *root_port __free(put_device) = NULL;
 	struct cxl_root *cxl_root;
 	struct dsmas_entry *dent;
 	int valid_entries = 0;


