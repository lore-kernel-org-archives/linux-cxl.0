Received: from eastern.yew.relay.mailchannels.net (eastern.yew.relay.mailchannels.net [23.83.220.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87BF41F4E38
	for <linux-cxl@vger.kernel.org>; Fri, 21 Feb 2025 03:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.220.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740109120; cv=pass; b=kYrknqPWWYv0o+RFQ9KJx1uBBNyEMaFxnAW5YRaX7WdwuKeZXTFcP1kYpZjWQSJvSBYHbDTfwTCIyx3xSGsd7R42u4LWt7oSRjmJT5TSkYi4AqCypEt5S21WQGM1YIg0ZHtDXDyBi9xCpM8V7Bc8k/anHYq6CWuK6IR+GQQmBSw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740109120; c=relaxed/simple;
	bh=5O2EhE6JqETNfwk6troveYz2VumKBKoIXKsv4e+CMx4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bplg9wUXa46mrt6ADpXMnvFTOkwyPl7YbNRCvIiQfJ0sj/ZseFw5qcP97vSusSwVLguKwqKB2r7V2xqh0Ccb0ShukVbTNvrwc50yKCT/z2q1LfSpqcu2XzPXRh09GAsHqV2CGlpx0u58lyOTFYSkRfLHePS9ExIO1vswZssLsWc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=DDauWsHx; arc=pass smtp.client-ip=23.83.220.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="DDauWsHx"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id D0E798C22AC;
	Thu, 20 Feb 2025 22:02:45 +0000 (UTC)
Received: from pdx1-sub0-mail-a229.dreamhost.com (100-100-209-197.trex-nlb.outbound.svc.cluster.local [100.100.209.197])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 62FD68C1AD6;
	Thu, 20 Feb 2025 22:02:45 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1740088965; a=rsa-sha256;
	cv=none;
	b=CLPvfTjt0UHIhm0NKTgPpOWa9S5StHF5T4L8hpqN/8ONsdzEXrQzR+BIPhDC3cf117O3qo
	F3/hCFUA1dqEmh1QWZ4J/DBmR4v+B/cp4Sk9jVdG9tCreb6YK3U37fgiKcpVQa+XT7XZB/
	l5fQiq43Ej+0Xs7idjJvc8XKAkN8S7vV+MVZJvTq5syP9DN3zNQ6Y5w60RH6em+i5nEndQ
	zSlFXK6iAe8YbNe6IeD+i9YIETNeN/h93Fopj4CtsuyvR8EP0R0fr6QLtCcvN1UaZRO8Nz
	7MgFRcwm6+jp2jKoktC8bJR773rt0EUYa5R5V7SCbzUuJatqQ4IqI2Me6AgbVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1740088965;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=Hm/em4gW8zM4TNeuCgUrGpyltdUqxN8G9uB47IjUj4Q=;
	b=hnJBy48EF55EAxkPDWBqdH4vPQKgPKDak6bNxUDrK+k0VqQNj1BaYqIVEjqO7RTPJMFxVS
	DxydrXfwo7f87GEHjRz3rrKQrcZY7BoFDa553JgHQiA0PcwaksopD6R17RmUocOPrUxNFb
	ZTBDNbsHUavI5ju7pOV3stpQMvH0MPH3YZPZavSFX0Z3MmNRtnms1b6KY7/Ef/5ksyoNhU
	GOwG7ap2UB6mmtyhfikWh2ALsKgTz08y73DA3/o6hyuWkH1NiVeZM+QXXdZFuhTifk0yMz
	tvePhWLPhjq2V+IGlI/CnpEPFaAnsfM9/jL5bY5169PI1EZXI00dQ5c1BiV5uQ==
ARC-Authentication-Results: i=1;
	rspamd-6d7cc6b78d-6gdtf;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Good
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Eyes-Industry: 65df173c0b3e0fcc_1740088965724_2874690912
X-MC-Loop-Signature: 1740088965724:2958077725
X-MC-Ingress-Time: 1740088965723
Received: from pdx1-sub0-mail-a229.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.100.209.197 (trex/7.0.2);
	Thu, 20 Feb 2025 22:02:45 +0000
Received: from localhost.localdomain (unknown [104.36.25.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a229.dreamhost.com (Postfix) with ESMTPSA id 4YzS1J3PPlzJG;
	Thu, 20 Feb 2025 14:02:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1740088965;
	bh=Hm/em4gW8zM4TNeuCgUrGpyltdUqxN8G9uB47IjUj4Q=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=DDauWsHxojhLWQCYRZnyCM4sQD4lJr5j9mzPc+TWTWsB0hUw32v58y3obkSaDr/K4
	 6waGAkARi7g0dhX5REm2ff5fZeWKqsRp7/7dOrU4/bTzzH1UQtvKiMetJl8+aCWQ6k
	 E+PWE9aAluE8BK50Wh2gfo2kyC/fHFBZE8VZ24km1lrK7C4mmj/W+0MwP4DN+l7TQ4
	 m+2vn64q+rbMhylnpca44UJScoce90Uy7f1jxEttj1qs+MxgasY9oVl4cIi5JHBm0S
	 3ejBwnfmP6JxGe4dRhe8Uwgua7ZEmMLx8esPib0wNUdzXB9dKqiu6+zse5ang8SE9i
	 NnWhl4f8pl9TA==
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
	linux-cxl@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 4/4] tools/testing/cxl: Set Shutdown State support
Date: Thu, 20 Feb 2025 14:02:35 -0800
Message-Id: <20250220220235.276831-5-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250220220235.276831-1-dave@stgolabs.net>
References: <20250220220235.276831-1-dave@stgolabs.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support to emulate the CXL Set Shutdown State operation.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Li Ming <ming.li@zohomail.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 tools/testing/cxl/test/mem.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
index 4cbfafdf5371..9c4fee78b729 100644
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

