Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F49F390C9F
	for <linux-cxl@vger.kernel.org>; Sat, 23 May 2026 09:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779529471; cv=none; b=efajZ/GxJBouI+Y5w7IaQif4J94qMtJ5EAT8Ud37h+aOoi4PFYvy1IwCQE6Qsz+KivZrB5pHfTWlyGLEM92hRcikUo2o+vGKfNYSrpnEtNYcIrBd5cnPhUokmeVzDAPVzG/M9TDIp5RDeFkamgWi+saPppV9Ein5zKQJRxLMsx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779529471; c=relaxed/simple;
	bh=dPc+Jmt6Ao4NKtb3a2yTElMc9JU4ev8Gi4vvYTbxHSM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dVHscxSmca+iALLSgiq8KSawcNonHlhcrKvuBg351ej8aIZDvVwk6BwFSRmrDHoI9PYuXMcXYtVlIQbLAMMe3nsiY5P7M4BVFoGVcjY5Ce3bmRI+5yZIYpGRAorlinJ2Ce03KUFX3P9GzeAgko+ZlY1XbWXLQDbALWTGMTCTuLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lv53Bdaz; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lv53Bdaz"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-135e88b8e55so3425588c88.0
        for <linux-cxl@vger.kernel.org>; Sat, 23 May 2026 02:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779529467; x=1780134267; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9mYuq+VCymP+W06eRpvcFDkonJ88MmeA72PafHhyXdc=;
        b=lv53BdazzmWJT0t9Gz7CtkfcFD1tnH7w9CoaWqttMquusCmKmR4BS35dyo9hWWzOmF
         0T+hrbD65ydYtP3m33ErJM+fwVfNhyhPoxRgXnb0zfMI5yjSPlRZDNNHhPNxEa2XZeII
         Iap+Tmd/yLL1MtnADcpEj2DqomGnOpunexR3wIW3mbIGZKDFcFJaraRasMGMiWitQE5P
         GHz8h0yTpGjiMYMB5P/RhfLEFGTyl9k7SsO6cBP7zgMNb/bQ0oe/TlPO7tFOvVRjJieh
         rDI9eSSxqSUci9R8rlmJSgBg/IP1ScNaqqIqVv0T+rhDea1g9oO0klqO39q7ZcxltZn0
         IjAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779529467; x=1780134267;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9mYuq+VCymP+W06eRpvcFDkonJ88MmeA72PafHhyXdc=;
        b=P3dpzEPZM8/PSDn+c9j8oo6oKP6+J8bkIAvslVKp0JW7KRjjqZpB5QCDV+hMu1/Gq5
         XrZ/B6zUglye5MgoMk1BTdKDPDBc1pjMyeXIBHpBdZ/WNrBl+Y8CG7FvVGFu/nAf4yML
         YCZfmxPmNevvbsb+2qBmWZolpg/+zltmyxN6tl6J6ToJK//7CyO72iJay4txDAJat6nb
         KL+SKfACDvMtkNdIrOLOlgFNbXgX+uHtY+pOugI8Q4mepPBDkebslAx4kL8NzMZjbgXu
         59NnNwHY4znm329yRNVfqiLT3ciFNLf8SHmmxR/Awd4PMGP3XDsdpF1ODqNYghYCAUaJ
         Ps8g==
X-Gm-Message-State: AOJu0Yz5eg5wy9vxL4ka/SlkPtB6P36s4Vj+Ce4as6bh8ct0BQbj5Uk/
	yrO4b+Ae0TkM/nYkD5WNbGTsbWPb/zcu/dOKJWVxA4dqQWrS8n5IdbuyBiUGKA==
X-Gm-Gg: Acq92OFWLyDtgDEaeCMGcwZhdgzrqXwsRoc6PUQ5JkLjLECrEELk9XwbCAq55UsHKIC
	Cki3P6bMyFTiwvu4AZgo/3HWSDVVoMCTEWSqhiA6HxHd7Rh7Vo86OrdsF6kgcQbxbx8938OJgy6
	dcPBsHDFboaMYSR2o777yGH4O1c2yV4SU385YtNLjzHW/aICgTBgtwxK+QDmfvU4F82vWYRkbcG
	Bc1Zu3NoVUhJxfnv98EnzYQ/TZeN+Dltl30768suWZ7c5fVEUPIj3MIq57mwTRI/WMD0SryoZUI
	9LtIx2IzKPGnbgoWMR5LMAss7uu4TVRrXlI1ybi6dZG2+SHDeXHe5kVpNlBN83E/R24++bsF1W3
	3EcL+19QgCETgYHAUfTkg7JjRwT1Pi3uOouy8Kvu5feRxDFvAM0Y1f5k0WscppjlbH4zhdYHSh/
	/CsffJMCUcMbMJO9rme86d5pYdbuLxfmpk2GmviBD47FdvRQ2jpoToPs77Ul+QBosn+1UO/8lV0
	QNLv3M=
X-Received: by 2002:a05:7022:68a3:b0:130:9b78:b18d with SMTP id a92af1059eb24-1365fc62681mr2472043c88.34.1779529467174;
        Sat, 23 May 2026 02:44:27 -0700 (PDT)
Received: from AnisaLaptop.localdomain (c-73-170-217-179.hsd1.ca.comcast.net. [73.170.217.179])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1366a40305csm2376358c88.7.2026.05.23.02.44.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 02:44:26 -0700 (PDT)
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
	Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH v10 26/31] dax/bus: Tag-aware uuid claim and show on DC dax devices
Date: Sat, 23 May 2026 02:43:20 -0700
Message-ID: <89784b600e4284772c4136b462e948e016129cdf.1779528761.git.anisa.su@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1779528761.git.anisa.su@samsung.com>
References: <cover.1779528761.git.anisa.su@samsung.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

DC DAX regions are populated with dax_resource children that each carry a
backing tag uuid and a per-allocation sequence number (seq_num).  Add the
userspace claim semantics that resolve those tagged groups into DAX
devices.

A DC region's seed dax device is created at 0-size on probe; userspace
populates it by writing to its 'uuid' attribute:

  * A non-null UUID claims every dax_resource on this region whose tag
    matches, in seq_num order via uuid_claim_tagged().  The match set
    must form a dense 1..n sequence (no gap, no duplicate); the CXL
    side maintains this invariant for both sharable allocations (where
    the device stamps shared_extn_seq) and non-sharable allocations
    (where cxl_add_pending assigns arrival-order seq).  The resulting
    DAX device's size equals the sum of every member extent's size.

  * "0" claims a single untagged dax_resource via
    uuid_claim_untagged().  Untagged extents are independent
    allocations; collapsing several would aggregate unrelated capacity,
    so each uuid="0" write consumes exactly one untagged resource.

  * A write that matches no dax_resource returns -ENOENT; the device
    stays at size 0.

uuid_show() reads back the backing tag uuid (or the null UUID for an
untagged claim).  The attribute is read-only (0444) on non-DC dax
devices; writes to it on non-DC regions return -EOPNOTSUPP.

dev_dax_visible() exposes the uuid attribute only on DC dax devices.

Based on an original patch by Navneet Singh.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Anisa Su <anisa.su@samsung.com>

---
Changes:
[anisa: split out from the original "Surface dc_extents" commit;
 userspace tag-claim semantics only.]
---
 drivers/dax/bus.c | 260 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 256 insertions(+), 4 deletions(-)

diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
index c030eb103ad0..1dccb3e5cd0f 100644
--- a/drivers/dax/bus.c
+++ b/drivers/dax/bus.c
@@ -5,6 +5,7 @@
 #include <linux/mutex.h>
 #include <linux/list.h>
 #include <linux/slab.h>
+#include <linux/sort.h>
 #include <linux/dax.h>
 #include <linux/io.h>
 #include "dax-private.h"
@@ -1316,6 +1317,89 @@ static ssize_t dev_dax_resize(struct dax_region *dax_region,
 	return 0;
 }
 
+/* DC extents are all-or-nothing: an extent is either free or fully claimed. */
+static bool dax_resource_in_use(const struct dax_resource *dax_resource)
+{
+	return dax_resource->use_cnt > 0;
+}
+
+struct dax_uuid_match {
+	const struct dax_region *dax_region;
+	const uuid_t *uuid;
+};
+
+static int find_uuid_extent(struct device *dev, const void *data)
+{
+	const struct dax_uuid_match *match = data;
+	struct dax_resource *dax_resource;
+
+	if (!match->dax_region->dc_ops->is_extent(dev))
+		return 0;
+
+	dax_resource = dev_get_drvdata(dev);
+	if (!dax_resource || dax_resource_in_use(dax_resource))
+		return 0;
+	return uuid_equal(&dax_resource->uuid, match->uuid);
+}
+
+struct dax_tag_collect {
+	const struct dax_region *dax_region;
+	const uuid_t *uuid;
+	struct dax_resource **arr;
+	unsigned int count;
+	unsigned int cap;
+};
+
+static int collect_uuid_extent(struct device *dev, void *data)
+{
+	struct dax_tag_collect *c = data;
+	struct dax_resource *dax_resource;
+
+	if (!c->dax_region->dc_ops->is_extent(dev))
+		return 0;
+
+	dax_resource = dev_get_drvdata(dev);
+	if (!dax_resource || dax_resource_in_use(dax_resource))
+		return 0;
+	if (!uuid_equal(&dax_resource->uuid, c->uuid))
+		return 0;
+
+	if (c->count == c->cap)
+		return -ENOSPC;
+	c->arr[c->count++] = dax_resource;
+	return 0;
+}
+
+static int count_uuid_extent(struct device *dev, void *data)
+{
+	struct dax_tag_collect *c = data;
+	struct dax_resource *dax_resource;
+
+	if (!c->dax_region->dc_ops->is_extent(dev))
+		return 0;
+
+	dax_resource = dev_get_drvdata(dev);
+	if (!dax_resource || dax_resource_in_use(dax_resource))
+		return 0;
+	if (!uuid_equal(&dax_resource->uuid, c->uuid))
+		return 0;
+
+	c->count++;
+	return 0;
+}
+
+static int dax_resource_seq_cmp(const void *a, const void *b)
+{
+	const struct dax_resource * const *pa = a;
+	const struct dax_resource * const *pb = b;
+
+	if ((*pa)->seq_num < (*pb)->seq_num)
+		return -1;
+	if ((*pa)->seq_num > (*pb)->seq_num)
+		return 1;
+	return 0;
+}
+
 static ssize_t size_store(struct device *dev, struct device_attribute *attr,
 		const char *buf, size_t len)
 {
@@ -1548,13 +1632,177 @@ static DEVICE_ATTR_RO(numa_node);
 static ssize_t uuid_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
-	return sysfs_emit(buf, "%d\n", 0);
+	struct dev_dax *dev_dax = to_dev_dax(dev);
+	int rc;
+
+	rc = down_read_interruptible(&dax_dev_rwsem);
+	if (rc)
+		return rc;
+
+	for (int i = 0; i < dev_dax->nr_range; i++) {
+		struct dax_resource *r = dev_dax->ranges[i].dax_resource;
+
+		if (r && !uuid_is_null(&r->uuid)) {
+			rc = sysfs_emit(buf, "%pUb\n", &r->uuid);
+			goto out;
+		}
+	}
+	rc = sysfs_emit(buf, "0\n");
+out:
+	up_read(&dax_dev_rwsem);
+	return rc;
+}
+
+static ssize_t uuid_claim_untagged(struct dax_region *dax_region,
+				   struct dev_dax *dev_dax)
+{
+	struct dax_uuid_match match = {
+		.dax_region = dax_region,
+		.uuid = &uuid_null,
+	};
+	struct dax_resource *dax_resource;
+	resource_size_t to_alloc;
+	struct device *extent_dev;
+	ssize_t alloc;
+
+	extent_dev = device_find_child(dax_region->dev, &match,
+				       find_uuid_extent);
+	if (!extent_dev)
+		return -ENOENT;
+
+	dax_resource = dev_get_drvdata(extent_dev);
+	to_alloc = resource_size(dax_resource->res);
+	alloc = __dev_dax_resize(dax_resource->res, dev_dax, to_alloc,
+				 dax_resource);
+	put_device(extent_dev);
+	if (alloc < 0)
+		return alloc;
+	if (alloc == 0)
+		return -ENOENT;
+	dax_resource->use_cnt++;
+	return 0;
+}
+
+static ssize_t uuid_claim_tagged(struct dax_region *dax_region,
+				 struct dev_dax *dev_dax, const uuid_t *uuid)
+{
+	struct dax_tag_collect c = {
+		.dax_region = dax_region,
+		.uuid = uuid,
+	};
+	unsigned int i;
+	ssize_t rc;
+
+	/* Two-pass: count, then collect into a sized array. */
+	device_for_each_child(dax_region->dev, &c, count_uuid_extent);
+	if (!c.count)
+		return -ENOENT;
+
+	c.arr = kmalloc_array(c.count, sizeof(*c.arr), GFP_KERNEL);
+	if (!c.arr)
+		return -ENOMEM;
+	c.cap = c.count;
+	c.count = 0;
+
+	rc = device_for_each_child(dax_region->dev, &c, collect_uuid_extent);
+	if (rc)
+		goto out;
+
+	sort(c.arr, c.count, sizeof(*c.arr), dax_resource_seq_cmp, NULL);
+
+	/*
+	 * Tagged groups carry a dense 1..n @seq_num regardless of source
+	 * (sharable: device-stamped; non-sharable: host-assigned in
+	 * arrival order — see &struct dax_resource).  A gap or
+	 * out-of-range value here means an extent went missing on the
+	 * cxl side (e.g. a per-extent failure in cxl_add_pending) or a
+	 * cxl-side validation gap; in either case refuse the whole
+	 * group rather than carve a partial allocation.
+	 */
+	for (i = 0; i < c.count; i++) {
+		if (c.arr[i]->seq_num != i + 1) {
+			dev_WARN_ONCE(dax_region->dev, 1,
+				"tag %pUb seq invariant violated at slot %u (got %u)\n",
+				uuid, i, c.arr[i]->seq_num);
+			rc = -EINVAL;
+			goto out;
+		}
+	}
+
+	for (i = 0; i < c.count; i++) {
+		resource_size_t to_alloc = resource_size(c.arr[i]->res);
+		ssize_t alloc;
+
+		alloc = __dev_dax_resize(c.arr[i]->res, dev_dax, to_alloc,
+					 c.arr[i]);
+		if (alloc < 0) {
+			rc = alloc;
+			goto rollback;
+		}
+		if (alloc == 0) {
+			rc = -ENOSPC;
+			goto rollback;
+		}
+		c.arr[i]->use_cnt++;
+	}
+	rc = 0;
+	goto out;
+
+rollback:
+	/*
+	 * Partial failure: trim every range we added in this attempt.
+	 * trim_dev_dax_range pops the most-recently-appended range from
+	 * dev_dax->ranges[] and decrements its dax_resource->use_cnt, so
+	 * looping until we have undone @i additions restores both
+	 * dev_dax->ranges[] and the matched dax_resources' use_cnt.
+	 */
+	while (i-- > 0)
+		trim_dev_dax_range(dev_dax);
+out:
+	kfree(c.arr);
+	return rc;
 }
 
 static ssize_t uuid_store(struct device *dev, struct device_attribute *attr,
 			  const char *buf, size_t len)
 {
-	return -EOPNOTSUPP;
+	struct dev_dax *dev_dax = to_dev_dax(dev);
+	struct dax_region *dax_region = dev_dax->region;
+	uuid_t uuid;
+	ssize_t rc;
+
+	if (!is_dynamic(dax_region))
+		return -EOPNOTSUPP;
+
+	if (sysfs_streq(buf, "0"))
+		uuid_copy(&uuid, &uuid_null);
+	else {
+		rc = uuid_parse(buf, &uuid);
+		if (rc)
+			return rc;
+	}
+
+	rc = down_write_killable(&dax_region_rwsem);
+	if (rc)
+		return rc;
+	if (!dax_region->dev->driver) {
+		rc = -ENXIO;
+		goto err_region;
+	}
+	rc = down_write_killable(&dax_dev_rwsem);
+	if (rc)
+		goto err_region;
+
+	if (uuid_is_null(&uuid))
+		rc = uuid_claim_untagged(dax_region, dev_dax);
+	else
+		rc = uuid_claim_tagged(dax_region, dev_dax, &uuid);
+
+	up_write(&dax_dev_rwsem);
+err_region:
+	up_write(&dax_region_rwsem);
+
+	return rc < 0 ? rc : len;
 }
 static DEVICE_ATTR_RW(uuid);
 
@@ -1614,8 +1862,12 @@ static umode_t dev_dax_visible(struct kobject *kobj, struct attribute *a, int n)
 		return 0;
 	if (a == &dev_attr_mapping.attr && is_dynamic(dax_region))
 		return 0;
-	if ((a == &dev_attr_align.attr ||
-	     a == &dev_attr_size.attr) && is_static(dax_region))
+	if (a == &dev_attr_uuid.attr && !is_dynamic(dax_region))
+		return 0444;
+	if (a == &dev_attr_align.attr &&
+	    (is_static(dax_region) || is_dynamic(dax_region)))
+		return 0444;
+	if (a == &dev_attr_size.attr && is_static(dax_region))
 		return 0444;
 	return a->mode;
 }
-- 
2.43.0

