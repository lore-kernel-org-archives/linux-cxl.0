Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD17F1CEADB
	for <linux-cxl@vger.kernel.org>; Sat, 11 Apr 2026 01:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775871647; cv=none; b=qur4bYwyJS8QI2UiZx9DiKfEqXG0NZT5j28H6y5KV1MXM6me7k3KhH4Dh0GeYG94JZAnr/U3uPMsyuthXqmd0S/lqSr5IhTjEzIQP6iSlxSEtIWwubF4syFl8eoy+MvyNrQPbOV48U7bMfeTNNcJ5DQSFX0gDP2Km1S8cQyHCEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775871647; c=relaxed/simple;
	bh=QHn7ieEid47WTEFJ2WMdYtqFPw9lv7IgPPIAjVaHAjw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RQiMjb1L9LNvFBRa8/l/bIolGKWpPEQ+7irbWMgt2Y1hlbrAHff2leSoufwm/UVqMqaJeAVPZEnJBFm1QS5qEuhdLfwrzcodf0G8FZ/IkAW565qaYHrrR8AHgcsLvMmvE9RFuO0RPti1fxq2WGS+L+fHs/8i/R4KryHgUijMTF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KrG5hauT; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KrG5hauT"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-793fdbb8d3aso30629507b3.3
        for <linux-cxl@vger.kernel.org>; Fri, 10 Apr 2026 18:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775871644; x=1776476444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7hMbFzbKyATSd8MEYQXDyg3tLh7e5iSg6PU3CPCFlOg=;
        b=KrG5hauTNIjOpn2VxvUiUKrL9cnSJmuS7BsHi3Io/Qpgi0OXvY71QHRG/quouVQA3v
         hHz/JCGXtUaorFwjlwQHURBO8Ru9d148nC5dbpwlgj8CQWhH9lh9oNAd14CTNmC9fRvC
         pFYV/kNdQdURyrgn/4Czr4RjyWIUttyBNjJ5AOdED60zocfKqWzql1HQwh2t88ptYUPl
         JD/mpiIlYRz5vF/FnElW2FJYPooF+IlfsLG9HGA5eeX5Okz0fuUMJ4BrOF+usVhIktvT
         GcX9Cv8ROvDa/YejkMFDZebdwFXCCi2CH2ALE8ZJJ1Nf5eDFRVAJq0BDjg9zYRxAHsVe
         QAdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775871644; x=1776476444;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7hMbFzbKyATSd8MEYQXDyg3tLh7e5iSg6PU3CPCFlOg=;
        b=slIanZoFKU2TAcov07507/fSKDrf6dhMHDz1eltGFM/vfLTLPJkiRZXUW9ygXAWJe0
         YABeqfnHvAMKcEQkU5TU9DHn6GsPqJqZSmB8HahhPpltRxq+6picJXf+Jjf+cAz7EUct
         mvM9b5GAGIa8s7GMrZNPzOQ/FNWnmVwiVgvondSjQ/vrXUv91aEXO3u4esZzHXx0olRE
         tOxl7hHSNogH6IlszFIjWogJHKwyFKplBxr8VDoq803+Nm1TKhqmUsMhdz9uh5h9pku1
         3vBExDQ6PTu1ECvLtS91TstLtKoPpzzerx+eRLsCpNa3xyomafFM0nFLWnbSs6L33T4X
         UyIg==
X-Gm-Message-State: AOJu0Yy7yRLvfye4o2bgMsBWLC8YwA7ixfrRmpVUkO7p2aIirmZWoVwT
	1j60x0Av0PBRd93YWU3g0keYgP+PeUzbXdwQBFr8IGjR7SPKODaA8cnfB5yY+g==
X-Gm-Gg: AeBDieshXB8MJILgAW91ZsSeYEOlozMhh6HkU/wsUrCTtf2mGler+gzY+9CnduwSdb/
	aSghJMLqIIe3uyNHWE1b+B6wDcTttMREq6C2L3aRZZtuocmx3jBGCVsK/7lGgid5KxJjttphCEQ
	RfmVDr64Vri00qsvL0BFpKpQ+OvNCqN9vdBO5DBSvdgak78LZFi2uXXQ01maUWwWGNEHfKTUeMs
	t9Uh5M7T0HaZZzuYfd08WCvdMn2HNLF50J1ykqUwBEezofWE3dVaLAxsgsFdU/L8VjV8dnVkZ6D
	2pLi6FenzXVA4XNdba2Desju76sgDH93f3dU5XFgEOAkUQwLVbPrXY1K/SINO3CaBsmcQUhmWcQ
	JOuOr3xlPH4oCRimDLHznyoJnm46v55dfnUSvtHSeiaDTDPH8X0giI4O0NyASB1dKXQ0AchItUz
	QhKiUMiEVOaWW9lmS3c5CQ8l+cI9L6nXXBgB8rnbEOzw==
X-Received: by 2002:a05:690c:a041:b0:7ae:7e57:440a with SMTP id 00721157ae682-7af6ee47eaamr44626557b3.8.1775871644573;
        Fri, 10 Apr 2026 18:40:44 -0700 (PDT)
Received: from 4470NRD-ASU.ssi.samsung.com ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7af3fa06595sm21690547b3.40.2026.04.10.18.40.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 18:40:44 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
To: linux-cxl@vger.kernel.org
Cc: john@groves.net,
	dave.jiang@intel.com,
	gourry@gourry.net,
	dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Fan Ni <fan.ni@samsung.com>
Subject: [PATCH 13/20] cxl/region/extent: Expose region extent information in sysfs
Date: Fri, 10 Apr 2026 18:23:08 -0700
Message-ID: <20260411013958.47422-14-anisa.su@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260411013958.47422-1-anisa.su@samsung.com>
References: <20260411013958.47422-1-anisa.su@samsung.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ira Weiny <ira.weiny@intel.com>

Extent information can be helpful to the user to coordinate memory usage
with the external orchestrator and FM.

Expose the details of region extents by creating the following
sysfs entries.

        /sys/bus/cxl/devices/dax_regionX/extentX.Y
        /sys/bus/cxl/devices/dax_regionX/extentX.Y/offset
        /sys/bus/cxl/devices/dax_regionX/extentX.Y/length
        /sys/bus/cxl/devices/dax_regionX/extentX.Y/tag

Based on an original patch by Navneet Singh.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Fan Ni <fan.ni@samsung.com>
Tested-by: Fan Ni <fan.ni@samsung.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes:
[anisa: rebase]
---
 Documentation/ABI/testing/sysfs-bus-cxl | 36 +++++++++++++++
 drivers/cxl/core/extent.c               | 58 +++++++++++++++++++++++++
 2 files changed, 94 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
index 3080aef9ad67..38cf0a2894b9 100644
--- a/Documentation/ABI/testing/sysfs-bus-cxl
+++ b/Documentation/ABI/testing/sysfs-bus-cxl
@@ -661,3 +661,39 @@ Description:
 		The count is persistent across power loss and wraps back to 0
 		upon overflow. If this file is not present, the device does not
 		have the necessary support for dirty tracking.
+
+
+What:		/sys/bus/cxl/devices/dax_regionX/extentX.Y/offset
+Date:		May, 2025
+KernelVersion:	v6.16
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
+Date:		May, 2025
+KernelVersion:	v6.16
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
+Date:		May, 2025
+KernelVersion:	v6.16
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(RO) [For Dynamic Capacity regions only] Users can use the
+		extent information to create DAX devices on specific extents.
+		This is done by creating and destroying DAX devices in specific
+		sequences and looking at the mappings created.  UUID of this
+		extent.
diff --git a/drivers/cxl/core/extent.c b/drivers/cxl/core/extent.c
index ecdd7717f7d7..17fad51f084d 100644
--- a/drivers/cxl/core/extent.c
+++ b/drivers/cxl/core/extent.c
@@ -6,6 +6,63 @@
 
 #include "core.h"
 
+static ssize_t offset_show(struct device *dev, struct device_attribute *attr,
+			   char *buf)
+{
+	struct region_extent *region_extent = to_region_extent(dev);
+
+	return sysfs_emit(buf, "%#llx\n", region_extent->hpa_range.start);
+}
+static DEVICE_ATTR_RO(offset);
+
+static ssize_t length_show(struct device *dev, struct device_attribute *attr,
+			   char *buf)
+{
+	struct region_extent *region_extent = to_region_extent(dev);
+	u64 length = range_len(&region_extent->hpa_range);
+
+	return sysfs_emit(buf, "%#llx\n", length);
+}
+static DEVICE_ATTR_RO(length);
+
+static ssize_t uuid_show(struct device *dev, struct device_attribute *attr,
+			 char *buf)
+{
+	struct region_extent *region_extent = to_region_extent(dev);
+
+	return sysfs_emit(buf, "%pUb\n", &region_extent->uuid);
+}
+static DEVICE_ATTR_RO(uuid);
+
+static struct attribute *region_extent_attrs[] = {
+	&dev_attr_offset.attr,
+	&dev_attr_length.attr,
+	&dev_attr_uuid.attr,
+	NULL
+};
+
+static uuid_t empty_uuid = { 0 };
+
+static umode_t region_extent_visible(struct kobject *kobj,
+				     struct attribute *a, int n)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct region_extent *region_extent = to_region_extent(dev);
+
+	if (a == &dev_attr_uuid.attr &&
+	    uuid_equal(&region_extent->uuid, &empty_uuid))
+		return 0;
+
+	return a->mode;
+}
+
+static const struct attribute_group region_extent_attribute_group = {
+	.attrs = region_extent_attrs,
+	.is_visible = region_extent_visible,
+};
+
+__ATTRIBUTE_GROUPS(region_extent_attribute);
+
 static void cxled_release_extent(struct cxl_endpoint_decoder *cxled,
 				 struct cxled_extent *ed_extent)
 {
@@ -44,6 +101,7 @@ static void region_extent_release(struct device *dev)
 static const struct device_type region_extent_type = {
 	.name = "extent",
 	.release = region_extent_release,
+	.groups = region_extent_attribute_groups,
 };
 
 bool is_region_extent(struct device *dev)
-- 
2.43.0

