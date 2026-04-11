Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FAB32AE78
	for <linux-cxl@vger.kernel.org>; Sat, 11 Apr 2026 01:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775871638; cv=none; b=M4i3GdfRQcfMSernnrhZYbwH9bu79We3T6Tv+1UAR9zq9z2XQCFDDuUoeNmMP2OLtS0IBRKneunBQooYfwP8hwg/g/SzW0EeIMcWofyDPvFinqLEqIq/Utj39J4A2hZlYlVlEInIVTGhfZHs4YJKAk8pJFB3Z98qewb7MWUJGYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775871638; c=relaxed/simple;
	bh=/+274m0pb5j8WMUjOLl/krtcGbEIWW3q7UQKWzyg6SE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bF1ML+xlIeXVzp37XVIJ7Rt9Ktru08K0MuoTCRkgQQQ2A+mcHPYSXC3X+LerZZ3h4XvLWw4Ka5LQsSF8j5BIAOIsNDWTDRpOnDNTFbvQ80R8XVeVePzHCy7MEI1nn/onPDFTJ+pNjwH6vlBGKyNzCeiHyEU4iv6y8L+cmG3ewCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CDRbAy35; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CDRbAy35"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-79a7109f568so31536587b3.1
        for <linux-cxl@vger.kernel.org>; Fri, 10 Apr 2026 18:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775871636; x=1776476436; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jZvTumHiX2RqznjQXhJeRZHcUvQAPLedS6/f1P7VGWM=;
        b=CDRbAy35yLGxwyZ9fI56f08c5INlnsh9/WG61qKtdRSWdwEamrafozIo8VU2LkJkMy
         1mnXz6B5Jnawta5SBLKq3Dr3ZEk29FzlYjrqsZ4D59tEK/kdj+0IrLGrcV+qkybE5/19
         zoRKiqzjmyCFbpypmh7rigzVOO06gxrU3FBECv5e1opyPRl6kC/ZbPJXFR95kOegV+ky
         Jh2D2ei/ww1I8abd1NUvLMgmIuYAtQxffQOxBadNNe0tzCTcLQ5wHJbOwc6izyDEUj1Q
         NCziXanYpbmM7U9k7Rm2dzwWVVE/w8dy3vbrzx43EG8RH2bUD77mH8tdz1H+E0l1HweH
         rUfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775871636; x=1776476436;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jZvTumHiX2RqznjQXhJeRZHcUvQAPLedS6/f1P7VGWM=;
        b=fMLMC89IdKRt65U+HXu44Z5Ji1L+EH9q1DpvQWKViel1nn7tImF/RjnitSVmmX+LHO
         sFfmDpMCR0GqkHasd1+//aIBrlIK3Pn3LuAyYIAUSsBkW81YWObnfCwqQBBqkecRoH+P
         OxTaIt6783dxWhwywsBtOzdmCb+NqZS1gF/O15Fbd6+RLOYjwwK3OQJbJw/6cv3AG8cs
         v/vti+PyU3O1Suy80zFA1yVyg+TVmRLt6/D1GcVMgQ+OZ5QYsSW3rfzQCSrCVyuzxnKh
         lJwApSZ2KqqgwmB8+hwK2B3qoyG3VARHRw98RuxbT1i6UkF68MnIvyoeOkKxMywY5Knt
         UDSA==
X-Gm-Message-State: AOJu0YxGpsaB3luCeYRZ6QleB0PjaKyrBHCSwTCoFr4I26h9v8jx163L
	m3BnSKJGT7Zg8qAm7xxRmWqFaoDe9OguosHf8LL+jqcJxastomoYcMKVxgdhDA==
X-Gm-Gg: AeBDieuPdlruxDaNQyuGoIOUFpAF2fQfxz5xn+3G2rcloVFkSH4rMZHoM7t+ZgAKOzu
	3W30UGymyntfY48K+8w0lEWh2cRdZHs6dCStQ8aaOAVg/hhD83MbAWP5TyZkFoG1oQs0BkvcseC
	57R0sUtie+CRoE+DHLq75acCiJePs0wowJ9Den8O/th+guolS135V9NwRZSqdSNRHn1Es5CvmvZ
	KufiuEf6JHksCTJjyq5wwAqo55XuawhC6k4Bn5sS46tT3dM7rkqz2RETpc7flE1CJ/mmhHIbjy2
	7osMOAPZrLG/XgvhaFqGcPqDGIuyBSUF5qOI9kHMqq3GRkxEqSZ7NYauf0u+8o6SYSs3fyHVZSA
	Dq0guTCL6EZYIEhgvSxapw96C2A7SFj51/vEn+7vpBvdZlP7ZdRFcXaGNeqrm9RUS8HNAl+GC5/
	8qEd5wS8fAxcrhqkpkBwoDV53ETzJ44L2/dq9ogMNt7w==
X-Received: by 2002:a05:690c:c509:b0:7a4:c40c:4b19 with SMTP id 00721157ae682-7af6f22b8f5mr63147957b3.10.1775871636188;
        Fri, 10 Apr 2026 18:40:36 -0700 (PDT)
Received: from 4470NRD-ASU.ssi.samsung.com ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7af3fa06595sm21690547b3.40.2026.04.10.18.40.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 18:40:35 -0700 (PDT)
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
	dan.j.williams@intel.com
Subject: [PATCH 07/20] cxl/region: Add sparse DAX region support
Date: Fri, 10 Apr 2026 18:23:02 -0700
Message-ID: <20260411013958.47422-8-anisa.su@samsung.com>
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

Dynamic Capacity CXL regions must allow memory to be added or removed
dynamically.  In addition to the quantity of memory available the
location of the memory within a DC partition is dynamic based on the
extents offered by a device.  CXL DAX regions must accommodate the
sparseness of this memory in the management of DAX regions and devices.

Introduce the concept of a sparse DAX region.  Introduce
create_dynamic_ram_a_region() sysfs entry to create such regions.
Special case dynamic capable regions to create a 0 sized seed DAX device
to maintain compatibility which requires a default DAX device to hold a
region reference.

Indicate 0 byte available capacity until such time that capacity is
added.

Sparse regions complicate the range mapping of dax devices.  There is no
known use case for range mapping on sparse regions.  Avoid the
complication by preventing range mapping of dax devices on sparse
regions.

Interleaving is deferred for now.  Add checks.

Based on an original patch by Navneet Singh.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes:
[anisa: rebase]
[fan: fix return logic when validating DCD mode in store_targetN]
---
 Documentation/ABI/testing/sysfs-bus-cxl | 22 ++++++++---------
 drivers/cxl/core/core.h                 | 11 +++++++++
 drivers/cxl/core/port.c                 |  1 +
 drivers/cxl/core/region.c               | 33 +++++++++++++++++++++++--
 drivers/dax/bus.c                       | 10 ++++++++
 drivers/dax/bus.h                       |  1 +
 drivers/dax/cxl.c                       | 16 ++++++++++--
 7 files changed, 79 insertions(+), 15 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
index c604c7ca6432..3080aef9ad67 100644
--- a/Documentation/ABI/testing/sysfs-bus-cxl
+++ b/Documentation/ABI/testing/sysfs-bus-cxl
@@ -434,20 +434,20 @@ Description:
 		interleave_granularity).
 
 
-What:		/sys/bus/cxl/devices/decoderX.Y/create_{pmem,ram}_region
-Date:		May, 2022, January, 2023
-KernelVersion:	v6.0 (pmem), v6.3 (ram)
+What:		/sys/bus/cxl/devices/decoderX.Y/create_{pmem,ram,dynamic_ram_a}_region
+Date:		May, 2022, January, 2023, May 2025
+KernelVersion:	v6.0 (pmem), v6.3 (ram), v6.16 (dynamic_ram_a)
 Contact:	linux-cxl@vger.kernel.org
 Description:
 		(RW) Write a string in the form 'regionZ' to start the process
-		of defining a new persistent, or volatile memory region
-		(interleave-set) within the decode range bounded by root decoder
-		'decoderX.Y'. The value written must match the current value
-		returned from reading this attribute. An atomic compare exchange
-		operation is done on write to assign the requested id to a
-		region and allocate the region-id for the next creation attempt.
-		EBUSY is returned if the region name written does not match the
-		current cached value.
+		of defining a new persistent, volatile, or dynamic RAM memory
+		region (interleave-set) within the decode range bounded by root
+		decoder 'decoderX.Y'. The value written must match the current
+		value returned from reading this attribute.  An atomic compare
+		exchange operation is done on write to assign the requested id
+		to a region and allocate the region-id for the next creation
+		attempt.  EBUSY is returned if the region name written does not
+		match the current cached value.
 
 
 What:		/sys/bus/cxl/devices/decoderX.Y/delete_region
diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 82ca3a476708..8881cc9323e0 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -6,6 +6,7 @@
 
 #include <cxl/mailbox.h>
 #include <linux/rwsem.h>
+#include <cxlmem.h>
 
 extern const struct device_type cxl_nvdimm_bridge_type;
 extern const struct device_type cxl_nvdimm_type;
@@ -18,6 +19,15 @@ enum cxl_detach_mode {
 	DETACH_INVALIDATE,
 };
 
+static inline struct cxl_memdev_state *
+cxled_to_mds(struct cxl_endpoint_decoder *cxled)
+{
+	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+
+	return container_of(cxlds, struct cxl_memdev_state, cxlds);
+}
+
 #ifdef CONFIG_CXL_REGION
 
 struct cxl_region_context {
@@ -29,6 +39,7 @@ struct cxl_region_context {
 
 extern struct device_attribute dev_attr_create_pmem_region;
 extern struct device_attribute dev_attr_create_ram_region;
+extern struct device_attribute dev_attr_create_dynamic_ram_a_region;
 extern struct device_attribute dev_attr_delete_region;
 extern struct device_attribute dev_attr_region;
 extern const struct device_type cxl_pmem_region_type;
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index a7f71f36531f..2d33001dac26 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -337,6 +337,7 @@ static struct attribute *cxl_decoder_root_attrs[] = {
 	&dev_attr_qos_class.attr,
 	SET_CXL_REGION_ATTR(create_pmem_region)
 	SET_CXL_REGION_ATTR(create_ram_region)
+	SET_CXL_REGION_ATTR(create_dynamic_ram_a_region)
 	SET_CXL_REGION_ATTR(delete_region)
 	NULL,
 };
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index edc267c6cf77..d2ce844a142f 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -533,6 +533,11 @@ static ssize_t interleave_ways_store(struct device *dev,
 	if (rc)
 		return rc;
 
+	if (cxlr->mode == CXL_PARTMODE_DYNAMIC_RAM_A && val != 1) {
+		dev_err(dev, "Interleaving and DCD not supported\n");
+		return -EINVAL;
+	}
+
 	ACQUIRE(rwsem_write_kill, rwsem)(&cxl_rwsem.region);
 	if ((rc = ACQUIRE_ERR(rwsem_write_kill, &rwsem)))
 		return rc;
@@ -2389,6 +2394,7 @@ static size_t store_targetN(struct cxl_region *cxlr, const char *buf, int pos,
 	if (sysfs_streq(buf, "\n"))
 		rc = detach_target(cxlr, pos);
 	else {
+		struct cxl_endpoint_decoder *cxled;
 		struct device *dev;
 
 		dev = bus_find_device_by_name(&cxl_bus_type, NULL, buf);
@@ -2400,8 +2406,14 @@ static size_t store_targetN(struct cxl_region *cxlr, const char *buf, int pos,
 			goto out;
 		}
 
-		rc = attach_target(cxlr, to_cxl_endpoint_decoder(dev), pos,
-				   TASK_INTERRUPTIBLE);
+		cxled = to_cxl_endpoint_decoder(dev);
+		if (cxlr->mode == CXL_PARTMODE_DYNAMIC_RAM_A &&
+		    !cxl_dcd_supported(cxled_to_mds(cxled))) {
+			dev_dbg(dev, "DCD unsupported\n");
+			rc = -EINVAL;
+			goto out;
+		}
+		rc = attach_target(cxlr, cxled, pos, TASK_INTERRUPTIBLE);
 out:
 		put_device(dev);
 	}
@@ -2750,6 +2762,7 @@ static struct cxl_region *__create_region(struct cxl_root_decoder *cxlrd,
 	switch (mode) {
 	case CXL_PARTMODE_RAM:
 	case CXL_PARTMODE_PMEM:
+	case CXL_PARTMODE_DYNAMIC_RAM_A:
 		break;
 	default:
 		dev_err(&cxlrd->cxlsd.cxld.dev, "unsupported mode %d\n", mode);
@@ -2802,6 +2815,21 @@ static ssize_t create_ram_region_store(struct device *dev,
 }
 DEVICE_ATTR_RW(create_ram_region);
 
+static ssize_t create_dynamic_ram_a_region_show(struct device *dev,
+						struct device_attribute *attr,
+						char *buf)
+{
+	return __create_region_show(to_cxl_root_decoder(dev), buf);
+}
+
+static ssize_t create_dynamic_ram_a_region_store(struct device *dev,
+						 struct device_attribute *attr,
+						 const char *buf, size_t len)
+{
+	return create_region_store(dev, buf, len, CXL_PARTMODE_DYNAMIC_RAM_A);
+}
+DEVICE_ATTR_RW(create_dynamic_ram_a_region);
+
 static ssize_t region_show(struct device *dev, struct device_attribute *attr,
 			   char *buf)
 {
@@ -4081,6 +4109,7 @@ static int cxl_region_probe(struct device *dev)
 
 		return devm_cxl_add_pmem_region(cxlr);
 	case CXL_PARTMODE_RAM:
+	case CXL_PARTMODE_DYNAMIC_RAM_A:
 		rc = devm_cxl_region_edac_register(cxlr);
 		if (rc)
 			dev_dbg(&cxlr->dev, "CXL EDAC registration for region_id=%d failed\n",
diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
index 68437c05e21d..e41e36747111 100644
--- a/drivers/dax/bus.c
+++ b/drivers/dax/bus.c
@@ -179,6 +179,11 @@ static bool is_static(struct dax_region *dax_region)
 	return (dax_region->res.flags & IORESOURCE_DAX_STATIC) != 0;
 }
 
+static bool is_sparse(struct dax_region *dax_region)
+{
+	return (dax_region->res.flags & IORESOURCE_DAX_SPARSE_CAP) != 0;
+}
+
 bool static_dev_dax(struct dev_dax *dev_dax)
 {
 	return is_static(dev_dax->region);
@@ -302,6 +307,9 @@ static unsigned long long dax_region_avail_size(struct dax_region *dax_region)
 
 	lockdep_assert_held(&dax_region_rwsem);
 
+	if (is_sparse(dax_region))
+		return 0;
+
 	for_each_dax_region_resource(dax_region, res)
 		size -= resource_size(res);
 	return size;
@@ -1387,6 +1395,8 @@ static umode_t dev_dax_visible(struct kobject *kobj, struct attribute *a, int n)
 		return 0;
 	if (a == &dev_attr_mapping.attr && is_static(dax_region))
 		return 0;
+	if (a == &dev_attr_mapping.attr && is_sparse(dax_region))
+		return 0;
 	if ((a == &dev_attr_align.attr ||
 	     a == &dev_attr_size.attr) && is_static(dax_region))
 		return 0444;
diff --git a/drivers/dax/bus.h b/drivers/dax/bus.h
index 7b1a83f1ce1f..7abdd5a403dc 100644
--- a/drivers/dax/bus.h
+++ b/drivers/dax/bus.h
@@ -15,6 +15,7 @@ struct dax_region;
 /* dax bus specific ioresource flags */
 #define IORESOURCE_DAX_STATIC BIT(0)
 #define IORESOURCE_DAX_KMEM BIT(1)
+#define IORESOURCE_DAX_SPARSE_CAP BIT(2)
 
 struct dax_region *alloc_dax_region(struct device *parent, int region_id,
 		struct range *range, int target_node, unsigned int align,
diff --git a/drivers/dax/cxl.c b/drivers/dax/cxl.c
index 3ab39b77843d..9ebe974d25c3 100644
--- a/drivers/dax/cxl.c
+++ b/drivers/dax/cxl.c
@@ -13,19 +13,31 @@ static int cxl_dax_region_probe(struct device *dev)
 	struct cxl_region *cxlr = cxlr_dax->cxlr;
 	struct dax_region *dax_region;
 	struct dev_dax_data data;
+	resource_size_t dev_size;
+	unsigned long flags;
 
 	if (nid == NUMA_NO_NODE)
 		nid = memory_add_physaddr_to_nid(cxlr_dax->hpa_range.start);
 
+	flags = IORESOURCE_DAX_KMEM;
+	if (cxlr->mode == CXL_PARTMODE_DYNAMIC_RAM_A)
+		flags |= IORESOURCE_DAX_SPARSE_CAP;
+
 	dax_region = alloc_dax_region(dev, cxlr->id, &cxlr_dax->hpa_range, nid,
-				      PMD_SIZE, IORESOURCE_DAX_KMEM);
+				      PMD_SIZE, flags);
 	if (!dax_region)
 		return -ENOMEM;
 
+	if (cxlr->mode == CXL_PARTMODE_DYNAMIC_RAM_A)
+		/* Add empty seed dax device */
+		dev_size = 0;
+	else
+		dev_size = range_len(&cxlr_dax->hpa_range);
+
 	data = (struct dev_dax_data) {
 		.dax_region = dax_region,
 		.id = -1,
-		.size = range_len(&cxlr_dax->hpa_range),
+		.size = dev_size,
 		.memmap_on_memory = true,
 	};
 
-- 
2.43.0

