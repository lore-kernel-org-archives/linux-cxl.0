Received: from crane.ash.relay.mailchannels.net (crane.ash.relay.mailchannels.net [23.83.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6F318FDDE
	for <linux-cxl@vger.kernel.org>; Fri, 20 Feb 2026 00:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.222.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771546590; cv=pass; b=dDzIsDHfutePwGy9UaJBdLj/WAwJfKp0C/dnoaYKmepG8ecvGHo9cGJIpmMB3YZwHhQGELe9MHfkfrzwxo5y0va4/CZV3GkKpkMqM7zC39KzVHL5Q4A2zMEAqr8Ug+2YNxaDLEEn8Bz0MciVMMQCMsLgVzRAS0IaBaXkvW+dY9Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771546590; c=relaxed/simple;
	bh=CC0U3Bg8CaE5GOlBXZDydfgGT1tb54v/agMQXDOrzH8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fmyPfxgRpg+EOEeYBL7aeppnYzG+yhctyo53E3P0fdlO5STLxSWMRsr/ielE+vKPOhrA2GxeePx96Ej++rSSbPNk4IQEg08QVe3Afw4fcD0YHTH32O1/P4aZBw6HNVbnQfhUYpY5FCe84z9452PMcKIF9TBO/MFjNge/9PZG25Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=ACj4WU6K; arc=pass smtp.client-ip=23.83.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="ACj4WU6K"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 24BC97E1C34;
	Fri, 20 Feb 2026 00:16:22 +0000 (UTC)
Received: from pdx1-sub0-mail-a248.dreamhost.com (100-99-12-77.trex-nlb.outbound.svc.cluster.local [100.99.12.77])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id BA0A97E2738;
	Fri, 20 Feb 2026 00:16:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1771546581;
	b=5MVyJAiBWhtLk6AvSHBMrDpGr474Cvj4j9vET63mS9ViriDIuBPSGTA5FncKrEU0HUDrVw
	cnqRylk7IQyfO2AC2AQFlED+eyWFheZTVD3SdDGQknfFLJm8VoqFADcfQqcBqCHs0Xp2wG
	lCUmyKrQWoOlgTCIkh5O6JGxDmeiGT+7H9qupcnsjec1OuSWh+uXOlHwezbB4SAHGBlmnS
	vFazQ51YpPgCyqisTTZdf9z3FRg/M77kYRcsZbtddZSVnsrxNIBKVQ/k645cTVmj/VnCiF
	xPFmySg/n0TAQMNejEGU6sFBDyV/2TyncSeP2jl5xkKOvQ3q98QTBVn6WI2/3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1771546581;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=KSHxrmT/NBw6HhAWPp6k8gxQH/VMe+cnmX/kP4bfj9s=;
	b=zrMFsx/1DnZYVg/+sKVLpmQxyC5tz8ytCXnBblBignNp736H/dLf0OmI4h2REG+ooRah2k
	zGVWfmZq7LPeTzHw+Ry9eQcF4vZeMnm5Akt8Zc9ov+vjOeLRYi15vDSDd76YlW/Onw2wYE
	Nnc/6Klr5FnDCgv3WN21SdAIVwkEag/xWUDWFsb4Etm3gVc7I4XxAtH2mQija+jbE6FmFe
	AUxrOnWyyqy+fLgoRKzqXT+a3qxHFUfvinlvmIi+KVylVooqdtPzdM5rZO5NDg+GCnw0HB
	Zyv4ER6MVsi7SyOk5mF0bjUdgGLEzSyqvniOh+8CGGFJJSdKPGO5CFc3fPr8pQ==
ARC-Authentication-Results: i=1;
	rspamd-659f7bc6cc-mn88h;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Keen-Bored: 01a8761c2eb4d256_1771546582057_4113869744
X-MC-Loop-Signature: 1771546582057:2541532830
X-MC-Ingress-Time: 1771546582057
Received: from pdx1-sub0-mail-a248.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.99.12.77 (trex/7.1.3);
	Fri, 20 Feb 2026 00:16:22 +0000
Received: from offworld.lan (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a248.dreamhost.com (Postfix) with ESMTPSA id 4fH9lT1CVpzyr9;
	Thu, 19 Feb 2026 16:16:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1771546581;
	bh=KSHxrmT/NBw6HhAWPp6k8gxQH/VMe+cnmX/kP4bfj9s=;
	h=From:To:Cc:Subject:Date:Content-Type:Content-Transfer-Encoding;
	b=ACj4WU6KKXU3rnvo6G7y0KjDs9bDmWJMBk8E04frb0Mae9VjXxRXHZg/x2JvkCJth
	 jRF8TEAFOwmtvFOj++QJeL+XxoegoWwvQVWOtSV6bLg1iqCpE+qMhMEMQfqg2iLjCV
	 9FbIipZwFG44LazjpMDZJE1wKQWSY3E+0KHD3OTC4XxKjtWt/NPJyldS0m/JsDNJFA
	 jt6FbhiAC2XRvNaNuw2y0cn+ytn82l+uKRmZOJ49/iaMyutnjw4u9/07waca+fDpzt
	 lYhIau6ry0aLOACyaW8f2mcOyeqTskMPTKB5wBJzYNpYo+4gX855Q6xw24ChsCenpz
	 PcJvkcwa+WrCA==
From: Davidlohr Bueso <dave@stgolabs.net>
To: dave.jiang@intel.com
Cc: jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	linux-cxl@vger.kernel.org,
	Davidlohr Bueso <dave@stgolabs.net>
Subject: [PATCH 2/2] cxl/mbox: return appropriate error in cxl_payload_from_user_allowed()
Date: Thu, 19 Feb 2026 16:16:18 -0800
Message-Id: <20260220001618.963490-3-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260220001618.963490-1-dave@stgolabs.net>
References: <20260220001618.963490-1-dave@stgolabs.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Make cxl_payload_from_user_allowed() return int such that the it can
distinguish between different errors. The payload size failure is not
well represented by EBUSY (exclusive access by the kernel).

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 drivers/cxl/core/mbox.c | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index e7a6452bf544..164da335fa33 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -314,8 +314,9 @@ static bool cxl_mem_raw_command_allowed(u16 opcode)
  * @in_size: Size of @payload_in in bytes.
  *
  * Return:
- *  * true	- payload_in passes check for @opcode.
- *  * false	- payload_in contains invalid or unsupported values.
+ *  * %0	- payload_in passes check for @opcode.
+ *  * %-EINVAL	- payload_in is too small for the opcode.
+ *  * %-EBUSY	- payload_in contains unsupported values.
  *
  * The driver may inspect payload contents before sending a mailbox
  * command from user space to the device. The intent is to reject
@@ -326,40 +327,44 @@ static bool cxl_mem_raw_command_allowed(u16 opcode)
  *
  * The specific checks are determined by the opcode.
  */
-static bool cxl_payload_from_user_allowed(u16 opcode, void *payload_in,
-					  size_t in_size)
+static int cxl_payload_from_user_allowed(u16 opcode, void *payload_in,
+					 size_t in_size)
 {
 	switch (opcode) {
 	case CXL_MBOX_OP_SET_PARTITION_INFO: {
 		struct cxl_mbox_set_partition_info *pi = payload_in;
 
 		if (in_size < sizeof(*pi))
-			return false;
+			return -EINVAL;
 		if (pi->flags & CXL_SET_PARTITION_IMMEDIATE_FLAG)
-			return false;
+			return -EBUSY;
 		break;
 	}
 	case CXL_MBOX_OP_CLEAR_LOG: {
 		const uuid_t *uuid = (uuid_t *)payload_in;
 
 		if (in_size < sizeof(uuid_t))
-			return false;
+			return -EINVAL;
 		/*
-		 * Restrict the ‘Clear log’ action to only apply to
+		 * Restrict the 'Clear log' action to only apply to
 		 * Vendor debug logs.
 		 */
-		return uuid_equal(uuid, &DEFINE_CXL_VENDOR_DEBUG_UUID);
+		if (!uuid_equal(uuid, &DEFINE_CXL_VENDOR_DEBUG_UUID))
+			return -EBUSY;
+		break;
 	}
 	default:
 		break;
 	}
-	return true;
+	return 0;
 }
 
 static int cxl_mbox_cmd_ctor(struct cxl_mbox_cmd *mbox_cmd,
 			     struct cxl_mailbox *cxl_mbox, u16 opcode,
 			     size_t in_size, size_t out_size, u64 in_payload)
 {
+	int rc;
+
 	*mbox_cmd = (struct cxl_mbox_cmd) {
 		.opcode = opcode,
 		.size_in = in_size,
@@ -371,12 +376,13 @@ static int cxl_mbox_cmd_ctor(struct cxl_mbox_cmd *mbox_cmd,
 		if (IS_ERR(mbox_cmd->payload_in))
 			return PTR_ERR(mbox_cmd->payload_in);
 
-		if (!cxl_payload_from_user_allowed(opcode, mbox_cmd->payload_in,
-						  in_size)) {
+		rc = cxl_payload_from_user_allowed(opcode, mbox_cmd->payload_in,
+						   in_size);
+		if (rc) {
 			dev_dbg(cxl_mbox->host, "%s: input payload not allowed\n",
 				cxl_mem_opcode_to_name(opcode));
 			kvfree(mbox_cmd->payload_in);
-			return -EBUSY;
+			return rc;
 		}
 	}
 
-- 
2.39.5

