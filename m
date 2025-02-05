Received: from giraffe.ash.relay.mailchannels.net (giraffe.ash.relay.mailchannels.net [23.83.222.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA5917F7
	for <linux-cxl@vger.kernel.org>; Wed,  5 Feb 2025 04:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.222.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738728947; cv=pass; b=rzQ1fXfOOB3I/rOKmcjTQWaPrNpEE5YTZKoh+Zg+EyISUs2a6RNPjKPcXdbf+ZWUQ6Qf+Ge/Ccaks/xnX3pHM9RNRV2mrP8eEBb06hVJjyc+gNAJin2rBPmaEGZPk07TqfihiSGjjvNrRPO7mdf/i+kdP2/xeY5rkWXyoWCOH6I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738728947; c=relaxed/simple;
	bh=j9RKvBMw7shg6MaOM1BUtFYrx1veyctwAE7n0w6h7L8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SBhQR3RnSN37Ja42e/sQDsXDNPYZoGhTpvqDKuwBrKX/V0L/YhTs86V8mHlyVvAqdR1EcImVO9XciYVenQ7qGucEiavwoRd8EGHX+Oap9Kq4sByJHvH0tBQy5yDVE7bJUbo8T0CqxxqBSKAVEgCQVpUNb1Tw29HTqQ12rt0aQ8s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=g39Hf18A; arc=pass smtp.client-ip=23.83.222.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="g39Hf18A"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id ACA3E8C2E90;
	Wed,  5 Feb 2025 04:08:48 +0000 (UTC)
Received: from pdx1-sub0-mail-a274.dreamhost.com (trex-0.trex.outbound.svc.cluster.local [100.121.114.237])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 4E6368C2DCD;
	Wed,  5 Feb 2025 04:08:48 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1738728528; a=rsa-sha256;
	cv=none;
	b=94sb1fxWfiF8eIM1lLS2r8WrN1L11U0Zh6stQYMOjcztpDI/q4Nsdcmx1cHTIMSQJPbTd9
	wsNt6v95rw79s/7WXoXk8jHes4vJXrTv49m7H8FB1TAtRXn7PDpkJxoir6oF8RUIsR8wFP
	kCZCKyZGXK2PN9GepNSzcJ8bHeEJEk5tu5IxSwTkhIHOLxMMlB2kL5lCTEEpvpzlBQejNr
	6FIPEb0OivQiNliYT+zzUmR/493O9Un8DEChFLRHdb0I7Ulf4oCpdmF7ugH//2/B+/TfMN
	6q4YKmfEScavPBxpgaNULv4ettWe+FbmFl9hhwgHnL/+jkEB/5lhKcy7c2UBmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1738728528;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=Z7YwJhj5MG5x6KgCOV4bl4/xliE5KQ2d8hyfpAm8FnE=;
	b=RPEXqBhLmLw/0SRW0PMYNEHlrkffQP0vkSrffliAOXtB7rUcG7tumjZTZhklUS+LxWq/VG
	IOoYrh0QvTB2q5UjsaXPKhPfDjzb50l8UHMUVYg8vgq7kAADcU7QGM+j/LXXYMXX5d3R03
	fzfejfTv04M7MJMz18h+3+87FdDGloGCVsJptb/wQKjdnC6PA4h8fZS9Yhmml2LWGQCoii
	qOa1CdvA3MT6YR2Xe1uASXWwPSInQMLhmnQrG/rQY/pvt3Z9OsqEqkOOp8qXMOeJMNsljj
	ZnvA44kQPbranNkEzPDWOeV6PEkRfgZkp9tEKJt8AjT3Lrm+4FsNJqjWnqn16A==
ARC-Authentication-Results: i=1;
	rspamd-854f7f575d-l97bm;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Illegal-Irritate: 19d4f55f2df79488_1738728528629_4117093073
X-MC-Loop-Signature: 1738728528629:3615873036
X-MC-Ingress-Time: 1738728528628
Received: from pdx1-sub0-mail-a274.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.121.114.237 (trex/7.0.2);
	Wed, 05 Feb 2025 04:08:48 +0000
Received: from localhost.localdomain (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a274.dreamhost.com (Postfix) with ESMTPSA id 4Ynmv33ZYFzFL;
	Tue,  4 Feb 2025 20:08:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1738728528;
	bh=Z7YwJhj5MG5x6KgCOV4bl4/xliE5KQ2d8hyfpAm8FnE=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=g39Hf18AtAKQoIUyuLMB+aT8zXHQWLGp89aKmKUSwAq6LpqD9QAH9SL1NOXNfuwkr
	 /dnbrqTnmrd5q1eZk0EcUQycrEiQLHn+NlwIdxjPBxdh+BmhbgFwsOFPd7q3x1vU58
	 gm+AdohbgKNhZbojxjgVgylOqmcjbnmGUpZ9N2dwdlEVEdzyyMMZ3WV/idSiesSqHo
	 t46DDPRgy/tgNvlw6UF/9kO8CzZ5nSn2RxMJUaOgOgldX5omPXp7seNfxbhl8MzIkc
	 0tyYAkSOZzjDwzFyo2gQGNq6kb9iTTP/A5vjNxEhNoaeeqRrXbbIdnanVxXCwRdtTD
	 M53OLQ32croFQ==
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
Subject: [PATCH 1/2] cxl/pmem: Export dirty shutdown count via sysfs
Date: Tue,  4 Feb 2025 20:08:41 -0800
Message-Id: <20250205040842.1253616-2-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250205040842.1253616-1-dave@stgolabs.net>
References: <20250205040842.1253616-1-dave@stgolabs.net>
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
 Documentation/ABI/testing/sysfs-bus-cxl       | 12 ++++
 Documentation/driver-api/cxl/maturity-map.rst |  2 +-
 drivers/cxl/core/mbox.c                       | 21 ++++++
 drivers/cxl/core/pci.c                        | 23 +++++++
 drivers/cxl/cxl.h                             |  1 +
 drivers/cxl/cxlmem.h                          | 15 ++++
 drivers/cxl/pmem.c                            | 69 ++++++++++++++++---
 7 files changed, 134 insertions(+), 9 deletions(-)

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
index 4d22bb731177..d03fc7ed76a8 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -1290,6 +1290,27 @@ int cxl_mem_dpa_fetch(struct cxl_memdev_state *mds, struct cxl_dpa_info *info)
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
 int cxl_dirty_shutdown_state(struct cxl_memdev_state *mds)
 {
 	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index a5c65f79db18..bcf05d010a77 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -1141,3 +1141,26 @@ int cxl_gpf_port_setup(struct device *dport_dev, struct cxl_port *port)
 
 	return 0;
 }
+
+int cxl_gpf_device(struct cxl_dev_state *cxlds)
+{
+	int dvsec;
+	struct device *dev = cxlds->dev;
+	struct pci_dev *pdev;
+
+	if (!dev_is_pci(dev))
+		return 0;
+
+	pdev = to_pci_dev(dev);
+	if (!pdev)
+		return -EINVAL;
+
+	dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
+					  CXL_DVSEC_DEVICE_GPF);
+	if (!dvsec) {
+		pci_warn(pdev, "Device GPF DVSEC not present\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 6baec4ba9141..40cc44a18df8 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -542,6 +542,7 @@ struct cxl_nvdimm {
 	struct device dev;
 	struct cxl_memdev *cxlmd;
 	u8 dev_id[CXL_DEV_ID_LEN]; /* for nvdimm, string of 'serial' */
+	long dirty_shutdown;
 };
 
 struct cxl_pmem_region_mapping {
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 536cbe521d16..ee0c93fde50c 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -725,6 +725,18 @@ struct cxl_mbox_set_partition_info {
 
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
@@ -866,6 +878,7 @@ void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
 			    enum cxl_event_log_type type,
 			    enum cxl_event_type event_type,
 			    const uuid_t *uuid, union cxl_event *evt);
+int cxl_get_dirty_count(struct cxl_memdev_state *mds, u32 *count);
 int cxl_dirty_shutdown_state(struct cxl_memdev_state *mds);
 int cxl_set_timestamp(struct cxl_memdev_state *mds);
 int cxl_poison_state_init(struct cxl_memdev_state *mds);
@@ -910,4 +923,6 @@ struct cxl_hdm {
 struct seq_file;
 struct dentry *cxl_debugfs_create_dir(const char *dir);
 void cxl_dpa_debug(struct seq_file *file, struct cxl_dev_state *cxlds);
+
+int cxl_gpf_device(struct cxl_dev_state *cxlds);
 #endif /* __CXL_MEM_H__ */
diff --git a/drivers/cxl/pmem.c b/drivers/cxl/pmem.c
index a39e2c52d7ab..d83ecd568a9c 100644
--- a/drivers/cxl/pmem.c
+++ b/drivers/cxl/pmem.c
@@ -42,15 +42,41 @@ static ssize_t id_show(struct device *dev, struct device_attribute *attr, char *
 }
 static DEVICE_ATTR_RO(id);
 
+static ssize_t dirty_shutdown_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	struct nvdimm *nvdimm = to_nvdimm(dev);
+	struct cxl_nvdimm *cxl_nvd = nvdimm_provider_data(nvdimm);
+
+	return sysfs_emit(buf, "%ld\n", cxl_nvd->dirty_shutdown);
+}
+static DEVICE_ATTR_RO(dirty_shutdown);
+
 static struct attribute *cxl_dimm_attributes[] = {
 	&dev_attr_id.attr,
 	&dev_attr_provider.attr,
+	&dev_attr_dirty_shutdown.attr,
 	NULL
 };
 
+static umode_t cxl_dimm_visible(struct kobject *kobj, struct attribute *a, int n)
+{
+	if (a == &dev_attr_dirty_shutdown.attr) {
+		struct device *dev = kobj_to_dev(kobj);
+		struct nvdimm *nvdimm = to_nvdimm(dev);
+		struct cxl_nvdimm *cxl_nvd = nvdimm_provider_data(nvdimm);
+
+		if (cxl_nvd->dirty_shutdown == -1)
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
@@ -58,6 +84,33 @@ static const struct attribute_group *cxl_dimm_attribute_groups[] = {
 	NULL
 };
 
+static void cxl_nvdimm_setup_dirty_tracking(struct cxl_nvdimm *cxl_nvd)
+{
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
+	cxl_nvd->dirty_shutdown = -1;
+
+	if (cxl_dirty_shutdown_state(mds)) {
+		dev_warn(dev, "GPF: could not dirty shutdown state\n");
+	} else if (!cxl_gpf_device(cxlds)) {
+		u32 count;
+
+		if (!cxl_get_dirty_count(mds, &count))
+			cxl_nvd->dirty_shutdown = count;
+		else
+			dev_warn(dev, "GPF: could not retrieve dirty count\n");
+	}
+}
+
 static int cxl_nvdimm_probe(struct device *dev)
 {
 	struct cxl_nvdimm *cxl_nvd = to_cxl_nvdimm(dev);
@@ -78,20 +131,20 @@ static int cxl_nvdimm_probe(struct device *dev)
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
-	if (cxl_dirty_shutdown_state(mds))
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

