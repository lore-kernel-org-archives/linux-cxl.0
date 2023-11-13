Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E6B208BB
	for <linux-cxl@vger.kernel.org>; Mon, 13 Nov 2023 22:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Iab6Ucaw"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2BB6DC
	for <linux-cxl@vger.kernel.org>; Mon, 13 Nov 2023 14:13:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699913609; x=1731449609;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Yj5vg1DYtloXkQkiRLrMNWtig7Om1Ewo9q9vdUCcKQg=;
  b=Iab6Ucaw4LpDxb6AfxVk+LFOWtnsbCr6BjDTUvKKrNamw1LDt6vXlCRt
   a7SCSy6eXzqPVBDRjGgGPR8OWsDIAHcKsrdHy4RknQn7WdsfIXRLw3owW
   ALrcaIg8GU4RN6zdG1KiVcs1ViEMuu88yTWNCfhkte3+wyabsvAPO+jAx
   0BbKOH36bY30LYP/uxr9USFjoZCM85TBOQwbTrZVHtzpOODBp1fDR32wr
   iYf1A1sEjg12oCb+PnGTIOo/oQGoDNntfe2kLRau6JZm2B9j7BhUxtHAw
   7rTaOsG8ypvo2DJQ9ZV7qLYog2aKBleDkBSmGuCDsQx76HRwGB/4GMWct
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="394431306"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="394431306"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 14:13:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="1011674460"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="1011674460"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.212.206.59])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 14:13:28 -0800
From: alison.schofield@intel.com
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org,
	Dmytro Adamenko <dmytro.adamenko@intel.com>
Subject: [PATCH] kernel/resource: Increment by align value in get_free_mem_region()
Date: Mon, 13 Nov 2023 14:13:24 -0800
Message-Id: <20231113221324.1118092-1-alison.schofield@intel.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alison Schofield <alison.schofield@intel.com>

Currently get_free_mem_region() searches for available capacity
in increments equal to the region size being requested. This can
cause the search to take giant steps through the resource leaving
needless gaps and missing available space.

Replace the size increment with an alignment increment so that the
next possible address is always examined for availability.

Fixes: 14b80582c43e ("resource: Introduce alloc_free_mem_region()")
Reported-by: Dmytro Adamenko <dmytro.adamenko@intel.com>
Reported-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---

A couple of below the line items:

The MAINTAINERS file and get_maintainers script did not emit a clear
recipient list for this one. Start with CXL folks and I can expand
it in a v2 with your help.

I considered, but didn't, change the parameter naming in gfr_continue(),
gfr_next(). It's a choice as get_free_mem_region() is the only caller.
Thoughts?


 kernel/resource.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/resource.c b/kernel/resource.c
index 866ef3663a0b..91be1bc50b60 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -1844,8 +1844,8 @@ get_free_mem_region(struct device *dev, struct resource *base,
 
 	write_lock(&resource_lock);
 	for (addr = gfr_start(base, size, align, flags);
-	     gfr_continue(base, addr, size, flags);
-	     addr = gfr_next(addr, size, flags)) {
+	     gfr_continue(base, addr, align, flags);
+	     addr = gfr_next(addr, align, flags)) {
 		if (__region_intersects(base, addr, size, 0, IORES_DESC_NONE) !=
 		    REGION_DISJOINT)
 			continue;

base-commit: b85ea95d086471afb4ad062012a4d73cd328fa86
-- 
2.37.3

