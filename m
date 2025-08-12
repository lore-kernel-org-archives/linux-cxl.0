Received: from buffalo.tulip.relay.mailchannels.net (buffalo.tulip.relay.mailchannels.net [23.83.218.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34FDA215789
	for <linux-cxl@vger.kernel.org>; Tue, 12 Aug 2025 01:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754961116; cv=pass; b=AO4xuOqf435yj7CWtGkVd0GWhrn+gn+EckcQc/JA90tCc7MrkqH5iokh2HUY2nusyGZpJ1FSw0wqmWwDCSzcj73hK4NmhQ8jC7wuSoKFOWzbNFDJBThxpKP1PiD85c0BqSDt+XwssroSaNhkgiuwsFu23C0/74e7PiUBIxMXBxo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754961116; c=relaxed/simple;
	bh=RQ6KBxYN9yjVkVt3Xxl1WMhgRjXBg/jgyCpks5PeC/M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FpS61tzG60lUTWhrA//CHxh2RAN0Rh/vZaF4YLRMevsM8CCEsyQPsZzvloxHjVg54Mc1e53VXH0UQUS+/++iykpsjc5Pf/nD+4S/VIr5M7k4IzrIkWg1FkncJp2KMbp8n9n4G17934WWTtxgZibt4i31B1p9AHWr1Vsj0E5lZC0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=omKzyqDd; arc=pass smtp.client-ip=23.83.218.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="omKzyqDd"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id BD52182BCC;
	Tue, 12 Aug 2025 01:02:33 +0000 (UTC)
Received: from pdx1-sub0-mail-a202.dreamhost.com (trex-blue-2.trex.outbound.svc.cluster.local [100.96.138.11])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 637A982EFF;
	Tue, 12 Aug 2025 01:02:33 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1754960553; a=rsa-sha256;
	cv=none;
	b=O78+U4hdPzT+l8wM3yxgrN1WSK2XncnvO9k8Ga3zMvnVl3oiqrKDP3gwjvDXUVK1gC2p+I
	JbW5H3T9e6pnUf7DMtRobjmGuHZKkofi+03N4h5F/jlJxhYjJ3Q1b0+TfVtOfhGd4s5pkP
	MM6usiImllwtFJ0EqIA0+SFMtdz9tRyOHqTEG/4lnVdJ9NlRDJ6Af4SYy1gFXERx3JDZUW
	kxYpTsRCznILrjDoabHttMNyrs08NwrxQgp6CkmUW9Eo02CjKfIDyvny/bYGPU4pm2ycnk
	xkLuSDUPLlq5nuIxsnjEH5UAKJYopU+RMQpmF4rU9XURlKuYhnug19O0ckz8dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1754960553;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=dvjYqSP82S8QRJBQVAEkToNf3JgaPYd3eOB7qIMjuaw=;
	b=Hla33Vy0GoFX4KrjkiIqqGOKO+TbGse8Iub4P8M6idhHeTGIbZdmYZqjzZjXXf/nsC0CkU
	t/fqOogcU2h/9pGAmiyH/5XMo2wwtnPhG+EegmDQe4rtlOZTOwyRefHWv+3jJDCOwDaHqv
	1lkPRhqWaWf9TGksy+IrWGxYEZhy750BWdaDydooz3gOlS8ghD97nOBpmQnHWpmI/FYsPC
	qzlfDKrzyUkfrVBfUT8yofTdV3WcwPvwjJFQVOar+pdYCjnsnwZPPTi1YcUXlzLR3gCpqv
	CsDn4gtsTTkV8RMU7+nQe1vCMnffYITzn+lmWun0B44/sLKOIBhtPrIBQclhlQ==
ARC-Authentication-Results: i=1;
	rspamd-7c5968dc44-r5gdq;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Absorbed-Lyrical: 48ef37711efe898a_1754960553708_2430857697
X-MC-Loop-Signature: 1754960553708:1213533528
X-MC-Ingress-Time: 1754960553708
Received: from pdx1-sub0-mail-a202.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.96.138.11 (trex/7.1.3);
	Tue, 12 Aug 2025 01:02:33 +0000
Received: from offworld.lan (syn-076-167-199-067.res.spectrum.com [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a202.dreamhost.com (Postfix) with ESMTPSA id 4c1CsN4W7CzDF;
	Mon, 11 Aug 2025 18:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1754960553;
	bh=dvjYqSP82S8QRJBQVAEkToNf3JgaPYd3eOB7qIMjuaw=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=omKzyqDd7F5vHXd4rWWArsO9vgTsoETBrS+T7YI0q/tDdxikew8SDBJfu+GkW0REr
	 +SL/goYx1C+aWBmJuCzLEdaR2OV8MYtIRUL7FDhoa8Qm7bIqmxHVwkYAFLBFSzOp1p
	 e+0EljU1CkZuyWUj5lCFcPQrm726K1UR4BEDKwn4y89CXU0nAGoKVEY3HKYzv/HnFL
	 95utOmv0GzOSxVW67A6JLvB1J7SAS3ynadZmeHEKQfi6Vy57NCo0OdEFUXuV2Lg/QT
	 0+sjCub60mG6dGP/l33k5jS8E/NhCNY65Sb57oawHEKl6+bmJ3oQEMblfsEm+vamj2
	 6Xup4pF+hTvtw==
From: Davidlohr Bueso <dave@stgolabs.net>
To: dave.jiang@intel.com,
	dan.j.williams@intel.com
Cc: jonathan.cameron@huawei.com,
	ira.weiny@intel.com,
	alison.schofield@intel.com,
	alucerop@amd.com,
	a.manzanares@samsung.com,
	anisa.su@samsung.com,
	linux-cxl@vger.kernel.org,
	dave@stgolabs.net
Subject: [PATCH 3/3] cxl: Support creating HDM-DB regions
Date: Mon, 11 Aug 2025 18:02:28 -0700
Message-Id: <20250812010228.2589787-4-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250812010228.2589787-1-dave@stgolabs.net>
References: <20250812010228.2589787-1-dave@stgolabs.net>
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

For accelerators (type2), it is expected for accelerator drivers to manage the
HDM-D[B] region creation. For type3, relevant sysfs tunables are provided to
the user.

Other than the HDM decoder supported coherency models, the main dependency
to create these regions is for the device state to be BI-ready (cxlds->bi),
for which already committed HDM decoders with the BI bit set detected during
enumeration is currently not supported because endpoint and port enumerations
are independent.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 Documentation/ABI/testing/sysfs-bus-cxl | 41 ++++++++++++++----
 drivers/cxl/acpi.c                      |  2 +
 drivers/cxl/core/core.h                 |  4 ++
 drivers/cxl/core/hdm.c                  | 56 +++++++++++++++++++++---
 drivers/cxl/core/port.c                 | 55 +++++++++++++++++++++++-
 drivers/cxl/core/region.c               | 57 +++++++++++++++++++++----
 drivers/cxl/cxl.h                       |  7 ++-
 drivers/cxl/cxlmem.h                    |  1 +
 include/acpi/actbl1.h                   |  1 +
 9 files changed, 199 insertions(+), 25 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
index 6b4e8c7a963d..7d9e3db736c3 100644
--- a/Documentation/ABI/testing/sysfs-bus-cxl
+++ b/Documentation/ABI/testing/sysfs-bus-cxl
@@ -297,17 +297,18 @@ Description:
 		Each entry in the list is a dport id.
 
 
-What:		/sys/bus/cxl/devices/decoderX.Y/cap_{pmem,ram,type2,type3}
-Date:		June, 2021
-KernelVersion:	v5.14
+What:		/sys/bus/cxl/devices/decoderX.Y/cap_{pmem,ram,type2,type3,bi}
+Date:		June, 2021, August, 2025
+KernelVersion:	v5.14, v6.18 (bi)
 Contact:	linux-cxl@vger.kernel.org
 Description:
 		(RO) When a CXL decoder is of devtype "cxl_decoder_root", it
 		represents a fixed memory window identified by platform
 		firmware. A fixed window may only support a subset of memory
 		types. The 'cap_*' attributes indicate whether persistent
-		memory, volatile memory, accelerator memory, and / or expander
-		memory may be mapped behind this decoder's memory window.
+		memory, volatile memory, accelerator memory, back invalidation,
+		and / or expander memory may be mapped behind this decoder's
+		memory window.
 
 
 What:		/sys/bus/cxl/devices/decoderX.Y/target_type
@@ -352,6 +353,17 @@ Description:
 		next allocation.
 
 
+What:		/sys/bus/cxl/devices/decoderX.Y/bi
+Date:		August, 2025
+KernelVersion:	v6.18
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(RW) Specify whether or not the memory range for this endpoint
+		decoder will use Back-Invalidation (HDM-DB) for device managed
+		coherence. It may only be written to when the decoder is in the
+		'disabled' state.
+
+
 What:		/sys/bus/cxl/devices/decoderX.Y/dpa_resource
 Date:		May, 2022
 KernelVersion:	v6.0
@@ -410,15 +422,17 @@ Description:
 		interleave_granularity).
 
 
-What:		/sys/bus/cxl/devices/decoderX.Y/create_{pmem,ram}_region
-Date:		May, 2022, January, 2023
-KernelVersion:	v6.0 (pmem), v6.3 (ram)
+What:		/sys/bus/cxl/devices/decoderX.Y/create_{pmem,ram}_{bi}_region
+Date:		May, 2022, January, 2023, August, 2025
+KernelVersion:	v6.0 (pmem), v6.3 (ram) v6.18 (bi)
 Contact:	linux-cxl@vger.kernel.org
 Description:
 		(RW) Write a string in the form 'regionZ' to start the process
 		of defining a new persistent, or volatile memory region
 		(interleave-set) within the decode range bounded by root decoder
-		'decoderX.Y'. The value written must match the current value
+		'decoderX.Y'. Further, it is specified whether or not the region
+		also supports Back-Invalidate flows for device memory coherence
+		management. The value written must match the current value
 		returned from reading this attribute. An atomic compare exchange
 		operation is done on write to assign the requested id to a
 		region and allocate the region-id for the next creation attempt.
@@ -509,6 +523,15 @@ Description:
 		region. For more details on the possible modes see
 		/sys/bus/cxl/devices/decoderX.Y/mode
 
+What:		/sys/bus/cxl/devices/regionZ/bi
+Date:		August, 2025
+KernelVersion:	v6.18
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(RO) The coherence model of a region is established at region
+		creation time and dictates the type of the endpoint decoder that
+		comprise the region. See /sys/bus/cxl/devices/decoderX.Y/bi for
+		more details.
 
 What:		/sys/bus/cxl/devices/regionZ/resource
 Date:		May, 2022
diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 9b32392c82fc..364f003d1961 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -123,6 +123,8 @@ static unsigned long cfmws_to_decoder_flags(int restrictions)
 		flags |= CXL_DECODER_F_PMEM;
 	if (restrictions & ACPI_CEDT_CFMWS_RESTRICT_FIXED)
 		flags |= CXL_DECODER_F_LOCK;
+	if (restrictions & ACPI_CEDT_CFMWS_RESTRICT_BI)
+		flags |= CXL_DECODER_F_BI;
 
 	return flags;
 }
diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 2669f251d677..79fac8bc74f7 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -21,6 +21,8 @@ enum cxl_detach_mode {
 #ifdef CONFIG_CXL_REGION
 extern struct device_attribute dev_attr_create_pmem_region;
 extern struct device_attribute dev_attr_create_ram_region;
+extern struct device_attribute dev_attr_create_pmem_bi_region;
+extern struct device_attribute dev_attr_create_ram_bi_region;
 extern struct device_attribute dev_attr_delete_region;
 extern struct device_attribute dev_attr_region;
 extern const struct device_type cxl_pmem_region_type;
@@ -89,6 +91,8 @@ void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
 struct dentry *cxl_debugfs_create_dir(const char *dir);
 int cxl_dpa_set_part(struct cxl_endpoint_decoder *cxled,
 		     enum cxl_partition_mode mode);
+int cxl_dpa_set_coherence(struct cxl_endpoint_decoder *cxled,
+			  enum cxl_decoder_type type);
 int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, u64 size);
 int cxl_dpa_free(struct cxl_endpoint_decoder *cxled);
 resource_size_t cxl_dpa_size(struct cxl_endpoint_decoder *cxled);
diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index e9e1d555cec6..9e213785c335 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -96,6 +96,10 @@ static void parse_hdm_decoder_caps(struct cxl_hdm *cxlhdm)
 		cxlhdm->iw_cap_mask |= BIT(3) | BIT(6) | BIT(12);
 	if (FIELD_GET(CXL_HDM_DECODER_INTERLEAVE_16_WAY, hdm_cap))
 		cxlhdm->iw_cap_mask |= BIT(16);
+	if (FIELD_GET(CXL_HDM_DECODER_SUPPORTED_COHERENCY_MASK, hdm_cap))
+		cxlhdm->supported_coherency =
+			FIELD_GET(CXL_HDM_DECODER_SUPPORTED_COHERENCY_MASK,
+				  hdm_cap);
 }
 
 static bool should_emulate_decoders(struct cxl_endpoint_dvsec_info *info)
@@ -613,6 +617,31 @@ int cxl_dpa_set_part(struct cxl_endpoint_decoder *cxled,
 	return 0;
 }
 
+int cxl_dpa_set_coherence(struct cxl_endpoint_decoder *cxled,
+			  enum cxl_decoder_type type)
+{
+	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+	struct cxl_port *port = to_cxl_port(cxled->cxld.dev.parent);
+	struct cxl_hdm *cxlhdm = dev_get_drvdata(&port->dev);
+
+	guard(rwsem_write)(&cxl_rwsem.dpa);
+	if (cxled->cxld.flags & CXL_DECODER_F_ENABLE)
+		return -EBUSY;
+
+	if (!cxlds->bi && type == CXL_DECODER_DEVMEM)
+		return -EINVAL;
+
+	if (type == CXL_DECODER_HOSTONLYMEM &&
+	    cxlhdm->supported_coherency == 0x1)
+		return -EINVAL;
+	if (type == CXL_DECODER_DEVMEM && cxlhdm->supported_coherency == 0x2)
+		return -EINVAL;
+
+	cxled->cxld.target_type = type;
+	return 0;
+}
+
 static int __cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, u64 size)
 {
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
@@ -723,6 +752,9 @@ static void cxld_set_type(struct cxl_decoder *cxld, u32 *ctrl)
 	u32p_replace_bits(ctrl,
 			  !!(cxld->target_type == CXL_DECODER_HOSTONLYMEM),
 			  CXL_HDM_DECODER0_CTRL_HOSTONLY);
+	u32p_replace_bits(ctrl,
+			  !!(cxld->target_type == CXL_DECODER_DEVMEM),
+			  CXL_HDM_DECODER0_CTRL_BI);
 }
 
 static void cxlsd_set_targets(struct cxl_switch_decoder *cxlsd, u64 *tgt)
@@ -1033,6 +1065,15 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 		cxld->flags |= CXL_DECODER_F_ENABLE;
 		if (ctrl & CXL_HDM_DECODER0_CTRL_LOCK)
 			cxld->flags |= CXL_DECODER_F_LOCK;
+
+		/*
+		 * Autocommit BI-enabled decoders is not supported.
+		 * At this point ->bi is not yet setup, so there
+		 * are no guarantees that the platform supports BI.
+		 */
+		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_BI, ctrl))
+			return -ENXIO;
+
 		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_HOSTONLY, ctrl))
 			cxld->target_type = CXL_DECODER_HOSTONLYMEM;
 		else
@@ -1057,14 +1098,19 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 		if (cxled) {
 			struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
 			struct cxl_dev_state *cxlds = cxlmd->cxlds;
+			struct cxl_port *port = to_cxl_port(cxld->dev.parent);
+			struct cxl_hdm *cxlhdm = dev_get_drvdata(&port->dev);
 
 			/*
-			 * Default by devtype until a device arrives that needs
-			 * more precision.
+			 * For type3 HDM-DB devices, users can later change the
+			 * target_type, if supported by the HDM decoder.
 			 */
-			if (cxlds->type == CXL_DEVTYPE_CLASSMEM)
-				cxld->target_type = CXL_DECODER_HOSTONLYMEM;
-			else
+			if (cxlds->type == CXL_DEVTYPE_CLASSMEM) {
+				if (cxlhdm->supported_coherency == 0x1)
+					cxld->target_type = CXL_DECODER_DEVMEM;
+				else
+					cxld->target_type = CXL_DECODER_HOSTONLYMEM;
+			} else
 				cxld->target_type = CXL_DECODER_DEVMEM;
 		} else {
 			/* To be overridden by region type at commit time */
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 38f74bcbfec2..6f95ac6ac01e 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -122,6 +122,7 @@ CXL_DECODER_FLAG_ATTR(cap_ram, CXL_DECODER_F_RAM);
 CXL_DECODER_FLAG_ATTR(cap_type2, CXL_DECODER_F_TYPE2);
 CXL_DECODER_FLAG_ATTR(cap_type3, CXL_DECODER_F_TYPE3);
 CXL_DECODER_FLAG_ATTR(locked, CXL_DECODER_F_LOCK);
+CXL_DECODER_FLAG_ATTR(cap_bi, CXL_DECODER_F_BI);
 
 static ssize_t target_type_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
@@ -224,6 +225,38 @@ static ssize_t mode_store(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RW(mode);
 
+static ssize_t bi_show(struct device *dev, struct device_attribute *attr,
+			 char *buf)
+{
+	struct cxl_endpoint_decoder *cxled = to_cxl_endpoint_decoder(dev);
+	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+
+	return sysfs_emit(buf, "%d\n", !!cxlds->bi);
+}
+
+static ssize_t bi_store(struct device *dev, struct device_attribute *attr,
+			  const char *buf, size_t len)
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
@@ -320,10 +353,13 @@ static struct attribute *cxl_decoder_root_attrs[] = {
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
@@ -342,7 +378,15 @@ static bool can_create_ram(struct cxl_root_decoder *cxlrd)
 	return (cxlrd->cxlsd.cxld.flags & flags) == flags;
 }
 
-static umode_t cxl_root_decoder_visible(struct kobject *kobj, struct attribute *a, int n)
+static bool can_create_bi(struct cxl_root_decoder *cxlrd)
+{
+	unsigned long flags = CXL_DECODER_F_BI;
+
+	return (cxlrd->cxlsd.cxld.flags & flags) == flags;
+}
+
+static umode_t cxl_root_decoder_visible(struct kobject *kobj,
+					struct attribute *a, int n)
 {
 	struct device *dev = kobj_to_dev(kobj);
 	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(dev);
@@ -353,6 +397,14 @@ static umode_t cxl_root_decoder_visible(struct kobject *kobj, struct attribute *
 	if (a == CXL_REGION_ATTR(create_ram_region) && !can_create_ram(cxlrd))
 		return 0;
 
+	if (a == CXL_REGION_ATTR(create_pmem_bi_region) &&
+	    (!can_create_pmem(cxlrd) || !can_create_bi(cxlrd)))
+		return 0;
+
+	if (a == CXL_REGION_ATTR(create_ram_bi_region) &&
+	    (!can_create_ram(cxlrd) || !can_create_bi(cxlrd)))
+		return 0;
+
 	if (a == CXL_REGION_ATTR(delete_region) &&
 	    !(can_create_pmem(cxlrd) || can_create_ram(cxlrd)))
 		return 0;
@@ -393,6 +445,7 @@ static const struct attribute_group *cxl_decoder_switch_attribute_groups[] = {
 static struct attribute *cxl_decoder_endpoint_attrs[] = {
 	&dev_attr_target_type.attr,
 	&dev_attr_mode.attr,
+	&dev_attr_bi.attr,
 	&dev_attr_dpa_size.attr,
 	&dev_attr_dpa_resource.attr,
 	SET_CXL_REGION_ATTR(region)
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index e9bf42d91689..0c8a6e539599 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -624,6 +624,15 @@ static ssize_t mode_show(struct device *dev, struct device_attribute *attr,
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
 	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
@@ -754,6 +763,7 @@ static struct attribute *cxl_region_attrs[] = {
 	&dev_attr_resource.attr,
 	&dev_attr_size.attr,
 	&dev_attr_mode.attr,
+	&dev_attr_bi.attr,
 	NULL,
 };
 
@@ -2523,7 +2533,7 @@ static int cxl_region_calculate_adistance(struct notifier_block *nb,
  * @cxlrd: root decoder
  * @id: memregion id to create, or memregion_free() on failure
  * @mode: mode for the endpoint decoders of this region
- * @type: select whether this is an expander or accelerator (type-2 or type-3)
+ * @type: select whether this is HDM-H or HDM-D[B]
  *
  * This is the second step of region initialization. Regions exist within an
  * address space which is mapped by a @cxlrd.
@@ -2586,8 +2596,21 @@ static ssize_t create_ram_region_show(struct device *dev,
 	return __create_region_show(to_cxl_root_decoder(dev), buf);
 }
 
+static ssize_t create_pmem_bi_region_show(struct device *dev,
+				       struct device_attribute *attr, char *buf)
+{
+	return __create_region_show(to_cxl_root_decoder(dev), buf);
+}
+
+static ssize_t create_ram_bi_region_show(struct device *dev,
+				      struct device_attribute *attr, char *buf)
+{
+	return __create_region_show(to_cxl_root_decoder(dev), buf);
+}
+
 static struct cxl_region *__create_region(struct cxl_root_decoder *cxlrd,
-					  enum cxl_partition_mode mode, int id)
+					  enum cxl_partition_mode mode,
+					  bool bi, int id)
 {
 	int rc;
 
@@ -2609,11 +2632,13 @@ static struct cxl_region *__create_region(struct cxl_root_decoder *cxlrd,
 		return ERR_PTR(-EBUSY);
 	}
 
-	return devm_cxl_add_region(cxlrd, id, mode, CXL_DECODER_HOSTONLYMEM);
+	return devm_cxl_add_region(cxlrd, id, mode, bi ?
+				   CXL_DECODER_DEVMEM:CXL_DECODER_HOSTONLYMEM);
 }
 
 static ssize_t create_region_store(struct device *dev, const char *buf,
-				   size_t len, enum cxl_partition_mode mode)
+				   size_t len, enum cxl_partition_mode mode,
+				   bool bi)
 {
 	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(dev);
 	struct cxl_region *cxlr;
@@ -2623,7 +2648,7 @@ static ssize_t create_region_store(struct device *dev, const char *buf,
 	if (rc != 1)
 		return -EINVAL;
 
-	cxlr = __create_region(cxlrd, mode, id);
+	cxlr = __create_region(cxlrd, mode, bi, id);
 	if (IS_ERR(cxlr))
 		return PTR_ERR(cxlr);
 
@@ -2634,7 +2659,7 @@ static ssize_t create_pmem_region_store(struct device *dev,
 					struct device_attribute *attr,
 					const char *buf, size_t len)
 {
-	return create_region_store(dev, buf, len, CXL_PARTMODE_PMEM);
+	return create_region_store(dev, buf, len, CXL_PARTMODE_PMEM, false);
 }
 DEVICE_ATTR_RW(create_pmem_region);
 
@@ -2642,10 +2667,26 @@ static ssize_t create_ram_region_store(struct device *dev,
 				       struct device_attribute *attr,
 				       const char *buf, size_t len)
 {
-	return create_region_store(dev, buf, len, CXL_PARTMODE_RAM);
+	return create_region_store(dev, buf, len, CXL_PARTMODE_RAM, false);
 }
 DEVICE_ATTR_RW(create_ram_region);
 
+static ssize_t create_pmem_bi_region_store(struct device *dev,
+					   struct device_attribute *attr,
+					   const char *buf, size_t len)
+{
+	return create_region_store(dev, buf, len, CXL_PARTMODE_PMEM, true);
+}
+DEVICE_ATTR_RW(create_pmem_bi_region);
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
@@ -3414,7 +3455,7 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 	struct cxl_region *cxlr;
 
 	do {
-		cxlr = __create_region(cxlrd, cxlds->part[part].mode,
+		cxlr = __create_region(cxlrd, cxlds->part[part].mode, false,
 				       atomic_read(&cxlrd->region_id));
 	} while (IS_ERR(cxlr) && PTR_ERR(cxlr) == -EBUSY);
 
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 6361365c5ce9..0a9532fa4ec1 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -51,6 +51,7 @@ extern const struct nvdimm_security_ops *cxl_security_ops;
 #define   CXL_HDM_DECODER_INTERLEAVE_14_12 BIT(9)
 #define   CXL_HDM_DECODER_INTERLEAVE_3_6_12_WAY BIT(11)
 #define   CXL_HDM_DECODER_INTERLEAVE_16_WAY BIT(12)
+#define   CXL_HDM_DECODER_SUPPORTED_COHERENCY_MASK GENMASK(22, 21)
 #define CXL_HDM_DECODER_CTRL_OFFSET 0x4
 #define   CXL_HDM_DECODER_ENABLE BIT(1)
 #define CXL_HDM_DECODER0_BASE_LOW_OFFSET(i) (0x20 * (i) + 0x10)
@@ -65,6 +66,7 @@ extern const struct nvdimm_security_ops *cxl_security_ops;
 #define   CXL_HDM_DECODER0_CTRL_COMMITTED BIT(10)
 #define   CXL_HDM_DECODER0_CTRL_COMMIT_ERROR BIT(11)
 #define   CXL_HDM_DECODER0_CTRL_HOSTONLY BIT(12)
+#define   CXL_HDM_DECODER0_CTRL_BI BIT(13)
 #define CXL_HDM_DECODER0_TL_LOW(i) (0x20 * (i) + 0x24)
 #define CXL_HDM_DECODER0_TL_HIGH(i) (0x20 * (i) + 0x28)
 #define CXL_HDM_DECODER0_SKIP_LOW(i) CXL_HDM_DECODER0_TL_LOW(i)
@@ -363,8 +365,9 @@ int cxl_dport_map_rcd_linkcap(struct pci_dev *pdev, struct cxl_dport *dport);
 #define CXL_DECODER_F_TYPE2 BIT(2)
 #define CXL_DECODER_F_TYPE3 BIT(3)
 #define CXL_DECODER_F_LOCK  BIT(4)
-#define CXL_DECODER_F_ENABLE    BIT(5)
-#define CXL_DECODER_F_MASK  GENMASK(5, 0)
+#define CXL_DECODER_F_BI    BIT(5)
+#define CXL_DECODER_F_ENABLE    BIT(6)
+#define CXL_DECODER_F_MASK  GENMASK(6, 0)
 
 enum cxl_decoder_type {
 	CXL_DECODER_DEVMEM = 2,
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index cc0a48031fdd..d05ceea29261 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -922,6 +922,7 @@ struct cxl_hdm {
 	unsigned int target_count;
 	unsigned int interleave_mask;
 	unsigned long iw_cap_mask;
+	unsigned int supported_coherency;
 	struct cxl_port *port;
 };
 
diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index eb787dfbd2fa..7f35eb0e8458 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -565,6 +565,7 @@ struct acpi_cedt_cfmws_target_element {
 #define ACPI_CEDT_CFMWS_RESTRICT_VOLATILE   (1<<2)
 #define ACPI_CEDT_CFMWS_RESTRICT_PMEM       (1<<3)
 #define ACPI_CEDT_CFMWS_RESTRICT_FIXED      (1<<4)
+#define ACPI_CEDT_CFMWS_RESTRICT_BI         (1<<5)
 
 /* 2: CXL XOR Interleave Math Structure */
 
-- 
2.39.5

