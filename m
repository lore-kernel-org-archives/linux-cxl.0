Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6497332EC8
	for <linux-cxl@vger.kernel.org>; Thu, 12 Mar 2026 09:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773306739; cv=none; b=GLRwtNzN1N5C5+OtBwlg0LRo5TWuWY0ZFv2BmYrasddiXDY8euz+DOxuhl7tYfheVN0mg17wM3iij8elZfyXqAISONlmpMvhleGzTw5XEgBEA9blumZbOQc0XXIPAYm7fgGrPiVoHdqWfvAyLwcnpk/fkSvjA8tiuxziL6xKnP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773306739; c=relaxed/simple;
	bh=4B8fUe4Y6rdWT0cATHjZd7WuX2LL1Yv8MRXAsdqpRcw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jU8zCnMyFzhcQri3qV6eHUzZgzU756iYJEK23h+0F1IXfsVKAMU9VIuoeYMic5w9BLWoQBELEYLEf6hPBWEbRz6o3WO2aTlgjelzxCUxJVU63sMLOJO8sOOXM7YgYgq3SYagjS1ZUEqxvbhweNR3mxycylBa2Ezn3mTSWgUT0/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S1ki8sM1; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S1ki8sM1"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8297310ce0aso454589b3a.2
        for <linux-cxl@vger.kernel.org>; Thu, 12 Mar 2026 02:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773306737; x=1773911537; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sZaIDNiBTsN9aL3bUzrKNeXVeD+/QF1qmzkDXQhoczs=;
        b=S1ki8sM1SQDE7TZhztQ7yabOs1/hF2MASEB0rOr3ZtTSKZvXGijLhrCIUkOp88Czdr
         ZDg4KyzYhsud4oWIvHDmC+GNjw+U4YqINa4T1BzxJIt3Zoz7MVcb8+NQqx7mY3glM3EV
         rrnGrF7k6dxQ/YKrWp+amvRplwB0p230aanLFXctO+JkmTswJKyOCrqLQIr+qZ35iirR
         sizK8ZfGzfxI/VDhK+GSVg6CFAz13Ka/kBmcCpnJ/Spjr8dMbnLeSZK4yESgyfs9HDk1
         3meSDpvF+srRf+HnKPqU6XmWjfrFtQ8BI31WO9uM3Ysp4SdM3PJSdjgZyqIU6fqu2/cb
         kjzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773306737; x=1773911537;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sZaIDNiBTsN9aL3bUzrKNeXVeD+/QF1qmzkDXQhoczs=;
        b=bOIYYIP7eHqUwSy6DYAbYlJ5B48V/C1sSCf6RKeK/PYxvQI/D94Dq4O1eTZiKAZS11
         eNaYE5/qLvq6s5He/C0YcO2L4OvAdMNyVzdN/DLyDeLV7ANYiaDpeo2VgyRAruAVgfV/
         /QQvUfWHkl5a4noEK5zKXmU0C4lCXWQtshuP1Vu2cgOkAcr31bgwUnWq863286mI8IRX
         tGMRjwJmWHfhSTirjQz7TLJ4mGIssmNXdryemljYzM+C+LTm8dANya3zII0gpMpX/F3j
         9vaz6duWuM+JkADX/KcztJjkWYGSwUCm3sktj9Y8UJ40Jrh9M0sqvUw/B5XjD703PGF9
         TU/g==
X-Forwarded-Encrypted: i=1; AJvYcCVE+W/fozpR743KeQlsaNrBdUX1Pyme0IIp2Jh6tJnziPwnUkYH4qrl3gKFxDreS4qo4BCWRUvQv38=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRAFfpdl5ZrG37PFTQFuDtp5Yc/nhclpaCbmteab2LRxNatsTO
	gp64UQ65DEegqG+vhNl4x9db7WT7pZpe1dMyU1c+UCb1mBrJp7HOPbKT
X-Gm-Gg: ATEYQzweH5gIasIE4KP/uCuSWIJmJ0mMJJ7/f0Neruw6RhRZMf0Kfy7FreOA2ABPM67
	mTg124PZqZr3agORx97EyJAYweVH92qrkTk8m5W7WYrGJae6FrSpzxwmLZnUNoXeBhKQPdluT6H
	HslEeHtmAizUp0j90Kr2wmGIIpyF/MTytKpmnsPkc0lTGbAaT1GObt1crQYlFFn69FERRXtPKub
	nLXoh7S0ceTEQwOU+p9sBe1WOhuUvuS1AO7fZF4XUuhsOsJh7eDFRG3r8FIAybTtw/gAuP0vnwt
	n+PV+HOYoYWBROfjncAlLeNUUN/00xaV5zyCk9Fpdpuw3wpPhVEUThWE1/JXQ2hl7omzBd6mVrc
	zKvp42YBmiYDY2s3JY2HM0PC6MSTPI47bL61oJ5uZyFGtSMGF8yJNprZ7UoJ+COfjjgwr+KlQsf
	pwGBTlX6OIxoGpOJpKGhlP7tgKLW1hYT1kzOJEkETSAQHSpKkem59WYz4hf3cV830S3QDc
X-Received: by 2002:a05:6a00:ab08:b0:827:32d7:668f with SMTP id d2e1a72fcca58-829f6e7897amr5024122b3a.6.1773306737021;
        Thu, 12 Mar 2026 02:12:17 -0700 (PDT)
Received: from Yee-680G4.lan (n11212047001.netvigator.com. [112.120.47.1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a0734199csm2299470b3a.36.2026.03.12.02.12.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 02:12:16 -0700 (PDT)
From: YeeLi <seven.yi.lee@gmail.com>
To: akpm@linux-foundation.org,
	david@kernel.org,
	dan.j.williams@intel.com,
	ying.huang@linux.alibaba.com,
	linux-mm@kvack.org,
	joshua.hahnjy@gmail.com
Cc: linux-kernel@vger.kernel.org,
	Jonathan.Cameron@huawei.com,
	linux-cxl@vger.kernel.org,
	dave.jiang@intel.com,
	yeeli <seven.yi.lee@gmail.com>
Subject: [PATCH] mm/mempolicy: add sysfs interface to override NUMA node bandwidth
Date: Thu, 12 Mar 2026 17:12:07 +0800
Message-Id: <20260312091207.2016518-1-seven.yi.lee@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: yeeli <seven.yi.lee@gmail.com>

Automatic tuning for weighted interleaving [1] provides real benefits on
systems with CXL support. However, platforms that lack HMAT or CDAT
information cannot make use of this feature.

If the bandwidth reported by firmware or the device deviates from the
actual measured bandwidth, administrators also lack a clear way to adjust
the per-node weight values.

This patch introduces an optional Kconfig option,
CONFIG_NUMA_BW_MANUAL_OVERRIDE (default n), which exposes node bandwidth
R/W sysfs attributes under:

  /sys/kernel/mm/mempolicy/weighted_interleave/bw_nodeN

The sysfs files are created and removed dynamically on node hotplug
events, in sync with the existing weighted_interleave/nodeN attributes.

Userspace can write a single bandwidth value (in MB/s) to override both
read_bandwidth and write_bandwidth for the corresponding NUMA node. The
value is then propagated to the internal node_bw_table via
mempolicy_set_node_perf().

This interface is intended for debugging and experimentation only.

[1] Link:
https://lkml.kernel.org/r/20250505182328.4148265-1-joshua.hahnjy@gmail.com

Signed-off-by: yeeli <seven.yi.lee@gmail.com>
---
 mm/Kconfig     |  20 +++++++
 mm/mempolicy.c | 148 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 168 insertions(+)

diff --git a/mm/Kconfig b/mm/Kconfig
index bd0ea5454af8..40554df18edc 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1441,6 +1441,26 @@ config NUMA_EMU
 	  into virtual nodes when booted with "numa=fake=N", where N is the
 	  number of nodes. This is only useful for debugging.
 
+config NUMA_BW_MANUAL_OVERRIDE
+	bool "Allow manual override of per-NUMA-node bandwidth for weighted interleave"
+	depends on NUMA && SYSFS
+	default n
+	help
+	  This option exposes writable sysfs attributes under
+	  /sys/kernel/mm/mempolicy/weighted_interleave/bw_nodeN, allowing
+	  userspace to manually set read/write bandwidth values for each NUMA node.
+
+	  These values update the internal node_bw_table and can influence
+	  weighted interleave auto-tuning (if enabled).
+
+	  WARNING: This is intended for debugging, development, or platforms
+	  with incorrect HMAT/CDAT firmware data. Overriding hardware-reported
+	  bandwidth can lead to suboptimal performance, instability, or
+	  incorrect resource allocation decisions.
+
+	  Say N unless you are actively developing or debugging bandwidth-aware
+	  memory policies.
+
 config ARCH_HAS_USER_SHADOW_STACK
 	bool
 	help
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 68a98ba57882..0b7f42491748 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -226,6 +226,7 @@ int mempolicy_set_node_perf(unsigned int node, struct access_coordinate *coords)
 
 	bw_val = min(coords->read_bandwidth, coords->write_bandwidth);
 	new_bw = kcalloc(nr_node_ids, sizeof(unsigned int), GFP_KERNEL);
+
 	if (!new_bw)
 		return -ENOMEM;
 
@@ -3614,6 +3615,9 @@ struct iw_node_attr {
 struct sysfs_wi_group {
 	struct kobject wi_kobj;
 	struct mutex kobj_lock;
+#ifdef CONFIG_NUMA_BW_MANUAL_OVERRIDE
+	struct iw_node_attr *bw_attrs[MAX_NUMNODES];
+#endif
 	struct iw_node_attr *nattrs[];
 };
 
@@ -3855,6 +3859,128 @@ static int sysfs_wi_node_add(int nid)
 	return ret;
 }
 
+#ifdef CONFIG_NUMA_BW_MANUAL_OVERRIDE
+static ssize_t bw_node_show(struct kobject *kobj,
+			    struct kobj_attribute *attr,
+			    char *buf)
+{
+	struct iw_node_attr *node_attr;
+
+	node_attr = container_of(attr, struct iw_node_attr, kobj_attr);
+
+	/*A Node without CDAT or HMAT*/
+	if (!node_bw_table)
+		return sprintf(buf, "N/A\n");
+
+	if (!node_bw_table[node_attr->nid])
+		return sprintf(buf, "0\n");
+
+	return sprintf(buf, "%u(MB/s)\n", node_bw_table[node_attr->nid]);
+}
+
+static ssize_t bw_node_store(struct kobject *kobj,
+			     struct kobj_attribute *attr,
+			     const char *buf, size_t count)
+{
+	struct iw_node_attr *node_attr;
+	unsigned long val = 0;
+	int ret;
+	struct access_coordinate coords = {
+		.read_bandwidth = 0,
+		.write_bandwidth = 0,
+	};
+
+	node_attr = container_of(attr, struct iw_node_attr, kobj_attr);
+
+	ret = kstrtoul(buf, 0, &val);
+
+	coords.read_bandwidth = val;
+	coords.write_bandwidth = val;
+
+	if (ret)
+		return ret;
+
+	if (val > UINT_MAX)
+		return -EINVAL;
+
+	ret = mempolicy_set_node_perf(node_attr->nid, &coords);
+	if (ret)
+		return ret;
+
+	return count;
+}
+
+static int sysfs_bw_node_add(int nid)
+{
+	int ret;
+	char *name;
+	struct iw_node_attr *new_attr;
+
+	if (nid < 0 || nid >= nr_node_ids) {
+		pr_err("invalid node id: %d\n", nid);
+		return -EINVAL;
+	}
+
+	new_attr = kzalloc(sizeof(*new_attr), GFP_KERNEL);
+	if (!new_attr)
+		return -ENOMEM;
+
+	name = kasprintf(GFP_KERNEL, "bw_node%d", nid);
+	if (!name) {
+		kfree(new_attr);
+		return -ENOMEM;
+	}
+
+	sysfs_attr_init(&new_attr->kobj_attr.attr);
+	new_attr->kobj_attr.attr.name = name;
+	new_attr->kobj_attr.attr.mode = 0644;
+	new_attr->kobj_attr.show = bw_node_show;
+	new_attr->kobj_attr.store = bw_node_store;
+	new_attr->nid = nid;
+
+	mutex_lock(&wi_group->kobj_lock);
+	if (wi_group->bw_attrs[nid]) {
+		mutex_unlock(&wi_group->kobj_lock);
+		ret = -EEXIST;
+		goto out;
+	}
+
+	ret = sysfs_create_file(&wi_group->wi_kobj, &new_attr->kobj_attr.attr);
+
+	if (ret) {
+		mutex_unlock(&wi_group->kobj_lock);
+		goto out;
+	}
+	wi_group->bw_attrs[nid] = new_attr;
+	mutex_unlock(&wi_group->kobj_lock);
+	return 0;
+
+out:
+	kfree(new_attr->kobj_attr.attr.name);
+	kfree(new_attr);
+	return ret;
+}
+
+static void sysfs_bw_node_delete(int nid)
+{
+	struct iw_node_attr *attr;
+
+	if (nid < 0 || nid >= nr_node_ids)
+		return;
+
+	mutex_lock(&wi_group->kobj_lock);
+	attr = wi_group->bw_attrs[nid];
+
+	if (attr) {
+		sysfs_remove_file(&wi_group->wi_kobj, &attr->kobj_attr.attr);
+		kfree(attr->kobj_attr.attr.name);
+		kfree(attr);
+		wi_group->nattrs[nid] = NULL;
+	}
+	mutex_unlock(&wi_group->kobj_lock);
+}
+#endif
+
 static int wi_node_notifier(struct notifier_block *nb,
 			       unsigned long action, void *data)
 {
@@ -3868,9 +3994,22 @@ static int wi_node_notifier(struct notifier_block *nb,
 		if (err)
 			pr_err("failed to add sysfs for node%d during hotplug: %d\n",
 			       nid, err);
+
+#ifdef CONFIG_NUMA_BW_MANUAL_OVERRIDE
+		err = sysfs_bw_node_add(nid);
+		if (err)
+			pr_err("failed to add sysfs bw_node%d: %d\n",
+			       nid, err);
+#endif
 		break;
+
 	case NODE_REMOVED_LAST_MEMORY:
 		sysfs_wi_node_delete(nid);
+
+#ifdef CONFIG_NUMA_BW_MANUAL_OVERRIDE
+		sysfs_bw_node_delete(nid);
+#endif
+
 		break;
 	}
 
@@ -3906,6 +4045,15 @@ static int __init add_weighted_interleave_group(struct kobject *mempolicy_kobj)
 			       nid, err);
 			goto err_cleanup_kobj;
 		}
+
+#ifdef CONFIG_NUMA_BW_MANUAL_OVERRIDE
+		err = sysfs_bw_node_add(nid);
+		if (err) {
+			pr_err("failed to add sysfs bw_node%d during init: %d\n", nid, err);
+			goto err_cleanup_kobj;
+		}
+#endif
+
 	}
 
 	hotplug_node_notifier(wi_node_notifier, DEFAULT_CALLBACK_PRI);
-- 
2.34.1

