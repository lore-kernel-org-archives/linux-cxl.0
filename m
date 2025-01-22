Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198721CD1EA
	for <linux-cxl@vger.kernel.org>; Wed, 22 Jan 2025 23:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737589931; cv=none; b=q2v3vVfJ7G9nMW0MS7PV+zwVmNV1DrP9+toy2Inkulf6Yjweke6/Rzde+LaE5jCunDnwbBX/P/1s5XfD8cRYFQRM1LXyHv0MeYfQS5neabFRthd1SwDMq7mkYJmsVtxUsE5JrI86JUM0yZWnWqKxqHc4Oi13OdcA+zu/fhc2B6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737589931; c=relaxed/simple;
	bh=ISTzco0bW0ZSJFe7b+RI2slRx3Zq5pCCaADI3rS07gs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XRtqAlZPT4v3T3ygyFf+DiQhNYzxkIUiXOWhkyM4tNIeUaBVkVoJfdzmGpJ5epC8rGOdvjzSJhklSXAG8K6ZDTpR7rTKXaHvCyKq+s25QVfJG7RYU1avSXqJ7eJEbYExjpFRuSgn4H2qJlHbFKdHvrYdsfS6FOO5WpjGmxwP8wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F335C4CED2;
	Wed, 22 Jan 2025 23:52:09 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dan.j.williams@intel.com,
	ira.weiny@intel.com,
	vishal.l.verma@intel.com,
	alison.schofield@intel.com,
	Jonathan.Cameron@huawei.com,
	dave@stgolabs.net,
	jgg@nvidia.com,
	shiju.jose@huawei.com
Subject: [PATCH v1 05/19] cxl: Add features driver attribute to emit number of features supported
Date: Wed, 22 Jan 2025 16:50:36 -0700
Message-ID: <20250122235159.2716036-6-dave.jiang@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250122235159.2716036-1-dave.jiang@intel.com>
References: <20250122235159.2716036-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable sysfs attribute emission of the number of features supported by the
driver/device. This is useful for userspace to determine the number of features
to query for.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/features.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/cxl/features.c b/drivers/cxl/features.c
index a5949312a4ab..0d1fc3da9e35 100644
--- a/drivers/cxl/features.c
+++ b/drivers/cxl/features.c
@@ -173,11 +173,38 @@ static void cxl_features_remove(struct device *dev)
 	kfree(cfs);
 }
 
+static ssize_t features_show(struct device *dev, struct device_attribute *attr,
+			     char *buf)
+{
+	struct cxl_features_state *cfs = dev_get_drvdata(dev);
+
+	if (!cfs)
+		return -ENOENT;
+
+	return sysfs_emit(buf, "%d\n", cfs->num_features);
+}
+
+static DEVICE_ATTR_RO(features);
+
+static struct attribute *cxl_features_attrs[] = {
+	&dev_attr_features.attr,
+	NULL
+};
+
+static struct attribute_group cxl_features_group = {
+	.attrs = cxl_features_attrs,
+};
+
+__ATTRIBUTE_GROUPS(cxl_features);
+
 static struct cxl_driver cxl_features_driver = {
 	.name = "cxl_features",
 	.probe = cxl_features_probe,
 	.remove = cxl_features_remove,
 	.id = CXL_DEVICE_FEATURES,
+	.drv = {
+		.dev_groups = cxl_features_groups,
+	},
 };
 
 module_cxl_driver(cxl_features_driver);
-- 
2.47.1

