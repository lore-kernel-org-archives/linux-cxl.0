Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA5D1A682A
	for <linux-cxl@vger.kernel.org>; Sat,  4 Apr 2026 00:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775261272; cv=none; b=pD/zn2ND9ZLE1Hm52gibfdNpEW6BJ4V9VbxyIDwjWKB40Cr66SJwVwe6RwJFik0oT3F+jPBByc9q0/P/kScSFyuKOrLtUBsrp8KRGtWIGfFsVXn1/tcee++EoRMwEox50+GrfHpmX9KmR5oUKUvDrSqLi3+y06Flql2fWRwbM0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775261272; c=relaxed/simple;
	bh=o+VlMAnQQaP1SWDlc4XFND6M5h5/jJtCq+7R5B9vAq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uejcT+++ruVke035JVzEA5pwP5yinRecJbjvzpnHJWv1se5AK+I7bNDnPk/1L1t02LpxNAxE7tl+azZz2/Fvcpez8wyUr2fqVEogDu6dRNMN22+PJb70L8XYSvBVp+8i0EAcEVTKNdr/44dz1s8XKej1diAqESGmziRHK/75Cag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=TG9sgBH3; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TG9sgBH3"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2b6b0500e06so3552573eec.1
        for <linux-cxl@vger.kernel.org>; Fri, 03 Apr 2026 17:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1775261266; x=1775866066; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5WbWNOKgJimgI9xjyvoHzw2TjM6jyvThEk+IUd6YUTg=;
        b=TG9sgBH3FGbXqx4NpgO/yjO3Uw7l9avqXSEpVc8xWEKFedXVFEx3GEs6VHOKsDxfoq
         Id4HBT8gdrw7aX9v6oKSMa4HjMMQgzWq/iJELUm8DZ9D+jsWEs3tiaw5G3GZ8tBRckTA
         UGcGWRntC+nw3fuojSzrVGfpvR9xGYCm8CkE8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775261266; x=1775866066;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5WbWNOKgJimgI9xjyvoHzw2TjM6jyvThEk+IUd6YUTg=;
        b=chdhqo/KccosFKHwKVFPAYqBXJR6nKNy/AxKjOlQL1TaZX6yx9cHFgjkowzAc4TeHH
         39O/rxlYFQ4fL7DpR1i7/naLxSx8moH465e8jMmJGqMICosGJiF2U06miLrFJafLZ7Sn
         V+5lnKzHL5PTG+FscExr8kUsZJ0J/+EZw+IOPdiu/GMfMgxmjVYQVjayji6fJCY3YX95
         eYgaFQqPS/PoSOgU+j4zdVnu5odnE3zruVhSBzrTm1Rcg7Xbi/i8CxWHnYGY2xpJ8K82
         gzKNCCZrQKrYSrzM2kXI8vCyxZoZtGmc5/KgMsURdBioh8B//OfUctZzOxAGN5WDfaGM
         k1bw==
X-Forwarded-Encrypted: i=1; AJvYcCUK7+PaSWaUNMIS/jaFv1f0jOlebbkRyCfansRoR/wwhDkix52fWOKFBRDZiRSDdZO+uDoAl69cWGs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0sCG3lgZ7f4XoueWO1WBdggFCmRITXQIqeRNgyF3zyd7F+rND
	AYZGdqQLgM/iUnvFkmcxe9+dpnHVe7k263Q7UfBsorHsPpY3ZGRXeu7Ic69ihsulkQ==
X-Gm-Gg: AeBDieuDe+iCrmS9ykPB9aFdo4jcCJu5rvbRc46iLnEBMQn/f7aBqVFPqysObGF47oU
	srbeZ1joQ+19gExn/tZ0ePfqxusznnhK/EnWzPzYH34yUgAxWkU6rZYqQFgOpdn428pRKgSX488
	YguSjeaouWrek7Q2Fgm+Ap3tlJ31Jf2y8oSYUP6cJ6FpuDJBzcSeaj3pgpsxcmtoTS3i3uMi5Wm
	+PqiqrTUkgEbJmMvuD0yhok+Fb3QH2KwTS0HLIPL/2VuGsSP4468fbQGk5dairU5rZZ4TXoz1Xd
	d1ApE/7ViNJBsd2M8GDgW7pJLyUUxmSlY3EhpYc6xqVMvl8gsGWiJZix/x3NWJlwwrCu17XpNvJ
	IUpgZKrYYkc2tvKMju6NG0itETaduBgqM6A6WV7sxb2Is2+Tfeb06yPXxyn4g9EeipdtuJrNZON
	jg+ApAD9B8byuXlpFriW4nfVl5VbxyyXz9Ivu2OafCstgCFlH9I1R/PqIgzta9DHntlRy7E+SRN
	ECoFGWXULIUKKDqci140w==
X-Received: by 2002:a05:7300:dc88:b0:2b7:b7e7:9025 with SMTP id 5a478bee46e88-2cbfcb5580fmr2229803eec.31.1775261265791;
        Fri, 03 Apr 2026 17:07:45 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2a00:79e0:2e7c:8:a8b6:55b2:3eb6:2c0e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ca79e1d93bsm6520716eec.12.2026.04.03.17.07.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 17:07:44 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>
Cc: Saravana Kannan <saravanak@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Eric Dumazet <edumazet@google.com>,
	Johan Hovold <johan@kernel.org>,
	Leon Romanovsky <leon@kernel.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Alexey Kardashevskiy <aik@ozlabs.ru>,
	Robin Murphy <robin.murphy@arm.com>,
	Douglas Anderson <dianders@chromium.org>,
	Mark Brown <broonie@kernel.org>,
	ardb@kernel.org,
	catalin.marinas@arm.com,
	chleroy@kernel.org,
	david@kernel.org,
	driver-core@lists.linux.dev,
	kees@kernel.org,
	kevin.brodsky@arm.com,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org,
	maddy@linux.ibm.com,
	maz@kernel.org,
	miko.lenczewski@arm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	osalvador@suse.de,
	oupton@kernel.org,
	peterz@infradead.org,
	tglx@kernel.org,
	will@kernel.org,
	yangyicong@hisilicon.com,
	yeoreum.yun@arm.com
Subject: [PATCH v4 9/9] driver core: Replace dev->offline + ->offline_disabled with accessors
Date: Fri,  3 Apr 2026 17:05:03 -0700
Message-ID: <20260403170432.v4.9.I897d478b4a9361d79cd5073207c1062fd4d0d0e4@changeid>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
In-Reply-To: <20260404000644.522677-1-dianders@chromium.org>
References: <20260404000644.522677-1-dianders@chromium.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In C, bitfields are not necessarily safe to modify from multiple
threads without locking. Switch "offline" and "offline_disabled" over
to the "flags" field so modifications are safe.

Cc: Rafael J. Wysocki <rafael@kernel.org>
Acked-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
Not fixing any known bugs; problem is theoretical and found by code
inspection. Change is done somewhat manually and only lightly tested
(mostly compile-time tested).

Changes in v4:
- Use accessor functions for flags

Changes in v3:
- New

 arch/arm64/kernel/cpufeature.c                 |  2 +-
 .../powerpc/platforms/pseries/hotplug-memory.c |  4 ++--
 drivers/acpi/scan.c                            |  2 +-
 drivers/base/core.c                            | 18 +++++++++---------
 drivers/base/cpu.c                             |  4 ++--
 drivers/base/memory.c                          |  2 +-
 include/linux/device.h                         | 12 ++++++------
 kernel/cpu.c                                   |  4 ++--
 8 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 32c2dbcc0c64..c832aa565dc2 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -4042,7 +4042,7 @@ static int enable_mismatched_32bit_el0(unsigned int cpu)
 	 */
 	lucky_winner = cpu_32bit ? cpu : cpumask_any_and(cpu_32bit_el0_mask,
 							 cpu_active_mask);
-	get_cpu_device(lucky_winner)->offline_disabled = true;
+	dev_set_offline_disabled(get_cpu_device(lucky_winner));
 	setup_elf_hwcaps(compat_elf_hwcaps);
 	elf_hwcap_fixup();
 	pr_info("Asymmetric 32-bit EL0 support detected on CPU %u; CPU hot-unplug disabled on CPU %u\n",
diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
index b2f14db59034..75f85a5da981 100644
--- a/arch/powerpc/platforms/pseries/hotplug-memory.c
+++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
@@ -213,9 +213,9 @@ static int dlpar_change_lmb_state(struct drmem_lmb *lmb, bool online)
 		return -EINVAL;
 	}
 
-	if (online && mem_block->dev.offline)
+	if (online && dev_offline(&mem_block->dev))
 		rc = device_online(&mem_block->dev);
-	else if (!online && !mem_block->dev.offline)
+	else if (!online && !dev_offline(&mem_block->dev))
 		rc = device_offline(&mem_block->dev);
 	else
 		rc = 0;
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index e8cdbdb46fdb..1353adbcc234 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -122,7 +122,7 @@ bool acpi_scan_is_offline(struct acpi_device *adev, bool uevent)
 	mutex_lock_nested(&adev->physical_node_lock, SINGLE_DEPTH_NESTING);
 
 	list_for_each_entry(pn, &adev->physical_node_list, node)
-		if (device_supports_offline(pn->dev) && !pn->dev->offline) {
+		if (device_supports_offline(pn->dev) && !dev_offline(pn->dev)) {
 			if (uevent)
 				kobject_uevent_env(&pn->dev->kobj, KOBJ_CHANGE, envp);
 
diff --git a/drivers/base/core.c b/drivers/base/core.c
index f12f3b53b4d0..79c85dbcffad 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2788,7 +2788,7 @@ static ssize_t online_show(struct device *dev, struct device_attribute *attr,
 	bool val;
 
 	device_lock(dev);
-	val = !dev->offline;
+	val = !dev_offline(dev);
 	device_unlock(dev);
 	return sysfs_emit(buf, "%u\n", val);
 }
@@ -2913,7 +2913,7 @@ static int device_add_attrs(struct device *dev)
 	if (error)
 		goto err_remove_type_groups;
 
-	if (device_supports_offline(dev) && !dev->offline_disabled) {
+	if (device_supports_offline(dev) && !dev_offline_disabled(dev)) {
 		error = device_create_file(dev, &dev_attr_online);
 		if (error)
 			goto err_remove_dev_groups;
@@ -4178,7 +4178,7 @@ static int device_check_offline(struct device *dev, void *not_used)
 	if (ret)
 		return ret;
 
-	return device_supports_offline(dev) && !dev->offline ? -EBUSY : 0;
+	return device_supports_offline(dev) && !dev_offline(dev) ? -EBUSY : 0;
 }
 
 /**
@@ -4196,7 +4196,7 @@ int device_offline(struct device *dev)
 {
 	int ret;
 
-	if (dev->offline_disabled)
+	if (dev_offline_disabled(dev))
 		return -EPERM;
 
 	ret = device_for_each_child(dev, NULL, device_check_offline);
@@ -4205,13 +4205,13 @@ int device_offline(struct device *dev)
 
 	device_lock(dev);
 	if (device_supports_offline(dev)) {
-		if (dev->offline) {
+		if (dev_offline(dev)) {
 			ret = 1;
 		} else {
 			ret = dev->bus->offline(dev);
 			if (!ret) {
 				kobject_uevent(&dev->kobj, KOBJ_OFFLINE);
-				dev->offline = true;
+				dev_set_offline(dev);
 			}
 		}
 	}
@@ -4236,11 +4236,11 @@ int device_online(struct device *dev)
 
 	device_lock(dev);
 	if (device_supports_offline(dev)) {
-		if (dev->offline) {
+		if (dev_offline(dev)) {
 			ret = dev->bus->online(dev);
 			if (!ret) {
 				kobject_uevent(&dev->kobj, KOBJ_ONLINE);
-				dev->offline = false;
+				dev_clear_offline(dev);
 			}
 		} else {
 			ret = 1;
@@ -4714,7 +4714,7 @@ static int device_attrs_change_owner(struct device *dev, kuid_t kuid,
 	if (error)
 		return error;
 
-	if (device_supports_offline(dev) && !dev->offline_disabled) {
+	if (device_supports_offline(dev) && !dev_offline_disabled(dev)) {
 		/* Change online device attributes of @dev to @kuid/@kgid. */
 		error = sysfs_file_change_owner(kobj, dev_attr_online.attr.name,
 						kuid, kgid);
diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index 875abdc9942e..19d288a3c80c 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -422,8 +422,8 @@ int register_cpu(struct cpu *cpu, int num)
 	cpu->dev.id = num;
 	cpu->dev.bus = &cpu_subsys;
 	cpu->dev.release = cpu_device_release;
-	cpu->dev.offline_disabled = !cpu->hotpluggable;
-	cpu->dev.offline = !cpu_online(num);
+	dev_assign_offline_disabled(&cpu->dev, !cpu->hotpluggable);
+	dev_assign_offline(&cpu->dev, !cpu_online(num));
 	cpu->dev.of_node = of_get_cpu_node(num, NULL);
 	cpu->dev.groups = common_cpu_attr_groups;
 	if (cpu->hotpluggable)
diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index a3091924918b..5005654f44fa 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -697,7 +697,7 @@ static int __add_memory_block(struct memory_block *memory)
 	memory->dev.id = memory->start_section_nr / sections_per_block;
 	memory->dev.release = memory_block_release;
 	memory->dev.groups = memory_memblk_attr_groups;
-	memory->dev.offline = memory->state == MEM_OFFLINE;
+	dev_assign_offline(&memory->dev, memory->state == MEM_OFFLINE);
 
 	ret = device_register(&memory->dev);
 	if (ret) {
diff --git a/include/linux/device.h b/include/linux/device.h
index 8132aab17e04..65fc6c566cc6 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -485,6 +485,8 @@ struct device_physical_location {
  *		architecture supports non-coherent devices.
  * @DEV_FLAG_OF_NODE_REUSED: Set if the device-tree node is shared with an
  *		ancestor device.
+ * @DEV_FLAG_OFFLINE_DISABLED: If set, the device is permanently online.
+ * @DEV_FLAG_OFFLINE: Set after successful invocation of bus type's .offline().
  */
 enum struct_device_flags {
 	DEV_FLAG_READY_TO_PROBE = 0,
@@ -495,6 +497,8 @@ enum struct_device_flags {
 	DEV_FLAG_STATE_SYNCED = 5,
 	DEV_FLAG_DMA_COHERENT = 6,
 	DEV_FLAG_OF_NODE_REUSED = 7,
+	DEV_FLAG_OFFLINE_DISABLED = 8,
+	DEV_FLAG_OFFLINE = 9,
 
 	DEV_FLAG_COUNT
 };
@@ -573,9 +577,6 @@ enum struct_device_flags {
  * @removable:  Whether the device can be removed from the system. This
  *              should be set by the subsystem / bus driver that discovered
  *              the device.
- *
- * @offline_disabled: If set, the device is permanently online.
- * @offline:	Set after successful invocation of bus type's .offline().
  * @flags:	DEV_FLAG_XXX flags. Use atomic bitfield operations to modify.
  *
  * At the lowest level, every device in a Linux system is represented by an
@@ -680,9 +681,6 @@ struct device {
 
 	enum device_removable	removable;
 
-	bool			offline_disabled:1;
-	bool			offline:1;
-
 	DECLARE_BITMAP(flags, DEV_FLAG_COUNT);
 };
 
@@ -716,6 +714,8 @@ __create_dev_flag_accessors(dma_ops_bypass, DEV_FLAG_DMA_OPS_BYPASS);
 __create_dev_flag_accessors(state_synced, DEV_FLAG_STATE_SYNCED);
 __create_dev_flag_accessors(dma_coherent, DEV_FLAG_DMA_COHERENT);
 __create_dev_flag_accessors(of_node_reused, DEV_FLAG_OF_NODE_REUSED);
+__create_dev_flag_accessors(offline_disabled, DEV_FLAG_OFFLINE_DISABLED);
+__create_dev_flag_accessors(offline, DEV_FLAG_OFFLINE);
 
 /**
  * struct device_link - Device link representation.
diff --git a/kernel/cpu.c b/kernel/cpu.c
index bc4f7a9ba64e..f975bb34915b 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -2639,7 +2639,7 @@ static void cpuhp_offline_cpu_device(unsigned int cpu)
 {
 	struct device *dev = get_cpu_device(cpu);
 
-	dev->offline = true;
+	dev_set_offline(dev);
 	/* Tell user space about the state change */
 	kobject_uevent(&dev->kobj, KOBJ_OFFLINE);
 }
@@ -2648,7 +2648,7 @@ static void cpuhp_online_cpu_device(unsigned int cpu)
 {
 	struct device *dev = get_cpu_device(cpu);
 
-	dev->offline = false;
+	dev_clear_offline(dev);
 	/* Tell user space about the state change */
 	kobject_uevent(&dev->kobj, KOBJ_ONLINE);
 }
-- 
2.53.0.1213.gd9a14994de-goog

