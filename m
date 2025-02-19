Received: from rusty.tulip.relay.mailchannels.net (rusty.tulip.relay.mailchannels.net [23.83.218.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7667F22F11
	for <linux-cxl@vger.kernel.org>; Wed, 19 Feb 2025 06:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.252
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739947526; cv=pass; b=DwHBeYCtF6vT3c4f975KpWmeIsyt+MAPHpmmTCI62mrWLFVJ5moBGdjNT18XaKP3EMV80kDXpzdXiD9j/DOoA7FJiq5W8wZpddNr7V1brltMY+sdUFVW1TWUnwQINYGUWhmWuc0afJZK8Vrt5eDuMKRQVuJO+yKMMKwyqzWZCVE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739947526; c=relaxed/simple;
	bh=Yo1mVlU60uv+OVSWS6/nBok9v35JRuSKnH0W3ZYbMd4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HEf8LY9wPQu3wot+ZhusOniwMfoTuLpttlev8VOygOCEuFSyXp36ppiQIReNV02XQG1Zrn3zExYEzyy+DxsRd9RCKJSrPzdi78GVYJuQzLPrMN39vuACz0kwLew5olbYyZ2I+toM550evG53Sk8/Z6B8/S3y/L+tCy57lYyGYso=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=mUppwMCp; arc=pass smtp.client-ip=23.83.218.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="mUppwMCp"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 5302878320B;
	Wed, 19 Feb 2025 06:29:14 +0000 (UTC)
Received: from pdx1-sub0-mail-a223.dreamhost.com (100-100-209-197.trex-nlb.outbound.svc.cluster.local [100.100.209.197])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id DFFCE782DDE;
	Wed, 19 Feb 2025 06:29:13 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1739946554; a=rsa-sha256;
	cv=none;
	b=1VwZhstJzQH710zzH4mGbA5GLoMzDg2GuXf4AGq1xzQrAdgMf++drKRiMLQQB9AIj9XyeS
	0TBQGGiUDs+VWK/QjyOzWbLhEB2qqFZZxFJmu+SZX05GlQ7UIBMpZnBebZ122SdiWr89Be
	yPPzciqneepdN4jgwPMmvkRMZ9SmzAjcj9T2fN88ekmTphgS2lC3Uf5isi4ZG9aU09fuu1
	WL2DQaKPCjt760Xp7bqSWypyaXonWFlBS0jFoOX6e98QEOq8cJJb4Ba5dAXQHo8bNiObbP
	7ukBU5mn4Sfx/dVuzJZjOBxSYv/o5OugOjIr3UX2fovcVa03u6FLsMML0J0oDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1739946554;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=Ep+VlKhuM20wFLB3UUjQe5uf8/ZbfbDSIIG3I14++ds=;
	b=Sbh3biV0bmMxWqHqEGuQpwnzwB8rQ/EDb+cqhvQxrMmaKN8YXq4yndQkBE/FdrGbaHYncD
	apufNqcWYivkKmew8XfLsegVR36GjCGxarBuLgxHrn1Ll+n9r69hfSmXwhj+lFq4Z15JOv
	c+yJxBRRz3DJGbjUExeC0GHbdG3mermmXlm8ya9PMXbOCo9gj8BoggEF2egF8OfN8oe0eN
	uy7k/S8BYnV4dzgqFT2qwUvWpoAMrkEtp8ex9CIUBt9tZhaKmHvtk6hGNPoA5oAg+noXS3
	0OuZgJ/1rMaFbA4EDsU2vc7v//M5/hKct9u4jg9JDIBNmTlTBw1AevsUnv0wIg==
ARC-Authentication-Results: i=1;
	rspamd-6d7cc6b78d-bq9x4;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Industry-Shade: 69e0452a42d8eec6_1739946554226_4176659332
X-MC-Loop-Signature: 1739946554226:3279060998
X-MC-Ingress-Time: 1739946554226
Received: from pdx1-sub0-mail-a223.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.100.209.197 (trex/7.0.2);
	Wed, 19 Feb 2025 06:29:14 +0000
Received: from localhost.localdomain (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a223.dreamhost.com (Postfix) with ESMTPSA id 4YyRLc6vskzFh;
	Tue, 18 Feb 2025 22:29:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1739946553;
	bh=Ep+VlKhuM20wFLB3UUjQe5uf8/ZbfbDSIIG3I14++ds=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=mUppwMCp3sJ9apGsZL0/LpocG2QIdZ5T1hBye7U9H37WD3Xf/GWc6dTX2SuViebuM
	 HA6PeXi9R9YSlZs6L1dxquG7CcVIkUMNv/KnkIBx2gXVM4f1PluHmwZKQcTvFVzckf
	 APqDGpKk5oO3hJ1zkdUCaLIvA+D4ugkM4c9cXjflcyQmxBZJ/3XmVyIqkM/0J7F5df
	 /J+INMegSvbS4584C3V1DlJ1DgA7RLcixF2eeTL+EiyJ37uIvnP4ZbYc5Jv97Byz6z
	 sudac8mEMtJV0jv0yQc4naZE3avk8tnkANiCWf4hvJqAd2/jszqsMcRjZQ2w2xa7b5
	 qnzfPMM6gfryg==
From: Davidlohr Bueso <dave@stgolabs.net>
To: dave.jiang@intel.com,
	dan.j.williams@intel.com
Cc: jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	ira.weiny@intel.com,
	vishal.l.verma@intel.com,
	seven.yi.lee@gmail.com,
	a.manzanares@samsung.com,
	fan.ni@samsung.com,
	anisa.su@samsung.com,
	dave@stgolabs.net,
	linux-cxl@vger.kernel.org
Subject: [PATCH 3/4] cxl/pmem: Export dirty shutdown count via sysfs
Date: Tue, 18 Feb 2025 22:28:31 -0800
Message-Id: <20250219062832.237881-4-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250219062832.237881-1-dave@stgolabs.net>
References: <20250219062832.237881-1-dave@stgolabs.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Similar to how the acpi_nfit driver exports Optane dirty shutdown count,
introduce:

  /sys/bus/cxl/devices/nvdimm-bridge0/ndbusX/nmemY/cxl/dirty_shutdown

Under the conditions that 1) dirty shutdown can be set, 2) Device GPF
DVSEC exists, and 3) the count itself can be retrieved.

Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 Documentation/ABI/testing/sysfs-bus-cxl       | 12 +++
 Documentation/driver-api/cxl/maturity-map.rst |  2 +-
 drivers/cxl/core/mbox.c                       | 21 +++++
 drivers/cxl/cxl.h                             |  1 +
 drivers/cxl/cxlmem.h                          | 13 ++++
 drivers/cxl/pmem.c                            | 77 +++++++++++++++++--
 6 files changed, 117 insertions(+), 9 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
index 3f5627a1210a..a7491d214098 100644
--- a/Documentation/ABI/testing/sysfs-bus-cxl
+++ b/Documentation/ABI/testing/sysfs-bus-cxl
@@ -586,3 +586,15 @@ Description:
 		See Documentation/ABI/stable/sysfs-devices-node. access0 provides
 		the number to the closest initiator and access1 provides the
 		number to the closest CPU.
+
+
+What:		/sys/bus/cxl/devices/nvdimm-bridge0/ndbusX/nmemY/cxl/dirty_shutdown
+Date:		Feb, 2025
+KernelVersion:	v6.15
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(RO) The device dirty shutdown count value, which is the number
+		of times the device could have incurred in potential data loss.
+		The count is persistent across power loss and wraps back to 0
+		upon overflow. If this file is not present, the device does not
+		have the necessary support for dirty tracking.
diff --git a/Documentation/driver-api/cxl/maturity-map.rst b/Documentation/driver-api/cxl/maturity-map.rst
index 99dd2c841e69..a2288f9df658 100644
--- a/Documentation/driver-api/cxl/maturity-map.rst
+++ b/Documentation/driver-api/cxl/maturity-map.rst
@@ -130,7 +130,7 @@ Mailbox commands
 * [0] Switch CCI
 * [3] Timestamp
 * [1] PMEM labels
-* [1] PMEM GPF / Dirty Shutdown
+* [3] PMEM GPF / Dirty Shutdown
 * [0] Scan Media
 
 PMU
diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 86d13f4a1c18..f1009a265f9d 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -1281,6 +1281,27 @@ int cxl_mem_dpa_fetch(struct cxl_memdev_state *mds, struct cxl_dpa_info *info)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_mem_dpa_fetch, "CXL");
 
+int cxl_get_dirty_count(struct cxl_memdev_state *mds, u32 *count)
+{
+	int rc;
+	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
+	struct cxl_mbox_cmd mbox_cmd;
+	struct cxl_mbox_get_health_info_out hi;
+
+	mbox_cmd = (struct cxl_mbox_cmd) {
+		.opcode = CXL_MBOX_OP_GET_HEALTH_INFO,
+		.size_out = sizeof(hi),
+		.payload_out = &hi,
+	};
+
+	rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
+	if (!rc)
+		*count = le32_to_cpu(hi.dirty_shutdown_cnt);
+
+	return rc;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_get_dirty_count, "CXL");
+
 int cxl_arm_dirty_shutdown(struct cxl_memdev_state *mds)
 {
 	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index acbbba41356d..4dbf1cc60047 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -542,6 +542,7 @@ struct cxl_nvdimm {
 	struct device dev;
 	struct cxl_memdev *cxlmd;
 	u8 dev_id[CXL_DEV_ID_LEN]; /* for nvdimm, string of 'serial' */
+	u64 dirty_shutdowns;
 };
 
 struct cxl_pmem_region_mapping {
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 6d60030139df..3b6ef9e936c3 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -681,6 +681,18 @@ struct cxl_mbox_set_partition_info {
 
 #define  CXL_SET_PARTITION_IMMEDIATE_FLAG	BIT(0)
 
+/* Get Health Info Output Payload CXL 3.2 Spec 8.2.10.9.3.1 Table 8-148 */
+struct cxl_mbox_get_health_info_out {
+	u8 health_status;
+	u8 media_status;
+	u8 additional_status;
+	u8 life_used;
+	__le16 device_temperature;
+	__le32 dirty_shutdown_cnt;
+	__le32 corrected_volatile_error_cnt;
+	__le32 corrected_persistent_error_cnt;
+} __packed;
+
 /* Set Shutdown State Input Payload CXL 3.2 Spec 8.2.10.9.3.5 Table 8-152 */
 struct cxl_mbox_set_shutdown_state_in {
 	u8 state;
@@ -822,6 +834,7 @@ void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
 			    enum cxl_event_log_type type,
 			    enum cxl_event_type event_type,
 			    const uuid_t *uuid, union cxl_event *evt);
+int cxl_get_dirty_count(struct cxl_memdev_state *mds, u32 *count);
 int cxl_arm_dirty_shutdown(struct cxl_memdev_state *mds);
 int cxl_set_timestamp(struct cxl_memdev_state *mds);
 int cxl_poison_state_init(struct cxl_memdev_state *mds);
diff --git a/drivers/cxl/pmem.c b/drivers/cxl/pmem.c
index 6b284962592f..aee1afe9d287 100644
--- a/drivers/cxl/pmem.c
+++ b/drivers/cxl/pmem.c
@@ -42,15 +42,44 @@ static ssize_t id_show(struct device *dev, struct device_attribute *attr, char *
 }
 static DEVICE_ATTR_RO(id);
 
+static ssize_t dirty_shutdown_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	struct nvdimm *nvdimm = to_nvdimm(dev);
+	struct cxl_nvdimm *cxl_nvd = nvdimm_provider_data(nvdimm);
+
+	return sysfs_emit(buf, "%lld\n", cxl_nvd->dirty_shutdowns);
+}
+static DEVICE_ATTR_RO(dirty_shutdown);
+
 static struct attribute *cxl_dimm_attributes[] = {
 	&dev_attr_id.attr,
 	&dev_attr_provider.attr,
+	&dev_attr_dirty_shutdown.attr,
 	NULL
 };
 
+#define CXL_INVALID_DIRTY_SHUTDOWN_COUNT -1
+static umode_t cxl_dimm_visible(struct kobject *kobj,
+				struct attribute *a, int n)
+{
+	if (a == &dev_attr_dirty_shutdown.attr) {
+		struct device *dev = kobj_to_dev(kobj);
+		struct nvdimm *nvdimm = to_nvdimm(dev);
+		struct cxl_nvdimm *cxl_nvd = nvdimm_provider_data(nvdimm);
+
+		if (cxl_nvd->dirty_shutdowns ==
+		    CXL_INVALID_DIRTY_SHUTDOWN_COUNT)
+			return 0;
+	}
+
+	return a->mode;
+}
+
 static const struct attribute_group cxl_dimm_attribute_group = {
 	.name = "cxl",
 	.attrs = cxl_dimm_attributes,
+	.is_visible = cxl_dimm_visible
 };
 
 static const struct attribute_group *cxl_dimm_attribute_groups[] = {
@@ -58,6 +87,38 @@ static const struct attribute_group *cxl_dimm_attribute_groups[] = {
 	NULL
 };
 
+static void cxl_nvdimm_setup_dirty_tracking(struct cxl_nvdimm *cxl_nvd)
+{
+	u32 count;
+	struct cxl_memdev *cxlmd = cxl_nvd->cxlmd;
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
+	struct device *dev = &cxl_nvd->dev;
+
+	/*
+	 * Dirty tracking is enabled and exposed to the user, only when:
+	 *   - dirty shutdown on the device can be set, and,
+	 *   - the device has a Device GPF DVSEC (albeit unused), and,
+	 *   - the Get Health Info cmd can retrieve the device's dirty count.
+	 */
+	cxl_nvd->dirty_shutdowns = CXL_INVALID_DIRTY_SHUTDOWN_COUNT;
+
+	if (cxl_arm_dirty_shutdown(mds)) {
+		dev_warn(dev, "GPF: could not set dirty shutdown state\n");
+		return;
+	}
+
+	if (cxl_gpf_get_dvsec(cxlds->dev, false) <= 0)
+		return;
+
+	if (cxl_get_dirty_count(mds, &count)) {
+		dev_warn(dev, "GPF: could not retrieve dirty count\n");
+		return;
+	}
+
+	cxl_nvd->dirty_shutdowns = count;
+}
+
 static int cxl_nvdimm_probe(struct device *dev)
 {
 	struct cxl_nvdimm *cxl_nvd = to_cxl_nvdimm(dev);
@@ -78,20 +139,20 @@ static int cxl_nvdimm_probe(struct device *dev)
 	set_bit(ND_CMD_GET_CONFIG_SIZE, &cmd_mask);
 	set_bit(ND_CMD_GET_CONFIG_DATA, &cmd_mask);
 	set_bit(ND_CMD_SET_CONFIG_DATA, &cmd_mask);
-	nvdimm = __nvdimm_create(cxl_nvb->nvdimm_bus, cxl_nvd,
-				 cxl_dimm_attribute_groups, flags,
-				 cmd_mask, 0, NULL, cxl_nvd->dev_id,
-				 cxl_security_ops, NULL);
-	if (!nvdimm)
-		return -ENOMEM;
 
 	/*
 	 * Set dirty shutdown now, with the expectation that the device
 	 * clear it upon a successful GPF flow. The exception to this
 	 * is upon Viral detection, per CXL 3.2 section 12.4.2.
 	 */
-	if (cxl_arm_dirty_shutdown(mds))
-		dev_warn(dev, "GPF: could not dirty shutdown state\n");
+	cxl_nvdimm_setup_dirty_tracking(cxl_nvd);
+
+	nvdimm = __nvdimm_create(cxl_nvb->nvdimm_bus, cxl_nvd,
+				 cxl_dimm_attribute_groups, flags,
+				 cmd_mask, 0, NULL, cxl_nvd->dev_id,
+				 cxl_security_ops, NULL);
+	if (!nvdimm)
+		return -ENOMEM;
 
 	dev_set_drvdata(dev, nvdimm);
 	return devm_add_action_or_reset(dev, unregister_nvdimm, nvdimm);
-- 
2.39.5

