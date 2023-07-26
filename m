Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FD0EC001DE
	for <linux-cxl@archiver.kernel.org>; Wed, 26 Jul 2023 06:03:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbjGZGDf (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 26 Jul 2023 02:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231833AbjGZGD2 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 26 Jul 2023 02:03:28 -0400
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E0C626B7
        for <linux-cxl@vger.kernel.org>; Tue, 25 Jul 2023 23:03:26 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 5539141B13;
        Wed, 26 Jul 2023 05:57:58 +0000 (UTC)
Received: from pdx1-sub0-mail-a240.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id B022341B15;
        Wed, 26 Jul 2023 05:57:57 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1690351077; a=rsa-sha256;
        cv=none;
        b=HJ2g26pedMoMxEjTQ8RMRS740xL6IIcvDx5iY3kHRUf/wMJ17oyJk/zbwne0l5ShVLx3jR
        KqKwT4arawBleKFlI3p2dMJw2cF21lSuFywoLVWS27rQt52DDPUgE3MqqKoNSp1OpumC8s
        gcCzC6NQ38ofkGhn20WTSrpxpTR62zOT9/79v0TQGjWZw6S4oc7rlC5LqVMLAjSqB7nkkM
        1+izaEhhmHx9qiio7ccIDEp6VPAuIXDX+AKQvGzMCu4O5JAyaKf6KW/RzCPrzO1W5uHSYI
        HQpQbRWHRWnVDBHbHqm0ws6ggP0VtjmuF675Zavq6SDW8vXIjoH2etxcW9iclg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1690351077;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=C1XE4XvXWLt5KJpRMKh6E7ucSM+S1KQoGYdLgtEDWLI=;
        b=dXpnwdZ331iqe8WLcpW10hBJdHGdVxSN/byl49OP4kO9NDzOuhC800r5lYjZrbcJuHI4f0
        /r6Guf4SGx66Biqqb1LQNRDUhNHGtpouhYCwrRSaPIz8FYeeVNJn+0I4b3RZxxLQpZv6bl
        QhdTZqiECvGZ3M1hN3OiwNDuqkm822Oao7y9Qh6q8Uv7O1XUjHH4MTIn+dG53Q/84arPCq
        W6rfp5Mu4moUJKsLMj7fJAfywZ2GHrDmH+ta+2Uq2/nbovzlt/0E0bT6TLyj/xYfg1+Lis
        4xYRo1q2yrjKbh3kwaPqBT4LtGOA8Mg/63Hr7IZEDHBII1IszsPwNdaju5BJMg==
ARC-Authentication-Results: i=1;
        rspamd-d58c88954-q8hpw;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Hook-Well-Made: 0c72bc134c6cfcb5_1690351078161_3888977358
X-MC-Loop-Signature: 1690351078161:1889567987
X-MC-Ingress-Time: 1690351078161
Received: from pdx1-sub0-mail-a240.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.106.0.198 (trex/6.9.1);
        Wed, 26 Jul 2023 05:57:58 +0000
Received: from localhost.localdomain (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a240.dreamhost.com (Postfix) with ESMTPSA id 4R9jqT0D3Tzlv;
        Tue, 25 Jul 2023 22:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1690351077;
        bh=C1XE4XvXWLt5KJpRMKh6E7ucSM+S1KQoGYdLgtEDWLI=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=jVzXsvS+EMyusyiDhxvQcS/yB/1Lbl3TDeQUBiGmiMHE/UJ33IeEuH0Mi88Rw+yZc
         PSc4i/3NQkorEUN1qqyb2VRITcL72wsXHfp02BZqnHNgAhNz8hQfMVKK7FpvzOtaU5
         WVcm9s3nyBJkN7IcmAIJnQojQUHABu8Pd3MxDO/2yMNOWCzBOfX2zDSLynUEiWkLrP
         ykbvL5Fg2q5F2j/18vrRjWT3TOwH3u4uB4sVcndORK1sjp6Vu6LKCi7kOwPAXvyZ9A
         /ULT1fvpPMir7L66/UJ/RWQvTkzkbfvwNtM0kFGeNpaiVnJqT+47+4RfuQvGQ3GBgm
         2nU1PoZR2d0gA==
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     dan.j.williams@intel.com
Cc:     vishal.l.verma@intel.com, jonathan.cameron@huawei.com,
        fan.ni@samsung.com, dave.jiang@intel.com, a.manzanares@samsung.com,
        dave@stgolabs.net, linux-cxl@vger.kernel.org
Subject: [PATCH 3/3] cxl/memdev: Only show sanitize sysfs files when supported
Date:   Tue, 25 Jul 2023 22:19:40 -0700
Message-ID: <20230726051940.3570-4-dave@stgolabs.net>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230726051940.3570-1-dave@stgolabs.net>
References: <20230726051940.3570-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

If the device does not support Sanitize or Secure Erase commands,
hide the respective sysfs interfaces such that the operation can
never be attempted.

In order to be generic, keep track of the enabled security commands
found in the CEL - the driver does not support Security Passthrough.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 Documentation/ABI/testing/sysfs-bus-cxl |  6 ++--
 drivers/cxl/core/mbox.c                 | 45 ++++++++++++++++++++++++-
 drivers/cxl/core/memdev.c               | 19 +++++++++++
 drivers/cxl/cxlmem.h                    | 15 +++++++++
 4 files changed, 82 insertions(+), 3 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
index c4c4acb1f3b3..087f762ebfd5 100644
--- a/Documentation/ABI/testing/sysfs-bus-cxl
+++ b/Documentation/ABI/testing/sysfs-bus-cxl
@@ -86,7 +86,8 @@ Description:
 		HPA ranges. This permits avoiding explicit global CPU cache
 		management, relying instead for it to be done when a region
 		transitions between software programmed and hardware committed
-		states.
+		states. If this file is not present, then there is no hardware
+		support for the operation.
 
 
 What            /sys/bus/cxl/devices/memX/security/erase
@@ -101,7 +102,8 @@ Description:
 		HPA ranges. This permits avoiding explicit global CPU cache
 		management, relying instead for it to be done when a region
 		transitions between software programmed and hardware committed
-		states.
+		states. If this file is not present, then there is no hardware
+		support for the operation.
 
 
 What:		/sys/bus/cxl/devices/memX/firmware/
diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index d6d067fbee97..ca60bb8114f2 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -121,6 +121,45 @@ static bool cxl_is_security_command(u16 opcode)
 	return false;
 }
 
+static void cxl_set_security_cmd_enabled(struct cxl_security_state *security,
+					 u16 opcode)
+{
+	switch (opcode) {
+	case CXL_MBOX_OP_SANITIZE:
+		set_bit(CXL_SEC_ENABLED_SANITIZE, security->enabled_cmds);
+		break;
+	case CXL_MBOX_OP_SECURE_ERASE:
+		set_bit(CXL_SEC_ENABLED_SECURE_ERASE,
+			security->enabled_cmds);
+		break;
+	case CXL_MBOX_OP_GET_SECURITY_STATE:
+		set_bit(CXL_SEC_ENABLED_GET_SECURITY_STATE,
+			security->enabled_cmds);
+		break;
+	case CXL_MBOX_OP_SET_PASSPHRASE:
+		set_bit(CXL_SEC_ENABLED_SET_PASSPHRASE,
+			security->enabled_cmds);
+		break;
+	case CXL_MBOX_OP_DISABLE_PASSPHRASE:
+		set_bit(CXL_SEC_ENABLED_DISABLE_PASSPHRASE,
+			security->enabled_cmds);
+		break;
+	case CXL_MBOX_OP_UNLOCK:
+		set_bit(CXL_SEC_ENABLED_UNLOCK, security->enabled_cmds);
+		break;
+	case CXL_MBOX_OP_FREEZE_SECURITY:
+		set_bit(CXL_SEC_ENABLED_FREEZE_SECURITY,
+			security->enabled_cmds);
+		break;
+	case CXL_MBOX_OP_PASSPHRASE_SECURE_ERASE:
+		set_bit(CXL_SEC_ENABLED_PASSPHRASE_SECURE_ERASE,
+			security->enabled_cmds);
+		break;
+	default:
+		break;
+	}
+}
+
 static bool cxl_is_poison_command(u16 opcode)
 {
 #define CXL_MBOX_OP_POISON_CMDS 0x43
@@ -677,7 +716,8 @@ static void cxl_walk_cel(struct cxl_memdev_state *mds, size_t size, u8 *cel)
 		u16 opcode = le16_to_cpu(cel_entry[i].opcode);
 		struct cxl_mem_command *cmd = cxl_mem_find_command(opcode);
 
-		if (!cmd && !cxl_is_poison_command(opcode)) {
+		if (!cmd && (!cxl_is_poison_command(opcode) ||
+			     !cxl_is_security_command(opcode))) {
 			dev_dbg(dev,
 				"Opcode 0x%04x unsupported by driver\n", opcode);
 			continue;
@@ -689,6 +729,9 @@ static void cxl_walk_cel(struct cxl_memdev_state *mds, size_t size, u8 *cel)
 		if (cxl_is_poison_command(opcode))
 			cxl_set_poison_cmd_enabled(&mds->poison, opcode);
 
+		if (cxl_is_security_command(opcode))
+			cxl_set_security_cmd_enabled(&mds->security, opcode);
+
 		dev_dbg(dev, "Opcode 0x%04x enabled\n", opcode);
 	}
 }
diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index f99e7ec3cc40..14b547c07f54 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -477,9 +477,28 @@ static struct attribute_group cxl_memdev_pmem_attribute_group = {
 	.attrs = cxl_memdev_pmem_attributes,
 };
 
+static umode_t cxl_memdev_security_visible(struct kobject *kobj,
+					   struct attribute *a, int n)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
+	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
+
+	if (a == &dev_attr_security_sanitize.attr &&
+	    !test_bit(CXL_SEC_ENABLED_SANITIZE, mds->security.enabled_cmds))
+		return 0;
+
+	if (a == &dev_attr_security_erase.attr &&
+	    !test_bit(CXL_SEC_ENABLED_SECURE_ERASE, mds->security.enabled_cmds))
+		return 0;
+
+	return a->mode;
+}
+
 static struct attribute_group cxl_memdev_security_attribute_group = {
 	.name = "security",
 	.attrs = cxl_memdev_security_attributes,
+	.is_visible = cxl_memdev_security_visible,
 };
 
 static const struct attribute_group *cxl_memdev_attribute_groups[] = {
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 083c6e58bc49..f86afef90c91 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -244,6 +244,19 @@ enum poison_cmd_enabled_bits {
 	CXL_POISON_ENABLED_MAX
 };
 
+/* Device enabled security commands */
+enum security_cmd_enabled_bits {
+	CXL_SEC_ENABLED_SANITIZE,
+	CXL_SEC_ENABLED_SECURE_ERASE,
+	CXL_SEC_ENABLED_GET_SECURITY_STATE,
+	CXL_SEC_ENABLED_SET_PASSPHRASE,
+	CXL_SEC_ENABLED_DISABLE_PASSPHRASE,
+	CXL_SEC_ENABLED_UNLOCK,
+	CXL_SEC_ENABLED_FREEZE_SECURITY,
+	CXL_SEC_ENABLED_PASSPHRASE_SECURE_ERASE,
+	CXL_SEC_ENABLED_MAX
+};
+
 /**
  * struct cxl_poison_state - Driver poison state info
  *
@@ -346,6 +359,7 @@ struct cxl_fw_state {
  * struct cxl_security_state - Device security state
  *
  * @state: state of last security operation
+ * @enabled_cmds: All security commands enabled in the CEL
  * @poll: polling for sanitization is enabled, device has no mbox irq support
  * @poll_tmo_secs: polling timeout
  * @poll_dwork: polling work item
@@ -353,6 +367,7 @@ struct cxl_fw_state {
  */
 struct cxl_security_state {
 	unsigned long state;
+	DECLARE_BITMAP(enabled_cmds, CXL_SEC_ENABLED_MAX);
 	bool poll;
 	int poll_tmo_secs;
 	struct delayed_work poll_dwork;
-- 
2.41.0

