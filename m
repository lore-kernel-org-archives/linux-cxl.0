Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9419340DA3
	for <linux-cxl@vger.kernel.org>; Wed, 14 Jan 2026 23:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768434673; cv=none; b=iV/O2C7aJDMN1DKmxWWM7Qx5G4ORiaZ7GoDsRto91TebK9CE6hVhvTL/Qu+5aXOheVNBg7vpccsUhPRXoum76ImYfqt2LL0e/AlBB35OcGaW7/7cRxLK0CChru6aCxu++Da9xZl6lbZhTU6tMfKre4eTefNZsIjQWGI74wkBMQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768434673; c=relaxed/simple;
	bh=2HJXstFWbA8JKzmFLrV4EYZca67gOgm6jsl+V+jc43U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E1rdpSOnSl17vZV4lxYs8T9VBLvMpgwkme9npAB9UeibyVdIMk2O92KVmNWCn8rMV8ZTCw6r7EjuGQWyIaEIqustf4gHp2BBUkESzZAr9SSnr/RthpBPx/8rbV/hh4QHg85HVjsHateiSbeM+HT839BDCFnp54oX1sR2H/ORNp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=DXwO1ZbO; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="DXwO1ZbO"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-88888c41a13so3862826d6.3
        for <linux-cxl@vger.kernel.org>; Wed, 14 Jan 2026 15:51:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1768434666; x=1769039466; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HO1V54BeeL6soGWklBzHc2sknfCRHcpjkYKQEUfGCuc=;
        b=DXwO1ZbOBlZCeUu1x49jm43ULDpD64hWnui754YMz75mmfUVu7QxxTl8ePr/R+FKVF
         4ZgE9BY23bWLAZ5RJUeDyScsKqor9beHBipmjTOa+XyItnrLsVFS+25hAoB8Bto4cszY
         uKtVAB88WdXgqQ/mZqi6kx7Kqn1CQ6fp3T0lxh5xRyiZbdQyfcmNS/iIPt/XWXHR6JbD
         cwitgPlf15JWMMnfDgNmil5aqdDu2We/mp+Hi17MyoiwyRT+zTMpXlwcMjWwhd+Ghbo2
         AJDm8uXdGQACaxKo3ZL4zgygx18BR8ZjCFn89sIcpKSUE2NlA57mYlEAmTxYacIgPA93
         Lbag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768434666; x=1769039466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HO1V54BeeL6soGWklBzHc2sknfCRHcpjkYKQEUfGCuc=;
        b=jt32de2RmKEqVq+nu53DZMSiO5x10rb5GROEkElMHSq7yUz5uJp8VzeKnv37N8KaMB
         UGqumfLh7AjJF4FYwpCMOfhBajxCUyPgGX9oa/+goGp+x0Uf/G8Yb81tZmVk3aclFK2z
         X0XnZDWGH1w5eQhJuDrp4dqYqbqWZbWC1FN2wfvF4tZ0OXZMlFEQ7L16zVVMjdQOOfdR
         AgrA2ewA7HujK7yaGINFgl2KIyfRcnfRFqyVnW1z0QUj6BayjI3esarLsFI1GKCAacpl
         RFlWMZ6KDSp3sowi1fM8ZrJQpgckgTu+o2Bd8LnmoAblgAbwSn/RkkN/hqv3jCmsqjBU
         ZgNg==
X-Gm-Message-State: AOJu0YyrYwr+i3hVcCtH4gSyUg5wpdsNhlEJCTPNfTQKnbsLApTMaOm1
	Dy1Ad218vMGDC9tIpEi04o6bdhIYpFkt+EgSRV0ggBZGFyH6WBoH93XTJR+J6PKmfts=
X-Gm-Gg: AY/fxX4Gtc99dBKu9DZgyviAWhwDrJ2Yb5e526HbcvOfax8w9Y30kAFIQOe6zmi+fdL
	0312AyKtQ67cqJ3myFLInQPZK9bV8YbUwfKmJB2at12O3REAwULpRKtKiXZF8SaeJuWChVY2+ck
	MrPmHXReLjARp8MYpA4me6n0cKMXGr/Ay2xar7AfZ0jvpqBnNdV1EprHtz4TnV6bv40S+eROblF
	zcDFuJvQTdj86x3BZuSAq0GOrm/kAWLDwDHeBvCQ0CxaA+ef2juCaN7I19aYMItJO0YiAf7t2UX
	FonyC9eKKR9rM8hiuEE/vGpGfDhj3bBh2q2hfjg6+4lC99D7BKCJsh26OS38damy9paSi0s6b1t
	QDhwMcZAt4syyPW2Z/o8CEi3/asPadRg6LeYqrkbWuVAHUelmGtxv3nWxlKEfJpdFMhdMBFIabG
	V2QGRBK55a0zXKsJQLlC4AlcW9p0ZntPauAKtOhz1hno0GFb1fSxWalu0PExkiPATTH9WEadnui
	hM=
X-Received: by 2002:ad4:5aa4:0:b0:880:48e4:198a with SMTP id 6a1803df08f44-89275c0aef3mr46108836d6.32.1768434666420;
        Wed, 14 Jan 2026 15:51:06 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-890772346f8sm188449106d6.35.2026.01.14.15.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 15:51:05 -0800 (PST)
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
Subject: [PATCH v2 4/5] dax/kmem: add sysfs interface for runtime hotplug state control
Date: Wed, 14 Jan 2026 18:50:20 -0500
Message-ID: <20260114235022.3437787-5-gourry@gourry.net>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260114235022.3437787-1-gourry@gourry.net>
References: <20260114235022.3437787-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The dax kmem driver currently onlines memory automatically during
probe using the system's default online policy but provides no way
to control or query the entire region state at runtime.

There is no atomic to offline and remove memory blocks together.

Add a new 'hotplug' sysfs attribute that allows userspace to control
and query the entire memory region state.

The interface supports the following states:
  - "unplug": memory is offline and blocks are not present
  - "online": memory is online as normal system RAM
  - "online_movable": memory is online in ZONE_MOVABLE

Valid transitions:
  - unplugged -> online
  - unplugged -> online_movable
  - online    -> unplugged
  - online_movable -> unplugged

"offline" (memory blocks exist but are offline by default) is not
supported because it's functionally equivalent to "unplugged" and
entices races between offlining and unplugging.

The initial state after probe uses mhp_get_default_online_type() to
preserve backwards compatibility - existing systems with auto-online
policies will continue to work as before.

As with any hot-remove mechanism, the removal can fail and if rollback
fails the system can be left in an inconsistent state.

Unbind Note:
  We used to call remove_memory() during unbind, which would fire a
  BUG() if any of the memory blocks were online at that time.  We lift
  this into a WARN in the cleanup routine and don't attempt hotremove
  if ->state is not DAX_KMEM_UNPLUGGED.

  The resources are still leaked but this prevents deadlock on unbind
  if a memory region happens to be impossible to hotremove.

Suggested-by: Hannes Reinecke <hare@suse.de>
Suggested-by: David Hildenbrand <david@kernel.org>
Signed-off-by: Gregory Price <gourry@gourry.net>
---
 Documentation/ABI/testing/sysfs-bus-dax |  17 +++
 drivers/dax/kmem.c                      | 159 +++++++++++++++++++++---
 2 files changed, 156 insertions(+), 20 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-dax b/Documentation/ABI/testing/sysfs-bus-dax
index b34266bfae49..faf6f63a368c 100644
--- a/Documentation/ABI/testing/sysfs-bus-dax
+++ b/Documentation/ABI/testing/sysfs-bus-dax
@@ -151,3 +151,20 @@ Description:
 		memmap_on_memory parameter for memory_hotplug. This is
 		typically set on the kernel command line -
 		memory_hotplug.memmap_on_memory set to 'true' or 'force'."
+
+What:		/sys/bus/dax/devices/daxX.Y/hotplug
+Date:		January, 2026
+KernelVersion:	v6.21
+Contact:	nvdimm@lists.linux.dev
+Description:
+		(RW) Controls what hotplug state of the memory region.
+		Applies to all memory blocks associated with the device.
+		Only applies to dax_kmem devices.
+
+                States: [unplugged, online, online_movable]
+                Arguments:
+		  "unplug": memory is offline and blocks are not present
+		  "online": memory is online as normal system RAM
+		  "online_movable": memory is online in ZONE_MOVABLE
+
+		Devices must unplug to online into a different state.
diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
index 3929cb8576de..c222ae9d675d 100644
--- a/drivers/dax/kmem.c
+++ b/drivers/dax/kmem.c
@@ -44,9 +44,15 @@ static int dax_kmem_range(struct dev_dax *dev_dax, int i, struct range *r)
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
 
@@ -69,8 +75,10 @@ static void kmem_put_memory_types(void)
  * dax_kmem_do_hotplug - hotplug memory for dax kmem device
  * @dev_dax: the dev_dax instance
  * @data: the dax_kmem_data structure with resource tracking
+ * @online_type: MMOP_ONLINE or MMOP_ONLINE_MOVABLE
  *
- * Hotplugs all ranges in the dev_dax region as system memory.
+ * Hotplugs all ranges in the dev_dax region as system memory using
+ * the specified online type.
  *
  * Returns the number of successfully mapped ranges, or negative error.
  */
@@ -82,6 +90,12 @@ static int dax_kmem_do_hotplug(struct dev_dax *dev_dax,
 	int i, rc, onlined = 0;
 	mhp_t mhp_flags;
 
+	if (data->state == MMOP_ONLINE || data->state == MMOP_ONLINE_MOVABLE)
+		return -EINVAL;
+
+	if (online_type != MMOP_ONLINE && online_type != MMOP_ONLINE_MOVABLE)
+		return -EINVAL;
+
 	for (i = 0; i < dev_dax->nr_range; i++) {
 		struct range range;
 
@@ -174,9 +188,9 @@ static int dax_kmem_init_resources(struct dev_dax *dev_dax,
  * @dev_dax: the dev_dax instance
  * @data: the dax_kmem_data structure with resource tracking
  *
- * Removes all ranges in the dev_dax region.
+ * Offlines and removes all ranges in the dev_dax region.
  *
- * Returns the number of successfully removed ranges.
+ * Returns the number of successfully removed ranges, or negative error.
  */
 static int dax_kmem_do_hotremove(struct dev_dax *dev_dax,
 				 struct dax_kmem_data *data)
@@ -196,7 +210,7 @@ static int dax_kmem_do_hotremove(struct dev_dax *dev_dax,
 		if (!data->res[i])
 			continue;
 
-		rc = remove_memory(range.start, range_len(&range));
+		rc = offline_and_remove_memory(range.start, range_len(&range));
 		if (rc == 0) {
 			success++;
 			continue;
@@ -228,6 +242,21 @@ static void dax_kmem_cleanup_resources(struct dev_dax *dev_dax,
 {
 	int i;
 
+	/*
+	 * If the device unbind occurs before memory is hotremoved, we can never
+	 * remove the memory (requires reboot).  Attempting an offline operation
+	 * here may cause deadlock and a failure to finish the unbind.
+	 *
+	 * This WARN used to be a BUG called by remove_memory().
+	 *
+	 * Note: This leaks the resources.
+	 */
+	if (data->state != DAX_KMEM_UNPLUGGED) {
+		WARN(data->state != DAX_KMEM_UNPLUGGED,
+		     "Hotplug memory regions stuck online until reboot");
+		return;
+	}
+
 	for (i = 0; i < dev_dax->nr_range; i++) {
 		if (!data->res[i])
 			continue;
@@ -237,6 +266,91 @@ static void dax_kmem_cleanup_resources(struct dev_dax *dev_dax,
 	}
 }
 
+static int dax_kmem_parse_state(const char *buf)
+{
+	if (sysfs_streq(buf, "unplug"))
+		return DAX_KMEM_UNPLUGGED;
+	if (sysfs_streq(buf, "online"))
+		return MMOP_ONLINE;
+	if (sysfs_streq(buf, "online_movable"))
+		return MMOP_ONLINE_MOVABLE;
+	return -EINVAL;
+}
+
+static ssize_t hotplug_show(struct device *dev,
+			    struct device_attribute *attr, char *buf)
+{
+	struct dax_kmem_data *data = dev_get_drvdata(dev);
+	const char *state_str;
+
+	if (!data)
+		return -ENXIO;
+
+	switch (data->state) {
+	case DAX_KMEM_UNPLUGGED:
+		state_str = "unplugged";
+		break;
+	case MMOP_ONLINE:
+		state_str = "online";
+		break;
+	case MMOP_ONLINE_MOVABLE:
+		state_str = "online_movable";
+		break;
+	default:
+		state_str = "unknown";
+		break;
+	}
+
+	return sysfs_emit(buf, "%s\n", state_str);
+}
+
+static ssize_t hotplug_store(struct device *dev, struct device_attribute *attr,
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
+		if (rc < 0) {
+			dev_warn(dev, "hotplug state is inconsistent\n");
+			return rc;
+		}
+		data->state = DAX_KMEM_UNPLUGGED;
+		return len;
+	}
+
+	/*
+	 * online_type is MMOP_ONLINE or MMOP_ONLINE_MOVABLE
+	 * Cannot switch between online types without unplugging first
+	 */
+	if (data->state == MMOP_ONLINE || data->state == MMOP_ONLINE_MOVABLE)
+		return -EBUSY;
+
+	rc = dax_kmem_do_hotplug(dev_dax, data, online_type);
+	if (rc < 0)
+		return rc;
+
+	data->state = online_type;
+	return len;
+}
+static DEVICE_ATTR_RW(hotplug);
+
 static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
 {
 	struct device *dev = &dev_dax->dev;
@@ -246,6 +360,7 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
 	int i, rc;
 	int numa_node;
 	int adist = MEMTIER_DEFAULT_DAX_ADISTANCE;
+	int online_type;
 
 	/*
 	 * Ensure good NUMA information for the persistent memory.
@@ -304,6 +419,10 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
 	if (rc < 0)
 		goto err_reg_mgid;
 	data->mgid = rc;
+	data->numa_node = numa_node;
+	data->dev_dax = dev_dax;
+	data->state = DAX_KMEM_UNPLUGGED;
+	mutex_init(&data->lock);
 
 	dev_set_drvdata(dev, data);
 
@@ -315,9 +434,17 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
 	 * Hotplug using the system default policy - this preserves backwards
 	 * for existing users who rely on the default auto-online behavior.
 	 */
-	rc = dax_kmem_do_hotplug(dev_dax, data, mhp_get_default_online_type());
-	if (rc < 0)
-		goto err_hotplug;
+	online_type = mhp_get_default_online_type();
+	if (online_type != MMOP_OFFLINE) {
+		rc = dax_kmem_do_hotplug(dev_dax, data, online_type);
+		if (rc < 0)
+			goto err_hotplug;
+		data->state = online_type;
+	}
+
+	rc = device_create_file(dev, &dev_attr_hotplug);
+	if (rc)
+		dev_warn(dev, "failed to create hotplug sysfs entry\n");
 
 	return 0;
 
@@ -338,23 +465,11 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
 #ifdef CONFIG_MEMORY_HOTREMOVE
 static void dev_dax_kmem_remove(struct dev_dax *dev_dax)
 {
-	int success;
 	int node = dev_dax->target_node;
 	struct device *dev = &dev_dax->dev;
 	struct dax_kmem_data *data = dev_get_drvdata(dev);
 
-	/*
-	 * We have one shot for removing memory, if some memory blocks were not
-	 * offline prior to calling this function remove_memory() will fail, and
-	 * there is no way to hotremove this memory until reboot because device
-	 * unbind will succeed even if we return failure.
-	 */
-	success = dax_kmem_do_hotremove(dev_dax, data);
-	if (success < dev_dax->nr_range) {
-		dev_err(dev, "Hotplug regions stuck online until reboot\n");
-		return;
-	}
-
+	device_remove_file(dev, &dev_attr_hotplug);
 	dax_kmem_cleanup_resources(dev_dax, data);
 	memory_group_unregister(data->mgid);
 	kfree(data->res_name);
@@ -372,6 +487,10 @@ static void dev_dax_kmem_remove(struct dev_dax *dev_dax)
 #else
 static void dev_dax_kmem_remove(struct dev_dax *dev_dax)
 {
+	struct device *dev = &dev_dax->dev;
+
+	device_remove_file(dev, &dev_attr_hotplug);
+
 	/*
 	 * Without hotremove purposely leak the request_mem_region() for the
 	 * device-dax range and return '0' to ->remove() attempts. The removal
-- 
2.52.0

