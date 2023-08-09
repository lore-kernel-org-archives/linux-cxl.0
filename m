Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 814E5C001E0
	for <linux-cxl@archiver.kernel.org>; Wed,  9 Aug 2023 17:16:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbjHIRQK (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 9 Aug 2023 13:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232834AbjHIRQG (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 9 Aug 2023 13:16:06 -0400
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8A281FF5
        for <linux-cxl@vger.kernel.org>; Wed,  9 Aug 2023 10:15:44 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id C8745141ADC;
        Wed,  9 Aug 2023 17:15:43 +0000 (UTC)
Received: from pdx1-sub0-mail-a209.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 03853140FD7;
        Wed,  9 Aug 2023 17:15:43 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1691601343; a=rsa-sha256;
        cv=none;
        b=jKUihXING8EJ4pZZ38HEDCsmwZVfPVGyXhP+LTQgJEgfIZUSo0+1fnP+l1rO+RYaggxVZ0
        a7nQdFAlMpSjKohLQSwxHFJn9vYxVXh27q5dgFSlr6EZCa+WSZdjVfaaWyLAcgYEtAaWr1
        JHDxSe9y9Ozx+D3b9TH/zfkrUubxoRgOPCiKReIpPRmh18QhV459lM7qfoDIk/ItkGaRse
        ytfoNZYCIYNAUzNdVZyWrY2AgD9fQWCY5k9S48aqB0cdAqKDCemvfH3n8WNkoY/6Hppix7
        midzo8SmUhmKIbcedtB+UFVB8COnEC611xknVqe1z8XcDa8b57SqNYGZwgntDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1691601343;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:dkim-signature;
        bh=q268FAIn25WDPLDbV47mUQOb6JNVlHOJ2vETN9wiQyo=;
        b=MLaXtpqoKaQu/YtAvyH3q4EHnDG+QBFiktglrTZywdNTm/wZ23CYbhXG1SCTlv8ypSTVsY
        sn1wsF2BLa5c9aYou0lx8HP3ve+cKoOa4XfueIfv7u2hjnaLrUgYrWXz5ZFe6jEyX8Q/AI
        vLfO4noCN7FlFqlwaExKv57sMk6if7+akdB6mtsqhRuQgCfJe3GKh7M3V8lfzivjCe5nbY
        Mkg4JPlO2byVMQrEWr3ov5wZSVs34+BU1OAKOwcSx/ZyUGvlO6vA5MxjDecLtr46Iw8mPI
        RdM0qQvZYhdp01Nnu26ErXDCTuudoi51FQekH3ohlQnfk1HnB5UwgggTxnR/RQ==
ARC-Authentication-Results: i=1;
        rspamd-749bd77c9c-bbdl4;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Soft-Lyrical: 49bb549c7ffbb6ee_1691601343641_314075629
X-MC-Loop-Signature: 1691601343641:3984341397
X-MC-Ingress-Time: 1691601343641
Received: from pdx1-sub0-mail-a209.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.100.168.12 (trex/6.9.1);
        Wed, 09 Aug 2023 17:15:43 +0000
Received: from localhost.localdomain (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a209.dreamhost.com (Postfix) with ESMTPSA id 4RLcC23D71z2v;
        Wed,  9 Aug 2023 10:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1691601342;
        bh=q268FAIn25WDPLDbV47mUQOb6JNVlHOJ2vETN9wiQyo=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=KIwFzsI2eWw6Nc6eICsZ5Jz3Ox19nkp+lPpKPMPh7fx9yG3ROTDGXr/P6DLFYDxe7
         iNJ9w+8inVIzjQHveqGpIcpntX3+65HiH2M4q5J8KFBvLA82OJYQdNNCEwHl0++yYg
         vfDrnIk5P2e/3IKvZLMbTD4ml+h3vcOK0w2n4BT4x5Ouy6PfJ03pKz8IvWyegG3QhH
         +K17OJN2cHyXWXPDaPiQ5AfBk6r8dcDZ8PuUfrUWmA0CNetmld78j0RDp+Il9cqO6z
         Y7jkq8QOtRsq7JmQtmKwK3EmyLau0xvuxj3RmviQSgcQyVq3VvgAVwGX2icbDHjFwA
         zZsiOUVJdRd5Q==
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     dan.j.williams@intel.com
Cc:     ira.weiny@intel.com, dave.jiang@intel.com,
        alison.schofield@intel.com, Jonathan.Cameron@huawei.com,
        dave@stgolabs.net, linux-cxl@vger.kernel.org
Subject: [PATCH] cxl/memdev: Decouple security init from devm_cxl_add_memdev()
Date:   Wed,  9 Aug 2023 09:37:33 -0700
Message-ID: <20230809163733.32008-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

A crash was reported during type2 device entablement[0] which called
devm_cxl_add_memdev() without an mds, causing the security state
init steps to be bogus.

  BUG: kernel NULL pointer dereference, address: 0000000000000278
  [...]
  RIP: 0010:devm_cxl_add_memdev+0x1de/0x2c0 [cxl_core]
  [...]
  Call Trace:
   <TASK>
   ? __die+0x1f/0x70
   ? page_fault_oops+0x149/0x420
   ? fixup_exception+0x22/0x310
   ? kernelmode_fixup_or_oops+0x84/0x110
   ? exc_page_fault+0x6d/0x150
   ? asm_exc_page_fault+0x22/0x30
   ? devm_cxl_add_memdev+0x1de/0x2c0 [cxl_core]
   cxl_mock_mem_probe+0x632/0x870 [cxl_mock_mem]
   platform_probe+0x40/0x90
   really_probe+0x19e/0x3e0
   ? __pfx___driver_attach+0x10/0x10
   __driver_probe_device+0x78/0x160
   driver_probe_device+0x1f/0x90
   __driver_attach+0xce/0x1c0
   bus_for_each_dev+0x63/0xa0
   bus_add_driver+0x112/0x210
   driver_register+0x55/0x100
   ? __pfx_cxl_mock_mem_driver_init+0x10/0x10 [cxl_mock_mem]
   [...]

Move out cxl_memdev_security_init() and allow the pci probing to call
it directly.

The cxl_memdev_security_shutdown() counterpart will still be called
by the unregistering scenario, but is removed, however, from the
devm_cxl_add_memdev() cleanup path - as this is about ioctls and
there is no way for the sanitation to become active during that time.

[0] https://lore.kernel.org/all/168592160379.1948938.12863272903570476312.stgit@dwillia2-xfh.jf.intel.com/

Reported-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 drivers/cxl/core/memdev.c | 17 ++++++-----------
 drivers/cxl/cxlmem.h      |  1 +
 drivers/cxl/pci.c         |  4 ++++
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 14b547c07f54..628d9d1fb795 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -561,7 +561,7 @@ static void cxl_memdev_security_shutdown(struct device *dev)
 	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
 	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
 
-	if (mds->security.poll)
+	if (mds && mds->security.poll)
 		cancel_delayed_work_sync(&mds->security.poll_dwork);
 }
 
@@ -570,7 +570,6 @@ static void cxl_memdev_shutdown(struct device *dev)
 	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
 
 	down_write(&cxl_memdev_rwsem);
-	cxl_memdev_security_shutdown(dev);
 	cxlmd->cxlds = NULL;
 	up_write(&cxl_memdev_rwsem);
 }
@@ -580,6 +579,7 @@ static void cxl_memdev_unregister(void *_cxlmd)
 	struct cxl_memdev *cxlmd = _cxlmd;
 	struct device *dev = &cxlmd->dev;
 
+	cxl_memdev_security_shutdown(dev);
 	cxl_memdev_shutdown(dev);
 	cdev_device_del(&cxlmd->cdev, dev);
 	put_device(dev);
@@ -1009,11 +1009,10 @@ static void put_sanitize(void *data)
 	sysfs_put(mds->security.sanitize_node);
 }
 
-static int cxl_memdev_security_init(struct cxl_memdev *cxlmd)
+int cxl_memdev_security_state_init(struct cxl_memdev_state *mds)
 {
-	struct cxl_dev_state *cxlds = cxlmd->cxlds;
-	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
-	struct device *dev = &cxlmd->dev;
+	struct cxl_dev_state *cxlds = &mds->cxlds;
+	struct device *dev = &cxlds->cxlmd->dev;
 	struct kernfs_node *sec;
 
 	sec = sysfs_get_dirent(dev->kobj.sd, "security");
@@ -1029,7 +1028,7 @@ static int cxl_memdev_security_init(struct cxl_memdev *cxlmd)
 	}
 
 	return devm_add_action_or_reset(cxlds->dev, put_sanitize, mds);
- }
+}
 
 struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds)
 {
@@ -1059,10 +1058,6 @@ struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds)
 	if (rc)
 		goto err;
 
-	rc = cxl_memdev_security_init(cxlmd);
-	if (rc)
-		goto err;
-
 	rc = devm_add_action_or_reset(cxlds->dev, cxl_memdev_unregister, cxlmd);
 	if (rc)
 		return ERR_PTR(rc);
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 706f8a6d1ef4..b99099eb2402 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -884,6 +884,7 @@ static inline void cxl_mem_active_dec(void)
 #endif
 
 int cxl_mem_sanitize(struct cxl_memdev_state *mds, u16 cmd);
+int cxl_memdev_security_state_init(struct cxl_memdev_state *mds);
 
 struct cxl_hdm {
 	struct cxl_component_regs regs;
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 1cb1494c28fe..5242dbf0044d 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -887,6 +887,10 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (IS_ERR(cxlmd))
 		return PTR_ERR(cxlmd);
 
+	rc = cxl_memdev_security_state_init(mds);
+	if (rc)
+		return rc;
+
 	rc = cxl_memdev_setup_fw_upload(mds);
 	if (rc)
 		return rc;
-- 
2.41.0

