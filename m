Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 535F2C433F5
	for <linux-cxl@archiver.kernel.org>; Fri, 11 Feb 2022 01:04:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346600AbiBKBEn (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 10 Feb 2022 20:04:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244058AbiBKBEm (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 10 Feb 2022 20:04:42 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1F3410BB
        for <linux-cxl@vger.kernel.org>; Thu, 10 Feb 2022 17:04:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644541482; x=1676077482;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=z4eYwYIDRohzBBXlw9aGJhhdUWKIRY+4DRqUZznnX8Y=;
  b=KW6LJGQMAItdc5mujMTMhBu0AQP30nLcitc0HMqI8G4yfGdX/DAL8QSQ
   UrgmAuqgy0+0KfkP0kb1ggEcgTC7xo3Mn6xutBTAd7Wqv/vbIfh5JgrFM
   GD/WaBU7JTflyNA9bDxRs7JiG6geKWLtCq4NsuXn//Tts6fkfi+jlgjqx
   pmlJaqXk7vA1KIc7PsejkyUAttqXB6NsSOFVWby8OZa/eMQPAagV8kL8M
   GKK1s0ZlICKSg/sz2CQGjkHXe7eFikugYfVRHTxk51/pOORpdi9tCg1Hn
   yr2QymEB0n1h4gieEBfg2RR+/4b1b6H7Lqs8lhlsKNwoBjcj1VaUzSKO0
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10254"; a="229596606"
X-IronPort-AV: E=Sophos;i="5.88,359,1635231600"; 
   d="scan'208";a="229596606"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2022 17:04:42 -0800
X-IronPort-AV: E=Sophos;i="5.88,359,1635231600"; 
   d="scan'208";a="629920186"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2022 17:04:42 -0800
Subject: [PATCH] cxl/port: Fix endpoint refcount leak
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     ben.widawsky@intel.com
Date:   Thu, 10 Feb 2022 17:04:42 -0800
Message-ID: <164454148209.3429624.12905500880311609053.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

An endpoint can be unregistered via two paths. Either its parent port is
unregistered, or the memdev that registered the endpoint is removed. The
memdev remove path is responsible for synchronizing against the parent
->remove() event and if the memdev remove path wins, manually trigger
unregister_port() via devm_release_action(). Until that race is resolved
the memdev remove path holds a reference on the endpoint.

If the parent port for the endpoint can not be found that is an
indication that the endpoint has already been registered. Be sure to
drop the reference in all exit paths from delete_endpoint().

Fixes: 8dd2bc0f8e02 ("cxl/mem: Add the cxl_mem driver")
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/port.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index d29eb2abdbc2..0fc1441be014 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -850,7 +850,7 @@ static void delete_endpoint(void *data)
 
 	parent_port = cxl_mem_find_port(cxlmd);
 	if (!parent_port)
-		return;
+		goto out;
 	parent = &parent_port->dev;
 
 	cxl_device_lock(parent);
@@ -860,6 +860,7 @@ static void delete_endpoint(void *data)
 	}
 	cxl_device_unlock(parent);
 	put_device(parent);
+out:
 	put_device(&endpoint->dev);
 }
 

