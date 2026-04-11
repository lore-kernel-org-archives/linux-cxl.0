Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87D92AE78
	for <linux-cxl@vger.kernel.org>; Sat, 11 Apr 2026 01:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775871636; cv=none; b=Ya6TVxbz+LWEXjuuuKiVydEZUeC2FQl7hMaZx04QTBV6RUf+tASkGKvor+//PGDck19u4zxODGwhJJyFFczKq41qqzSjGmFNpXKzKNdDRSvfLwitHC30DKmya6S9OJDTjDUBoSGi885jByNnsMKdz1E5QSf8hAWnBCG0Kkpx9Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775871636; c=relaxed/simple;
	bh=lUv0SjAAaw3E/kgV1KeDK72Wh6iLEtGftRf81Pn66SM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W5lGYGdYh+BELxIQuSj5D/KgyRs66vzeqljeYV7wXQ3ATILK2GHMWlZBGnUPNwEq0dm2kSX3egju0/beu8b1ADm0Nbym/AQYCoZPKVNlOn3PG6hsxwsjy9DtMv2vZIoA4Yi2rTgfTiMlPqRs0f0yAcQkKQRNovwLWFq48x/OSOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YMyJIZag; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YMyJIZag"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-79827d28fc4so27886867b3.1
        for <linux-cxl@vger.kernel.org>; Fri, 10 Apr 2026 18:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775871634; x=1776476434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w6Dz9TYOBwWg06fFUo8qqEZEgSQ6r/8vuvT8PbFJpKY=;
        b=YMyJIZagq1DxKjQjl2z3uX0xrjRvSm91OB0IN3BCimTtCpLVYsyCsw0g26CvSK4/ic
         MJPBK1nj+E7X80pszu33hnERrKqBrOXwMJydsKIMFcqEnkx2Qno58TV9li/0Wvg/iMFA
         K761pXOOl/ImB9lgA/hUqdaywy3BEO7RF2LWBRNCKmQKgHN7gLOMSobw9T+T2ux2JZnd
         UU5hjBUkkOXOXgeaulwv6OxVoK4GIyln+kIxVyNbQgdyM+1BsETaHZ77iFYamAyDaYoX
         3t2OW7SAjBSA6o37UsXjkJaOQjklY4f8b/qwaR+ZBkF/iIY6v4hD4iDn7bS5/BVoI1Iq
         KMDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775871634; x=1776476434;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=w6Dz9TYOBwWg06fFUo8qqEZEgSQ6r/8vuvT8PbFJpKY=;
        b=rhHH3qlobUPo6LwfFDQy5tmGHY+Bs4Q2gaPUItsO0rcD966Cd30pZ8MnM3pjm+nS4c
         dyHcT487XDI3wpTwovyx2ac2SYFRUpuG/3I8Mwypy8LBbrUSpNMNAoox1/VdN5zOrG0M
         6I3DEGd3tnZTzn3poiKhZQl+zQZ9YgoLIiQQOTEMaYbSBH1NGt1yXb4Ymf6j+4FjQQUN
         /wJvU/0YWVV5grlSKu6sk3UmzEsV2a243xIPfBUhsVm0F8FxhnoGqPB5TyRSxPyHK065
         o7F1Ju3aAZGFwwHPO3StIrgjxT4vGCxYwGirP0wHzy8M+0VIG4RwoWzHVQhGdM25ricK
         6a1g==
X-Gm-Message-State: AOJu0YxXOqug50Xu5lAMcZrei6rsHElN8VJ/kJ2aII2sS7PZ+ou2XHIC
	1aAvujoP4TJrmretSxwmp+Du5z1+1rJJ9QGPfHFyBCUYZ4ttnZTjru3eGQ2suw==
X-Gm-Gg: AeBDieuN6p/dSbpBt3uWJDP2CURbBEQFtOcB1Xbg/e+9sEO7q7e4+ubqLtCCXmUGz8W
	lr9e1vkjTcCF+oJOpAdWCvZViE7rkcKMQEvesfEGCZvAmHr9rr9TnP+pKZEQsTZx6VcnJNBvZY1
	AxyEP4Qks61B6/dAgegqn278wJVdQtsTBNf34+X/YOuLmVCVym1x5LIANZKvy1WqQM82nyV1xgO
	M8eKWIY1x5/oWWQaZttrpyXeqDKbh5lYrvv/0i/hDf8ssSoL/kGmgFxTeDi51RW6389Zd2EhvZt
	9QmEriX7KAf5D0hrWn8WXdfbUUbc7JRhVfRlkCdFvn6/wzmivNBI6aG5iASy0IGJNwuo7qmFNkN
	WQ5pO7dx58TtJ1EPGu7c2HGhnYZI//KHlso2zB7zsJaXxpgpcjo0avSPcOpmX38FOKjs1mCqxEI
	hHlLcHVwdV4TP3dkmiOXU4R+yWHD38d/kqu90rWJVN3Q==
X-Received: by 2002:a05:690c:110:b0:79a:57a2:ed75 with SMTP id 00721157ae682-7af71282b4cmr61507407b3.34.1775871633778;
        Fri, 10 Apr 2026 18:40:33 -0700 (PDT)
Received: from 4470NRD-ASU.ssi.samsung.com ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7af3fa06595sm21690547b3.40.2026.04.10.18.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 18:40:33 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
To: linux-cxl@vger.kernel.org
Cc: john@groves.net,
	dave.jiang@intel.com,
	gourry@gourry.net,
	dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com
Subject: [PATCH 05/20] cxl/mem: Expose dynamic ram A partition in sysfs
Date: Fri, 10 Apr 2026 18:23:00 -0700
Message-ID: <20260411013958.47422-6-anisa.su@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260411013958.47422-1-anisa.su@samsung.com>
References: <20260411013958.47422-1-anisa.su@samsung.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ira Weiny <ira.weiny@intel.com>

To properly configure CXL regions user space will need to know the
details of the dynamic ram partition.

Expose the first dynamic ram partition through sysfs.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes:
[anisa: Update kernel version to 7.0]
[davidlohr: Remove "persistent" from description of
/sys/bus/cxl/devices/memX/dynamic_ram_a/qos_class]
---
 Documentation/ABI/testing/sysfs-bus-cxl | 24 +++++++++++
 drivers/cxl/core/memdev.c               | 57 +++++++++++++++++++++++++
 2 files changed, 81 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
index 16a9b3d2e2c0..3d95c325f6e0 100644
--- a/Documentation/ABI/testing/sysfs-bus-cxl
+++ b/Documentation/ABI/testing/sysfs-bus-cxl
@@ -89,6 +89,30 @@ Description:
 		and there are platform specific performance related
 		side-effects that may result. First class-id is displayed.
 
+What:		/sys/bus/cxl/devices/memX/dynamic_ram_a/size
+Date:		May, 2025
+KernelVersion:	v7.0
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(RO) The first Dynamic RAM partition capacity as bytes.
+
+
+What:		/sys/bus/cxl/devices/memX/dynamic_ram_a/qos_class
+Date:		May, 2025
+KernelVersion:	v7.0
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
index 71602820f896..064cfd628577 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -101,6 +101,19 @@ static ssize_t pmem_size_show(struct device *dev, struct device_attribute *attr,
 static struct device_attribute dev_attr_pmem_size =
 	__ATTR(size, 0444, pmem_size_show, NULL);
 
+static ssize_t dynamic_ram_a_size_show(struct device *dev, struct device_attribute *attr,
+			      char *buf)
+{
+	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+	unsigned long long len = cxl_part_size(cxlds, CXL_PARTMODE_DYNAMIC_RAM_A);
+
+	return sysfs_emit(buf, "%#llx\n", len);
+}
+
+static struct device_attribute dev_attr_dynamic_ram_a_size =
+	__ATTR(size, 0444, dynamic_ram_a_size_show, NULL);
+
 static ssize_t serial_show(struct device *dev, struct device_attribute *attr,
 			   char *buf)
 {
@@ -443,6 +456,25 @@ static struct attribute *cxl_memdev_pmem_attributes[] = {
 	NULL,
 };
 
+static ssize_t dynamic_ram_a_qos_class_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+
+	return sysfs_emit(buf, "%d\n",
+			  part_perf(cxlds, CXL_PARTMODE_DYNAMIC_RAM_A)->qos_class);
+}
+
+static struct device_attribute dev_attr_dynamic_ram_a_qos_class =
+	__ATTR(qos_class, 0444, dynamic_ram_a_qos_class_show, NULL);
+
+static struct attribute *cxl_memdev_dynamic_ram_a_attributes[] = {
+	&dev_attr_dynamic_ram_a_size.attr,
+	&dev_attr_dynamic_ram_a_qos_class.attr,
+	NULL,
+};
+
 static ssize_t ram_qos_class_show(struct device *dev,
 				  struct device_attribute *attr, char *buf)
 {
@@ -519,6 +551,29 @@ static struct attribute_group cxl_memdev_pmem_attribute_group = {
 	.is_visible = cxl_pmem_visible,
 };
 
+static umode_t cxl_dynamic_ram_a_visible(struct kobject *kobj, struct attribute *a, int n)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
+	struct cxl_dpa_perf *perf = part_perf(cxlmd->cxlds, CXL_PARTMODE_DYNAMIC_RAM_A);
+
+	if (a == &dev_attr_dynamic_ram_a_qos_class.attr &&
+	    (!perf || perf->qos_class == CXL_QOS_CLASS_INVALID))
+		return 0;
+
+	if (a == &dev_attr_dynamic_ram_a_size.attr &&
+	    (!cxl_part_size(cxlmd->cxlds, CXL_PARTMODE_DYNAMIC_RAM_A)))
+		return 0;
+
+	return a->mode;
+}
+
+static struct attribute_group cxl_memdev_dynamic_ram_a_attribute_group = {
+	.name = "dynamic_ram_a",
+	.attrs = cxl_memdev_dynamic_ram_a_attributes,
+	.is_visible = cxl_dynamic_ram_a_visible,
+};
+
 static umode_t cxl_memdev_security_visible(struct kobject *kobj,
 					   struct attribute *a, int n)
 {
@@ -547,6 +602,7 @@ static const struct attribute_group *cxl_memdev_attribute_groups[] = {
 	&cxl_memdev_attribute_group,
 	&cxl_memdev_ram_attribute_group,
 	&cxl_memdev_pmem_attribute_group,
+	&cxl_memdev_dynamic_ram_a_attribute_group,
 	&cxl_memdev_security_attribute_group,
 	NULL,
 };
@@ -555,6 +611,7 @@ void cxl_memdev_update_perf(struct cxl_memdev *cxlmd)
 {
 	sysfs_update_group(&cxlmd->dev.kobj, &cxl_memdev_ram_attribute_group);
 	sysfs_update_group(&cxlmd->dev.kobj, &cxl_memdev_pmem_attribute_group);
+	sysfs_update_group(&cxlmd->dev.kobj, &cxl_memdev_dynamic_ram_a_attribute_group);
 }
 EXPORT_SYMBOL_NS_GPL(cxl_memdev_update_perf, "CXL");
 
-- 
2.43.0

