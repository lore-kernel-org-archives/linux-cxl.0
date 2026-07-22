Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8244457A5
	for <linux-cxl@vger.kernel.org>; Wed, 22 Jul 2026 18:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784745342; cv=none; b=B1pmLLrb37tIv7HRo4lUXS3O8Hl/8Q8lEGN4FWRMSW4qhzglR6UpkuStPIt4kosk9XDRdVSFpejZXg4u+7rAUWEdq9X/IpDz3bZcjQyzi06oL9snQ92NZTktpYiWm4Teelh7/mH5mloaPiQReRbog0ibd6sQkurrXDFasq+R6oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784745342; c=relaxed/simple;
	bh=nJ35d+eSRwcW0nsb3UMSMmMEzxzLr5EKcff45F9EGHk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SR1fetfnA81gkulJluROD0nJzq0JfVYOjf2BQc3Nzb+u52GbtOhN8rGtF3gWGXoee9F0rmt80a/5/YxuQ3RO3cyxR8HR++/6Hrk3aPf095ItXyeYO93G2z1P51j4CS0mH/3dQ80NOHfGMTriQ5elmSLlRTiclC24/PjqmaQY33Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Sl9+Z9jT; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Sl9+Z9jT"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-9305a2121a1so961529985a.2
        for <linux-cxl@vger.kernel.org>; Wed, 22 Jul 2026 11:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1784745336; x=1785350136; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rb3wioIcpW4xOhPfXJEKXcvsIiP8tbJgl4SCMKfLhpI=;
        b=Sl9+Z9jTE3gnS9DBZMHJ8oL9nCIJiTS6xfiaRNCN1Brjme023rH/b3x54CvoPkhXj4
         7ivZjJuASH8xM5ZzPaPsbQsDzWfuNZONrqDMJxZUuAeKY+UgTdLRpi6ZfznzezN1T6n2
         5BsaiK9eo4QXKYwufyIT6vWmwUomne2hOTDcFljKgyZx6pW+X8RiMH9mLtI0evht5Y5x
         ymcJKZr0WmbeSOl+Rh90kY2D/F1j63+Q1PsS6a2nvH/ITkJZuokqY/lpkM7FzugOj7f1
         25Uc0MuukQf1FglToPOk0pxL3slkaalpCIS+05ixVTHiENFZpCCkb0NwGHW4nXihuBje
         FAPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784745336; x=1785350136;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rb3wioIcpW4xOhPfXJEKXcvsIiP8tbJgl4SCMKfLhpI=;
        b=mfjSwf+SfpepXPNvSSE8Xrhahp+lzbmq2TB07sDApmkQlF/kuJ+oxNNzEqdjzEhbS2
         2VICTPJHwM/A5KJjDzYk/3a9rtUwGHMhrMv5vQWjjxQOyhLd8CU0YeeZVpspZs7wU+o5
         tpi6P/pfk+ZPk/sDGfHdis9SZJ589n633FDXpeH0jChjgHGgCncQupLiptxG+OvosdKJ
         xUU4p9vjXQdRKD3JJ1cKJhqW0HDI+H+6Un2YXJ8/6Yiy4OSmrKN4QsBkWombD+WOHu9R
         eoCHohHpefCZQ1a2pk+YU9T5PaxjeoUsi9+duvaMHZHeOV92Xgv4QgNckefLsdj7FOPN
         im5A==
X-Gm-Message-State: AOJu0YxUsJEkBpHUM234PCE2qGUWPTA4rI8g2G5BF6atXA+x/eByvA71
	OVyaQbFL0nmNiAmAdLNUos1kWS8oCP/dWz5Awm7Pc17SuCRJA6e1sEVoVKjcC5188IPr2sduzuu
	JTQOd
X-Gm-Gg: AR+sD13JcPBXJobqyOUVVjyYqsZP6PrJXrndbMtJ+ArjY1EIMTcp/oOzl4CB6O0QpCf
	zEkAbo1gZGemySKjtqLzz7wSQiuAVSymNtzSvfNqAfwKl5cvjdTGd6ej7KWdRySqm97scSrzRzT
	g+haWDlXabZlL7lK8Nh92xHRat+CQG4NEbK720W5XZDobr2B86gK7fBLCnk8QClq9SRAHsTydIw
	PV3Mx7BIynMgH3FnryEMIKYbPLN7Y0AiZ3jM2zyjRV/cK4ekIRmFf7S/E8H38LBQuTJLgVcnpgy
	nd3d/GBXuvljWxguVVrDIunw+37Fdoc8JjUvJ6lKdmpL4YGd4MsBJIKiuTzvuEvYa7jqYEfDpP6
	fDJ6kfDu8pRAAaRWPBomNmICah8QLn4NBn+pzin7PcjNpXG0pxznllUdZvhaySjfOzgl67qPLZk
	vGrlu8W9MAOJYVjFugt0vTwY9JSo7O2Fgabw0ilhGu3TeWkkt2OE0Fph/7/Ti/dfs=
X-Received: by 2002:a05:620a:4885:b0:92e:d5f6:2e71 with SMTP id af79cd13be357-930b3eea5damr2411579085a.14.1784745335608;
        Wed, 22 Jul 2026 11:35:35 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-907ba8b3e96sm27630216d6.1.2026.07.22.11.35.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 11:35:35 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-cxl@vger.kernel.org
Cc: nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	djbw@kernel.org,
	vishal.l.verma@intel.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com
Subject: [RFC PATCH 8/8] dax/kmem: add dax/adistance to make private node adistance configurable
Date: Wed, 22 Jul 2026 14:35:19 -0400
Message-ID: <20260722183519.935213-9-gourry@gourry.net>
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

For testing, it is useful to allow adjustments to node location in the
tiering hierarchy - but this is presently a function of static config
data (SRAT/HMAT).

Private nodes have a contract of one owning service per node, meaning
the registering service can set the adistance for that node without
interfering with other hotplugged memory (no other service can hotplug).

Extend kmem to have dax0.0/adistance when `private=1`, so that the
targeted node's tier membership can be moved around.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 drivers/dax/kmem.c | 68 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
index c33dac5939edd..9fd50ef44d56b 100644
--- a/drivers/dax/kmem.c
+++ b/drivers/dax/kmem.c
@@ -51,6 +51,7 @@ struct dax_kmem_data {
 	int numa_node;
 	int state;
 	struct mutex lock; /* protects hotplug state transitions and config */
+	int adistance; /* node abstract distance */
 	bool dax_file; /* when set, cdev allows mmap */
 	struct mempolicy *policy; /* device-lifetime bind for dax-file mmap */
 	bool private; /* when set, memory is onlined as N_MEMORY_PRIVATE */
@@ -68,6 +69,27 @@ static struct memory_dev_type *kmem_find_alloc_memory_type(int adist)
 	return mt_find_alloc_memory_type(adist, &kmem_memory_types);
 }
 
+/*
+ * Re-register the node's memory type at given abstract distance, refined
+ * by the platform algorithm.  This lets us move nodes to different memory
+ * tiers for testing and if the node does not have static perf data.
+ *
+ * Caller holds data->lock, and device must be in unplugged state.
+ */
+static int kmem_set_adistance(struct dax_kmem_data *data, int adist)
+{
+	struct memory_dev_type *memtype;
+
+	mt_calc_adistance(data->numa_node, &adist);
+	memtype = kmem_find_alloc_memory_type(adist);
+	if (IS_ERR(memtype))
+		return PTR_ERR(memtype);
+	clear_node_memory_type(data->numa_node, NULL);
+	init_node_memory_type(data->numa_node, memtype);
+	data->adistance = adist;
+	return 0;
+}
+
 static void kmem_put_memory_types(void)
 {
 	guard(mutex)(&kmem_memory_type_lock);
@@ -495,6 +517,45 @@ static ssize_t state_store(struct device *dev, struct device_attribute *attr,
 	return len;
 }
 
+static ssize_t adistance_show(struct device *dev, struct device_attribute *attr,
+			      char *buf)
+{
+	struct dax_kmem_data *data = dev_get_drvdata(dev);
+
+	if (!data)
+		return -ENXIO;
+	return sysfs_emit(buf, "%d\n", data->adistance);
+}
+
+static ssize_t adistance_store(struct device *dev, struct device_attribute *attr,
+			       const char *buf, size_t len)
+{
+	struct dax_kmem_data *data = dev_get_drvdata(dev);
+	int adist;
+	ssize_t rc;
+
+	if (!data)
+		return -ENXIO;
+
+	rc = kstrtoint(buf, 0, &adist);
+	if (rc)
+		return rc;
+	if (adist <= 0)
+		return -EINVAL;
+
+	guard(mutex)(&data->lock);
+
+	/* adistance only reconfigures the device while it holds no memory. */
+	if (data->state != DAX_KMEM_UNPLUGGED)
+		return -EBUSY;
+
+	rc = kmem_set_adistance(data, adist);
+	if (rc)
+		return rc;
+	return len;
+}
+static DEVICE_ATTR_RW(adistance);
+
 static const struct attribute_group dax_kmem_private_group;
 
 static ssize_t private_show(struct device *dev, struct device_attribute *attr,
@@ -529,6 +590,11 @@ static ssize_t private_store(struct device *dev, struct device_attribute *attr,
 	if (enable == data->private)
 		return len;
 
+	/* When toggling private, reset custom adistance to default */
+	rc = kmem_set_adistance(data, MEMTIER_DEFAULT_DAX_ADISTANCE);
+	if (rc)
+		return rc;
+
 	if (enable) {
 		/* Add the per-service opt-in attributes. */
 		rc = sysfs_create_group(&dev->kobj, &dax_kmem_private_group);
@@ -637,6 +703,7 @@ KMEM_PRIVATE_CAP_ATTR(ltpin, NODE_PRIVATE_CAP_LTPIN);
 
 /* Per-service opt-ins. Visibility toggled by 'private' control */
 static struct attribute *dax_kmem_private_attrs[] = {
+	&dev_attr_adistance.attr,
 	&dev_attr_reclaim.attr,
 	&dev_attr_user_numa.attr,
 	&dev_attr_hotunplug.attr,
@@ -719,6 +786,7 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
 	data->mgid = rc;
 	data->numa_node = numa_node;
 	data->state = DAX_KMEM_UNPLUGGED;
+	data->adistance = adist;
 	data->np.owner = data;
 	mutex_init(&data->lock);
 
-- 
2.53.0-Meta

