Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD52C365A0F
	for <linux-cxl@vger.kernel.org>; Mon, 12 Jan 2026 16:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768235762; cv=none; b=uLXT3x1QC48IW/6EITqb21Putp+7bKr2eRZCZ92COIem/PXWDRCYq2hQ3B/PJW5yp053z1m0yAFkWw0idAiXkdkwPxy3xtqzT0506xBKluLlyymaWivIDuSaS8L5bg6p1V/WM9UADrjV8VJ/niSx2+LmfGAX2rswuI5lyHXiGFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768235762; c=relaxed/simple;
	bh=JrHNQt8zuafgYPfF3gFXWJn22SxhOqIEHjy19OUrPSw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e+QYFDrp6xE8FE/M0zQ0WmgEjxT499MU2GbY6ZYF6xAsE5alwcZiHsPysjHHLZh7xWwHWvtsYM42B4KtDLyP4kWzr7VIjYGbfrt6sH9d1FpVdKfarqLtgtMPychRIC/Op/s22pnDnThuPZDDNEnsKa4UAaW87w1zxaLwOGw7Gv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=SbA+GsFc; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="SbA+GsFc"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8b220ddc189so897601885a.0
        for <linux-cxl@vger.kernel.org>; Mon, 12 Jan 2026 08:36:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1768235759; x=1768840559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O4OBouSJxcSdHo3tQ8y/LhFr77uHm9IloTJDMHbIIbI=;
        b=SbA+GsFcOeLT+4goAQy+I+jwsZ/RkmVxVZYBlhS//UwjvV8p8LeYbaQmZtLciCzbgm
         qFqKSbC38eXIF1mO3jVZhFXMOsw5/zK3H9bXUGVRjq80zUjYdZp2QtOADxcnlq5BPQr7
         o7Otufz2Gsc25KFJ6B7u5LmjM9CQRrBCA2OrP16s1UMN9Is2QXqlk4svjfloDIWSW91L
         is39XprLyD+sP8lenhq1l6mUu9loPR+WhSnt7+TgCp61xdHIPy6Ion+JdDO8EdNrjffe
         IwZ7jcK2kmzSnfcbVrK3ZvSm5IY7xIcrcvwM0ukWh47RwRqy+L+3ylaAcoo0m1sMCyKd
         mucQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768235759; x=1768840559;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O4OBouSJxcSdHo3tQ8y/LhFr77uHm9IloTJDMHbIIbI=;
        b=kMpQdNOfVUY6+yolGMnt4RqwP8JZieKViYZKaoKKH4KIbJC1KRyr1YR5yBAbmpx8rx
         zLR5974WRCF3A39aWWK87bSntjSARonjpzTTQ8qKbqgyvHc2ppybJEs6TT2y262Ksqdb
         AYMuS7P50u2T6wxmNF5M0gu3daqVQcWUWjirfjWOKLGyVNJxjVjWsVkWX8YZZLT1kzdE
         jVmQQmt5WELPzAoisCKWuU7Q43SU6zWuSmYptwEgelFzUPuSGY5CfWlwJXtWNLMOv30+
         oPVoQA86pgaWig/RZpzaF+CHFJoAhI55ciNiX1YtWp8hu/1zZF+XAja5WPQQ4lPo6bQo
         6Aeg==
X-Gm-Message-State: AOJu0YzZ1Rf9hJpBuvTodHIMJ9FHAmSZ3+GeWBTA3XENeQT6RVoZIzcq
	mOFTkboLpuivPJhTh5pUSA4CVSZ9P7q9bcck9S/SW4OzrndUtqgFHjo/hOH3UNm+CmH/a7fxFlc
	grOYh
X-Gm-Gg: AY/fxX7Ymae/1Q+cuAyHnpg32mf0r1hGHPA7H4mfek/fFS2ITqx5w+jol3Zs3LySk1F
	tozkM9VhLbmJbJDE7PWjHiVj2gQMoCANttJMvpGbrGwt4GSCpmNSDA3TtYm6e3ztzgzN6hosHaN
	sgeH2kHDQGCaZqrB1wbQtzHp5WMtY4f9H98CHyvBs1KfhrLzgIv1L4Qa56/SrWfKpGedfa932GZ
	javstiZfgNUfj79FOcME2HCQj1GU0tGIVXX9DZn9Mn/5EWXktdcaR97BHVEwmTParL37NqAUErh
	xf3ccAVDh8e6sYlG1r61Ws6D4vZQVSVWAVYYxlnCstBMEzWZ+VaZifwT7hMxQ6TyIqmaOjJMU1V
	EPcITzijXTVFFptP47EL/zzrhTrOSW8d0qajBNWIfTgOn74vLsKEE4NBx9k2OiAHz24/37g83Wb
	p1BI1+uB0XptEKJN9eNA/yIlHTomyWWxD8Q8YR/cyRtqXJwM6E6rnY3bMVeYEXFc4qsTdteC9eq
	TQ=
X-Google-Smtp-Source: AGHT+IG2Jjm6s9R3smVtD6zbj1AGex6fzQAS3nqpLst7EeccmBodp/dBMnr2YHsUiN17+Yt/X6pa3Q==
X-Received: by 2002:a05:620a:2886:b0:8b1:ed55:e4f0 with SMTP id af79cd13be357-8c3893a06d1mr2719163985a.39.1768235759421;
        Mon, 12 Jan 2026 08:35:59 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c37f4a7962sm1489152685a.11.2026.01.12.08.35.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 08:35:59 -0800 (PST)
From: Gregory Price <gourry@gourry.net>
To: linux-cxl@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	David Hildenbrand <david@kernel.org>
Subject: [PATCH 2/6] cxl: add sysram_region memory controller
Date: Mon, 12 Jan 2026 11:35:10 -0500
Message-ID: <20260112163514.2551809-3-gourry@gourry.net>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260112163514.2551809-1-gourry@gourry.net>
References: <20260112163514.2551809-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a sysram memctrl that directly hotplugs memory without needing to
route through DAX.  This simplifies the sysram usecase considerably.

The sysram memctl adds new sysfs controls when registered:
	region/memctrl/[hotplug, hotunplug, state]

hotplug:   controller attempts to hotplug the memory region
hotunplug: controller attempts to offline and hotunplug the memory region
state:     [online,online_normal,offline]
   online       : controller onlines blocks in ZONE_MOVABLE
   online_normal: controller onlines blocks in ZONE_NORMAL
   offline      : controller attempts to offline the memory blocks

Hotplug note - by default the controller will hotplug the blocks, but
leave them offline (unless MHP auto-online in Kconfig is enabled).

Setting state to "online_normal" may prevent future hot-unplug of sysram
regions, and unbinding a memory region with memory online in ZONE_NORMAL
may result in the device being removed but the memory remaining online.

This can result in future management functions failing (such as adding a
new region).  This is why "online_normal" is explicit, and the default
online zone is ZONE_MOVABLE.

Cc: David Hildenbrand <david@kernel.org>
Signed-off-by: Gregory Price <gourry@gourry.net>
---
 drivers/cxl/core/core.h                  |   2 +
 drivers/cxl/core/memctrl/Makefile        |   1 +
 drivers/cxl/core/memctrl/memctrl.c       |   2 +
 drivers/cxl/core/memctrl/sysram_region.c | 358 +++++++++++++++++++++++
 drivers/cxl/core/region.c                |   5 +
 drivers/cxl/cxl.h                        |   6 +-
 6 files changed, 372 insertions(+), 2 deletions(-)
 create mode 100644 drivers/cxl/core/memctrl/sysram_region.c

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 1156a4bd0080..18cb84950500 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -31,6 +31,8 @@ int cxl_decoder_detach(struct cxl_region *cxlr,
 		       struct cxl_endpoint_decoder *cxled, int pos,
 		       enum cxl_detach_mode mode);
 
+int devm_cxl_add_sysram_region(struct cxl_region *cxlr);
+
 #define CXL_REGION_ATTR(x) (&dev_attr_##x.attr)
 #define CXL_REGION_TYPE(x) (&cxl_region_type)
 #define SET_CXL_REGION_ATTR(x) (&dev_attr_##x.attr),
diff --git a/drivers/cxl/core/memctrl/Makefile b/drivers/cxl/core/memctrl/Makefile
index 8165aad5a52a..1c52c7d75570 100644
--- a/drivers/cxl/core/memctrl/Makefile
+++ b/drivers/cxl/core/memctrl/Makefile
@@ -2,3 +2,4 @@
 
 cxl_core-$(CONFIG_CXL_REGION) += memctrl/memctrl.o
 cxl_core-$(CONFIG_CXL_REGION) += memctrl/dax_region.o
+cxl_core-$(CONFIG_CXL_REGION) += memctrl/sysram_region.o
diff --git a/drivers/cxl/core/memctrl/memctrl.c b/drivers/cxl/core/memctrl/memctrl.c
index 24e0e14b39c7..40ffb59353bb 100644
--- a/drivers/cxl/core/memctrl/memctrl.c
+++ b/drivers/cxl/core/memctrl/memctrl.c
@@ -34,6 +34,8 @@ int cxl_enable_memctrl(struct cxl_region *cxlr)
 		return devm_cxl_add_dax_region(cxlr);
 	case CXL_MEMCTRL_DAX:
 		return devm_cxl_add_dax_region(cxlr);
+	case CXL_MEMCTRL_SYSRAM:
+		return devm_cxl_add_sysram_region(cxlr);
 	default:
 		return -EINVAL;
 	}
diff --git a/drivers/cxl/core/memctrl/sysram_region.c b/drivers/cxl/core/memctrl/sysram_region.c
new file mode 100644
index 000000000000..a7570c8a54e1
--- /dev/null
+++ b/drivers/cxl/core/memctrl/sysram_region.c
@@ -0,0 +1,358 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2026 Meta Inc. All rights reserved. */
+#include <linux/memremap.h>
+#include <linux/memory.h>
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/slab.h>
+#include <linux/mm.h>
+#include <linux/memory-tiers.h>
+#include <linux/memory_hotplug.h>
+#include <linux/string_helpers.h>
+#include <linux/sched/signal.h>
+#include <cxlmem.h>
+#include <cxl.h>
+#include "../core.h"
+
+/* If HMAT was unavailable, assign a default distance. */
+#define MEMTIER_DEFAULT_CXL_ADISTANCE	(MEMTIER_ADISTANCE_DRAM * 5)
+
+static const char *sysram_name = "System RAM (CXL)";
+
+struct cxl_sysram_data {
+	const char *res_name;
+	int mgid;
+	struct resource *res;
+};
+
+static DEFINE_MUTEX(cxl_memory_type_lock);
+static LIST_HEAD(cxl_memory_types);
+
+static struct cxl_region *to_cxl_region(struct device *dev)
+{
+	if (dev->type != &cxl_region_type)
+		return NULL;
+	return container_of(dev, struct cxl_region, dev);
+}
+
+static struct memory_dev_type *cxl_find_alloc_memory_type(int adist)
+{
+	guard(mutex)(&cxl_memory_type_lock);
+	return mt_find_alloc_memory_type(adist, &cxl_memory_types);
+}
+
+static void __maybe_unused cxl_put_memory_types(void)
+{
+	guard(mutex)(&cxl_memory_type_lock);
+	mt_put_memory_types(&cxl_memory_types);
+}
+
+static int cxl_sysram_range(struct cxl_region *cxlr, struct range *r)
+{
+	struct cxl_region_params *p = &cxlr->params;
+
+	if (!p->res)
+		return -ENODEV;
+
+	/* memory-block align the hotplug range */
+	r->start = ALIGN(p->res->start, memory_block_size_bytes());
+	r->end = ALIGN_DOWN(p->res->end + 1, memory_block_size_bytes()) - 1;
+	if (r->start >= r->end) {
+		r->start = p->res->start;
+		r->end = p->res->end;
+		return -ENOSPC;
+	}
+	return 0;
+}
+
+static ssize_t hotunplug_store(struct device *dev,
+			       struct device_attribute *attr,
+			       const char *buf, size_t len)
+{
+	struct cxl_region *cxlr = to_cxl_region(dev);
+	struct range range;
+	int rc;
+
+	if (!cxlr)
+		return -ENODEV;
+
+	rc = cxl_sysram_range(cxlr, &range);
+	if (rc)
+		return rc;
+
+	rc = offline_and_remove_memory(range.start, range_len(&range));
+
+	if (rc)
+		return rc;
+
+	return len;
+}
+static DEVICE_ATTR_WO(hotunplug);
+
+struct online_memory_cb_arg {
+	int online_type;
+	int rc;
+};
+
+static int online_memory_block_cb(struct memory_block *mem, void *arg)
+{
+	struct online_memory_cb_arg *cb_arg = arg;
+
+	if (signal_pending(current))
+		return -EINTR;
+
+	cond_resched();
+
+	if (mem->state == MEM_ONLINE)
+		return 0;
+
+	mem->online_type = cb_arg->online_type;
+	cb_arg->rc = device_online(&mem->dev);
+
+	return cb_arg->rc;
+}
+
+static int offline_memory_block_cb(struct memory_block *mem, void *arg)
+{
+	int *rc = arg;
+
+	if (signal_pending(current))
+		return -EINTR;
+
+	cond_resched();
+
+	if (mem->state == MEM_OFFLINE)
+		return 0;
+
+	*rc = device_offline(&mem->dev);
+
+	return *rc;
+}
+
+static ssize_t state_store(struct device *dev,
+			   struct device_attribute *attr,
+			   const char *buf, size_t len)
+{
+	struct cxl_region *cxlr = to_cxl_region(dev);
+	struct online_memory_cb_arg cb_arg;
+	struct range range;
+	int rc;
+
+	if (!cxlr)
+		return -ENODEV;
+
+	rc = cxl_sysram_range(cxlr, &range);
+	if (rc)
+		return rc;
+
+	rc = lock_device_hotplug_sysfs();
+	if (rc)
+		return rc;
+
+	if (sysfs_streq(buf, "online")) {
+		cb_arg.online_type = MMOP_ONLINE_MOVABLE;
+		cb_arg.rc = 0;
+		rc = walk_memory_blocks(range.start, range_len(&range),
+					&cb_arg, online_memory_block_cb);
+		if (!rc)
+			rc = cb_arg.rc;
+	} else if (sysfs_streq(buf, "online_normal")) {
+		cb_arg.online_type = MMOP_ONLINE;
+		cb_arg.rc = 0;
+		rc = walk_memory_blocks(range.start, range_len(&range),
+					&cb_arg, online_memory_block_cb);
+		if (!rc)
+			rc = cb_arg.rc;
+	} else if (sysfs_streq(buf, "offline")) {
+		int offline_rc = 0;
+
+		rc = walk_memory_blocks(range.start, range_len(&range),
+					&offline_rc, offline_memory_block_cb);
+		if (!rc)
+			rc = offline_rc;
+	} else {
+		rc = -EINVAL;
+	}
+
+	unlock_device_hotplug();
+
+	if (rc)
+		return rc;
+
+	return len;
+}
+static DEVICE_ATTR_WO(state);
+
+static ssize_t hotplug_store(struct device *dev,
+			     struct device_attribute *attr,
+			     const char *buf, size_t len)
+{
+	struct cxl_region *cxlr = to_cxl_region(dev);
+	struct cxl_sysram_data *data;
+	struct range range;
+	int rc;
+
+	if (!cxlr)
+		return -ENODEV;
+
+	data = dev_get_drvdata(dev);
+	if (!data)
+		return -ENODEV;
+
+	rc = cxl_sysram_range(cxlr, &range);
+	if (rc)
+		return rc;
+
+	rc = add_memory_driver_managed(data->mgid, range.start,
+				       range_len(&range), sysram_name,
+				       MHP_NID_IS_MGID);
+	if (rc)
+		return rc;
+
+	return len;
+}
+static DEVICE_ATTR_WO(hotplug);
+
+static struct attribute *cxl_sysram_region_attrs[] = {
+	&dev_attr_hotunplug.attr,
+	&dev_attr_state.attr,
+	&dev_attr_hotplug.attr,
+	NULL,
+};
+
+static const struct attribute_group cxl_sysram_region_group = {
+	.name = "memctl",
+	.attrs = cxl_sysram_region_attrs,
+};
+
+static void cxl_sysram_unregister(void *_data)
+{
+	struct cxl_sysram_data *data = _data;
+	struct range range = {
+		.start = data->res->start,
+		.end = data->res->end
+	};
+
+	/* We have one shot for removal, otherwise it's stuck til reboot */
+	if (!offline_and_remove_memory(range.start, range_len(&range))) {
+		remove_resource(data->res);
+		kfree(data->res);
+		memory_group_unregister(data->mgid);
+		kfree(data->res_name);
+		kfree(data);
+		return;
+	}
+	pr_err("CXL: %#llx-%#llx cannot be hotremoved until next reboot\n",
+	       range.start, range.end);
+}
+
+int devm_cxl_add_sysram_region(struct cxl_region *cxlr)
+{
+	struct cxl_region_params *p = &cxlr->params;
+	struct device *dev = &cxlr->dev;
+	struct cxl_sysram_data *data;
+	struct memory_dev_type *mtype;
+	unsigned long total_len = 0;
+	struct resource *res;
+	struct range range;
+	mhp_t mhp_flags;
+	int numa_node;
+	int adist = MEMTIER_DEFAULT_CXL_ADISTANCE;
+	int rc;
+
+	numa_node = phys_to_target_node(p->res->start);
+	if (numa_node < 0) {
+		dev_warn(dev, "rejecting CXL region with invalid node: %d\n",
+			 numa_node);
+		return -EINVAL;
+	}
+
+	rc = cxl_sysram_range(cxlr, &range);
+	if (rc) {
+		dev_info(dev, "range %#llx-%#llx too small after alignment\n",
+			 range.start, range.end);
+		return rc;
+	}
+	total_len = range_len(&range);
+
+	if (!total_len) {
+		dev_warn(dev, "rejecting CXL region without any memory after alignment\n");
+		return -EINVAL;
+	}
+
+	mt_calc_adistance(numa_node, &adist);
+	mtype = cxl_find_alloc_memory_type(adist);
+	if (IS_ERR(mtype))
+		return PTR_ERR(mtype);
+
+	init_node_memory_type(numa_node, mtype);
+
+	data = kzalloc(sizeof(*data), GFP_KERNEL);
+	if (!data) {
+		rc = -ENOMEM;
+		goto err_data;
+	}
+
+	data->res_name = kstrdup(dev_name(dev), GFP_KERNEL);
+	if (!data->res_name) {
+		rc = -ENOMEM;
+		goto err_res_name;
+	}
+
+	rc = memory_group_register_static(numa_node, PFN_UP(total_len));
+	if (rc < 0)
+		goto err_reg_mgid;
+	data->mgid = rc;
+
+	/* Region is permanently reserved if hotremove fails when unbinding. */
+	res = request_mem_region(range.start, range_len(&range),
+				 data->res_name);
+	if (!res) {
+		dev_warn(dev, "range %#llx-%#llx could not reserve region\n",
+			 range.start, range.end);
+		rc = -EBUSY;
+		goto err_request_mem;
+	}
+	data->res = res;
+
+	/*
+	 * Setup flags for System RAM. Leave _BUSY clear so add_memory() can add
+	 * a child resource. Do not inherit flags from parent since it may set
+	 * flags unknown to us that will the break add_memory() below.
+	 */
+	res->flags = IORESOURCE_SYSTEM_RAM;
+	mhp_flags = MHP_NID_IS_MGID;
+	rc = add_memory_driver_managed(data->mgid, range.start,
+				       range_len(&range), sysram_name, mhp_flags);
+	if (rc) {
+		dev_warn(dev, "range %#llx-%#llx memory add failed\n",
+			 range.start, range.end);
+		goto err_add_memory;
+	}
+	dev_dbg(dev, "%s: added %llu bytes as System RAM\n", dev_name(dev),
+		(unsigned long long)total_len);
+
+	dev_set_drvdata(dev, data);
+	rc = devm_device_add_group(dev, &cxl_sysram_region_group);
+	if (rc)
+		goto err_add_group;
+
+	return devm_add_action_or_reset(dev, cxl_sysram_unregister, data);
+
+err_add_group:
+	dev_set_drvdata(dev, NULL);
+	/* if this fails, memory cannot be removed from the system until reboot */
+	remove_memory(range.start, range_len(&range));
+err_add_memory:
+	remove_resource(res);
+	kfree(res);
+err_request_mem:
+	memory_group_unregister(data->mgid);
+err_reg_mgid:
+	kfree(data->res_name);
+err_res_name:
+	kfree(data);
+err_data:
+	clear_node_memory_type(numa_node, mtype);
+	return rc;
+}
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 02d7d9ae0252..eeab091f043a 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -639,6 +639,9 @@ static ssize_t ctrl_show(struct device *dev, struct device_attribute *attr,
 	case CXL_MEMCTRL_DAX:
 		desc = "dax";
 		break;
+	case CXL_MEMCTRL_SYSRAM:
+		desc = "sysram";
+		break;
 	default:
 		desc = "";
 		break;
@@ -663,6 +666,8 @@ static ssize_t ctrl_store(struct device *dev, struct device_attribute *attr,
 
 	if (sysfs_streq(buf, "dax"))
 		cxlr->memctrl = CXL_MEMCTRL_DAX;
+	else if (sysfs_streq(buf, "sysram"))
+		cxlr->memctrl = CXL_MEMCTRL_SYSRAM;
 	else
 		return -EINVAL;
 
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index b8fabaa77262..bb4f877b4e8f 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -506,13 +506,15 @@ enum cxl_partition_mode {
 /*
  * Memory Controller modes:
  *   None - No controller selected
- *   Auto - either BIOS-configured as SysRAM, or default to DAX
- *   DAX  - creates a dax_region controller for the cxl_region
+ *   Auto   - either BIOS-configured as SysRAM, or default to DAX
+ *   DAX    - creates a dax_region controller for the cxl_region
+ *   SYSRAM - hotplugs the region directly as System RAM
  */
 enum cxl_memctrl_mode {
 	CXL_MEMCTRL_NONE,
 	CXL_MEMCTRL_AUTO,
 	CXL_MEMCTRL_DAX,
+	CXL_MEMCTRL_SYSRAM,
 };
 
 /*
-- 
2.52.0

