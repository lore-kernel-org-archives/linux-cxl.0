Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793833356;
	b=RPrPq99QIFSeOzI9tKiANpRd6HCfR6Y+ox9HfsR3UBHFc3M1NrYPSsvaFFuAfbpItFAu
	 WPbb36/nRCj6GXPguZo5pFSBEfG11YBUj4PZ/vRWQiOHxI1PmgIYbeavaImVlSeEzDHpw
	 rSEZm0ax6QiDBM2HEUx5/S2VDjY+PON8kTuzv2GDWCrqaUcc380dNeN56rwmpUqN/NUgP
	 WPwGG4aqcM4icao/daYJnaPS7g/p+EJOrreDW1+jPF5Kh2HmW+aRoWsE4m/8Vl2xlZdp4
	 /aBAImwi3KOMrEckLySSNHETBPodNjam0CTGbKAXLZEtu0YROwqSRTTxUCl+y0puGaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793833356;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:
	 X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=UJ8u1Aac89i93fKW/IhHRaklRCdGyzhiA6QnCteajf8=;
	b=VwElT6HLl52bEpZmd/Qda+SqwW7/PrHKHYEqLxokJ0yoIuTcGuk9/zsopMcNorecs3Su
	 FRvqwBbypdEzkGs4PpS5CaEJqRu/Mvf4SQVvIAUEZD2BWGZXO/u3yuouV56ualOtCaAJT
	 dOQbKkJ8WcgMFcZ/fGtWUOMg/utfgiCSzp/CGXESACQHQgxFZom92dV2JucQYVB/3JPYP
	 Vt4iUi1ZGbldt+tr00gKfoVIpgyUSM7EEmION70/W6WbzFLQQz9Q4sltB7NFs9XgQKaAf
	 uKOnbI3MlQWHYpei4lrUrKYN7camKyxIQSzBVcCjtUTKvry9tXoLiKkmxRaKgvWCzaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XTNy6qt9;
	arc=none smtp.remote-ip=209.85.214.174
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B41A606A31B
	for <linux-cxl@vger.kernel.org>; Wed,  4 Nov 2026 23:02:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B41A606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XTNy6qt9
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2e96502e447so10550585ad.1
        for <linux-cxl@vger.kernel.org>; Wed, 04 Nov 2026 15:02:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793833356; x=1794438156; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UJ8u1Aac89i93fKW/IhHRaklRCdGyzhiA6QnCteajf8=;
        b=XTNy6qt9isfuc+dFgmXrKjbZMFdOjaeLIViKYvaRdr/kMlsCpMxVFvzIrx+XBGAi+A
         if9j2dvKX6N8UiW/PHIvQSsYuHfTY1+AalxO2SGQ4cYOTtp4irdu3+kwmRVzCjqxvWE1
         E1OI4Wp/woJJ2utGni220uiq8wuj4dUh6b3MykRSMsaKgNz214RtmNo6nv9hgpWV/Tf9
         lvE3nWHDEOyYTKpT907njIgroV23F/XwdpFJ3NpkKkVIZiZevDHE4rkI5zlQ66tXucFZ
         bJpCou9ghHCoixfo2TdyS4gQ06R8igNEF8ytnyqe7CDA+qRDx+nCdwuqxaeKOqueHKJX
         AfFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793833356; x=1794438156;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UJ8u1Aac89i93fKW/IhHRaklRCdGyzhiA6QnCteajf8=;
        b=xKidaL2Ql2122l90JSV6V3UKMZ1qHXGoDA5zuzkIM7wSecSin6vIrsMuOMUJI3TQiA
         fPcDnP/d9MZsD6PGSCvg8ATCf4q9uuBiebeDWL57jwM4taUc7WIUq8LAo12rAb6Oj6mG
         In7K9A4hzeA5WFlkfE0hbO4S/YUwc+ueAvy6GKJrigBRFxidwDtoiJV8PfW6iG1YQjME
         Df43VmEKspUud1oJZDv3l9eyEaXrIqlBeNRWZFzjJOo3bOziIDNoGaSt9KRFuahI1qWv
         amXUhwPY++YmQHxyunsQwrLoar9AorqIbinhLu5HXj2ll6up3WzeKuUlp+ISXhBn2NpI
         rW4Q==
X-Gm-Message-State: APuU4Z+yC/vVL86zbuSffRImeWIlEsppReu3cZrVMUgzure4ZPgN1Mdp
	VNdDbJjm5UzFXUptfg0+PzQm3ayftiEXVPbh6jU0VXSCRw6jPaI175x5/rExThSV
X-Gm-Gg: AYBFou3gvCQVgbemg7/ypi44CuZVPA7BPRvdnLS0uhToEw6oJ3Up1gTzLuQFjxLYwMZ
	Z1kLPhoNdUTkzcx/pNl3q7FFMGY5CRBUdatKwu2ja19FBMztme96cLrKTG5wmM1i+mCs1hWubQ5
	MQhIePO/9n9hVkimy+LCUVkVjimvjUJa9rkj8BfKasalgoXTVUq4IIgxV8kRwWivj/RJZ8fceSx
	fhcYOg6+wYPpZrP3yOFn+BhgFzamwTRVNuIi6FeITAHFmpAML/Hfe/QpWLdnYNsbJUqZl3tV/ZY
	HVwvo57c2VwPCVS4gOf56DmhxsUgfGcmorukdzghCMuWxgHklKdjzGKFp2UtBkz73+kYGGsMPli
	DEZGhvQAmx5xBNb5TvBpWh6S0jRY/ZadLdQqUBjPWut339L8JtsviUPLftnZXbYcW1wMWGJHtUh
	9lf3xumOBeVGqhGwXi1ghQcnhsY5FmwId/+xL+jpx+LRh59K/s/uRBjCrxNouM/seTP0pQWVR+7
	1U99SJill05JVWhqd3VWRl5b6GD117UT7sk0tLsdAb+DvXjJgg+HoVRZF4GEeFSDuZnHA8HXaBh
	wUh3NtgNUh5Dxk8jGIjoQjmeFssbow==
X-Received: by 2002:a17:902:ce8b:b0:2df:aed3:2ac0 with SMTP id d9443c01a7336-2eb3649c031mr164760135ad.10.1793833355653;
        Wed, 04 Nov 2026 15:02:35 -0800 (PST)
Received: from cxlqual.. ([220.120.90.131])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ed0908587dsm10999175ad.36.2026.11.04.15.02.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 15:02:35 -0800 (PST)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
To: linux-cxl@vger.kernel.org
Cc: nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Ira Weiny <iweiny@kernel.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Fan Ni <nifan.cxl@gmail.com>,
	Li Ming <ming.li@zohomail.com>,
	Benjamin Cheatham <benjamin.cheatham@amd.com>,
	Gregory Price <gourry@gourry.net>,
	Richard Cheng <icheng@nvidia.com>,
	Anisa Su <anisa.su@samsung.com>
Subject: [PATCH v1 02/14] cxl/port: Add dynamic capacity options to endpoint decoder mode
Date: Thu,  5 Nov 2026 08:02:26 +0900
Message-ID: <20261104230445.66625-3-anisa.su@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261104230445.66625-1-anisa.su@samsung.com>
References: <20261104230445.66625-1-anisa.su@samsung.com>
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Endpoints can now carry a dynamic ram partition following the
persistent memory partition. A DC partition is further described by
two properties reported in its CDAT DSMAS entry: shareable and
read-only.

Expand the decoder mode to accept 'dynamic_ram', 'dynamic_ram_shared',
'dynamic_ram_ro' and 'dynamic_ram_shared_ro'. cxl_dpa_set_part()
selects the first dynamic ram partition whose properties match exactly.

DCD may be disabled during validation after the DC partition(s) were
added to the DPA layout, so a decoder may only be assigned to a DC
partition while DCD is enabled for its memdev. Add a helper,
cxled_dcd_enabled(), to check cxl_dcd_supported().

Signed-off-by: Anisa Su <anisa.su@samsung.com>
Tested-by: Wonjae Lee <wj28.lee@samsung.com>
Tested-by: Junhee Park <jh9934.park@samsung.com>
Tested-by: Heesoo Kim <habil.kim@samsung.com>
---
 Documentation/ABI/testing/sysfs-bus-cxl | 25 +++++++----
 drivers/cxl/core/core.h                 | 23 ++++++++++-
 drivers/cxl/core/hdm.c                  | 21 ++++++++--
 drivers/cxl/core/port.c                 | 55 ++++++++++++++++++++++---
 4 files changed, 105 insertions(+), 19 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
index 7352dbd70bc7..bcbc44fea6db 100644
--- a/Documentation/ABI/testing/sysfs-bus-cxl
+++ b/Documentation/ABI/testing/sysfs-bus-cxl
@@ -339,22 +339,29 @@ Description:
 
 
 What:		/sys/bus/cxl/devices/decoderX.Y/mode
-Date:		May, 2022
-KernelVersion:	v6.0
+Date:		May, 2022, November, 2026
+KernelVersion:	v6.0, v7.5 (dynamic_ram)
 Contact:	linux-cxl@vger.kernel.org
 Description:
 		(RW) When a CXL decoder is of devtype "cxl_decoder_endpoint" it
 		translates from a host physical address range, to a device
 		local address range. Device-local address ranges are further
-		split into a 'ram' (volatile memory) range and 'pmem'
-		(persistent memory) range. The 'mode' attribute emits one of
-		'ram', 'pmem', or 'none'. The 'none' indicates the decoder is
-		not actively decoding, or no DPA allocation policy has been
-		set.
+		split into a 'ram' (volatile memory) range, 'pmem' (persistent
+		memory) range, and dynamic capacity ranges. The 'mode'
+		attribute emits one of 'ram', 'pmem', 'none', or a dynamic
+		capacity selector: 'dynamic_ram', 'dynamic_ram_shared',
+		'dynamic_ram_ro' or 'dynamic_ram_shared_ro', composed from the
+		shareable and read-only properties of the partition the decoder
+		points at. The 'none' indicates the decoder is not actively
+		decoding, or no DPA allocation policy has been set.
 
 		'mode' can be written, when the decoder is in the 'disabled'
-		state, with either 'ram' or 'pmem' to set the boundaries for the
-		next allocation.
+		state, with 'ram', 'pmem', or one of the dynamic capacity
+		selectors to set the boundaries for the next allocation. A
+		selector picks the first dynamic capacity partition whose
+		shareable and read-only properties match it exactly, and is
+		accepted only while the driver has dynamic capacity enabled
+		for the device.
 
 
 What:		/sys/bus/cxl/devices/decoderX.Y/dpa_resource
diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 8a81be004d00..24fbb5718abc 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -6,6 +6,7 @@
 
 #include <cxl/mailbox.h>
 #include <linux/rwsem.h>
+#include <cxlmem.h>
 
 extern const struct device_type cxl_nvdimm_bridge_type;
 extern const struct device_type cxl_nvdimm_type;
@@ -18,6 +19,25 @@ enum cxl_detach_mode {
 	DETACH_INVALIDATE,
 };
 
+static inline struct cxl_memdev_state *
+cxled_to_mds(struct cxl_endpoint_decoder *cxled)
+{
+	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
+
+	return to_cxl_memdev_state(cxlmd->cxlds);
+}
+
+/* Type-2 devices have no memdev state; nothing else leaves @cxlds NULL here */
+static inline bool cxled_dcd_enabled(struct cxl_endpoint_decoder *cxled)
+{
+	struct cxl_memdev_state *mds = cxled_to_mds(cxled);
+
+	return mds && cxl_dcd_supported(mds);
+}
+
+const char *cxl_dc_mode_name(bool shareable, bool read_only);
+int cxl_dc_mode_parse(const char *buf, bool *shareable, bool *read_only);
+
 #ifdef CONFIG_CXL_REGION
 
 struct cxl_region_context {
@@ -104,7 +124,8 @@ void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
 
 struct dentry *cxl_debugfs_create_dir(const char *dir);
 int cxl_dpa_set_part(struct cxl_endpoint_decoder *cxled,
-		     enum cxl_partition_mode mode);
+		     enum cxl_partition_mode mode, bool shareable,
+		     bool read_only);
 struct cxl_memdev_state;
 int cxl_mem_get_partition_info(struct cxl_memdev_state *mds);
 int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, u64 size);
diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index fdcef20e01ba..36fba4cff493 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -619,8 +619,14 @@ int cxl_dpa_free(struct cxl_endpoint_decoder *cxled)
 	return 0;
 }
 
+/*
+ * Select the first partition of @mode. For dynamic capacity the shareable
+ * and read-only flags must match exactly as well, so each selector names
+ * one kind of partition.
+ */
 int cxl_dpa_set_part(struct cxl_endpoint_decoder *cxled,
-		     enum cxl_partition_mode mode)
+		     enum cxl_partition_mode mode, bool shareable,
+		     bool read_only)
 {
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
@@ -631,9 +637,16 @@ int cxl_dpa_set_part(struct cxl_endpoint_decoder *cxled,
 	if (cxled->cxld.flags & CXL_DECODER_F_ENABLE)
 		return -EBUSY;
 
-	for (part = 0; part < cxlds->nr_partitions; part++)
-		if (cxlds->part[part].mode == mode)
-			break;
+	for (part = 0; part < cxlds->nr_partitions; part++) {
+		struct cxl_dpa_partition *p = &cxlds->part[part];
+
+		if (p->mode != mode)
+			continue;
+		if (mode == CXL_PARTMODE_DYNAMIC_RAM &&
+		    (p->shareable != shareable || p->read_only != read_only))
+			continue;
+		break;
+	}
 
 	if (part >= cxlds->nr_partitions) {
 		dev_dbg(dev, "unsupported mode: %d\n", mode);
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index f3705ea44db7..9b71b58d4e36 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -203,6 +203,40 @@ static ssize_t target_list_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(target_list);
 
+/* Dynamic capacity selectors: the flags name one kind of DC partition */
+static const struct {
+	const char *name;
+	bool shareable;
+	bool read_only;
+} cxl_dc_modes[] = {
+	{ "dynamic_ram",		false,	false },
+	{ "dynamic_ram_shared",		true,	false },
+	{ "dynamic_ram_ro",		false,	true },
+	{ "dynamic_ram_shared_ro",	true,	true },
+};
+
+const char *cxl_dc_mode_name(bool shareable, bool read_only)
+{
+	for (int i = 0; i < ARRAY_SIZE(cxl_dc_modes); i++)
+		if (cxl_dc_modes[i].shareable == shareable &&
+		    cxl_dc_modes[i].read_only == read_only)
+			return cxl_dc_modes[i].name;
+	return "";
+}
+
+/* Map a dynamic_ram selector to its partition flags; -EINVAL if unknown */
+int cxl_dc_mode_parse(const char *buf, bool *shareable, bool *read_only)
+{
+	for (int i = 0; i < ARRAY_SIZE(cxl_dc_modes); i++) {
+		if (!sysfs_streq(buf, cxl_dc_modes[i].name))
+			continue;
+		*shareable = cxl_dc_modes[i].shareable;
+		*read_only = cxl_dc_modes[i].read_only;
+		return 0;
+	}
+	return -EINVAL;
+}
+
 static ssize_t mode_show(struct device *dev, struct device_attribute *attr,
 			 char *buf)
 {
@@ -215,6 +249,9 @@ static ssize_t mode_show(struct device *dev, struct device_attribute *attr,
 
 	if (part < 0)
 		desc = "none";
+	else if (cxlds->part[part].mode == CXL_PARTMODE_DYNAMIC_RAM)
+		desc = cxl_dc_mode_name(cxlds->part[part].shareable,
+					cxlds->part[part].read_only);
 	else
 		desc = cxlds->part[part].res.name;
 
@@ -225,17 +262,25 @@ static ssize_t mode_store(struct device *dev, struct device_attribute *attr,
 			  const char *buf, size_t len)
 {
 	struct cxl_endpoint_decoder *cxled = to_cxl_endpoint_decoder(dev);
+	bool shareable = false, read_only = false;
 	enum cxl_partition_mode mode;
 	ssize_t rc;
 
-	if (sysfs_streq(buf, "pmem"))
+	if (sysfs_streq(buf, "pmem")) {
 		mode = CXL_PARTMODE_PMEM;
-	else if (sysfs_streq(buf, "ram"))
+	} else if (sysfs_streq(buf, "ram")) {
 		mode = CXL_PARTMODE_RAM;
-	else
-		return -EINVAL;
+	} else {
+		if (cxl_dc_mode_parse(buf, &shareable, &read_only))
+			return -EINVAL;
+		mode = CXL_PARTMODE_DYNAMIC_RAM;
+	}
+
+	/* The DC partition may outlive DCD support; refuse it when disabled */
+	if (mode == CXL_PARTMODE_DYNAMIC_RAM && !cxled_dcd_enabled(cxled))
+		return -ENXIO;
 
-	rc = cxl_dpa_set_part(cxled, mode);
+	rc = cxl_dpa_set_part(cxled, mode, shareable, read_only);
 	if (rc)
 		return rc;
 
-- 
2.43.0

