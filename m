Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com [74.125.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B67E5237AE
	for <linux-cxl@vger.kernel.org>; Fri, 18 Sep 2026 20:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789763490; cv=none; b=JaNcdLMT3heTJlHbVTmyRiJEy5DOCtByac0KswIC/S9wubbGuKZhWLZtgy/IyQpk4ZJd2Y4A+lHzRqDonszO5ynYijB44Qdyj6ag01G9QNGAA/IMsHowpnGFjvH+gjdy42nh/1mwsbyFDcAN8Cx7KKSYeyE8wI2p2Qw1iChiZ+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789763490; c=relaxed/simple;
	bh=50YF1GRIAdh1pbM526fLR+jHhqN2rJgvJ/QgNd/p0D4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h8LZlMcLzI8IOqSzj+vqEUNBKJJr7FB+phq+lZNM0UsA7Ib28ka5cvvOe6i5sjGEW2+5+Xv2jHiQJHKXeTpflcOfwPdY4alLiojTucCryNDZAqjztzfUdYiI5WrsgjJueMkFk6KqvvScxWVPBhAwHcVNtF3V/nH5658K2f7i0DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k05XR5Bm; arc=none smtp.client-ip=74.125.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k05XR5Bm"
Received: by mail-yx2-f13.google.com with SMTP id 956f58d0204a3-66e4ab1ba47so590425d50.0
        for <linux-cxl@vger.kernel.org>; Fri, 18 Sep 2026 13:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789763487; x=1790368287; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=n7emqRlU0MzXMkqE8ZjhvjRAJOSMNKDO1xaL6vJcVJs=;
        b=k05XR5BmQgUhyyumTag2wLCscLr+7d4KhQtY1fejXeD7+m9iYZg9TPR4d70QFvca7g
         UEMxlFxtCQORoxUN2w1js/cLm2LPZnJOY8Rg0tGY8Gg13/13Y4yBtiVdrkH2cVJpsUaP
         gJllcRGp0wN86cjMlDhq+j7M9aIRLxx1eGPzPXp6994v1i4Oejk72by8pzFSbhcHPhSY
         vYyTc7eJRUsby5FXVCIHaWnuJrLtb9+xWICQHmlUvY1IWN/2IThVaiRM0qwD2FtediaD
         UFA2EZnw/aDj6jTB5unOF9trXzapbMTjoFN9NovaPDfk5JXoO1tX4DaUXUo6k7LaHTed
         Ky5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789763487; x=1790368287;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=n7emqRlU0MzXMkqE8ZjhvjRAJOSMNKDO1xaL6vJcVJs=;
        b=k/5MeQ7wSjfeJqtXkbSbk/pX7tfFpvzT0HmzPiJWxv9Niu+oGqN8fM4lcaNQ9aeRXJ
         tVMCyDGXatFtnUqQuf6FFbLH3G9aYo9y5OvsbpkGhbWZ5jdvWtBfsrmL9Wgn3ioKXER6
         Pxt2qA3azUs+edVSj4ZZvAV+p2VLu/yb/iunsNDfkZjc/9b1JbpU1v9OMD8dpX5Tqf/E
         hq6gRJqTXUk3zPXILfoZlax1XVMcWZZoB5Vd+FmqfEweBLy5uX6fqt7nzjxnLFox2ETh
         IzOKDhKwp/sr1J2sfitopa7M99Qdkr5IOPzd7AVvHlv7pvpJxLR/gCgODryQ1XVRuBgf
         vdjA==
X-Gm-Message-State: AFuF++ldWSHNlkJpgDYUHC1Wa7a/b/5N7AFEvr6yjQ/PJYMjRYLxylPI
	YbYeYSGLeAY1o/1f2D4HyH2sJ8bfJxqaAJrYoXJFp0+mTUP7HZdb/r6DMlaAtw==
X-Gm-Gg: AYBFou2JanAOyP+fsWKbxKGFabun4Lb5nMjdVlOMA0G6oj3JchgAj2Qq7bUMJEi4JAv
	g4l2XMdeNBTCis0b1qj5w+bbQdf/uZeZeft4o+6zSUL34y6V+wwp3u6EiuaXG2BS/gD75WuL1DY
	jWTr8gYQFVlV1UFDXMBFtQfKmIhkvCnVMBgYsSW6Q1JqSUiND1BC4BuasZjLbfZd+DWTGG1sIhE
	WMkQWa+fB7Oogd98WU7UIAS6JNhKjHnNJYJ6fvQagshEkbyAk+Uayh2kXvqCahd30JCAF0mzh/p
	ALvpFrfTUY1dYMzkxl2jNPyBc3Mjafm+k7QeH+DJW/m8evfQ5IAkvDvPr3m3Xd2kPh30wjFSFnH
	QSL1VmEboghS/y4jo1Yzpk9ILIwLrDVJ7PzM2HPxLPgpaw6RYjlz9vgkbKws2N257GcIGmFRUFN
	VTpwxy5+ylXvqJIY6gJApSTAm+eM23o+zfGWvAC6yCN1Mr4GKg5oejlGviXoS5XbtVrkci0ovTj
	0BY3eKfXsY35xjSlVrm9jiBJCGfAs6eKI7GHhpzfXX9Ryx/dQ==
X-Received: by 2002:a53:d44f:0:b0:671:31f3:9485 with SMTP id 956f58d0204a3-6717ff3e77dmr803329d50.33.1789763487269;
        Fri, 18 Sep 2026 13:31:27 -0700 (PDT)
Received: from 4470NRD-ASU.ssi.samsung.com ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67298f64b74sm427240d50.1.2026.09.18.13.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 13:31:26 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
To: linux-cxl@vger.kernel.org
Cc: Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Li Ming <ming.li@zohomail.com>,
	Gregory Price <gourry@gourry.net>,
	Richard Cheng <icheng@nvidia.com>,
	Ben Cheatham <benjamin.cheatham@amd.com>,
	Ira Weiny <iweiny@kernel.org>,
	Anisa Su <anisa.su@samsung.com>,
	Wonjae Lee <wj28.lee@samsung.com>,
	Junhee Park <jh9934.park@samsung.com>,
	Heesoo Kim <habil.kim@samsung.com>
Subject: [PATCH v14 1/8] cxl/mbox: Flag support for Dynamic Capacity Devices (DCD)
Date: Fri, 18 Sep 2026 13:30:10 -0700
Message-ID: <20260918203049.7273-2-anisa.su@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260918203049.7273-1-anisa.su@samsung.com>
References: <20260918203049.7273-1-anisa.su@samsung.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ira Weiny <iweiny@kernel.org>

Per the CXL 4.0 specification software must check the Command Effects
Log (CEL) for dynamic capacity command support.

Detect support for the DCD commands while reading the CEL, including:

	Get DC Config
	Get DC Extent List
	Add DC Response
	Release DC

Leave mds->dcd_supported false. Dynamic capacity is only usable once
the driver can handle Add and Release Capacity events. Detect and log
the capability here and let the commit which adds DCD event handling set
the flag.

Based on an original patch by Navneet Singh.

Signed-off-by: Ira Weiny <iweiny@kernel.org>
Signed-off-by: Anisa Su <anisa.su@samsung.com>
Tested-by: Wonjae Lee <wj28.lee@samsung.com>
Tested-by: Junhee Park <jh9934.park@samsung.com>
Tested-by: Heesoo Kim <habil.kim@samsung.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Reviewed-by: Richard Cheng <icheng@nvidia.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/core/mbox.c | 39 +++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxlmem.h    | 20 ++++++++++++++++++++
 2 files changed, 59 insertions(+)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 55828a836c01..199bb986d674 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -171,6 +171,33 @@ static void cxl_set_security_cmd_enabled(struct cxl_security_state *security,
 	}
 }
 
+static bool cxl_is_dcd_command(u16 opcode)
+{
+#define CXL_MBOX_OP_DCD_CMDS 0x48
+
+	return (opcode >> 8) == CXL_MBOX_OP_DCD_CMDS;
+}
+
+static void cxl_set_dcd_cmd_enabled(u16 opcode, unsigned long *cmd_mask)
+{
+	switch (opcode) {
+	case CXL_MBOX_OP_GET_DC_CONFIG:
+		set_bit(CXL_DCD_ENABLED_GET_CONFIG, cmd_mask);
+		break;
+	case CXL_MBOX_OP_GET_DC_EXTENT_LIST:
+		set_bit(CXL_DCD_ENABLED_GET_EXTENT_LIST, cmd_mask);
+		break;
+	case CXL_MBOX_OP_ADD_DC_RESPONSE:
+		set_bit(CXL_DCD_ENABLED_ADD_RESPONSE, cmd_mask);
+		break;
+	case CXL_MBOX_OP_RELEASE_DC:
+		set_bit(CXL_DCD_ENABLED_RELEASE, cmd_mask);
+		break;
+	default:
+		break;
+	}
+}
+
 static bool cxl_is_poison_command(u16 opcode)
 {
 #define CXL_MBOX_OP_POISON_CMDS 0x43
@@ -759,6 +786,7 @@ static void cxl_walk_cel(struct cxl_memdev_state *mds, size_t size, u8 *cel)
 	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
 	struct cxl_cel_entry *cel_entry;
 	const int cel_entries = size / sizeof(*cel_entry);
+	DECLARE_BITMAP(dcd_cmds, CXL_DCD_ENABLED_MAX) = {};
 	struct device *dev = mds->cxlds.dev;
 	int i, ro_cmds = 0, wr_cmds = 0;
 
@@ -787,11 +815,22 @@ static void cxl_walk_cel(struct cxl_memdev_state *mds, size_t size, u8 *cel)
 			enabled++;
 		}
 
+		if (cxl_is_dcd_command(opcode)) {
+			cxl_set_dcd_cmd_enabled(opcode, dcd_cmds);
+			enabled++;
+		}
+
 		dev_dbg(dev, "Opcode 0x%04x %s\n", opcode,
 			enabled ? "enabled" : "unsupported by driver");
 	}
 
 	set_features_cap(cxl_mbox, ro_cmds, wr_cmds);
+	/*
+	 * Disabled until event handling implemented.
+	 */
+	if (bitmap_full(dcd_cmds, CXL_DCD_ENABLED_MAX))
+		dev_dbg(dev, "Device supports DCD; capability disabled\n");
+	mds->dcd_supported = false;
 }
 
 static struct cxl_mbox_get_supported_logs *cxl_get_gsl(struct cxl_memdev_state *mds)
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index c401e3a1af06..0c8e23276dc6 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -252,6 +252,20 @@ struct cxl_event_state {
 	struct mutex log_lock;
 };
 
+/*
+ * CXL r4.0 Section 8.2.10.9 - Memory Device Command Sets. See Table 8-308.
+ *
+ * The 48h Command Set (Opcodes 4800h - 4803h) defines the device-enabled DCD
+ * commands.
+ */
+enum dcd_cmd_enabled_bits {
+	CXL_DCD_ENABLED_GET_CONFIG,
+	CXL_DCD_ENABLED_GET_EXTENT_LIST,
+	CXL_DCD_ENABLED_ADD_RESPONSE,
+	CXL_DCD_ENABLED_RELEASE,
+	CXL_DCD_ENABLED_MAX
+};
+
 /* Device enabled poison commands */
 enum poison_cmd_enabled_bits {
 	CXL_POISON_ENABLED_LIST,
@@ -427,6 +441,7 @@ static inline struct cxl_dev_state *mbox_to_cxlds(struct cxl_mailbox *cxl_mbox)
  * @partition_align_bytes: alignment size for partition-able capacity
  * @active_volatile_bytes: sum of hard + soft volatile
  * @active_persistent_bytes: sum of hard + soft persistent
+ * @dcd_supported: all DCD commands are supported
  * @event: event log driver state
  * @poison: poison driver state info
  * @security: security driver state info
@@ -445,6 +460,7 @@ struct cxl_memdev_state {
 	u64 partition_align_bytes;
 	u64 active_volatile_bytes;
 	u64 active_persistent_bytes;
+	bool dcd_supported;
 
 	struct cxl_event_state event;
 	struct cxl_poison_state poison;
@@ -505,6 +521,10 @@ enum cxl_opcode {
 	CXL_MBOX_OP_UNLOCK		= 0x4503,
 	CXL_MBOX_OP_FREEZE_SECURITY	= 0x4504,
 	CXL_MBOX_OP_PASSPHRASE_SECURE_ERASE	= 0x4505,
+	CXL_MBOX_OP_GET_DC_CONFIG	= 0x4800,
+	CXL_MBOX_OP_GET_DC_EXTENT_LIST	= 0x4801,
+	CXL_MBOX_OP_ADD_DC_RESPONSE	= 0x4802,
+	CXL_MBOX_OP_RELEASE_DC		= 0x4803,
 	CXL_MBOX_OP_MAX			= 0x10000
 };
 
-- 
2.43.0

