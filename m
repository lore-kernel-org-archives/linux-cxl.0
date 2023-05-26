Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD6EEC77B7C
	for <linux-cxl@archiver.kernel.org>; Fri, 26 May 2023 04:07:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbjEZEHd (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 26 May 2023 00:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbjEZEHb (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 26 May 2023 00:07:31 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E88B12F
        for <linux-cxl@vger.kernel.org>; Thu, 25 May 2023 21:07:29 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id C8B382613EE;
        Fri, 26 May 2023 04:07:28 +0000 (UTC)
Received: from pdx1-sub0-mail-a281.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 464B1260E4C;
        Fri, 26 May 2023 04:07:28 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1685074048; a=rsa-sha256;
        cv=none;
        b=rSaKtNu+QhKb4UuGoMJhHISIDv1uO8anf0YcO9oVzZZkb1Wsr0ZmhFAeByaFYizuGVBDse
        hf45LZ9GCfI/SJVbw0jDAw0j/tTtB2nwAA9djiECI3V14XQJxQ+Jye1gh5qhUlxvpvO0fc
        yAwASi5cYmj8NbZvM6Pi5zL/R4ehm4vGyd9LSawpcylfLEEm43Dp8eeYtVvVPr8lU9RDBx
        0GOyQJOjlPPhxZNeulhTenxuc6bLixXPjSsDqY1HljWU8I2ObgiapWdJ9X/dmsG+FclmNr
        b1YrGvjEe6FgiRpftKvvuVfx8iYzvH2A8fb4J7l9oS3TbMYNw6aNU5OL/RIv9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1685074048;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=hlJe/5lHkRV4ma+TL2Wmt8zinlWFRKi30n4a+pYrJL0=;
        b=2WpSGAOfxCejtbB7cmwnT17NgSikqpciMHyxxiQFFU5+vqtJ6xb26KSGvKyZ8yRY2LWopq
        lQ5g+Xqxs+AqGmLcUXVYMT2OsMbuYYteZhR06Fp4ysy7Y6iaDNbPquhGFxbCiWnH2ruCWm
        h2a4clt72ouSbthiTbLM62XSfxGRs12gC5FTizX+/KsKLWZmHwmkUO/TMtV6hvbnPuTdut
        Jj7z6w/4KBSFUImvEm/NgcC5HqsPMv+q9o+01sisvyMmA3K0591GibvtEUEs36KYSMGhBp
        KqFZ7uvFOiuAtd6rEi08QAY7atGbz4blIAH+t/azUA1RT7SJLSdqMoexVZ1a5w==
ARC-Authentication-Results: i=1;
        rspamd-7d4b855556-pn845;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Relation-Skirt: 7adc57a2547ed57a_1685074048587_2408068052
X-MC-Loop-Signature: 1685074048587:1264517250
X-MC-Ingress-Time: 1685074048587
Received: from pdx1-sub0-mail-a281.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.109.138.46 (trex/6.8.1);
        Fri, 26 May 2023 04:07:28 +0000
Received: from localhost.localdomain (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a281.dreamhost.com (Postfix) with ESMTPSA id 4QSBG73k63zCV;
        Thu, 25 May 2023 21:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1685074048;
        bh=hlJe/5lHkRV4ma+TL2Wmt8zinlWFRKi30n4a+pYrJL0=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=HAtXlcNB72lkVFRCOygjFj8ltLHJF/58aaNcsU9hhzC2ijMrr9YX+/2Mw9+EfJo8B
         H/FASxI6jRqUyvnIxLwAkLo5SXBE2MC6ZUJDDZefe8t8LHpirbcvx4BhQmkdEewmDo
         j8577lFd/N0L6qB92qhqubEJYrDyoMR7YyMf94zWswypM8ZPRZS4Frp4HtM4lhIa8s
         g2LAJzbj2gSTN+bLyzdK8GxXAFMH2LQvD9AU3P4tUXJ7U5jVvbWzq2IxU9uG4xe+/U
         mce0gHSJ00xntG6j3Wr5vxzekc4YWauI8MuBBfLWBrXuH4WXDRxzOes3MeGKziONZU
         V+kxKJmYxucPw==
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     dan.j.williams@intel.com
Cc:     dave.jiang@intel.com, vishal.l.verma@intel.com,
        Jonathan.Cameron@huawei.com, fan.ni@samsung.com,
        a.manzanares@samsung.com, dave@stgolabs.net,
        linux-cxl@vger.kernel.org
Subject: [PATCH 5/6] cxl/mem: Support Secure Erase
Date:   Thu, 25 May 2023 20:33:43 -0700
Message-Id: <20230526033344.17167-6-dave@stgolabs.net>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230526033344.17167-1-dave@stgolabs.net>
References: <20230526033344.17167-1-dave@stgolabs.net>
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
index 90f23e53d483..d06c8539e82c 100644
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
index 408ec33c8480..758fea7b9dbf 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -392,6 +392,7 @@ enum cxl_opcode {
 	CXL_MBOX_OP_SCAN_MEDIA		= 0x4304,
 	CXL_MBOX_OP_GET_SCAN_MEDIA	= 0x4305,
 	CXL_MBOX_OP_SANITIZE		= 0x4400,
+	CXL_MBOX_OP_SECURE_ERASE	= 0x4401,
 	CXL_MBOX_OP_GET_SECURITY_STATE	= 0x4500,
 	CXL_MBOX_OP_SET_PASSPHRASE	= 0x4501,
 	CXL_MBOX_OP_DISABLE_PASSPHRASE	= 0x4502,
-- 
2.40.1

