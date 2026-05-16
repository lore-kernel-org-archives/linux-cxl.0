Received: from serval.cherry.relay.mailchannels.net (serval.cherry.relay.mailchannels.net [23.83.223.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A07312D21B
	for <linux-cxl@vger.kernel.org>; Sat, 16 May 2026 04:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.223.163
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778906489; cv=pass; b=Ui4ZDTSV0lxnrVpwanwB8Abd9Sa6qmmF0UsI7JmmJgv0g6hHsQBojW06yKciAAVynys/92XeXSeNfsnS5JTOEeXaJc44cn5KBOKLvPq2cKdPMcQKsO6K8zNeCMDvH1rr41VHgmeYNGHJ82D/TLVRHQqng5UiXl7l6IGfnfhkCvc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778906489; c=relaxed/simple;
	bh=/UPeu6Fly4vtRTqNyl1MNXMRieefqP6gsIPv9VMkB+I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XbH8F1/ppWfKtOWI+Ou81eKWdAkFD5T48MTeiz0CSTREXweliy7evCRFJx+uOxusg8LWbDC+2b6a78m7BLuwJ+GLIqmW3pEF1C7IX0nvdA+Gbu6eaXA3+kd94OrSbwi25q5tB8ryN/yC5Gf+E/rBiuYgla94M9qH8pdsUE3d2o8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=RB5IX8gf; arc=pass smtp.client-ip=23.83.223.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="RB5IX8gf"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id DE2BD941B5C;
	Sat, 16 May 2026 02:21:10 +0000 (UTC)
Received: from pdx1-sub0-mail-a238.dreamhost.com (trex-green-1.trex.outbound.svc.cluster.local [100.102.214.146])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 91BE1941F51;
	Sat, 16 May 2026 02:21:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1778898070;
	b=nC8Q5SuUoKnK74OS1xVvQOI46w99YpVT12xZK1AEzyfQ0d0Ix9hWWvZ9dzqd1TxEXE6YuV
	uz3xz3tQ5QRUiOFNxADWVXdlGt76Uow2mcFjrn/b9kOfQwG1brrSEb38uzZFJYwYhn3iH4
	AkvBJyaKsCDCP2ll9ZuKuIaLFanBxwCovVHZrd2wuAbvoZKbG4zAkgwjTvy1mi5B6uCF/O
	U4LxXM5aDZKbznKu965xQ+Av9SNOK1GBL4J57WYz28RShDQNIQHMJuu5pIajs2xj8sHfay
	jaK4KjGOlfMf+XboE50owLnbMXEZ8nM5yNhb7+vRrVPGMqE1iO5NIYO4Hrk5zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1778898070;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=KbgF3rMWwxp/RHJLhtSBL0L/GSGUXPuBNvAKPRoxvSA=;
	b=NIYCkwzIkkz9eIa5KxK2zH8oIdLrxqIZUaGHdMmxEOZMFcNsHSL7l51Hi5sL4aepk5WJcu
	3io36DmNxKe/tY77BKR2p2KTsAYbqAw43QWvBOTVWEHXDRFx0MUG99BMtKGUzsfqfUUcZW
	t7uJBZHnOKbf5g2KroAMN1MGu7DYcwUrGVPZGT10WQNhJuCkwB/iDmw4QY0p/F+DaqB/qL
	9yck/qIegdazK+CX47CBCorZwoA3Je16uH3zwsvlOccSGLn3JhXqdKVPmG1smwFELMkJdV
	CP5dYHeA1j7zNL7LLd/AChUqECIQSnh+okIPBXUt/YpmrVwhIuLJJkGtVunrMQ==
ARC-Authentication-Results: i=1;
	rspamd-79cfc4d687-xlrbs;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Keen-Wide-Eyed: 1f009eb1407eb48f_1778898070866_1804139740
X-MC-Loop-Signature: 1778898070865:2539430932
X-MC-Ingress-Time: 1778898070865
Received: from pdx1-sub0-mail-a238.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.102.214.146 (trex/7.1.5);
	Sat, 16 May 2026 02:21:10 +0000
Received: from offworld.lan (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a238.dreamhost.com (Postfix) with ESMTPSA id 4gHSVF5jGKz105f;
	Fri, 15 May 2026 19:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1778898070;
	bh=KbgF3rMWwxp/RHJLhtSBL0L/GSGUXPuBNvAKPRoxvSA=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=RB5IX8gfO64q5GHuYUSaqAap3w8A7aXFfPblFx3bsTrPrb9WodaWiMmGVX+wrfyh2
	 D2lVz6iL5Rz7V36+1N/0Q0XFuBg5wb3fvps4ZS3W9HHmAFr2LWaVYU1S4El460kGrZ
	 o7Z1HW7PC4Nx7dVFt6kh3Fi8GxG6nKQ8fifbzqN6c9Tgk29w9tUIFvZVfjPDY7B/Is
	 ln8qDi2iUEPHGl+7K97mX08YAJDTzIt0c87p51/F+qIvoD+TyRk7ghgCq4iodMfdUx
	 1tSS9X4pTSTmJ3dczIE31M4X8m+a7SWTnA4yMr17NocC9/ElAJk7fusHHRjDUEmpZi
	 1kJDOKebHbOHA==
From: Davidlohr Bueso <dave@stgolabs.net>
To: dave.jiang@intel.com,
	djbw@kernel.org
Cc: jic23@kernel.org,
	benjamin.cheatham@amd.com,
	alucerop@amd.com,
	alison.schofield@intel.com,
	ira.weiny@intel.com,
	gourry@gourry.net,
	dongjoo.seo1@samsung.com,
	anisa.su@samsung.com,
	dave@stgolabs.net,
	linux-cxl@vger.kernel.org
Subject: [PATCH v3 4/5] cxl: Add HDM-DB region creation and sysfs interface
Date: Fri, 15 May 2026 19:20:35 -0700
Message-Id: <20260516022037.1761453-5-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260516022037.1761453-1-dave@stgolabs.net>
References: <20260516022037.1761453-1-dave@stgolabs.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A single Type 3 device can expose different parts of its memory with
different coherency semantics: some ranges as HDM-H (host-only), others
as HDM-DB (device-coherent with back-invalidate). Coherency models are
therefore defined per memory region.

Surface this through the sysfs interface and region-creation flow:

  - cap_bi (root decoder, RO): set when the underlying CFMWS window
    declares the BI restriction (ACPI_CEDT_CFMWS_RESTRICT_BI),
    propagated via a new CXL_DECODER_F_BI flag.

  - create_{pmem,ram}_bi_region (root decoder, RW): create an HDM-DB
    region. Visible only when cap_bi is set.

  - decoderX.Y/bi (endpoint decoder, RW): HDM-DB state of this
    decoder. Writes ('1' to set, '0' to clear) go through
    cxl_dpa_set_coherence() and are rejected after commit.

  - regionZ/bi (region, RO): '1' if the region is HDM-DB.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 Documentation/ABI/testing/sysfs-bus-cxl | 39 +++++++++++++--
 drivers/cxl/acpi.c                      |  2 +
 drivers/cxl/core/core.h                 |  2 +
 drivers/cxl/core/port.c                 | 64 ++++++++++++++++++++++++-
 drivers/cxl/core/region.c               | 60 +++++++++++++++++++++--
 drivers/cxl/cxl.h                       |  1 +
 6 files changed, 160 insertions(+), 8 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
index 16a9b3d2e2c0..11ef9faabec2 100644
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
@@ -426,6 +427,38 @@ Description:
 		current cached value.
 
 
+What:		/sys/bus/cxl/devices/decoderX.Y/create_{pmem,ram}_bi_region
+Date:		May, 2026
+KernelVersion:	v7.2
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
+Date:		May, 2026
+KernelVersion:	v7.2
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(RW) HDM-DB (device-managed coherency with back-invalidate)
+		state of this endpoint decoder. Writing '1' configures the
+		decoder for HDM-DB; '0' clears it. Reads return '1' if the
+		decoder is configured for HDM-DB and the device's BI is
+		enabled.
+
+What:		/sys/bus/cxl/devices/regionZ/bi
+Date:		May, 2026
+KernelVersion:	v7.2
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
index 127537628817..3026ab55cb57 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -152,6 +152,8 @@ static unsigned long cfmws_to_decoder_flags(int restrictions)
 		flags |= CXL_DECODER_F_PMEM;
 	if (restrictions & ACPI_CEDT_CFMWS_RESTRICT_FIXED)
 		flags |= CXL_DECODER_F_LOCK;
+	if (restrictions & ACPI_CEDT_CFMWS_RESTRICT_BI)
+		flags |= CXL_DECODER_F_BI;
 
 	return flags;
 }
diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 9c4ba9e7717f..846f098c52e4 100644
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
index c5aacd7054f1..0aa5ed33a3b5 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -131,6 +131,7 @@ CXL_DECODER_FLAG_ATTR(cap_ram, CXL_DECODER_F_RAM);
 CXL_DECODER_FLAG_ATTR(cap_type2, CXL_DECODER_F_TYPE2);
 CXL_DECODER_FLAG_ATTR(cap_type3, CXL_DECODER_F_TYPE3);
 CXL_DECODER_FLAG_ATTR(locked, CXL_DECODER_F_LOCK);
+CXL_DECODER_FLAG_ATTR(cap_bi, CXL_DECODER_F_BI);
 
 static ssize_t target_type_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
@@ -233,6 +234,39 @@ static ssize_t mode_store(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RW(mode);
 
+static ssize_t bi_show(struct device *dev, struct device_attribute *attr,
+		       char *buf)
+{
+	struct cxl_endpoint_decoder *cxled = to_cxl_endpoint_decoder(dev);
+	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+
+	return sysfs_emit(buf, "%d\n", cxlds->bi &&
+			  cxled->cxld.target_type == CXL_DECODER_DEVMEM);
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
@@ -329,10 +363,13 @@ static struct attribute *cxl_decoder_root_attrs[] = {
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
@@ -351,6 +388,21 @@ static bool can_create_ram(struct cxl_root_decoder *cxlrd)
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
@@ -362,8 +414,17 @@ static umode_t cxl_root_decoder_visible(struct kobject *kobj, struct attribute *
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
@@ -402,6 +463,7 @@ static const struct attribute_group *cxl_decoder_switch_attribute_groups[] = {
 static struct attribute *cxl_decoder_endpoint_attrs[] = {
 	&dev_attr_target_type.attr,
 	&dev_attr_mode.attr,
+	&dev_attr_bi.attr,
 	&dev_attr_dpa_size.attr,
 	&dev_attr_dpa_resource.attr,
 	SET_CXL_REGION_ATTR(region)
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index e50dc716d4e8..257f3f5fad97 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -632,6 +632,15 @@ static ssize_t resource_show(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RO(resource);
 
+static ssize_t bi_show(struct device *dev, struct device_attribute *attr,
+		       char *buf)
+{
+	struct cxl_region *cxlr = to_cxl_region(dev);
+
+	return sysfs_emit(buf, "%d\n", cxlr->type == CXL_DECODER_DEVMEM);
+}
+static DEVICE_ATTR_RO(bi);
+
 static ssize_t mode_show(struct device *dev, struct device_attribute *attr,
 			 char *buf)
 {
@@ -814,6 +823,7 @@ static struct attribute *cxl_region_attrs[] = {
 	&dev_attr_resource.attr,
 	&dev_attr_size.attr,
 	&dev_attr_mode.attr,
+	&dev_attr_bi.attr,
 	&dev_attr_extended_linear_cache_size.attr,
 	&dev_attr_locked.attr,
 	NULL,
@@ -2090,6 +2100,13 @@ static int cxl_region_attach(struct cxl_region *cxlr,
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
@@ -2769,7 +2786,8 @@ static struct cxl_region *__create_region(struct cxl_root_decoder *cxlrd,
 }
 
 static ssize_t create_region_store(struct device *dev, const char *buf,
-				   size_t len, enum cxl_partition_mode mode)
+				   size_t len, enum cxl_partition_mode mode,
+				   enum cxl_decoder_type target_type)
 {
 	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(dev);
 	struct cxl_region *cxlr;
@@ -2779,7 +2797,7 @@ static ssize_t create_region_store(struct device *dev, const char *buf,
 	if (rc != 1)
 		return -EINVAL;
 
-	cxlr = __create_region(cxlrd, mode, id, CXL_DECODER_HOSTONLYMEM);
+	cxlr = __create_region(cxlrd, mode, id, target_type);
 	if (IS_ERR(cxlr))
 		return PTR_ERR(cxlr);
 
@@ -2790,7 +2808,8 @@ static ssize_t create_pmem_region_store(struct device *dev,
 					struct device_attribute *attr,
 					const char *buf, size_t len)
 {
-	return create_region_store(dev, buf, len, CXL_PARTMODE_PMEM);
+	return create_region_store(dev, buf, len, CXL_PARTMODE_PMEM,
+				   CXL_DECODER_HOSTONLYMEM);
 }
 DEVICE_ATTR_RW(create_pmem_region);
 
@@ -2798,10 +2817,43 @@ static ssize_t create_ram_region_store(struct device *dev,
 				       struct device_attribute *attr,
 				       const char *buf, size_t len)
 {
-	return create_region_store(dev, buf, len, CXL_PARTMODE_RAM);
+	return create_region_store(dev, buf, len, CXL_PARTMODE_RAM,
+				   CXL_DECODER_HOSTONLYMEM);
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
+	return create_region_store(dev, buf, len, CXL_PARTMODE_PMEM,
+				   CXL_DECODER_DEVMEM);
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
+	return create_region_store(dev, buf, len, CXL_PARTMODE_RAM,
+				   CXL_DECODER_DEVMEM);
+}
+DEVICE_ATTR_RW(create_ram_bi_region);
+
 static ssize_t region_show(struct device *dev, struct device_attribute *attr,
 			   char *buf)
 {
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 8f7c3fe31f65..349e68ccb3e5 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -287,6 +287,7 @@ int cxl_dport_map_rcd_linkcap(struct pci_dev *pdev, struct cxl_dport *dport);
 #define CXL_DECODER_F_LOCK  BIT(4)
 #define CXL_DECODER_F_ENABLE    BIT(5)
 #define CXL_DECODER_F_NORMALIZED_ADDRESSING BIT(6)
+#define CXL_DECODER_F_BI    BIT(7)
 #define CXL_DECODER_F_RESET_MASK (CXL_DECODER_F_ENABLE | CXL_DECODER_F_LOCK)
 
 enum cxl_decoder_type {
-- 
2.39.5

