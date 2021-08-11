Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.9 required=3.0 tests=BAYES_00,
	DATE_IN_FUTURE_06_12,DKIM_INVALID,DKIM_SIGNED,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E26C6C4338F
	for <linux-cxl@archiver.kernel.org>; Wed, 11 Aug 2021 08:01:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B590960F55
	for <linux-cxl@archiver.kernel.org>; Wed, 11 Aug 2021 08:01:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235966AbhHKIBc (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 11 Aug 2021 04:01:32 -0400
Received: from usmail.montage-tech.com ([12.176.92.53]:55899 "EHLO
        usmail.montage-tech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235837AbhHKIBJ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 11 Aug 2021 04:01:09 -0400
X-Greylist: delayed 406 seconds by postgrey-1.27 at vger.kernel.org; Wed, 11 Aug 2021 04:01:09 EDT
X-MDAV-Result: clean
X-MDAV-Processed: usmail.montage-tech.com, Wed, 11 Aug 2021 00:53:53 -0700
Received: from shmail.montage-tech.com by usmail.montage-tech.com with ESMTP id md5001005753117.msg; 
        Wed, 11 Aug 2021 00:53:52 -0700
X-MDArrival-Date: Wed, 11 Aug 2021 00:53:52 -0700
X-Return-Path: prvs=185740f129=johnny.li@montage-tech.com
X-Envelope-From: johnny.li@montage-tech.com
X-MDaemon-Deliver-To: linux-cxl@vger.kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=montage-tech.com;
        s=MDaemon; t=1628668428; x=1629273228;
        i=johnny.li@montage-tech.com; q=dns/txt; h=From:To:Cc:Subject:
        Date:Message-Id; bh=mway5rp8UQJT7KHpLoJ7ZB4jujutVSt4NbeqkgbJsoc=;
        b=Xzv4hZhql5rF+z6Wp3FppuC8fEdgsT62psyKBUMvzS0YCtPa7ojXRkBozW8DK1
        Ekq7AnpMVYqshAiN4csS0b6Rn3/ZknZaeYZACm183UBppibjRVS7gJAKkrYPsd6e
        dPynR/QhuNEcf+jucyg4B0OFzQEQ9JuKjIG+sVruRE/yI=
X-MDAV-Result: clean
X-MDAV-Processed: shmail.montage-tech.com, Wed, 11 Aug 2021 15:53:48 +0800
Received: from montage-desktop by shmail.montage-tech.com with ESMTPA id pp5001017238344.msg; 
        Wed, 11 Aug 2021 15:53:48 +0800
From:   "Li Qiang (Johnny Li)" <johnny.li@montage-tech.com>
To:     linux-cxl@vger.kernel.org
Cc:     ira.weiny@intel.com, dan.j.williams@intel.com,
        ben.widawsky@intel.com, Jonathan.Cameron@huawei.com,
        "Li Qiang (Johnny Li)" <johnny.li@montage-tech.com>
Subject: [PATCH v1] cxl/pci: Fix debug message in cxl_probe_regs()
Date:   Wed, 11 Aug 2021 15:47:47 -0400
Message-Id: <20210811194747.44688-1-johnny.li@montage-tech.com>
X-Mailer: git-send-email 2.17.1
X-MDCFSigsAdded: montage-tech.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Indicator string for mbox and memdev register set to status
incorrectly in error message.

Signed-off-by: Li Qiang (Johnny Li) <johnny.li@montage-tech.com>
---
 drivers/cxl/pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 47315bb2db10..70e80237865c 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -1032,8 +1032,8 @@ static int cxl_probe_regs(struct cxl_mem *cxlm, void __iomem *base,
 		    !dev_map->memdev.valid) {
 			dev_err(dev, "registers not found: %s%s%s\n",
 				!dev_map->status.valid ? "status " : "",
-				!dev_map->mbox.valid ? "status " : "",
-				!dev_map->memdev.valid ? "status " : "");
+				!dev_map->mbox.valid ? "mbox " : "",
+				!dev_map->memdev.valid ? "memdev " : "");
 			return -ENXIO;
 		}
 
-- 
2.17.1



