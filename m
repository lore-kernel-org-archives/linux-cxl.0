Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E70F3D7D67
	for <linux-cxl@vger.kernel.org>; Wed, 24 Jun 2026 14:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782313095; cv=none; b=uWoLNnBdZH2IxM7ly/wHo72eL3rzZ5Qb4dkkXJDmXL477ViLcPTUlTNvfy9eH4zw2iDBwKrjtWkCbbtDfWM69/DYSvS75W4nk236ZOYeVt1n3XSeX+an5plVMyupBkIbGnC/i5A5iwsJIfViLQOC3ZInT7VtiXl3ms3l8eVff90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782313095; c=relaxed/simple;
	bh=BZ/UFvQHPYbo3CBM5/POf64lDsBt4/Fy986FoGYI7B4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fp7upQ9c1ghArpFbnBxL8lHDSNECawW1ssqJUtYRMPX4T0NVxQlKUy60TrFsmuD8JpxZsPD90NArsxG5mXqCuFt/BxciVbGV6qPlyQKjGVxsocPVy/XCadqA+6oH51bBZpYaVkVC7HKxnUMSgJsaE8Y8OVFYIVYPUeCs/mPdJbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=s22IcJ5e; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="s22IcJ5e"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-5177945a22eso7810061cf.1
        for <linux-cxl@vger.kernel.org>; Wed, 24 Jun 2026 07:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1782313092; x=1782917892; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GLv7yvsJyJMTMKtB8MLtFXICrKv3HRFHSZL0ZVu3e8M=;
        b=s22IcJ5efZdYGSWDoLB8vp4GBR2uAJ4QEdo9jzyIU/dHBDSSYaUtLC26JmAX6XR4B7
         izc7dkqAPWDXBrSsyPZ/nlaLR5egHg+a50QLiexTrLkjnDYK5VjvKgWo9BPQmMzr53cj
         SEGGzuiBTcLUI6t3GtS9YpwyrrpkRcLoJa4I4LM4wbkAu9+HSw1HcZZBvfNODJo1jEPF
         ojOtAFMX5UlJhPNDtyhMKbf4dBqPef3vh3Uq6gWdhVVplXFKTKY1+z6rjNSlIdSiEHGE
         03Aog6E/1bswT+rKTZl84fuRsYyu/PonRpU7hPoCt80/RqqvJ0flRUb/OAdpjq1I8Dy5
         ka3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782313092; x=1782917892;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GLv7yvsJyJMTMKtB8MLtFXICrKv3HRFHSZL0ZVu3e8M=;
        b=ZcCetHlGgV+BJtRYFk+7VYGaEOzoeDpB4oyGZvdmF2lgKeIJgYA+LkeCLIVAG0NK5A
         GZV9SL7a/BUqsQpandUUngKrW2TJA3dO4X5F1PD/ifuLh/dcxOFUoSf6Ixmra+Q6NFB8
         T9prssV6HiiSbMpITXycLTcEsju2/zFs2Em6Un0anRCzFCpGbfOd3mZga/Lj/weANBb+
         5kUdhvDKquWeXdftCyBRRvbDReeYcgflFjoaLp4jYm509/TdAKQ33hdfm/kpp5ZIIb/l
         6OOd2pj/doh7XBAD2LJ0Y5q/7HC6Mcy/oT7Gv89xCz9sj7XRlcQeIgxQ3XC7T4Wuy0mN
         VSKw==
X-Forwarded-Encrypted: i=1; AFNElJ9C/IJ9d27IM1704J2S/s4ikTQEZK5fHta6pPdiSUXybcKBt5UHvIbQK8TKiydow2/o0yW9ntYEzo4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxgB0bBUp8bWEoFJ5HjrPM7umS54qsMxa7kJMZpyvkNIaP/Nkn
	enkcuJ5AD4OEt7mfLTiKNE73a5yLJY305sGII6qB+QEXfy2YsNIxyY0/UBijt3/pBCM=
X-Gm-Gg: AfdE7ck4UQiDQ6CXtksUo8XGpGiPA2MTcSDZnwa/iWZVb7ndIeKpMu6n64NzLFxuN5L
	4bgOakdHovM3hGhkm+GthmhAAY9fJR3Q3vy64O14rgsVZ+Nwx/M+aDaMBmmc3VvCLInZhpwbOqZ
	2uLTwJ29dBeQjHIqNK+C3pvc5DrHVIDEZQgil1WZsP/NPq8nKyI9uWQWx1ygNjDZRjT0Wg9vdKc
	aD0HZypnJiuJd2wskW6dwlWY7rMHXaPZBQ1prcJEtZr9dHd8tEG/qqtS/Uc17unz5/wq7EnCUZG
	zglPjPrYOt5PZnVxeZS/AfgBfaknhTkR5P8Fv4QNlJ2avNiR1AnpSjR7QBKAm+76wLGbIYqo7KB
	4MPo6jzWBzSYbC0lzI6m3gSaWPc+wa+eX1b5WpbaOiFUD9kta/DW+yVS1phmG0eHWH6xmTv+kly
	MMVT64GURbBT1Om+SNIHq5ftDMnmLgAuKQYpDya10ZzSAP+YfflOa0yXZUTN0UcT3QmSM8W6tBg
	g==
X-Received: by 2002:ac8:7c41:0:b0:517:905d:dc72 with SMTP id d75a77b69052e-51a61d7e679mr54934151cf.18.1782313092082;
        Wed, 24 Jun 2026 07:58:12 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51a51ae8ee7sm49502301cf.24.2026.06.24.07.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 07:58:11 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org,
	nvdimm@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	driver-core@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	kernel-team@meta.com,
	david@kernel.org,
	osalvador@suse.de,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	dakr@kernel.org,
	djbw@kernel.org,
	vishal.l.verma@intel.com,
	dave.jiang@intel.com,
	akpm@linux-foundation.org,
	ljs@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	shuah@kernel.org,
	gourry@gourry.net,
	alison.schofield@intel.com,
	Smita.KoralahalliChannabasappa@amd.com,
	ira.weiny@intel.com,
	apopple@nvidia.com,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH v5 8/9] dax/kmem: add sysfs interface for atomic whole-device hotplug
Date: Wed, 24 Jun 2026 10:57:43 -0400
Message-ID: <20260624145744.3532049-9-gourry@gourry.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260624145744.3532049-1-gourry@gourry.net>
References: <20260624145744.3532049-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is no atomic mechanism to offline and remove an entire
multi-block DAX kmem device.  This is presently done in two steps:
    1. offline all
    2. remove all).

This creates a race condition where another entity operates directly
on the memory blocks and can cause hot-unplug to fail / unbind to
deadlock.

Add a new 'state' sysfs attribute that enables an atomic whole-device
hotplug operation across its entire memory region.

daxX.Y/state mirrors the per-block memoryX/state ABI:
  - [offline, online, online_kernel, online_movable]
  - "unplugged" - is added specifically for dax0.0/state

The valid writable states include:
  - "unplugged":      memory blocks are not present
  - "online":         memory is online, zone chosen by the kernel
  - "online_kernel":  memory is online in ZONE_NORMAL
  - "online_movable": memory is online in ZONE_MOVABLE

Valid transitions:
  - unplugged                -> online[_kernel|_movable]
  - online[_kernel|_movable] -> unplugged
  - offline                  -> unplugged

A device can only be onlined from "unplugged", so it must be returned
there before being onlined into a different state.

For backwards compatibility the memory blocks are always created at
probe - existing tools expect them to be present after kmem binds.

"offline" is therefore a reportable state but is not writable: it only
arises from the legacy auto_online_blocks=offline policy.  Onlining
such a device through this attribute requires unplugging it first in
an effort to get drivers creating DAX devices to set a default.

Unplug is atomic across the whole device: dax_kmem_do_hotremove()
collects every added range and offlines/removes them in one operation.
Either the operation succeeds or is entirely rolled back.

Unbind Note:
  We used to call remove_memory() during unbind, which would fire a
  BUG() if any of the memory blocks were online at that time.  We lift
  this into a WARN in the cleanup routine and don't attempt hotremove
  if ->state is not DAX_KMEM_UNPLUGGED or MMOP_OFFLINE.

  An offline dax device memory is removed on unbind as before.

  If online at unbind, the resources are leaked (as before), but now
  we prevent deadlock if a memory region is impossible to hotremove.

Suggested-by: Hannes Reinecke <hare@suse.de>
Suggested-by: David Hildenbrand <david@kernel.org>
Signed-off-by: Gregory Price <gourry@gourry.net>
---
 Documentation/ABI/testing/sysfs-bus-dax |  26 +++
 drivers/base/memory.c                   |   9 +
 drivers/dax/kmem.c                      | 224 ++++++++++++++++++++----
 include/linux/memory_hotplug.h          |   1 +
 4 files changed, 224 insertions(+), 36 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-dax b/Documentation/ABI/testing/sysfs-bus-dax
index b34266bfae49..2dcad1e9dad0 100644
--- a/Documentation/ABI/testing/sysfs-bus-dax
+++ b/Documentation/ABI/testing/sysfs-bus-dax
@@ -151,3 +151,29 @@ Description:
 		memmap_on_memory parameter for memory_hotplug. This is
 		typically set on the kernel command line -
 		memory_hotplug.memmap_on_memory set to 'true' or 'force'."
+
+What:		/sys/bus/dax/devices/daxX.Y/state
+Date:		June, 2026
+KernelVersion:	v6.21
+Contact:	nvdimm@lists.linux.dev
+Description:
+		(RW) Controls the state of the memory region.
+		Applies to all memory blocks associated with the device.
+		Only applies to dax_kmem devices.
+
+		Reading returns the current state; the writable states mirror
+		the per-block /sys/devices/system/memory/memoryX/state ABI::
+
+		  "unplugged": memory blocks are not present
+		  "online": memory is online, zone chosen by the kernel
+		  "online_kernel": memory is online in ZONE_NORMAL
+		  "online_movable": memory is online in ZONE_MOVABLE
+
+		"offline" (memory blocks are present but offline) may also be
+		reported - this happens when the device is bound while the
+		auto_online_blocks policy is "offline".  It cannot be written,
+		as it's not useful and creates device destruction races.
+
+		A device can only be onlined from the "unplugged" state, so a
+		device must be returned to "unplugged" before it can be onlined
+		into a different state.
diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index b318344426fa..3a2f69d3af7b 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -46,6 +46,15 @@ int mhp_online_type_from_str(const char *str)
 	}
 	return -EINVAL;
 }
+EXPORT_SYMBOL_GPL(mhp_online_type_from_str);
+
+const char *mhp_online_type_to_str(int online_type)
+{
+	if (online_type < 0 || online_type >= (int)ARRAY_SIZE(online_type_to_str))
+		return NULL;
+	return online_type_to_str[online_type];
+}
+EXPORT_SYMBOL_GPL(mhp_online_type_to_str);
 
 #define to_memory_block(dev) container_of(dev, struct memory_block, dev)
 
diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
index a45e50def537..340486586d82 100644
--- a/drivers/dax/kmem.c
+++ b/drivers/dax/kmem.c
@@ -42,9 +42,15 @@ static int dax_kmem_range(struct dev_dax *dev_dax, int i, struct range *r)
 	return 0;
 }
 
+#define DAX_KMEM_UNPLUGGED	(-1)
+
 struct dax_kmem_data {
 	const char *res_name;
 	int mgid;
+	int numa_node;
+	struct dev_dax *dev_dax;
+	int state;
+	struct mutex lock; /* protects hotplug state transitions */
 	struct resource *res[];
 };
 
@@ -63,12 +69,22 @@ static void kmem_put_memory_types(void)
 	mt_put_memory_types(&kmem_memory_types);
 }
 
+/* True for the online states a kmem dax device can hold. */
+static bool dax_kmem_state_is_online(int state)
+{
+	return state == MMOP_ONLINE ||
+	       state == MMOP_ONLINE_KERNEL ||
+	       state == MMOP_ONLINE_MOVABLE;
+}
+
 /**
  * dax_kmem_do_hotplug - hotplug memory for dax kmem device
  * @dev_dax: the dev_dax instance
  * @data: the dax_kmem_data structure with resource tracking
+ * @online_type: the online policy to use for the memory blocks
  *
- * Hotplugs all ranges in the dev_dax region as system memory.
+ * Hotplugs all ranges in the dev_dax region as system memory with the
+ * provided online policy (offline, online, online_movable, online_kernel).
  *
  * Returns the number of successfully mapped ranges, or negative error.
  */
@@ -77,9 +93,15 @@ static int dax_kmem_do_hotplug(struct dev_dax *dev_dax,
 			       int online_type)
 {
 	struct device *dev = &dev_dax->dev;
-	int i, rc, onlined = 0;
+	int i, rc, added = 0;
 	mhp_t mhp_flags;
 
+	if (dax_kmem_state_is_online(data->state))
+		return -EINVAL;
+
+	if (online_type < MMOP_OFFLINE || online_type > MMOP_ONLINE_MOVABLE)
+		return -EINVAL;
+
 	for (i = 0; i < dev_dax->nr_range; i++) {
 		struct range range;
 
@@ -112,14 +134,14 @@ static int dax_kmem_do_hotplug(struct dev_dax *dev_dax,
 				kfree(data->res[i]);
 				data->res[i] = NULL;
 			}
-			if (onlined)
+			if (added)
 				continue;
 			return rc;
 		}
-		onlined++;
+		added++;
 	}
 
-	return onlined;
+	return added;
 }
 
 /**
@@ -182,45 +204,64 @@ static int dax_kmem_init_resources(struct dev_dax *dev_dax,
  * @dev_dax: the dev_dax instance
  * @data: the dax_kmem_data structure with resource tracking
  *
- * Removes all ranges in the dev_dax region.
+ * Offlines and removes every currently-added range in the dev_dax region
+ * atomically: either all ranges are offlined and removed, or none are and
+ * the device is returned to its prior state.
  *
- * Returns the number of successfully removed ranges.
+ * Returns 0 on success, or a negative errno on failure.
  */
 static int dax_kmem_do_hotremove(struct dev_dax *dev_dax,
 				 struct dax_kmem_data *data)
 {
 	struct device *dev = &dev_dax->dev;
-	int i, success = 0;
+	struct range *ranges;
+	int i, nr_ranges = 0, rc;
+
+	ranges = kmalloc_array(dev_dax->nr_range, sizeof(*ranges), GFP_KERNEL);
+	if (!ranges)
+		return -ENOMEM;
 
+	/* Collect the ranges that were actually added during probe. */
 	for (i = 0; i < dev_dax->nr_range; i++) {
 		struct range range;
-		int rc;
 
-		rc = dax_kmem_range(dev_dax, i, &range);
-		if (rc)
+		if (!data->res[i])
 			continue;
-
-		/* range was never added during probe, count as removed */
-		if (!data->res[i]) {
-			success++;
+		if (dax_kmem_range(dev_dax, i, &range))
 			continue;
-		}
+		ranges[nr_ranges++] = range;
+	}
 
-		rc = remove_memory(range.start, range_len(&range));
-		if (rc == 0) {
-			/* Release the resource for the successfully removed range */
-			remove_resource(data->res[i]);
-			kfree(data->res[i]);
-			data->res[i] = NULL;
-			success++;
-			continue;
-		}
+	/* Nothing added means nothing to remove. */
+	if (!nr_ranges) {
+		kfree(ranges);
+		return 0;
+	}
+
+	rc = offline_and_remove_memory_ranges(ranges, nr_ranges);
+	kfree(ranges);
+	if (rc) {
 		any_hotremove_failed = true;
-		dev_err(dev, "mapping%d: %#llx-%#llx hotremove failed\n",
-			i, range.start, range.end);
+		dev_err(dev, "hotremove failed, device left online: %d\n", rc);
+		return rc;
 	}
 
-	return success;
+	/* All ranges removed; release the reserved resources. */
+	for (i = 0; i < dev_dax->nr_range; i++) {
+		if (!data->res[i])
+			continue;
+		remove_resource(data->res[i]);
+		kfree(data->res[i]);
+		data->res[i] = NULL;
+	}
+
+	return 0;
+}
+#else
+static int dax_kmem_do_hotremove(struct dev_dax *dev_dax,
+				 struct dax_kmem_data *data)
+{
+	return -EBUSY;
 }
 #endif /* CONFIG_MEMORY_HOTREMOVE */
 
@@ -236,6 +277,18 @@ static void dax_kmem_cleanup_resources(struct dev_dax *dev_dax,
 {
 	int i;
 
+	/*
+	 * If the device unbind occurs before memory is hotremoved, we can never
+	 * remove the memory (requires reboot).  Attempting an offline operation
+	 * here may cause deadlock and a failure to finish the unbind.
+	 *
+	 * Note: This leaks the resources.
+	 */
+	if (WARN(((data->state != DAX_KMEM_UNPLUGGED) &&
+		  (data->state != MMOP_OFFLINE)),
+		 "Hotplug memory regions stuck online until reboot"))
+		return;
+
 	for (i = 0; i < dev_dax->nr_range; i++) {
 		if (!data->res[i])
 			continue;
@@ -245,6 +298,85 @@ static void dax_kmem_cleanup_resources(struct dev_dax *dev_dax,
 	}
 }
 
+static int dax_kmem_parse_state(const char *buf)
+{
+	int online_type;
+
+	/* "unplugged" is kmem-specific - the rest map to MMOP_ */
+	if (sysfs_streq(buf, "unplugged"))
+		return DAX_KMEM_UNPLUGGED;
+
+	online_type = mhp_online_type_from_str(buf);
+	/* Disallow "offline": it's not useful and creates race conditions */
+	if (online_type == MMOP_OFFLINE)
+		return -EINVAL;
+	return online_type;
+}
+
+static ssize_t state_show(struct device *dev,
+			    struct device_attribute *attr, char *buf)
+{
+	struct dax_kmem_data *data = dev_get_drvdata(dev);
+	const char *state_str;
+
+	if (!data)
+		return -ENXIO;
+
+	if (data->state == DAX_KMEM_UNPLUGGED)
+		state_str = "unplugged";
+	else
+		state_str = mhp_online_type_to_str(data->state);
+
+	return sysfs_emit(buf, "%s\n", state_str ?: "unknown");
+}
+
+static ssize_t state_store(struct device *dev, struct device_attribute *attr,
+			     const char *buf, size_t len)
+{
+	struct dev_dax *dev_dax = to_dev_dax(dev);
+	struct dax_kmem_data *data = dev_get_drvdata(dev);
+	int online_type;
+	int rc;
+
+	if (!data)
+		return -ENXIO;
+
+	online_type = dax_kmem_parse_state(buf);
+	if (online_type < DAX_KMEM_UNPLUGGED)
+		return online_type;
+
+	guard(mutex)(&data->lock);
+
+	/* Already in requested state */
+	if (data->state == online_type)
+		return len;
+
+	if (online_type == DAX_KMEM_UNPLUGGED) {
+		rc = dax_kmem_do_hotremove(dev_dax, data);
+		if (rc)
+			return rc;
+		data->state = DAX_KMEM_UNPLUGGED;
+		return len;
+	}
+
+	/* Onlining is only allowed from the unplugged state. */
+	if (data->state != DAX_KMEM_UNPLUGGED)
+		return -EBUSY;
+
+	/* Re-acquire resources if previously unplugged, otherwise no-op */
+	rc = dax_kmem_init_resources(dev_dax, data);
+	if (rc < 0)
+		return rc;
+
+	rc = dax_kmem_do_hotplug(dev_dax, data, online_type);
+	if (rc < 0)
+		return rc;
+
+	data->state = online_type;
+	return len;
+}
+static DEVICE_ATTR_RW(state);
+
 static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
 {
 	struct device *dev = &dev_dax->dev;
@@ -313,6 +445,10 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
 	if (rc < 0)
 		goto err_reg_mgid;
 	data->mgid = rc;
+	data->numa_node = numa_node;
+	data->dev_dax = dev_dax;
+	data->state = DAX_KMEM_UNPLUGGED;
+	mutex_init(&data->lock);
 
 	dev_set_drvdata(dev, data);
 
@@ -325,9 +461,15 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
 	if (online_type == DAX_ONLINE_DEFAULT)
 		online_type = mhp_get_default_online_type();
 
+	/* Always create blocks for backward compatibility, even if offline */
 	rc = dax_kmem_do_hotplug(dev_dax, data, online_type);
 	if (rc < 0)
 		goto err_hotplug;
+	data->state = online_type;
+
+	rc = device_create_file(dev, &dev_attr_state);
+	if (rc)
+		dev_warn(dev, "failed to create state sysfs entry\n");
 
 	return 0;
 
@@ -348,20 +490,26 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
 #ifdef CONFIG_MEMORY_HOTREMOVE
 static void dev_dax_kmem_remove(struct dev_dax *dev_dax)
 {
-	int success;
 	int node = dev_dax->target_node;
 	struct device *dev = &dev_dax->dev;
 	struct dax_kmem_data *data = dev_get_drvdata(dev);
 
+	device_remove_file(dev, &dev_attr_state);
 	/*
-	 * We have one shot for removing memory, if some memory blocks were not
-	 * offline prior to calling this function remove_memory() will fail, and
-	 * there is no way to hotremove this memory until reboot because device
-	 * unbind will succeed even if we return failure.
+	 * Online memory cannot safely be removed (offlining during unbind can
+	 * deadlock a task as unbind cannot be interrupted).  Unfortunately we
+	 * have to leak all of [resources, memory group, @data, memtype], until
+	 * the next reboot - and the memory will stay online until then.
+	 *
+	 * offline blocks are removed on unbind, but may leak on failure.
 	 */
-	success = dax_kmem_do_hotremove(dev_dax, data);
-	if (success < dev_dax->nr_range) {
-		dev_err(dev, "Hotplug regions stuck online until reboot\n");
+	if (dax_kmem_state_is_online(data->state)) {
+		dev_warn(dev, "Hotplug regions stuck online until reboot\n");
+		any_hotremove_failed = true;
+		return;
+	} else if (data->state == MMOP_OFFLINE &&
+	    dax_kmem_do_hotremove(dev_dax, data)) {
+		dev_warn(dev, "Unplug failed, resources leaked until reboot\n");
 		return;
 	}
 
@@ -382,6 +530,10 @@ static void dev_dax_kmem_remove(struct dev_dax *dev_dax)
 #else
 static void dev_dax_kmem_remove(struct dev_dax *dev_dax)
 {
+	struct device *dev = &dev_dax->dev;
+
+	device_remove_file(dev, &dev_attr_state);
+
 	/*
 	 * Without hotremove purposely leak the request_mem_region() for the
 	 * device-dax range and return '0' to ->remove() attempts. The removal
diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index 7f1da7c428dc..46c796570692 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -127,6 +127,7 @@ extern int arch_add_memory(int nid, u64 start, u64 size,
 extern u64 max_mem_size;
 
 extern int mhp_online_type_from_str(const char *str);
+const char *mhp_online_type_to_str(int online_type);
 
 /* If movable_node boot option specified */
 extern bool movable_node_enabled;
-- 
2.54.0

