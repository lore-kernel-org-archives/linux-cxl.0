Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 517BFC7618E
	for <linux-cxl@archiver.kernel.org>; Fri, 21 Apr 2023 09:55:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbjDUJz6 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 21 Apr 2023 05:55:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232011AbjDUJzr (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 21 Apr 2023 05:55:47 -0400
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B830BB441
        for <linux-cxl@vger.kernel.org>; Fri, 21 Apr 2023 02:55:40 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id E8B6D881DA8;
        Fri, 21 Apr 2023 09:55:39 +0000 (UTC)
Received: from pdx1-sub0-mail-a204.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 6635C881CB9;
        Fri, 21 Apr 2023 09:55:39 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1682070939; a=rsa-sha256;
        cv=none;
        b=Ws4aGVarXNLn19Dy5pR3MR/SYTm5ktPXuFEzve5ag2uNk2uhmpwaj76r3C1i7yJoTAsBIi
        fV7P6QbQ2KfHQbinQc9H+BcdYohc/QiTK/r5tAQsRRBWbhJmNcz2/hFse6EzNGXODfL5By
        xIb+P1eT1tr5BBwGyohr5N7Hh/fTpCAhRELLzImknzY3BfTALHihY+g+as8gO3TWfGvTBK
        FKZRtQBPs/F5nIEojXERxWGzZLnpTZMvikNru6wBFlYMTf5b01SQp/rrbvP6gE3r9YiGc0
        ac922WKO1iivEuKocfxhnIit7ZAJAQS8TmGbaqGgiK9KurWutpYFzN+kdg8oFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1682070939;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=dUh3MF13ZlGBuHd8p/JIkdIbzcdb8EQOzw5Ag0TrsUU=;
        b=umPsVvqsvdVVHXOqz4Vhy4eo4JDMQWNhThzGxEJmY1z3HG+BnsBlVMMCmVJ2d83FHMqfpn
        bsgmyu3/Y4TeRAqdeUuxeEvPenH/fs71JNXmt6bD5+g5gjIZcjWWZb31HORlLhYqyAKES/
        OwYKcGl8xR7Uj63kUIRtH4cytm5LhCsBSrBJjuoesaFxR3QWWUx5R484F1KAFgvMCAA24x
        W32Y6iG5nKuNpBBSnEnD2LfLqdYYcNei2Y1j4QGBSNuXTwH1HrMoG79/kCOSmhOo2fMR2S
        KZLe4H3VYGgYlqlG+ZJad/r5O7g2WFLFvDFMNsGyBc7Vn9qVWBxLOucZRFr1Lg==
ARC-Authentication-Results: i=1;
        rspamd-7f66b7b68c-qw5fh;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Arithmetic-Glossy: 26eb33ef35e9ae1b_1682070939749_893583836
X-MC-Loop-Signature: 1682070939749:266840768
X-MC-Ingress-Time: 1682070939749
Received: from pdx1-sub0-mail-a204.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.126.30.36 (trex/6.7.2);
        Fri, 21 Apr 2023 09:55:39 +0000
Received: from localhost.localdomain (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a204.dreamhost.com (Postfix) with ESMTPSA id 4Q2qf24Cq1zRN;
        Fri, 21 Apr 2023 02:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1682070939;
        bh=dUh3MF13ZlGBuHd8p/JIkdIbzcdb8EQOzw5Ag0TrsUU=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=T741pZFLKIcoU1JJyKZBp10IJnl0KpApVU15g+TYmhft+wbysig1jyh90CVvq6BEm
         6rlrb7/0+aKJgUFm+9/SKo61V0S7fn1c8FbcfJ3fgJkTx/m0WlliTl8iNjpjui1yDy
         Hq3SxklhNr0+bAa1wVD1vSguC6n7zEgtkQSI9BF5ueZ9s5bMjIDLnhCV/02oq03792
         qCUos1FrPUnblcYpok8jcKr8VcltF3GvUY3sLh+XIu3iZH9w6C/N3EL+dmc9BIiOrQ
         gHxNMOFW4DUr58UvYisV6JuzGowfzqBPgpWHvSp21CfbD7PnF7MoTup+z27TVghpvg
         JpiNkAFGpv+7g==
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     dan.j.williams@intel.com
Cc:     Jonathan.Cameron@huawei.com, dave.jiang@intel.com,
        alison.schofield@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, fan.ni@samsung.com,
        a.manzanares@samsung.com, dave@stgolabs.net,
        linux-cxl@vger.kernel.org
Subject: [PATCH 6/7] cxl/mem: Support Secure Erase
Date:   Fri, 21 Apr 2023 02:23:20 -0700
Message-Id: <20230421092321.12741-7-dave@stgolabs.net>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230421092321.12741-1-dave@stgolabs.net>
References: <20230421092321.12741-1-dave@stgolabs.net>
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
 Documentation/ABI/testing/sysfs-bus-cxl | 10 ++++++++
 drivers/cxl/core/mbox.c                 |  6 ++++-
 drivers/cxl/core/memdev.c               | 34 +++++++++++++++++++++++++
 drivers/cxl/cxlmem.h                    |  1 +
 4 files changed, 50 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
index 2e98ec9220ca..af7b603faf77 100644
--- a/Documentation/ABI/testing/sysfs-bus-cxl
+++ b/Documentation/ABI/testing/sysfs-bus-cxl
@@ -77,6 +77,16 @@ Description:
 		completion.
 
 
+What            /sys/bus/cxl/devices/memX/security/erase
+Date:           May, 2023
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
index 28daf7dcdec4..a2180f3e09eb 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -1049,7 +1049,7 @@ int cxl_mem_sanitize(struct cxl_dev_state *cxlds, u16 cmd)
 	};
 	struct cxl_mbox_cmd mbox_cmd = { .opcode = cmd };
 
-	if (cmd != CXL_MBOX_OP_SANITIZE)
+	if (cmd != CXL_MBOX_OP_SANITIZE && cmd != CXL_MBOX_OP_SECURE_ERASE)
 		return -EINVAL;
 
 	rc = cxl_internal_send_cmd(cxlds, &sec_cmd);
@@ -1067,6 +1067,10 @@ int cxl_mem_sanitize(struct cxl_dev_state *cxlds, u16 cmd)
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
index 70e7158826c9..6406e8e47da2 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -138,6 +138,39 @@ static struct device_attribute dev_attr_security_sanitize =
 	__ATTR(sanitize, 0644,
 	       security_sanitize_show, security_sanitize_store);
 
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
+		struct cxl_port *port = dev_get_drvdata(&cxlmd->dev);
+
+		if (!port || !is_cxl_endpoint(port))
+			return -EINVAL;
+		/* ensure no regions are mapped to this memdev */
+		if (port->commit_end != -1)
+			return -EBUSY;
+
+		rc = cxl_mem_sanitize(cxlds, CXL_MBOX_OP_SECURE_ERASE);
+	}
+
+	if (rc == 0)
+		rc = len;
+	return rc;
+}
+
+static struct device_attribute dev_attr_security_erase =
+	__ATTR(erase, 0200, NULL, security_erase_store);
+
 static ssize_t serial_show(struct device *dev, struct device_attribute *attr,
 			   char *buf)
 {
@@ -199,6 +232,7 @@ static struct attribute_group cxl_memdev_pmem_attribute_group = {
 
 static struct attribute *cxl_memdev_security_attributes[] = {
 	&dev_attr_security_sanitize.attr,
+	&dev_attr_security_erase.attr,
 	NULL,
 };
 
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 9bd33cfdc0ec..f8b513e70c21 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -345,6 +345,7 @@ enum cxl_opcode {
 	CXL_MBOX_OP_SCAN_MEDIA		= 0x4304,
 	CXL_MBOX_OP_GET_SCAN_MEDIA	= 0x4305,
 	CXL_MBOX_OP_SANITIZE		= 0x4400,
+	CXL_MBOX_OP_SECURE_ERASE		= 0x4401,
 	CXL_MBOX_OP_GET_SECURITY_STATE	= 0x4500,
 	CXL_MBOX_OP_SET_PASSPHRASE	= 0x4501,
 	CXL_MBOX_OP_DISABLE_PASSPHRASE	= 0x4502,
-- 
2.40.0

