Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F37392C5F
	for <linux-cxl@vger.kernel.org>; Wed,  7 Oct 2026 20:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791404318; cv=none; b=nWuw2D+vnqmrVMX6MFA1ftTR8143JNQq/vhg6628PrzBKHsazcZl2PmkDGwRdnyMJeQF5YsrGfbyO+W/aDnRic+TLq4Ecs/ZvyRLtmhSahZaVIC48fZ+sWVhnw6HXS7riZL93x7r3oyDN6ctl2Z51lBiw0Obdwj9N5+itXpmY1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791404318; c=relaxed/simple;
	bh=r8qBsfJbNZRq7JrBJozIFzwC/WJjCuHiYGXZgNGqfQg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B9FZtmQb8vGrTbZXA3ZKK0jTpqIN7JXkgZ/RN0PR/4fZrGrd3MkOBC6PlnB8/bt9D9r1hqZbup/2hvPw4MDV48JcK/0lgroHUjkXOuOUqAfG8c94sOphAx1gEiYxqhNUtTY+oVTLK9EscWfmQJNI6l+8riOWvFeM39wrFD7Zaq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nJ5wxtZP; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nJ5wxtZP"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-38e42560ebcso2658254a91.1
        for <linux-cxl@vger.kernel.org>; Wed, 07 Oct 2026 13:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791404316; x=1792009116; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=e5Nm4HCEgY1Zc46v0F10qQolFAbTP8DxnjvFTksX9bE=;
        b=nJ5wxtZPmRV8ggQN7qo1U/2dFLeJLiJg4rk74VE9DQAazI3EqTBvxtEvuvvCf2neGr
         YbfRN+CKJ+YiOcNNwA1zuO57kvL6a9E9P2vzL4GtsLhfUcIHsDCvR44R6t1pmcjSlZUC
         9i385x9UAxoCOXC6IK5YCg4Y+k9vkHO8C4HlLwFrJEPoI4q3qR7838OQ92e3L6/u4yGu
         YJ6sSnM+xqxM2XaX+v7VayZ7Ih5OauaQme2TZidvK1A1QPndC26tgoL9rgUi4j717qCo
         +q0JwV415eO7VfPBOwA1s6BEg4ruViTPHgEFgqNnMkGtLLcxnOBV90dWXKDmHY/rpx3R
         lypg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791404316; x=1792009116;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=e5Nm4HCEgY1Zc46v0F10qQolFAbTP8DxnjvFTksX9bE=;
        b=sWm+jRh2oCJaq0C2CBLZ7IdIfuDEQznV9AyAs2jUv6gv6YR1uukCRyqDffG/FVQeo8
         B8EvErl13G67Wh5dG9hUBkr7cBR7OQUdKGuPgBqtry/W7QJ0RxXvmC9VppBmBD9W5T1Y
         h48602oRB3a31Uatgs590QjOp4kC5jRg/ltdCWvn2IEgyd4PJ9y9DaTd6FOu7bwNQZED
         BnF+qJuiNHKkjf9iP5JImlNYwjPBR1zLtLKC8LjHzJzfiWaT6DDxaKzE88T3LYYdByvw
         Dreo9HIcACcsfTROauvJ5TjpvdSXXfDSdJCI4oF52B8PV+Ob21mbHTL99WikL1gKT02/
         +k6g==
X-Gm-Message-State: AFq9FYIvIzZsvLUGF/bUUFm/OHbYLK3rnKWe4j5//LXiUTlAULXmRV/t
	+nnICSVNQfQ+NlvdvNNQnPArHST2eARdrm1XRRo2Cxd2GwbIvv42PFGAkn2WoQ==
X-Gm-Gg: AYBFou1XbfvkY+6nESKrPa4XcHYvAS0/Kfu6PLpyn/uqMZ1WK42QUGxCei02wZ/kodo
	4Sj58skSYc1VxBoQs/N//o7c3Y8uaYHw2baP6n0qIRUlOIqgEWe2Lafza+zYz3cdxQVqJyNPKX2
	O3Ps8MR4o7mnAYyuAWHB3v7bVPPE2f7p4HU4lxNQvJPl9U3E9dmS4V2TrolEQ4ayfrAbCc+IXmL
	Z7g2HNRNJyIGi/zCzylaJCv4sDWA8jDomia1xtkq6tqSpkOUPdDdeOWDIK+LoFl3RRck4ET0Jwt
	rVhNoqo0ttaNK3Sp6DKW18CGLt9kOfhagqjN9AIrZLmYjjOpVKEthyyFzROXWpfw2TsJY+tj5qW
	G6MlPbEiotCE0ZewJaOU7U/YX35lYolx0GvYOmBgYHss4Z/AtB4hoju9NZKC4W9X/NfqPE9CsRt
	ZpbxPcH2ul/7BJ1NxMxKUtTWhaspQYmRkXhXhky0lLV4DbR2EjoKqRmHFC1V9AXNHt+rELKV87Z
	tFR2i6c1dn5FgVHunWIJjNd/hIxcJ/nPSIPf7ur/QOAXAiSaN2RiZZGuV7JpPSnKaYmF6p8l92f
	Qzu+dS6tr7e9Qw==
X-Received: by 2002:a17:90b:380b:b0:3a8:86d6:aab2 with SMTP id 98e67ed59e1d1-3a8a1e3ecbfmr2983641a91.63.1791404316458;
        Wed, 07 Oct 2026 13:18:36 -0700 (PDT)
Received: from 4470NRD-ASU.ssi.samsung.com (c-24-19-224-150.hsd1.wa.comcast.net. [24.19.224.150])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a9ff7ab034sm967623a91.4.2026.10.07.13.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 13:18:36 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
To: linux-cxl@vger.kernel.org
Cc: nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Dan Williams <djbw@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Ira Weiny <iweiny@kernel.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Fan Ni <nifan.cxl@gmail.com>,
	Li Ming <ming.li@zohomail.com>,
	Benjamin Cheatham <benjamin.cheatham@amd.com>,
	Gregory Price <gourry@gourry.net>,
	Richard Cheng <icheng@nvidia.com>,
	Anisa Su <anisa.su@samsung.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: [PATCH v15 1/8] cxl/mbox: Flag support for Dynamic Capacity Devices (DCD)
Date: Wed,  7 Oct 2026 13:16:34 -0700
Message-ID: <20261007201828.952-2-anisa.su@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261007201828.952-1-anisa.su@samsung.com>
References: <20261007201828.952-1-anisa.su@samsung.com>
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

