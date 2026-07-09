Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1642EEE74
	for <linux-cxl@vger.kernel.org>; Thu,  9 Jul 2026 15:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783612723; cv=none; b=L8tItLiYIo9G1+JKOyLZ+Wq5NUNxH4bcp2qrYdhdv9cDaEddXOhx7KllcPZGX0Fz6S4JWq4iMmB9OotTIlPUFH5NvQ6huqhmN72+I1lW0fJLP4Ga4J74QzRxRamWL/Ro8ZcaRmG1/Ei8DPgZiy9P/RblmRKYQ4IKKZzVv0P8qNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783612723; c=relaxed/simple;
	bh=ZdM/nVycfh5zIQ8q8zCKlCChZ25lHoOFTP4le5xdh1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YSh2pQCUibW6rWadV0XNyKyM9/5nDclGn5yYZ5Qtjg4/IV54q5i/IMKwKQ2oJdWc8k01E6u3N0OfQwlv0KdmJmhU1PyoQhjVJJE4/5g1SIFA/pjLhlfXqBQFDel/nlVucp82TwSWjX951o6O+Hv0DJ++q3lfW/LjmrLkcnrKnFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 256FF1F000E9;
	Thu,  9 Jul 2026 15:58:42 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: djbw@kernel.org,
	dave@stgolabs.net,
	jic23@kernel.org,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com
Subject: [PATCH] cxl/features: Serialize multi-part Get/Set Feature transfers
Date: Thu,  9 Jul 2026 08:58:41 -0700
Message-ID: <20260709155841.1895915-1-dave.jiang@intel.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A Get or Set Feature payload larger than the mailbox payload size is
split into several mailbox commands. mbox_mutex only serializes
individual mailbox commands and is dropped between iterations of these
loops. Nothing serializes the multi-part transfer as a whole.
cxl_get_feature() and cxl_set_feature() are reachable concurrently
from fwctl (per-fd RPCs run under a read-held registration lock) and
from the EDAC scrub/ECS/repair paths, so two transfers to the same
mailbox can interleave their parts and corrupt the device's transfer
context.

Add a per-mailbox feat_mutex and hold it across the whole transfer in
both functions. It nests outside mbox_mutex (which is taken inside
cxl_internal_send_cmd()), and is taken nowhere else, so no lock-ordering
inversion is introduced.

Link: https://sashiko.dev/#/patchset/20260702090849.47501-1-icheng@nvidia.com?part=1
Fixes: 5e5ac21f629d ("cxl/mbox: Add GET_FEATURE mailbox command")
Fixes: 14d502cc2718 ("cxl/mbox: Add SET_FEATURE mailbox command")
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/features.c | 3 +++
 drivers/cxl/core/mbox.c     | 1 +
 include/cxl/mailbox.h       | 2 ++
 3 files changed, 6 insertions(+)

diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
index 85185af46b72..85d6bcdc360e 100644
--- a/drivers/cxl/core/features.c
+++ b/drivers/cxl/core/features.c
@@ -240,6 +240,8 @@ size_t cxl_get_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
 	size_out = min(feat_out_size, cxl_mbox->payload_size);
 	uuid_copy(&pi.uuid, feat_uuid);
 	pi.selection = selection;
+
+	guard(mutex)(&cxl_mbox->feat_mutex);
 	do {
 		data_to_rd_size = min(feat_out_size - data_rcvd_size,
 				      cxl_mbox->payload_size);
@@ -314,6 +316,7 @@ int cxl_set_feature(struct cxl_mailbox *cxl_mbox,
 		data_in_size = cxl_mbox->payload_size - hdr_size;
 	}
 
+	guard(mutex)(&cxl_mbox->feat_mutex);
 	do {
 		int rc;
 
diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 7c6c5b7450a5..0370ac39ec4a 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -1516,6 +1516,7 @@ int cxl_mailbox_init(struct cxl_mailbox *cxl_mbox, struct device *host)
 
 	cxl_mbox->host = host;
 	mutex_init(&cxl_mbox->mbox_mutex);
+	mutex_init(&cxl_mbox->feat_mutex);
 	rcuwait_init(&cxl_mbox->mbox_wait);
 
 	return 0;
diff --git a/include/cxl/mailbox.h b/include/cxl/mailbox.h
index c4e99e2e3a9d..d008b9db07aa 100644
--- a/include/cxl/mailbox.h
+++ b/include/cxl/mailbox.h
@@ -50,6 +50,7 @@ struct cxl_mbox_cmd {
  * @payload_size: Size of space for payload
  *                (CXL 3.1 8.2.8.4.3 Mailbox Capabilities Register)
  * @mbox_mutex: mutex protects device mailbox and firmware
+ * @feat_mutex: serializes multi-part Get/Set Feature transfers
  * @mbox_wait: rcuwait for mailbox
  * @mbox_send: @dev specific transport for transmitting mailbox commands
  * @feat_cap: Features capability
@@ -60,6 +61,7 @@ struct cxl_mailbox {
 	DECLARE_BITMAP(exclusive_cmds, CXL_MEM_COMMAND_ID_MAX);
 	size_t payload_size;
 	struct mutex mbox_mutex; /* lock to protect mailbox context */
+	struct mutex feat_mutex;
 	struct rcuwait mbox_wait;
 	int (*mbox_send)(struct cxl_mailbox *cxl_mbox, struct cxl_mbox_cmd *cmd);
 	enum cxl_features_capability feat_cap;

base-commit: 8cdeaa50eae8dad34885515f62559ee83e7e8dda
-- 
2.54.0

