Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB24046C4DD
	for <linux-cxl@vger.kernel.org>; Tue, 21 Jul 2026 17:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784655433; cv=none; b=ozk1C7EGeBcO/rj5vg/ZU/WaF/PaWhYMOqBTMdfwiyyGPcJxTkq2Ug9UFOi9ZdEdUfwg7RCgM5p5r5l1t/fN6bbGU2sMFOVt4M0Qgt8nyU/drnQaQAaIIg1/T2BMujmwrM+oYDN4dMjss/EgrK8RD9OVTfZCM2Z0DcyvNOJbCtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784655433; c=relaxed/simple;
	bh=VkfsPJqBhxtMnegb6Mm8zHGCWqI6+ybCdA4gJ+JGXJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pHdZIHXDgTz54J+vQbAWVObySeXrS7mvBO2Fryynxr4vW9CvovkR2a60l8JYmhwqlhMybYcTpOvsuoYMbBbw4WtCWSvkJRkNSdeRDTmWdeNSwB6fzkjUxhXsxS4ydP+6yKd2GgnT41ZU46i0AADo2RG5iGSUjKcwPFF1vFrFuOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HI0H6VmC; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HI0H6VmC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784655432; x=1816191432;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VkfsPJqBhxtMnegb6Mm8zHGCWqI6+ybCdA4gJ+JGXJQ=;
  b=HI0H6VmCd2QtVQ5blUUaLpWODJRjwvX/P/1WiA8xhqAm/X0DZrBsEgfF
   XURrzz2CpdoKC/kZIwZyC0U9ddYVtet5oHVjxLLihqlqqbpITrsBF9eiF
   IrO3pd9wvbr3mUYmICoMGNBfpZD8FCXz9ieAjmM6Zyz87cbTJE0eq7Iji
   2VkmmH/kjGlpq4BCoJb2242ZTWpEyKDUr68fZxUy7jfKjCpQ6S6gn4xzl
   7qYegDb8p4p+/l1CLHY4S9JgkzBRFqzhr+7J2foAPegIwMrbJyPJxPyj4
   YJDBSVTKp+TQvKclz0h3xSY+Itu+F1ERMOZvWE5K4I49OFanJZDEcciro
   w==;
X-CSE-ConnectionGUID: I4wB+0GaTtikonT8fwxofg==
X-CSE-MsgGUID: FGm2lWlNQOy4IZBD+18UZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11853"; a="96782123"
X-IronPort-AV: E=Sophos;i="6.25,177,1779174000"; 
   d="scan'208";a="96782123"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 10:37:12 -0700
X-CSE-ConnectionGUID: axwXFN9eSWCYIHS0CFkoVA==
X-CSE-MsgGUID: zOga5J6BQN6SrYX/i0DWcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,177,1779174000"; 
   d="scan'208";a="258486554"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.221.249])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 10:37:11 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>,
	Dan Williams <djbw@kernel.org>,
	Li Ming <ming.li@zohomail.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH v2 2/2] cxl/region: Use __free(put_device) in find_pos_and_ways()
Date: Tue, 21 Jul 2026 10:37:04 -0700
Message-ID: <03aceaa0001651c28f221988c9e845f59bf1d84d.1784654628.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <3a36953b5c665cb9544ba61dafbea0b0fa508c77.1784654628.git.alison.schofield@intel.com>
References: <3a36953b5c665cb9544ba61dafbea0b0fa508c77.1784654628.git.alison.schofield@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use __free(put_device) for the switch decoder reference returned by
device_find_child() instead of releasing it with an open-coded
put_device().

This matches the scoped device reference handling used elsewhere in
the file.

Suggested-by: Li Ming <ming.li@zohomail.com>
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---

This is a new patch added in series after the UAF fixup in patch 1/2.


 drivers/cxl/core/region.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index c86dd9d55e93..4d7d96d03ece 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1911,9 +1911,9 @@ static int match_switch_decoder_by_range(struct device *dev,
 static int find_pos_and_ways(struct cxl_port *port, struct range *range,
 			     int *pos, int *ways)
 {
+	struct device *dev __free(put_device) = NULL;
 	struct cxl_switch_decoder *cxlsd;
 	struct cxl_port *parent;
-	struct device *dev;
 	int rc = -ENXIO;
 
 	parent = parent_port_of(port);
@@ -1945,8 +1945,6 @@ static int find_pos_and_ways(struct cxl_port *port, struct range *range,
 			dev_name(port->parent_dport->dport_dev),
 			dev_name(&cxlsd->cxld.dev));
 
-	put_device(dev);
-
 	return rc;
 }
 
-- 
2.37.3

