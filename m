Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3EAB3D994;
	Tue, 22 Oct 2024 05:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729575534; cv=none; b=rLgNpRBbPa6SwE44/cnP4WutpTHq0IWu8JSpEYSzYNHZhZvLWgvnEX9cEq8npDo3Hou29U/eIlVEk2KMu2rapTOqKV2jqD3eDWGQT5YIRCtzXORDxfuiggUwJboidRhryAzmc99aa/I5qm/6KxpPnR8KYa58pG4hXWnKG1C+eCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729575534; c=relaxed/simple;
	bh=GwTFeNoIIXjKi/aSaoQJJGcSm97Xf5Ku6yRmwVLP3O4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XjEOoEGg7a74T4sBaW2zWcBd3Fn+KfXjIMDfg0PCisM2ayHZ4GsH1AuH0xuSWiCRsqUXAPJR1OHR6evsePPT4gEgafo3osaU/tidgod0OfxeA+6ND85JtQ6Vg65ESChVrkuyP2sOPeKvLgXOrOuCtMKeCOShBZts55UoQ374Txk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e5oZkv8A; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e5oZkv8A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729575533; x=1761111533;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GwTFeNoIIXjKi/aSaoQJJGcSm97Xf5Ku6yRmwVLP3O4=;
  b=e5oZkv8Aukujk8aN2AgdYG39lyK6gEd4HN923x4zO7NGUaiWbOZskFDT
   5IEh+I8vI4vu4UhZq6ENZ0Zp7Aqo1aqCBefPs55LEtdM/zuxsrjsJKFMJ
   yJe2FLJnmRvDm8NgOgqyo5iczB6yaSO/gl5SIkD6YiVFOfJL5Adb/+TC1
   9N6CHiyMhTKF10SDWgLJv9fAB8IC50Kqo+XiMvhk+fYdYx+3/uhnChpaY
   br2syduXcF7YhUuGElcdHAp/mX2+F46WYKB4cvvqx+6ynS9lna9rB1zlt
   VDx4UxABvKCwzE2/052yv48oQ4ZXxnWksyNwE0r1rwH0qUfQMbcX6eJ/F
   g==;
X-CSE-ConnectionGUID: Yy7y1z3VRQeEupmlQSThlA==
X-CSE-MsgGUID: KiK25AZnQTyllJ2Dzto5Gw==
X-IronPort-AV: E=McAfee;i="6700,10204,11232"; a="33015503"
X-IronPort-AV: E=Sophos;i="6.11,222,1725346800"; 
   d="scan'208";a="33015503"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 22:38:52 -0700
X-CSE-ConnectionGUID: Az2Rjbx7TMykrTgOQjxVxg==
X-CSE-MsgGUID: u7bsE4q1S5GTrbYWt4vuzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="84557733"
Received: from yhuang6-mobl2.sh.intel.com ([10.238.3.32])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 22:38:48 -0700
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
Subject: [PATCH] resource: Avoid unnecessary resource tree walking in __region_intersects()
Date: Tue, 22 Oct 2024 13:38:35 +0800
Message-Id: <20241022053835.217703-1-ying.huang@intel.com>
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
for_each_resource(), which iterates not only the descendant tree, but
also subsequent sibling trees in certain scenarios.  While this
doesn't introduce bugs, it makes code hard to be understood and
potentially inefficient.

So, the patch renames next_resource() to __next_resource(), and makes
it possible to only traverse the subtree under the specified resource.
Test shows that this avoids unnecessary resource tree walking in
__region_intersects().

For the example resource tree as follows,

  X
  |
  A----D----E
  |
  B--C

if 'A' is the overlapped but unmatched resource, original kernel
iterates 'B', 'C', 'D', 'E' when it walks the descendant tree.  While
the patched kernel iterates only 'B', 'C'.

It appears even better to revise for_each_resource() to traverse the
resource subtree under "_root" only.  But that will cause "_root" to
be evaluated twice, which I don't find a good way to eliminate.

Thanks David Hildenbrand for providing a good resource tree example.

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

Changes:

RFC->v1:

- Revised patch description and comments, Thanks David and Andy!

- Link to RFC: https://lore.kernel.org/linux-mm/20241010065558.1347018-1-ying.huang@intel.com/

---
 kernel/resource.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/kernel/resource.c b/kernel/resource.c
index b730bd28b422..bd217d57fb09 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -50,15 +50,34 @@ EXPORT_SYMBOL(iomem_resource);
 
 static DEFINE_RWLOCK(resource_lock);
 
-static struct resource *next_resource(struct resource *p, bool skip_children)
+/*
+ * Return the next node of @p in pre-order tree traversal.  If
+ * @skip_children is true, skip the descendant nodes of @p in
+ * traversal.  If @p is a descendant of @subtree_root, only traverse
+ * the subtree under @subtree_root.
+ */
+static struct resource *__next_resource(struct resource *p, bool skip_children,
+					struct resource *subtree_root)
 {
 	if (!skip_children && p->child)
 		return p->child;
-	while (!p->sibling && p->parent)
+	while (!p->sibling && p->parent) {
 		p = p->parent;
+		if (p == subtree_root)
+			return NULL;
+	}
 	return p->sibling;
 }
 
+static struct resource *next_resource(struct resource *p, bool skip_children)
+{
+	return __next_resource(p, skip_children, NULL);
+}
+
+/*
+ * Traverse the whole resource tree with @_root as root in pre-order.
+ * NOTE: @_root should be the topmost node, that is, @_root->parent == NULL.
+ */
 #define for_each_resource(_root, _p, _skip_children) \
 	for ((_p) = (_root)->child; (_p); (_p) = next_resource(_p, _skip_children))
 
@@ -572,7 +591,8 @@ static int __region_intersects(struct resource *parent, resource_size_t start,
 		covered = false;
 		ostart = max(res.start, p->start);
 		oend = min(res.end, p->end);
-		for_each_resource(p, dp, false) {
+		/* Traverse the subtree under 'p'. */
+		for (dp = p->child; dp; dp = __next_resource(dp, false, p)) {
 			if (!resource_overlaps(dp, &res))
 				continue;
 			is_type = (dp->flags & flags) == flags &&
-- 
2.39.2

