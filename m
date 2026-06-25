Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909533DA5B1
	for <linux-cxl@vger.kernel.org>; Thu, 25 Jun 2026 11:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782386861; cv=none; b=Toh/HQnGP8fcjjLKIkLJdmDAJdkrRdIbnGK5QiAQLdCn6++Z7Y3XnCG79k2RPnD6Iye3Xs5vHeSVuNEwsIfmzmrfKl5W6o4x5cCWgXr7ZXP77k4DsPyunrpoqbY4yZ+7Lr0nAs67tbP+neIBM7IaLU3EnwADQRJVP1iSwyKAuyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782386861; c=relaxed/simple;
	bh=5coC4Ng0U+2f5IPyy4HU9epy0iz53WLosocy1XVckYg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q2653z2mFNQ3lI77FNRJa2aJEJoYgixCyFZ6zphQBthzXBdogHpa5xXVwyMuGkP+Z6Fz0V8mvcQbeFAQIwtRFodOaWQIjRr+UOqEHv48p46ZixJDqpyX4kVBUueD+JxOBbmrzDXm9pFio2vl85X790RH7Tqnz8uFz4pqIfDHI+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DwMT0e7s; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DwMT0e7s"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-30bc871ecdfso2537626eec.1
        for <linux-cxl@vger.kernel.org>; Thu, 25 Jun 2026 04:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782386859; x=1782991659; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M7yqkLUJR7iA6d1P1y5JWiVkuTmcvilfiJDbVJ20RrA=;
        b=DwMT0e7s0tk3KtH6xWDvx28btH5b+OtDKMEzwWlwUPuKRE2cKw5Mtd6WIt0DQFH4Ip
         O90bWqb5gKgamgAwNjPa2ZyKBfYx9h1MuGe25GxB3VMujMUxN2qXF9Hc5Z4q+tK5uAPe
         TA0EYaE0nrAr0MaqHzyelIR5dBemyV7Qrkwa+n+8AKoTEHu25m3qeh/52yClZuRD3Ma2
         ZIhbbPTakQShWu218wuAaUQS0at/wNBW3dSHLoDxWQtZeMgMlJymTZYZG05K3E0ZAyuO
         81LO+8rhvDUGvYNeYYWODXGF73ov1tzMaU6sRvOV2M4IzFXAdMuJ+RJvw87GW1SJk+IB
         DcJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782386859; x=1782991659;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M7yqkLUJR7iA6d1P1y5JWiVkuTmcvilfiJDbVJ20RrA=;
        b=ieoPXU1MmqyCVsXSjLzntK0OuFwdYOKmIQ9kj+5zZWUNrRcJ8SB2M8NHqdzf3ScTLj
         04EXRyruT0/9CMhys+1wkocHL8oRmfLyExKvfrnbt3zazojkdSSrP0aTeYrqCsAjVjD3
         OBgbpnFoOKbLahl+h9JdmncSJRkqQNAIgXh4aJ3+7dPMojU0Co+PxoaG63BcbDxxNpWd
         saVbUSpaXrusqpNYvfEfeNFAhaRSiBYcwM54OxeTqXhsrJmq493y+2HpC1gFVJdcCAq0
         nq57Kpy4ZQUGk5sCRXv5sFB7OzTPCBvaN9cKPi9FR18sysg4TeKuP9ztao8libTKc26r
         P74w==
X-Gm-Message-State: AOJu0YxU/Na638qSR5KV1Nwe7uXQ3b8iFpM39oNBY7oYjNwevVsl1Rn5
	s7x3rleBkkGRaNzqQgzeIO7lfv7BB464+yTZqumsZBIk/p0Y7Fr7dTo6Xe/H6Q==
X-Gm-Gg: AfdE7cm7fbm83W/wUr3nRx2VW1+ib5khwaObdabPJaJzbfVSAhBegqbMbd1jM7NNs/4
	eIwAUksHoVqkFrBajSy8VEpeBfXkaisSD8z7usqHCBECOJ7QrhCpqkLePFO1b01qelvonMBRTpY
	xzwf+ckbVduAtpvA46TeVOQ+SIjrk43nlmo5qYdYmyyeqmpyPakXf3pD4dWG5V9RJEPPDTszfws
	SnOR/aCkRp9q/EgEwQ9dLL4HcOSAVvXlGxcGnnuey/Jt5KyO0tBiyHBZhWtQcq7grkCTAJt/sEh
	KhVz0WhiowHn2OvO9e8P39sH3drMe4MBdChh/ixcSuSjuelSY+vdPoxcGU3WuEDYgFY7AaEXIOr
	z9qB6A8Y3pU/z89z0FpDglrwVpjlgofzkdHO45g/RVNaS1OQxJWh4cd7nwbpy3QGkbVerRhyiuB
	lcG55FbcfSMxh3C4FxUjwIyWFQ+Vz2douD97/ZB6a5Zkb+ZO76cd2zlbKoTg0Ws0jIbQT8
X-Received: by 2002:a05:7300:d517:b0:30c:544f:a861 with SMTP id 5a478bee46e88-30c84eb7d9amr2260863eec.20.1782386858437;
        Thu, 25 Jun 2026 04:27:38 -0700 (PDT)
Received: from AnisaLaptop.localdomain (c-73-170-217-179.hsd1.ca.comcast.net. [73.170.217.179])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c7cab08c2sm8744614eec.29.2026.06.25.04.27.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 04:27:38 -0700 (PDT)
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
	Anisa Su <anisa.su@samsung.com>
Subject: [PATCH v11 01/31] cxl/mbox: Flag support for Dynamic Capacity Devices (DCD)
Date: Thu, 25 Jun 2026 04:04:38 -0700
Message-ID: <20260625112638.550691-2-anisa.su@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260625112638.550691-1-anisa.su@samsung.com>
References: <20260625112638.550691-1-anisa.su@samsung.com>
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

---

Changes:
- remove unused param struct cxl_memdev_state *mds from
  cxl_set_dcd_cmd_enabled()

- remove unused param struct cxl_memdev_state *mds from
  cxl_verify_dcd_cmds()

- cxl_verify_dcd_cmds(): originally filled out local
  bitmap with all DCD cmd bits and checking if cmds_seen
  bitmap is equal to the local bitmap. Replace with
  simple call to bitmap_full(cmd_seen)

- cxl_walk_cel(): zero out dcd_cmds bitmap before using

- cxlmem.h: Add comment to enum dcd_cmd_enabled_bits
  pointing to where the command set is defined in the
  4.0 spec

- original commit message referred to CXL r3.1. Bump to r4.0
---
 drivers/cxl/core/mbox.c | 39 +++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxlmem.h    | 20 ++++++++++++++++++++
 2 files changed, 59 insertions(+)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 7c6c5b7450a5..07aba6f0b719 100644
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
 
@@ -785,11 +818,17 @@ static void cxl_walk_cel(struct cxl_memdev_state *mds, size_t size, u8 *cel)
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
+	mds->dcd_supported = cxl_verify_dcd_cmds(dcd_cmds);
 }
 
 static struct cxl_mbox_get_supported_logs *cxl_get_gsl(struct cxl_memdev_state *mds)
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 776c50d1db51..60dc3f0006a7 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -230,6 +230,20 @@ struct cxl_event_state {
 	struct mutex log_lock;
 };
 
+/**
+ * CXL r4.0 Section 8.2.10.9 - Memory Device Command Sets. See Table 8-308.
+ *
+ * The 48h Command Set (Opcodes 4800h - 4803h) defines the device-enabled DCD
+ * commands.
+ * */
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
@@ -405,6 +419,7 @@ static inline struct cxl_dev_state *mbox_to_cxlds(struct cxl_mailbox *cxl_mbox)
  * @partition_align_bytes: alignment size for partition-able capacity
  * @active_volatile_bytes: sum of hard + soft volatile
  * @active_persistent_bytes: sum of hard + soft persistent
+ * @dcd_supported: all DCD commands are supported
  * @event: event log driver state
  * @poison: poison driver state info
  * @security: security driver state info
@@ -424,6 +439,7 @@ struct cxl_memdev_state {
 	u64 partition_align_bytes;
 	u64 active_volatile_bytes;
 	u64 active_persistent_bytes;
+	bool dcd_supported;
 
 	struct cxl_event_state event;
 	struct cxl_poison_state poison;
@@ -485,6 +501,10 @@ enum cxl_opcode {
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

