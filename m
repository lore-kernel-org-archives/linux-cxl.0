Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614C83D5672;
	Wed,  1 Apr 2026 12:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775047815; cv=pass; b=VxJshFMp5+BJX2Xu8H7StRd19xB+f0uQn7muYC+B+6FgbXQ/Molk4OU2G9S0EAxDiHWb1f0FCB/YHDEjZjc/FRddXKnYTPM2vQdwKiDorMjyJDmakRVBMD9T/cPcwmFbwFbYnus1cIOdHtvMyStb0xkou2oQ01ybOCdg3nBJ76o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775047815; c=relaxed/simple;
	bh=0TpE//NDba80R4x6HTf+IbDhLdY03k7TyyZ9iXEo7gY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tivdjupVx0+gicYwjQOSFdNeIUASDXpQxe97m7IOcOhRvx3g0NQL2i7Ok1bLmpbHa6hntXdaJWNXoOLdWQzjS3trRqrczkwm12Cu+5xeBiZhXNqslEx50TRJbqNupHMGHgHrgHbe52sDLOSM7zX2BEVDv3SRfsnCA7S/05kVvKM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=FxO+tegF; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="FxO+tegF"
ARC-Seal: i=1; a=rsa-sha256; t=1775047802; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=MlzlXCST0qsPAlVJC0QZHZcjlfn+xdtA3xRG/BB4T8pE3so9UlsDvh9JJk3m7sm6p742POrNR8lLOUK8KefZMdCDtVics13p75mFdA4ewfYW9miis5vmgZSNA6pjprCNHvgYbzxGqPt9gLJ7zdGudNDTkz1a1yXuYDkhhmVolC0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1775047802; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ImFDoJmzDoQLqXxX/rG+/JQkrJ03GR3mLWa87iyt7ik=; 
	b=TZ4zPkDsDqHhwG8Ad0UWQ8BOqT6GaxOVagfCrqTSHL0PdHbem0km/nTVJqXAORTN/cNWMDrlzfdEKKuz4dUwqWpqAtSpHnAsc7zGu0vqaI5X7LHHS/4gyPr7df+x9exok4oKp6MuuLYMAeaYaH3DeYFkq0jJEQw7mKLS/r3JxRg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1775047802;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=ImFDoJmzDoQLqXxX/rG+/JQkrJ03GR3mLWa87iyt7ik=;
	b=FxO+tegFHxK9BghGqEw/wE2K8PyPN/aud6kYdWum0ZahOkPaZgL173lpjrObBW5g
	uNSMYFRi6vo6Dwg4b3cr2ZfCu0T/ul+E8DULMBX3iLp6zxNm3rV1WdJLGxMKj1gToUO
	KmzemaQVgsOkU3kwvEvpZbKSYKLBem9azdGbA9Cw=
Received: by mx.zohomail.com with SMTPS id 17750477992641011.3673642657153;
	Wed, 1 Apr 2026 05:49:59 -0700 (PDT)
From: Li Ming <ming.li@zohomail.com>
To: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com
Cc: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ming.li@zohomail.com,
	Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v2 1/1] cxl/region: Add a region sysfs interface for region lock status
Date: Wed,  1 Apr 2026 20:49:51 +0800
Message-ID: <20260401124951.1290041-1-ming.li@zohomail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: rr08011228dee731c24cf1f4e0801a025b0000696ee9cea4e247fc3803a5e92da00fa0efedaf5b19106c04639c:zu08011227c905e98434fe6bc3104259eb0000a0aa3097f9462d5486f734fcc3fccc45acab3ff080741b7cc4:rf0801122dcbb711b7e6d653d2e969f4f000000e3bcf364736cda31a494c19dbeccdb0448a96d1c52348142ee072980c2e8e:ZohoMail
X-ZohoMailClient: External

If a region is created on a root decoder with Fixed Device Confiuration
attribute, the region will be locked, meaning region destroy
operations are not permitted. CXL region driver returns -EPERM for
region destroy operations.

Although the locked status of the corresponding root decoder implies the
region is also locked, exposing the region lock status directly to
userspace improves usability for users who may not be aware of this
relationship.

Signed-off-by: Li Ming <ming.li@zohomail.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Alejandro Lucero <alucerop@amd.com>
---
v2:
* Add more info to the interface description. (Alison)
---
 Documentation/ABI/testing/sysfs-bus-cxl | 13 +++++++++++++
 drivers/cxl/core/region.c               | 17 +++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
index c80a1b5a03db..16a9b3d2e2c0 100644
--- a/Documentation/ABI/testing/sysfs-bus-cxl
+++ b/Documentation/ABI/testing/sysfs-bus-cxl
@@ -508,6 +508,19 @@ Description:
 		(RO) The size of extended linear cache, if there is an extended
 		linear cache. Otherwise the attribute will not be visible.
 
+
+What:		/sys/bus/cxl/devices/regionZ/locked
+Date:		Mar, 2026
+KernelVersion:	v7.1
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(RO) The CXL driver has the capability to lock a region based on
+		a BIOS or platform dependent configuration. Regions created as
+		locked are never permitted to be destroyed. Resets to participating
+		decoders will not result in a region destroy and will not free the
+		decoder resources.
+
+
 What:		/sys/bus/cxl/devices/regionZ/mode
 Date:		January, 2023
 KernelVersion:	v6.3
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 42874948b589..95d81816008e 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -767,6 +767,22 @@ static ssize_t extended_linear_cache_size_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(extended_linear_cache_size);
 
+static ssize_t locked_show(struct device *dev,
+			   struct device_attribute *attr,
+			   char *buf)
+{
+	struct cxl_region *cxlr = to_cxl_region(dev);
+	int rc;
+
+	ACQUIRE(rwsem_read_intr, rwsem)(&cxl_rwsem.region);
+	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &rwsem)))
+		return rc;
+
+	rc = test_bit(CXL_REGION_F_LOCK, &cxlr->flags);
+	return sysfs_emit(buf, "%d\n", rc);
+}
+static DEVICE_ATTR_RO(locked);
+
 static struct attribute *cxl_region_attrs[] = {
 	&dev_attr_uuid.attr,
 	&dev_attr_commit.attr,
@@ -776,6 +792,7 @@ static struct attribute *cxl_region_attrs[] = {
 	&dev_attr_size.attr,
 	&dev_attr_mode.attr,
 	&dev_attr_extended_linear_cache_size.attr,
+	&dev_attr_locked.attr,
 	NULL,
 };
 
-- 
2.43.0

