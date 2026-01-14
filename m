Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769CA387348
	for <linux-cxl@vger.kernel.org>; Wed, 14 Jan 2026 08:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768380780; cv=none; b=SAZwK/2F+Mx+u1lQvYrRJ17wxmI3wwjICWlfFyP5kdPirppBDjuA+HA3O38T12voWQnKsodjCIGedj7O54Jx3yrYm9b6rXeUItjNMORq5Nl86PM07JFleRbehIRlyV6e1DIGTJI4QuaOF1HKIiMLo0Q58gnr2k0e+hZ7iNpIe5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768380780; c=relaxed/simple;
	bh=OO8AZtRwM9LO6XTgvISWCqOrzA8jABISGNYxC+F/ODM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lEciW5GKaztgxaOunXnS7DMfhcinqtv4+b6OgAL35pQClPZEcrUfE5WKmjna++zpKtXvvUgf3KGZfzXdyogAfVo8YKZnWPaW0lZiuj8fDWZjpHQmwOinaS/Eo77lUEuq0NaYiuF962lY9woDR4GSQtFYZ7UXnNelkb7D7LOHVh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=s4UZPD+y; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="s4UZPD+y"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-5014b7de222so3571321cf.0
        for <linux-cxl@vger.kernel.org>; Wed, 14 Jan 2026 00:52:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1768380768; x=1768985568; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qkrYA1tOx7DkpeW8XgsApRQxl0EKaXZdk0Npo4TW1Lg=;
        b=s4UZPD+yjLulTikC4k19QMINzYDvPXFSdJu+1EhyRws2AS2bikmf5f6VqJk/qP7IaW
         mWVjX0EbP6Y83jCUSd6uBgvKk9hPiMGz25E5Gig5Vjs78GoBdn6R7a1B8+N+speHtpBs
         VBxnc56/93PKnBPITjbhzhmii7+lBShzdVCj30N8Hngwv7IhuvjxyqLo8EAnVOMU3xqX
         r3LKeSQ5vAR9Cv8D6AQJOQu9wywlFpsp6JtcwLFwAo69vbT7cA8oqMl9+V3W/ti90kAs
         kfmPnwKIHrb4GOfKQ9bo81sXUveqhp2jRF9E0fzNyCPzesE+skZVSaXKgAWKh4f0rZDx
         p3kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768380768; x=1768985568;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qkrYA1tOx7DkpeW8XgsApRQxl0EKaXZdk0Npo4TW1Lg=;
        b=UxPG3+icAUSh2EQzjEWMYNUjMoikS29SbI9dGps0XU3B9dCoMxb7yd7Qmjj8EbysF3
         wvtcYQjsQAr/yLhdByJG5KJNJYpSt1FBFUZUvHC2zrN2bR2VisK5oXgR4rsdWtpvRMHG
         nEoOkjT2neQ2V7NiapQu8qYyy8FTBIcTvHUDGFx0vSlM7DVfo25Z2oVFIZ+hCRkzGAYo
         ZVqyc7/gWXvwIIeuJS58SsUgQwOaTDwyUIZSMNWUUWYRBIaFeln3wtE7x6rAV/jh+M2a
         O4hIUhYs/64Bs4YBSq3zQ6kvjt1Tj0SdXpRwOVAn30JBW5SBmSovbi8453/0hbGj3XgJ
         lhdw==
X-Gm-Message-State: AOJu0YyzaLBUii0aZASHuLcvOsaA+kd66m7CrEeNXUCoPvagYTUOQOIo
	fcHrE50PeLNmOiU2Turmq0OQD1wzcCJdCBLZ2ovzleaNSeyBIIXfXvlECd/nhwJLcFU=
X-Gm-Gg: AY/fxX4fLuTecbbkJNPWXNSWTAxDE4EDFYDyPXxipKrMZiQYaFBw6AIqX/XIgZS1XR5
	c5MQaWBqzZUh09nL2vA7e/l3VqXRXTsbyh0y5FHjXR9wdjnJJk/HFe4RLAD/K+q6Y118uKmXBMv
	7zLXORMYnWnZXSiQ0ibyHXFSTOwGSpIwJbeL5ACxQdVcSKgBgIqYRCaJLNi1fuV78ZEoNt4ERbB
	mnXtuiu+I99VMnliLOj8qGCSbOu4ouL9w68VhR+mnIOfiFKw11fqkeAtap2PmEphjldfkr+rx5p
	fP0nW9gb/zL+cllwNltW2THOOiPQMeQdl4k7er0uEJW5dErCMtDJOApIX5lnPXDW/9JnLHskObn
	NLfnFds94U6/IGWjxa+/hJhKFsNrCx76JLuT7nIEdh8m4HqNkTHUXCRQ+h5HZMFfoeR6Dcp2B+l
	xDaHNkm61kghvZPc2Te12vhgFeKvYzCm5rF9//akie/zo22Zi73J9MsflNPVtr90XOhkmZ/Vx+K
	gU=
X-Received: by 2002:a05:622a:50f:b0:501:4996:8e73 with SMTP id d75a77b69052e-5014a967795mr12209691cf.66.1768380768198;
        Wed, 14 Jan 2026 00:52:48 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50148df8759sm10131931cf.10.2026.01.14.00.52.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 00:52:47 -0800 (PST)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: linux-cxl@vger.kernel.org,
	nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev,
	kernel-team@meta.com,
	dan.j.williams@intel.com,
	vishal.l.verma@intel.com,
	dave.jiang@intel.com,
	david@kernel.org,
	mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	osalvador@suse.de,
	akpm@linux-foundation.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 8/8] dax/kmem: add memory notifier to block external state changes
Date: Wed, 14 Jan 2026 03:52:00 -0500
Message-ID: <20260114085201.3222597-9-gourry@gourry.net>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260114085201.3222597-1-gourry@gourry.net>
References: <20260114085201.3222597-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a memory notifier to prevent external operations from changing the
online/offline state of memory blocks managed by dax_kmem. This ensures
state changes only occur through the driver's hotplug sysfs interface,
providing consistent state tracking and preventing races with auto-online
policies or direct memory block sysfs manipulation.

The notifier uses a transition protocol with memory barriers:
  - Before initiating a state change, set target_state then in_transition
  - Use a barrier to ensure target_state is visible before in_transition
  - The notifier checks in_transition, then uses barrier before reading
    target_state to ensure proper ordering on weakly-ordered architectures

The notifier callback:
  - Returns NOTIFY_DONE for non-overlapping memory (not our concern)
  - Returns NOTIFY_BAD if in_transition is false (block external ops)
  - Validates the memory event matches target_state (MEM_GOING_ONLINE
    for online operations, MEM_GOING_OFFLINE for offline/unplug)
  - Returns NOTIFY_OK only for driver-initiated operations with matching
    target_state

This prevents scenarios where:
  - Auto-online policies re-online memory the driver is trying to offline
  - Users manually change memory state via /sys/devices/system/memory/
  - Other kernel subsystems interfere with driver-managed memory state

Suggested-by: Hannes Reinecke <hare@suse.de>
Suggested-by: David Hildenbrand <david@kernel.org>
Signed-off-by: Gregory Price <gourry@gourry.net>
---
 drivers/dax/kmem.c | 164 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 160 insertions(+), 4 deletions(-)

diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
index 6d73c44e4e08..b604da8b3fe1 100644
--- a/drivers/dax/kmem.c
+++ b/drivers/dax/kmem.c
@@ -53,6 +53,9 @@ struct dax_kmem_data {
 	struct dev_dax *dev_dax;
 	int state;
 	struct mutex lock; /* protects hotplug state transitions */
+	bool in_transition;
+	int target_state;
+	struct notifier_block mem_nb;
 	struct resource *res[];
 };
 
@@ -71,6 +74,116 @@ static void kmem_put_memory_types(void)
 	mt_put_memory_types(&kmem_memory_types);
 }
 
+/**
+ * dax_kmem_start_transition - begin a driver-initiated state transition
+ * @data: the dax_kmem_data structure
+ * @target: the target state (MMOP_ONLINE, MMOP_ONLINE_MOVABLE, or MMOP_OFFLINE)
+ *
+ * Sets up state for a driver-initiated memory operation. The memory notifier
+ * will only allow operations that match this target state while in transition.
+ * Uses store-release to ensure target_state is visible before in_transition.
+ */
+static void dax_kmem_start_transition(struct dax_kmem_data *data, int target)
+{
+	data->target_state = target;
+	smp_store_release(&data->in_transition, true);
+}
+
+/**
+ * dax_kmem_end_transition - end a driver-initiated state transition
+ * @data: the dax_kmem_data structure
+ *
+ * Clears the in_transition flag after a state change completes or aborts.
+ */
+static void dax_kmem_end_transition(struct dax_kmem_data *data)
+{
+	WRITE_ONCE(data->in_transition, false);
+}
+
+/**
+ * dax_kmem_overlaps_range - check if a memory range overlaps with this device
+ * @data: the dax_kmem_data structure
+ * @start: start physical address of the range to check
+ * @size: size of the range to check
+ *
+ * Returns true if the range overlaps with any of the device's memory ranges.
+ */
+static bool dax_kmem_overlaps_range(struct dax_kmem_data *data,
+				    u64 start, u64 size)
+{
+	struct dev_dax *dev_dax = data->dev_dax;
+	int i;
+
+	for (i = 0; i < dev_dax->nr_range; i++) {
+		struct range range;
+		struct range check = DEFINE_RANGE(start, start + size - 1);
+
+		if (dax_kmem_range(dev_dax, i, &range))
+			continue;
+
+		if (!data->res[i])
+			continue;
+
+		if (range_overlaps(&range, &check))
+			return true;
+	}
+	return false;
+}
+
+/**
+ * dax_kmem_memory_notifier_cb - memory notifier callback for dax kmem
+ * @nb: the notifier block (embedded in dax_kmem_data)
+ * @action: the memory event (MEM_GOING_ONLINE, MEM_GOING_OFFLINE, etc.)
+ * @arg: pointer to memory_notify structure
+ *
+ * This callback prevents external operations (e.g., from sysfs or auto-online
+ * policies) on memory blocks managed by dax_kmem. Only operations initiated
+ * by the driver itself (via the hotplug sysfs interface) are allowed.
+ *
+ * Returns NOTIFY_OK to allow the operation, NOTIFY_BAD to block it,
+ * or NOTIFY_DONE if the memory doesn't belong to this device.
+ */
+static int dax_kmem_memory_notifier_cb(struct notifier_block *nb,
+				       unsigned long action, void *arg)
+{
+	struct dax_kmem_data *data = container_of(nb, struct dax_kmem_data,
+						  mem_nb);
+	struct memory_notify *mhp = arg;
+	const u64 start = PFN_PHYS(mhp->start_pfn);
+	const u64 size = PFN_PHYS(mhp->nr_pages);
+
+	/* Only interested in going online/offline events */
+	if (action != MEM_GOING_ONLINE && action != MEM_GOING_OFFLINE)
+		return NOTIFY_DONE;
+
+	/* Check if this memory belongs to our device */
+	if (!dax_kmem_overlaps_range(data, start, size))
+		return NOTIFY_DONE;
+
+	/*
+	 * Block all operations unless we're in a driver-initiated transition.
+	 * When in_transition is set, only allow operations that match our
+	 * target_state to prevent races with external operations.
+	 *
+	 * Use load-acquire to pair with the store-release in
+	 * dax_kmem_start_transition(), ensuring target_state is visible.
+	 */
+	if (!smp_load_acquire(&data->in_transition))
+		return NOTIFY_BAD;
+
+	/* Online operations expect MEM_GOING_ONLINE */
+	if (action == MEM_GOING_ONLINE &&
+	    (data->target_state == MMOP_ONLINE ||
+	     data->target_state == MMOP_ONLINE_MOVABLE))
+		return NOTIFY_OK;
+
+	/* Offline/hotremove operations expect MEM_GOING_OFFLINE */
+	if (action == MEM_GOING_OFFLINE && data->target_state == MMOP_OFFLINE)
+		return NOTIFY_OK;
+
+	return NOTIFY_BAD;
+}
+
 /**
  * dax_kmem_do_hotplug - hotplug memory for dax kmem device
  * @dev_dax: the dev_dax instance
@@ -375,11 +488,27 @@ static ssize_t hotplug_store(struct device *dev, struct device_attribute *attr,
 	if (data->state == online_type)
 		return len;
 
+	/*
+	 * Start transition with target_state for the notifier.
+	 * For unplug, use MMOP_OFFLINE since memory goes offline before removal.
+	 */
+	if (online_type == DAX_KMEM_UNPLUGGED || online_type == MMOP_OFFLINE)
+		dax_kmem_start_transition(data, MMOP_OFFLINE);
+	else
+		dax_kmem_start_transition(data, online_type);
+
 	if (online_type == DAX_KMEM_UNPLUGGED) {
+		int expected = 0;
+
+		for (rc = 0; rc < dev_dax->nr_range; rc++)
+			if (data->res[rc])
+				expected++;
+
 		rc = dax_kmem_do_hotremove(dev_dax, data);
-		if (rc < 0) {
+		dax_kmem_end_transition(data);
+		if (rc < expected) {
 			dev_warn(dev, "hotplug state is inconsistent\n");
-			return rc;
+			return rc == 0 ? -EBUSY : -EIO;
 		}
 		data->state = DAX_KMEM_UNPLUGGED;
 		return len;
@@ -387,9 +516,12 @@ static ssize_t hotplug_store(struct device *dev, struct device_attribute *attr,
 
 	if (online_type == MMOP_OFFLINE) {
 		/* Can only offline from an online state */
-		if (data->state != MMOP_ONLINE && data->state != MMOP_ONLINE_MOVABLE)
+		if (data->state != MMOP_ONLINE && data->state != MMOP_ONLINE_MOVABLE) {
+			dax_kmem_end_transition(data);
 			return -EINVAL;
+		}
 		rc = dax_kmem_do_offline(dev_dax, data);
+		dax_kmem_end_transition(data);
 		if (rc < 0) {
 			dev_warn(dev, "hotplug state is inconsistent\n");
 			return rc;
@@ -401,14 +533,18 @@ static ssize_t hotplug_store(struct device *dev, struct device_attribute *attr,
 	/* online_type is MMOP_ONLINE or MMOP_ONLINE_MOVABLE */
 
 	/* Cannot switch between online types without offlining first */
-	if (data->state == MMOP_ONLINE || data->state == MMOP_ONLINE_MOVABLE)
+	if (data->state == MMOP_ONLINE || data->state == MMOP_ONLINE_MOVABLE) {
+		dax_kmem_end_transition(data);
 		return -EBUSY;
+	}
 
 	if (data->state == MMOP_OFFLINE)
 		rc = dax_kmem_do_online(dev_dax, data, online_type);
 	else
 		rc = dax_kmem_do_hotplug(dev_dax, data, online_type);
 
+	dax_kmem_end_transition(data);
+
 	if (rc < 0)
 		return rc;
 
@@ -490,12 +626,25 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
 
 	dev_set_drvdata(dev, data);
 
+	/* Register memory notifier to block external operations */
+	data->mem_nb.notifier_call = dax_kmem_memory_notifier_cb;
+	rc = register_memory_notifier(&data->mem_nb);
+	if (rc) {
+		dev_warn(dev, "failed to register memory notifier\n");
+		goto err_notifier;
+	}
+
 	/*
 	 * Hotplug the memory using the system default online policy.
 	 * This preserves backwards compatibility for existing users who
 	 * rely on auto-online behavior.
+	 *
+	 * Start transition with resolved system default since the notifier
+	 * validates the operation type matches.
 	 */
+	dax_kmem_start_transition(data, mhp_get_default_online_type());
 	rc = dax_kmem_do_hotplug(dev_dax, data, MMOP_SYSTEM_DEFAULT);
+	dax_kmem_end_transition(data);
 	if (rc < 0)
 		goto err_hotplug;
 	/*
@@ -511,6 +660,8 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
 	return 0;
 
 err_hotplug:
+	unregister_memory_notifier(&data->mem_nb);
+err_notifier:
 	dev_set_drvdata(dev, NULL);
 	memory_group_unregister(data->mgid);
 err_reg_mgid:
@@ -538,12 +689,15 @@ static void dev_dax_kmem_remove(struct dev_dax *dev_dax)
 	 * there is no way to hotremove this memory until reboot because device
 	 * unbind will succeed even if we return failure.
 	 */
+	dax_kmem_start_transition(data, MMOP_OFFLINE);
 	success = dax_kmem_do_hotremove(dev_dax, data);
+	dax_kmem_end_transition(data);
 	if (success < dev_dax->nr_range) {
 		dev_err(dev, "Hotplug regions stuck online until reboot\n");
 		return;
 	}
 
+	unregister_memory_notifier(&data->mem_nb);
 	memory_group_unregister(data->mgid);
 	kfree(data->res_name);
 	kfree(data);
@@ -561,8 +715,10 @@ static void dev_dax_kmem_remove(struct dev_dax *dev_dax)
 static void dev_dax_kmem_remove(struct dev_dax *dev_dax)
 {
 	struct device *dev = &dev_dax->dev;
+	struct dax_kmem_data *data = dev_get_drvdata(dev);
 
 	device_remove_file(dev, &dev_attr_hotplug);
+	unregister_memory_notifier(&data->mem_nb);
 
 	/*
 	 * Without hotremove purposely leak the request_mem_region() for the
-- 
2.52.0

