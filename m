Received: from duck.ash.relay.mailchannels.net (duck.ash.relay.mailchannels.net [23.83.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22DD9136A
	for <linux-cxl@vger.kernel.org>; Tue, 17 Jun 2025 19:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.222.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750189635; cv=pass; b=muySdWAx2rsOqUQXFQe2URIfGHh3e3olttdsm5Ti8uNthxFzWIkIK0TWr5GEMy52Ke3E5fpM0yx3lpuGiLWinM46Iiswxy+jQk6opBlGKGxadADAQVQLY0h9R7nfFQSzeb82HO8s/+7ZDqQf2mY1Kx4UGrQ/qfwzQIhgrT5m9lI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750189635; c=relaxed/simple;
	bh=dqKonp0b9d2DFwDPnM0r9T7TjV+8T9HeW7wilH3Fk48=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Wpe/AsLAsPIMa8DiZo5svExrpDrN9blI0nP15nPqU0z5FbN8wojFa4bjUmGR7FIb5101ZJ/68yCptlcjOenMXbYXMf5nRxXq/qhsb8k9wXrNuZb4+jrbrxxcsY89tl6kimZYparcvfwebTQ7wy5IN1M9IVG796J8Y6zwlEUBjKo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=UDfHd9Hi; arc=pass smtp.client-ip=23.83.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="UDfHd9Hi"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 8D1861A4DBA;
	Tue, 17 Jun 2025 19:38:01 +0000 (UTC)
Received: from pdx1-sub0-mail-a289.dreamhost.com (trex-green-9.trex.outbound.svc.cluster.local [100.100.12.242])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 18CDF1A4C0C;
	Tue, 17 Jun 2025 19:38:01 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1750189081; a=rsa-sha256;
	cv=none;
	b=AJE1eAalBq16tkqzcGRrt7HWV4TraJALYwkg6lkMc5r1xRD4vhCIZZ4rgrtzTLupel2KE6
	el14F9RQZApy0b47l2xBZj/QTFBiAEM+29t75rHcJzt3LkA5GAD7yLoFsnArwWBboGXsR+
	gparUu5dxvljY6j0SbNd+iS5rv/FS9iJOXR9pKA9AiWA3hyXH/lr+gt02T2pkxl+shrjRz
	g3exzqvZORpZ4cDE/rX35LsFfG9uHzdwBCsUffBYyWoZ69Ed/eLDq8ALqc1h7RTVEC90jq
	nRJNAiMFxfcmMbeJWYryZuUBaEJVs08BJM29mo05lRkA4lGgrO19AzO547+bhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1750189081;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=TSff8z6Q1M2QyHC4BXXMACojZ8Losyo8UAnEU3mutOs=;
	b=PQuRjd2DznglQ6WjH1YHSUlg76T2bFZXkP9NayoM0iyGA1pqoRmCXX5oW5T4c3esF0HUiB
	Yjcy1Z6Ne07sgb1exEFuw143psKnjgqp/Lf+Q3d2dN0PBPhJc+i0Bg0GTYqfCeO7gGpOfE
	P1BvgeziL4kmfCeBCh+t6KuFMQ2YKg7iOrmaV621JozM/1VMcXr52VgsHQao1NT5N9VWXW
	kiJAPDg3dFr2dBDJiix3aJEQUDTLY4261wVbs5N4IzIJaJ+dDNJZk/55UH3KqeRv8aXXrU
	aMQKcskjtVfbk3kDz4sz54juyfzsBvbKl4sQUCmbuoFVciWg+pYWeVl+a3Q4Jw==
ARC-Authentication-Results: i=1;
	rspamd-5859dfb5d9-nwn5w;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Left-Robust: 08e12f8c1678298f_1750189081420_2455194954
X-MC-Loop-Signature: 1750189081420:3589919271
X-MC-Ingress-Time: 1750189081419
Received: from pdx1-sub0-mail-a289.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.100.12.242 (trex/7.0.3);
	Tue, 17 Jun 2025 19:38:01 +0000
Received: from offworld.lan (syn-076-167-199-067.res.spectrum.com [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a289.dreamhost.com (Postfix) with ESMTPSA id 4bMHGJ0bY6zJX;
	Tue, 17 Jun 2025 12:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1750189080;
	bh=TSff8z6Q1M2QyHC4BXXMACojZ8Losyo8UAnEU3mutOs=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=UDfHd9HiknJbuDnmd/xJO9AMp2uaVCCKZr8GHmfWpkPy8S2TV6jiBYB65CF6YbGyv
	 ZUjP/uNOU8xBn0DTXvPCVlD1q+igRyoamwJ7+dErV+LQskmcRv89fTw6Y3K65PKIiw
	 henMC25VTApmaOJGzn4sVOyu0Oaz/ZUlaveEsNlmKE7k5ssT1BfTbJv1z1VNsYTnb3
	 NciaZIQGLq/1gfCha8pdVLyvmGOcHptZ9HKRpDQ6zVUpFov+in7ZEq0RqkrvIi3UiE
	 dTvAQLl4oMxt0sIrYFFKysWVM9uoCw8tkVceBeIAMOd4ttjFvPj8OL1krnUPyBytcC
	 56ZahM0K7MWig==
From: Davidlohr Bueso <dave@stgolabs.net>
To: dave.jiang@intel.com
Cc: dan.j.williams@intel.com,
	jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	jgroves@micron.com,
	ravis.opensrc@micron.com,
	fan.ni@samsung.com,
	anisa.su@samsung.com,
	a.manzanares@samsung.com,
	linux-cxl@vger.kernel.org,
	dave@stgolabs.net
Subject: [PATCH 1/7] cxl/mbox: Track background commands from CEL
Date: Tue, 17 Jun 2025 12:36:05 -0700
Message-Id: <20250617193611.564668-2-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250617193611.564668-1-dave@stgolabs.net>
References: <20250617193611.564668-1-dave@stgolabs.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remember whether or not a command is background-capable, per the CEL.
This will later be used to consult the bitmap to evaluate incoming
mbox commands.

Further, "enable" any background commands that didn't fall in the
uapi, poison or security categories, such as fw related. This prevents
situations where the command is incorrectly listed as unsupported by
the driver.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 drivers/cxl/core/mbox.c | 30 ++++++++++++++++++++++++++++++
 drivers/cxl/cxlmem.h    | 28 ++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 2689e6453c5a..4ea02f7a5b6b 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -202,6 +202,31 @@ static void cxl_set_poison_cmd_enabled(struct cxl_poison_state *poison,
 	}
 }
 
+static bool cxl_set_bgcmd_enabled(struct cxl_background_state *bg, u16 opcode)
+{
+	switch (opcode) {
+	case CXL_MBOX_OP_TRANSFER_FW:
+		set_bit(CXL_BG_ENABLED_TRANSFER_FW, bg->enabled_cmds);
+		break;
+	case CXL_MBOX_OP_ACTIVATE_FW:
+		set_bit(CXL_BG_ENABLED_ACTIVATE_FW, bg->enabled_cmds);
+		break;
+	case CXL_MBOX_OP_DO_MAINTENANCE:
+		set_bit(CXL_BG_ENABLED_DO_MAINTENANCE, bg->enabled_cmds);
+		break;
+	case CXL_MBOX_OP_SCAN_MEDIA:
+		set_bit(CXL_BG_ENABLED_SCAN_MEDIA, bg->enabled_cmds);
+		break;
+	case CXL_MBOX_OP_SANITIZE:
+		set_bit(CXL_BG_ENABLED_SANITIZE, bg->enabled_cmds);
+		break;
+	default:
+		return false;
+	}
+
+	return true;
+}
+
 static struct cxl_mem_command *cxl_mem_find_command(u16 opcode)
 {
 	struct cxl_mem_command *c;
@@ -757,6 +782,7 @@ static void cxl_walk_cel(struct cxl_memdev_state *mds, size_t size, u8 *cel)
 
 	for (i = 0; i < cel_entries; i++) {
 		u16 opcode = le16_to_cpu(cel_entry[i].opcode);
+		u16 effect = le16_to_cpu(cel_entry[i].effect);
 		struct cxl_mem_command *cmd = cxl_mem_find_command(opcode);
 		int enabled = 0;
 
@@ -778,6 +804,10 @@ static void cxl_walk_cel(struct cxl_memdev_state *mds, size_t size, u8 *cel)
 			enabled++;
 		}
 
+		if (effect & CXL_CEL_BACKGROUND_OPERATION)
+			if (cxl_set_bgcmd_enabled(&mds->bg, opcode))
+				enabled++; /* might be redundant */
+
 		dev_dbg(dev, "Opcode 0x%04x %s\n", opcode,
 			enabled ? "enabled" : "unsupported by driver");
 	}
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 551b0ba2caa1..5c7fd4a6704c 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -248,6 +248,16 @@ enum security_cmd_enabled_bits {
 	CXL_SEC_ENABLED_MAX
 };
 
+/* Device enabled background commands */
+enum background_cmd_enabled_bits {
+	CXL_BG_ENABLED_TRANSFER_FW,
+	CXL_BG_ENABLED_ACTIVATE_FW,
+	CXL_BG_ENABLED_DO_MAINTENANCE,
+	CXL_BG_ENABLED_SCAN_MEDIA,
+	CXL_BG_ENABLED_SANITIZE,
+	CXL_BG_ENABLED_MAX
+};
+
 /**
  * struct cxl_poison_state - Driver poison state info
  *
@@ -365,6 +375,16 @@ struct cxl_security_state {
 	struct kernfs_node *sanitize_node;
 };
 
+/**
+ * struct cxl_background_state - Driver background operation state info
+ *
+ * @enabled_cmds: All background commands enabled in the CEL
+ */
+struct cxl_background_state {
+	DECLARE_BITMAP(enabled_cmds, CXL_BG_ENABLED_MAX);
+};
+
+
 /*
  * enum cxl_devtype - delineate type-2 from a generic type-3 device
  * @CXL_DEVTYPE_DEVMEM - Vendor specific CXL Type-2 device implementing HDM-D or
@@ -484,6 +504,7 @@ static inline struct cxl_dev_state *mbox_to_cxlds(struct cxl_mailbox *cxl_mbox)
  * @poison: poison driver state info
  * @security: security driver state info
  * @fw: firmware upload / activation state
+ * @bg: background operation state
  * @mce_notifier: MCE notifier
  *
  * See CXL 3.0 8.2.9.8.2 Capacity Configuration and Label Storage for
@@ -504,6 +525,7 @@ struct cxl_memdev_state {
 	struct cxl_poison_state poison;
 	struct cxl_security_state security;
 	struct cxl_fw_state fw;
+	struct cxl_background_state bg;
 	struct notifier_block mce_notifier;
 };
 
@@ -580,6 +602,12 @@ struct cxl_mbox_get_supported_logs {
 	} __packed entry[];
 }  __packed;
 
+/*
+ * Command Effects Log (CEL)
+ * CXL 3.2 Section 8.2.10.5.2.1; Table 8-87
+ */
+#define CXL_CEL_BACKGROUND_OPERATION BIT(6)
+
 struct cxl_cel_entry {
 	__le16 opcode;
 	__le16 effect;
-- 
2.39.5

