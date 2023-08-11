Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A47DBC001DE
	for <linux-cxl@archiver.kernel.org>; Fri, 11 Aug 2023 03:37:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbjHKDhg (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 10 Aug 2023 23:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjHKDhf (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 10 Aug 2023 23:37:35 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E21D2D66
        for <linux-cxl@vger.kernel.org>; Thu, 10 Aug 2023 20:37:34 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 980BF1014EE;
        Fri, 11 Aug 2023 03:37:33 +0000 (UTC)
Received: from pdx1-sub0-mail-a303.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 0E08E1018D1;
        Fri, 11 Aug 2023 03:37:33 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1691725053; a=rsa-sha256;
        cv=none;
        b=eANuFjM4niJtasB7UR9xs1XOew5USNI9TLVFqMw41680wNJYTrPNN047iYRgdcPDiXlU+D
        30JqcsCDJ1enwBgrGvchLF1+ZC7SPh3wUiAfw+OQPSPPYb38ht/G/PkGmEAzfl9eWea/EG
        Dg/vNewrodW6oucXbREz72UO35hBZiyJRP+6Oca0KlfxbCBd+l2dLx+3IwbpMnqLCuxQg6
        DaAZ5GBqN/J2Wz/DfJ667FkCTn0dKBNcd/HwAhoKSFdYcgYtMcDIazlZceMf7wRT89H7ur
        o1VWM6FA48h9wFK4Lb1REmr56I+X1MmP3rqmIcFJFYT6pGNx+JuhP5k8IvvbEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1691725053;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:dkim-signature;
        bh=taZ39XSs80JUGDwUwW1ntxON4dyUPTJF+zpzrq+lIUA=;
        b=eLAU7sjarxqS4Y+RlrV2j2I2WVqbWGw+x4+Py/Bi2847SrWAvPDUT2QeCaKJdMoTe2WNa0
        XamtrC5etwhwx2ZSJAkxAox+hPHe/Riuqo6D8c3dAX792Sh9DfydPgNk0Z7rWuaqex9xwY
        weCGq/hIcf/OqD0+lp9m+Jau/lgRYBnlPNrRdxmsRe14obkTJ5pmjNV/JekGWLEGpzNYcF
        jGRDWGDmAHZSMAMBWndTDnbbdKEq0Wn0pyNqHkcClc91yJmLzayO/E52l8Leii73HV42xt
        Qil0Vr8b01CN7/IT//0nb/BFGd9xfjgZviZdOEc27ot1jYpd5/wEOVzPKcDN7g==
ARC-Authentication-Results: i=1;
        rspamd-749bd77c9c-vxnkl;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Fearful-Average: 41aa993637646004_1691725053443_3790442149
X-MC-Loop-Signature: 1691725053443:307047409
X-MC-Ingress-Time: 1691725053443
Received: from pdx1-sub0-mail-a303.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.125.117.202 (trex/6.9.1);
        Fri, 11 Aug 2023 03:37:33 +0000
Received: from localhost.localdomain (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a303.dreamhost.com (Postfix) with ESMTPSA id 4RMTy42VL0zPT;
        Thu, 10 Aug 2023 20:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1691725052;
        bh=taZ39XSs80JUGDwUwW1ntxON4dyUPTJF+zpzrq+lIUA=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=CscWhnOXqMrM8VKVSKYnwO8a2UHDF/WgVJaQVhyPxiXKru8YhrWFmVgsjNz9J7MkW
         zZ839Oi9fXiBTtL7BR6r4/1QcM5xlxDuDnCYtoXcT7DyaK2vtCX8gw8ILD3aTveGpg
         U92l67Tdf7mZlCikT5UAR4TJoD0zASXFRRnO04KBcKozcs19diNo/QP2pp80n9ejRg
         3yHnXIqgYUCIHyxSXz/Bf7RGWGvhNOR7CyxRKntWwrzXtaR/fDoXZgU+9SQLuFnZj5
         /bSsysYFC8hx+CbJOggYU/tXhNxm3wKr1U6GmRU1Q8JQInBePJtJZ+PQu+6B0vPZyI
         AkDRfMfTkkYUg==
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     dan.j.williams@intel.com
Cc:     ira.weiny@intel.com, dave.jiang@intel.com,
        alison.schofield@intel.com, vishal.l.verma@intel.com,
        Jonathan.Cameron@huawei.com, dave@stgolabs.net,
        linux-cxl@vger.kernel.org
Subject: [PATCH v2] cxl/memdev: Decouple security init from devm_cxl_add_memdev()
Date:   Thu, 10 Aug 2023 19:57:55 -0700
Message-ID: <20230811025755.15103-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

A crash was reported during type2 device enablement[0] which called
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
it directly. This is more aligned with the intention of f6b8ab32e3ec
("cxl/memdev: Make mailbox functionality optional").

The cxl_memdev_security_shutdown() counterpart is removed altogether
and handle the sanitation corner case directly in the unregister. In
addition, the devm_cxl_add_memdev() cleanup path case is about ioctls,
and regardless, there is no way for the sanitation to become active
during that time.

[0] https://lore.kernel.org/all/168592160379.1948938.12863272903570476312.stgit@dwillia2-xfh.jf.intel.com/

Reported-by: Ira Weiny <ira.weiny@intel.com>
Tested-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
Changes from v1:
 - Picked up tags.
 - Add missing EXPORT_SYMBOL_NS_GPL.
 - Kill the shutdown function.
 - Fix typo in changelog.

 drivers/cxl/core/memdev.c | 28 +++++++++-------------------
 drivers/cxl/cxlmem.h      |  1 +
 drivers/cxl/pci.c         |  4 ++++
 3 files changed, 14 insertions(+), 19 deletions(-)

diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 14b547c07f54..13d334b11e64 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -556,21 +556,11 @@ void clear_exclusive_cxl_commands(struct cxl_memdev_state *mds,
 }
 EXPORT_SYMBOL_NS_GPL(clear_exclusive_cxl_commands, CXL);
 
-static void cxl_memdev_security_shutdown(struct device *dev)
-{
-	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
-	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
-
-	if (mds->security.poll)
-		cancel_delayed_work_sync(&mds->security.poll_dwork);
-}
-
 static void cxl_memdev_shutdown(struct device *dev)
 {
 	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
 
 	down_write(&cxl_memdev_rwsem);
-	cxl_memdev_security_shutdown(dev);
 	cxlmd->cxlds = NULL;
 	up_write(&cxl_memdev_rwsem);
 }
@@ -579,6 +569,10 @@ static void cxl_memdev_unregister(void *_cxlmd)
 {
 	struct cxl_memdev *cxlmd = _cxlmd;
 	struct device *dev = &cxlmd->dev;
+	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
+
+	if (mds && mds->security.poll)
+		cancel_delayed_work_sync(&mds->security.poll_dwork);
 
 	cxl_memdev_shutdown(dev);
 	cdev_device_del(&cxlmd->cdev, dev);
@@ -1009,11 +1003,10 @@ static void put_sanitize(void *data)
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
@@ -1029,7 +1022,8 @@ static int cxl_memdev_security_init(struct cxl_memdev *cxlmd)
 	}
 
 	return devm_add_action_or_reset(cxlds->dev, put_sanitize, mds);
- }
+}
+EXPORT_SYMBOL_NS_GPL(cxl_memdev_security_state_init, CXL);
 
 struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds)
 {
@@ -1059,10 +1053,6 @@ struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds)
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
@@ -887,7 +887,10 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
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

