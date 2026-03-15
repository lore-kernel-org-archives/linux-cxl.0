Received: from fossa.ash.relay.mailchannels.net (fossa.ash.relay.mailchannels.net [23.83.222.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F015E223702
	for <linux-cxl@vger.kernel.org>; Sun, 15 Mar 2026 21:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.222.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773611253; cv=pass; b=DVV2c/WNiA0ZMNl0I8pg9agugNhyAHTuVyOQ6DpOQ24/X0SDdjpxspM6Mu7LWOhyrSgjr1kx/Dn/+apcaKm7+BNdbYtVlFReMFAHPXhcfUSnCuga9TZMNsVKjyvJiYp+Wfy70z2hRq6hd+pcsgtcC15Fl3WVw44faADEnHQYFZQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773611253; c=relaxed/simple;
	bh=kxxHeSc7/rHessFWhw7j+ndPh87SQRZGLuBltBffG3M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hCiQr1ZizDOx8hCrOblA74ARJlgiY5jxPRiqUVrz8/+QnwZBkCr753zgBhK0/GUWW2HBgW/Bo038jC8I/nJOC2lW2UEcx6U0N/8llMdlskD2xwrYdY02k37+gUpDox0G3huaCizrIIxEzD/irqRqklcOI6daxlBnSDWmYuGLGDc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=bfaNZ9S9; arc=pass smtp.client-ip=23.83.222.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="bfaNZ9S9"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 890CD92173A;
	Sun, 15 Mar 2026 20:27:48 +0000 (UTC)
Received: from pdx1-sub0-mail-a246.dreamhost.com (100-115-142-93.trex-nlb.outbound.svc.cluster.local [100.115.142.93])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 385BB9218A2;
	Sun, 15 Mar 2026 20:27:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1773606468;
	b=YpGPxAXl1e3YkeDaT4hxcZbPwDsmQrjeOlCfvjjV5b+MKBolXNWoPfrpsLEUMMIZ1Hl2v5
	4utiLXVAX/WeVzP5a9aH1iKBgYYn/lOsJwugUWOQmHvEGeMlZ8er5B9VXd9+LrTtocdYd0
	xFQwym8Z/FAZ0cAO4Czx6SRGvrvoyEpXWnpPDgTw95S9BoRAl2hcR9t/xS62UJiEmbgrwy
	QvQVIU86l+3NLyBwhIp3rEI+I2fBe8D6u/phDAD8UzcGvWrRRNVTwbG82Pmfkuw/I+BDKI
	s4fbqbwmHcEMqKM+LuKyZ+88mw1fLW/8KPjOQzJeRfns1SSBH4v6D0TsvL/69g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1773606468;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=FDrerqrhNUoXwdfrO4uqLcSLM0A5gHeBagwAZD9fAgM=;
	b=72Sf1luNXppQPNqNnEp9mY7fXMTzOycSZHpYOf4EaV5Wnh7bw1UPVwp/gzSYpFWSksEb3c
	6r9xtWXG6G9R4rsAbSdjK3aVsT9D6vpHlUwovToVYFcEpT0tOEo0v+g//fUA1p0MlZWaID
	iyvl27SwqadY5n9izc0EK+sJloLTJ39QvmA/HnBKlDKOo9C93IZBL1OABt1i5O2NHJErZD
	RdeVFR0bBI8cHQQ8BXbHs6ibzOfjGI6gI4mYaL8gWgY36fAWD30hCi86E9OA6nB3v/mgWN
	5FbCbBRijQC/eLkBRO5eNObR9IYP89ubrX2N6j1pECjn5YtmJTsVTdFCucEgOg==
ARC-Authentication-Results: i=1;
	rspamd-c9674b64d-tp962;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Cellar-Chief: 2e920e6864d83082_1773606468507_838345390
X-MC-Loop-Signature: 1773606468507:1755078552
X-MC-Ingress-Time: 1773606468506
Received: from pdx1-sub0-mail-a246.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.115.142.93 (trex/7.1.5);
	Sun, 15 Mar 2026 20:27:48 +0000
Received: from offworld.lan (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a246.dreamhost.com (Postfix) with ESMTPSA id 4fYqXg365Qz107r;
	Sun, 15 Mar 2026 13:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1773606467;
	bh=FDrerqrhNUoXwdfrO4uqLcSLM0A5gHeBagwAZD9fAgM=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=bfaNZ9S9zkZ3ZGGSOGB91ohLB0p2Yqogz51d+anU15wg22VO2VS/NtFDcbzzkoQFT
	 tWz8TGEZoCsy71dnT2NRKNbEN4Trrz2eciRHyE0hq7FRz2UBzLR/GbAJQ60JP84QSq
	 mhnN89yg+OWglFLMbJq8AliNHWzCIci7WZotfdE8NhSd64k8kSj1xa+tgM4Q3h3/Rj
	 Ri9rJdZSZaQ5DhAHACoekIsb9BZoDWn9G4DV51viJgvGDzKWoy1IPQ7BMZHk9A/5lc
	 3krv22zHC3CPaT7HIjSnAnzbagW6HQaoRya3G3ISEG5lJmCABzCFpjsqhpm9M835Cw
	 OlhntEcoQA63A==
From: Davidlohr Bueso <dave@stgolabs.net>
To: dave.jiang@intel.com,
	dan.j.williams@intel.com
Cc: jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	ira.weiny@intel.com,
	gourry@gourry.net,
	dongjoo.seo1@samsung.com,
	anisa.su@samsung.com,
	linux-cxl@vger.kernel.org,
	Davidlohr Bueso <dave@stgolabs.net>
Subject: [PATCH 6/6] cxl: Add HDM-DB region creation and sysfs interface
Date: Sun, 15 Mar 2026 13:27:41 -0700
Message-Id: <20260315202741.3264295-7-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260315202741.3264295-1-dave@stgolabs.net>
References: <20260315202741.3264295-1-dave@stgolabs.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A single Type 3 device can expose different parts of its memory with different
coherency semantics. For example, some memory ranges within a Type 3 device
could be configured as HDM-H, while other memory ranges on the same device
could be configured as HDM-DB. This allows for flexible memory configuration
within a single device. As such, coherency models are defined per memory region.

For accelerators (type2), it is expected for the respective drivers to manage
the HDM-D[B] region creation. For type3, relevant sysfs tunables are provided
to the user.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 Documentation/ABI/testing/sysfs-bus-cxl | 40 +++++++++++++--
 drivers/cxl/acpi.c                      |  2 +
 drivers/cxl/core/core.h                 |  2 +
 drivers/cxl/core/port.c                 | 63 +++++++++++++++++++++++-
 drivers/cxl/core/region.c               | 65 ++++++++++++++++++++++---
 5 files changed, 161 insertions(+), 11 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
index c80a1b5a03db..2959cc532f7c 100644
--- a/Documentation/ABI/testing/sysfs-bus-cxl
+++ b/Documentation/ABI/testing/sysfs-bus-cxl
@@ -297,7 +297,7 @@ Description:
 		Each entry in the list is a dport id.
 
 
-What:		/sys/bus/cxl/devices/decoderX.Y/cap_{pmem,ram,type2,type3}
+What:		/sys/bus/cxl/devices/decoderX.Y/cap_{pmem,ram,type2,type3,bi}
 Date:		June, 2021
 KernelVersion:	v5.14
 Contact:	linux-cxl@vger.kernel.org
@@ -306,8 +306,9 @@ Description:
 		represents a fixed memory window identified by platform
 		firmware. A fixed window may only support a subset of memory
 		types. The 'cap_*' attributes indicate whether persistent
-		memory, volatile memory, accelerator memory, and / or expander
-		memory may be mapped behind this decoder's memory window.
+		memory, volatile memory, accelerator memory, expander memory,
+		and / or back-invalidate (HDM-DB) memory may be mapped behind
+		this decoder's memory window.
 
 
 What:		/sys/bus/cxl/devices/decoderX.Y/target_type
@@ -426,6 +427,39 @@ Description:
 		current cached value.
 
 
+What:		/sys/bus/cxl/devices/decoderX.Y/create_{pmem,ram}_bi_region
+Date:		March, 2026
+KernelVersion:	v7.1
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(RW) Same as create_{pmem,ram}_region but creates an HDM-DB
+		(Back-Invalidate) region where the device manages coherency
+		via BISnp/BIRsp messages. Only visible when the root decoder
+		has the cap_bi flag set. Requires 256B Flit mode and BI
+		capability throughout the CXL topology.
+
+
+What:		/sys/bus/cxl/devices/decoderX.Y/bi
+Date:		March, 2026
+KernelVersion:	v7.1
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(RW) For endpoint decoders: set the coherence model of this
+		decoder. Write '1' to set HDM-DB (device-managed coherency
+		with back-invalidate), '0' for HDM-H (host-only coherency).
+		Reads show '1' if the device has Back-Invalidate enabled,
+		'0' otherwise. Can only be written when the decoder is
+		disabled.
+
+What:		/sys/bus/cxl/devices/regionZ/bi
+Date:		March, 2026
+KernelVersion:	v7.1
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(RO) Shows '1' if the region uses HDM-DB coherency model,
+		'0' otherwise.
+
+
 What:		/sys/bus/cxl/devices/decoderX.Y/delete_region
 Date:		May, 2022
 KernelVersion:	v6.0
diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index c959fca69b3f..7a5cdf5081cd 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -145,6 +145,8 @@ static unsigned long cfmws_to_decoder_flags(int restrictions)
 		flags |= CXL_DECODER_F_PMEM;
 	if (restrictions & ACPI_CEDT_CFMWS_RESTRICT_FIXED)
 		flags |= CXL_DECODER_F_LOCK;
+	if (restrictions & ACPI_CEDT_CFMWS_RESTRICT_BI)
+		flags |= CXL_DECODER_F_BI;
 
 	return flags;
 }
diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index da4c094b6702..eceba6c71564 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -29,6 +29,8 @@ struct cxl_region_context {
 
 extern struct device_attribute dev_attr_create_pmem_region;
 extern struct device_attribute dev_attr_create_ram_region;
+extern struct device_attribute dev_attr_create_pmem_bi_region;
+extern struct device_attribute dev_attr_create_ram_bi_region;
 extern struct device_attribute dev_attr_delete_region;
 extern struct device_attribute dev_attr_region;
 extern const struct device_type cxl_pmem_region_type;
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 5c82e6f32572..9bc2fb804aa0 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -131,6 +131,7 @@ CXL_DECODER_FLAG_ATTR(cap_ram, CXL_DECODER_F_RAM);
 CXL_DECODER_FLAG_ATTR(cap_type2, CXL_DECODER_F_TYPE2);
 CXL_DECODER_FLAG_ATTR(cap_type3, CXL_DECODER_F_TYPE3);
 CXL_DECODER_FLAG_ATTR(locked, CXL_DECODER_F_LOCK);
+CXL_DECODER_FLAG_ATTR(cap_bi, CXL_DECODER_F_BI);
 
 static ssize_t target_type_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
@@ -233,6 +234,38 @@ static ssize_t mode_store(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RW(mode);
 
+static ssize_t bi_show(struct device *dev, struct device_attribute *attr,
+		       char *buf)
+{
+	struct cxl_endpoint_decoder *cxled = to_cxl_endpoint_decoder(dev);
+	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+
+	return sysfs_emit(buf, "%d\n", !!cxlds->bi);
+}
+
+static ssize_t bi_store(struct device *dev, struct device_attribute *attr,
+			const char *buf, size_t len)
+{
+	struct cxl_endpoint_decoder *cxled = to_cxl_endpoint_decoder(dev);
+	enum cxl_decoder_type type;
+	ssize_t rc;
+
+	if (sysfs_streq(buf, "1"))
+		type = CXL_DECODER_DEVMEM;
+	else if (sysfs_streq(buf, "0"))
+		type = CXL_DECODER_HOSTONLYMEM;
+	else
+		return -EINVAL;
+
+	rc = cxl_dpa_set_coherence(cxled, type);
+	if (rc)
+		return rc;
+
+	return len;
+}
+static DEVICE_ATTR_RW(bi);
+
 static ssize_t dpa_resource_show(struct device *dev, struct device_attribute *attr,
 			    char *buf)
 {
@@ -329,10 +362,13 @@ static struct attribute *cxl_decoder_root_attrs[] = {
 	&dev_attr_cap_ram.attr,
 	&dev_attr_cap_type2.attr,
 	&dev_attr_cap_type3.attr,
+	&dev_attr_cap_bi.attr,
 	&dev_attr_target_list.attr,
 	&dev_attr_qos_class.attr,
 	SET_CXL_REGION_ATTR(create_pmem_region)
 	SET_CXL_REGION_ATTR(create_ram_region)
+	SET_CXL_REGION_ATTR(create_pmem_bi_region)
+	SET_CXL_REGION_ATTR(create_ram_bi_region)
 	SET_CXL_REGION_ATTR(delete_region)
 	NULL,
 };
@@ -351,6 +387,21 @@ static bool can_create_ram(struct cxl_root_decoder *cxlrd)
 	return (cxlrd->cxlsd.cxld.flags & flags) == flags;
 }
 
+static bool can_create_bi(struct cxl_root_decoder *cxlrd)
+{
+	return cxlrd->cxlsd.cxld.flags & CXL_DECODER_F_BI;
+}
+
+static bool can_create_pmem_bi(struct cxl_root_decoder *cxlrd)
+{
+	return can_create_pmem(cxlrd) && can_create_bi(cxlrd);
+}
+
+static bool can_create_ram_bi(struct cxl_root_decoder *cxlrd)
+{
+	return can_create_ram(cxlrd) && can_create_bi(cxlrd);
+}
+
 static umode_t cxl_root_decoder_visible(struct kobject *kobj, struct attribute *a, int n)
 {
 	struct device *dev = kobj_to_dev(kobj);
@@ -362,8 +413,17 @@ static umode_t cxl_root_decoder_visible(struct kobject *kobj, struct attribute *
 	if (a == CXL_REGION_ATTR(create_ram_region) && !can_create_ram(cxlrd))
 		return 0;
 
+	if (a == CXL_REGION_ATTR(create_pmem_bi_region) &&
+	    !can_create_pmem_bi(cxlrd))
+		return 0;
+
+	if (a == CXL_REGION_ATTR(create_ram_bi_region) &&
+	    !can_create_ram_bi(cxlrd))
+		return 0;
+
 	if (a == CXL_REGION_ATTR(delete_region) &&
-	    !(can_create_pmem(cxlrd) || can_create_ram(cxlrd)))
+	    !(can_create_pmem(cxlrd) || can_create_ram(cxlrd) ||
+	      can_create_pmem_bi(cxlrd) || can_create_ram_bi(cxlrd)))
 		return 0;
 
 	return a->mode;
@@ -402,6 +462,7 @@ static const struct attribute_group *cxl_decoder_switch_attribute_groups[] = {
 static struct attribute *cxl_decoder_endpoint_attrs[] = {
 	&dev_attr_target_type.attr,
 	&dev_attr_mode.attr,
+	&dev_attr_bi.attr,
 	&dev_attr_dpa_size.attr,
 	&dev_attr_dpa_resource.attr,
 	SET_CXL_REGION_ATTR(region)
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index bd4c4a4a27da..4bc23ac3b5ed 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -626,6 +626,15 @@ static ssize_t mode_show(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RO(mode);
 
+static ssize_t bi_show(struct device *dev, struct device_attribute *attr,
+		       char *buf)
+{
+	struct cxl_region *cxlr = to_cxl_region(dev);
+
+	return sysfs_emit(buf, "%d\n", cxlr->type == CXL_DECODER_DEVMEM);
+}
+static DEVICE_ATTR_RO(bi);
+
 static int alloc_hpa(struct cxl_region *cxlr, resource_size_t size)
 {
 	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
@@ -775,6 +784,7 @@ static struct attribute *cxl_region_attrs[] = {
 	&dev_attr_resource.attr,
 	&dev_attr_size.attr,
 	&dev_attr_mode.attr,
+	&dev_attr_bi.attr,
 	&dev_attr_extended_linear_cache_size.attr,
 	NULL,
 };
@@ -2041,6 +2051,13 @@ static int cxl_region_attach(struct cxl_region *cxlr,
 		return -ENXIO;
 	}
 
+	if (cxlr->type == CXL_DECODER_DEVMEM &&
+	    cxlds->type == CXL_DEVTYPE_CLASSMEM && !cxlds->bi) {
+		dev_dbg(&cxlr->dev, "%s:%s BI not enabled on device\n",
+			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev));
+		return -ENXIO;
+	}
+
 	if (!cxled->dpa_res) {
 		dev_dbg(&cxlr->dev, "%s:%s: missing DPA allocation.\n",
 			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev));
@@ -2650,7 +2667,8 @@ static ssize_t create_ram_region_show(struct device *dev,
 }
 
 static struct cxl_region *__create_region(struct cxl_root_decoder *cxlrd,
-					  enum cxl_partition_mode mode, int id)
+					  enum cxl_partition_mode mode,
+					  bool bi, int id)
 {
 	int rc;
 
@@ -2672,11 +2690,14 @@ static struct cxl_region *__create_region(struct cxl_root_decoder *cxlrd,
 		return ERR_PTR(-EBUSY);
 	}
 
-	return devm_cxl_add_region(cxlrd, id, mode, CXL_DECODER_HOSTONLYMEM);
+	return devm_cxl_add_region(cxlrd, id, mode,
+				   bi ? CXL_DECODER_DEVMEM
+				      : CXL_DECODER_HOSTONLYMEM);
 }
 
 static ssize_t create_region_store(struct device *dev, const char *buf,
-				   size_t len, enum cxl_partition_mode mode)
+				   size_t len, enum cxl_partition_mode mode,
+				   bool bi)
 {
 	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(dev);
 	struct cxl_region *cxlr;
@@ -2686,7 +2707,7 @@ static ssize_t create_region_store(struct device *dev, const char *buf,
 	if (rc != 1)
 		return -EINVAL;
 
-	cxlr = __create_region(cxlrd, mode, id);
+	cxlr = __create_region(cxlrd, mode, bi, id);
 	if (IS_ERR(cxlr))
 		return PTR_ERR(cxlr);
 
@@ -2697,7 +2718,7 @@ static ssize_t create_pmem_region_store(struct device *dev,
 					struct device_attribute *attr,
 					const char *buf, size_t len)
 {
-	return create_region_store(dev, buf, len, CXL_PARTMODE_PMEM);
+	return create_region_store(dev, buf, len, CXL_PARTMODE_PMEM, false);
 }
 DEVICE_ATTR_RW(create_pmem_region);
 
@@ -2705,10 +2726,40 @@ static ssize_t create_ram_region_store(struct device *dev,
 				       struct device_attribute *attr,
 				       const char *buf, size_t len)
 {
-	return create_region_store(dev, buf, len, CXL_PARTMODE_RAM);
+	return create_region_store(dev, buf, len, CXL_PARTMODE_RAM, false);
 }
 DEVICE_ATTR_RW(create_ram_region);
 
+static ssize_t create_pmem_bi_region_show(struct device *dev,
+					  struct device_attribute *attr,
+					  char *buf)
+{
+	return __create_region_show(to_cxl_root_decoder(dev), buf);
+}
+
+static ssize_t create_pmem_bi_region_store(struct device *dev,
+					   struct device_attribute *attr,
+					   const char *buf, size_t len)
+{
+	return create_region_store(dev, buf, len, CXL_PARTMODE_PMEM, true);
+}
+DEVICE_ATTR_RW(create_pmem_bi_region);
+
+static ssize_t create_ram_bi_region_show(struct device *dev,
+					 struct device_attribute *attr,
+					 char *buf)
+{
+	return __create_region_show(to_cxl_root_decoder(dev), buf);
+}
+
+static ssize_t create_ram_bi_region_store(struct device *dev,
+					  struct device_attribute *attr,
+					  const char *buf, size_t len)
+{
+	return create_region_store(dev, buf, len, CXL_PARTMODE_RAM, true);
+}
+DEVICE_ATTR_RW(create_ram_bi_region);
+
 static ssize_t region_show(struct device *dev, struct device_attribute *attr,
 			   char *buf)
 {
@@ -3883,7 +3934,7 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 	struct cxl_region *cxlr;
 
 	do {
-		cxlr = __create_region(cxlrd, cxlds->part[part].mode,
+		cxlr = __create_region(cxlrd, cxlds->part[part].mode, false,
 				       atomic_read(&cxlrd->region_id));
 	} while (IS_ERR(cxlr) && PTR_ERR(cxlr) == -EBUSY);
 
-- 
2.39.5

