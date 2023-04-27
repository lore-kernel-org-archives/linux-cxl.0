Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D20BC77B7E
	for <linux-cxl@archiver.kernel.org>; Thu, 27 Apr 2023 15:47:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244179AbjD0Prb (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 27 Apr 2023 11:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244105AbjD0Pra (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 27 Apr 2023 11:47:30 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 104BF11B
        for <linux-cxl@vger.kernel.org>; Thu, 27 Apr 2023 08:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682610445; x=1714146445;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gqJi2vik9NUgAr9bOA5LltCWc8/TTPCLFAOWEEgMpDY=;
  b=PAHgvaLkUC53qleJjljD0/FfEDr2QYIXKKUOHVQzkeDgYJZ5KBwvDSvd
   Y1IrCyAtzhvc0dbuyPxyCbBOLfJ5Wp2vxVrp6UOZPMKmAljVzyuqjixKp
   iTwUE7CTbP+hwmk6CFRimXGn3GQWL2i2w4Dc+KPqabTNWXZ/4rHyJvOYN
   GiyUoOdxywXWXpOu38vVPd7WEVikZgH65Y760oiGA34tV6ziZdtwjkQzO
   NYobAxMo9MeRI7ZhocT2+Fn8ax5jM0rJe395P+qmfXzrrLkWy5qpH4RFZ
   hxzaT0d42FIuk1hQxnPGXQwYjdG00NGnwVUcPRaixMoHnb8xXmPkeDjUT
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="433768110"
X-IronPort-AV: E=Sophos;i="5.99,230,1677571200"; 
   d="scan'208";a="433768110"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2023 08:47:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="644753306"
X-IronPort-AV: E=Sophos;i="5.99,230,1677571200"; 
   d="scan'208";a="644753306"
Received: from abenich-mobl.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.123.129])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2023 08:47:23 -0700
Subject: [RESEND PATCH v2] cxl: Warn of flexible array in struct
 cxl_root_decoder
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     dan.j.williams@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com, ira.weiny@intel.com
Date:   Thu, 27 Apr 2023 08:47:23 -0700
Message-ID: <168261044311.369593.10950998135160952191.stgit@djiang5-mobl3>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

The 'cxl_switch_decoder' member in 'cxl_root_decoder' must be the last
element due to 'cxl_switch_decoder' has a flexible array at the
end of the struct. Any variables placed after will be corrupted.
Add a warning comment to 'cxl_root_decoder'.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>

---
v2:
- Clarify subject (Alison)
- Fit comment under 80 chars. (Alison)
---
 drivers/cxl/cxl.h |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 044a92d9813e..7db7e217b6f3 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -419,6 +419,7 @@ struct cxl_root_decoder {
 	cxl_calc_hb_fn calc_hb;
 	void *platform_data;
 	struct mutex range_lock;
+	/* Must be the last member. Struct contains a flexible array */
 	struct cxl_switch_decoder cxlsd;
 };
 


