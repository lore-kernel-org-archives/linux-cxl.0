Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829683DC4AE
	for <linux-cxl@vger.kernel.org>; Wed, 22 Jul 2026 18:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784745329; cv=none; b=p5d3s9oghFQLiNGK6nvJ0trJ3De3X6JpDHQJTlcRNDaI0Gk7kXyts6qrdCvMs1p5+p6+Vgb9/oMpkKIeYhCr9FARhZGRHluCEzdKgTS9gymY+ohQ8Vl1eP9sXO+8h409d3Pv+74gxCY7kHiYeXUZBfbXDymvUxMvO8csF99ksg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784745329; c=relaxed/simple;
	bh=17xpFpa5YRnGNcYvBWqNUbnxwE6UGTg1b8TiOR8UmHc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MBhHlkq79iw/AIxf/6dtRBwnjpOcvT9d1pKmCc0OT2ZKjNsRwsYxAm3/VwFx9hLOctnbgeKxj0BI4uuNI464Rl4oYdFKaZfNkjXomR6RGi9YQwRDUJqXENp4sYAjZ2RmIkdd7H0HVQTEXiDspCjjokFZyHVpNLkYWaumQv7Pd/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=DFKkCMgY; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="DFKkCMgY"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-51c2cce930cso90799141cf.0
        for <linux-cxl@vger.kernel.org>; Wed, 22 Jul 2026 11:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1784745326; x=1785350126; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Pm5BZ9qJgkVevAwG5CFNqV+xwvYk7oAu9XFj5gld8ew=;
        b=DFKkCMgYuHhfHygeKuOz2qeB49pxidY/bvOiflmnE63/Df0KGZUh4FS7A2ZoXJzQjd
         C/pbPaJPXiAcMdVf9R7TwuQK44M5nUXvhNqd5oZ9R+2iv8PfSLd69JtioafhC5bx/vhj
         Z0nUMhvX/11ony+tB1KnXxyk3ucitvQVSNLSTlZQ3BPD0ECjUgxTIFwQG9md/K4AKuyO
         EudUDRZVgbTsiJ55Z4ymVq+L2ohXXuoYzL03Yk0SVSHfOYgfU0gX04yYPUW14Ip6Uylh
         T6MTddqN43Ij6kgLRRLZOjf0W/4lKteWVTkBHVMo3bf7Npd704JjLFCJCdY9dvSlSR5b
         H3+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784745326; x=1785350126;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Pm5BZ9qJgkVevAwG5CFNqV+xwvYk7oAu9XFj5gld8ew=;
        b=sfPUhycHfS7Sx+qOZ07V6+Cz72VMgWd1OwJjCxwSxmrEet6h5l+P1hBb15pa8U/oFC
         RdAZJnXma7WL9XOtvrQ071UvKwVbkkMHb0BQHCR0kobN9JGnDJ6lYAeF/egX8RGDtsUs
         cRJtz9YbhkSuNS/caAdHzjxQ9ZqPdx6llksSeEJBD54/tAgrCSp7k5rVT/R88whvMRRm
         UXJPgsM95M/d48z8RS9KpLVZB530od/EloY9MIZKUS8fgo57gC67BFW7ZSZP87RlPDkA
         Ni86Fz4IFnTjGBZfnp6KF4ZJJkv251YlCAPJpOSCHJslDzqaELPI/+EtnX6Vn/T3jDHh
         WR+g==
X-Gm-Message-State: AOJu0YyF4WiAMzGwfh8gcBWCNklc/1zJeXlPB2RlDjySlMUbtcS5TQ5u
	n/rOUUCJu7ORIUxJG9WzbF2m+4riir7mqLpvAcLla1EXXuCfTy70624Ex+kFvEdRbtj/c5Mm3+2
	tGf6C
X-Gm-Gg: AR+sD10Gh0T/0lHrg5GO/G7g1JJN5faQHIXNU7Tdj4c5adzkXIxrQxVDGOV3cgQ22TZ
	cdi/l11x6X853crDIhJKH3tzPreF0bnSMrhfOrjUYy7yMYpEtmc78MccrUsDnfOjq5ZBbsU7/F6
	vYspjIF9nzDavH9oNNB+TlpOTQwQ31sXbtUGaFM427p1KgzYN8Yd9xVXrDOJjELO/6mWVCkxl1S
	ASRh66xbatAoeRYnBEmbEwnQ1b1qYlC5iJW98FzzQXma7od2xMdutM5w8+hTCyZOtzlr5XFl3la
	adNwFwqoQBgpaSHpufqm0M7zCQYqbbA5NgDe8fozNqRteC4ar1pEU7WI49sYIfC2HlqfiMw4VlY
	kXywnmzhCbzwnGW6cFM74hRzqNHdX+M/PRQmmpHFe5bvrdgCvD7NZtk0iA2QowovZ3y+cfAJ9Ej
	RRDyGUDoAeZSlGo+YY9GbmomWA6N5MZkWUclFzTmj2h1BNys62sGXoGHpS+90Bg7I=
X-Received: by 2002:a05:622a:349:b0:527:f4d0:4bb7 with SMTP id d75a77b69052e-527f4d05517mr42226231cf.52.1784745326076;
        Wed, 22 Jul 2026 11:35:26 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-907ba8b3e96sm27630216d6.1.2026.07.22.11.35.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 11:35:25 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-cxl@vger.kernel.org
Cc: nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	djbw@kernel.org,
	vishal.l.verma@intel.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com
Subject: [RFC PATCH 1/8] dax/kmem: add dax_file= to expose an anonymous-fault char device
Date: Wed, 22 Jul 2026 14:35:12 -0400
Message-ID: <20260722183519.935213-2-gourry@gourry.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260722183519.935213-1-gourry@gourry.net>
References: <20260722183519.935213-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a "dax_file" knob to dax/kmem.

When set, installs a char device on the existing /dev/daxN.N whose
mmap() turns the mapping into an ordinary ANONYMOUS mapping bound
to the device's node - so every folio (on fault and swap-in) lands
on that node exactly like an mbind() to it.

Writing 0 removes the char device again.

Because kmem devices hotplug memory to mm/, faulted memory is NOT
limited to just the dax device's memory ranges.  This is not
particularly useful for normal nodes, but will be useful for private
nodes where each node can only have one owner - and therefore the
faults are limited to the device's memory ranges.

Note: The mapping is deliberately not S_DAX - otherwise the vma would
be wrongly excluded from migration, NUMA balancing, and the like.

The node binding is a device-lifetime mempolicy, built once at online
time. A plain fault would place the first folio correctly without it,
but swap-in would likely misplace the folio, so the policy is what
keeps the mapping pinned to the node.

MAP_SHARED is rejected (no shared mappings are possible here).

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 drivers/dax/kmem.c | 171 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 170 insertions(+), 1 deletion(-)

diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
index c3faf18e7f85d..d9021cf148982 100644
--- a/drivers/dax/kmem.c
+++ b/drivers/dax/kmem.c
@@ -5,11 +5,13 @@
 #include <linux/memory.h>
 #include <linux/module.h>
 #include <linux/device.h>
+#include <linux/cdev.h>
 #include <linux/slab.h>
 #include <linux/dax.h>
 #include <linux/fs.h>
 #include <linux/mm.h>
 #include <linux/mman.h>
+#include <linux/mempolicy.h>
 #include <linux/memory-tiers.h>
 #include <linux/memory_hotplug.h>
 #include <linux/string_helpers.h>
@@ -45,8 +47,11 @@ static int dax_kmem_range(struct dev_dax *dev_dax, int i, struct range *r)
 struct dax_kmem_data {
 	const char *res_name;
 	int mgid;
+	int numa_node;
 	int state;
-	struct mutex lock; /* protects hotplug state transitions */
+	struct mutex lock; /* protects hotplug state transitions and config */
+	bool dax_file; /* when set, cdev allows mmap */
+	struct mempolicy *policy; /* device-lifetime bind for dax-file mmap */
 	struct resource *res[];
 };
 
@@ -65,6 +70,90 @@ static void kmem_put_memory_types(void)
 	mt_put_memory_types(&kmem_memory_types);
 }
 
+#ifdef CONFIG_NUMA
+static void kmem_vma_set_policy(struct vm_area_struct *vma, struct mempolicy *pol)
+{
+	vma->vm_policy = pol;
+}
+#else
+static void kmem_vma_set_policy(struct vm_area_struct *vma, struct mempolicy *pol)
+{
+}
+#endif
+
+/*
+ * On mmap, install MPOL_F_PRIVATE mempolicy to bind to that node's memory,
+ * so every folio (fault and swap-in) lands on the node exactly like an mbind().
+ * Only present when dax_file=true, otherwise returns -ENXIO as before.
+ */
+static int kmem_anon_mmap(struct file *filp, struct vm_area_struct *vma)
+{
+	struct dev_dax *dev_dax = filp->private_data;
+	struct dax_kmem_data *data = dev_get_drvdata(&dev_dax->dev);
+	int rc = 0, id;
+
+	id = dax_read_lock();
+	if (!dax_alive(dev_dax->dax_dev))
+		rc = -ENXIO;
+	dax_read_unlock(id);
+	if (rc)
+		return rc;
+
+	/* Private mappings are not shared by definition, reject MAP_SHARED. */
+	if (vma->vm_flags & VM_SHARED)
+		return -EINVAL;
+
+	/* No policy means the node is not online yet - nothing to map. */
+	if (!data->policy)
+		return -ENXIO;
+
+	vma_set_anonymous(vma);
+	mpol_get(data->policy);
+	kmem_vma_set_policy(vma, data->policy);
+	return 0;
+}
+
+static int kmem_anon_open(struct inode *inode, struct file *filp)
+{
+	struct dax_device *dax_dev = inode_dax(inode);
+	struct dev_dax *dev_dax = dax_get_private(dax_dev);
+
+	filp->private_data = dev_dax;
+	/* Deliberately NOT S_DAX to allow normal mm/ operations on the vma */
+	return 0;
+}
+
+static const struct file_operations kmem_anon_fops = {
+	.llseek = noop_llseek,
+	.owner = THIS_MODULE,
+	.open = kmem_anon_open,
+	.mmap = kmem_anon_mmap,
+};
+
+/* Installs dax-file char device fops on the existing /dev/daxN.N node. */
+static int kmem_dax_file_cdev_add(struct dev_dax *dev_dax)
+{
+	struct dax_device *dax_dev = dev_dax->dax_dev;
+	struct device *dev = &dev_dax->dev;
+	struct cdev *cdev = dax_inode(dax_dev)->i_cdev;
+	int rc;
+
+	cdev_init(cdev, &kmem_anon_fops);
+	cdev->owner = dev->driver->owner;
+	cdev_set_parent(cdev, &dev->kobj);
+	rc = cdev_add(cdev, dev->devt, 1);
+	if (rc)
+		return rc;
+	run_dax(dax_dev);
+	return 0;
+}
+
+static void kmem_dax_file_cdev_del(struct dev_dax *dev_dax)
+{
+	kill_dev_dax(dev_dax);
+	cdev_del(dax_inode(dev_dax->dax_dev)->i_cdev);
+}
+
 /* True for the online states a kmem dax device can hold. */
 static bool dax_kmem_state_is_online(int state)
 {
@@ -339,6 +428,7 @@ static ssize_t state_store(struct device *dev, struct device_attribute *attr,
 {
 	struct dev_dax *dev_dax = to_dev_dax(dev);
 	struct dax_kmem_data *data = dev_get_drvdata(dev);
+	struct mempolicy *pol;
 	int online_type;
 	int rc;
 
@@ -377,8 +467,69 @@ static ssize_t state_store(struct device *dev, struct device_attribute *attr,
 	}
 
 	data->state = online_type;
+
+	/* If in dax-file mode, build the bind policy applied during mmap */
+	if (data->dax_file && !data->policy) {
+		pol = mpol_private_bind(data->numa_node);
+		if (IS_ERR(pol))
+			dev_warn(dev, "dax-file bind failed: %ld\n", PTR_ERR(pol));
+		else
+			data->policy = pol;
+	}
+
+	return len;
+}
+
+static ssize_t dax_file_show(struct device *dev, struct device_attribute *attr,
+			     char *buf)
+{
+	struct dax_kmem_data *data = dev_get_drvdata(dev);
+
+	if (!data)
+		return -ENXIO;
+	return sysfs_emit(buf, "%d\n", data->dax_file);
+}
+
+static ssize_t dax_file_store(struct device *dev, struct device_attribute *attr,
+			      const char *buf, size_t len)
+{
+	struct dev_dax *dev_dax = to_dev_dax(dev);
+	struct dax_kmem_data *data = dev_get_drvdata(dev);
+	bool enable;
+	int rc;
+
+	if (!data)
+		return -ENXIO;
+
+	rc = kstrtobool(buf, &enable);
+	if (rc)
+		return rc;
+
+	guard(mutex)(&data->lock);
+
+	/* dax_file= only reconfigures the device while it holds no memory. */
+	if (data->state != DAX_KMEM_UNPLUGGED)
+		return -EBUSY;
+
+	if (enable == data->dax_file)
+		return len;
+
+	if (enable) {
+		/* Add the anon-fault cdev; mmap returns -ENXIO until onlined. */
+		rc = kmem_dax_file_cdev_add(dev_dax);
+		if (rc)
+			return rc;
+		data->dax_file = true;
+	} else {
+		kmem_dax_file_cdev_del(dev_dax);
+		mpol_put(data->policy);
+		data->policy = NULL;
+		data->dax_file = false;
+	}
+
 	return len;
 }
+static DEVICE_ATTR_RW(dax_file);
 
 static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
 {
@@ -448,6 +599,7 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
 	if (rc < 0)
 		goto err_reg_mgid;
 	data->mgid = rc;
+	data->numa_node = numa_node;
 	data->state = DAX_KMEM_UNPLUGGED;
 	mutex_init(&data->lock);
 
@@ -516,6 +668,13 @@ static void dev_dax_kmem_remove(struct dev_dax *dev_dax)
 	struct device *dev = &dev_dax->dev;
 	struct dax_kmem_data *data = dev_get_drvdata(dev);
 
+	/* If enabled, clean up the dax-file char device configuration. */
+	if (data->dax_file) {
+		kmem_dax_file_cdev_del(dev_dax);
+		mpol_put(data->policy);
+		data->policy = NULL;
+	}
+
 	/*
 	 * Remove every range that is still added.  dax_kmem_remove_ranges()
 	 * uses remove_memory(), which never offlines: an online block fails
@@ -548,6 +707,15 @@ static void dev_dax_kmem_remove(struct dev_dax *dev_dax)
 #else
 static void dev_dax_kmem_remove(struct dev_dax *dev_dax)
 {
+	struct dax_kmem_data *data = dev_get_drvdata(&dev_dax->dev);
+
+	/* If enabled, clean up the dax-file char device configuration. */
+	if (data && data->dax_file) {
+		kmem_dax_file_cdev_del(dev_dax);
+		mpol_put(data->policy);
+		data->policy = NULL;
+	}
+
 	/*
 	 * Without hotremove purposely leak the request_mem_region() for the
 	 * device-dax range and return '0' to ->remove() attempts. The removal
@@ -563,6 +731,7 @@ static DEVICE_ATTR_RW(state);
 
 static struct attribute *dev_dax_kmem_attrs[] = {
 	&dev_attr_state.attr,
+	&dev_attr_dax_file.attr,
 	NULL,
 };
 ATTRIBUTE_GROUPS(dev_dax_kmem);
-- 
2.53.0-Meta

