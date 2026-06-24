Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ADC63DA5C1
	for <linux-cxl@vger.kernel.org>; Wed, 24 Jun 2026 14:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782313093; cv=none; b=oGoYgbxdyaNH/QC4arJsewHYpqZiTV3xqFwS+ZMWmUmg21hDfe+N480GfM/MFciLeiRmlhIAqK5R/ayabBN5Jv3JRbf4YW9AOIcTZGZEz9+J6SUh8ZOXB4wuVQB71dRefyZNCuZRclfKuA3AYZKut5YVvsJNF16t0Z2UM3al2Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782313093; c=relaxed/simple;
	bh=UMz6Z8qvZGiw9OXiT47NIXHcV3Yx0cT5hve26G0hRfs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mJ0HHSqx8ae/k/H6iC0+iGJNTCR8J0vVciScwVmV7CsTNmuvZ3SF2dAfsC0WxsGN8Y73tJxV11g59isJn9JUrIU16CxcnJbzqAWnUyL6swlOELC2XPiMHHUH1ciLlxYHwZSPTN4x6Z5eL162GPPTH5vAUzjNgt6eL7oz2WESQF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=uhC0hVjg; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="uhC0hVjg"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-51778069c31so7690621cf.1
        for <linux-cxl@vger.kernel.org>; Wed, 24 Jun 2026 07:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1782313090; x=1782917890; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RKpasY2KJpfbg8w//6XxF8BOdkJDqDfdQCZLET/ejMU=;
        b=uhC0hVjgmp/cX0FARKI8ro2L0w47E6I/4Pgmlh0u9OSsdk85ocRqA5RheGccXHvMLW
         C3gyGcd8ULWQY91SIYa5y9Ant1sojVdbg7PsNALXxDRtIbFXQjuvcbczL+LCtcY0trqt
         QvFu9trvPlZhvnpsJS4djtlkE9GxHimJTx1O30ayKRYqBI2+cE/Ju0d9M3DLnT3zp2MP
         ZEcJVtD9+7TJbH3mhaVwKgguzSDe+QCJSjf+cVn3CZFtTTRFpvpzF8ASK3RBZc91YmNM
         jo7J4qpNn1bQWbmAyfr90BtfK4LnN8aqqEMh9enXfCrUm/Csu7GSaMd0VBBIqPO5bRkw
         pMMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782313090; x=1782917890;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RKpasY2KJpfbg8w//6XxF8BOdkJDqDfdQCZLET/ejMU=;
        b=Io77CkHR/6gM2TnRjQhpC+P/u1SN/tUtF8QbiMyQ5c3BK1XjaGLYfFZdjHfxR8O5Pv
         Cc7TRWXqRQ/RTSpAGDjelArK2woq91XmOIpIi0LKPYPJd8uvGAwFydDvJ26fB0jqK05/
         FH21JU8OoaKlVczOjiWG2XaZ7M3fM+1VVyrCZvbJGCQxXeRCmB1MPA0sn8NyCXfWiA1V
         bmywyyZOUHKhU3k1AJiXu8rQp7pTDOwdk7MhjFwZ9Q7x5EVcMHfZg+4udRMWuU5Bm7Tz
         PjeqOLf3mnmmew7DiShXBnZdWeVUar3D+H1myX5RVNLyEyn3Wh1pnxPbpyIhbBmqzO4o
         8tNQ==
X-Forwarded-Encrypted: i=1; AFNElJ/sIox2iWmPuCHrdA5YwYkuY8doPjNfPSRN+94iDUAuPXWxuON0tVjjaomy3einakOnFkbH1LdT7Is=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgHkhdJZppL6w6h6XrLX/8DXITHbG06WRKoGOfM0iF2fcXwcJF
	XNncqjSWULh3+XJwdn1dmOzmRryidIeCkq0f8Ev0DcKqxwftmtXvdPxBamQKMNA55K0=
X-Gm-Gg: AfdE7cmx5FonCCNP1AoHyaqj6noRBQaO4tCwx9mCvLi1hLfsD10c/qzFl3L35eSgy6V
	zlk/Q1V3mgs7T+YZsLbjnC4wxKB2wP/+wXVyWRMxz/MXpJa/ehTsBtCY/XuwWcPcISuqGNGQVWO
	HNDlu1vmvBBp/Mr7R7+4TmGdRKLiov3jYeCMi+Dwwp3JxNGNRLZw0cvbkh2w3O3GffvTBcesGTZ
	TUMceNlh7nmnDivdJpqf4wRKW28jaWWSNPUcRru5onO/eqYzCRkmOeczgg4rIlv7fl4g3yvTWwh
	Zb6Z8c/vnY6imMRo8mWYoZ/cfuzv0FjLA/nXOMiByrS5QZy88Yxj+k/vX9N9SDUfdxRVyZ96hA3
	TP/FElJiSK8KBzpJInzrggEgXEZLCaE/DoSSVKH16roOhlVj19oBdT6k10C7OJkYCTsT36aT6/s
	pdK/MkV8KdDTAURueB2ptQcl1Fs5HkJER+UTXEnywPwZol2CfLuUGwz/AbmDPJT8ENq6I9Eh180
	ovKNhauH96O
X-Received: by 2002:a05:622a:1355:b0:517:580c:bcd5 with SMTP id d75a77b69052e-51a547035f3mr101298441cf.16.1782313089996;
        Wed, 24 Jun 2026 07:58:09 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51a51ae8ee7sm49502301cf.24.2026.06.24.07.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 07:58:09 -0700 (PDT)
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
	apopple@nvidia.com
Subject: [PATCH v5 7/9] dax/kmem: extract hotplug/hotremove helper functions
Date: Wed, 24 Jun 2026 10:57:42 -0400
Message-ID: <20260624145744.3532049-8-gourry@gourry.net>
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

Refactor kmem _probe() _remove() by extracting init, cleanup, hotplug,
and hot-remove logic into separate helper functions:

  - dax_kmem_init_resources: inits IO_RESOURCE w/ request_mem_region
  - dax_kmem_cleanup_resources: cleans up initialized IO_RESOURCE
  - dax_kmem_do_hotplug: handles memory region reservation and adding
  - dax_kmem_do_hotremove: handles memory removal and resource cleanup

This is a pure refactoring with no functional change. The helpers will
enable future extensions to support more granular control over memory
hotplug operations.

We need to split hotplug/hotunplug and init/cleanup in order to have the
resources available for hot-add.  Otherwise, when probe occurs, the dax
devices are never added to sysfs because the resources are never
registered.

Detatching hotunplug/cleanup allows us to re-use the hotunplug code
without destroying the underlying resources.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 drivers/dax/kmem.c | 316 ++++++++++++++++++++++++++++++---------------
 1 file changed, 214 insertions(+), 102 deletions(-)

diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
index 0a184c0878dd..a45e50def537 100644
--- a/drivers/dax/kmem.c
+++ b/drivers/dax/kmem.c
@@ -63,14 +63,195 @@ static void kmem_put_memory_types(void)
 	mt_put_memory_types(&kmem_memory_types);
 }
 
+/**
+ * dax_kmem_do_hotplug - hotplug memory for dax kmem device
+ * @dev_dax: the dev_dax instance
+ * @data: the dax_kmem_data structure with resource tracking
+ *
+ * Hotplugs all ranges in the dev_dax region as system memory.
+ *
+ * Returns the number of successfully mapped ranges, or negative error.
+ */
+static int dax_kmem_do_hotplug(struct dev_dax *dev_dax,
+			       struct dax_kmem_data *data,
+			       int online_type)
+{
+	struct device *dev = &dev_dax->dev;
+	int i, rc, onlined = 0;
+	mhp_t mhp_flags;
+
+	for (i = 0; i < dev_dax->nr_range; i++) {
+		struct range range;
+
+		rc = dax_kmem_range(dev_dax, i, &range);
+		if (rc)
+			continue;
+
+		mhp_flags = MHP_NID_IS_MGID;
+		if (dev_dax->memmap_on_memory)
+			mhp_flags |= MHP_MEMMAP_ON_MEMORY;
+
+		/*
+		 * Ensure that future kexec'd kernels will not treat
+		 * this as RAM automatically.
+		 */
+		rc = __add_memory_driver_managed(data->mgid, range.start,
+				range_len(&range), kmem_name, mhp_flags,
+				online_type);
+
+		if (rc) {
+			dev_warn(dev, "mapping%d: %#llx-%#llx memory add failed\n",
+				 i, range.start, range.end);
+			/*
+			 * Release the reservation for the range that failed to
+			 * add so a later hotremove does not try to remove memory
+			 * that was never added.
+			 */
+			if (data->res[i]) {
+				remove_resource(data->res[i]);
+				kfree(data->res[i]);
+				data->res[i] = NULL;
+			}
+			if (onlined)
+				continue;
+			return rc;
+		}
+		onlined++;
+	}
+
+	return onlined;
+}
+
+/**
+ * dax_kmem_init_resources - create memory regions for dax kmem
+ * @dev_dax: the dev_dax instance
+ * @data: the dax_kmem_data structure with resource tracking
+ *
+ * Initializes all the resources for the DAX
+ *
+ * Returns the number of successfully mapped ranges, or negative error.
+ */
+static int dax_kmem_init_resources(struct dev_dax *dev_dax,
+				   struct dax_kmem_data *data)
+{
+	struct device *dev = &dev_dax->dev;
+	int i, rc, mapped = 0;
+
+	for (i = 0; i < dev_dax->nr_range; i++) {
+		struct resource *res;
+		struct range range;
+
+		rc = dax_kmem_range(dev_dax, i, &range);
+		if (rc)
+			continue;
+
+		/* Skip ranges already added */
+		if (data->res[i])
+			continue;
+
+		/* Region is permanently reserved if hotremove fails. */
+		res = request_mem_region(range.start, range_len(&range),
+					 data->res_name);
+		if (!res) {
+			dev_warn(dev, "mapping%d: %#llx-%#llx could not reserve region\n",
+				 i, range.start, range.end);
+			/*
+			 * Once some memory has been onlined we can't
+			 * assume that it can be un-onlined safely.
+			 */
+			if (mapped)
+				continue;
+			return -EBUSY;
+		}
+		data->res[i] = res;
+		/*
+		 * Set flags appropriate for System RAM.  Leave ..._BUSY clear
+		 * so that add_memory() can add a child resource.  Do not
+		 * inherit flags from the parent since it may set new flags
+		 * unknown to us that will break add_memory() below.
+		 */
+		res->flags = IORESOURCE_SYSTEM_RAM;
+		mapped++;
+	}
+	return mapped;
+}
+
+#ifdef CONFIG_MEMORY_HOTREMOVE
+/**
+ * dax_kmem_do_hotremove - hot-remove memory for dax kmem device
+ * @dev_dax: the dev_dax instance
+ * @data: the dax_kmem_data structure with resource tracking
+ *
+ * Removes all ranges in the dev_dax region.
+ *
+ * Returns the number of successfully removed ranges.
+ */
+static int dax_kmem_do_hotremove(struct dev_dax *dev_dax,
+				 struct dax_kmem_data *data)
+{
+	struct device *dev = &dev_dax->dev;
+	int i, success = 0;
+
+	for (i = 0; i < dev_dax->nr_range; i++) {
+		struct range range;
+		int rc;
+
+		rc = dax_kmem_range(dev_dax, i, &range);
+		if (rc)
+			continue;
+
+		/* range was never added during probe, count as removed */
+		if (!data->res[i]) {
+			success++;
+			continue;
+		}
+
+		rc = remove_memory(range.start, range_len(&range));
+		if (rc == 0) {
+			/* Release the resource for the successfully removed range */
+			remove_resource(data->res[i]);
+			kfree(data->res[i]);
+			data->res[i] = NULL;
+			success++;
+			continue;
+		}
+		any_hotremove_failed = true;
+		dev_err(dev, "mapping%d: %#llx-%#llx hotremove failed\n",
+			i, range.start, range.end);
+	}
+
+	return success;
+}
+#endif /* CONFIG_MEMORY_HOTREMOVE */
+
+/**
+ * dax_kmem_cleanup_resources - remove the dax memory resources
+ * @dev_dax: the dev_dax instance
+ * @data: the dax_kmem_data structure with resource tracking
+ *
+ * Removes all resources in the dev_dax region.
+ */
+static void dax_kmem_cleanup_resources(struct dev_dax *dev_dax,
+				       struct dax_kmem_data *data)
+{
+	int i;
+
+	for (i = 0; i < dev_dax->nr_range; i++) {
+		if (!data->res[i])
+			continue;
+		remove_resource(data->res[i]);
+		kfree(data->res[i]);
+		data->res[i] = NULL;
+	}
+}
+
 static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
 {
 	struct device *dev = &dev_dax->dev;
 	unsigned long total_len = 0, orig_len = 0;
 	struct dax_kmem_data *data;
 	struct memory_dev_type *mtype;
-	int i, rc, mapped = 0;
-	mhp_t mhp_flags;
+	int i, rc;
 	int numa_node;
 	int online_type;
 	int adist = MEMTIER_DEFAULT_DAX_ADISTANCE;
@@ -133,73 +314,27 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
 		goto err_reg_mgid;
 	data->mgid = rc;
 
+	dev_set_drvdata(dev, data);
+
+	rc = dax_kmem_init_resources(dev_dax, data);
+	if (rc < 0)
+		goto err_resources;
+
 	/* Resolve system default at bind time in case it changed */
 	online_type = dev_dax->online_type;
 	if (online_type == DAX_ONLINE_DEFAULT)
 		online_type = mhp_get_default_online_type();
 
-	for (i = 0; i < dev_dax->nr_range; i++) {
-		struct resource *res;
-		struct range range;
-
-		rc = dax_kmem_range(dev_dax, i, &range);
-		if (rc)
-			continue;
-
-		/* Region is permanently reserved if hotremove fails. */
-		res = request_mem_region(range.start, range_len(&range), data->res_name);
-		if (!res) {
-			dev_warn(dev, "mapping%d: %#llx-%#llx could not reserve region\n",
-					i, range.start, range.end);
-			/*
-			 * Once some memory has been onlined we can't
-			 * assume that it can be un-onlined safely.
-			 */
-			if (mapped)
-				continue;
-			rc = -EBUSY;
-			goto err_request_mem;
-		}
-		data->res[i] = res;
-
-		/*
-		 * Set flags appropriate for System RAM.  Leave ..._BUSY clear
-		 * so that add_memory() can add a child resource.  Do not
-		 * inherit flags from the parent since it may set new flags
-		 * unknown to us that will break add_memory() below.
-		 */
-		res->flags = IORESOURCE_SYSTEM_RAM;
-
-		mhp_flags = MHP_NID_IS_MGID;
-		if (dev_dax->memmap_on_memory)
-			mhp_flags |= MHP_MEMMAP_ON_MEMORY;
-
-		/*
-		 * Ensure that future kexec'd kernels will not treat
-		 * this as RAM automatically.
-		 */
-		rc = __add_memory_driver_managed(data->mgid, range.start,
-				range_len(&range), kmem_name, mhp_flags,
-				online_type);
-
-		if (rc) {
-			dev_warn(dev, "mapping%d: %#llx-%#llx memory add failed\n",
-					i, range.start, range.end);
-			remove_resource(res);
-			kfree(res);
-			data->res[i] = NULL;
-			if (mapped)
-				continue;
-			goto err_request_mem;
-		}
-		mapped++;
-	}
-
-	dev_set_drvdata(dev, data);
+	rc = dax_kmem_do_hotplug(dev_dax, data, online_type);
+	if (rc < 0)
+		goto err_hotplug;
 
 	return 0;
 
-err_request_mem:
+err_hotplug:
+	dax_kmem_cleanup_resources(dev_dax, data);
+err_resources:
+	dev_set_drvdata(dev, NULL);
 	memory_group_unregister(data->mgid);
 err_reg_mgid:
 	kfree(data->res_name);
@@ -213,7 +348,7 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
 #ifdef CONFIG_MEMORY_HOTREMOVE
 static void dev_dax_kmem_remove(struct dev_dax *dev_dax)
 {
-	int i, success = 0;
+	int success;
 	int node = dev_dax->target_node;
 	struct device *dev = &dev_dax->dev;
 	struct dax_kmem_data *data = dev_get_drvdata(dev);
@@ -224,48 +359,25 @@ static void dev_dax_kmem_remove(struct dev_dax *dev_dax)
 	 * there is no way to hotremove this memory until reboot because device
 	 * unbind will succeed even if we return failure.
 	 */
-	for (i = 0; i < dev_dax->nr_range; i++) {
-		struct range range;
-		int rc;
-
-		rc = dax_kmem_range(dev_dax, i, &range);
-		if (rc)
-			continue;
-
-		/* range was never added during probe */
-		if (!data->res[i]) {
-			success++;
-			continue;
-		}
-
-		rc = remove_memory(range.start, range_len(&range));
-		if (rc == 0) {
-			remove_resource(data->res[i]);
-			kfree(data->res[i]);
-			data->res[i] = NULL;
-			success++;
-			continue;
-		}
-		any_hotremove_failed = true;
-		dev_err(dev,
-			"mapping%d: %#llx-%#llx cannot be hotremoved until the next reboot\n",
-				i, range.start, range.end);
+	success = dax_kmem_do_hotremove(dev_dax, data);
+	if (success < dev_dax->nr_range) {
+		dev_err(dev, "Hotplug regions stuck online until reboot\n");
+		return;
 	}
 
-	if (success >= dev_dax->nr_range) {
-		memory_group_unregister(data->mgid);
-		kfree(data->res_name);
-		kfree(data);
-		dev_set_drvdata(dev, NULL);
-		/*
-		 * Clear the memtype association on successful unplug.
-		 * If not, we have memory blocks left which can be
-		 * offlined/onlined later. We need to keep memory_dev_type
-		 * for that. This implies this reference will be around
-		 * till next reboot.
-		 */
-		clear_node_memory_type(node, NULL);
-	}
+	dax_kmem_cleanup_resources(dev_dax, data);
+	memory_group_unregister(data->mgid);
+	kfree(data->res_name);
+	kfree(data);
+	dev_set_drvdata(dev, NULL);
+	/*
+	 * Clear the memtype association on successful unplug.
+	 * If not, we have memory blocks left which can be
+	 * offlined/onlined later. We need to keep memory_dev_type
+	 * for that. This implies this reference will be around
+	 * till next reboot.
+	 */
+	clear_node_memory_type(node, NULL);
 }
 #else
 static void dev_dax_kmem_remove(struct dev_dax *dev_dax)
-- 
2.54.0

