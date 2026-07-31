Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5733A3AAF65
	for <linux-cxl@vger.kernel.org>; Fri, 31 Jul 2026 08:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785487770; cv=none; b=YzvX3wzE0icpMRacNdJgyqWlRudGfqhUGbWd3Ni7zWX55RqxQrK/ZxFd6ZnrTeYqYNSAmC+vDtuOYw25aymps37L6mfRwW8FhyZBDNcM8o4VAYg3yvxaFnztHi6k2eY1B706dIVsm33a0ZMGW9nUKBAPRmJfovV8GliJH+EUZMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785487770; c=relaxed/simple;
	bh=XYCPrEarp34OaxCJDCO8652G7vPD8QRseTGPqPxUGlc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XfbM/QopelODO3F5pxglJi1Ry6w6G7T+VzBexawTUDTh98Tr/xY2NKQju247Ju3he3kKq1xEXL2v/SOo4oibKHGRBGrM4KhQhPYIqw2tnbL2POiVXqF3h4x9ohmfIcfgBINZJPSbGBFu5x3um92uu5qb27WHPNxW4+ZF7Da4va0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fa11VHRn; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fa11VHRn"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2d032846c95so7794455ad.1
        for <linux-cxl@vger.kernel.org>; Fri, 31 Jul 2026 01:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785487767; x=1786092567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b4KDHY++FP3qIPmrM4bkpQdwzqFZC4sRb/8sm6+ifG0=;
        b=Fa11VHRnaczRk2OeBvlL0+spkgLXULMZZOgWmzNPmxEAHPCyZXVTpE48l21mlIwrrF
         WWp8NC9PyPBKsxERItUCqI79RRkKsworlENInv1/2EtBk7hhHbH63SgiQ/1m2aFDHoVt
         fX5QljlD8icy795L5XQ5T/aqQ0dNRrpZT/dU9Fk59CTyKgC+NVtqlwN+mn4p6cpb070L
         kQxBvMci0EpqHJP73XdcNbVkn56bk0mF8pCVuHmErbYiOlbFKYaRsBV9X1CQtISBuk5Y
         MnJZNF/56ZWXh48dUu8PksuPYSBC2j5A4Bd7FUcFyHISGN6b9v7AcwLtONuaL05IjkQS
         NKtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785487767; x=1786092567;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=b4KDHY++FP3qIPmrM4bkpQdwzqFZC4sRb/8sm6+ifG0=;
        b=LZAvVwmEHgalU6Jq3keOmPptY169u3t+Grlk7ECZtm59TIr2jWoj5hAUODAIs72Z26
         oH+nRfGpBexw5WLbmyEW3Rnezl3x+g+cZvNYYi2Eadc3YyFWIv8qUeWfCh5XSeBUO2gF
         OjXrNwOr6OYmVTv8IXflUsOyyJqyXwcNrCpankU435hbwgsyS+xTAl8AUvXaOAG9SUX6
         DPOFmgcMkaxaeikJUqhfqSGZGMrPhOoxo7QoUEpjhRIB3AKqZPQ3DJpsVStYRkrBP2Je
         7hYz2m4B9t96fJiyct4qIqOY/GY/A+FiX6hz6IJB3mvvU1q2ioFdrLsjv48SuJdy+A3X
         0aQw==
X-Gm-Message-State: AOJu0YzkWFbSmmrXMaBIAUWoVoEQLK9DlYjlZjKsTM5CEtNezPaw2+m6
	EEWTg8O6KkSe9SL2h1dJ3npxpn5w5KnUX/J0XgaaY3m7FM/qeAFIx6llpiSZiA==
X-Gm-Gg: AR+sD12mTN/Mu32CA6JdZyC0cM68AOw1Sk0ZCzo/QhLdNmOIbmC2ghQ5eIHlrogcys/
	AK/Jz6ud+5rO4ObWDqSjkKeVCpWKIQq3lwnMAIdklYuxq0BEaZAmea7cGtNfgljRb56n0YsPubc
	PwH1eHF6rc5M07jm9LpUjm8794BC2cXODLq0LRcmID7HCBoepO2f53j1iStX3QXEilL8irtf/gl
	AM/hYOEHjikdtex9rXyj9Sh9Mt66dDHyWpYJtkKqyOiqJ2cSyrPQeJs0VmmYcvgi0pgQ2romrtn
	YoMDOEmxn474t8ZPgnZ/tdOx60wm8smm+9O6XpaFADOb/CYHyIeiWBc7x5tBbZzwtUcFLRsceVP
	xJh+yjjfrWlntqQxDJrY9wcMzDNq/dPIZrH4tLfvKzNvIe4Wi89ObcjzWvnJhnzgewR1TAKhMIB
	6cdrob3JhEIwrPPfZG74zyy8Sh6T9fa3UOeCwJ5vnFOMHHt0zWsxSsIRNL3tiJk6X/T+lT7r+uh
	BYnThxzyWjNo+b1HOaX5RH3f1wRwTnTZKbgnwRM3HEh
X-Received: by 2002:a17:902:c407:b0:2cf:a1c0:d4ca with SMTP id d9443c01a7336-2d046e4e65fmr13231395ad.22.1785487767301;
        Fri, 31 Jul 2026 01:49:27 -0700 (PDT)
Received: from AnisaLaptop.localdomain (c-73-170-217-179.hsd1.ca.comcast.net. [73.170.217.179])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d04ae5abaesm2708425ad.27.2026.07.31.01.49.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 01:49:26 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
To: linux-cxl@vger.kernel.org
Cc: nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Fan Ni <nifan.cxl@gmail.com>,
	Li Ming <ming.li@zohomail.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Ira Weiny <iweiny@kernel.org>,
	Benjamin Cheatham <benjamin.cheatham@amd.com>,
	Wonjae Lee <wj28.lee@samsung.com>,
	Junhee Park <jh9934.park@samsung.com>,
	Heesoo Kim <habil.kim@samsung.com>,
	Anisa Su <anisa.su@samsung.com>
Subject: [PATCH v12 1/8] cxl/mbox: Flag support for Dynamic Capacity Devices (DCD)
Date: Fri, 31 Jul 2026 01:48:06 -0700
Message-ID: <20260731084901.1512819-2-anisa.su@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260731084901.1512819-1-anisa.su@samsung.com>
References: <20260731084901.1512819-1-anisa.su@samsung.com>
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

Based on an original patch by Navneet Singh.

Signed-off-by: Ira Weiny <iweiny@kernel.org>
Signed-off-by: Anisa Su <anisa.su@samsung.com>
Tested-by: Wonjae Lee <wj28.lee@samsung.com>
Tested-by: Junhee Park <jh9934.park@samsung.com>
Tested-by: Heesoo Kim <habil.kim@samsung.com>

---
Changes:
1. mbox.c: leave mds->dcd_supported false so the hardware enablement
   patches can be upstreamed ahead of the extent and DAX work; the
   event handling patch re-enables it.
---
 drivers/cxl/core/mbox.c | 44 +++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxlmem.h    | 20 +++++++++++++++++++
 2 files changed, 64 insertions(+)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 7c6c5b7450a5..4790524c32a7 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -165,6 +165,38 @@ static void cxl_set_security_cmd_enabled(struct cxl_security_state *security,
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
+static bool cxl_verify_dcd_cmds(unsigned long *cmds_seen)
+{
+	return bitmap_full(cmds_seen, CXL_DCD_ENABLED_MAX);
+}
+
 static bool cxl_is_poison_command(u16 opcode)
 {
 #define CXL_MBOX_OP_POISON_CMDS 0x43
@@ -757,6 +789,7 @@ static void cxl_walk_cel(struct cxl_memdev_state *mds, size_t size, u8 *cel)
 	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
 	struct cxl_cel_entry *cel_entry;
 	const int cel_entries = size / sizeof(*cel_entry);
+	DECLARE_BITMAP(dcd_cmds, CXL_DCD_ENABLED_MAX) = {};
 	struct device *dev = mds->cxlds.dev;
 	int i, ro_cmds = 0, wr_cmds = 0;
 
@@ -785,11 +818,22 @@ static void cxl_walk_cel(struct cxl_memdev_state *mds, size_t size, u8 *cel)
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
+	if (cxl_verify_dcd_cmds(dcd_cmds))
+		dev_dbg(dev, "Device supports DCD; capability disabled\n");
+	mds->dcd_supported = false;
 }
 
 static struct cxl_mbox_get_supported_logs *cxl_get_gsl(struct cxl_memdev_state *mds)
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index ed419d0c59f2..616eeaeee5b9 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -252,6 +252,20 @@ struct cxl_event_state {
 	struct mutex log_lock;
 };
 
+/**
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
@@ -446,6 +461,7 @@ struct cxl_memdev_state {
 	u64 partition_align_bytes;
 	u64 active_volatile_bytes;
 	u64 active_persistent_bytes;
+	bool dcd_supported;
 
 	struct cxl_event_state event;
 	struct cxl_poison_state poison;
@@ -507,6 +523,10 @@ enum cxl_opcode {
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

