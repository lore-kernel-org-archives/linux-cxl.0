Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C643DA5AC
	for <linux-cxl@vger.kernel.org>; Thu, 25 Jun 2026 11:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782386894; cv=none; b=AJfTl9fu5PUnfLrJVUP1VB+saYlTC0jo5xc39EnNdwhaYjhOOPiRbOtwmRMpBGzB1+JpLpzmjj1lwKl8v+Eq4hGH/D/BOEcIqq9rJuZN5YO6cJ53UsGEc7wlAVXkLvgX9OY1onD1xQSc52GJuz3eVc80DtQMkTWEuZyZQwEMETs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782386894; c=relaxed/simple;
	bh=DXvkissHn/+KuthdE3sUGuF5LPzedT+vKlIYwzDV4Dk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NozUYnvdef3fnntNnZEz/+1iYRPc6+sCVQlUmTeUM4d7dYwaUQ0GNp857kIveusNAslPZUimm2uBAAwn6OMtxDfiyzzbAcaBJKrZjtwqIo2NiEILuuM70YEfAOunNsdz4WJYT25FCS85x1a4bUf7dMD7q7fJZtJTomybSJk350M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fcq6aXpV; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fcq6aXpV"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-30b6dad2382so3819648eec.0
        for <linux-cxl@vger.kernel.org>; Thu, 25 Jun 2026 04:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782386892; x=1782991692; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BvxC/dokCYNYQ3OhGrfeL1A+tMPegXdAVL8H95aEecc=;
        b=fcq6aXpV8M1S6g2aDGJeEv82GcGB00mVeskUBD9JdArju0tx3klC6N0Vc/PAYBv3xi
         zM3rFIAOkk0jGnlOPMBvFQJUv3tlKmPdsKcUdYMOVsxN9sQDfLyd7AgX5f/yVmCVh9LE
         QMoXswBN1KEoP9lzj8ekdgFuZKYfG+ds8+JRKyoIsa83S50CzUSQ9/0MXo6KxKE5aht0
         f2Rqcct5RT/8ZJXSOnW/FzLIOzJ8H4obxdHzW2DQmDjINMA1f7nnYjKOO+j4YCbx+MUd
         tA2VgLQTeXzvhNJ9spCVDzh5+m5KYF30f9j4l1xXCNSmoyOkMSgRWqeDq7ekKB7+ML0n
         onBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782386892; x=1782991692;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BvxC/dokCYNYQ3OhGrfeL1A+tMPegXdAVL8H95aEecc=;
        b=JucAsCVFPV/EMN7/NVwd728fSJ7ejSdXXZIYU0gAX9MWa9EOvFYCvjMFKnrPuUSj85
         2iOhaRs30GLy3nD09NrxPCSNNfkW9xyC2DsE5983CkpDYDnL6J7znRnkjgjK52CgthO7
         EwxKSr2CAHtLQuvQjArYz5WS09PQtvIt273f5PqsE5K5ky9b1x+gKxJxsL/L9xc5XaMW
         IKZU/iUjmsTsVgQCuW9Ca3fEbdjSq7I914vcpiSGimBOYc+CwrwuGq+wFImTNgaxGUtP
         zfBtiMM2zmulwcz67TSxvkMEot2gMAfJ1CVLb9i8H7+xofT6mePeSNxOrs/kb/GwUPe5
         OatA==
X-Gm-Message-State: AOJu0Yy4qdejw7PmZl1SHscI42JFAwtkCmV3+x6Cc4zz+e9n6G96Q+cK
	x1ri6dq6R334RMB+nS9wpR9hh9GWf2OwRClitbnKrT3yPEfJZm6LJ9FG97Fj3Q==
X-Gm-Gg: AfdE7cmki81z9+kj6tgIVxMeIpNGak0s5xp9asfQvryLtUGe2ptu3Kmt3bwCN04e0xC
	k+EtDVetkYVfGPVIwu697r6IBmEmASIJETSGxgnFKd4rurXnQI+ciy58XjzlEqdyqlxV1BKL4PB
	vN5FBmCTTyjCpSMWiDngy1DE6DastYG3U8t5mPJpfJCy5EvRwqAy34nZWKIOddSio5lt1ZOlejn
	FxOHHzJeOLJOTLSNzR5T15xLKMR7chrH6stFnbhgJpGCSvur8qCIGGx8Hc1dPxluXkrZLLQxtgP
	2TmxzwGBOuhCjzDxJv0btHk8gpLKnhdR3ee8S6TaGAUR1GQmLMW1eD2/GV1sQDTYVIXP8hNRTWT
	vt7+gwtvafvTrAmB1f/XbO8dO4CBKrid+eY1Ktahzn7KEZhZ71JkUt9fb7jzkKSz4dSwv4CiAEo
	lUaNYAQVKqSMoIEL9eur0E765L8fU5N9fUxB4CBZDRKrzvVbYcfvb/Gk6FDZBGhqde164d
X-Received: by 2002:a05:7300:f108:b0:30c:5807:abbb with SMTP id 5a478bee46e88-30c84cb1ab9mr2140180eec.20.1782386892087;
        Thu, 25 Jun 2026 04:28:12 -0700 (PDT)
Received: from AnisaLaptop.localdomain (c-73-170-217-179.hsd1.ca.comcast.net. [73.170.217.179])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c7cab08c2sm8744614eec.29.2026.06.25.04.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 04:28:11 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
To: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: nvdimm@lists.linux.dev,
	Dan Williams <djbw@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>,
	Alison Schofield <alison.schofield@intel.com>,
	John Groves <John@Groves.net>,
	Gregory Price <gourry@gourry.net>,
	Anisa Su <anisa.su@samsung.com>
Subject: [PATCH v11 05/31] cxl/mem: Expose dynamic ram 1 partition in sysfs
Date: Thu, 25 Jun 2026 04:04:42 -0700
Message-ID: <20260625112638.550691-6-anisa.su@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260625112638.550691-1-anisa.su@samsung.com>
References: <20260625112638.550691-1-anisa.su@samsung.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ira Weiny <iweiny@kernel.org>

To properly configure CXL regions user space will need to know the
details of the dynamic ram partition.

Expose the first dynamic ram partition through sysfs.

Signed-off-by: Ira Weiny <iweiny@kernel.org>
Signed-off-by: Anisa Su <anisa.su@samsung.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>

---
Changes:
1. Documentation: bump kernel version to 7.3 and date to June 2026
2. Pick up Dave's reviewed-by tag
3. Rename dynamic_ram_a to dynamic_ram_1
---
 Documentation/ABI/testing/sysfs-bus-cxl | 24 +++++++++++
 drivers/cxl/core/memdev.c               | 57 +++++++++++++++++++++++++
 2 files changed, 81 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
index 16a9b3d2e2c0..435495de409c 100644
--- a/Documentation/ABI/testing/sysfs-bus-cxl
+++ b/Documentation/ABI/testing/sysfs-bus-cxl
@@ -89,6 +89,30 @@ Description:
 		and there are platform specific performance related
 		side-effects that may result. First class-id is displayed.
 
+What:		/sys/bus/cxl/devices/memX/dynamic_ram_1/size
+Date:		June, 2026
+KernelVersion:	v7.3
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(RO) The first Dynamic RAM partition capacity as bytes.
+
+
+What:		/sys/bus/cxl/devices/memX/dynamic_ram_1/qos_class
+Date:		June, 2026
+KernelVersion:	v7.3
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(RO) For CXL host platforms that support "QoS Telemmetry"
+		this attribute conveys a comma delimited list of platform
+		specific cookies that identifies a QoS performance class
+		for the partition of the CXL mem device. These
+		class-ids can be compared against a similar "qos_class"
+		published for a root decoder. While it is not required
+		that the endpoints map their local memory-class to a
+		matching platform class, mismatches are not recommended
+		and there are platform specific performance related
+		side-effects that may result. First class-id is displayed.
+
 
 What:		/sys/bus/cxl/devices/memX/serial
 Date:		January, 2022
diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 71602820f896..20417db933aa 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -101,6 +101,19 @@ static ssize_t pmem_size_show(struct device *dev, struct device_attribute *attr,
 static struct device_attribute dev_attr_pmem_size =
 	__ATTR(size, 0444, pmem_size_show, NULL);
 
+static ssize_t dynamic_ram_1_size_show(struct device *dev, struct device_attribute *attr,
+			      char *buf)
+{
+	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+	unsigned long long len = cxl_part_size(cxlds, CXL_PARTMODE_DYNAMIC_RAM_1);
+
+	return sysfs_emit(buf, "%#llx\n", len);
+}
+
+static struct device_attribute dev_attr_dynamic_ram_1_size =
+	__ATTR(size, 0444, dynamic_ram_1_size_show, NULL);
+
 static ssize_t serial_show(struct device *dev, struct device_attribute *attr,
 			   char *buf)
 {
@@ -443,6 +456,25 @@ static struct attribute *cxl_memdev_pmem_attributes[] = {
 	NULL,
 };
 
+static ssize_t dynamic_ram_1_qos_class_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+
+	return sysfs_emit(buf, "%d\n",
+			  part_perf(cxlds, CXL_PARTMODE_DYNAMIC_RAM_1)->qos_class);
+}
+
+static struct device_attribute dev_attr_dynamic_ram_1_qos_class =
+	__ATTR(qos_class, 0444, dynamic_ram_1_qos_class_show, NULL);
+
+static struct attribute *cxl_memdev_dynamic_ram_1_attributes[] = {
+	&dev_attr_dynamic_ram_1_size.attr,
+	&dev_attr_dynamic_ram_1_qos_class.attr,
+	NULL,
+};
+
 static ssize_t ram_qos_class_show(struct device *dev,
 				  struct device_attribute *attr, char *buf)
 {
@@ -519,6 +551,29 @@ static struct attribute_group cxl_memdev_pmem_attribute_group = {
 	.is_visible = cxl_pmem_visible,
 };
 
+static umode_t cxl_dynamic_ram_1_visible(struct kobject *kobj, struct attribute *a, int n)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
+	struct cxl_dpa_perf *perf = part_perf(cxlmd->cxlds, CXL_PARTMODE_DYNAMIC_RAM_1);
+
+	if (a == &dev_attr_dynamic_ram_1_qos_class.attr &&
+	    (!perf || perf->qos_class == CXL_QOS_CLASS_INVALID))
+		return 0;
+
+	if (a == &dev_attr_dynamic_ram_1_size.attr &&
+	    (!cxl_part_size(cxlmd->cxlds, CXL_PARTMODE_DYNAMIC_RAM_1)))
+		return 0;
+
+	return a->mode;
+}
+
+static struct attribute_group cxl_memdev_dynamic_ram_1_attribute_group = {
+	.name = "dynamic_ram_1",
+	.attrs = cxl_memdev_dynamic_ram_1_attributes,
+	.is_visible = cxl_dynamic_ram_1_visible,
+};
+
 static umode_t cxl_memdev_security_visible(struct kobject *kobj,
 					   struct attribute *a, int n)
 {
@@ -547,6 +602,7 @@ static const struct attribute_group *cxl_memdev_attribute_groups[] = {
 	&cxl_memdev_attribute_group,
 	&cxl_memdev_ram_attribute_group,
 	&cxl_memdev_pmem_attribute_group,
+	&cxl_memdev_dynamic_ram_1_attribute_group,
 	&cxl_memdev_security_attribute_group,
 	NULL,
 };
@@ -555,6 +611,7 @@ void cxl_memdev_update_perf(struct cxl_memdev *cxlmd)
 {
 	sysfs_update_group(&cxlmd->dev.kobj, &cxl_memdev_ram_attribute_group);
 	sysfs_update_group(&cxlmd->dev.kobj, &cxl_memdev_pmem_attribute_group);
+	sysfs_update_group(&cxlmd->dev.kobj, &cxl_memdev_dynamic_ram_1_attribute_group);
 }
 EXPORT_SYMBOL_NS_GPL(cxl_memdev_update_perf, "CXL");
 
-- 
2.43.0

