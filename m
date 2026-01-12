Received: from mail-qk1-f194.google.com (mail-qk1-f194.google.com [209.85.222.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68056366DCA
	for <linux-cxl@vger.kernel.org>; Mon, 12 Jan 2026 16:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768235774; cv=none; b=AEBTw2PvuwgjQSPFa1nwHf9hI2sms4Yq2uXf7K8EMnLrepkwlI5KZZoXrKKg7OR+feCUkDJiF1l2zYUU7p6L2u+Wx0O3DXC6BZBzOXBHWJt0ZBSn3kCC5illS0iRZnkmnySGC2Jk5UySiJ8KQsLJMHQcJ2TRN6X4DH6NVbMDFz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768235774; c=relaxed/simple;
	bh=a+1Vckg0Y0ApTL8FqKoFrVt3+WTxV5v3qbvQIZ1qTig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nVJmWs9T9wSI4P4vER7EG782s6ZBipSPg926NXnOPZzSNFEpqqxYWkUVQLausKkOCNX/mABmuqwE31KZS2HLTedP/cIj25gDXT8If7Lb5ulbzTKY3JwfHiw5fUoJleP/YtfAt54v//lI2PGxBgPIG6ta2/81rgp4DbkdMtY0Lto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=tokGa3cq; arc=none smtp.client-ip=209.85.222.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="tokGa3cq"
Received: by mail-qk1-f194.google.com with SMTP id af79cd13be357-8b2148ca40eso952847685a.1
        for <linux-cxl@vger.kernel.org>; Mon, 12 Jan 2026 08:36:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1768235770; x=1768840570; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z3I/G0EhDE3+slCtVTNXpav+ECSkZZ3ZPq9IZrnfZqI=;
        b=tokGa3cqkKATkXwkOfcCW+gELPPylqgG5Wk/Dbnh3lOG1wEHdCnUvyqTRAhLpM10Ik
         YcWdebp+Gr8wlP6L0VNPb/lPjjKTcMUZFn6UpwbUKU2yDeSG6kFPBiyfH+a6h/STp4bo
         hDGtyS/W+SXkLpq2awWnCb76lUBfHq4tHlJilok4DNl+M3/ejYIWUIDMy9knTb7aglxa
         h7X/AGTSZubQ8MaxPWrefF+pCBIIgrivGDrQ/sHSOleV98vDzw5bFltLPiZPgniYIoXR
         wi490uSe/Pgi1bbLHegGHwLnZIATXlcVPiaLx09J8sFRmFxVRc1iua/yWRl1iS4Zboh+
         J70g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768235770; x=1768840570;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Z3I/G0EhDE3+slCtVTNXpav+ECSkZZ3ZPq9IZrnfZqI=;
        b=dqZn1+RFLH1y7bPtGj9KvqkgX79KWb6uS/7s6510+PrXcCW32pWkKPRKz3uoI3AGop
         NKQ4O7e/rSN1obE3M70OW8rk0HzSvCk6zdll8r/pFJv8Q8RjBZUrZj8IYHzOnCE4rQBy
         x2wvGzUc9AsQPW9TSQie9pVGh4hbHX2yzQKcv90MisM1fKcvP4AM5cn9DnhJ1a9X8QPe
         PWbWUdvAl6G4eN3o7wEvmLrrsxJp3Tj4IgC2SurlBfzAGnRJ+hMGc3EqwGkZiXWWqhYE
         R3wIg/IbJ3sX9G0CrHg6d6Khumv6FqSWNFH3qUTVSXnJS6yCbOapudzSFLua+AYv7BNU
         mPQA==
X-Gm-Message-State: AOJu0YwGhiuL6sWUUML195SfFBYaEsRigu85LncvvSwDTj4dC+af6ffs
	GGJ4w0KJ3h3gs3BrI4AAbAPXRAkYiQ55+sPu25vZGquX9XwTeX8+RIFDu89BlvS6Ckl9pKHT6+D
	gBq7X
X-Gm-Gg: AY/fxX7nbMYCAmmHsZJhic2ee36WA2Yxjyhofz46QoUX8grxf4jUaciWmQhtCLKCVR9
	TBOcxeHg7nDFhD9CWRYL11BzWjlRBUowvrMLpgNQZabkYkuTX3wpqSAfUxxQtieiaCstDMnVKvp
	/KtYDAGh8hsw4N7OM5m/nGAPwV5NvGiFw+1XsjCwqfU9Uof1rHmuvZQm49V230L39O4BOX6qoaY
	rc0U0IyyD8zsuUv1wAH21nP8Ab7BedN3+lvXrKwS6K1YJdJ3EY8oqxn9xLOqdxf/YH/VRbqWIib
	17EXLciencC2Pf2IUc5L0IynInxjwMSdUmd5KLsjWvMu/M9+eRXoPeBpwhrMPGYov60M4pn5Y4v
	txoE2TM+53adSGWX67Giss2Me2oSA9WtmsPenNBK28MPhTPod2hsP4rFQVtsVD3odQ4KLY4gwVs
	X587BUdO142m4E49YJOIH+riuvPV0nSUrT9Zhtl37Or73YtLSYuEIDUm5E19QHBOKtymCL1asFy
	iL0amdYZvdmZg==
X-Google-Smtp-Source: AGHT+IGBEMDopMAuDTiFSKsXIeUiEcVCCbmKNNb05D/QQ5LDaD26f9NZnIUwZpZW1w2CXBV00G3MkA==
X-Received: by 2002:a05:620a:440d:b0:8ba:41b2:da01 with SMTP id af79cd13be357-8c389411960mr2326124585a.71.1768235770092;
        Mon, 12 Jan 2026 08:36:10 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c37f4a7962sm1489152685a.11.2026.01.12.08.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 08:36:09 -0800 (PST)
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
	David Hildenbrand <david@kernel.org>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 6/6] cxl/sysram: disallow onlining in ZONE_NORMAL if state is movable only
Date: Mon, 12 Jan 2026 11:35:14 -0500
Message-ID: <20260112163514.2551809-7-gourry@gourry.net>
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

If state is set to online (default to ZONE_MOVABLE), the user intends
for this memory to either refuse non-movable allocations, and/or intends
to preserve the hot-unpluggability of this memory.  However, any admin
can write `offline` and `online` to the memory block controller and
bring that memory online in ZONE_NORMAL.

Register a memory_notify callback that disallows onlining the block into
ZONE_NORMAL if the default state of the controller is ZONE_MOVABLE.

If an actor attempts to online the block into ZONE_NORMAL, it will fail,
but if it attempts to online into either NORMAL or MOVABLE, only MOVABLE
will be allowed and it will succeed.

Suggested-by: David Hildenbrand <david@kernel.org>
Suggested-by: Hannes Reinecke <hare@suse.de>
Link: https://lore.kernel.org/linux-mm/39533aa8-ca78-41a8-b005-9202ce53e3ae@kernel.org/
Signed-off-by: Gregory Price <gourry@gourry.net>
---
 drivers/cxl/core/memctrl/sysram_region.c | 138 +++++++++++++++++++++--
 1 file changed, 127 insertions(+), 11 deletions(-)

diff --git a/drivers/cxl/core/memctrl/sysram_region.c b/drivers/cxl/core/memctrl/sysram_region.c
index 2e2d9b59a725..71e39d725dc5 100644
--- a/drivers/cxl/core/memctrl/sysram_region.c
+++ b/drivers/cxl/core/memctrl/sysram_region.c
@@ -2,6 +2,7 @@
 /* Copyright(c) 2026 Meta Inc. All rights reserved. */
 #include <linux/memremap.h>
 #include <linux/memory.h>
+#include <linux/mmzone.h>
 #include <linux/module.h>
 #include <linux/device.h>
 #include <linux/slab.h>
@@ -23,6 +24,14 @@ struct cxl_sysram_data {
 	const char *res_name;
 	int mgid;
 	struct resource *res;
+	struct range range;
+	struct notifier_block memory_notifier;
+	/*
+	 * Last online type requested by user via state sysfs or auto-online.
+	 * Used to enforce zone consistency when memory blocks are onlined.
+	 * MMOP_OFFLINE means no online preference has been set yet.
+	 */
+	int last_online_type;
 };
 
 static DEFINE_MUTEX(cxl_memory_type_lock);
@@ -158,7 +167,58 @@ static int cxl_sysram_offline_memory(struct range *range)
 	return rc;
 }
 
-static int cxl_sysram_auto_online(struct device *dev, struct range *range)
+/*
+ * Memory notifier callback to enforce zone consistency.
+ *
+ * When the user (or auto-online) requests memory to be onlined into
+ * ZONE_MOVABLE, reject any subsequent attempts to online memory blocks
+ * from this region into a different zone (e.g., ZONE_NORMAL). This prevents
+ * accidental zone mixing which could lead to memory fragmentation and
+ * offlining failures.
+ */
+static int cxl_sysram_memory_notify_cb(struct notifier_block *nb,
+				       unsigned long action, void *arg)
+{
+	struct cxl_sysram_data *data = container_of(nb, struct cxl_sysram_data,
+						    memory_notifier);
+	struct memory_notify *mhp = arg;
+	unsigned long start_phys = PFN_PHYS(mhp->start_pfn);
+	unsigned long size = PFN_PHYS(mhp->nr_pages);
+	struct page *page;
+
+	if (action != MEM_GOING_ONLINE)
+		return NOTIFY_DONE;
+
+	/* Check if this memory block overlaps with our region */
+	if (start_phys + size <= data->range.start ||
+	    start_phys > data->range.end)
+		return NOTIFY_DONE;
+
+	/*
+	 * If no online preference has been set (MMOP_OFFLINE), allow any zone.
+	 * Also allow if the preference wasn't for ZONE_MOVABLE.
+	 */
+	if (data->last_online_type != MMOP_ONLINE_MOVABLE)
+		return NOTIFY_DONE;
+
+	/*
+	 * The zone has already been assigned to the pages at this point
+	 * via move_pfn_range_to_zone() before MEM_GOING_ONLINE is sent.
+	 * Check if it's ZONE_MOVABLE as expected.
+	 */
+	page = pfn_to_page(mhp->start_pfn);
+
+	if (!is_zone_movable_page(page)) {
+		pr_warn("CXL sysram: rejecting online to non-movable zone for range %#lx-%#lx (expected ZONE_MOVABLE)\n",
+			start_phys, start_phys + size - 1);
+		return NOTIFY_BAD;
+	}
+
+	return NOTIFY_OK;
+}
+
+static int cxl_sysram_auto_online(struct device *dev, struct range *range,
+				  struct cxl_sysram_data *data)
 {
 	int online_type;
 	int rc;
@@ -173,6 +233,9 @@ static int cxl_sysram_auto_online(struct device *dev, struct range *range)
 	else
 		online_type = MMOP_ONLINE_MOVABLE;
 
+	/* Record the auto-online type for zone enforcement */
+	data->last_online_type = online_type;
+
 	rc = lock_device_hotplug_sysfs();
 	if (rc)
 		return rc;
@@ -187,17 +250,43 @@ static int cxl_sysram_auto_online(struct device *dev, struct range *range)
 	return rc;
 }
 
+static ssize_t state_show(struct device *dev,
+			  struct device_attribute *attr, char *buf)
+{
+	struct cxl_sysram_data *data;
+
+	data = dev_get_drvdata(dev);
+	if (!data)
+		return -ENODEV;
+
+	switch (data->last_online_type) {
+	case MMOP_ONLINE_MOVABLE:
+		return sysfs_emit(buf, "online\n");
+	case MMOP_ONLINE_KERNEL:
+		return sysfs_emit(buf, "online_normal\n");
+	case MMOP_OFFLINE:
+	default:
+		return sysfs_emit(buf, "offline\n");
+	}
+}
+
 static ssize_t state_store(struct device *dev,
 			   struct device_attribute *attr,
 			   const char *buf, size_t len)
 {
 	struct cxl_region *cxlr = to_cxl_region(dev);
+	struct cxl_sysram_data *data;
 	struct range range;
+	int online_type = MMOP_OFFLINE;
 	int rc;
 
 	if (!cxlr)
 		return -ENODEV;
 
+	data = dev_get_drvdata(dev);
+	if (!data)
+		return -ENODEV;
+
 	rc = cxl_sysram_range(cxlr, &range);
 	if (rc)
 		return rc;
@@ -206,23 +295,30 @@ static ssize_t state_store(struct device *dev,
 	if (rc)
 		return rc;
 
-	if (sysfs_streq(buf, "online"))
-		rc = cxl_sysram_online_memory(&range, MMOP_ONLINE_MOVABLE);
-	else if (sysfs_streq(buf, "online_normal"))
-		rc = cxl_sysram_online_memory(&range, MMOP_ONLINE);
-	else if (sysfs_streq(buf, "offline"))
+	if (sysfs_streq(buf, "online")) {
+		online_type = MMOP_ONLINE_MOVABLE;
+		rc = cxl_sysram_online_memory(&range, online_type);
+	} else if (sysfs_streq(buf, "online_normal")) {
+		online_type = MMOP_ONLINE;
+		rc = cxl_sysram_online_memory(&range, online_type);
+	} else if (sysfs_streq(buf, "offline")) {
 		rc = cxl_sysram_offline_memory(&range);
-	else
+	} else {
 		rc = -EINVAL;
+	}
 
 	unlock_device_hotplug();
 
 	if (rc)
 		return rc;
 
+	/* Record the online type for zone enforcement on success */
+	if (online_type != MMOP_OFFLINE)
+		data->last_online_type = online_type;
+
 	return len;
 }
-static DEVICE_ATTR_WO(state);
+static DEVICE_ATTR_RW(state);
 
 static ssize_t hotplug_store(struct device *dev,
 			     struct device_attribute *attr,
@@ -274,6 +370,11 @@ static void cxl_sysram_unregister(void *_data)
 		.end = data->res->end
 	};
 
+	unregister_memory_notifier(&data->memory_notifier);
+
+	range.start = data->res->start;
+	range.end = data->res->end;
+
 	/* We have one shot for removal, otherwise it's stuck til reboot */
 	if (!offline_and_remove_memory(range.start, range_len(&range))) {
 		remove_resource(data->res);
@@ -334,6 +435,10 @@ int devm_cxl_add_sysram_region(struct cxl_region *cxlr)
 		goto err_data;
 	}
 
+	/* Initialize range and online type tracking */
+	data->range = range;
+	data->last_online_type = MMOP_OFFLINE;
+
 	data->res_name = kstrdup(dev_name(dev), GFP_KERNEL);
 	if (!data->res_name) {
 		rc = -ENOMEM;
@@ -373,11 +478,20 @@ int devm_cxl_add_sysram_region(struct cxl_region *cxlr)
 	dev_dbg(dev, "%s: added %llu bytes as System RAM\n", dev_name(dev),
 		(unsigned long long)total_len);
 
-	rc = cxl_sysram_auto_online(dev, &range);
+	/* Set drvdata early so auto_online can access it */
+	dev_set_drvdata(dev, data);
+
+	/* Register memory notifier for zone enforcement */
+	data->memory_notifier.notifier_call = cxl_sysram_memory_notify_cb;
+	data->memory_notifier.priority = CXL_CALLBACK_PRI;
+	rc = register_memory_notifier(&data->memory_notifier);
+	if (rc)
+		goto err_notifier;
+
+	rc = cxl_sysram_auto_online(dev, &range, data);
 	if (rc)
 		goto err_auto_online;
 
-	dev_set_drvdata(dev, data);
 	rc = devm_device_add_group(dev, &cxl_sysram_region_group);
 	if (rc)
 		goto err_add_group;
@@ -385,9 +499,11 @@ int devm_cxl_add_sysram_region(struct cxl_region *cxlr)
 	return devm_add_action_or_reset(dev, cxl_sysram_unregister, data);
 
 err_add_group:
-	dev_set_drvdata(dev, NULL);
 err_auto_online:
 	/* if this fails, memory cannot be removed from the system until reboot */
+	unregister_memory_notifier(&data->memory_notifier);
+err_notifier:
+	dev_set_drvdata(dev, NULL);
 	remove_memory(range.start, range_len(&range));
 err_add_memory:
 	remove_resource(res);
-- 
2.52.0

