Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A813C7EE30
	for <linux-cxl@archiver.kernel.org>; Fri, 24 Feb 2023 19:47:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbjBXTrK (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 24 Feb 2023 14:47:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjBXTrK (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 24 Feb 2023 14:47:10 -0500
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A58256C1A2
        for <linux-cxl@vger.kernel.org>; Fri, 24 Feb 2023 11:47:08 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 035013E1274;
        Fri, 24 Feb 2023 19:47:08 +0000 (UTC)
Received: from pdx1-sub0-mail-a250.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 7311D3E171F;
        Fri, 24 Feb 2023 19:47:07 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1677268027; a=rsa-sha256;
        cv=none;
        b=WS3oOlFknCr2w7q7ifO6qj6w6doOHbK/I+SthvAZlvv6SvaKESGVGMMxokOQVFmkWe/chF
        wmDA5VvDq97RwOuPmJVBSGpVg9HjEXXqt8DiFRp7k+i6PyeJC5HMmgQh/WmWZIpfGKzJ6m
        PWx4vmUnZhQC9/a70abtjFfxifVy7jg35+nzxlo1VM8Ec9YxXvehXIMmnozW+QFS3KSa/N
        d5bZoidgW+k5RRK7H0VUoFzFVzVpC5fji/oFlnnPDT8mC2lNySuf/Q39mhErDTifCwEiya
        OVh3gvMoVQYVYEG2OUmo67FTZTmUD3QfyMlMrbTmo79jOilXCrBPYkN8nOmZ6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1677268027;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=pQp/N3Eufw05PzXNXa9+lQfLf0rhBWb4ZP5pKq1qTQo=;
        b=GBgAjn1uz8IWQVIgI/umKLmEybhOh5BUaXha6u9uI6md3OHj40s1o1DXaEsYuwyz/GdNn0
        8vFKvyBKD38chHddJmoGdLJIQi4V706IGDPRpXRpM51Z3Cl+YZ/mZrsvEkZ3c/5cpfSEFp
        TrJ3JL6rPsS+EF3AteVkQ9u8pRwqef5ayDl4JVprfr7LhB/TCKxpJdZcXWZDCJJOxfZYFo
        kwYEqllN70fHc4o4LGvm+z5fkc71y6xwjQNr5SKREupUvC+rMzn1/IhtfYOhOOmt1L9y12
        SGo0Nwq5/CkNyOomzkahSmcTM6l9iwhBH9EFrIjkAASRFaCD207CtHii01G+CQ==
ARC-Authentication-Results: i=1;
        rspamd-9788b98bc-jddqq;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Trouble-Tasty: 536211f31e3eec65_1677268027837_2074064300
X-MC-Loop-Signature: 1677268027837:3779901095
X-MC-Ingress-Time: 1677268027837
Received: from pdx1-sub0-mail-a250.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.109.196.241 (trex/6.7.1);
        Fri, 24 Feb 2023 19:47:07 +0000
Received: from offworld.. (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a250.dreamhost.com (Postfix) with ESMTPSA id 4PNgQL2LYSz2d;
        Fri, 24 Feb 2023 11:47:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1677268027;
        bh=pQp/N3Eufw05PzXNXa9+lQfLf0rhBWb4ZP5pKq1qTQo=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=q0dcms7cDxLEkznkEBjIzCj/ateOoE4W1B45nMmx5VKyS4I8+Z2xQcqkyBOFijvQG
         37h9eruP9bcFnVNsL2impD4mVM6PIsKD8/wUvr7aO+UrdVMZOdO/IAfRjdePzYTxm9
         DqtwG6VWMV5HLEfW/rN8oTr3DN5Ta/WLV3oayzHSeSuPhP0fdWm3uOWr5M8ETqC4Kv
         4UUXfA0KJQl85DsU6Pwj/iScJfzU0zQdwTVNOxHMdjg2CIE55JaOZ/vmOdk+WfK5rY
         UA/DZSQpwKm4Y577bIusAgjIWoOXEKCrSZ5va8EbW/8RSieMHBAFDP9HlIJ5+FooGk
         f+S7rkXLQDwgg==
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     dan.j.williams@intel.com
Cc:     jonathan.cameron@huawei.com, ira.weiny@intel.com,
        fan.ni@samsung.com, a.manzanares@samsung.com,
        linux-cxl@vger.kernel.org, dave@stgolabs.net
Subject: [PATCH 4/7] cxl/mem: Support Sanitation
Date:   Fri, 24 Feb 2023 11:46:49 -0800
Message-Id: <20230224194652.1990604-5-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230224194652.1990604-1-dave@stgolabs.net>
References: <20230224194652.1990604-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Implement support for the non-pmem exclusive sanitize (aka overwrite),
per CXL specs. This is the baseline for the sanitize-on-release
functionality.

To properly support this feature, create a 'security/sanitize' sysfs
file that when read will list the current pmem security state and
when written to, perform the requested operation.

This operation can run in the background and the driver must wait
for completion (no timeout), where the poller will awake every
~10 seconds (this could be further based on the size of the device).

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 Documentation/ABI/testing/sysfs-bus-cxl | 14 ++++++
 drivers/cxl/core/mbox.c                 | 61 +++++++++++++++++++++++++
 drivers/cxl/core/memdev.c               | 39 ++++++++++++++++
 drivers/cxl/cxlmem.h                    |  2 +
 4 files changed, 116 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
index e9c432a5a841..b315d78b7e91 100644
--- a/Documentation/ABI/testing/sysfs-bus-cxl
+++ b/Documentation/ABI/testing/sysfs-bus-cxl
@@ -66,6 +66,20 @@ Description:
 		are available: frozen, locked, unlocked and disabled (which
 		is also the case for any unsupported security features).
 
+What:          /sys/bus/cxl/devices/memX/security/sanitize
+Date:          February, 2023
+KernelVersion: v6.4
+Contact:       linux-cxl@vger.kernel.org
+Description:
+	       (WO) Write a boolean 'true' string value to this attribute to
+	       sanitize the device to securely re-purpose or decommission it.
+	       This is done by ensuring that all user data and meta-data,
+	       whether it resides in persistent capacity, volatile capacity,
+	       or the LSA, is made permanently unavailable by whatever means
+	       is appropriate for the media type. This causes all CPU caches
+	       to be flushed. If this sysfs entry is not present then the
+	       architecture does not support security features.
+
 What:		/sys/bus/cxl/devices/*/devtype
 Date:		June, 2021
 KernelVersion:	v5.14
diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index f2addb457172..885de3506735 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright(c) 2020 Intel Corporation. All rights reserved. */
 #include <linux/io-64-nonatomic-lo-hi.h>
+#include <linux/memregion.h>
 #include <linux/security.h>
 #include <linux/debugfs.h>
 #include <linux/ktime.h>
@@ -1021,6 +1022,66 @@ int cxl_dev_state_identify(struct cxl_dev_state *cxlds)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_dev_state_identify, CXL);
 
+/**
+ * cxl_mem_sanitize() - Send sanitation (aka overwrite) command to the device.
+ * @cxlds: The device data for the operation
+ *
+ * Return: 0 if the command was executed successfully, regardless of
+ * whether or not the actual security operation is done in the background.
+ * Upon error, return the result of the mailbox command or -EINVAL if
+ * security requirements are not met. CPU caches are flushed before and
+ * after succesful completion of each command.
+ *
+ * See CXL 3.0 @8.2.9.8.5.1 Sanitize.
+ */
+int cxl_mem_sanitize(struct cxl_dev_state *cxlds)
+{
+	int rc;
+	u32 sec_out = 0;
+	struct cxl_get_security_output {
+		__le32 flags;
+	} out;
+	struct cxl_mbox_cmd sec_cmd = {
+		.opcode = CXL_MBOX_OP_GET_SECURITY_STATE,
+		.payload_out = &out,
+		.size_out = sizeof(out),
+	};
+	struct cxl_mbox_cmd mbox_cmd = {
+		.opcode = CXL_MBOX_OP_SANITIZE,
+		.poll_interval = 10000UL,
+	};
+
+	if (!cpu_cache_has_invalidate_memregion())
+		return -EINVAL;
+
+	rc = cxl_internal_send_cmd(cxlds, &sec_cmd);
+	if (rc < 0) {
+		dev_err(cxlds->dev, "Failed to get security state : %d", rc);
+		return rc;
+	}
+
+	/*
+	 * Prior to using these commands, any security applied to
+	 * the user data areas of the device shall be DISABLED (or
+	 * UNLOCKED for secure erase case).
+	 */
+	sec_out = le32_to_cpu(out.flags);
+	if (sec_out & CXL_PMEM_SEC_STATE_USER_PASS_SET)
+		return -EINVAL;
+
+	cpu_cache_invalidate_memregion(IORES_DESC_CXL);
+
+	rc = cxl_internal_send_cmd(cxlds, &mbox_cmd);
+	if (rc < 0) {
+		dev_err(cxlds->dev, "Failed to sanitize device : %d", rc);
+		return rc;
+	}
+
+	cpu_cache_invalidate_memregion(IORES_DESC_CXL);
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_mem_sanitize, CXL);
+
 static int add_dpa_res(struct device *dev, struct resource *parent,
 		       struct resource *res, resource_size_t start,
 		       resource_size_t size, const char *type)
diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 68c0ab06b999..a1bb095d081c 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -127,6 +127,34 @@ static ssize_t security_state_show(struct device *dev,
 static struct device_attribute dev_attr_security_state =
 	__ATTR(state, 0444, security_state_show, NULL);
 
+static ssize_t security_sanitize_store(struct device *dev,
+				       struct device_attribute *attr,
+				       const char *buf, size_t len)
+{
+	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+	ssize_t rc;
+	bool sanitize;
+
+	rc = kstrtobool(buf, &sanitize);
+	if (rc)
+		return rc;
+
+	if (sanitize) {
+		if (cxl_memdev_active_region(cxlmd))
+			return -EBUSY;
+
+		rc = cxl_mem_sanitize(cxlds);
+	}
+
+	if (rc == 0)
+		rc = len;
+	return rc;
+}
+
+static struct device_attribute dev_attr_security_sanitize =
+	__ATTR(sanitize, 0200, NULL, security_sanitize_store);
+
 static ssize_t serial_show(struct device *dev, struct device_attribute *attr,
 			   char *buf)
 {
@@ -188,11 +216,22 @@ static struct attribute_group cxl_memdev_pmem_attribute_group = {
 
 static struct attribute *cxl_memdev_security_attributes[] = {
 	&dev_attr_security_state.attr,
+	&dev_attr_security_sanitize.attr,
 	NULL,
 };
 
+static umode_t cxl_security_visible(struct kobject *kobj,
+				    struct attribute *a, int n)
+{
+	if (!cpu_cache_has_invalidate_memregion() &&
+	    a == &dev_attr_security_sanitize.attr)
+		return 0;
+	return a->mode;
+}
+
 static struct attribute_group cxl_memdev_security_attribute_group = {
 	.name = "security",
+	.is_visible = cxl_security_visible,
 	.attrs = cxl_memdev_security_attributes,
 };
 
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 4e31f3234519..0d2009b36933 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -631,6 +631,8 @@ static inline void cxl_mem_active_dec(void)
 }
 #endif
 
+int cxl_mem_sanitize(struct cxl_dev_state *cxlds);
+
 struct cxl_hdm {
 	struct cxl_component_regs regs;
 	unsigned int decoder_count;
-- 
2.39.2

