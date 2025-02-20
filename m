Received: from slategray.cherry.relay.mailchannels.net (slategray.cherry.relay.mailchannels.net [23.83.223.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53AC7082E
	for <linux-cxl@vger.kernel.org>; Thu, 20 Feb 2025 01:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.223.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740015436; cv=pass; b=CMTx3sY3WxdqWuNg28q/GAtobUTbhpwaeh4dbJ29+jj6Vzh7ApEgZYXgeuFh/kTRkA7m3z+/ysve9PJlBs+HIHuZKfPIyI1HOT0GY0kFSzmbNVOurKB6lmi92E2DBAsSdpbha1MnZ9ttZXGjnj/DWRp0jrs0WurQ8u4aeiPNUI4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740015436; c=relaxed/simple;
	bh=3vwAkv1d0jHerRD1PW3RmRZIoCCsKpnZmMJph/NVB+o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t2mpwBBUxDijsI6rh3Rbqg4RR5RkhLqUzkYycWVA3caxpMICcULcrb8EWk6C+zqFY4H82hxx+EW3CHUfBiva/wFTjSV9IVX6oGMk78vB/V/mRSlx5JqMecSUI2zdQ6MysjWaHe+VfjJFzSzfT4d8bvJVaGFFnmztKQXhbldho7I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=G8FJlFgJ; arc=pass smtp.client-ip=23.83.223.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="G8FJlFgJ"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id ABE052C3527;
	Thu, 20 Feb 2025 01:37:08 +0000 (UTC)
Received: from pdx1-sub0-mail-a300.dreamhost.com (100-99-192-59.trex-nlb.outbound.svc.cluster.local [100.99.192.59])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 46CEB2C2CF6;
	Thu, 20 Feb 2025 01:37:08 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1740015428; a=rsa-sha256;
	cv=none;
	b=91hbCsLeFmfl4kfY2ihS1Ib47/AYgHZJdyRiIdlKy1H7PYORmd1X9Egbrd6UNIg0/36UHy
	rkdoC3DMX8CRoHpm2x5vnuAlE1XNR0+puic67IMmvgxc1ZWMa7h1kst+peBWnBXSOadiMP
	hfj3xvIhefrm0J95mZxpzE8WjKL9frdzgNVCoVJll5Yx1O7diCOlWg7CCPfwe6dsckWDRV
	mheq+h6yNsKc6fgztced6VjqC7fTsaEjfifmlmgyzHotDalqDcbCg4JilQ9Sup2i1L5bss
	5WJIBp7JUxsWzwObuGd7rjmI7T23eN9c1fQvHj9lgqnn8fyc9+lWMQQ/ZbQ5rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1740015428;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=ObteXauFVE4bYK5zXDJLlupkYnUT4Pw33ZZc+ElpCgY=;
	b=9RPBaDTd1ImTJYuyBAD2ReQbaYff+S+eAj4LeOZj7ysOuIPZzcU5VCuQ2HjVykJo6PVG48
	FgFqnTAeT6gyFPxV1eQTpnKb1kLvMbiGFWLGOeaPB6QGy5hjJSae/JRm/1heVQEQNM3GpJ
	TUEl1ChMMxQhMaV5LFiCecZNdi+PVCiOHWVGQzSC9CV7cunh2bViGcxNKkcGbJQd/13rQO
	DKxQOIpon8/QKEU3tiOwMpn1D7eqt2szODYfWhZP1TbLYsJRLyAFWPgsCfbqU8ztmJ4omc
	3eVgiUmf8wWpQbFVSo9EDBhdi0VEzUis+hHih5XsuY+v0acL5hHkevkd2e25lQ==
ARC-Authentication-Results: i=1;
	rspamd-6d7cc6b78d-56wzv;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Arch-Language: 1173aa28569dd3ee_1740015428585_3768806492
X-MC-Loop-Signature: 1740015428585:3646154081
X-MC-Ingress-Time: 1740015428585
Received: from pdx1-sub0-mail-a300.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.99.192.59 (trex/7.0.2);
	Thu, 20 Feb 2025 01:37:08 +0000
Received: from localhost.localdomain (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a300.dreamhost.com (Postfix) with ESMTPSA id 4Yywq73LQ6zY0;
	Wed, 19 Feb 2025 17:37:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1740015428;
	bh=ObteXauFVE4bYK5zXDJLlupkYnUT4Pw33ZZc+ElpCgY=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=G8FJlFgJkkgLjqLu+PiwlVaLxIJ2pXizKqu7w68iTUrH12G/pXQhtgAt9xOVSZppO
	 3sCv3xslHxBApJ2K85DVrSvFcmaq3nn939eAzdVSzjUpZwjw9UuJrkS6YpkhJBkzfz
	 3kSpdo4bE9UNWRhbevA7JqwCnC8LSA5/MNRsKaVWmSgDGENG8r1rBq7wcUphESU+GH
	 BbjM3hab6kHrgO0uI6wO2aprnAKl4lcgrrTHDv48dcV4KXNpsDOsitH4CKKODk0EBu
	 z5oKwIigrwDjTZGO0FTUnniuhgl9nycO/tx9QzpzgR9x57I/Zigjque0PlFFxsjcWQ
	 dEFPcUl6k4AFg==
From: Davidlohr Bueso <dave@stgolabs.net>
To: dave.jiang@intel.com,
	dan.j.williams@intel.com
Cc: jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	ira.weiny@intel.com,
	vishal.l.verma@intel.com,
	seven.yi.lee@gmail.com,
	ming.li@zohomail.com,
	a.manzanares@samsung.com,
	fan.ni@samsung.com,
	anisa.su@samsung.com,
	dave@stgolabs.net,
	linux-cxl@vger.kernel.org
Subject: [PATCH 4/4] tools/testing/cxl: Set Shutdown State support
Date: Wed, 19 Feb 2025 17:36:04 -0800
Message-Id: <20250220013604.263489-5-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250220013604.263489-1-dave@stgolabs.net>
References: <20250220013604.263489-1-dave@stgolabs.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support to emulate the CXL Set Shutdown State operation.

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Li Ming <ming.li@zohomail.com>
Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 tools/testing/cxl/test/mem.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
index 495199238335..9ca210b80e27 100644
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
+	u8 shutdown_state;
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

