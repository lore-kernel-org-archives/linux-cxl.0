Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4631BA33
	for <linux-cxl@vger.kernel.org>; Wed,  5 Mar 2025 02:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741141376; cv=none; b=bXxkL0FgR/tTv7rZRKMbcWiTFFujmEtAkPY50IisNjLBsFn2IYIisilWWCqiODsiCO3va5WJag6DSAQCB8NIU5iQi7YLFQkcfMImjpQlHUmFACPjgr/wLSTHv/dktqJqIWIplekHKA0vSdN3Ez6SNp44qGmAi2lNXBsls3Ve1XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741141376; c=relaxed/simple;
	bh=ERc43QGGlLAUbjL3VRXvHJ6lgsMfQrtDwlm2qBy2Tis=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=jCimyTFWFNlLVJNypHM2J5C2rUbP+jkVh92K8le9zA5/ZmdWV+IXxA/P6G9Bh/oOS0MQ8VnO53hQCMyFGnueKOaSf3f0lOuA2YJyQKgPvV+NdOTwNr4Hd5ZI6ibrWPyh1AMYSwP6rS1iSES0e2PM2vN4Jkxv8oMkprD9QTsIZxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hACdYslj; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hACdYslj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741141375; x=1772677375;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ERc43QGGlLAUbjL3VRXvHJ6lgsMfQrtDwlm2qBy2Tis=;
  b=hACdYsljECV3Y6wheDDCKQlA/a7v/p9UXSZ63/sVykzDXuUzkpX6kgCg
   PFdPCoH+FL8XTyISvB7VhX1MBI2y1sGswOMl57zn03ICm5iUGqIW0n3ER
   aMHF+p2ZLEjJeFtjZ6n0Xosw7R0scSm+qMiSi1DOYq+a/PEauhJ0bOyj9
   QtRuaniOVRz5ViFeF99Dr/cbDcjgXGtuFbAHvVDoVr9FddckGg05kH8ph
   XwyjYfTaoXIhk1Eb00kyrLb1fVxnzGua/k8NloMC6snUsx9B0QYZZIQb5
   GjsIEHSUEX41yUvpQVrgohb6pxF/u/Zkwnxh/DFxuWlLiAc8v9/hamOi/
   w==;
X-CSE-ConnectionGUID: eu/pl5sVTeWrEoL+OUqaHg==
X-CSE-MsgGUID: ikhAgKqwSgy2QrMi9sgkWA==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="46011368"
X-IronPort-AV: E=Sophos;i="6.14,221,1736841600"; 
   d="scan'208";a="46011368"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 18:22:54 -0800
X-CSE-ConnectionGUID: 1j4c1QX6SzS0QgNt1+Llew==
X-CSE-MsgGUID: pSOTPEz4SOS7Gnef05Gpnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,221,1736841600"; 
   d="scan'208";a="118567719"
Received: from rchatre-mobl4.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.125.109.141])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 18:22:54 -0800
Subject: [PATCH] resource: Fix resource leak in get_free_mem_region()
From: Dan Williams <dan.j.williams@intel.com>
To: akpm@linux-foundation.org
Cc: Li Zhijian <lizhijian@fujitsu.com>, linux-cxl@vger.kernel.org,
 Jonathan.Cameron@huawei.com, andriy.shevchenko@linux.intel.com,
 mika.westerberg@linux.intel.com, ilpo.jarvinen@linux.intel.com,
 bhelgaas@google.com, huang.ying.caritas@gmail.com
Date: Tue, 04 Mar 2025 18:22:53 -0800
Message-ID: <174114125011.1367354.2670882864492961789.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Li reports a kmemleak detection in get_free_mem_region() error unwind
path:

  cxl region2: HPA allocation error (-34) for size:0x0000000100000000 in CXL Window 0 [mem 0xa90000000-0x1a8fffffff flags 0x200]
  kmemleak: 1 new suspected memory leaks (see /sys/kernel/debug/kmemleak)

     __kmalloc_cache_noprof+0x28c/0x350
     get_free_mem_region+0x45/0x380
     alloc_free_mem_region+0x1d/0x30
     size_store+0x180/0x290 [cxl_core]
     kernfs_fop_write_iter+0x13f/0x1e0
     vfs_write+0x37c/0x540
     ksys_write+0x68/0xe0
     do_syscall_64+0x6e/0x190
     entry_SYSCALL_64_after_hwframe+0x76/0x7e

It turns out it not only leaks memory, also fails to unwind changes to
the resource tree (@base, usually iomem_resource).

Fix this by consolidating the devres and devm paths into just devres,
and move those details to a wrapper function. So now
__get_free_mem_region() only needs to worry about alloc_resource()
unwinding, and the devres failure path is resolved before touching the
resource tree.

Fixes: 14b80582c43e ("resource: Introduce alloc_free_mem_region()")
Reported-by: Li Zhijian <lizhijian@fujitsu.com>
Closes: http://lore.kernel.org/20250304043415.610286-1-lizhijian@fujitsu.com
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---

Andrew, here is a replacement patch for
resource-fix-resource-leak-in-get_free_mem_region.patch in your tree. It
addresses missing calls to remove_resource() in addition to
free_resource() in the error path.

 kernel/resource.c |  105 ++++++++++++++++++++++++++++++-----------------------
 1 file changed, 60 insertions(+), 45 deletions(-)

diff --git a/kernel/resource.c b/kernel/resource.c
index 12004452d999..80d10714cb38 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -172,6 +172,8 @@ static void free_resource(struct resource *res)
 		kfree(res);
 }
 
+DEFINE_FREE(free_resource, struct resource *, if (_T) free_resource(_T))
+
 static struct resource *alloc_resource(gfp_t flags)
 {
 	return kzalloc(sizeof(struct resource), flags);
@@ -1631,17 +1633,29 @@ void devm_release_resource(struct device *dev, struct resource *new)
 }
 EXPORT_SYMBOL(devm_release_resource);
 
+/*
+ * The GFR_REQUEST_REGION case performs a request_region() to be paired
+ * with release_region(). The alloc_free_mem_region() path performs
+ * insert_resource() to be paired with {remove,free}_resource(). The
+ * @res member differentiates the 2 cases.
+ */
 struct region_devres {
 	struct resource *parent;
 	resource_size_t start;
 	resource_size_t n;
+	struct resource *res;
 };
 
 static void devm_region_release(struct device *dev, void *res)
 {
 	struct region_devres *this = res;
 
-	__release_region(this->parent, this->start, this->n);
+	if (!this->res) {
+		__release_region(this->parent, this->start, this->n);
+	} else {
+		remove_resource(this->res);
+		free_resource(this->res);
+	}
 }
 
 static int devm_region_match(struct device *dev, void *res, void *match_data)
@@ -1908,43 +1922,19 @@ static resource_size_t gfr_next(resource_size_t addr, resource_size_t size,
 	return addr + size;
 }
 
-static void remove_free_mem_region(void *_res)
-{
-	struct resource *res = _res;
-
-	if (res->parent)
-		remove_resource(res);
-	free_resource(res);
-}
-
 static struct resource *
-get_free_mem_region(struct device *dev, struct resource *base,
-		    resource_size_t size, const unsigned long align,
-		    const char *name, const unsigned long desc,
-		    const unsigned long flags)
+__get_free_mem_region(struct resource *base, resource_size_t size,
+		      const unsigned long align, const char *name,
+		      const unsigned long desc, const unsigned long flags)
 {
 	resource_size_t addr;
-	struct resource *res;
-	struct region_devres *dr = NULL;
 
 	size = ALIGN(size, align);
 
-	res = alloc_resource(GFP_KERNEL);
+	struct resource *res __free(free_resource) = alloc_resource(GFP_KERNEL);
 	if (!res)
 		return ERR_PTR(-ENOMEM);
 
-	if (dev && (flags & GFR_REQUEST_REGION)) {
-		dr = devres_alloc(devm_region_release,
-				sizeof(struct region_devres), GFP_KERNEL);
-		if (!dr) {
-			free_resource(res);
-			return ERR_PTR(-ENOMEM);
-		}
-	} else if (dev) {
-		if (devm_add_action_or_reset(dev, remove_free_mem_region, res))
-			return ERR_PTR(-ENOMEM);
-	}
-
 	write_lock(&resource_lock);
 	for (addr = gfr_start(base, size, align, flags);
 	     gfr_continue(base, addr, align, flags);
@@ -1958,17 +1948,9 @@ get_free_mem_region(struct device *dev, struct resource *base,
 						    size, name, 0))
 				break;
 
-			if (dev) {
-				dr->parent = &iomem_resource;
-				dr->start = addr;
-				dr->n = size;
-				devres_add(dev, dr);
-			}
-
 			res->desc = desc;
 			write_unlock(&resource_lock);
 
-
 			/*
 			 * A driver is claiming this region so revoke any
 			 * mappings.
@@ -1985,25 +1967,58 @@ get_free_mem_region(struct device *dev, struct resource *base,
 			 * Only succeed if the resource hosts an exclusive
 			 * range after the insert
 			 */
-			if (__insert_resource(base, res) || res->child)
+			if (__insert_resource(base, res))
+				break;
+			if (res->child) {
+				remove_resource(res);
 				break;
+			}
 
 			write_unlock(&resource_lock);
 		}
 
-		return res;
+		return no_free_ptr(res);
 	}
 	write_unlock(&resource_lock);
 
-	if (flags & GFR_REQUEST_REGION) {
-		free_resource(res);
-		devres_free(dr);
-	} else if (dev)
-		devm_release_action(dev, remove_free_mem_region, res);
-
 	return ERR_PTR(-ERANGE);
 }
 
+static struct resource *
+get_free_mem_region(struct device *dev, struct resource *base,
+		    resource_size_t size, const unsigned long align,
+		    const char *name, const unsigned long desc,
+		    const unsigned long flags)
+{
+
+	struct region_devres *dr __free(kfree) = NULL;
+	struct resource *res;
+
+	if (dev) {
+		dr = devres_alloc(devm_region_release,
+				  sizeof(struct region_devres), GFP_KERNEL);
+		if (!dr)
+			return ERR_PTR(-ENOMEM);
+	}
+
+	res = __get_free_mem_region(base, size, align, name, desc, flags);
+
+	if (IS_ERR(res) || !dr)
+		return res;
+
+	dr->parent = base;
+	dr->start = res->start;
+	dr->n = resource_size(res);
+
+	/* See 'struct region_devres' definition for details */
+	if ((flags & GFR_REQUEST_REGION) == 0)
+		dr->res = res;
+
+	devres_add(dev, no_free_ptr(dr));
+
+	return res;
+}
+
 /**
  * devm_request_free_mem_region - find free region for device private memory
  *

