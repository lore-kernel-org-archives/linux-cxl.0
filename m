Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 259C0C7EE2F
	for <linux-cxl@archiver.kernel.org>; Mon, 12 Jun 2023 18:45:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233586AbjFLSp1 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 12 Jun 2023 14:45:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234484AbjFLSp0 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 12 Jun 2023 14:45:26 -0400
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74593189
        for <linux-cxl@vger.kernel.org>; Mon, 12 Jun 2023 11:45:25 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id B081A141BF4;
        Mon, 12 Jun 2023 18:45:24 +0000 (UTC)
Received: from pdx1-sub0-mail-a316.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 060A514176D;
        Mon, 12 Jun 2023 18:45:24 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1686595524; a=rsa-sha256;
        cv=none;
        b=K7Vzu3dTt8HhBOsav3CEblKKgd42vJRIbFMUOc7vLSYX9CNL9TJ5xAEeuI2kypw3AT7bMA
        xebfTnFmYq7ma5g+PjClADeJp16w3FJ2Q9/XDmnKsxh5HNYlOC/VSCFPBs7Rr7TtBd184l
        xzfaM4paV3eWjxEAd1VvDfwrJXcrfGOlaorqf8cmKEc1QXw/E2wbMvJVbrD/6fhnVglQ6U
        mgVATEUYPkjrdG4D4TS3IXdCE6ar8jl1eMJnisWfOHy9ZVm4DOTrVO+pCSzeCaWnenR4GB
        a0Twa+wnIftFnUcAywWG13XQrr7MT9vcBOfYoPEseC1DkGtRUmpl65LsnUolLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1686595524;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=JSkW/AbJnGyuWN6X0hmjYxQ7Qm9s4hbO+3fDpZXzSV8=;
        b=eJG2BAuE+1e5RofvwoT/WpddE7KFOTMfj3Btq2W/Zhg3ppejDT4AFR462331SCDvDmBWR1
        ap1p+rbSl4AZps2Do+p7HH8qWySPwazTs5qKgqvuLpchnl3LOYMtVgpXka+WW2OJJWrPzq
        Jhmi+OHfoZeRbgRYIbgB5Ll9rp00ttobQvPO15MNpL30cUwHWdFBTevozy4VOYvoNDH/gE
        j2mgU030FrJByy+rFaRTTjdRZ+NijkQDgGKw4HjQvfeImfRdSnjICiAT8mtilyLCnt1THy
        xQdrgNRit8sJxlBXHgydvTkfYBPQsGwUKaCMSOkH5zT3SjO6W6gX17k2EwTL1w==
ARC-Authentication-Results: i=1;
        rspamd-6c69b8658d-x5df5;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Daffy-Coil: 71be2f8d189b2b2d_1686595524456_1116937861
X-MC-Loop-Signature: 1686595524456:4128173717
X-MC-Ingress-Time: 1686595524456
Received: from pdx1-sub0-mail-a316.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.126.30.17 (trex/6.8.1);
        Mon, 12 Jun 2023 18:45:24 +0000
Received: from localhost.localdomain (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a316.dreamhost.com (Postfix) with ESMTPSA id 4Qg0xH18vmzXL;
        Mon, 12 Jun 2023 11:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1686595523;
        bh=JSkW/AbJnGyuWN6X0hmjYxQ7Qm9s4hbO+3fDpZXzSV8=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=d+85juhSRGJ9TKldaWfRLCV/4/4XNI2MWbl0W5KPSFv7Sy+m2ToboY6i/MX1lxHMg
         rCOHdD9U4lesuT9wIcMml0j/Y20CtvXOsu0JpjYyyvPb7SI/S1TfAlKMiLkXODqt/b
         9xlQhZ3l73ek+CrsU9s8ZKNL8ulLmV3aI4UhSO/VH1epAJ+IXusa/Vx1MHIKf+UEEj
         QoZcBxhXDUJKWILpsBLcp+qotW3w31AKtPIF3oOuhv/eXhsE1oe0+IijA46A+gYbOl
         z1nGtZNIsHIsOulfnz3cHv2fk4L9DT44S+G2q33Sqxr25e6d5IIy5XslVKpAuJ6GKW
         I3UTqL7mJVrOQ==
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     dan.j.williams@intel.com
Cc:     dave.jiang@intel.com, vishal.l.verma@intel.com,
        Jonathan.Cameron@huawei.com, fan.ni@samsung.com,
        a.manzanares@samsung.com, dave@stgolabs.net,
        linux-cxl@vger.kernel.org
Subject: [PATCH 2/7] cxl/mem: Introduce security state sysfs file
Date:   Mon, 12 Jun 2023 11:10:33 -0700
Message-ID: <20230612181038.14421-3-dave@stgolabs.net>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230612181038.14421-1-dave@stgolabs.net>
References: <20230612181038.14421-1-dave@stgolabs.net>
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

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Fan Ni <fan.ni@samsung.com>
Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 Documentation/ABI/testing/sysfs-bus-cxl | 10 ++++++++
 drivers/cxl/core/memdev.c               | 33 +++++++++++++++++++++++++
 drivers/cxl/cxlmem.h                    | 10 ++++++++
 drivers/cxl/security.c                  |  3 +++
 4 files changed, 56 insertions(+)

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
index 057a43267290..1bbb7e39fc93 100644
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
 
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 1d8e81c87c6a..091f1200736b 100644
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
@@ -336,6 +345,7 @@ struct cxl_dev_state {
 
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
2.41.0

