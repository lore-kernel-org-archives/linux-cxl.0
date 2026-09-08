Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0111050AC14
	for <linux-cxl@vger.kernel.org>; Tue,  8 Sep 2026 10:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788862932; cv=none; b=UykEgtLf4eH4i1oOXV7M0snvqVTY2rv6KTp8Dlk4NFw0KuGeeaYTv1ktEKZ+ogdosfqKD0ChL87aeADIh4nL0ypk6sJR0tBqQgT9I3vlp/pIf0KUPuHlubnwUf+JQo0WWoUtWgDgYLZFqmWNj0VdWRIf9zh1rFmplgpkQF4ZdNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788862932; c=relaxed/simple;
	bh=lswWLwG/JPooiNhdBGjHvDyqMkw8XwG0OWaKRYb7VI0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lxIBpnLSfE/qdrdNPldxol0/LnqE0QY9v77/v//HfVSG26sXtMOWMjyekkdzo32PwZv9u2RhjKE3ZjfDFG56b8kOwCPdCg4dmUhK/H3DcX9LWOHLmD6GO8R24K9p1qXLA3moXwKECQNVb9Var/wqb3HimIMED9vaHM7ZJOv4aXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gT5d9GAW; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gT5d9GAW"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2db858d60e0so1887175ad.0
        for <linux-cxl@vger.kernel.org>; Tue, 08 Sep 2026 03:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788862930; x=1789467730; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Rk13g7zQor0BPEJRwOiqh3a+NZ3g5zyp+DqP2CQRO54=;
        b=gT5d9GAWuourAPH9fQxXvNdy/c949bvm6Z7/u2hSELPfTUrZKMqNvU+lV4zFRuaznA
         F83gYYseQllKamfNADuajdgUMDpN4UYIkf0+myWDtyWrff3ArLhzPQR9KOyIf75UFEkx
         0JxVHxjNnd6QjOp2+kUEoX7pz4NJfhMpaYou0LGvN6k/JQe/FE61KWlyflr4woJ0aMwo
         KU6isMRdXA1/Ak4qItYgO6IFdEVwIyBu9MvzV6VRz+dVTBb1bK4dVg8jmR+J4TTY7vf3
         GptWVjkh5PoqtvrBUFtixmdZgdnoNZi6lqFhxKie+zqbs1Enw+uH/EHvnrx5wkXvdZqe
         tUwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788862930; x=1789467730;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Rk13g7zQor0BPEJRwOiqh3a+NZ3g5zyp+DqP2CQRO54=;
        b=NQAhr9uvfoOj5HQ8qzpJ3EjSoAHB5h2+UBViAsTFgrwwb/Rut9SwPy8O8vvVJSGOPl
         acMtypoRR4cxkjuZoeYZayG1gsRxnHA19TnqEj6V213zwoDW/9w06FvzkY8+X/q0gULA
         noqv1Oeqz39u4LcY53x+wPajbfPoWSBMZTDWmT4n7RF244yTEuPHbEmMsWidlVeNpXPz
         bqIckm6/rtF65RtCNTeTonoUtEgDVZzffOo0z+ni7Nm/VYr13IYFFh1B/Y8Qnta5r1Q6
         gFjqLJpXKqXbeHZQS/xAaDZ9AEJ1Ges8J6CKyx791NqRYfuo2ph6tIXXuPGWZ6HtN/Lh
         Wbtg==
X-Gm-Message-State: AFuF++nhyA6GWLiyG94N/clkNxEdrDMKBFy9sii7S0CN6k8ntXm5Fxn9
	7TxJzqhjRYNZzLsJ0Rn2YUduo5gkGfGW+fJo+fpAiuHwmX1M/vOGTjvKodc++Q==
X-Gm-Gg: AYBFou1c9/nlpHtKS3jBiUTQwESqxDFZAtSpWBelUuGxPw+dvolL2f+lrYjGZPXx4eJ
	nfexe/ulqJvo45lTVffQ7gIG3lnMHiUCeQn4CVjWmhxtHcsGeTEGGnPRsx5izv6SdaAXHOke2WH
	xPf1liBgEbchVwRMgErqc3kzUBhC7brfXTPNtxBlSdABGXQoqtG4cFQXtmXmj3Bl1TgTsc0HhKK
	a5IxnpFHl6qe7dgS1dgopwWUtxyP+//uem5vahjZY2Kxl9w2MNO9G/T5ePEl5a4JwdmIraiJRy9
	6KTA4h7a2BeqkXhTZDViLjHlomhUjHAe7ugv1+atR+JcIcVSjtc3YDtisJ6gUcBkO7+FtaeIKup
	A+Dyb+4/DRgTBbI1BAIkbScctmbhx+wRQYbbgLdA4BVsGBL5FSLjaP7yxGYQQDtIK5NCGyd4bEf
	uK9OecNYWmkdBToYPlfmZ6jSHDcC//SLESGj1iHsQHSzEj/5Ns39Ky+bGOXAGXWsVGtTVydy+N+
	sKlQh/f3h/8rYrCUtO+MHRy/0ix6pQ/yt3iuF5U4JgIkYur1bF1K5BiMgtxuRwJhkHUofr4+t3Z
X-Received: by 2002:a17:90b:2d0b:b0:398:c794:ca26 with SMTP id 98e67ed59e1d1-39b263167f7mr41655017a91.25.1788862930102;
        Tue, 08 Sep 2026 03:22:10 -0700 (PDT)
Received: from AnisaLaptop.localdomain (c-73-170-217-179.hsd1.ca.comcast.net. [73.170.217.179])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3396e7e477csm3435658eec.29.2026.09.08.03.22.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 03:22:09 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
To: linux-cxl@vger.kernel.org
Cc: alison.schofield@intel.com,
	jic23@kernel.org,
	dave.jiang@intel.com,
	gourry@gourry.net,
	icheng@nvidia.com,
	ming.li@zohomail.com,
	vishal.l.verma@intel.com,
	dave@stgolabs.net,
	benjamin.cheatham@amd.com,
	Ira Weiny <iweiny@kernel.org>,
	Anisa Su <anisa.su@samsung.com>,
	Wonjae Lee <wj28.lee@samsung.com>,
	Junhee Park <jh9934.park@samsung.com>,
	Heesoo Kim <habil.kim@samsung.com>
Subject: [RESEND PATCH v13 1/8] cxl/mbox: Flag support for Dynamic Capacity Devices (DCD)
Date: Tue,  8 Sep 2026 03:15:05 -0700
Message-ID: <20260908102124.2231730-3-anisa.su@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260908102124.2231730-2-anisa.su@samsung.com>
References: <20260908102124.2231730-2-anisa.su@samsung.com>
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

---
Changes:
1. Commit message: explain why mds->dcd_supported is left
   false and when it's re-enabled in the commit message.

2. mbox.c: drop the single use cxl_verify_dcd_cmds() helper and test
   bitmap_full(dcd_cmds, CXL_DCD_ENABLED_MAX) directly. Reported by
   Alison Schofield.
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

