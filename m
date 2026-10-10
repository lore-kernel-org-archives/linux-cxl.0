Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C4B39EF1C
	for <linux-cxl@vger.kernel.org>; Sat, 10 Oct 2026 22:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791673030; cv=none; b=GPqWvl7WAcEpZaXWl/iL0UFcLe5xsk3uiJcmZVffuI6Y+uZGQjXYnMCRwELpXt7PZ/LAMQIl/DHjBPhZX3CgH39ax8DSivF4DPz/pppy4ZUw09XSLu4k9NlE2e47O9ILjyLfskzjoFGVaKirfWtlW5ROvXBfe51Dc48duY+MFnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791673030; c=relaxed/simple;
	bh=50YF1GRIAdh1pbM526fLR+jHhqN2rJgvJ/QgNd/p0D4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JqZeFl8BqJAdJspq/ZGcYaeQ/tTCDKW9FiwP7kCDpuxKleLJGblCTAFbN6bEWIbGOQWQD1egFQQCfGr4c8KlpEdmniWLA8jZVAsGTke0af+M+fnmCWzFSkMpY/CdSjl3WRD6QdzLXiPF/OsCfHds12tjOHwS2TPFRdIGmLWklqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ndc0ciYx; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ndc0ciYx"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-383b4a3755fso586697a91.3
        for <linux-cxl@vger.kernel.org>; Sat, 10 Oct 2026 15:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791673028; x=1792277828; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=n7emqRlU0MzXMkqE8ZjhvjRAJOSMNKDO1xaL6vJcVJs=;
        b=ndc0ciYxjWsA8z4dIiqDVn08t3BzwbwQv8+i8wh5tbKsQ//HX0f5vEGfvdxP2bcsmJ
         IlH7gUry+6IpQW9Ii/DWCR0u5qTSdQGr6PeB5xmWCmJrMH3Ur+bKW1EbT3MJjPFra/jz
         Gj90azYJyg9s7U6GQDBGbNQ+5GU09ztBlMgTYwqO3jrCd4Zkntl833nO+aP8m0+M5f6c
         PdUGqfjCZnQdHoKOy68AtJrPGoWSzv06BcKidJ2hv9d1I07sMbNDGCHjdRWZb4l5uA8U
         zUrEB2yZJPbPGc8y3eJ0nhfr1YqUVjTdWGVcFwAbkq0m1MQ+gZ0nxmzgjzRM7GBLn/o6
         sM6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791673028; x=1792277828;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=n7emqRlU0MzXMkqE8ZjhvjRAJOSMNKDO1xaL6vJcVJs=;
        b=EJi6sktH2lE8faIRhT6SxQZO8dDPEJktFq6bvgIeGn2Sm8r16oZKRsWtZdAfM9UEnq
         8O/OyaulJZCYLN3A2vIU9ZEn30QTUboxt8d74EL7gc87rxzsdsbgZZsck1hHuBEb1Whe
         s4HT2PJsWQhzwxDqRu8XBS8qBzwGLsFopYKgNsmiv4sWoBzqXW9eWRqdJIpUZHij+FER
         aE674OkLQrizo2EvCR86Me7yFCrN1jYbvj7fJxeVXn6mbx+zK265/SE2tpl5j8DYoqtA
         CeRHnIg0DvUkA5Kjp/Rl108/QhO5lXWDm5Ovigzcc1Z4rZXyrZllzRxUavGtRbWVLFkE
         Zm/Q==
X-Gm-Message-State: AFq9FYLR+V9wzVnqtnmJOfKWMj/MuocIJbeOK6MJkkh5co0dNnONTruN
	fcaL2THzGDly++enHmBIlMrY3FIABDasjuwmPPR7m4qZg2HF2PiLFwoPFv/bZMpK
X-Gm-Gg: AYBFou3tThejkx7LQqTxrbqmOtzZo231BZML6oZro15V2KQGiztoDx27rh3WY6r0e6S
	icjw+qMl2a6Vbwg5zgRT7s8rqwJftDYCPn+gJbGJ9s3/kyW0hbF1wrRyROpmnXNp5i12MK4saPT
	I6VVWEifCrDo4nWStLpKbxPPfyuQf5EIDzed6Jbpwajno4j/Zl4AIAYXVbiOEWLBm5iISFbILIS
	jIOA3hNRz8Ow009loOEjFONEIUOUhrOxC4spZRUYzX3UqCVQyViKjTjq/gOC++Auql0TsSSmOqG
	gmrTdeFwgqkwIQ//jileUIM3HBljsBXTPXJoVhuu5Hky6tk8VMXaqqV4MCMbxjGmcfsgM2kkn2v
	jeBY3IZ4S+VmJEAHqxDSu5mbewDMVVrcvWN8y+m+i3Y3LFU7E7OAkz+wpAHO+QwDPIl/nM3gB4R
	KE47Rh3LsbtRb04ZzKGE2HKSxaLPVMILazAmHrRtVaM5s33qGQ0HIkgPMuNimBwf1TqAxiEDgYc
	GObSbPTlSRlBzh29+Cd0shQYalt
X-Received: by 2002:a17:90b:1844:b0:3ab:188b:c5bf with SMTP id 98e67ed59e1d1-3ab3a955af4mr4973848a91.18.1791673028071;
        Sat, 10 Oct 2026 15:57:08 -0700 (PDT)
Received: from cxlqual.. ([220.120.90.131])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd3d9e07329sm2603662a12.5.2026.10.10.15.57.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 15:57:07 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
To: linux-cxl@vger.kernel.org
Cc: nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
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
	Anisa Su <anisa.su@samsung.com>
Subject: [PATCH v16 1/8] cxl/mbox: Flag support for Dynamic Capacity Devices (DCD)
Date: Sun, 11 Oct 2026 07:54:52 +0900
Message-ID: <20261010225852.10727-2-anisa.su@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261010225852.10727-1-anisa.su@samsung.com>
References: <20261010225852.10727-1-anisa.su@samsung.com>
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

