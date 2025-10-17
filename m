Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935B5223710
	for <linux-cxl@vger.kernel.org>; Fri, 17 Oct 2025 22:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760739938; cv=none; b=QdTvfnP4uJhzoAHvWwiotV1nUrwejLxTgYXBNKg6+PqhMUoLucl5yu8bttp0QDeyqf/Kf9dp+4NhAnZWdXGAuMfNCRzjkn/zvX7OegZGXivkgUHKhh3kUUELpmuBc8oOEEoq+kBUCTVzZRQt9Ed2UInU83xSGFqZoYKoxg5w08c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760739938; c=relaxed/simple;
	bh=D0XiWAMkAc0ibsOSnA5Idu+CkpE3G0JwNqpcjusBh08=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OMoZSKM2V0j0ZrArAiebvDjMy1AKFc9uMEc+FWDxGebHfcTBufBd5ylt7rybT7bRBD5dA73ASJ14b1vzmGlxBx2KZkVmuqA6yi6COrPqT+q+jKVdZ+JuC4jpG5bJZOKSsnVpHv4SrrbCOqNfK/lcUWHfWV7KzIfY+dsgIzj4UPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F501C4CEE7;
	Fri, 17 Oct 2025 22:25:37 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com
Subject: [PATCH v2] cxl/region: Add support to indicate region has extended linear cache
Date: Fri, 17 Oct 2025 15:25:36 -0700
Message-ID: <20251017222536.4160645-1-dave.jiang@intel.com>
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
v2:
- Add documentation. (Alison)
---
 Documentation/ABI/testing/sysfs-bus-cxl |  8 ++++
 drivers/cxl/core/region.c               | 63 +++++++++++++++++++------
 2 files changed, 56 insertions(+), 15 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
index 6b4e8c7a963d..8d529d68dfcd 100644
--- a/Documentation/ABI/testing/sysfs-bus-cxl
+++ b/Documentation/ABI/testing/sysfs-bus-cxl
@@ -498,6 +498,14 @@ Description:
 		there is no guarantee that a free followed by an allocate
 		results in the same address being allocated.
 
+What:		/sys/bus/cxl/devices/regionZ/extended_linear_cache_size
+Date:		October, 2025
+KernelVersion:	v6.19
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(RO) The size of extended linear cache if there is one present.
+		The region 'size' attribute would reflect the total size where
+		the CXL region size plus the extended linear cache size.
 
 What:		/sys/bus/cxl/devices/regionZ/mode
 Date:		January, 2023
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index b06fee1978ba..531f790b9510 100644
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
@@ -762,14 +762,44 @@ static struct attribute *cxl_region_attrs[] = {
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
 };
 
+static const struct attribute_group *get_cxl_region_group(void)
+{
+	return &cxl_region_group;
+}
+
 static size_t show_targetN(struct cxl_region *cxlr, char *buf, int pos)
 {
 	struct cxl_region_params *p = &cxlr->params;
@@ -3478,6 +3508,9 @@ static int __construct_region(struct cxl_region *cxlr,
 		dev_warn(cxlmd->dev.parent,
 			 "Extended linear cache calculation failed rc:%d\n", rc);
 	}
+	rc = sysfs_update_group(&cxlr->dev.kobj, get_cxl_region_group());
+	if (rc)
+		return rc;
 
 	rc = insert_resource(cxlrd->res, res);
 	if (rc) {

base-commit: a4bbb493a3247ef32f6191fd8b2a0657139f8e08
-- 
2.51.0

