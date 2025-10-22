Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E201D9346
	for <linux-cxl@vger.kernel.org>; Wed, 22 Oct 2025 20:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761165054; cv=none; b=nDQqIo/vF0vXNoPUAT+SrXeN7cUn9ksILl55w+0iiUX+mkq3WY3pwFrajXb29egvwoqDNhfTtUbX6r0oUXeXp8w3DdOuCW9+2fK59T3Vakoaia/JHpRJp2/osj98bO5hP113bgvZ33MuIA6rslY5BmbEY2DkYjhOjawsVc4c01c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761165054; c=relaxed/simple;
	bh=CvqS6SRTanr5CKK6JUSKTMSvK38Kday3sqZHWaI9zB4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IuFpC47H3P4mJa6l5AJ884RrmdYarhX9NN/1ya4r6fi7u5YvIApBYZLIdu6P22yznBPOr4PSsM2vclbmqHgGUJQ1x0QdDs4SocozxXaNsyakXLipDyLitEvEAK7j9KP8QiipZGCzxSAyWlU3xkRrIbLcE+I0fmKkgGCeyCjwuoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74DACC4CEE7;
	Wed, 22 Oct 2025 20:30:53 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com
Subject: [PATCH v3] cxl/region: Add support to indicate region has extended linear cache
Date: Wed, 22 Oct 2025 13:30:52 -0700
Message-ID: <20251022203052.4078527-1-dave.jiang@intel.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a region sysfs attribute to show the size of the extended linear
cache if there is any. The attribute is invisible when the cache
size is 0, which indicates it does not exist.

Moved the cxl_region_visible() location in order to pick up the
new sysfs attribute definition.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
v3:
- refine documentation (Benjamin)
- Drop helper function to get region group. (Benjamin)
- Add blank line for better readability. (Benjamin)
---
 Documentation/ABI/testing/sysfs-bus-cxl | 11 ++++-
 drivers/cxl/core/region.c               | 59 ++++++++++++++++++-------
 2 files changed, 54 insertions(+), 16 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
index 6b4e8c7a963d..c6abce129137 100644
--- a/Documentation/ABI/testing/sysfs-bus-cxl
+++ b/Documentation/ABI/testing/sysfs-bus-cxl
@@ -496,8 +496,17 @@ Description:
 		changed, only freed by writing 0. The kernel makes no guarantees
 		that data is maintained over an address space freeing event, and
 		there is no guarantee that a free followed by an allocate
-		results in the same address being allocated.
+		results in the same address being allocated. If extended linear
+		cache is present, the size indicates extended linear cach size
+		plus the CXL region size.
 
+What:		/sys/bus/cxl/devices/regionZ/extended_linear_cache_size
+Date:		October, 2025
+KernelVersion:	v6.19
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(RO) The size of extended linear cache, if there is an extended
+		linear cache. Otherwise the attribute will not be visible.
 
 What:		/sys/bus/cxl/devices/regionZ/mode
 Date:		January, 2023
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index b06fee1978ba..095f5dcd17a1 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -461,21 +461,6 @@ static ssize_t commit_show(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RW(commit);
 
-static umode_t cxl_region_visible(struct kobject *kobj, struct attribute *a,
-				  int n)
-{
-	struct device *dev = kobj_to_dev(kobj);
-	struct cxl_region *cxlr = to_cxl_region(dev);
-
-	/*
-	 * Support tooling that expects to find a 'uuid' attribute for all
-	 * regions regardless of mode.
-	 */
-	if (a == &dev_attr_uuid.attr && cxlr->mode != CXL_PARTMODE_PMEM)
-		return 0444;
-	return a->mode;
-}
-
 static ssize_t interleave_ways_show(struct device *dev,
 				    struct device_attribute *attr, char *buf)
 {
@@ -754,6 +739,21 @@ static ssize_t size_show(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RW(size);
 
+static ssize_t extended_linear_cache_size_show(struct device *dev,
+					       struct device_attribute *attr,
+					       char *buf)
+{
+	struct cxl_region *cxlr = to_cxl_region(dev);
+	struct cxl_region_params *p = &cxlr->params;
+	ssize_t rc;
+
+	ACQUIRE(rwsem_read_intr, rwsem)(&cxl_rwsem.region);
+	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &rwsem)))
+		return rc;
+	return sysfs_emit(buf, "%#llx\n", p->cache_size);
+}
+static DEVICE_ATTR_RO(extended_linear_cache_size);
+
 static struct attribute *cxl_region_attrs[] = {
 	&dev_attr_uuid.attr,
 	&dev_attr_commit.attr,
@@ -762,9 +762,34 @@ static struct attribute *cxl_region_attrs[] = {
 	&dev_attr_resource.attr,
 	&dev_attr_size.attr,
 	&dev_attr_mode.attr,
+	&dev_attr_extended_linear_cache_size.attr,
 	NULL,
 };
 
+static umode_t cxl_region_visible(struct kobject *kobj, struct attribute *a,
+				  int n)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct cxl_region *cxlr = to_cxl_region(dev);
+
+	/*
+	 * Support tooling that expects to find a 'uuid' attribute for all
+	 * regions regardless of mode.
+	 */
+	if (a == &dev_attr_uuid.attr && cxlr->mode != CXL_PARTMODE_PMEM)
+		return 0444;
+
+	/*
+	 * Don't dispaly extended linear cache attribute if there is no
+	 * extended linear cache.
+	 */
+	if (a == &dev_attr_extended_linear_cache_size.attr &&
+	    cxlr->params.cache_size == 0)
+		return 0;
+
+	return a->mode;
+}
+
 static const struct attribute_group cxl_region_group = {
 	.attrs = cxl_region_attrs,
 	.is_visible = cxl_region_visible,
@@ -3479,6 +3504,10 @@ static int __construct_region(struct cxl_region *cxlr,
 			 "Extended linear cache calculation failed rc:%d\n", rc);
 	}
 
+	rc = sysfs_update_group(&cxlr->dev.kobj, &cxl_region_group);
+	if (rc)
+		return rc;
+
 	rc = insert_resource(cxlrd->res, res);
 	if (rc) {
 		/*

base-commit: 211ddde0823f1442e4ad052a2f30f050145ccada
-- 
2.51.0

