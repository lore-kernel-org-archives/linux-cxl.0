Received: from dog.elm.relay.mailchannels.net (dog.elm.relay.mailchannels.net [23.83.212.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36AD620330
	for <linux-cxl@vger.kernel.org>; Wed, 19 Feb 2025 02:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.212.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739931759; cv=pass; b=Q1tn1bTo5ylw1jsP8UI/Pc3Q4DyddLwwQQH4sAuIFxNWvLiErXw7j3x/2Al+qjYEljRuybw1IZnOiq9MlKbuNhv9e7TeUrx2VaJo3QG9TWD1yixsXicvbd9TpBkKsTljsWkhcZQU5AMCku7K49qr81+Nu1683M2hMJ9B2a1Vn3I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739931759; c=relaxed/simple;
	bh=fixYkbbpMpN+IFI9hXDzeqe1oXfjB+UxqhKAOZJeIHs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TWBSO3ocphvVAUOYiwwFHfWi+Jzs+JWLrb0FvgXumvFahiVkGdhp3bfL4t2pW42aGwIMf5L+8kShjOZVcd1/uBCmQ+pyQxMNggNXbZJ2WZ44+CtJZADsKsdoxlkVNhNBPTbnWbRzMmaR2hdbim/ejsNfHD4BmFRyu+0vX5BluuY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=awPc35Ak; arc=pass smtp.client-ip=23.83.212.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="awPc35Ak"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 5CB618A4748;
	Wed, 19 Feb 2025 02:15:28 +0000 (UTC)
Received: from pdx1-sub0-mail-a289.dreamhost.com (trex-2.trex.outbound.svc.cluster.local [100.105.228.217])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id B80BB8A4740;
	Wed, 19 Feb 2025 02:15:27 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1739931327; a=rsa-sha256;
	cv=none;
	b=8hQiFzP6HIS/3PseibBA59CR2WO/bDChr62aVzDweYzOH2PLAyhuBb53WnrcS3WBer6vAu
	uu6QcUrABfchXiVwpUdbCkICGBbpFPIQxDQX6d/JbpPwC5gx+C8fSOHqchNEaG9QfwQ1UJ
	mOSAKZveHdoqW4TIG+dra5VMgAdt52UGpQQ1aTd2ryW5lWKLf3p3mLqWTGFg61bawyQJKq
	xtBleqv0CQFT/LE+1465X/Nw2r0C4w3N26ylxvMQt3A2CQ6vNI9vbj5/A/wHLP6I7kNOWn
	rzhBh7SpSDIXhBsk2Y5U0RkdwHXiH5r/lI2AMCW6r8Gvu6RILyOOAuTHqQRYcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1739931327;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=OgVWa1w0Glp7+aIcrEC6ne8i2ADuKDrBVq8uQMTjI+0=;
	b=lzs46WcqxfsDtPSZzeiBdfQaROrsTI/9bdy4nKwUolGSr1rj0jIsOwU9ZKlfP7GdOmDpvz
	zvt5xggILjuycVUDAB9+O2uabMiaTOuOgXtDa1hqvMflD9NA6Iywp6rwzhyH/HglIRyxTi
	KscMlmdEr/dOXNshMzAFUlsaG1WnWKHW0PIEL+vqM/5DJtlN/eVd+FRm1noJmVnDD5UCkL
	VyyiGUYym7Ae46wiaYU7TdweU5FQrHtAJC+EeSHFzlh+GNaflj1CCBRc/PL9d/l3OvSh1l
	LEyv8azp7iQDOBj6XeC9Nw9w4OzUBnN5SIRCl9DJWPLyeEY0LFMrYEpYAuBdiw==
ARC-Authentication-Results: i=1;
	rspamd-78ddd997cc-phtwd;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Suffer-Abiding: 4c5590c55fa205b2_1739931328041_1896423367
X-MC-Loop-Signature: 1739931328041:2130400324
X-MC-Ingress-Time: 1739931328041
Received: from pdx1-sub0-mail-a289.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.105.228.217 (trex/7.0.2);
	Wed, 19 Feb 2025 02:15:28 +0000
Received: from localhost.localdomain (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a289.dreamhost.com (Postfix) with ESMTPSA id 4YyKjp6xWNz7x;
	Tue, 18 Feb 2025 18:15:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1739931327;
	bh=OgVWa1w0Glp7+aIcrEC6ne8i2ADuKDrBVq8uQMTjI+0=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=awPc35AklAE4JEk/OK0cilNs2fH4oT73j9I6Jwif886mJWV7KgtkfX3dcGqMhgX9s
	 xUT1UvbCgHEbqh924js/IJx4jWcUzgsmqJGhhVVyHswt2A4VmWxjY7ch7Ne2h8+aKR
	 /nAUZwkiLdCXTMyP+8CRC7RRzNGMM+r7aGYJEQzuszLl12febPzEl7ve1mqWdeA8F/
	 C3W18+FwcDPMhWjc9yJrBLwgRs2u9PMyCSvHZlnLdBNmVQXTcuOzDAdoRDRD4GRZRW
	 f/Arj4taYt3xt8jzwLXt9mpcBfRWdm4+JspPtMX7Yjh4GKdDx+ltSzZynuIFVcI8tJ
	 vVrGDcE0qejkg==
From: Davidlohr Bueso <dave@stgolabs.net>
To: dave.jiang@intel.com,
	dan.j.williams@intel.com
Cc: jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	ira.weiny@intel.com,
	vishal.l.verma@intel.com,
	seven.yi.lee@gmail.com,
	a.manzanares@samsung.com,
	fan.ni@samsung.com,
	anisa.su@samsung.com,
	dave@stgolabs.net,
	linux-cxl@vger.kernel.org
Subject: [PATCH 4/4] tools/testing/cxl: Set Shutdown State support
Date: Tue, 18 Feb 2025 18:14:20 -0800
Message-Id: <20250219021420.214991-5-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250219021420.214991-1-dave@stgolabs.net>
References: <20250219021420.214991-1-dave@stgolabs.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support to emulate the CXL Set Shutdown State operation.

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 tools/testing/cxl/test/mem.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
index 495199238335..832680a87c73 100644
--- a/tools/testing/cxl/test/mem.c
+++ b/tools/testing/cxl/test/mem.c
@@ -65,6 +65,10 @@ static struct cxl_cel_entry mock_cel[] = {
 		.opcode = cpu_to_le16(CXL_MBOX_OP_GET_HEALTH_INFO),
 		.effect = CXL_CMD_EFFECT_NONE,
 	},
+	{
+		.opcode = cpu_to_le16(CXL_MBOX_OP_SET_SHUTDOWN_STATE),
+		.effect = POLICY_CHANGE_IMMEDIATE,
+	},
 	{
 		.opcode = cpu_to_le16(CXL_MBOX_OP_GET_POISON),
 		.effect = CXL_CMD_EFFECT_NONE,
@@ -161,6 +165,7 @@ struct cxl_mockmem_data {
 	u8 event_buf[SZ_4K];
 	u64 timestamp;
 	unsigned long sanitize_timeout;
+	int shutdown_state;
 };
 
 static struct mock_event_log *event_find_log(struct device *dev, int log_type)
@@ -1088,6 +1093,21 @@ static int mock_health_info(struct cxl_mbox_cmd *cmd)
 	return 0;
 }
 
+static int mock_set_shutdown_state(struct cxl_mockmem_data *mdata,
+				   struct cxl_mbox_cmd *cmd)
+{
+	struct cxl_mbox_set_shutdown_state_in *ss = cmd->payload_in;
+
+	if (cmd->size_in != sizeof(*ss))
+		return -EINVAL;
+
+	if (cmd->size_out != 0)
+		return -EINVAL;
+
+	mdata->shutdown_state = ss->state;
+	return 0;
+}
+
 static struct mock_poison {
 	struct cxl_dev_state *cxlds;
 	u64 dpa;
@@ -1421,6 +1441,9 @@ static int cxl_mock_mbox_send(struct cxl_mailbox *cxl_mbox,
 	case CXL_MBOX_OP_PASSPHRASE_SECURE_ERASE:
 		rc = mock_passphrase_secure_erase(mdata, cmd);
 		break;
+	case CXL_MBOX_OP_SET_SHUTDOWN_STATE:
+		rc = mock_set_shutdown_state(mdata, cmd);
+		break;
 	case CXL_MBOX_OP_GET_POISON:
 		rc = mock_get_poison(cxlds, cmd);
 		break;
-- 
2.39.5

