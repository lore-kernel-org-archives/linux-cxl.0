Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 907F6C88CB2
	for <linux-cxl@archiver.kernel.org>; Mon, 12 Jun 2023 18:45:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235411AbjFLSp3 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 12 Jun 2023 14:45:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234484AbjFLSp3 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 12 Jun 2023 14:45:29 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E2C1E6F
        for <linux-cxl@vger.kernel.org>; Mon, 12 Jun 2023 11:45:27 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id C94F5640B87;
        Mon, 12 Jun 2023 18:45:26 +0000 (UTC)
Received: from pdx1-sub0-mail-a316.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 46141641A6E;
        Mon, 12 Jun 2023 18:45:26 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1686595526; a=rsa-sha256;
        cv=none;
        b=QurRa4ndvCjcm0Myqm36MYijaBt/RrbnxmR6vvknhTgsCcFAd9/bntXttxz8rbxWPl79D6
        6zi8d+bL0hwfZX+ucUib2tRHXAs9299z/KrE9W5iOAyMLAN4S+tcXDPl9VE2MaR3d/GDoo
        YOvLSR9HK4pprxmQAkCzIHk0E+bYdZ9V3N//7uI5nQAqc/WgJ68j6Pwm7tr1zFYsYp6NPP
        RCc13wYWqXDAWr3plfbh79yUK8rESGfJ/BF15i6HqARbngJFib3D9IEJxpJATURfPqAQcF
        Gn3yAibyC14B4kFTO3KHlXMKCEFH2w/tuaqVUpkRpN/vcgPGCaxu2rRHYXRTtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1686595526;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=rb2nYuaQG7yq6MtzRrO1hwtQIlFYtLZezlkfpakDVbM=;
        b=KOCn9Dmof5rpuNCLWVTLXQ2WNiJTe92MsJlWcWstDcaQYfbPay9E4u64rzHv982KOtanVh
        qexzxG98dg9mcGj0pZNO6n3k9S2AlL2gpSLL0CixQ9CE9knwkcZZLkORuluZtlt1bY5OQA
        WnEpXwYgNyJx6Sskz8iied719Nuw6DcPAAVbiupCSYo90YZW0/GLaL7fBs6shKEyCjSK3d
        zYP9TkW4lRWNLv8CYs9542Q0rjXA1OUx9E2liBpkQr1C+vcE58AVhgFzwHdkPz3jyzwv07
        HpaHpGUllwGbospSXcxGB25XoMXYFT9ygPCoNKKH3+uhAAVpXB+u6dpC4dfczg==
ARC-Authentication-Results: i=1;
        rspamd-6c69b8658d-p8dcm;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Descriptive-Company: 3ee2f3993cb21c8f_1686595526627_2966272992
X-MC-Loop-Signature: 1686595526627:3912530023
X-MC-Ingress-Time: 1686595526627
Received: from pdx1-sub0-mail-a316.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.127.59.15 (trex/6.8.1);
        Mon, 12 Jun 2023 18:45:26 +0000
Received: from localhost.localdomain (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a316.dreamhost.com (Postfix) with ESMTPSA id 4Qg0xK4c6nzXL;
        Mon, 12 Jun 2023 11:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1686595526;
        bh=rb2nYuaQG7yq6MtzRrO1hwtQIlFYtLZezlkfpakDVbM=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=c4qwLM7otxYwXVj68G/uz7B8WC3fbKzejpaO7i9W5IrQmTrY4UreFMcg8tfOdhU41
         kg9KX3x5W+VNY24MRMN0el3hIyJHBqck0iLgqueKFHcd+DSYvRTFyzqyqlq+34zRu9
         tip1/TvbtY4EFpajnBSggB6feej78CAk8PD/l7XMG1UH/QMCmzTityTrTo76Adc3BV
         O9AvPaMQ+Me3oBxTb0nQfeM+4u0a0jnM51Y9aAzkXfNcFB0iWoielpZMtc8rq3e/Wc
         m12JpLPPFI53zNbIGCLSbTONBsecEaIsCVJ9xRmKxu5ABfpU/qsDoIHAX3CbUNdv1+
         PVop7ULCgdF9w==
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     dan.j.williams@intel.com
Cc:     dave.jiang@intel.com, vishal.l.verma@intel.com,
        Jonathan.Cameron@huawei.com, fan.ni@samsung.com,
        a.manzanares@samsung.com, dave@stgolabs.net,
        linux-cxl@vger.kernel.org
Subject: [PATCH 6/7] cxl/mem: Support Secure Erase
Date:   Mon, 12 Jun 2023 11:10:37 -0700
Message-ID: <20230612181038.14421-7-dave@stgolabs.net>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230612181038.14421-1-dave@stgolabs.net>
References: <20230612181038.14421-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Implement support for the non-pmem exclusive secure erase, per
CXL specs. Create a write-only 'security/erase' sysfs file to
perform the requested operation.

As with the sanitation this requires the device being offline
and thus no active HPA-DPA decoding.

The expectation is that userspace can use it such as:

	cxl disable-memdev memX
	echo 1 > /sys/bus/cxl/devices/memX/security/erase
	cxl enable-memdev memX

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Fan Ni <fan.ni@samsung.com>
Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 Documentation/ABI/testing/sysfs-bus-cxl | 10 +++++++++
 drivers/cxl/core/mbox.c                 |  6 +++++-
 drivers/cxl/core/memdev.c               | 28 +++++++++++++++++++++++++
 drivers/cxl/cxlmem.h                    |  1 +
 4 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
index 5753cba98692..f224c1215f22 100644
--- a/Documentation/ABI/testing/sysfs-bus-cxl
+++ b/Documentation/ABI/testing/sysfs-bus-cxl
@@ -85,6 +85,16 @@ Description:
 		the device to be not be actively decoding any HPA ranges.
 
 
+What            /sys/bus/cxl/devices/memX/security/erase
+Date:           June, 2023
+KernelVersion:  v6.5
+Contact:        linux-cxl@vger.kernel.org
+Description:
+		(WO) Write a boolean 'true' string value to this attribute to
+		secure erase user data by changing the media encryption keys for
+		all user data areas of the device.
+
+
 What:		/sys/bus/cxl/devices/*/devtype
 Date:		June, 2021
 KernelVersion:	v5.14
diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 51c64829f20a..6622eac66bf1 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -1102,7 +1102,7 @@ int cxl_mem_sanitize(struct cxl_dev_state *cxlds, u16 cmd)
 	};
 	struct cxl_mbox_cmd mbox_cmd = { .opcode = cmd };
 
-	if (cmd != CXL_MBOX_OP_SANITIZE)
+	if (cmd != CXL_MBOX_OP_SANITIZE && cmd != CXL_MBOX_OP_SECURE_ERASE)
 		return -EINVAL;
 
 	rc = cxl_internal_send_cmd(cxlds, &sec_cmd);
@@ -1120,6 +1120,10 @@ int cxl_mem_sanitize(struct cxl_dev_state *cxlds, u16 cmd)
 	if (sec_out & CXL_PMEM_SEC_STATE_USER_PASS_SET)
 		return -EINVAL;
 
+	if (cmd == CXL_MBOX_OP_SECURE_ERASE &&
+	    sec_out & CXL_PMEM_SEC_STATE_LOCKED)
+		return -EINVAL;
+
 	rc = cxl_internal_send_cmd(cxlds, &mbox_cmd);
 	if (rc < 0) {
 		dev_err(cxlds->dev, "Failed to sanitize device : %d", rc);
diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index bdd1edfd62e8..ed8de7efddef 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -163,6 +163,33 @@ static ssize_t security_sanitize_store(struct device *dev,
 static struct device_attribute dev_attr_security_sanitize =
 	__ATTR(sanitize, 0200, NULL, security_sanitize_store);
 
+static ssize_t security_erase_store(struct device *dev,
+				    struct device_attribute *attr,
+				    const char *buf, size_t len)
+{
+	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+	struct cxl_port *port = dev_get_drvdata(&cxlmd->dev);
+	ssize_t rc;
+	bool erase;
+
+	if (kstrtobool(buf, &erase) || !erase)
+		return -EINVAL;
+
+	if (!port || !is_cxl_endpoint(port))
+		return -EINVAL;
+
+	/* ensure no regions are mapped to this memdev */
+	if (port->commit_end != -1)
+		return -EBUSY;
+
+	rc = cxl_mem_sanitize(cxlds, CXL_MBOX_OP_SECURE_ERASE);
+
+	return rc ? rc : len;
+}
+static struct device_attribute dev_attr_security_erase =
+	__ATTR(erase, 0200, NULL, security_erase_store);
+
 static int cxl_get_poison_by_memdev(struct cxl_memdev *cxlmd)
 {
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
@@ -411,6 +438,7 @@ static struct attribute *cxl_memdev_ram_attributes[] = {
 static struct attribute *cxl_memdev_security_attributes[] = {
 	&dev_attr_security_state.attr,
 	&dev_attr_security_sanitize.attr,
+	&dev_attr_security_erase.attr,
 	NULL,
 };
 
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 177a76578a94..e57db7adb2a3 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -388,6 +388,7 @@ enum cxl_opcode {
 	CXL_MBOX_OP_SCAN_MEDIA		= 0x4304,
 	CXL_MBOX_OP_GET_SCAN_MEDIA	= 0x4305,
 	CXL_MBOX_OP_SANITIZE		= 0x4400,
+	CXL_MBOX_OP_SECURE_ERASE	= 0x4401,
 	CXL_MBOX_OP_GET_SECURITY_STATE	= 0x4500,
 	CXL_MBOX_OP_SET_PASSPHRASE	= 0x4501,
 	CXL_MBOX_OP_DISABLE_PASSPHRASE	= 0x4502,
-- 
2.41.0

