Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC313859E9
	for <linux-cxl@vger.kernel.org>; Sat, 23 May 2026 09:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779529416; cv=none; b=WjVDf0Co9b4kXLJ3UZqlsgI1+CjRwjdJU6YxVmW0nv9Hzot+0uU0x+8lmScNpJqJSXCH+Oesjfu66zwPtvD+hMVIJwbXEKc5+xSD6WqC3cp6PpHxmhb4TDI36r9+MHVl4M5qpUnPGWRnITX8CrGuKTyBigDdG2OvMGQQmZmuVSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779529416; c=relaxed/simple;
	bh=bc329ZjKfsjEkL6SZyy8g7yHEPrn1HJgDl86cAwK910=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z+xO1RpjNBb+F7VDbJlK9cbi+gCm1Gvf0edteE8BOO3MefuN5nSQC2jBj7vqspsTskPQSt7erUuuPpMD/qINdv/WLSh0NzUkNzEpCp9UUzBTCTl6lvfJwRElhfUrlSSoiT74jkkTFceACK28LKNhlr40cmcJB3LvyULj5K+pW7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=od0lZvQX; arc=none smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="od0lZvQX"
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-134fe980658so9935402c88.1
        for <linux-cxl@vger.kernel.org>; Sat, 23 May 2026 02:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779529414; x=1780134214; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M3OwZ94U8bDjUMg9dyoIVeXc+EhCZY7nOy8TPZRIabU=;
        b=od0lZvQXbNiXvjJkRt+WhMaFnJbjTHzdsf/wm8+YAymdd9TxqH/vAzljtkAHNPwYF2
         5YfZU33iixyziWXnydzTr/GZDBNbpkCCr6q49FEnqROPcimvv3WzDafDk6fsfSARELcm
         oVGP1Im10/GAelM866uBPLG+1mLrpM+85BQDHdBClHkehg+kEa8p1v2Qom82yq3iyzY9
         fGLQlHpjKi9yZmubhKrmqlpDIi8Fgm3jAFiEda4O32rXHNlmu1VGyKUF/260ehnxvQOW
         dbDYmLsAPErN0A2BPAtMDjxVzngrC6pBzJBuXX4pZJiAmbwjkIpOWqrh7nV4HTAQHKLV
         M4EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779529414; x=1780134214;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M3OwZ94U8bDjUMg9dyoIVeXc+EhCZY7nOy8TPZRIabU=;
        b=d9Y3VwB1KAtwyIFK3xQKYDoYCgapUNPeRgfsiW6HYQRj+oWtZWCHq3863MDD4fQkXV
         RlhH/00Kv0CUdaDXQpC+OAwjF0KbhLOU6I9aG/P32OhU05FzYKCQDHAKKbO9PFRzR4ul
         1ZoLfWzAOqadWAl13EN941E/T3srDtI9hJWsSWrs02M2jAveKyilnYuUsnX7UIz+/aMQ
         UBXy/ZDjYXiKxtqe6MHTois5zeBe1CNMujsDLbNg8JEPf7UogTyHi/N+c5rQI/QkogE9
         h0sTenj7rKdyjTuZ6xlMIR9WO1G06czohZnd0amq4euERJ6vzaQly8iKt60gWfjjSTTD
         /xCw==
X-Gm-Message-State: AOJu0YyoVoCBAAsvlIYD3efsFL1dlXxpH5s3Psn6gg1UWddvv7h1eWlm
	JVHctBRNrUIg78Yjg+QX9z4/0dRd4/VJjgtCqeazjt+N2wheavlFeXKUm3w43g==
X-Gm-Gg: Acq92OFHDmG9rDQNg9652Oys+6c0EumzvZ1pR1TKLmu7kZwDbexgyfgPupNxXYpTvv/
	YsmryqZGqqY+OTqJh26CeMuVQGKFaubqno22XeNYhvpc5unanIOFadYiIl6tNS5sk/0y1QHBApt
	STzlu8x3FXLNSiwoYXf2KzJAbtIlZJ10vaGhernYXUzRUSt1Y3LoPbE46MTDz2e7CW7qIC26jQy
	ZrrU0JYqHRcNoHFqPvrxKr8WP3+R8hiK/7oKdhE21c4UCHFe7nTKYgFxLXB3X3g42+AkOtjYVeO
	5gIB64z5A8vB1TKaTiABhjgJx58gAisidPZ9FzYCBd0EgUV/mD+YuJW7Q+BcRVpQmk6MoU4vBKK
	+i3Ynvha8d7TxxC5b/Yqnyk15njiM/t97TDRKjDMIpurq1juYNObwa3wmaK+SJ0GuDBSgkN5qDL
	Xw/RqirjlI/cltuGowgZlGrUjTpUgEKRBxoE/fU9PU0olqI236VXTqEaohZ5ZcuuAsc9CLCPhbd
	ukKu1E=
X-Received: by 2002:a05:7022:f313:b0:136:9ebf:3bef with SMTP id a92af1059eb24-1369ebf3d04mr123434c88.26.1779529414299;
        Sat, 23 May 2026 02:43:34 -0700 (PDT)
Received: from AnisaLaptop.localdomain (c-73-170-217-179.hsd1.ca.comcast.net. [73.170.217.179])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1366a40305csm2376358c88.7.2026.05.23.02.43.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 02:43:33 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
To: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: nvdimm@lists.linux.dev,
	Dan Williams <djbw@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>,
	Alison Schofield <alison.schofield@intel.com>,
	John Groves <John@Groves.net>,
	Gregory Price <gourry@gourry.net>,
	Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH v10 01/31] cxl/mbox: Flag support for Dynamic Capacity Devices (DCD)
Date: Sat, 23 May 2026 02:42:55 -0700
Message-ID: <4700826deb086665c9e1c643156864eaecfe1fef.1779528761.git.anisa.su@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1779528761.git.anisa.su@samsung.com>
References: <cover.1779528761.git.anisa.su@samsung.com>
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

