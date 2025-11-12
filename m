Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD3A353881
	for <linux-cxl@vger.kernel.org>; Wed, 12 Nov 2025 19:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762975820; cv=none; b=Tb2ixzKved3fCG4oIkZc5IZkiNY37jwuuJe9bEkIE3lI5kWBCZ4qxTFXxbK0180iSaoH5RbGlMXawQ7NNa70QRF6NsEgW+Jn7tbps/DyNF8edtl4yOloNZ9bNlrvIa3P1CYQpv7Zv7u+YHu6mEq8ckRpsAF+95Rbzu0khN7jW24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762975820; c=relaxed/simple;
	bh=KDT4LvBi3S/XOOUfgA+q7nj0PsLuynWQ2oewm937Vbs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ou7ytv3fzx9HGXhaEhyZYf7k23roTzIaKy15leu+Bvh0x7g8dTV46d5dkl8wLTD9nGXUmwdGgvoKygIm/AG6G+qHDsCjTdMkRw/BNpQUPY8sAtBUrAlb96AWfK+F91CalIkyDj+kd3SGXCNcGQB/vQeowrtJgpNb4L2goMXSPdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=iK/WZAx6; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="iK/WZAx6"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8b28f983333so4587085a.3
        for <linux-cxl@vger.kernel.org>; Wed, 12 Nov 2025 11:30:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1762975816; x=1763580616; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x8LOzdRF3F1ID8i/f4610zpV6s32IDb3v5xseVevQWo=;
        b=iK/WZAx6WSo597sQv8dIVqkTiZevnl7RNJ6CjNCRNNsysgMjw9wd8LAxosHniaUOIQ
         1ZeQKAR7HVbZBtr2aHSNZujRlWlLerK6xSmtGIb5v/1f1jFULjCLQj3IJGukejb072yG
         kyPlEwN3TL3wmoh95kLwZTsprX4hSCgP9W7300+Pk0YhzI3tzMWTTn5QJPR7VE8MDyg0
         L1M6CtPORE57vIczAIkMIyIHNQJuObn6FaNHoEGYJHHzVgY7u3dtKIocl1CdlccwNLB1
         EECRWVa4KKu2DOX9Q1E3aqUohIhmijL+SVGo0jNVJDtazmB2KiWDETbvcUL6sMr6eK6m
         ERYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762975816; x=1763580616;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=x8LOzdRF3F1ID8i/f4610zpV6s32IDb3v5xseVevQWo=;
        b=Kcc7hr9Vd8p84U4f0DWblj8D2fK2Op259rmTV082j59eiqz+V0tgD7pZcvxo3g0xHd
         le5yWNLyOnoujsvyf2aj7gHm81rnMc4u1w7DubrKed5K3SZXPM2+YDIHEnpps2NNsnIW
         rcVvqR98fxoNvTR1/7RS4YuFd8LpErdhVLi1fkW7yqH/wl4fUiU+8v9cElETa2UhnxO8
         MyU4hw/W93d9khzOPt7Xym5VOTWoI14PWzrQDxz3T4DKroVLvfINzwjQmga+ykPvHut2
         2wIDixrSmq1r8fXfmEVLDPIwYO2bbgJq8oUF6ByW22smzrNe1HPji32JFkVJ8dGmsfFr
         qg+w==
X-Forwarded-Encrypted: i=1; AJvYcCUbOLrstG8kd57qrYLUE58HjI4gI87bqXQSdAMwGohR/B3CGJzXAK0IG3VZ6biTHJ/wYK4XT2TAHBs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2wJu1fELlLOF4SoMrClgEaNZH8pj8QVDDSOdbN27TqMXu+imD
	Ej9sTB0fxvnBjvwGxdXLO2c8hJT1z9GL1dHQwKBBrzxEQlMKUrigPg8NWhryeRW4g9M=
X-Gm-Gg: ASbGncu2SwV+6pjluEyHMPTbtcuh2QwsHR3O7ZSJ+KvE4qH8OkD3YgkOBccicLj05v1
	CWOHGFW/f/b2xCJtJFF7x5o4QvqGvigkQPYR3phpFNWNoGF84ENelaPSjNm6xi7sghcp+w+adFo
	Epl03ZeuEDF35SEwgytMa5+yLPh1D5FvCEZnPo6xwZQkHgB64BDQAf0LeFAgvX8kXuEKzK6vAK5
	1/gzGTQ+um/Lltadqy14M12W8dCpN2qFSm4pJ9yW7MGeu8m/f4gVP8gF6mJC5v33Q9HuOgq6LBM
	43q4BHDBQaHkNXrkwGRDPLk8H1HhlRMrs/Xmv6t0Eb5upa4d9nBhIvIkvyLZPGIYUh64xHUh4m5
	c2dMuCxJZH8s2nIMSfbqBGrCCaQsUSTLqNaw3wsNuaj1TNaTn6/dcdGStyVNXvUH8KsaJtlSOXd
	h0rXoBeeaqosBbzgYUVrmdJfvZe/CvYJlE3qPw9j5O9J50G83e56RczkCCAAIOUSOa
X-Google-Smtp-Source: AGHT+IHll+IKPvcEc2EdGPBw2QQZcQZ6T6jlawQUNb6L1NrYv5cDZU0Tf0FeuJID2gzeZN1UxCbY+g==
X-Received: by 2002:a05:620a:2a0f:b0:84e:2544:6be7 with SMTP id af79cd13be357-8b29b815e49mr640273285a.65.1762975816129;
        Wed, 12 Nov 2025 11:30:16 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b29aa0082esm243922885a.50.2025.11.12.11.30.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 11:30:15 -0800 (PST)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: kernel-team@meta.com,
	linux-cxl@vger.kernel.org,
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
Subject: [RFC PATCH v2 09/11] drivers/dax: add spm_node bit to dev_dax
Date: Wed, 12 Nov 2025 14:29:25 -0500
Message-ID: <20251112192936.2574429-10-gourry@gourry.net>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251112192936.2574429-1-gourry@gourry.net>
References: <20251112192936.2574429-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This bit is used by dax/kmem to determine whether to set the
MHP_SPM_NODE flags, which determines whether the hotplug memory
is SysRAM or Specific Purpose Memory.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 drivers/dax/bus.c         | 39 +++++++++++++++++++++++++++++++++++++++
 drivers/dax/bus.h         |  1 +
 drivers/dax/dax-private.h |  1 +
 drivers/dax/kmem.c        |  2 ++
 4 files changed, 43 insertions(+)

diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
index fde29e0ad68b..b0de43854112 100644
--- a/drivers/dax/bus.c
+++ b/drivers/dax/bus.c
@@ -1361,6 +1361,43 @@ static ssize_t memmap_on_memory_store(struct device *dev,
 }
 static DEVICE_ATTR_RW(memmap_on_memory);
 
+static ssize_t spm_node_show(struct device *dev,
+			     struct device_attribute *attr, char *buf)
+{
+	struct dev_dax *dev_dax = to_dev_dax(dev);
+
+	return sysfs_emit(buf, "%d\n", dev_dax->spm_node);
+}
+
+static ssize_t spm_node_store(struct device *dev,
+			      struct device_attribute *attr,
+			      const char *buf, size_t len)
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
+	if (dev_dax->spm_node != val && dev->driver &&
+	    to_dax_drv(dev->driver)->type == DAXDRV_KMEM_TYPE) {
+		up_write(&dax_dev_rwsem);
+		return -EBUSY;
+	}
+
+	dev_dax->spm_node = val;
+	up_write(&dax_dev_rwsem);
+
+	return len;
+}
+static DEVICE_ATTR_RW(spm_node);
+
 static umode_t dev_dax_visible(struct kobject *kobj, struct attribute *a, int n)
 {
 	struct device *dev = container_of(kobj, struct device, kobj);
@@ -1388,6 +1425,7 @@ static struct attribute *dev_dax_attributes[] = {
 	&dev_attr_resource.attr,
 	&dev_attr_numa_node.attr,
 	&dev_attr_memmap_on_memory.attr,
+	&dev_attr_spm_node.attr,
 	NULL,
 };
 
@@ -1494,6 +1532,7 @@ static struct dev_dax *__devm_create_dev_dax(struct dev_dax_data *data)
 	ida_init(&dev_dax->ida);
 
 	dev_dax->memmap_on_memory = data->memmap_on_memory;
+	dev_dax->spm_node = data->spm_node;
 
 	inode = dax_inode(dax_dev);
 	dev->devt = inode->i_rdev;
diff --git a/drivers/dax/bus.h b/drivers/dax/bus.h
index cbbf64443098..51ed961b6a3c 100644
--- a/drivers/dax/bus.h
+++ b/drivers/dax/bus.h
@@ -24,6 +24,7 @@ struct dev_dax_data {
 	resource_size_t size;
 	int id;
 	bool memmap_on_memory;
+	bool spm_node;
 };
 
 struct dev_dax *devm_create_dev_dax(struct dev_dax_data *data);
diff --git a/drivers/dax/dax-private.h b/drivers/dax/dax-private.h
index 0867115aeef2..3d1b1f996383 100644
--- a/drivers/dax/dax-private.h
+++ b/drivers/dax/dax-private.h
@@ -89,6 +89,7 @@ struct dev_dax {
 	struct device dev;
 	struct dev_pagemap *pgmap;
 	bool memmap_on_memory;
+	bool spm_node;
 	int nr_range;
 	struct dev_dax_range *ranges;
 };
diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
index c036e4d0b610..3c3dd1cd052c 100644
--- a/drivers/dax/kmem.c
+++ b/drivers/dax/kmem.c
@@ -169,6 +169,8 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
 		mhp_flags = MHP_NID_IS_MGID;
 		if (dev_dax->memmap_on_memory)
 			mhp_flags |= MHP_MEMMAP_ON_MEMORY;
+		if (dev_dax->spm_node)
+			mhp_flags |= MHP_SPM_NODE;
 
 		/*
 		 * Ensure that future kexec'd kernels will not treat
-- 
2.51.1

