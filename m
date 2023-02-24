Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED595C6FA8E
	for <linux-cxl@archiver.kernel.org>; Fri, 24 Feb 2023 19:54:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbjBXTyw (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 24 Feb 2023 14:54:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjBXTyv (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 24 Feb 2023 14:54:51 -0500
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA12E628FC
        for <linux-cxl@vger.kernel.org>; Fri, 24 Feb 2023 11:54:49 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 29A403C1F46;
        Fri, 24 Feb 2023 19:47:10 +0000 (UTC)
Received: from pdx1-sub0-mail-a250.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 901A93C1F5C;
        Fri, 24 Feb 2023 19:47:09 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1677268029; a=rsa-sha256;
        cv=none;
        b=JjULwDOF8mhC7wVOgllUnm9o4Cl+eQmWpvsZL7fPIO7EKhTZCBLOU8oNsP+quB02rLIhfq
        0j6OlKS/UtGn7l3p7aSFWl8ti3kAyJLHZg26S++zEVfElWEX7n/lfgC79TZUfZKcxtagng
        PvnfgcuJWqonM6k9lgll9xSLdjfoeMW2/lpufz3RgruX8BNJo9lq2rallrQA4jh6iZDgyd
        EiPO5aqkzKrbk/YoCsJkUn2dr9iQXLSlnoraFvQRHz0LcirBS5KqjgxqEB0KgcqL+mVBlk
        3AdZorkTIMbRJvCgXZpDwJh6W7N8LX+1Ys/gqxbf2pwtjHCGzfNhCOuwioJecQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1677268029;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=GiOeG5lrocXfUVyExHZRoYMiICaJ3EVxSwc8oBrFE+8=;
        b=uWoB1YNN+pKqg+oVu8ywgUvuiYsLGIRHYy2dTDiJKKRK+jclBCE62EofxPNPIoFKROht8X
        hDbx5CIQUhmGncV3NqDCdhynhH3fX0GluyAJDajrT6MAW9kd+gv52lX32xsnmi3vE8foM6
        zJVBZ2QavPU3+6aXPKCJywrViZt8hbP2Iy1zJRrloEjs7sIvyO06WQ4walkeGdFstVCK+H
        HZiUUleGaEVNEODDTnYGufYQ6HEtI7b+E3JJZHGA21pV95jwXHc6PZQW09hi1I5bgY4R0K
        HUOheCIkBzcmpZH2fr/cvOg7CJwzsoeB7WLmpRNNssnq1CG74CNGlCS+FNmgzA==
ARC-Authentication-Results: i=1;
        rspamd-9788b98bc-x62tj;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Versed-Tart: 0317de5f04cc1a46_1677268029943_6978840
X-MC-Loop-Signature: 1677268029943:48012232
X-MC-Ingress-Time: 1677268029943
Received: from pdx1-sub0-mail-a250.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.116.179.67 (trex/6.7.1);
        Fri, 24 Feb 2023 19:47:09 +0000
Received: from offworld.. (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a250.dreamhost.com (Postfix) with ESMTPSA id 4PNgQN2DWqz2d;
        Fri, 24 Feb 2023 11:47:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1677268029;
        bh=GiOeG5lrocXfUVyExHZRoYMiICaJ3EVxSwc8oBrFE+8=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=mpMYESCo8OrAaWMufta4RtYCKwsEuM9G0rpz5p7wA3IKnVJ8AV5E9IT7bq8CBdJo9
         1Hm9EsMrkyvEVYYcrg8Fbll/i5kuyut6j5QZtWyGEC9UtwxRCXC1tnMXWLKmtOru6e
         MBv+US/TW8Qw6Y/iqiyzD2LXzc1naDVlL37MHyFV7/1UCs7Oq167uUvlbTCnsdSnhL
         6GclikV/0Hc1M5MZXwKyYcre62Krj1nKlSPRGY0ncvjHT/LQ6CrZuHpThQxqjjoo7G
         zmOodOmHL8yW4beqibdQXkjeMLOg6xyFijpgcIaMejZJn9GC62I/7scJoRJ/MQq4Rr
         hKkfaH0MQGV8Q==
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     dan.j.williams@intel.com
Cc:     jonathan.cameron@huawei.com, ira.weiny@intel.com,
        fan.ni@samsung.com, a.manzanares@samsung.com,
        linux-cxl@vger.kernel.org, dave@stgolabs.net
Subject: [PATCH 6/7] cxl/mem: Support Secure Erase
Date:   Fri, 24 Feb 2023 11:46:51 -0800
Message-Id: <20230224194652.1990604-7-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230224194652.1990604-1-dave@stgolabs.net>
References: <20230224194652.1990604-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Implement support for the non-pmem exclusive secure erase, per
CXL specs.

To properly support this feature, create a 'security/erase' sysfs
file that when read will list the current pmem security state and
when written to, perform the requested operation.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 Documentation/ABI/testing/sysfs-bus-cxl | 12 ++++++
 drivers/cxl/core/mbox.c                 | 56 +++++++++++++++++++++++++
 drivers/cxl/core/memdev.c               | 32 +++++++++++++-
 drivers/cxl/cxlmem.h                    |  2 +
 4 files changed, 101 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
index b315d78b7e91..91a74e27f248 100644
--- a/Documentation/ABI/testing/sysfs-bus-cxl
+++ b/Documentation/ABI/testing/sysfs-bus-cxl
@@ -80,6 +80,18 @@ Description:
 	       to be flushed. If this sysfs entry is not present then the
 	       architecture does not support security features.
 
+What:          /sys/bus/cxl/devices/memX/security/erase
+Date:          February, 2023
+KernelVersion: v6.4
+Contact:       linux-cxl@vger.kernel.org
+Description:
+	       (WO) Write a boolean 'true' string value to this attribute to
+	       secure erase the device to securely re-purpose or decommission
+	       it. This is done by hanging the media encryption keys for all
+	       user data areas of the device. This causes all CPU caches to
+	       be flushed. If this sysfs entry is not present then the
+	       architecture does not support security features.
+
 What:		/sys/bus/cxl/devices/*/devtype
 Date:		June, 2021
 KernelVersion:	v5.14
diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 885de3506735..bf206fe26839 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -1082,6 +1082,62 @@ int cxl_mem_sanitize(struct cxl_dev_state *cxlds)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_mem_sanitize, CXL);
 
+/**
+ * cxl_mem_secure_erase() - Send secure erase command to the device.
+ * @cxlds: The device data for the operation
+ *
+ * Return: 0 if the command was executed successfully.
+ * Upon error, return the result of the mailbox command or -EINVAL if
+ * security requirements are not met. CPU caches are flushed before and
+ * after succesful completion of each command.
+ *
+ * See CXL 3.0 @8.2.9.8.5.2 Secure Erase.
+ */
+int cxl_mem_secure_erase(struct cxl_dev_state *cxlds)
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
+		.opcode = CXL_MBOX_OP_SECURE_ERASE,
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
+	sec_out = le32_to_cpu(out.flags);
+	if (sec_out & CXL_PMEM_SEC_STATE_USER_PASS_SET)
+		return -EINVAL;
+
+	if (sec_out & CXL_PMEM_SEC_STATE_LOCKED)
+		return -EINVAL;
+
+	cpu_cache_invalidate_memregion(IORES_DESC_CXL);
+
+	rc = cxl_internal_send_cmd(cxlds, &mbox_cmd);
+	if (rc < 0) {
+		dev_err(cxlds->dev, "Failed to secure erase device : %d", rc);
+		return rc;
+	}
+
+	cpu_cache_invalidate_memregion(IORES_DESC_CXL);
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_mem_secure_erase, CXL);
+
 static int add_dpa_res(struct device *dev, struct resource *parent,
 		       struct resource *res, resource_size_t start,
 		       resource_size_t size, const char *type)
diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index a1bb095d081c..6334a0d1a925 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -155,6 +155,34 @@ static ssize_t security_sanitize_store(struct device *dev,
 static struct device_attribute dev_attr_security_sanitize =
 	__ATTR(sanitize, 0200, NULL, security_sanitize_store);
 
+static ssize_t security_erase_store(struct device *dev,
+				    struct device_attribute *attr,
+				    const char *buf, size_t len)
+{
+	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+	ssize_t rc;
+	bool erase;
+
+	rc = kstrtobool(buf, &erase);
+	if (rc)
+		return rc;
+
+	if (erase) {
+		if (cxl_memdev_active_region(cxlmd))
+			return -EBUSY;
+
+		rc = cxl_mem_secure_erase(cxlds);
+	}
+
+	if (rc == 0)
+		rc = len;
+	return rc;
+}
+
+static struct device_attribute dev_attr_security_erase =
+	__ATTR(sanitize, 0200, NULL, security_erase_store);
+
 static ssize_t serial_show(struct device *dev, struct device_attribute *attr,
 			   char *buf)
 {
@@ -217,6 +245,7 @@ static struct attribute_group cxl_memdev_pmem_attribute_group = {
 static struct attribute *cxl_memdev_security_attributes[] = {
 	&dev_attr_security_state.attr,
 	&dev_attr_security_sanitize.attr,
+	&dev_attr_security_erase.attr,
 	NULL,
 };
 
@@ -224,7 +253,8 @@ static umode_t cxl_security_visible(struct kobject *kobj,
 				    struct attribute *a, int n)
 {
 	if (!cpu_cache_has_invalidate_memregion() &&
-	    a == &dev_attr_security_sanitize.attr)
+	    (a == &dev_attr_security_sanitize.attr ||
+	     a == &dev_attr_security_erase.attr))
 		return 0;
 	return a->mode;
 }
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 0d2009b36933..2cf9ec3242a6 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -332,6 +332,7 @@ enum cxl_opcode {
 	CXL_MBOX_OP_SCAN_MEDIA		= 0x4304,
 	CXL_MBOX_OP_GET_SCAN_MEDIA	= 0x4305,
 	CXL_MBOX_OP_SANITIZE		= 0x4400,
+	CXL_MBOX_OP_SECURE_ERASE	= 0x4401,
 	CXL_MBOX_OP_GET_SECURITY_STATE	= 0x4500,
 	CXL_MBOX_OP_SET_PASSPHRASE	= 0x4501,
 	CXL_MBOX_OP_DISABLE_PASSPHRASE	= 0x4502,
@@ -632,6 +633,7 @@ static inline void cxl_mem_active_dec(void)
 #endif
 
 int cxl_mem_sanitize(struct cxl_dev_state *cxlds);
+int cxl_mem_secure_erase(struct cxl_dev_state *cxlds);
 
 struct cxl_hdm {
 	struct cxl_component_regs regs;
-- 
2.39.2

