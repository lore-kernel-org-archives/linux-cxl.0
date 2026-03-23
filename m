Received: from glass.ash.relay.mailchannels.net (glass.ash.relay.mailchannels.net [23.83.222.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D003CCFC3
	for <linux-cxl@vger.kernel.org>; Mon, 23 Mar 2026 20:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.222.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774298437; cv=pass; b=HgM4EepyMtA2/MSRLdGlV+UcKTL8ERibXwgzd8atQvxHQlG+4YONJVJ9RKHJHS4ptRdilSwcRsso75xriJPlsXqNwyON5cOxVUtbtrBLNQcr9KARrnUQ+FYi02ZfDE93W+hDMWLv9CyINihL8TgtSHD1vuhf1LlcGGwkQIb5q7M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774298437; c=relaxed/simple;
	bh=YCAo0K1fRnIFn0fZP4B+fEfU75+dZ/vVw2UzluRGqJA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lwxIEsHPxge9tvQe9RiWp3wvlFZsgigsxb/U2yFJ7egnPYap45srbSPUa98AunFns8aYToPE1R5CWZfdUzAFf7RRl7zCiKAcisxW8RZpSjWGgF73CNPXB5D0TUAQ1s+g9RjFmXsMuvea5Lb8xMccE4awbTsfyyxhYlclwwely0E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=aottw5Cu; arc=pass smtp.client-ip=23.83.222.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="aottw5Cu"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 0991B8A2969;
	Mon, 23 Mar 2026 20:40:28 +0000 (UTC)
Received: from pdx1-sub0-mail-a255.dreamhost.com (trex-green-5.trex.outbound.svc.cluster.local [100.115.97.34])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id A8EB48A27C6;
	Mon, 23 Mar 2026 20:40:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1774298427;
	b=2tKzfgOZYIMgaSw/Iq/r95YbHocdpfzsNQb9RM+gJTb9MXD5c6tWNNSFp6auVZ/jytMLXC
	BoO/g/nGSs6W2S4HCJS5MG3RbTSLpJ0qLqzUYaea+7R+r46CbJJGdATWVAdBJaa27J52Af
	WVhLZaM9xa48DaHaW5i4aRZwgK5NDnuuCBnkUCAeq1CKfXw+jnepGYxbY3TQQzADoHAbg9
	k+wxiQvJXkbcdTzxNoq5ZYVpIIaahyfRoqS+U3OXoRB+NNYKAjHVeQ2Q4735ZqZzn/fjBF
	+CEmb636+HygI5rgANIHHwrH1PB9dFN0DVGg6xJ9vvKMFeSWzWc2lrWoeyYttA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1774298427;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=lK8N7m2ZNpmuFWBkYQBCzx+BklQVUL0puLZJSw0AN1I=;
	b=cKPCdEWT2OMnZlgG5dhE1codokz0M69k9gV23cKdImAAKIx1GwsSA071L7SAZBQYHb7rDe
	n/4OGATqXiO4xjjpLJcHsXKd/Lh42GOzAj4rKaLOOBY+C7f/GsSi3s1jebkAuRJ8d6HtqG
	luIobUferP5W9viiYC5JAxiCvF7+808yGV2SkO+OA3yR840edj++Ge+PVHobdrR4DwjWFa
	Y1BgIAjecsaIVjztOAMe5vpJKM9WHDKOPyCfhVHIFa6VcJJtEe7JIvO50ZAOmfbyOJNNEg
	v59yAgh21FNLxGPzykIRTAxMASRI+hFCD6BotAXFnP6m83m7Wu4Z1bADldNmLA==
ARC-Authentication-Results: i=1;
	rspamd-7f98bb5847-fbmn8;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Continue-Soft: 41e42eb8345f0fa5_1774298427963_960283930
X-MC-Loop-Signature: 1774298427963:1125849712
X-MC-Ingress-Time: 1774298427962
Received: from pdx1-sub0-mail-a255.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.115.97.34 (trex/7.1.5);
	Mon, 23 Mar 2026 20:40:27 +0000
Received: from offworld.lan (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a255.dreamhost.com (Postfix) with ESMTPSA id 4fflRZ6ytxz1070;
	Mon, 23 Mar 2026 13:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1774298427;
	bh=lK8N7m2ZNpmuFWBkYQBCzx+BklQVUL0puLZJSw0AN1I=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=aottw5CuaN14kRMgT5gG5P2grpcEKO8x8qsv+FBIUQEmMcsHlbcsCmPD4Boz5HC64
	 Fw3KWVwg+4SHiJRpIz45ls04f/MiZhnWAV2hH54/d0qzsXcMFup52ROY22Eq6Uizn9
	 eBRjKqoVkcwXEEt+JP1ZVAQdVStz4JXikIuaJTzFXw+BQ9EKHRw34Qx3nO5VK/yOjL
	 U9tvRw6XRSEEQOEB85VN42tB3CJhQrAb9BMo/F6cm0INxjLiv5N5Ig//MDisVA4bdy
	 yaTdFLSS68ZDUCQdUNlA8f4O/VJjoVwsJghw+cAgSqh/XSWmIemvkw/GzfaenQV9Lo
	 CAS+ZBlKODqvA==
From: Davidlohr Bueso <dave@stgolabs.net>
To: dave.jiang@intel.com
Cc: jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	dongjoo.seo1@samsung.com,
	anisa.su@samsung.com,
	linux-cxl@vger.kernel.org,
	dave@stgolabs.net
Subject: [PATCH 1/1] cxl/mbox: Support Media Operation
Date: Mon, 23 Mar 2026 13:40:13 -0700
Message-Id: <20260323204013.4010634-2-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260323204013.4010634-1-dave@stgolabs.net>
References: <20260323204013.4010634-1-dave@stgolabs.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for the Media Operation command (opcode 4402h) which
enables targeted sanitize and zero operations on specific DPA
ranges, as defined in CXL 4.0 Section 8.2.10.9.5.3.

Run Discovery during probe to learn the device's DPA range granularity
and which operations are supported, and expose to sysfs accordingly:

  o 'security/sanitize' is multiplexed to allow single ranged input.
  o 'security/zero' is added, also with single ranged input.

Operations are only allowed on DPA ranges that do not overlap any
hardware-committed endpoint decoder to ensure not corrupting active
mappings. Background operations are handled synchronously.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 Documentation/ABI/testing/sysfs-bus-cxl |  31 +++-
 drivers/cxl/core/mbox.c                 | 235 ++++++++++++++++++++++++
 drivers/cxl/core/memdev.c               |  45 ++++-
 drivers/cxl/cxlmem.h                    |  59 ++++++
 drivers/cxl/pci.c                       |   4 +
 5 files changed, 369 insertions(+), 5 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
index c80a1b5a03db..da8f8dc92a5a 100644
--- a/Documentation/ABI/testing/sysfs-bus-cxl
+++ b/Documentation/ABI/testing/sysfs-bus-cxl
@@ -117,10 +117,12 @@ Contact:	linux-cxl@vger.kernel.org
 Description:
 		(RO) Reading this file will display the CXL security state for
 		that device. Such states can be: 'disabled', 'sanitize', when
-		a sanitization is currently underway; or those available only
-		for persistent memory: 'locked', 'unlocked' or 'frozen'. This
-		sysfs entry is select/poll capable from userspace to notify
-		upon completion of a sanitize operation.
+		a whole-device sanitization is currently underway; or those
+		available only for persistent memory: 'locked', 'unlocked' or
+		'frozen'. This sysfs entry is select/poll capable from
+		userspace to notify upon completion of a sanitize operation.
+		Targeted range sanitize via Media Operation does not affect
+		this state as it completes synchronously.
 
 
 What:           /sys/bus/cxl/devices/memX/security/sanitize
@@ -141,6 +143,13 @@ Description:
 		states. If this file is not present, then there is no hardware
 		support for the operation.
 
+		If the device supports the Media Operation command with the
+		sanitize operation, a DPA range may be written as 'start
+		length' in bytes to sanitize a targeted region of media.
+		The start address and length must be aligned to the device's
+		media operation granularity. The sanitize method applied to
+		the range is the same as for whole-device sanitize.
+
 
 What            /sys/bus/cxl/devices/memX/security/erase
 Date:           June, 2023
@@ -158,6 +167,20 @@ Description:
 		support for the operation.
 
 
+What:		/sys/bus/cxl/devices/memX/security/zero
+Date:		March, 2026
+KernelVersion:	v7.1
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(WO) Write a DPA range as 'start length' in bytes to this
+		attribute to zero a specific region of device media via the
+		Media Operation command. After completion, reads from the
+		specified range will return zero. The start address and
+		length must be aligned to the device's media operation
+		granularity. If this file is not present, then the device
+		does not support the Media Operation zero command.
+
+
 What:		/sys/bus/cxl/devices/memX/firmware/
 Date:		April, 2023
 KernelVersion:	v6.5
diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index aaa5c6277ebf..b7047cb9abed 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -160,6 +160,10 @@ static void cxl_set_security_cmd_enabled(struct cxl_security_state *security,
 		set_bit(CXL_SEC_ENABLED_PASSPHRASE_SECURE_ERASE,
 			security->enabled_cmds);
 		break;
+	case CXL_MBOX_OP_MEDIA_OPERATION:
+		set_bit(CXL_SEC_ENABLED_MEDIA_OPERATIONS,
+			security->enabled_cmds);
+		break;
 	default:
 		break;
 	}
@@ -893,6 +897,102 @@ int cxl_enumerate_cmds(struct cxl_memdev_state *mds)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_enumerate_cmds, "CXL");
 
+/**
+ * cxl_media_op_discover() - Discover supported media operation
+ * @mds: The device data for the operation
+ *
+ * Discover any available Media Operations.
+ *
+ * Return: 0 on success or if Media Operation is not supported,
+ * negative error code on failure.
+ */
+#define CXL_MEDIA_OP_MAX_OPS 2
+
+int cxl_media_op_discover(struct cxl_memdev_state *mds)
+{
+	size_t out_size, in_size;
+	void *payload_in;
+	struct cxl_mbox_cmd mbox_cmd;
+	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
+	struct cxl_mbox_media_op_input *payload;
+	struct cxl_mbox_media_op_discovery_args *args;
+	struct cxl_mbox_media_op_discovery_out *disc_out;
+	int rc, i;
+	u16 num_returned;
+
+	if (!test_bit(CXL_SEC_ENABLED_MEDIA_OPERATIONS,
+		      mds->security.enabled_cmds))
+		return 0;
+
+	in_size = sizeof(*payload) + sizeof(*args);
+	payload_in = kzalloc(in_size, GFP_KERNEL);
+	if (!payload_in)
+		return -ENOMEM;
+
+	payload = payload_in;
+	payload->class = CXL_MEDIA_OP_CLASS_GENERAL;
+	payload->subclass = CXL_MEDIA_OP_SUBCLASS_DISCOVERY;
+	payload->dpa_range_count = 0;
+
+	args = payload_in + sizeof(*payload);
+	args->start_index = 0;
+	args->num_ops = cpu_to_le16(CXL_MEDIA_OP_MAX_OPS);
+
+	out_size = sizeof(*disc_out) +
+		   CXL_MEDIA_OP_MAX_OPS * sizeof(disc_out->ops[0]);
+	disc_out = kzalloc(out_size, GFP_KERNEL);
+	if (!disc_out) {
+		kfree(payload_in);
+		return -ENOMEM;
+	}
+
+	mbox_cmd = (struct cxl_mbox_cmd) {
+		.opcode = CXL_MBOX_OP_MEDIA_OPERATION,
+		.payload_in = payload_in,
+		.size_in = in_size,
+		.payload_out = disc_out,
+		.size_out = out_size,
+		.min_out = sizeof(*disc_out),
+		.poll_count = 1,
+		.poll_interval_ms = 1000,
+	};
+
+	rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
+	if (rc < 0) {
+		dev_dbg(cxl_mbox->host,
+			"Media Operation Discovery failed: %d\n", rc);
+		goto out;
+	}
+
+	mds->media_op.granularity = le64_to_cpu(disc_out->granularity);
+	num_returned = min_t(u16, le16_to_cpu(disc_out->num_returned),
+			     CXL_MEDIA_OP_MAX_OPS);
+
+	for (i = 0; i < num_returned; i++) {
+		u8 cls = disc_out->ops[i].class;
+		u8 sub = disc_out->ops[i].subclass;
+
+		if (cls == CXL_MEDIA_OP_CLASS_SANITIZE &&
+		    sub == CXL_MEDIA_OP_SUBCLASS_SANITIZE)
+			mds->media_op.sanitize_supported = true;
+		if (cls == CXL_MEDIA_OP_CLASS_SANITIZE &&
+		    sub == CXL_MEDIA_OP_SUBCLASS_ZERO)
+			mds->media_op.zero_supported = true;
+	}
+
+	dev_dbg(cxl_mbox->host,
+		"Media Operation: granularity=%llu sanitize=%d zero=%d\n",
+		mds->media_op.granularity,
+		mds->media_op.sanitize_supported,
+		mds->media_op.zero_supported);
+
+out:
+	kfree(disc_out);
+	kfree(payload_in);
+	return rc;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_media_op_discover, "CXL");
+
 void cxl_event_trace_record(struct cxl_memdev *cxlmd,
 			    enum cxl_event_log_type type,
 			    enum cxl_event_type event_type,
@@ -1308,6 +1408,141 @@ int cxl_mem_sanitize(struct cxl_memdev *cxlmd, u16 cmd)
 	return -EBUSY;
 }
 
+static int __cxl_mem_media_op(struct cxl_memdev_state *mds, u8 class,
+			      u8 subclass, u64 dpa_start, u64 dpa_length)
+{
+	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
+	struct cxl_mbox_media_op_input *payload;
+	struct cxl_mbox_cmd mbox_cmd;
+	u64 granularity;
+	size_t size;
+	int rc;
+
+	if (!test_bit(CXL_SEC_ENABLED_MEDIA_OPERATIONS,
+		      mds->security.enabled_cmds))
+		return -EOPNOTSUPP;
+
+	/* ensure the specific operation was reported by Discovery */
+	if (class == CXL_MEDIA_OP_CLASS_SANITIZE &&
+	    subclass == CXL_MEDIA_OP_SUBCLASS_SANITIZE &&
+	    !mds->media_op.sanitize_supported)
+		return -EOPNOTSUPP;
+	if (class == CXL_MEDIA_OP_CLASS_SANITIZE &&
+	    subclass == CXL_MEDIA_OP_SUBCLASS_ZERO &&
+	    !mds->media_op.zero_supported)
+		return -EOPNOTSUPP;
+
+	granularity = mds->media_op.granularity;
+	if (!granularity)
+		return -EINVAL;
+
+	if (!IS_ALIGNED(dpa_start, granularity) ||
+	    !IS_ALIGNED(dpa_length, granularity) ||
+	    dpa_length == 0) {
+		dev_dbg(cxl_mbox->host,
+			"DPA range not aligned to %llu-byte granularity\n",
+			granularity);
+		return -EINVAL;
+	}
+
+	size = sizeof(*payload) + sizeof(payload->dpa_range_list[0]);
+	payload = kzalloc(size, GFP_KERNEL);
+	if (!payload)
+		return -ENOMEM;
+
+	payload->class = class;
+	payload->subclass = subclass;
+	payload->dpa_range_count = cpu_to_le32(1);
+	payload->dpa_range_list[0].starting_dpa = cpu_to_le64(dpa_start);
+	payload->dpa_range_list[0].length = cpu_to_le64(dpa_length);
+
+	mbox_cmd = (struct cxl_mbox_cmd) {
+		.opcode = CXL_MBOX_OP_MEDIA_OPERATION,
+		.payload_in = payload,
+		.size_in = size,
+		.poll_count = 60,
+		.poll_interval_ms = 1000,
+	};
+
+	rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
+	kfree(payload);
+
+	if (rc < 0) {
+		dev_dbg(cxl_mbox->host,
+			"Media Operation (class=%u sub=%u) failed: %d\n",
+			class, subclass, rc);
+		return rc;
+	}
+
+	return 0;
+}
+
+static int __cxl_dpa_overlap_committed(struct device *dev, void *arg)
+{
+	const struct resource *range = arg;
+	struct cxl_endpoint_decoder *cxled;
+
+	if (!is_endpoint_decoder(dev))
+		return 0;
+
+	cxled = to_cxl_endpoint_decoder(dev);
+	if (!(cxled->cxld.flags & CXL_DECODER_F_ENABLE))
+		return 0;
+	if (!cxled->dpa_res || !resource_size(cxled->dpa_res))
+		return 0;
+
+	return resource_overlaps(cxled->dpa_res, range);
+}
+
+static bool cxl_media_op_dpa_overlap(struct cxl_memdev *cxlmd,
+				     u64 dpa_start, u64 dpa_length)
+{
+	struct cxl_port *endpoint = cxlmd->endpoint;
+	struct resource range = DEFINE_RES_MEM(dpa_start, dpa_length);
+
+	if (!cxlmd->dev.driver || !is_cxl_endpoint(endpoint) ||
+	    cxl_num_decoders_committed(endpoint) == 0)
+		return false;
+
+	return device_for_each_child(&endpoint->dev, &range,
+				     __cxl_dpa_overlap_committed);
+}
+
+/**
+ * cxl_mem_media_op() - Send a Media Operation command to the device.
+ * @cxlmd: The device for the operation
+ * @class: Media operation class
+ * @subclass: Media operation subclass
+ * @dpa_start: Starting DPA in bytes
+ * @dpa_length: Length of the DPA range in bytes
+ *
+ * Send a Media Operation command with a single DPA range.
+ *
+ * Requires corresponding decoder containing the range be offline to
+ * prevent corrupting any actively mapped memory.
+ *
+ * Return: 0 on success, negative error code on failure.
+ */
+int cxl_mem_media_op(struct cxl_memdev *cxlmd, u8 class, u8 subclass,
+		     u64 dpa_start, u64 dpa_length)
+{
+	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
+
+	if (!dpa_length)
+		return -EINVAL;
+
+	guard(device)(&cxlmd->dev);
+	guard(rwsem_read)(&cxl_rwsem.region);
+	guard(rwsem_read)(&cxl_rwsem.dpa);
+
+	/* reject if the DPA range overlaps a committed decoder range */
+	if (cxl_media_op_dpa_overlap(cxlmd, dpa_start, dpa_length))
+		return -EBUSY;
+
+	return __cxl_mem_media_op(mds, class, subclass, dpa_start, dpa_length);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_mem_media_op, "CXL");
+
 static void add_part(struct cxl_dpa_info *info, u64 start, u64 size, enum cxl_partition_mode mode)
 {
 	int i = info->nr_partitions;
diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 99e422594885..a78a0469fb41 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -164,9 +164,20 @@ static ssize_t security_sanitize_store(struct device *dev,
 				       const char *buf, size_t len)
 {
 	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
+	u64 dpa_start, dpa_length;
 	bool sanitize;
 	ssize_t rc;
 
+	/* try "start length" first for ranged sanitize */
+	if (sscanf(buf, "%llx %llx", &dpa_start, &dpa_length) == 2) {
+		rc = cxl_mem_media_op(cxlmd, CXL_MEDIA_OP_CLASS_SANITIZE,
+				      CXL_MEDIA_OP_SUBCLASS_SANITIZE,
+				      dpa_start, dpa_length);
+		if (rc)
+			return rc;
+		return len;
+	}
+
 	if (kstrtobool(buf, &sanitize) || !sanitize)
 		return -EINVAL;
 
@@ -199,6 +210,28 @@ static ssize_t security_erase_store(struct device *dev,
 static struct device_attribute dev_attr_security_erase =
 	__ATTR(erase, 0200, NULL, security_erase_store);
 
+static ssize_t security_zero_store(struct device *dev,
+				   struct device_attribute *attr,
+				   const char *buf, size_t len)
+{
+	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
+	u64 dpa_start, dpa_length;
+	ssize_t rc;
+
+	if (sscanf(buf, "%llx %llx", &dpa_start, &dpa_length) != 2)
+		return -EINVAL;
+
+	rc = cxl_mem_media_op(cxlmd, CXL_MEDIA_OP_CLASS_SANITIZE,
+			      CXL_MEDIA_OP_SUBCLASS_ZERO,
+			      dpa_start, dpa_length);
+	if (rc)
+		return rc;
+
+	return len;
+}
+static struct device_attribute dev_attr_security_zero =
+	__ATTR(zero, 0200, NULL, security_zero_store);
+
 bool cxl_memdev_has_poison_cmd(struct cxl_memdev *cxlmd,
 			       enum poison_cmd_enabled_bits cmd)
 {
@@ -476,6 +509,7 @@ static struct attribute *cxl_memdev_security_attributes[] = {
 	&dev_attr_security_state.attr,
 	&dev_attr_security_sanitize.attr,
 	&dev_attr_security_erase.attr,
+	&dev_attr_security_zero.attr,
 	NULL,
 };
 
@@ -538,13 +572,22 @@ static umode_t cxl_memdev_security_visible(struct kobject *kobj,
 	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
 
 	if (a == &dev_attr_security_sanitize.attr &&
-	    !test_bit(CXL_SEC_ENABLED_SANITIZE, mds->security.enabled_cmds))
+	    !test_bit(CXL_SEC_ENABLED_SANITIZE, mds->security.enabled_cmds) &&
+	    !(test_bit(CXL_SEC_ENABLED_MEDIA_OPERATIONS,
+		       mds->security.enabled_cmds) &&
+	      mds->media_op.sanitize_supported))
 		return 0;
 
 	if (a == &dev_attr_security_erase.attr &&
 	    !test_bit(CXL_SEC_ENABLED_SECURE_ERASE, mds->security.enabled_cmds))
 		return 0;
 
+	if (a == &dev_attr_security_zero.attr &&
+	    (!test_bit(CXL_SEC_ENABLED_MEDIA_OPERATIONS,
+		       mds->security.enabled_cmds) ||
+	     !mds->media_op.zero_supported))
+		return 0;
+
 	return a->mode;
 }
 
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 02054f233fc5..cde613b25581 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -251,6 +251,7 @@ enum security_cmd_enabled_bits {
 	CXL_SEC_ENABLED_UNLOCK,
 	CXL_SEC_ENABLED_FREEZE_SECURITY,
 	CXL_SEC_ENABLED_PASSPHRASE_SECURE_ERASE,
+	CXL_SEC_ENABLED_MEDIA_OPERATIONS,
 	CXL_SEC_ENABLED_MAX
 };
 
@@ -352,6 +353,59 @@ struct cxl_fw_state {
 	int next_slot;
 };
 
+/* Media Operation classes and subclasses (CXL 4.0 Table 8-331) */
+#define CXL_MEDIA_OP_CLASS_GENERAL	0x00
+#define CXL_MEDIA_OP_CLASS_SANITIZE	0x01
+
+#define CXL_MEDIA_OP_SUBCLASS_DISCOVERY	0x00
+#define CXL_MEDIA_OP_SUBCLASS_SANITIZE	0x00
+#define CXL_MEDIA_OP_SUBCLASS_ZERO	0x01
+
+/* Media Operation DPA Range (CXL 4.0 Table 8-330) */
+struct cxl_media_op_dpa_range {
+	__le64 starting_dpa;
+	__le64 length;
+} __packed;
+
+/* Media Operation Input Payload (CXL 4.0 Table 8-329) */
+struct cxl_mbox_media_op_input {
+	u8 class;
+	u8 subclass;
+	u8 rsvd[2];
+	__le32 dpa_range_count;
+	struct cxl_media_op_dpa_range dpa_range_list[];
+} __packed;
+
+/* Discovery operation-specific arguments (CXL 4.0 Table 8-332) */
+struct cxl_mbox_media_op_discovery_args {
+	__le16 start_index;
+	__le16 num_ops;
+} __packed;
+
+/* Discovery output payload (CXL 4.0 Table 8-333) */
+struct cxl_mbox_media_op_discovery_out {
+	__le64 granularity;
+	__le16 total_supported;
+	__le16 num_returned;
+	struct {
+		u8 class;
+		u8 subclass;
+	} __packed ops[];
+} __packed;
+
+/**
+ * struct cxl_media_op_state - Media Operation state
+ *
+ * @granularity: DPA range granularity (bytes) from Discovery
+ * @sanitize_supported: device supports ranged sanitize
+ * @zero_supported: device supports ranged zero
+ */
+struct cxl_media_op_state {
+	u64 granularity;
+	bool sanitize_supported;
+	bool zero_supported;
+};
+
 /**
  * struct cxl_security_state - Device security state
  *
@@ -429,6 +483,7 @@ struct cxl_memdev_state {
 	struct cxl_poison_state poison;
 	struct cxl_security_state security;
 	struct cxl_fw_state fw;
+	struct cxl_media_op_state media_op;
 	struct notifier_block mce_notifier;
 };
 
@@ -479,6 +534,7 @@ enum cxl_opcode {
 	CXL_MBOX_OP_GET_SCAN_MEDIA	= 0x4305,
 	CXL_MBOX_OP_SANITIZE		= 0x4400,
 	CXL_MBOX_OP_SECURE_ERASE	= 0x4401,
+	CXL_MBOX_OP_MEDIA_OPERATION	= 0x4402,
 	CXL_MBOX_OP_GET_SECURITY_STATE	= 0x4500,
 	CXL_MBOX_OP_SET_PASSPHRASE	= 0x4501,
 	CXL_MBOX_OP_DISABLE_PASSPHRASE	= 0x4502,
@@ -829,6 +885,9 @@ static inline void cxl_mem_active_dec(void)
 #endif
 
 int cxl_mem_sanitize(struct cxl_memdev *cxlmd, u16 cmd);
+int cxl_media_op_discover(struct cxl_memdev_state *mds);
+int cxl_mem_media_op(struct cxl_memdev *cxlmd, u8 class, u8 subclass,
+		     u64 dpa_start, u64 dpa_length);
 
 /**
  * struct cxl_hdm - HDM Decoder registers and cached / decoded capabilities
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index bace662dc988..95bf773aab14 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -878,6 +878,10 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (rc)
 		dev_dbg(&pdev->dev, "No CXL Features discovered\n");
 
+	rc = cxl_media_op_discover(mds);
+	if (rc)
+		dev_dbg(&pdev->dev, "No Media Operation discovered\n");
+
 	cxlmd = devm_cxl_add_memdev(cxlds, NULL);
 	if (IS_ERR(cxlmd))
 		return PTR_ERR(cxlmd);
-- 
2.39.5

