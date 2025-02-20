Received: from sienna.cherry.relay.mailchannels.net (sienna.cherry.relay.mailchannels.net [23.83.223.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5DD813DDD3
	for <linux-cxl@vger.kernel.org>; Thu, 20 Feb 2025 01:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.223.165
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740015436; cv=pass; b=r1/jf5MWK/bRRoivo2ahmR1HcgpIPOXm0XfylDDMMpU7hEE82zmUbtB+JjrwMODmd4EiIr0p5kORvV6A4QNiU75EbWhsqKYwI/M18s3hoSH3U8Tmu9TZB9TV5fin+vXWbH/5M3qnKmyiK2JNN/SfclWw6rVA8uXNIq/L74gTua8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740015436; c=relaxed/simple;
	bh=oiHRrKGlluql4Dz8RS2LrxPuSLsg4MRxKuAD4UyjqOg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PtgleBrRQI6bJSti23y0T6dPx25A+eBK3IZCB09ufq1gIWQlZUH/4XfbZoJRXWsdhaCgP93wM3/0o4V9a9mGt8s241txcr8AGLboSfNZl2L9jYiGlB964r3z1QPPWMf5q7+sr8Cb2fQv8840+DvT9m50Qz+SDT4wosPlmLMmaL4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=ndzuAZuJ; arc=pass smtp.client-ip=23.83.223.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="ndzuAZuJ"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id E15687807B0;
	Thu, 20 Feb 2025 01:37:07 +0000 (UTC)
Received: from pdx1-sub0-mail-a300.dreamhost.com (100-102-124-192.trex-nlb.outbound.svc.cluster.local [100.102.124.192])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 7498778260A;
	Thu, 20 Feb 2025 01:37:07 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1740015427; a=rsa-sha256;
	cv=none;
	b=IcDOQOBtELYKoQA4uuNxYSTHVx3s/Qd16jBPoVxT0WHvyWIe77uNiukD+jS1qEOkDyw44Q
	z5uxnQcVevJCnFSP5CLAevb7sb7ZxryrRsjSqtapgS9UkDX2lhVhw3aZ61WN359dmejN9f
	zM+xuMRHpfHYtp+Ef2x38rTxVLd0c/0SmYWL5lKLpYXc32JfLH9XsFhNybpH3Yyk4uXIo+
	3Az0rECVthFrwDke87fD3RUqIX2OKD1lGy6jp3HszLAmRFCK3lHFV6notT0cTsgK0MELQL
	Gt12dekKOhJD1Khv78qEzYTTdIhAXvnDjga2YEB4+r4hEHMzA4ceCaYZcwXLTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1740015427;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=8n1f09kplx46bD/CSHMXPdCWSdvZipyzzSILkaeyvJI=;
	b=8sJX5tINYQimiSBqP2a0MEZ5EJUv0a/4ezjLeBT2xmf5XKHfx2yRE4tc+SZU3PU5YXN6Se
	pbKUyYD8zb9MD+tFG7+cA+mnwHnm7o0/WnGZKK3rGAplff8e3yqTw10X8JLeUfsNucQxWb
	7X+w3x1eTXsYVrn5q6xarOzXaoZEWrAOwan6z8O1KzuLnZnxAgtR1UmDDRPzT+FAXiPuj1
	viF5uSrOkG6jGC4UTxr8fAPWvKriSkUt7EB27JM77woud2gg/8Fzx5eu8ZBDG2Wrlfm0yk
	Hjixw9L3LiP4astqh2QEburcDJFILSB22o+pLMA+G658Q5AfTcDaN8yyYclBlw==
ARC-Authentication-Results: i=1;
	rspamd-6d7cc6b78d-bd6dx;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Squirrel-Sponge: 2a3ae1f62a04ff17_1740015427788_439790444
X-MC-Loop-Signature: 1740015427788:3552898818
X-MC-Ingress-Time: 1740015427788
Received: from pdx1-sub0-mail-a300.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.102.124.192 (trex/7.0.2);
	Thu, 20 Feb 2025 01:37:07 +0000
Received: from localhost.localdomain (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a300.dreamhost.com (Postfix) with ESMTPSA id 4Yywq64Zqnz5y;
	Wed, 19 Feb 2025 17:37:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1740015427;
	bh=8n1f09kplx46bD/CSHMXPdCWSdvZipyzzSILkaeyvJI=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=ndzuAZuJGOsisJEfwF8YEYF6UdNHxf6QMzzeXOI22d6trcOI1BIE/JHVyvqD0Hatf
	 W+ZmRslvGoK99H0AiJxkWlWzN55JmIqYp22wBEnAsKVPppGqSt9lCQvjlzFpl4HZil
	 ZedZDYFCVsxOSp1YYz2dLzH34zuTUQaUOAc7IuJeuuiz6rmOTMmKCUUDcxDKKPOHLC
	 yA0uNrUMvGRtt4CjST4iGShXufPAs85NKb53dsRrZz8MfouhGW6y5/6rm8F+QMYMbp
	 5lb+6nxdfMkUAH/cQ3AUMbwhnD7f2hapB/0VsvrwMIkP2RHvlVwdjaKWTzqpYhwcft
	 vHkhbTocmzImQ==
From: Davidlohr Bueso <dave@stgolabs.net>
To: dave.jiang@intel.com,
	dan.j.williams@intel.com
Cc: jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	ira.weiny@intel.com,
	vishal.l.verma@intel.com,
	seven.yi.lee@gmail.com,
	ming.li@zohomail.com,
	a.manzanares@samsung.com,
	fan.ni@samsung.com,
	anisa.su@samsung.com,
	dave@stgolabs.net,
	linux-cxl@vger.kernel.org
Subject: [PATCH 3/4] cxl/pmem: Export dirty shutdown count via sysfs
Date: Wed, 19 Feb 2025 17:36:03 -0800
Message-Id: <20250220013604.263489-4-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250220013604.263489-1-dave@stgolabs.net>
References: <20250220013604.263489-1-dave@stgolabs.net>
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
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 Documentation/ABI/testing/sysfs-bus-cxl       | 12 +++
 Documentation/driver-api/cxl/maturity-map.rst |  2 +-
 drivers/cxl/core/mbox.c                       | 21 +++++
 drivers/cxl/cxl.h                             |  1 +
 drivers/cxl/cxlmem.h                          | 13 +++
 drivers/cxl/pmem.c                            | 79 ++++++++++++++++---
 6 files changed, 118 insertions(+), 10 deletions(-)

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
index 86d13f4a1c18..6bc398182a5d 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -1281,6 +1281,27 @@ int cxl_mem_dpa_fetch(struct cxl_memdev_state *mds, struct cxl_dpa_info *info)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_mem_dpa_fetch, "CXL");
 
+int cxl_get_dirty_count(struct cxl_memdev_state *mds, u32 *count)
+{
+	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
+	struct cxl_mbox_get_health_info_out hi;
+	struct cxl_mbox_cmd mbox_cmd;
+	int rc;
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
index 29f2ab0d5bf6..8bdfa536262e 100644
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
index 6b284962592f..cb039cfc62cb 100644
--- a/drivers/cxl/pmem.c
+++ b/drivers/cxl/pmem.c
@@ -38,19 +38,48 @@ static ssize_t id_show(struct device *dev, struct device_attribute *attr, char *
 	struct cxl_nvdimm *cxl_nvd = nvdimm_provider_data(nvdimm);
 	struct cxl_dev_state *cxlds = cxl_nvd->cxlmd->cxlds;
 
-	return sysfs_emit(buf, "%lld\n", cxlds->serial);
+	return sysfs_emit(buf, "%llu\n", cxlds->serial);
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
 
+#define CXL_INVALID_DIRTY_SHUTDOWN_COUNT ULLONG_MAX
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
+	struct cxl_memdev *cxlmd = cxl_nvd->cxlmd;
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
+	struct device *dev = &cxl_nvd->dev;
+	u32 count;
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
+	if (!cxl_gpf_get_dvsec(cxlds->dev, false))
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

