Received: from tiger.tulip.relay.mailchannels.net (tiger.tulip.relay.mailchannels.net [23.83.218.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB99A17F7
	for <linux-cxl@vger.kernel.org>; Wed,  5 Feb 2025 04:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.248
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738728974; cv=pass; b=YVn26ua8GJjO3espcqRE5T8qFYpoT92Evz0hi6TYLUHS8ZEXTAMre1Kk+nqzpD8GW5A6N+pTPpPbOde1WjinBtJgNDT4SsQ55U8JtdpgzFdqrQz1K12nMOCtP59eKH7J4zP5+Ue5SfcauAd9btJNGLQSqzPRRS4D58PBetKtgeo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738728974; c=relaxed/simple;
	bh=8pSAO99fAun7tvDXZtq4izfJOo/FVC+LlGROabg8Go0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S4RnMuE1lhtmupVx/4wjFlox+Px+B89EW4sZlPrErf8oUwqyvkRWaAR4a/PYFf8S6BB8TcO8ucb/f2rU1C8Svq945TjDeF6De9/9/+di4YWRfTGf0T2BZKzpCg6MARP0nQ9LIOYRf7qQm2/eM3i7Hy261mEUcCKsmexpsN65xlc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=nnV9gvEO; arc=pass smtp.client-ip=23.83.218.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="nnV9gvEO"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id C5E9E322A50;
	Wed,  5 Feb 2025 04:08:49 +0000 (UTC)
Received: from pdx1-sub0-mail-a274.dreamhost.com (100-120-216-166.trex-nlb.outbound.svc.cluster.local [100.120.216.166])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 223A3322A96;
	Wed,  5 Feb 2025 04:08:49 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1738728529; a=rsa-sha256;
	cv=none;
	b=78YCb+uIJox2BP+lJfOLTph3UDD9Dbt8gSwRYj3wW+5sip88779vlZAHqK/hujlJiHFwuU
	kXuoMRrNltyyPuqCrF+FWCWNdTvCNfRveoQ1+tXZ6qiaJGmfvpQBAZxGZ/CMBQG201+Obp
	z6uFPvO4BQjm1xj5f567EuuTCSuUnPrDF+j1ep/fIQi4J66YeP9aeiKyASa4CmnAW2kGHS
	Q+PYofadJ5Q1IrwApc2rIfHy1qOrxThcnAorqw1D/KbPfOVNVe//Mxu1wIcp28zs17NMdb
	9otZFBe696n2bue9b2bD3SyhJmxqBelaLK93TehBk55yxI/JIuU8B4gxYV2gjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1738728529;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=REWb217/MWuN5ReY6irSzS6HNjO0O+RYf18H6LEMv90=;
	b=wAKwp3ZxwDRUDfgxlXUsePOf8kMu8TGOqlYFFjN7O4XoJMuSmyX5juWr0ulYIHPnw38IIP
	NmVWGWH4kKfdamclujMsKW3zKQImkC0IDajl7aix1QQmwrIx7//noooDTp+tJuHuuSZwHt
	WGYENpeeeKk5ODW/fgJsmdp8AgLPkg89mVQvbVhiPBfUFZyWo0GuLE87ZgeWz8L6MmnUiw
	7jfy0sNty6OD7FxOs1cPINjUKvjyfYdgjsBCxN6AS4Lg3AEdJHH/qUqa2DWYslhBkgh+n1
	Pvwf2Sn1/YhFnktfbjj1OA3ZAZDgYSc5h4I6uhXQGbgg57qsFh/YVz/Vy1Y/hw==
ARC-Authentication-Results: i=1;
	rspamd-854f7f575d-zwltk;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Tangy-Robust: 2210460038bfbe3f_1738728529706_4024760926
X-MC-Loop-Signature: 1738728529705:4282664883
X-MC-Ingress-Time: 1738728529705
Received: from pdx1-sub0-mail-a274.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.120.216.166 (trex/7.0.2);
	Wed, 05 Feb 2025 04:08:49 +0000
Received: from localhost.localdomain (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a274.dreamhost.com (Postfix) with ESMTPSA id 4Ynmv42Kl4zDT;
	Tue,  4 Feb 2025 20:08:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1738728529;
	bh=REWb217/MWuN5ReY6irSzS6HNjO0O+RYf18H6LEMv90=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=nnV9gvEOiNhW952HtuwZ4LDoqYYIW6hEWQ6JFId2luOJ9BQPIKjA6xtcaWyLtJVuJ
	 AzMjDGqArH1noGztgjYXqcwj3n4/DpXRTAqyeNTKyxXDUyNFyZOMEPZBq/XaJ59o66
	 tgM31+8NelrWqHqb+p/QzmTTb1CU8wL/czJyGeF4SyHPDqyFz8nphP1+lMDXQ3HVIg
	 exayIhaKw0FaYSEnI2r5mmQy//50GMW6D3cHLr02KQ7AzsoSz3rBNfQ3AO2sipyfPI
	 pCDO446gLlP9h9jXWMgnxYsKS0t/sTowgX+6Nk3C3SoRgarKfFE6vRN989SpwdYmlC
	 crTdW6pCiMHfw==
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
Subject: [PATCH 2/2] tools/testing/cxl: Set Shutdown State support
Date: Tue,  4 Feb 2025 20:08:42 -0800
Message-Id: <20250205040842.1253616-3-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250205040842.1253616-1-dave@stgolabs.net>
References: <20250205040842.1253616-1-dave@stgolabs.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support to emulate the CXL Set Shutdown State operation.

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

