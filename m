Received: from siberian.tulip.relay.mailchannels.net (siberian.tulip.relay.mailchannels.net [23.83.218.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700E92609E3
	for <linux-cxl@vger.kernel.org>; Tue, 28 Apr 2026 20:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.246
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777406666; cv=pass; b=pT78W+xZDC9fbFFpYi4uJ5qBI5Mor/M06F26MowzDjo7mVRwXr1rihIxURhSmPnzWy9zrXFML7n/87ce1bscqAs+fl+oGY6mzhEtHvYgcZikcCHwZ9OzTy+1mjSha1hwH/AYB7uBYJTsI0cGvKPvwBoyHuXrB9Ak7BaPJ10PPLQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777406666; c=relaxed/simple;
	bh=PJ5wJgs9GR7ZA2Kb9YgqZ3e4L33qqT1wKiAvHQTvnk8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WVv2WPp8H7MT6KrFmfz8i7jdkZopPU7wYW4UNEO6bu8H7H8rJWv5Uxoj1StLFJk8iXJMyCclBs2mvgatXuw0s7GgVp5sVXSYjuMbnetWgs6PyOWAJU89JseBYh3EMi9HqfoLdSRYct0QSesCZz5HL3jpwsn2soh12HgLyg5xyVc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=KGsnTZ3j; arc=pass smtp.client-ip=23.83.218.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="KGsnTZ3j"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id DA23C626E4;
	Tue, 28 Apr 2026 20:04:17 +0000 (UTC)
Received: from pdx1-sub0-mail-a251.dreamhost.com (100-96-24-226.trex-nlb.outbound.svc.cluster.local [100.96.24.226])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 763E86285B;
	Tue, 28 Apr 2026 20:04:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1777406657;
	b=vbs6U3Nvvxjhie/sAbg+DebL9Qk76laXvX4Atpro70Go6zNref72U20ispn113E0S9a28E
	+sXXnBmbj2nBUuIB3TCyEMCW//uzHO3bia5j5gA+79kOq6dYz3jFmj1hplopc8MqgjzO4R
	Z9CAx9vSr44l2rX2FfChX9+ZuapE/NNwjRgQrY8Tqivm/Il8Z1lF4jX/kBd/gGNWH+6fq8
	u3NmozAuy2nWqn6iPQxq0b1RZp8Z/N6DYokGh9scmMHeQGUf3h25weNPtpcfqHGDdIiz3/
	X5ZmDbp+vHL/Gqvsuc6d7F33BgtoX/X4hCRd26n7xo+q/dNLA+LWIx8/Xkt1SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1777406657;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=M/T+uCrd4tUKdCCn/A2q15hH+sVqk0hybRCJPLvT68E=;
	b=M/OcGwqEyLPiSzZio0Wnjlg7sbxwpODKQmAopvwNiYHRQfM82Ehwrd8MAmxKqkf9sENCAa
	y9PoQiuvUFtEpaknsxbdfepcuFyGJ0wngYlqmY4Hn7xJBLyHikUJzmigLAn+8A0udafYXd
	Uto/VBND0DLZmyLFIAMvUF9WTRp/wh9/ZGkGAdSO7s98M6/RtEukASDBNB/9LX997q6C3y
	RQCfeSiswONf0D6kuOWCAfy9asTNXmmJYXkErews74rnYRlsSUjzHHXM8zOTOxE15wxJtE
	O+lY3lvkDVqUbwWj0fXSFIANg1s41rufGx0kKRKr1lwHI3LPHhi/r5J9ip4Abw==
ARC-Authentication-Results: i=1;
	rspamd-b9d4fc544-m58ln;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Wipe-Chemical: 05b4abfc002b2236_1777406657743_818713862
X-MC-Loop-Signature: 1777406657743:1625055878
X-MC-Ingress-Time: 1777406657743
Received: from pdx1-sub0-mail-a251.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.96.24.226 (trex/7.1.5);
	Tue, 28 Apr 2026 20:04:17 +0000
Received: from offworld.lan (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a251.dreamhost.com (Postfix) with ESMTPSA id 4g4rxD24xsz107Q;
	Tue, 28 Apr 2026 13:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1777406657;
	bh=M/T+uCrd4tUKdCCn/A2q15hH+sVqk0hybRCJPLvT68E=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=KGsnTZ3joNFgoKMHClrW0VoQAJpxkJvjD4cn5aFvZ+PO4hQXJnD21BHS2uyV1dArv
	 3dTt8eqNUlAf4IJ6GnZUrhh55YVs2xBCcgyygVNjMA4AoIBFu663YjXI+IaOmT4KA0
	 Tm7kIJJOF+mDWmo+3OZvUcmQQMAzMPxrCGTtbib21Sp3yBFs79UKwpG1Zzz9l5PAIw
	 OF5xc1Len4LHiwwt2O5nbiUYs7WnxRwLQN9LfB9FU8HV5hRmBsFADKJ6SD2Q0tliEb
	 gfiukRDNVC46ghVqHf0QipYuytXznZ5wZhzYnhLn/YcelPJXFa4zQscKHBncY53OBB
	 09nLh4lgwnqIQ==
From: Davidlohr Bueso <dave@stgolabs.net>
To: dave.jiang@intel.com
Cc: jic23@kernel.org,
	alison.schofield@intel.com,
	ira.weiny@intel.com,
	djbw@kernel.org,
	dongjoo.seo1@samsung.com,
	anisa.su@samsung.com,
	linux-cxl@vger.kernel.org,
	Davidlohr Bueso <dave@stgolabs.net>
Subject: [PATCH v2] cxl/mbox: Support Media Operation
Date: Tue, 28 Apr 2026 13:04:10 -0700
Message-Id: <20260428200410.705675-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for the Media Operation command (opcode 4402h) which
enables targeted sanitize and zero operations on specific DPA ranges,
as defined in CXL 4.0 Section 8.2.10.9.5.3.

Operations are only allowed on DPA ranges that do not overlap any
hardware-committed endpoint decoder to ensure not corrupting active
mappings.

Following the path that we currently impose for background cmds, where
users are left with the responsibility of breaking up work sanely, this
implementation imposes an arbitrary limit of 1Gb range to avoid hogging
locks (ie: region/dpa cannot change while media op is on going) and resource
monopolization such as mbox. As such, background commands are processed
synchronously, with a 30s timeout, and currently, per spec, there is no
optional abort it either, nor a way for the device to inform how long the
op could take, ala Scan Media. The observation is that this differs in
semantics regarding the sanitize case, which for whole-device continues
to be handled asynchronously, as a special case.

Run Discovery during probe to get the device's DPA range granularity
and which operations are supported, and expose to sysfs accordingly:

  o 'security/sanitize' is multiplexed to allow single ranged input.
  o 'security/zero' is added, also with single ranged input.
  o 'security/range_limit' is added so users can see the max range supported.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
Changes from v1 (https://lore.kernel.org/all/20260428000220.587249-1-dave@stgolabs.net/):
  - Change range input length from hex to dec, leaving dpa
    address as hex which is more intuitive. (sashiko)
  - Move !cxlmd->dev.driver check out of overlaps logic. (sashiko)
  - Interruptible locking for region and dpa rwsems.
  - Reduce bgcmd timeout to 30s.

 Documentation/ABI/testing/sysfs-bus-cxl |  64 ++++--
 drivers/cxl/core/mbox.c                 | 248 ++++++++++++++++++++++++
 drivers/cxl/core/memdev.c               |  66 ++++++-
 drivers/cxl/cxlmem.h                    |  67 +++++++
 drivers/cxl/pci.c                       |   4 +
 5 files changed, 437 insertions(+), 12 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
index 16a9b3d2e2c0..76e48e870d9f 100644
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
@@ -129,17 +131,25 @@ KernelVersion:  v6.5
 Contact:        linux-cxl@vger.kernel.org
 Description:
 		(WO) Write a boolean 'true' string value to this attribute to
-		sanitize the device to securely re-purpose or decommission it.
+		sanitize the entire device, to securely re-purpose or
+		decommission it. If the device supports the Media Operation
+		command with the sanitize operation, a DPA range may be written
+		as 'start length' in bytes to sanitize a targeted region of
+		media. The start address and length must be aligned to the
+		device's media operation granularity, and the length must not
+		exceed the value reported in 'range_limit'. The sanitize method
+		applied to the range is the same as for whole-device sanitize.
+
 		This is done by ensuring that all user data and meta-data,
 		whether it resides in persistent capacity, volatile capacity,
 		or the LSA, is made permanently unavailable by whatever means
 		is appropriate for the media type. This functionality requires
-		the device to be disabled, that is, not actively decoding any
-		HPA ranges. This permits avoiding explicit global CPU cache
-		management, relying instead for it to be done when a region
-		transitions between software programmed and hardware committed
-		states. If this file is not present, then there is no hardware
-		support for the operation.
+		the device or relevant range to be disabled, that is, not
+		actively decoding any HPA ranges. This permits avoiding explicit
+		global CPU cache management, relying instead for it to be done
+		when a region transitions between software programmed and
+		hardware committed states. If this file is not present, then
+		there is no hardware support for the operation.
 
 
 What            /sys/bus/cxl/devices/memX/security/erase
@@ -158,6 +168,38 @@ Description:
 		support for the operation.
 
 
+What:		/sys/bus/cxl/devices/memX/security/zero
+Date:		April, 2026
+KernelVersion:	v7.2
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(WO) Write a DPA range as 'start length' in bytes to this
+		attribute to zero a specific region of device media via the
+		Media Operation command. The start address and length must be
+		aligned to the device's media operation granularity, and the
+		length must not exceed the value reported in 'range_limit'.
+		This functionality requires the range to be disabled, that is,
+		not actively decoding any HPA ranges. This permits avoiding
+		explicit global CPU cache management, relying instead for it
+		to be done when a region transitions between software
+		programmed and hardware committed states. After completion and
+		onlining, reads from the specified range will return zero. If
+		this file is not present, then the device does not support the
+		Media Operation zero command.
+
+
+What:		/sys/bus/cxl/devices/memX/security/range_limit
+Date:		April, 2026
+KernelVersion:	v7.2
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(RO) Maximum DPA range length in bytes that may be specified
+		for a single Media Operation (sanitize or zero). Userspace
+		must break larger operations into chunks no larger than this
+		limit. If this file is not present, the device does not support
+		Media Operations.
+
+
 What:		/sys/bus/cxl/devices/memX/firmware/
 Date:		April, 2023
 KernelVersion:	v6.5
diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index aaa5c6277ebf..5535c342ff83 100644
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
@@ -893,6 +897,103 @@ int cxl_enumerate_cmds(struct cxl_memdev_state *mds)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_enumerate_cmds, "CXL");
 
+#define CXL_MEDIA_OP_MAX_OPS 2
+
+/**
+ * cxl_media_op_discover() - Discover supported media operation
+ * @mds: The device data for the operation
+ *
+ * Discover any available Media Operations.
+ *
+ * Return: 0 on success or if Media Operation is not supported,
+ * negative error code on failure.
+ */
+int cxl_media_op_discover(struct cxl_memdev_state *mds)
+{
+	int rc, i;
+	u16 num_returned;
+	u64 granularity;
+	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
+	struct cxl_mbox_media_op_discovery_out *disc_out __free(kfree) = NULL;
+	struct cxl_mbox_media_op_discovery_in *disc_in __free(kfree) = NULL;
+
+	if (!test_bit(CXL_SEC_ENABLED_MEDIA_OPERATIONS,
+		      mds->security.enabled_cmds))
+		return 0;
+
+	disc_in = kzalloc_obj(*disc_in);
+	if (!disc_in)
+		return -ENOMEM;
+
+	disc_in->class = CXL_MEDIA_OP_CLASS_GENERAL;
+	disc_in->subclass = CXL_MEDIA_OP_GENERAL_DISCOVERY;
+	disc_in->dpa_range_count = 0;
+	disc_in->start_index = 0;
+	disc_in->num_ops = cpu_to_le16(CXL_MEDIA_OP_MAX_OPS);
+
+	disc_out = kzalloc_flex(*disc_out, ops, CXL_MEDIA_OP_MAX_OPS);
+	if (!disc_out)
+		return -ENOMEM;
+
+	struct cxl_mbox_cmd mbox_cmd = (struct cxl_mbox_cmd) {
+		.opcode = CXL_MBOX_OP_MEDIA_OPERATION,
+		.payload_in = disc_in,
+		.size_in = sizeof(*disc_in),
+		.payload_out = disc_out,
+		.size_out = struct_size(disc_out, ops, CXL_MEDIA_OP_MAX_OPS),
+		.min_out = sizeof(*disc_out),
+		.poll_count = 1,
+		.poll_interval_ms = 1000,
+	};
+
+	rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
+	if (rc < 0) {
+		dev_dbg(cxl_mbox->host,
+			"Media Operation Discovery failed: %d\n", rc);
+		return rc;
+	}
+
+	num_returned = le16_to_cpu(disc_out->num_returned);
+	if (num_returned > CXL_MEDIA_OP_MAX_OPS) {
+		dev_dbg(cxl_mbox->host,
+			"Discovery returned %u ops, expected max %u\n",
+			num_returned, CXL_MEDIA_OP_MAX_OPS);
+		return -EINVAL;
+	}
+
+	granularity = le64_to_cpu(disc_out->granularity);
+	/* spec requires granularity to be a power of 2 and a multiple of 0x40 */
+	if (!is_power_of_2(granularity) || !IS_ALIGNED(granularity, SZ_64)) {
+		dev_dbg(cxl_mbox->host,
+			"Discovery returned invalid granularity: %llu\n",
+			granularity);
+		return -EINVAL;
+	}
+	mds->media_op.granularity = granularity;
+	mds->media_op.range_limit = rounddown(SZ_1G, granularity);
+
+	for (i = 0; i < num_returned; i++) {
+		u8 cls = disc_out->ops[i].class;
+		u8 sub = disc_out->ops[i].subclass;
+
+		if (cls == CXL_MEDIA_OP_CLASS_SANITIZE &&
+		    sub == CXL_MEDIA_OP_SANITIZE_SANITIZE)
+			mds->media_op.sanitize_supported = true;
+		if (cls == CXL_MEDIA_OP_CLASS_SANITIZE &&
+		    sub == CXL_MEDIA_OP_SANITIZE_ZERO)
+			mds->media_op.zero_supported = true;
+	}
+
+	dev_dbg(cxl_mbox->host,
+		"Media Operation: granularity=%llu sanitize=%d zero=%d\n",
+		mds->media_op.granularity,
+		mds->media_op.sanitize_supported,
+		mds->media_op.zero_supported);
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_media_op_discover, "CXL");
+
 void cxl_event_trace_record(struct cxl_memdev *cxlmd,
 			    enum cxl_event_log_type type,
 			    enum cxl_event_type event_type,
@@ -1308,6 +1409,153 @@ int cxl_mem_sanitize(struct cxl_memdev *cxlmd, u16 cmd)
 	return -EBUSY;
 }
 
+static int __cxl_mem_media_op(struct cxl_memdev_state *mds, u8 class,
+			      u8 subclass, u64 dpa_start, u64 dpa_length)
+{
+	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
+	struct cxl_mbox_media_op_input *payload __free(kfree) = NULL;
+	int rc;
+
+	payload = kzalloc_flex(*payload, dpa_range_list, 1);
+	if (!payload)
+		return -ENOMEM;
+
+	payload->class = class;
+	payload->subclass = subclass;
+	payload->dpa_range_count = cpu_to_le32(1);
+	payload->dpa_range_list[0].starting_dpa = cpu_to_le64(dpa_start);
+	payload->dpa_range_list[0].length = cpu_to_le64(dpa_length);
+
+	struct cxl_mbox_cmd mbox_cmd = (struct cxl_mbox_cmd) {
+		.opcode = CXL_MBOX_OP_MEDIA_OPERATION,
+		.payload_in = payload,
+		.size_in = struct_size(payload, dpa_range_list, 1),
+		.poll_count = 30,
+		.poll_interval_ms = 1000,
+	};
+
+	rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
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
+	if (cxl_num_decoders_committed(endpoint) == 0)
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
+	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
+	u64 granularity;
+	int rc;
+
+	if (!test_bit(CXL_SEC_ENABLED_MEDIA_OPERATIONS,
+		      mds->security.enabled_cmds))
+		return -EOPNOTSUPP;
+
+	/* ensure the specific operation was reported by Discovery */
+	if (class == CXL_MEDIA_OP_CLASS_SANITIZE) {
+		switch (subclass) {
+		case CXL_MEDIA_OP_SANITIZE_SANITIZE:
+			if (!mds->media_op.sanitize_supported)
+				return -EOPNOTSUPP;
+			break;
+		case CXL_MEDIA_OP_SANITIZE_ZERO:
+			if (!mds->media_op.zero_supported)
+				return -EOPNOTSUPP;
+			break;
+		}
+	}
+
+	granularity = mds->media_op.granularity;
+	if (!granularity)
+		return -EINVAL;
+
+	if (dpa_length == 0 ||
+	    !IS_ALIGNED(dpa_start, granularity) ||
+	    !IS_ALIGNED(dpa_length, granularity)) {
+		dev_dbg(cxl_mbox->host,
+			"DPA range not aligned to %llu-byte granularity\n",
+			granularity);
+		return -EINVAL;
+	}
+
+	if (dpa_length > mds->media_op.range_limit) {
+		dev_dbg(cxl_mbox->host,
+			"DPA range length %llu exceeds limit %llu\n",
+			dpa_length, mds->media_op.range_limit);
+		return -EINVAL;
+	}
+
+	guard(device)(&cxlmd->dev);
+	if (!cxlmd->dev.driver || !is_cxl_endpoint(cxlmd->endpoint))
+		return -EBUSY;
+
+	ACQUIRE(rwsem_read_intr, region_rwsem)(&cxl_rwsem.region);
+	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &region_rwsem)))
+		return rc;
+
+	ACQUIRE(rwsem_read_intr, dpa_rwsem)(&cxl_rwsem.dpa);
+	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &dpa_rwsem)))
+		return rc;
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
index 80e65690eb77..3db4e91170a8 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -164,9 +164,20 @@ static ssize_t security_sanitize_store(struct device *dev,
 				       const char *buf, size_t len)
 {
 	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
+	u64 dpa_start, dpa_length;
 	bool sanitize;
 	ssize_t rc;
 
+	/* start with ranged sanitize */
+	if (sscanf(buf, "%llx %llu", &dpa_start, &dpa_length) == 2) {
+		rc = cxl_mem_media_op(cxlmd, CXL_MEDIA_OP_CLASS_SANITIZE,
+				      CXL_MEDIA_OP_SANITIZE_SANITIZE,
+				      dpa_start, dpa_length);
+		if (rc)
+			return rc;
+		return len;
+	}
+
 	if (kstrtobool(buf, &sanitize) || !sanitize)
 		return -EINVAL;
 
@@ -199,6 +210,40 @@ static ssize_t security_erase_store(struct device *dev,
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
+	if (sscanf(buf, "%llx %llu", &dpa_start, &dpa_length) != 2)
+		return -EINVAL;
+
+	rc = cxl_mem_media_op(cxlmd, CXL_MEDIA_OP_CLASS_SANITIZE,
+			      CXL_MEDIA_OP_SANITIZE_ZERO,
+			      dpa_start, dpa_length);
+	if (rc)
+		return rc;
+
+	return len;
+}
+static struct device_attribute dev_attr_security_zero =
+	__ATTR(zero, 0200, NULL, security_zero_store);
+
+static ssize_t security_range_limit_show(struct device *dev,
+					 struct device_attribute *attr,
+					 char *buf)
+{
+	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
+	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
+
+	return sysfs_emit(buf, "%llu\n", mds->media_op.range_limit);
+}
+static struct device_attribute dev_attr_security_range_limit =
+	__ATTR(range_limit, 0444, security_range_limit_show, NULL);
+
 bool cxl_memdev_has_poison_cmd(struct cxl_memdev *cxlmd,
 			       enum poison_cmd_enabled_bits cmd)
 {
@@ -479,6 +524,8 @@ static struct attribute *cxl_memdev_security_attributes[] = {
 	&dev_attr_security_state.attr,
 	&dev_attr_security_sanitize.attr,
 	&dev_attr_security_erase.attr,
+	&dev_attr_security_zero.attr,
+	&dev_attr_security_range_limit.attr,
 	NULL,
 };
 
@@ -540,14 +587,31 @@ static umode_t cxl_memdev_security_visible(struct kobject *kobj,
 	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
 	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
 
+	/* sanitize attr serves both whole-device sanitize and ranged media op */
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
+	if (a == &dev_attr_security_range_limit.attr &&
+	    (!test_bit(CXL_SEC_ENABLED_MEDIA_OPERATIONS,
+		       mds->security.enabled_cmds) ||
+	     (!mds->media_op.sanitize_supported &&
+	      !mds->media_op.zero_supported)))
+		return 0;
+
 	return a->mode;
 }
 
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 776c50d1db51..2fd8dc9c331d 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -251,6 +251,7 @@ enum security_cmd_enabled_bits {
 	CXL_SEC_ENABLED_UNLOCK,
 	CXL_SEC_ENABLED_FREEZE_SECURITY,
 	CXL_SEC_ENABLED_PASSPHRASE_SECURE_ERASE,
+	CXL_SEC_ENABLED_MEDIA_OPERATIONS,
 	CXL_SEC_ENABLED_MAX
 };
 
@@ -352,6 +353,67 @@ struct cxl_fw_state {
 	int next_slot;
 };
 
+/* Media Operation classes and subclasses (CXL 4.0 Table 8-331) */
+#define CXL_MEDIA_OP_CLASS_GENERAL		0x00
+#define CXL_MEDIA_OP_CLASS_SANITIZE		0x01
+
+/* General class subclasses */
+#define CXL_MEDIA_OP_GENERAL_DISCOVERY		0x00
+/* Sanitize class subclasses */
+#define CXL_MEDIA_OP_SANITIZE_SANITIZE		0x00
+#define CXL_MEDIA_OP_SANITIZE_ZERO		0x01
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
+	struct cxl_media_op_dpa_range dpa_range_list[] __counted_by_le(dpa_range_count);
+} __packed;
+
+/* Discovery Input Payload (CXL 4.0 Table 8-329 + Table 8-332) */
+struct cxl_mbox_media_op_discovery_in {
+	u8 class;
+	u8 subclass;
+	u8 rsvd[2];
+	__le32 dpa_range_count;
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
+	} __packed ops[] __counted_by_le(num_returned);
+} __packed;
+
+/**
+ * struct cxl_media_op_state - Media Operation state
+ *
+ * @granularity: DPA range granularity (bytes) from Discovery
+ * @range_limit: maximum DPA range length per operation (bytes)
+ * @sanitize_supported: device supports ranged sanitize
+ * @zero_supported: device supports ranged zero
+ */
+struct cxl_media_op_state {
+	u64 granularity;
+	u64 range_limit;
+	bool sanitize_supported;
+	bool zero_supported;
+};
+
 /**
  * struct cxl_security_state - Device security state
  *
@@ -429,6 +491,7 @@ struct cxl_memdev_state {
 	struct cxl_poison_state poison;
 	struct cxl_security_state security;
 	struct cxl_fw_state fw;
+	struct cxl_media_op_state media_op;
 	struct notifier_block mce_notifier;
 };
 
@@ -479,6 +542,7 @@ enum cxl_opcode {
 	CXL_MBOX_OP_GET_SCAN_MEDIA	= 0x4305,
 	CXL_MBOX_OP_SANITIZE		= 0x4400,
 	CXL_MBOX_OP_SECURE_ERASE	= 0x4401,
+	CXL_MBOX_OP_MEDIA_OPERATION	= 0x4402,
 	CXL_MBOX_OP_GET_SECURITY_STATE	= 0x4500,
 	CXL_MBOX_OP_SET_PASSPHRASE	= 0x4501,
 	CXL_MBOX_OP_DISABLE_PASSPHRASE	= 0x4502,
@@ -829,6 +893,9 @@ static inline void cxl_mem_active_dec(void)
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

