Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125A31B3727;
	Thu, 10 Oct 2024 06:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728543380; cv=none; b=UdHFL7538k/DpFObT+8cy7vQ+TKL/Lf612QTEf6FQS9SQA/1zWs8x6ul84Wlb0+eWfp0TJxrdT1Ihva+vKQQY948OC0h3xxgkmkHo6PwiED6yIzEIjxEg6lVy5BgSsiQppVSZ/vyt9VNFB0g/0sCo59LotvKzWZRyIWUm/4gzvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728543380; c=relaxed/simple;
	bh=2Df5FXqi+/E58OjQ101ZrWiq5+1tVdsdX+lRyBQgnRE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KCse64m+LAxoWxX8PAP+WT0E0+vgt93punx6qOjmjotbiIs4CS7JgOfbvqFuk8PUR/ptV5Qpm1JvEJoZkEjqLBfc6/f4Fo82xOIrUjJoulZgWbw6owEwBPHc4jFCG3KeXFAsWOZBDFmZH815tqdqJlm4Nwaut+Z+YPEF7+3aS+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FfGHmxmg; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FfGHmxmg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728543379; x=1760079379;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2Df5FXqi+/E58OjQ101ZrWiq5+1tVdsdX+lRyBQgnRE=;
  b=FfGHmxmgwUTQKB8ytO9MvQoxF70Tm118ym/Qb3cfNf9xEFmbSVEkoufi
   gLVWfFfUBtVInLt8eNGsf2TJi4K47PDEqFYjNXXxVfqTkrabCPZm2ROy2
   ivgC29GtKozAK6HNJ1WioPRByk+0k7ER41CMl6ssxSLzs2CRUIg9g03Ug
   8wK/DoUZHkB6umnts2ZR4Wr61gkxd7xvb0kM0pd6POhf3I0cuT2dBV5bk
   fcf7aIb3emVQtDff735CWBqM15K1LXjqmNuZMVRVe6ctU8U8y0QYDwsHd
   oNzoRlSqQeCuiLXJE71+UFL/3grNgQf4phdI4LB3fW7nwIu82Dyi3TUHy
   g==;
X-CSE-ConnectionGUID: DjeH6cP4RMCDc+wmnGhLjQ==
X-CSE-MsgGUID: 5ByBeTi3RYakfuzynzSzeg==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="28013097"
X-IronPort-AV: E=Sophos;i="6.11,192,1725346800"; 
   d="scan'208";a="28013097"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 23:56:18 -0700
X-CSE-ConnectionGUID: 1aAYwmSHSemda/dLtUrbhQ==
X-CSE-MsgGUID: yz/iyDIDSySv1bSXMR8fdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,192,1725346800"; 
   d="scan'208";a="81504475"
Received: from unknown (HELO yhuang6-mobl2.ccr.corp.intel.com) ([10.245.243.193])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 23:56:15 -0700
From: Huang Ying <ying.huang@intel.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	Huang Ying <ying.huang@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	David Hildenbrand <david@redhat.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Alistair Popple <apopple@nvidia.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Baoquan He <bhe@redhat.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>
Subject: [RFC] resource: Avoid unnecessary resource tree walking in __region_intersects()
Date: Thu, 10 Oct 2024 14:55:58 +0800
Message-Id: <20241010065558.1347018-1-ying.huang@intel.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, if __region_intersects() finds any overlapped but unmatched
resource, it walks the descendant resource tree to check for
overlapped and matched descendant resources.  This is achieved using
for_each_resource(), which iterates not only the descent tree, but
also subsequent sibling trees in certain scenarios.  While this
doesn't introduce bugs, it makes code hard to be understood and
potentially inefficient.

So, the patch renames next_resource() to __next_resource() and
modified it to return NULL after traversing all descent resources.
Test shows that this avoids unnecessary resource tree walking in
__region_intersects().

It appears even better to revise for_each_resource() to traverse the
descendant resource tree of "_root" only.  But that will cause "_root"
to be evaluated twice, which I don't find a good way to eliminate.

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Alistair Popple <apopple@nvidia.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>
---
 kernel/resource.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/kernel/resource.c b/kernel/resource.c
index b730bd28b422..3ded4c5d4418 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -50,15 +50,28 @@ EXPORT_SYMBOL(iomem_resource);
 
 static DEFINE_RWLOCK(resource_lock);
 
-static struct resource *next_resource(struct resource *p, bool skip_children)
+static struct resource *__next_resource(struct resource *root, struct resource *p,
+					bool skip_children)
 {
 	if (!skip_children && p->child)
 		return p->child;
-	while (!p->sibling && p->parent)
+	while (!p->sibling && p->parent) {
 		p = p->parent;
+		if (p == root)
+			return NULL;
+	}
 	return p->sibling;
 }
 
+static struct resource *next_resource(struct resource *p, bool skip_children)
+{
+	return __next_resource(NULL, p, skip_children);
+}
+
+/*
+ * Traverse the whole resource tree (NOTE: not descendant tree under
+ * _root) from _root->child on.
+ */
 #define for_each_resource(_root, _p, _skip_children) \
 	for ((_p) = (_root)->child; (_p); (_p) = next_resource(_p, _skip_children))
 
@@ -572,7 +585,7 @@ static int __region_intersects(struct resource *parent, resource_size_t start,
 		covered = false;
 		ostart = max(res.start, p->start);
 		oend = min(res.end, p->end);
-		for_each_resource(p, dp, false) {
+		for (dp = p->child; dp; dp = __next_resource(p, dp, false)) {
 			if (!resource_overlaps(dp, &res))
 				continue;
 			is_type = (dp->flags & flags) == flags &&
-- 
2.39.2

