Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DEF73DBD5B
	for <linux-cxl@vger.kernel.org>; Thu, 25 Jun 2026 11:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782386940; cv=none; b=T3RuXtKXafUA8XZBhRylc0TwVctvpMH4gIU2krvM+t+Mah81nQv3H5lcMzkqYgfHtzbcelF8by7QxjYKdCQhb8BPWGRI8vV9aAOFUkx8yJ9B4Jr/x1tYkvaCkFF0bMhYXt4+V8frxle6iA9DHRYF7OZATw/6PiQIQwUkGEoAXVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782386940; c=relaxed/simple;
	bh=lDCI3vzKkNv0kMeo9UgEy9FHiON7O3NPicd0Dj6Khks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fpcNc83bd1LUDe/LChpi8KPv+wO7CjyHPA9jbOvc44VodncDvVywaapfOKaGUY7b93Os2M0PnlZWzwm1093TGOwJax3Sp2Zw5MAGljGU1w2yA5TMBtVCNlt2Y5s0ZVb5isCfR6z7C0gax/7ygo/+6oGRz7h/mtA31Lx6iD5Yla4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BrVXYvr6; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BrVXYvr6"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-30bf132969bso3018498eec.0
        for <linux-cxl@vger.kernel.org>; Thu, 25 Jun 2026 04:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782386938; x=1782991738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2gR7m/DSqaMQo7FqxUtVjsmVLITybnD5yvw0NvjsHn0=;
        b=BrVXYvr6Ifk360RjNgbm5D3GryUjlnm9YyKllhiSnAx2rVPTRV3XL7ZDrXtoyANX3u
         fRab5V8Z7fF1XFfcMfmW7PBuIS/5iMkVCu21sSGpBz3+hazm4PvteNx4wDXIVk7j0g/r
         lQkxDfOdKnFMkaUtXy2K4TB5BiK3TKMt1Wzy3Ye3wsivNrtU3sJqpaGwMZ6iKyqxtAGF
         xU9Uh54k9ft5x1IZu/iBI3EPYRx+KNSPNmBXYL68c1f5I6SaMfH+Rl5YT4RR1xVhFsMH
         pTjPHqbpv2sDqu7NaeQOxshfPfzC73f8gPxs0Z/JSXzVQTupLe1gvnLzRizc/t14WH5X
         a/tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782386938; x=1782991738;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2gR7m/DSqaMQo7FqxUtVjsmVLITybnD5yvw0NvjsHn0=;
        b=jxlxXLJhIHizmsdjgO5nZzhpIm+M5pv1SFM2q3eWuLAKFHhOwx8JRXrsqW4XduxKqS
         8kGCNnHXDqICgZrPCsMIMKZXrb3ioZTlRFriuOnLGAzsZaksvxLPm949P5cc8GZQ7eRg
         ID+tAA8cKFns62FGoQEFm5UH7e019NUzphRYBwsfiz4F10uwBaRW6i5lSAFDIgUc4vG5
         Rn5o3cBR9/wOmNSzXvC11KBjX7/ze3T/j5GC1uE+IPvL6Vpcx9Q+zgxjjcNQlzd/RbQ1
         R6sqoHKjPkZ0g6looVW6e8wgYkVfKLmHPXUtgaw7UqmBqt2y6O3evwjoQ8dKl8Tbo4Bq
         w9Yw==
X-Gm-Message-State: AOJu0Yy2B2oBu/lj9jyVk3Z6WPIme9mH0UfgR95bV5x/hNnH+YneVyrP
	y83Ge3O/lODz8ZQboHY1QIpBoOYeICy7S3/Tc6x4Hz3BcBIsrw5tuJ4vY4XHGw==
X-Gm-Gg: AfdE7cld+Ikoq/YDaDMLuKGop54kTj3fH2bNP5hwhCjj0VIQsgiG1fbHz5mCT3GG9Pw
	T3Bwq+qvN9Y8XByvO2TH8UgsDlUx+wsbm/KCdkkkzpeGO9w8aVfaiKcyTz3VbOrHSnw8YfZyLIk
	+MZlu8mUF0kbz0N2t4HniKEU8UIG2Xzhy4FeMGRpvMPjVKGkcFFmhnp9ACEUOmI6qf2XjjZDIRc
	R2g77Xq8bQEuBy8//MXnxBxSlCeoooxuY81L5PzdJJL2xvED39oE6hixZNHiwWX1bMSZLqAAv/H
	/kM3nxk9l56rcXe1EpW4ebxmbqmAVpmvA+Qx3NROB5NCfFmZzh+3vwXRuzQJjzYA9LtTQ2uxZ+T
	JoOhmT4t1c2SQ4tVbeJpPbi/I+3+ZqUQMoSpMuRoyA1x3xEMM1cNOpnbRsnd7EGShoNV9TU2Fgw
	N6DtQG+ZgOb+ZUVYytCMRF9o6iw39pxbDLG3/NqIodM/UW1iLRwuAilVrZzZ6Z3g/NdfDIgrqFv
	4gpUO4=
X-Received: by 2002:a05:7300:2303:b0:307:934e:da79 with SMTP id 5a478bee46e88-30c84e27462mr2850884eec.34.1782386937520;
        Thu, 25 Jun 2026 04:28:57 -0700 (PDT)
Received: from AnisaLaptop.localdomain (c-73-170-217-179.hsd1.ca.comcast.net. [73.170.217.179])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c7cab08c2sm8744614eec.29.2026.06.25.04.28.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 04:28:57 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
To: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: nvdimm@lists.linux.dev,
	Dan Williams <djbw@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>,
	Alison Schofield <alison.schofield@intel.com>,
	John Groves <John@Groves.net>,
	Gregory Price <gourry@gourry.net>,
	Anisa Su <anisa.su@samsung.com>,
	Fan Ni <nifan.cxl@gmail.com>
Subject: [PATCH v11 20/31] cxl/region/extent: Expose dc_extent information in sysfs
Date: Thu, 25 Jun 2026 04:04:57 -0700
Message-ID: <20260625112638.550691-21-anisa.su@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260625112638.550691-1-anisa.su@samsung.com>
References: <20260625112638.550691-1-anisa.su@samsung.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Ira Weiny <iweiny@kernel.org>

Extent information can be helpful to the user to coordinate memory
usage with the external orchestrator and FM.

Expose the details of each dc_extent by creating the following sysfs
entries.

	/sys/bus/cxl/devices/dax_regionX/extentX.Y
	/sys/bus/cxl/devices/dax_regionX/extentX.Y/offset
	/sys/bus/cxl/devices/dax_regionX/extentX.Y/length
	/sys/bus/cxl/devices/dax_regionX/extentX.Y/uuid

Each dc_extent surfaces as its own extentX.Y device under the parent
dax_region.  offset and length describe that dc_extent's HPA range,
not an aggregate bounding box across the containing tagged
allocation — so when a tagged allocation has multiple
DPA-discontiguous extents, each is reported with its own offset and
length.  uuid is the tag identifying the containing allocation; it
is shared across dc_extents that belong to the same tagged
allocation and is hidden for untagged extents.

Based on an original patch by Navneet Singh.

Signed-off-by: Ira Weiny <iweiny@kernel.org>
Signed-off-by: Anisa Su <anisa.su@samsung.com>
Reviewed-by: Jonathan Cameron <jic23@kernel.org>
Reviewed-by: Fan Ni <nifan.cxl@gmail.com>
Tested-by: Fan Ni <nifan.cxl@gmail.com>

---
Changes:
1. Bump kver to 7.3 and date to June 2026
---
 Documentation/ABI/testing/sysfs-bus-cxl | 36 ++++++++++++++++
 drivers/cxl/core/extent.c               | 56 +++++++++++++++++++++++++
 2 files changed, 92 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
index 00b98bbe0ff3..2a3817cc6eef 100644
--- a/Documentation/ABI/testing/sysfs-bus-cxl
+++ b/Documentation/ABI/testing/sysfs-bus-cxl
@@ -661,3 +661,39 @@ Description:
 		The count is persistent across power loss and wraps back to 0
 		upon overflow. If this file is not present, the device does not
 		have the necessary support for dirty tracking.
+
+
+What:		/sys/bus/cxl/devices/dax_regionX/extentX.Y/offset
+Date:		June, 2026
+KernelVersion:	v7.3
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(RO) [For Dynamic Capacity regions only] Users can use the
+		extent information to create DAX devices on specific extents.
+		This is done by creating and destroying DAX devices in specific
+		sequences and looking at the mappings created.  Extent offset
+		within the region.
+
+
+What:		/sys/bus/cxl/devices/dax_regionX/extentX.Y/length
+Date:		June, 2026
+KernelVersion:	v7.3
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(RO) [For Dynamic Capacity regions only] Users can use the
+		extent information to create DAX devices on specific extents.
+		This is done by creating and destroying DAX devices in specific
+		sequences and looking at the mappings created.  Extent length
+		within the region.
+
+
+What:		/sys/bus/cxl/devices/dax_regionX/extentX.Y/uuid
+Date:		June, 2026
+KernelVersion:	v7.3
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(RO) [For Dynamic Capacity regions only] Users can use the
+		extent information to create DAX devices on specific extents.
+		This is done by creating and destroying DAX devices in specific
+		sequences and looking at the mappings created.  UUID of this
+		extent.
diff --git a/drivers/cxl/core/extent.c b/drivers/cxl/core/extent.c
index 36be56ca1097..69c993cdd558 100644
--- a/drivers/cxl/core/extent.c
+++ b/drivers/cxl/core/extent.c
@@ -6,6 +6,61 @@
 
 #include "core.h"
 
+static ssize_t offset_show(struct device *dev, struct device_attribute *attr,
+			   char *buf)
+{
+	struct dc_extent *dc_extent = to_dc_extent(dev);
+
+	return sysfs_emit(buf, "%#llx\n", dc_extent->hpa_range.start);
+}
+static DEVICE_ATTR_RO(offset);
+
+static ssize_t length_show(struct device *dev, struct device_attribute *attr,
+			   char *buf)
+{
+	struct dc_extent *dc_extent = to_dc_extent(dev);
+	u64 length = range_len(&dc_extent->hpa_range);
+
+	return sysfs_emit(buf, "%#llx\n", length);
+}
+static DEVICE_ATTR_RO(length);
+
+static ssize_t uuid_show(struct device *dev, struct device_attribute *attr,
+			 char *buf)
+{
+	struct dc_extent *dc_extent = to_dc_extent(dev);
+
+	return sysfs_emit(buf, "%pUb\n", &dc_extent->group->uuid);
+}
+static DEVICE_ATTR_RO(uuid);
+
+static struct attribute *dc_extent_attrs[] = {
+	&dev_attr_offset.attr,
+	&dev_attr_length.attr,
+	&dev_attr_uuid.attr,
+	NULL
+};
+
+static umode_t dc_extent_visible(struct kobject *kobj,
+				 struct attribute *a, int n)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct dc_extent *dc_extent = to_dc_extent(dev);
+
+	if (a == &dev_attr_uuid.attr &&
+	    uuid_is_null(&dc_extent->group->uuid))
+		return 0;
+
+	return a->mode;
+}
+
+static const struct attribute_group dc_extent_attribute_group = {
+	.attrs = dc_extent_attrs,
+	.is_visible = dc_extent_visible,
+};
+
+__ATTRIBUTE_GROUPS(dc_extent_attribute);
+
 
 static void cxled_release_extent(struct cxl_endpoint_decoder *cxled,
 				 struct dc_extent *dc_extent)
@@ -99,6 +154,7 @@ static void dc_extent_release(struct device *dev)
 static const struct device_type dc_extent_type = {
 	.name = "extent",
 	.release = dc_extent_release,
+	.groups = dc_extent_attribute_groups,
 };
 
 bool is_dc_extent(struct device *dev)
-- 
2.43.0

