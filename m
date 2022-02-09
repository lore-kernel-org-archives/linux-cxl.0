Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 803E5C433EF
	for <linux-cxl@archiver.kernel.org>; Wed,  9 Feb 2022 07:38:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233789AbiBIHh5 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 9 Feb 2022 02:37:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238705AbiBIHhn (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 9 Feb 2022 02:37:43 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8B36C050CD4
        for <linux-cxl@vger.kernel.org>; Tue,  8 Feb 2022 23:37:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644392254; x=1675928254;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=b2RTqzvbiIcedz5vr5KRV1pYvtVgmTLu2mMqaaMc63g=;
  b=Dn29VJ1X0tQMEuVv4cjs14N6aiDG4b/vx7KBQsYN0o88maNrW30F+c+I
   YRj58hzyg/ZG8WAlRXcLDGsypFUxiKpRcvRLWwlNtr+0dxKE1ZmnQ2upz
   tetgh10DVzeGUdp26QAcTpcUcsFoecsdMUgz9StpZPmHMXAzGY62ggjHQ
   7x3zXt0g/aCwqnqNKSHmVAbXR4VPMui3q8JnnFcu/b36YzfMIjMidTkcC
   BvHG7f+q4XlEAJ2U5Gba1Bpcke1krJslqquOgxpWwOKlAYHp/SEDjo/OS
   ufwePPspxTUKokBJMWp9CRK6G8Gg0Y5eO2FTt9t6RroHjXZwpRrlw9soy
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10252"; a="248906444"
X-IronPort-AV: E=Sophos;i="5.88,355,1635231600"; 
   d="scan'208";a="248906444"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2022 23:37:34 -0800
X-IronPort-AV: E=Sophos;i="5.88,355,1635231600"; 
   d="scan'208";a="701164610"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2022 23:37:34 -0800
Subject: [PATCH] cxl/core: Fix cxl_device_lock() class detection
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>
Date:   Tue, 08 Feb 2022 23:37:34 -0800
Message-ID: <164439225406.2941117.3927102269866914339.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

If cxl_device_lock() is used on a non-CXL device the expectation is that
the lock class will fall back to CXL_ANON_LOCK. Instead it crashes when
trying to determine if the device is a 'decoder'. Specifically when the
device has a NULL type pointer. Just check for NULL before
de-referencing ->release.

Fixes: 3c5b90395525 ("cxl: Prove CXL locking")
Reported-by: Ben Widawsky <ben.widawsky@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/port.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 9b4bbd51fbaa..d29eb2abdbc2 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -284,7 +284,7 @@ EXPORT_SYMBOL_NS_GPL(is_root_decoder, CXL);
 
 bool is_cxl_decoder(struct device *dev)
 {
-	return dev->type->release == cxl_decoder_release;
+	return dev->type && dev->type->release == cxl_decoder_release;
 }
 EXPORT_SYMBOL_NS_GPL(is_cxl_decoder, CXL);
 

