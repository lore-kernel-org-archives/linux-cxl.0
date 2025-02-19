Received: from crocodile.elm.relay.mailchannels.net (crocodile.elm.relay.mailchannels.net [23.83.212.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0417E4C6D
	for <linux-cxl@vger.kernel.org>; Wed, 19 Feb 2025 06:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.212.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739947161; cv=pass; b=II3kvQgJ7qRe1NJFbI9t6oSFznQTk2LF100XUgKPZqiUhFjWBOVbjuBrpgAmv6VbvqbeP6ujN7RC2r2EJOc+c0cLg3jQyL6yvceFrhxMMZPvGpGi1TAyv7p8CIL5qdUmV444+q8b9eSfEhENyGqC/azerGhVhOXOcEawdFAkVa4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739947161; c=relaxed/simple;
	bh=fixYkbbpMpN+IFI9hXDzeqe1oXfjB+UxqhKAOZJeIHs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oUk9wnZZFqj3isVith7nTKln6o7sAnCZ6+rc9cik7d4YTlMhQbSXyHom1GHM0FFL8Xn0wEnVddwxIVXLpU0mlZHZWV0/infHTOFV2OKCD4Xp4JsawBKxgjL9snelyMuYgqqJfQkdD1gUFDjABk5KlwhNfo45Sd8Quvs/609rr2Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=ZXAynl5i; arc=pass smtp.client-ip=23.83.212.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="ZXAynl5i"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 329721C0579;
	Wed, 19 Feb 2025 06:29:15 +0000 (UTC)
Received: from pdx1-sub0-mail-a223.dreamhost.com (trex-6.trex.outbound.svc.cluster.local [100.100.209.197])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id B468A1C0850;
	Wed, 19 Feb 2025 06:29:14 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1739946554; a=rsa-sha256;
	cv=none;
	b=zu4M2Ib9Uy9tw/jt97ToxDceD+xO6Tm26ps1EIhWbJI06Fhd07b7tKXb/k5Mk8IqtcbtjH
	gFPom+XQfmPrwCaIIIzn0DlbkNQmPyDJjDcSAMBlPcOqDI2Wf6m/3a7OSjabObkWnkb6Iw
	xbsWheEygt/e3YBVF44fjw5uZyDtfD8DeQgtxiI5LwlVR/BmTvzh2IcmlwUdxnL/R/m0IE
	zmwqUw7v3PvsiBTpcU94EgxHQSjWRPCnC51NQMz5ZlIi0cIClP6rz/TSgqEaqvB59upgiy
	eQ0eZlvCBLgfvgTWdFLUk+SizAONUKbajdQ34yTMHsvbm5lZFEpcoRDkFzZluw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1739946554;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=OgVWa1w0Glp7+aIcrEC6ne8i2ADuKDrBVq8uQMTjI+0=;
	b=eevlA2yNdCofZFNpPbGXjcUomdENiUljyfgHXTilQ2znBYSvt6pfUe1NfJalyhHpTEcW/a
	sd4pv3k6BrgxRv3mfquYtYAOIe1B8PLtFwjMa+bJF52B0t1Bxagm2WhhWY0pb8IdUYIXaJ
	5pnYWUuPCo/TV/pnHZJESq9mMVbfUiGNlsKxPtYdUtBw1DDOKRpzb+n2NrAoYVAXNMyd3E
	KJIjM7Gq397tCsvhHvZvvZUMzvr3UahNn4ckIslSzA5tcjvZcIQO3aG+yZfAKH2JZqmIuw
	77ZuCt0v/DDIAhf+0EAnI4/Afeii1mU/9F2zrZshX3k6XeUr+JVLMuB+rfzH0A==
ARC-Authentication-Results: i=1;
	rspamd-6d7cc6b78d-cf5kg;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Shrill-Name: 21cbc419396c7fc6_1739946555096_3204543989
X-MC-Loop-Signature: 1739946555096:3694675468
X-MC-Ingress-Time: 1739946555096
Received: from pdx1-sub0-mail-a223.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.100.209.197 (trex/7.0.2);
	Wed, 19 Feb 2025 06:29:15 +0000
Received: from localhost.localdomain (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a223.dreamhost.com (Postfix) with ESMTPSA id 4YyRLd5ZP3zFb;
	Tue, 18 Feb 2025 22:29:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1739946554;
	bh=OgVWa1w0Glp7+aIcrEC6ne8i2ADuKDrBVq8uQMTjI+0=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=ZXAynl5i13g0m1CFKQyaHE1TsIS/PUf5KQKsqz+zKwVHGtCIcZM66pi2M7ck01ZRl
	 dallz4cX6q18p30vPLl5xTRxr+bTbpqqmrkpzRUmtU+V4/hbC2I8uKE4CEVBSxXvRC
	 SoQEM9hg8rPejXBvom79JCMhiEt0IklKl2tG0l3n549k+eZQ2S6lm3aCchrZpdoYDP
	 u6UC0jwvTVntDq5+KqY1ekhRM63zk5ayT8d70q0Pv5sNXV7GaWKrhukxaKrp12uMAQ
	 zbJEe7nYWZZpvjhBAmdztcn+QJy7iOVl14uZHessujgzS9meAStN7I74biD7IyAkBO
	 jbs17t447/SMQ==
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
Date: Tue, 18 Feb 2025 22:28:32 -0800
Message-Id: <20250219062832.237881-5-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250219062832.237881-1-dave@stgolabs.net>
References: <20250219062832.237881-1-dave@stgolabs.net>
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

