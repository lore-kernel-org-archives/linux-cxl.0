Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7233326F29B
	for <linux-cxl@vger.kernel.org>; Sat, 11 Apr 2026 01:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775871617; cv=none; b=VB+rZRYIRYaMTtiviTpC7OT4kDWBT1YBxPijYVgVwSQHT4XyjUdKHxl/ntQGLqjGN/39iZTtrYRo038rY4anU7AOONVvy5Je/5xKSNUIpQ74Ai37nqNicdExT7dBoCT4njugrBkTvMVt7Mmpt77K3TeYBs6ImcezowQmtJPe7HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775871617; c=relaxed/simple;
	bh=bc329ZjKfsjEkL6SZyy8g7yHEPrn1HJgDl86cAwK910=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hqqMc8Nv7XWCFokvvucwfsSP0dVc/ztzlSuqQlMn4jdOrypjUo/DxfZInSWa5+S3d6dX8uIg62cG7gMvHE6yxTOPZPX9RJT6CrCjyf6VanywORjRHJ5H+mkCvWdeOAovakUGPjkNzw5jAqh9qISudYwJXm6r34vyjWxwbYKHV9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=byTnPBbP; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="byTnPBbP"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-793fdbb8d3aso30627097b3.3
        for <linux-cxl@vger.kernel.org>; Fri, 10 Apr 2026 18:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775871615; x=1776476415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M3OwZ94U8bDjUMg9dyoIVeXc+EhCZY7nOy8TPZRIabU=;
        b=byTnPBbPnZWKhqkbvWbjrTy925kHLFJyr2XC0w9thYFbn1Xlqin4lz+bnR9n7iO5MP
         WAgvX923VjalxWJTJoaHfGoCo7i5lGLKu2CMCPmD3eES8JJMPJzTP0WElWT/G4n+huGG
         lcABHgbusow2r6XF+7CiUGEICPgEVgizXEWrMPUzN0XaSCX2XUUGSBkO++p5E9FgS8Oq
         HWZe3w/hYDspzdmG21UU2LoagFVpl6Y2BsyzWTZd3tNveRo9CS2eglSS5aUHpPB51fZ7
         ZYKA40POLhRz60WfOtphBDCtORmjNX9ApAb8maXfQnnkseUEogSbIxoiwFNYuqSdRIIG
         c0fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775871615; x=1776476415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M3OwZ94U8bDjUMg9dyoIVeXc+EhCZY7nOy8TPZRIabU=;
        b=OiEN4htzi86KgRw19IPU+9Iy/qBvqu1ba6mMg8VooSw4ygj8/SGca3BCANA112vN83
         Vo8pZwVLvoZrLuLZltMYUb08VgSwaeX1t0CGsgh0HDupU1GNAks8Ya50pzYGnPpaKeSq
         FNPjg2irVHAR8IYc0LejvvK9xEegMRQ7GcJ0/Am6w92tkRf1LHhGmp/YsarcfPk2r6Kr
         RN6OA4ySzmkySvHO/w3Tq+dVkbwAXQbWk2eCn1aHFiwAgi0AHXp1Ne+inqmmKzOI2bmY
         izf5X9mXFmGShMp9HbsbAyYkqkBs1ySa4e1QoJIOOvdzgDPW7K9rMWyabC8aKZ1/PgVh
         ut5w==
X-Gm-Message-State: AOJu0Yxt0YGJCMEgnsglrKZBBgmocd523HFNg24ZzfL/2OxK4FMDyEke
	8Xe6STm963A9mwJSyvp6m2D0Vh7T3CnXD+NPibBq7fyUbMmPTEJlULHEfD2UNQ==
X-Gm-Gg: AeBDievos/8sEyJ3ThARqXl9sAtzt9tMJYNhFAEGvzmGmaO/+1mJnkWu2Y1xoK9Gn0i
	C7gsUlVAR0zZFPYgwIYdPfsoL+RicdYtFQHm5cpAzC75c7F99YQ+klBCkpk7klcNU4uqY6K0PR8
	DaA5FKq1QOej38WN7/k96Z8ZLB+0GAbXFUu4w0gxy6rmWaXMsh29srHZ/nMM0Bus1NORmC9QEw8
	bkGwU0X9Y4xrJMEf4CjLtgGRvgLv3RiS5FtZhpin+S51pFd5+sTrJdp8JNLyqtnUxO3f9OdNgnm
	g/7Vf4kJOpTrzNXKC9RjWgemVndVEwMbdkloXEJjmFJBfiQ632j1oyopgh6hoy/I0u5aHywSKnb
	/Tyl1HVaZYzxr+ilY6/KBJjtCYPFxxu3vOsljPom7/sZnPcDhnfsOFUWlzbP3zJKwM+p/qEjxCA
	QEmw6709dKMKO4HSDPO+WcqJ0eQu1ZBriv9jug1tn6uA==
X-Received: by 2002:a05:690c:448c:b0:79a:c40d:b734 with SMTP id 00721157ae682-7af71f470cdmr62288117b3.48.1775871615225;
        Fri, 10 Apr 2026 18:40:15 -0700 (PDT)
Received: from 4470NRD-ASU.ssi.samsung.com ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7af3fa06595sm21690547b3.40.2026.04.10.18.40.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 18:40:14 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
To: linux-cxl@vger.kernel.org
Cc: john@groves.net,
	dave.jiang@intel.com,
	gourry@gourry.net,
	dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com
Subject: [PATCH 01/20] cxl/mbox: Flag support for Dynamic Capacity Devices (DCD)
Date: Fri, 10 Apr 2026 18:22:56 -0700
Message-ID: <20260411013958.47422-2-anisa.su@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260411013958.47422-1-anisa.su@samsung.com>
References: <20260411013958.47422-1-anisa.su@samsung.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ira Weiny <ira.weiny@intel.com>

Per the CXL 3.1 specification software must check the Command Effects
Log (CEL) for dynamic capacity command support.

Detect support for the DCD commands while reading the CEL, including:

	Get DC Config
	Get DC Extent List
	Add DC Response
	Release DC

Based on an original patch by Navneet Singh.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes:
[anisa: rebase]
---
 drivers/cxl/core/mbox.c | 43 +++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxlmem.h    | 15 ++++++++++++++
 2 files changed, 58 insertions(+)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index aaa5c6277ebf..7ef5708bf210 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -165,6 +165,42 @@ static void cxl_set_security_cmd_enabled(struct cxl_security_state *security,
 	}
 }
 
+static bool cxl_is_dcd_command(u16 opcode)
+{
+#define CXL_MBOX_OP_DCD_CMDS 0x48
+
+	return (opcode >> 8) == CXL_MBOX_OP_DCD_CMDS;
+}
+
+static void cxl_set_dcd_cmd_enabled(struct cxl_memdev_state *mds, u16 opcode,
+				    unsigned long *cmd_mask)
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
+static bool cxl_verify_dcd_cmds(struct cxl_memdev_state *mds, unsigned long *cmds_seen)
+{
+	DECLARE_BITMAP(all_cmds, CXL_DCD_ENABLED_MAX);
+
+	bitmap_fill(all_cmds, CXL_DCD_ENABLED_MAX);
+	return bitmap_equal(cmds_seen, all_cmds, CXL_DCD_ENABLED_MAX);
+}
+
 static bool cxl_is_poison_command(u16 opcode)
 {
 #define CXL_MBOX_OP_POISON_CMDS 0x43
@@ -757,6 +793,7 @@ static void cxl_walk_cel(struct cxl_memdev_state *mds, size_t size, u8 *cel)
 	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
 	struct cxl_cel_entry *cel_entry;
 	const int cel_entries = size / sizeof(*cel_entry);
+	DECLARE_BITMAP(dcd_cmds, CXL_DCD_ENABLED_MAX);
 	struct device *dev = mds->cxlds.dev;
 	int i, ro_cmds = 0, wr_cmds = 0;
 
@@ -785,11 +822,17 @@ static void cxl_walk_cel(struct cxl_memdev_state *mds, size_t size, u8 *cel)
 			enabled++;
 		}
 
+		if (cxl_is_dcd_command(opcode)) {
+			cxl_set_dcd_cmd_enabled(mds, opcode, dcd_cmds);
+			enabled++;
+		}
+
 		dev_dbg(dev, "Opcode 0x%04x %s\n", opcode,
 			enabled ? "enabled" : "unsupported by driver");
 	}
 
 	set_features_cap(cxl_mbox, ro_cmds, wr_cmds);
+	mds->dcd_supported = cxl_verify_dcd_cmds(mds, dcd_cmds);
 }
 
 static struct cxl_mbox_get_supported_logs *cxl_get_gsl(struct cxl_memdev_state *mds)
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 776c50d1db51..53444af448d7 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -230,6 +230,15 @@ struct cxl_event_state {
 	struct mutex log_lock;
 };
 
+/* Device enabled DCD commands */
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
@@ -405,6 +414,7 @@ static inline struct cxl_dev_state *mbox_to_cxlds(struct cxl_mailbox *cxl_mbox)
  * @partition_align_bytes: alignment size for partition-able capacity
  * @active_volatile_bytes: sum of hard + soft volatile
  * @active_persistent_bytes: sum of hard + soft persistent
+ * @dcd_supported: all DCD commands are supported
  * @event: event log driver state
  * @poison: poison driver state info
  * @security: security driver state info
@@ -424,6 +434,7 @@ struct cxl_memdev_state {
 	u64 partition_align_bytes;
 	u64 active_volatile_bytes;
 	u64 active_persistent_bytes;
+	bool dcd_supported;
 
 	struct cxl_event_state event;
 	struct cxl_poison_state poison;
@@ -485,6 +496,10 @@ enum cxl_opcode {
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

