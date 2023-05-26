Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12F0CC7EE2F
	for <linux-cxl@archiver.kernel.org>; Fri, 26 May 2023 04:07:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233019AbjEZEHb (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 26 May 2023 00:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbjEZEH2 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 26 May 2023 00:07:28 -0400
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B56D513D
        for <linux-cxl@vger.kernel.org>; Thu, 25 May 2023 21:07:26 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id EBAE25C1EC1;
        Fri, 26 May 2023 04:07:25 +0000 (UTC)
Received: from pdx1-sub0-mail-a281.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 5812D5C2098;
        Fri, 26 May 2023 04:07:25 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1685074045; a=rsa-sha256;
        cv=none;
        b=6aAedEFqbZn4caQDeb5BF6ZXZUXMmt8d2Vpx1gTHevSBaVaH7msZlHenjsCZacNAwi+w77
        BG2Q/r8Y2/l6eSwlsfpaePcOntjM+D8Ca7EK2mrJxXRMEVw/qSkstktDZoMKkgn6o90BP/
        0iwEizQg2dt5eaX8ouCNN0+rs82lro3FLxjdSub2Z2M+V42YPmBsNp38w0txUQ9FhjzsTW
        xbJtZ7C4m0c22VjxaCWC/jfl06IOqTL2NOaietCO4g2cVD0EtyG5IRfVaQzrtPPePJz2TT
        mvfh+QCgALzrhEE1/2/9ag2OVLAcOySsLECyupjBUZPZ8m2VERvN9IMEo7JWPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1685074045;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=ZDT4VoEtbPHgSTLCgWFCzT/wRnykxMJ/gJ2uAXppXHo=;
        b=79EObgZbQLKYh2FbDjONEENHRwjexQD8gZ8YBC52ZrqhIkXhUfmkWwS1oAJT/Cw5sGOhjy
        62G2z5jLf6jc5WlEw4FULoPjZn2wKriRxCMZ5yVVGzDf9eOLqRuzO3BIgQ7z7sqoMl7fXu
        apbzagvBY27UxMQ+qUAcjn7izINUv9TwBd250EdVdAhTg3yGnKQL/eU5qloZcbAoiTjRTo
        5FG3b2plrIrlVmOVT5SQfTIWL9jZGGwCEi/zAWIcdNmdOSf6sOlRQXLgaM/0sqY14QNwf1
        ABUmJWJ93LE+aF3gfd32wbTXVBd1IDkc3isaMzYAVVaPLAcSPd5RM5HJ00ejXw==
ARC-Authentication-Results: i=1;
        rspamd-7d4b855556-pn845;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Whispering-Shoe: 153aba085164f95e_1685074045744_806699063
X-MC-Loop-Signature: 1685074045744:727372571
X-MC-Ingress-Time: 1685074045744
Received: from pdx1-sub0-mail-a281.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.109.138.46 (trex/6.8.1);
        Fri, 26 May 2023 04:07:25 +0000
Received: from localhost.localdomain (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a281.dreamhost.com (Postfix) with ESMTPSA id 4QSBG43V29zCV;
        Thu, 25 May 2023 21:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1685074045;
        bh=ZDT4VoEtbPHgSTLCgWFCzT/wRnykxMJ/gJ2uAXppXHo=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=rixUbI8fhCifDOfrVKy3xvgZfT8+gGZNoUurBo6/3ITNepzud5cSCE+T3PQKO7v2c
         czlNIDj7fswSfrwxMiiNk8U6AXQcoDJ+WginHPaI+eG/WVq9Q4vGRLuBp8z5KrePqn
         fQdKE8jXunCbIdA+OGRHDT8YX0KgxGFBztIfGY08xmz8qEbEfOP7evpSX3WuM/4Pf/
         l+8Ys+XwRKl3hGkUOK7VghBCnfqnDdb9ggHCBDQcATjsZc0o+cd6LuSB9kiX9fyrfF
         7Qmb5V9lG7pYg7RKgGFJI6iq3sxo1eMQKTLezD6joHTxrNrZFVPFi27OdOauMy7dqG
         0Y0k+givud65A==
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     dan.j.williams@intel.com
Cc:     dave.jiang@intel.com, vishal.l.verma@intel.com,
        Jonathan.Cameron@huawei.com, fan.ni@samsung.com,
        a.manzanares@samsung.com, dave@stgolabs.net,
        linux-cxl@vger.kernel.org
Subject: [PATCH 1/6] cxl/mem: Introduce security state sysfs file
Date:   Thu, 25 May 2023 20:33:39 -0700
Message-Id: <20230526033344.17167-2-dave@stgolabs.net>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230526033344.17167-1-dave@stgolabs.net>
References: <20230526033344.17167-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Add a read-only sysfs file to display the security state
of a device (currently only pmem):

    /sys/bus/cxl/devices/memX/security/state

This introduces a cxl_security_state structure that is
to be the placeholder for common CXL security features.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 Documentation/ABI/testing/sysfs-bus-cxl | 10 ++++++
 drivers/cxl/core/memdev.c               | 46 +++++++++++++++++++++++++
 drivers/cxl/cxlmem.h                    | 11 ++++++
 drivers/cxl/security.c                  |  3 ++
 4 files changed, 70 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
index 48ac0d911801..721a44d8a482 100644
--- a/Documentation/ABI/testing/sysfs-bus-cxl
+++ b/Documentation/ABI/testing/sysfs-bus-cxl
@@ -58,6 +58,16 @@ Description:
 		affinity for this device.
 
 
+What:		/sys/bus/cxl/devices/memX/security/state
+Date:		June, 2023
+KernelVersion:	v6.5
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(RO) Reading this file will display the CXL security state for
+		that device. Such states can be: 'disabled', or those available
+		only for persistent memory: 'locked', 'unlocked' or 'frozen'.
+
+
 What:		/sys/bus/cxl/devices/*/devtype
 Date:		June, 2021
 KernelVersion:	v5.14
diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 057a43267290..6e1d7d3610a2 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -107,6 +107,28 @@ static ssize_t numa_node_show(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RO(numa_node);
 
+static ssize_t security_state_show(struct device *dev,
+				   struct device_attribute *attr,
+				   char *buf)
+{
+	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+	unsigned long state = cxlds->security.state;
+
+	if (!(state & CXL_PMEM_SEC_STATE_USER_PASS_SET))
+		return sysfs_emit(buf, "disabled\n");
+	if (state & CXL_PMEM_SEC_STATE_FROZEN ||
+	    state & CXL_PMEM_SEC_STATE_MASTER_PLIMIT ||
+	    state & CXL_PMEM_SEC_STATE_USER_PLIMIT)
+		return sysfs_emit(buf, "frozen\n");
+	if (state & CXL_PMEM_SEC_STATE_LOCKED)
+		return sysfs_emit(buf, "locked\n");
+	else
+		return sysfs_emit(buf, "unlocked\n");
+}
+static struct device_attribute dev_attr_security_state =
+	__ATTR(state, 0444, security_state_show, NULL);
+
 static int cxl_get_poison_by_memdev(struct cxl_memdev *cxlmd)
 {
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
@@ -352,6 +374,11 @@ static struct attribute *cxl_memdev_ram_attributes[] = {
 	NULL,
 };
 
+static struct attribute *cxl_memdev_security_attributes[] = {
+	&dev_attr_security_state.attr,
+	NULL,
+};
+
 static umode_t cxl_memdev_visible(struct kobject *kobj, struct attribute *a,
 				  int n)
 {
@@ -375,10 +402,16 @@ static struct attribute_group cxl_memdev_pmem_attribute_group = {
 	.attrs = cxl_memdev_pmem_attributes,
 };
 
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
 
@@ -551,6 +584,15 @@ static const struct file_operations cxl_memdev_fops = {
 	.llseek = noop_llseek,
 };
 
+static int cxl_memdev_security_init(struct cxl_memdev *cxlmd)
+{
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+
+	cxlds->security.state = 0;
+
+	return 0;
+}
+
 struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds)
 {
 	struct cxl_memdev *cxlmd;
@@ -579,6 +621,10 @@ struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds)
 	if (rc)
 		goto err;
 
+	rc = cxl_memdev_security_init(cxlmd);
+	if (rc)
+		goto err;
+
 	rc = devm_add_action_or_reset(cxlds->dev, cxl_memdev_unregister, cxlmd);
 	if (rc)
 		return ERR_PTR(rc);
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 1d8e81c87c6a..5329274b0076 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -260,6 +260,15 @@ struct cxl_poison_state {
 	struct mutex lock;  /* Protect reads of poison list */
 };
 
+/**
+ * struct cxl_security_state - Device security state
+ *
+ * @state: state of last security operation
+ */
+struct cxl_security_state {
+	unsigned long state;
+};
+
 /**
  * struct cxl_dev_state - The driver device state
  *
@@ -297,6 +306,7 @@ struct cxl_poison_state {
  * @serial: PCIe Device Serial Number
  * @event: event log driver state
  * @poison: poison driver state info
+ * @security: device security state
  * @mbox_send: @dev specific transport for transmitting mailbox commands
  *
  * See section 8.2.9.5.2 Capacity Configuration and Label Storage for
@@ -336,6 +346,7 @@ struct cxl_dev_state {
 
 	struct cxl_event_state event;
 	struct cxl_poison_state poison;
+	struct cxl_security_state security;
 
 	struct rcuwait mbox_wait;
 	int (*mbox_send)(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd);
diff --git a/drivers/cxl/security.c b/drivers/cxl/security.c
index 4ad4bda2d18e..9da6785dfd31 100644
--- a/drivers/cxl/security.c
+++ b/drivers/cxl/security.c
@@ -34,6 +34,9 @@ static unsigned long cxl_pmem_get_security_flags(struct nvdimm *nvdimm,
 		return 0;
 
 	sec_out = le32_to_cpu(out.flags);
+	/* cache security state */
+	cxlds->security.state = sec_out;
+
 	if (ptype == NVDIMM_MASTER) {
 		if (sec_out & CXL_PMEM_SEC_STATE_MASTER_PASS_SET)
 			set_bit(NVDIMM_SECURITY_UNLOCKED, &security_flags);
-- 
2.40.1

