Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 486B9C7EE2F
	for <linux-cxl@archiver.kernel.org>; Fri, 24 Feb 2023 19:47:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbjBXTrJ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 24 Feb 2023 14:47:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjBXTrI (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 24 Feb 2023 14:47:08 -0500
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDF276C19D
        for <linux-cxl@vger.kernel.org>; Fri, 24 Feb 2023 11:47:06 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 24E435021B6;
        Fri, 24 Feb 2023 19:47:06 +0000 (UTC)
Received: from pdx1-sub0-mail-a250.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 8DEB7500EDC;
        Fri, 24 Feb 2023 19:47:05 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1677268025; a=rsa-sha256;
        cv=none;
        b=G3pC/r4vkO8Pr0PAROWvmuWSOIEptfT/dAtLM/8JCrmzyDAq5q4QmZKxsbUWPxRmuhUVAn
        DB74mBN1Cs62C87XMIArrPVlOSfsfGWycFJFTGYKmW436HIN6AD3mYiV6/ikijlMfoxZOE
        UVLuIMwH5vk6NFF+CSJBgvHWqDvLjl+la05sut5taXJE8sXAuZj21LbNsQY4EKK8T58RJJ
        RyILAlwTxVZkj33bpDFLCDDC/ZPlMAMTeZ16JeCn8XO7hUKD86kIbrPUxHEZVDWPWTZbq1
        FT2WXSOaxQ2afjWThw3uK1x0WDeiMyt8lROSUH8jM+zOOTqqrVI9fqkGT2Tngg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1677268025;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=DjzZAOO4awNY+j0vnzloQLKua0xzw1hNI/cCA000ioA=;
        b=cqjvHeiS/JXggDVE+ULkElaxGi3ISifhBAjMcGUKV+Cqx1QIC/HFacM4JoUZAjF1sUW9XZ
        BdIGvA9RSm1sdB1EJvB+R/xKCVVlzfPXvDseoSadqljo2aXS1Je6+luNzQMHelbMRG5S1Z
        wqxW14cjA5zd/FvMglZCDtSeGaSxJ/KtASgJdWQcmmRqcDhKtU7qIwEDFm3tQvd5jIcpse
        nL9A2WS/iBX8rTlUPQbp1e0Y0GroGEIT7x6yun3Y/ZmG1mz6+Y8rtYJ+fRqmANGWRv1i3F
        MPAyXjBEp8SLtiCYaewNxfGejMfrkIvwHJkTfHMFbVrc02y+lmcjKBUObHxpBw==
ARC-Authentication-Results: i=1;
        rspamd-9788b98bc-pxv92;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Shoe-Versed: 70a2da9b4e4083a2_1677268025934_1900094114
X-MC-Loop-Signature: 1677268025934:4203468878
X-MC-Ingress-Time: 1677268025933
Received: from pdx1-sub0-mail-a250.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.123.200.110 (trex/6.7.1);
        Fri, 24 Feb 2023 19:47:05 +0000
Received: from offworld.. (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a250.dreamhost.com (Postfix) with ESMTPSA id 4PNgQJ0dc5zMP;
        Fri, 24 Feb 2023 11:47:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1677268024;
        bh=DjzZAOO4awNY+j0vnzloQLKua0xzw1hNI/cCA000ioA=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=hHqgOFDYCbIivObTDIBKI8cuw+K328KA4QAHdirW2iWIP538AEa8xEqZKopMYeYAW
         cXc0MgkiNbfH6rGAQfRfTITqA9V8yThNWOX9y0iayjdz0gSf7FSh4nvkdWQl+CCpha
         3xhlRQ2lqz6nxFvmMqXdj4W34Q3l9imeTFbCHbWiFVXsj71cqTTHXII9ajudZDMIo2
         hDWcq4yvBTwPSrl0y3hxFJ+7kru0AeZpjznsEZcXj0S9CP653DgTurlqwOaBSoPoJc
         SIP9aAPTLHFdhMy2hhpheWaBMLwlIDGKuY6AE/UZlk9SRSvRI4i+ht+nj2oRoZK0Sp
         G90AlX0X8Ywxw==
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     dan.j.williams@intel.com
Cc:     jonathan.cameron@huawei.com, ira.weiny@intel.com,
        fan.ni@samsung.com, a.manzanares@samsung.com,
        linux-cxl@vger.kernel.org, dave@stgolabs.net
Subject: [PATCH 2/7] cxl/security: Add security state sysfs ABI
Date:   Fri, 24 Feb 2023 11:46:47 -0800
Message-Id: <20230224194652.1990604-3-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230224194652.1990604-1-dave@stgolabs.net>
References: <20230224194652.1990604-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

This adds the sysfs memdev's security/ directory with
a single 'state' file, which is always visible. In the
case of unsupported security features, this will show
disabled.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 Documentation/ABI/testing/sysfs-bus-cxl |  8 ++++
 drivers/cxl/core/memdev.c               | 49 +++++++++++++++++++++++++
 2 files changed, 57 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
index 3acf2f17a73f..e9c432a5a841 100644
--- a/Documentation/ABI/testing/sysfs-bus-cxl
+++ b/Documentation/ABI/testing/sysfs-bus-cxl
@@ -57,6 +57,14 @@ Description:
 		host PCI device for this memory device, emit the CPU node
 		affinity for this device.
 
+What:		/sys/bus/cxl/devices/memX/security/state
+Date:		February, 2023
+KernelVersion:	v6.4
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(RO) The security state for that device. The following states
+		are available: frozen, locked, unlocked and disabled (which
+		is also the case for any unsupported security features).
 
 What:		/sys/bus/cxl/devices/*/devtype
 Date:		June, 2021
diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 0af8856936dc..47cc625bb1b0 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright(c) 2020 Intel Corporation. */
 
+#include <linux/memregion.h>
 #include <linux/device.h>
 #include <linux/slab.h>
 #include <linux/idr.h>
@@ -89,6 +90,43 @@ static ssize_t pmem_size_show(struct device *dev, struct device_attribute *attr,
 static struct device_attribute dev_attr_pmem_size =
 	__ATTR(size, 0444, pmem_size_show, NULL);
 
+static ssize_t security_state_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	u32 sec_out;
+	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+	struct cxl_get_security_output {
+		__le32 flags;
+	} out;
+	struct cxl_mbox_cmd mbox_cmd = {
+		.opcode = CXL_MBOX_OP_GET_SECURITY_STATE,
+		.payload_out = &out,
+		.size_out = sizeof(out),
+	};
+
+	if (!cpu_cache_has_invalidate_memregion())
+		goto disabled;
+
+	if (cxl_internal_send_cmd(cxlds, &mbox_cmd) < 0)
+		goto disabled;
+
+	sec_out = le32_to_cpu(out.flags);
+	if (!(sec_out & CXL_PMEM_SEC_STATE_USER_PASS_SET))
+		goto disabled;
+	if (sec_out & CXL_PMEM_SEC_STATE_FROZEN)
+		return sysfs_emit(buf, "frozen\n");
+	if (sec_out & CXL_PMEM_SEC_STATE_LOCKED)
+		return sysfs_emit(buf, "locked\n");
+	else
+		return sysfs_emit(buf, "unlocked\n");
+disabled:
+	return sysfs_emit(buf, "disabled\n");
+}
+
+static struct device_attribute dev_attr_security_state =
+	__ATTR(state, 0444, security_state_show, NULL);
+
 static ssize_t serial_show(struct device *dev, struct device_attribute *attr,
 			   char *buf)
 {
@@ -148,10 +186,21 @@ static struct attribute_group cxl_memdev_pmem_attribute_group = {
 	.attrs = cxl_memdev_pmem_attributes,
 };
 
+static struct attribute *cxl_memdev_security_attributes[] = {
+	&dev_attr_security_state.attr,
+	NULL,
+};
+
+static struct attribute_group cxl_memdev_security_attribute_group = {
+	.name = "security",
+	.attrs = cxl_memdev_security_attributes,
+};
+
 static const struct attribute_group *cxl_memdev_attribute_groups[] = {
 	&cxl_memdev_attribute_group,
 	&cxl_memdev_ram_attribute_group,
 	&cxl_memdev_pmem_attribute_group,
+	&cxl_memdev_security_attribute_group,
 	NULL,
 };
 
-- 
2.39.2

