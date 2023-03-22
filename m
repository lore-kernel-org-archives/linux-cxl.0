Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4824C6FD1C
	for <linux-cxl@archiver.kernel.org>; Wed, 22 Mar 2023 17:33:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbjCVRdM (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 22 Mar 2023 13:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbjCVRdF (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 22 Mar 2023 13:33:05 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED65710261
        for <linux-cxl@vger.kernel.org>; Wed, 22 Mar 2023 10:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679506381; x=1711042381;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=mW9DcPH8Yg/fS3uSPXdC5+VQM3BhGVNaKX0DrroaIhU=;
  b=drf/7b3TBlBij8iwArPP2idZqfyrirmpXanSD+XHrwsSyaBYwJn2Z9DF
   sP2jPt1rgjRTapjdNpwC2qJD5JPDB3e9CnvLPkoV/I09GRYlNnB/sUpoO
   OaUU/QZXEXMP8mmnmZBHKeA2Zfl2TvmnZZtc/VXIlDgBWeeudPyQKqOYv
   pHKOPI2Jzsjws0vEUzAeaEfOWkhuw1glMtkSOHzTTNbK14t+RqeZmP3NP
   4VMCgIIuG+1XXoyHqOVhI0uP3cS1xQeH5LF8mtQxP0P+WKKCC1Lt+9EEb
   8BHA98XJneN4uBQ1/5p/qJ+6+9JObvQO5GoWSNkEqtLMIg8ClDx4OXeoF
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="338004692"
X-IronPort-AV: E=Sophos;i="5.98,282,1673942400"; 
   d="scan'208";a="338004692"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2023 10:33:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="684390498"
X-IronPort-AV: E=Sophos;i="5.98,282,1673942400"; 
   d="scan'208";a="684390498"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.102.179])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2023 10:33:01 -0700
Subject: [PATCH] hw/pci-bridge/cxl_upstream: Fix bandwidth entry base unit for
 SSLBIS
From:   Dave Jiang <dave.jiang@intel.com>
To:     jonathan.cameron@huawei.com
Cc:     linux-cxl@vger.kernel.org
Date:   Wed, 22 Mar 2023 10:33:00 -0700
Message-ID: <167950638058.386189.535068546966379964.stgit@djiang5-mobl3>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

According to ACPI spec 6.5 5.2.28.4 System Locality Latency and Bandwidth
Information Structure, if the "Entry Base Unit" is 1024 for BW and the
matrix entry has the value of 100, the BW is 100 GB/s. So the
entry_base_unit should be changed from 1000 to 1024 given the comment notes
it's 16GB/s for .latency_bandwidth.

Fixes: 882877fc359d ("hw/pci-bridge/cxl-upstream: Add a CDAT table access DOE")
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 hw/pci-bridge/cxl_upstream.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/pci-bridge/cxl_upstream.c b/hw/pci-bridge/cxl_upstream.c
index 2a00b708e560..d6f19c859a3d 100644
--- a/hw/pci-bridge/cxl_upstream.c
+++ b/hw/pci-bridge/cxl_upstream.c
@@ -297,7 +297,7 @@ static int build_cdat_table(CDATSubHeader ***cdat_table, void *priv)
                 .length = sslbis_size,
             },
             .data_type = HMATLB_DATA_TYPE_ACCESS_BANDWIDTH,
-            .entry_base_unit = 1000,
+            .entry_base_unit = 1024,
         },
     };
 


