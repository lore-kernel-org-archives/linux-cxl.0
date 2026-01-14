Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936883803D4
	for <linux-cxl@vger.kernel.org>; Wed, 14 Jan 2026 08:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768380771; cv=none; b=oqBrTM4bLjqdSfO7ofOf0Tc+B8WgUBC4YXFvQrMpjZHJOHtb+gNGwitUcHkMfxsnl/+EyelSncjzGmDX0drnXP+oW3VdRdblSh4Mj6s/CYsP8pDAMQWSJEQgRguD7SUIbQ7jEy3Kkii9XNkc22DhfZh6ABhcUiIOXeTnfQbEZ4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768380771; c=relaxed/simple;
	bh=ppAQ1Xz+aQObI+pJwKI87VFbc6xwZ4eiDj36T0P8LFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DaVNsQvP+NNR/72HgYBRg5tB1GBi1UU6DpMPUwEMJWG5m4eWUWpA26t1VYnKeW+hV0FymrJoqpMgNziI/qWbgykZunTBezROt1gElsJuMa5MXbUE7CONfau5kk9WyUXND+52EpSrmlmxvlOrEjatwQ/LbZFy83P6jyjWZCpcaCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=qfpuOh3k; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="qfpuOh3k"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-50143fe869fso12463161cf.1
        for <linux-cxl@vger.kernel.org>; Wed, 14 Jan 2026 00:52:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1768380763; x=1768985563; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7jiGG+pI5vJ9QdTZL/6UItyqMN2lMDN4VjpLN+CazVs=;
        b=qfpuOh3k5gc/ExVqBlU9X5SFChWFyYtou/exRsAVa8c8zHM9A4hqPFr7CMR7MuK//I
         GmCUTPPOWqEMDe7MUNUVlhb9gnUQLLiTBum63k2JIjF8XHVvcuy+sGtTRv81YEAKEXua
         yOnOZdT+5e6mli5gTkEux5La1csk6IUeLSAAtjHBZ8DFqI0cWiOZ9Mz0g0Xp8LKiBn8C
         QbBQKv7dMKAJB8b5wQPRNaq8qsHNBATdcnNwMwPLoiBD5be+A/KO6BjPXjpqfjUoM4Gs
         hYrPXUoQA8wZggVG6GkMLL0VCseRw1rlDPP3JYlKZrcD47mKIUQfnkTAsob4jQB4yOl3
         BnCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768380763; x=1768985563;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7jiGG+pI5vJ9QdTZL/6UItyqMN2lMDN4VjpLN+CazVs=;
        b=XVTkmYj3Jvi2q64GASMb7XQx1oX1k79lAqFgAZaHS8pRM0xaWkp3GoPY/QvfSYBi8P
         O4Q5Cicbq4jaI734hAXpCKTzm/pCO6HKJLCmQtv862rdG5AQm3gu2vp97QXkdjLZYp+Q
         oYq8PFQ/cXJFw3N6tWzMTj+ojWr1uufPPYNoB+ETPQjyqRW1GiXaUaVR7T0LxTxTfS5U
         Pb7dE3gBMAQZnNWLjGddhSmyxr/5PW5P3yVdOcTe8dxr2II+xLWDnKGZTk0Yxg9u8peX
         y+08/TTW78a7otvraEjDt2ZLq2qtQBpMPWhfE/Gf1IUwCpUB22h0WfMXMA0nh2ssYX7z
         sgmA==
X-Gm-Message-State: AOJu0YzisZ/TgieRXTEihymBlSaADp09OOZnVa3GcSSA4pK9EEPj2M8o
	XZKEHxljCW14X+vT1ZLQmgE+xUMYnf+i32vCirUdjsunQ3pDlSI5DWDH5OAe0H7R59s=
X-Gm-Gg: AY/fxX7rYFmopI0pXixtifpipb9HFu49eFyocSC8fuhT6zn0hdXB4Bk4PFFhpbvg50R
	aakZh0rY48lABMIFRDFt2DR1CsgMjD8P0DmqdOvkKNxQTKiZKgtj49YKiUj9AmOKOgk02IVEX3y
	BsURbnrAfPTCr8eVHR8DvLR6+AtfujcfAUmqCX1A8xvCEjMNZciItpajtXylOCum8jwF2oyrAG5
	Mp0bO1JTDSgvP6jrQCrRch2ArVhvg8PVgkSxTxhkUAClWkLIFnJYbr4dZS7Oj6PmzGl28wzjo9L
	84fprKWkGPJRPvik4zMNSsykg7nSeZP1C9+8LeyZ8GLXxmIeub7QAoE7kOawdSkfbEpj55PV8DK
	Wx2luvoeV/kqpcOHCY8vyYMw127c1jpsapb7r5LXYH4pcLHiIwOIAf5fDMufZZ3c8ERU9bCwqSf
	y7hEb742/ZF9+ztlRmT9NaSoMKdbsicNQ15yX6FMQtxzo/oANiYrlvUkidjmLbP51xVB2Ep7KAl
	cg=
X-Received: by 2002:a05:622a:1b1e:b0:4f4:d295:1f53 with SMTP id d75a77b69052e-501484b9dabmr20297781cf.84.1768380762822;
        Wed, 14 Jan 2026 00:52:42 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50148df8759sm10131931cf.10.2026.01.14.00.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 00:52:42 -0800 (PST)
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
	akpm@linux-foundation.org
Subject: [PATCH 5/8] dax/kmem: extract hotplug/hotremove helper functions
Date: Wed, 14 Jan 2026 03:51:57 -0500
Message-ID: <20260114085201.3222597-6-gourry@gourry.net>
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

Refactor dev_dax_kmem_probe() and dev_dax_kmem_remove() by extracting
the memory hotplug and hot-remove logic into separate helper functions:

  - dax_kmem_do_hotplug(): handles memory region reservation and adding
  - dax_kmem_do_hotremove(): handles memory removal and resource cleanup

Update to use the new add_memory_driver_managed() signature with
explicit online_type parameter, passing MMOP_SYSTEM_DEFAULT to
maintain existing behavior.

This is a pure refactoring with no functional change. The helpers will
enable future extensions to support more granular control over memory
hotplug operations.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 drivers/dax/kmem.c | 244 +++++++++++++++++++++++++++------------------
 1 file changed, 149 insertions(+), 95 deletions(-)

diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
index d0dd36c536a0..5225f2bf0b2a 100644
--- a/drivers/dax/kmem.c
+++ b/drivers/dax/kmem.c
@@ -65,14 +65,138 @@ static void kmem_put_memory_types(void)
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
+			       struct dax_kmem_data *data)
+{
+	struct device *dev = &dev_dax->dev;
+	int i, rc, mapped = 0;
+	mhp_t mhp_flags;
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
+
+		/*
+		 * Set flags appropriate for System RAM.  Leave ..._BUSY clear
+		 * so that add_memory() can add a child resource.  Do not
+		 * inherit flags from the parent since it may set new flags
+		 * unknown to us that will break add_memory() below.
+		 */
+		res->flags = IORESOURCE_SYSTEM_RAM;
+
+		mhp_flags = MHP_NID_IS_MGID;
+		if (dev_dax->memmap_on_memory)
+			mhp_flags |= MHP_MEMMAP_ON_MEMORY;
+
+		/*
+		 * Ensure that future kexec'd kernels will not treat
+		 * this as RAM automatically.
+		 */
+		rc = add_memory_driver_managed(data->mgid, range.start,
+					       range_len(&range), kmem_name,
+					       mhp_flags, MMOP_SYSTEM_DEFAULT);
+
+		if (rc < 0) {
+			dev_warn(dev, "mapping%d: %#llx-%#llx memory add failed\n",
+				 i, range.start, range.end);
+			remove_resource(res);
+			kfree(res);
+			data->res[i] = NULL;
+			if (mapped)
+				continue;
+			return rc;
+		}
+		mapped++;
+	}
+
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
+		/* Skip ranges not currently added */
+		if (!data->res[i])
+			continue;
+
+		rc = remove_memory(range.start, range_len(&range));
+		if (rc == 0) {
+			remove_resource(data->res[i]);
+			kfree(data->res[i]);
+			data->res[i] = NULL;
+			success++;
+			continue;
+		}
+		any_hotremove_failed = true;
+		dev_err(dev, "mapping%d: %#llx-%#llx offline failed\n",
+			i, range.start, range.end);
+	}
+
+	return success;
+}
+#endif /* CONFIG_MEMORY_HOTREMOVE */
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
 	int adist = MEMTIER_DEFAULT_DAX_ADISTANCE;
 
@@ -134,68 +258,16 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
 		goto err_reg_mgid;
 	data->mgid = rc;
 
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
-		rc = add_memory_driver_managed(data->mgid, range.start,
-				range_len(&range), kmem_name, mhp_flags,
-				MMOP_SYSTEM_DEFAULT);
-
-		if (rc < 0) {
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
 	dev_set_drvdata(dev, data);
 
+	rc = dax_kmem_do_hotplug(dev_dax, data);
+	if (rc < 0)
+		goto err_hotplug;
+
 	return 0;
 
-err_request_mem:
+err_hotplug:
+	dev_set_drvdata(dev, NULL);
 	memory_group_unregister(data->mgid);
 err_reg_mgid:
 	kfree(data->res_name);
@@ -209,7 +281,7 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
 #ifdef CONFIG_MEMORY_HOTREMOVE
 static void dev_dax_kmem_remove(struct dev_dax *dev_dax)
 {
-	int i, success = 0;
+	int success;
 	int node = dev_dax->target_node;
 	struct device *dev = &dev_dax->dev;
 	struct dax_kmem_data *data = dev_get_drvdata(dev);
@@ -220,42 +292,24 @@ static void dev_dax_kmem_remove(struct dev_dax *dev_dax)
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
2.52.0

