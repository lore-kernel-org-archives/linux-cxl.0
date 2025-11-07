Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABEE1331A51
	for <linux-cxl@vger.kernel.org>; Fri,  7 Nov 2025 22:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762555827; cv=none; b=Ud8tI3XPDF0LUvisPOiexbU1TNO745h8xpTo92+0mSisND4zfySaYWzMKB+ze/Vk6CBT/dWs1q68DVHSHnOjdMtZ+uo0ZXI4Ltk2cWOpScOHZF9cca/JubH/l4zEhamGc3K2dvmskLhiUEiLa28W0od1szWfYJqvi9dIZNAvQsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762555827; c=relaxed/simple;
	bh=tSh2k/90dL3dI0zpcxARGhUF4rlq7O4vW4BNP7CcNwc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FCi+MBJeI4I+eFMuPI3hb2J75jkZV0mDGacdAwO2/DnzSf07SjGOo/yQRuCuVcmoF2DYR+edtwEQW2BBNuf926psYtgBRS8VJrH3Yt8O38izofF4g6gfLB1aYsD7GOB6uzhcJmFEp6Wm9bWWdQEhNEXJqJltGKAjejJd7b9tYVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=aw/wI5v/; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="aw/wI5v/"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4eda6a8cc12so453371cf.0
        for <linux-cxl@vger.kernel.org>; Fri, 07 Nov 2025 14:50:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1762555825; x=1763160625; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CwxO6b4UaIu9W6F2d/g8AaHHPWCBsuMNbHYfAmKzKTo=;
        b=aw/wI5v/V2pViajSJfvh9FZwnNq2bke5v3pCCvw4+1MFAWWlbyy5dMJb9BbAT5WREB
         XYy3pSNb9cIqn6dMHKZpZDYGT983Lkj3YKmUmOYAy61x+0YpNv+EdW6/jT83NPy1jOv/
         6QBsQmauykNg57zqXlmL8c1i+FD/4m+stgxYBy17VfDUcJjGdxddNl/U3C6xF1YQTgFF
         qZi7S3+uuFQEFG1PHk8nzYDMQPAy2CZF0gYAJuAN5uKY9rALhABlNjetKYcpOIGldt0Y
         UGfUV5eXPrQaPoRIGo+Ir6OTKynN4HkBL7xrKK75VheHIs6VQbu3CQKOsEZTPvaTCRIK
         jjxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762555825; x=1763160625;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CwxO6b4UaIu9W6F2d/g8AaHHPWCBsuMNbHYfAmKzKTo=;
        b=X5hqfUE++0rkUJu84KSASk5qnNNQLjsdb85qL6MzEpMWl5w8h0HKRQZnWRwm6+W2UD
         jNE8JNxsSKXeP4yu/jBP41YQcxg0HASb2xQXbSVheEjvVK9+WOMSDYMdGWL/ZiQFUj1+
         ecogwxE/pdt4mv1B9mZlAcCkbNGBnkhG9XaQ0AclpPSazTBAITjuT/6xKTxpg7rMpkgz
         oBwIqsJl5UGB9B41hG6QwfDcv8/5gBvJF1Jgk0dLrUqWWOS9U6MtWrENgz4o3xTKyHFQ
         /IiD1GE0sR0i7kfHH/p2awx3xkO3j2ObNMdGZG0EAi9JYqkT9YhHev/kGFMcXZ84WKxV
         tsjQ==
X-Gm-Message-State: AOJu0YzWGiN8myA43KpNg2NmFsx2KYbRjSEp95Y4341306DvGC8Lofci
	XAgOPA8DLpZhWfJrpK2ErISoCmUYh5CbxYQ3Wjw1F+teQPSldTS8/SZbgY66xKQ1JEY=
X-Gm-Gg: ASbGncuTkri4cVou3VeSXvATHmkEvmlS+JurDp9oZiFQr8NFYH0pWplF2KFrIXtUVl9
	pEGQaOoZ0WEQEMoeZAJQgTKyrEjrwA/C7VK32RSFY7PDxhMuqQ3Iuh9iY6zSBQWGdoaFXjSmbMU
	h0Fbp33ssxG+Uu7O34RSiPdYuNcmN2snV0pWqB0XGU4lh7KlC6uTsr8KQ6IGwObG/vutL5RDKVq
	xHZMostdWeGjKZN8Ji6066OANMhBkUDMbHd7ZIxjiY5oeTGGu55QgevaHTCAB23c/wK+GyBO4r1
	GZmmk4Gt0tHA9YePMiFPG0YuHMY92QB3nhob0KvXaUcHiEZo9mf1fwa7S/NV+kpYG69m1AO2662
	8uri4IKIzsglp7c9o4C/OEJtnxm9OsuabdwZeynt8bJ6T8zoTaa65dI+30CmvzN8Rs10fp0j3ND
	Xq09k+twhGX/7UPRH+SUNCpaOwCxQfJxEKhXS6Ba/SD35+Of1cFVMu/76mdsX3hKMbQKNnEMczg
	ZI=
X-Google-Smtp-Source: AGHT+IGGUkY/hMvQZUDcDXSyhiDaml+qPtZeSmCY7fYoXMiela3sPEpJdPQ5lN6VWEde9PlUke632Q==
X-Received: by 2002:a05:622a:1ba9:b0:4ed:43fe:f51e with SMTP id d75a77b69052e-4eda4f8ffb3mr10117651cf.39.1762555824542;
        Fri, 07 Nov 2025 14:50:24 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4eda57ad8e6sm3293421cf.27.2025.11.07.14.50.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 14:50:24 -0800 (PST)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nvdimm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	cgroups@vger.kernel.org,
	dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	longman@redhat.com,
	akpm@linux-foundation.org,
	david@redhat.com,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	osalvador@suse.de,
	ziy@nvidia.com,
	matthew.brost@intel.com,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	byungchul@sk.com,
	gourry@gourry.net,
	ying.huang@linux.alibaba.com,
	apopple@nvidia.com,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	kees@kernel.org,
	muchun.song@linux.dev,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	rientjes@google.com,
	jackmanb@google.com,
	cl@gentwo.org,
	harry.yoo@oracle.com,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	zhengqi.arch@bytedance.com,
	yosry.ahmed@linux.dev,
	nphamcs@gmail.com,
	chengming.zhou@linux.dev,
	fabio.m.de.francesco@linux.intel.com,
	rrichter@amd.com,
	ming.li@zohomail.com,
	usamaarif642@gmail.com,
	brauner@kernel.org,
	oleg@redhat.com,
	namcao@linutronix.de,
	escape@linux.alibaba.com,
	dongjoo.seo1@samsung.com
Subject: [RFC PATCH 7/9] drivers/dax: add protected memory bit to dev_dax
Date: Fri,  7 Nov 2025 17:49:52 -0500
Message-ID: <20251107224956.477056-8-gourry@gourry.net>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251107224956.477056-1-gourry@gourry.net>
References: <20251107224956.477056-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This bit is used by dax/kmem to determine whether to set the
MHP_PROTECTED_MEMORY flags, which will make whether hotplug memory
should be restricted to a protected memory NUMA node.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 drivers/dax/bus.c         | 39 +++++++++++++++++++++++++++++++++++++++
 drivers/dax/bus.h         |  1 +
 drivers/dax/dax-private.h |  1 +
 drivers/dax/kmem.c        |  2 ++
 4 files changed, 43 insertions(+)

diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
index fde29e0ad68b..4321e80276f0 100644
--- a/drivers/dax/bus.c
+++ b/drivers/dax/bus.c
@@ -1361,6 +1361,43 @@ static ssize_t memmap_on_memory_store(struct device *dev,
 }
 static DEVICE_ATTR_RW(memmap_on_memory);
 
+static ssize_t protected_memory_show(struct device *dev,
+				     struct device_attribute *attr, char *buf)
+{
+	struct dev_dax *dev_dax = to_dev_dax(dev);
+
+	return sysfs_emit(buf, "%d\n", dev_dax->protected_memory);
+}
+
+static ssize_t protected_memory_store(struct device *dev,
+				      struct device_attribute *attr,
+				      const char *buf, size_t len)
+{
+	struct dev_dax *dev_dax = to_dev_dax(dev);
+	bool val;
+	int rc;
+
+	rc = kstrtobool(buf, &val);
+	if (rc)
+		return rc;
+
+	rc = down_write_killable(&dax_dev_rwsem);
+	if (rc)
+		return rc;
+
+	if (dev_dax->protected_memory != val && dev->driver &&
+	    to_dax_drv(dev->driver)->type == DAXDRV_KMEM_TYPE) {
+		up_write(&dax_dev_rwsem);
+		return -EBUSY;
+	}
+
+	dev_dax->protected_memory = val;
+	up_write(&dax_dev_rwsem);
+
+	return len;
+}
+static DEVICE_ATTR_RW(protected_memory);
+
 static umode_t dev_dax_visible(struct kobject *kobj, struct attribute *a, int n)
 {
 	struct device *dev = container_of(kobj, struct device, kobj);
@@ -1388,6 +1425,7 @@ static struct attribute *dev_dax_attributes[] = {
 	&dev_attr_resource.attr,
 	&dev_attr_numa_node.attr,
 	&dev_attr_memmap_on_memory.attr,
+	&dev_attr_protected_memory.attr,
 	NULL,
 };
 
@@ -1494,6 +1532,7 @@ static struct dev_dax *__devm_create_dev_dax(struct dev_dax_data *data)
 	ida_init(&dev_dax->ida);
 
 	dev_dax->memmap_on_memory = data->memmap_on_memory;
+	dev_dax->protected_memory = data->protected_memory;
 
 	inode = dax_inode(dax_dev);
 	dev->devt = inode->i_rdev;
diff --git a/drivers/dax/bus.h b/drivers/dax/bus.h
index cbbf64443098..0a885bf9839f 100644
--- a/drivers/dax/bus.h
+++ b/drivers/dax/bus.h
@@ -24,6 +24,7 @@ struct dev_dax_data {
 	resource_size_t size;
 	int id;
 	bool memmap_on_memory;
+	bool protected_memory;
 };
 
 struct dev_dax *devm_create_dev_dax(struct dev_dax_data *data);
diff --git a/drivers/dax/dax-private.h b/drivers/dax/dax-private.h
index 0867115aeef2..605b7ed87ffe 100644
--- a/drivers/dax/dax-private.h
+++ b/drivers/dax/dax-private.h
@@ -89,6 +89,7 @@ struct dev_dax {
 	struct device dev;
 	struct dev_pagemap *pgmap;
 	bool memmap_on_memory;
+	bool protected_memory;
 	int nr_range;
 	struct dev_dax_range *ranges;
 };
diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
index c036e4d0b610..140c6cb0ac88 100644
--- a/drivers/dax/kmem.c
+++ b/drivers/dax/kmem.c
@@ -169,6 +169,8 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
 		mhp_flags = MHP_NID_IS_MGID;
 		if (dev_dax->memmap_on_memory)
 			mhp_flags |= MHP_MEMMAP_ON_MEMORY;
+		if (dev_dax->protected_memory)
+			mhp_flags |= MHP_PROTECTED_MEMORY;
 
 		/*
 		 * Ensure that future kexec'd kernels will not treat
-- 
2.51.1

