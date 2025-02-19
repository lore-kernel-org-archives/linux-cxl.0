Received: from buffalo.tulip.relay.mailchannels.net (buffalo.tulip.relay.mailchannels.net [23.83.218.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25FA13D891
	for <linux-cxl@vger.kernel.org>; Wed, 19 Feb 2025 02:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739931703; cv=pass; b=sK7Bhr0lClMd9Ejms037BeMnsNeX122kPElP2Mc+5rpjriOnWl/5DsqHQSpHQU8RYYfl8Rv6pTwVTjws6cKR1yZu9/qM7FGakDj+IKcyF1qkCnnwHTIC1dBOlZcTTfsBk/bWKTVeXS5LCGNTUK/w0wzE65N7AxnX0FPZDMQh3TQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739931703; c=relaxed/simple;
	bh=+oKYpYeskCIOuoTNjl4mEHbQhFV4bR4UNnsB2L3pJPU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BZ/TBnZ13nyD9zQAnaTzz1MZjqOSm0evcQfTypUa7ushcZowxvl2jyAlbPT2Frmt5bRCFXl8Kf8sVTrWKMRCLHwPqrsr4pUYjrSa7pp+eDllBt3ZuMwkUV6Ac6Vc+EEpZYbja9LEC/o5Yt4HP9ixFvK8PGrVQfb/mmYo9+RKJHo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=SINM9YXZ; arc=pass smtp.client-ip=23.83.218.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="SINM9YXZ"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 82A023237DA;
	Wed, 19 Feb 2025 02:15:27 +0000 (UTC)
Received: from pdx1-sub0-mail-a289.dreamhost.com (100-97-28-76.trex-nlb.outbound.svc.cluster.local [100.97.28.76])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id ED08C3237C8;
	Wed, 19 Feb 2025 02:15:26 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1739931327; a=rsa-sha256;
	cv=none;
	b=3W82JhFvCNTDauYFQJUiWRtyeQo99mnhGZ/54t1aKoDiUKRTDPNfDvF8ZHYBx19JgOufVK
	i7bK49yDNGaffZfoXms2WJtxBFVgeMMXka/3cyLeu2+wV+f066UiqsZ4IJpbkyv+PYDLgB
	7QbBnS0z3nPaAP5UxGxgvV2FF+wJqojJc3g1FymgS5+jpczRNF1PFJU8Jc/N6ow7UwnJp1
	ripZT4lonr1LlbCY8IqMLtfJVUKgznxSLQ687mh1NAM2V6HJ0BNKbu6rYhI6aptGXvm56W
	AffVMqM/g8LlfY4G73fkT4p3Mb18H0HA6Lzh7t64C5OWs0SDzZkEYiqr6W0jpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1739931327;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=LMiOV8BzkEt1/KVWd+8I2LYqo3tW59KwTqB2FxFJVlA=;
	b=70tuEZv7rdW+2EYM3ET4w1PdZMTD/fShZk8AcM0IqDk3KwjNl0qxRfqt0IUyuzZCJFF/4V
	LAj8ghv8aPd2AOcK8fHLP854yHvHxgqN1kzoDyjYddIPj1Z/eludKTTiVxy86vAe5BIJeD
	Lp0JTwDcsGQ/2dOAUJ+ptEmhM12LQAMwiIRPeVfWAdJ/lPHRgNeYRMGKIyzMhvgnqexJby
	EaBnC3+cCUZFC6cpOKZlP8NsPGQmYJPxyrd6isydf7ABAX/OjMpBuPEr1EohU8av8dAaJL
	cgXA6n8AvE3j4djHbcSi5B0+FQlxv3b8aoFLnqqh4tanbhZOjvdjh4p2sJVhpA==
ARC-Authentication-Results: i=1;
	rspamd-6d7cc6b78d-cf5kg;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Sponge-Spicy: 45b6282321f19e66_1739931327418_2387960209
X-MC-Loop-Signature: 1739931327418:85110216
X-MC-Ingress-Time: 1739931327418
Received: from pdx1-sub0-mail-a289.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.97.28.76 (trex/7.0.2);
	Wed, 19 Feb 2025 02:15:27 +0000
Received: from localhost.localdomain (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a289.dreamhost.com (Postfix) with ESMTPSA id 4YyKjn67YrzBP;
	Tue, 18 Feb 2025 18:15:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1739931326;
	bh=LMiOV8BzkEt1/KVWd+8I2LYqo3tW59KwTqB2FxFJVlA=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=SINM9YXZLX9NCWK1OnMoYugjWIHN9po9aYttbRXiE3hG2D68IoMdoPiq4+as1fWNz
	 6XvaN/sftX+q9Z2KCUajEKWNlgOupm1Ag/2PAbv9CkLCgL5xd3qkKEBj05TenNTNHM
	 FMFK6KsMPAn/quPGAdY14fvNrUDC3uDNBtqfxgDIPW6xJet7sx5+jfPVkOjb1QcJ+H
	 1ISblH62J9qUVcvd4WgYF/DILiNX2nYyF0yZBIlgvH6OneANQvZaaWYOfba+UldLqt
	 vIxVxgBzrROI+3DnnaRJoq6i0UY+vEOkZYwcg7ZllhgdcbWinGFVxfJNzxsentFfIT
	 6q/TvVnleC0uA==
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
Date: Tue, 18 Feb 2025 18:14:19 -0800
Message-Id: <20250219021420.214991-4-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250219021420.214991-1-dave@stgolabs.net>
References: <20250219021420.214991-1-dave@stgolabs.net>
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
 drivers/cxl/cxlmem.h                          | 15 ++++
 drivers/cxl/pmem.c                            | 77 +++++++++++++++++--
 6 files changed, 119 insertions(+), 9 deletions(-)

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
index 6d60030139df..03ad3c8ba88d 100644
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
@@ -866,4 +879,6 @@ struct cxl_hdm {
 struct seq_file;
 struct dentry *cxl_debugfs_create_dir(const char *dir);
 void cxl_dpa_debug(struct seq_file *file, struct cxl_dev_state *cxlds);
+
+int cxl_gpf_device(struct cxl_dev_state *cxlds);
 #endif /* __CXL_MEM_H__ */
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

