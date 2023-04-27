Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9948CC77B61
	for <linux-cxl@archiver.kernel.org>; Thu, 27 Apr 2023 15:46:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243361AbjD0PqX (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 27 Apr 2023 11:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232698AbjD0PqW (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 27 Apr 2023 11:46:22 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 516AA2D76
        for <linux-cxl@vger.kernel.org>; Thu, 27 Apr 2023 08:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682610381; x=1714146381;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/1rkKjuW5SH1rg90/f/md696XOzEm3YXGkJWthMc5+U=;
  b=TM/HsYjWiy4UnXqOlNLGY+Xv2w3eDr7JaSJMY2tKK+Yw5t+BGuCqrDhi
   JeQuUcA7fHYVtrMNIuMPDom/uKfkUyC0rEUctWLcMATDwdGbXTLMdl6Ey
   UyjEEi+5SjWVQJe0NTUjl/TrTqbNv0b9ftTDe/cqldXtQT4gsKJxyKFRi
   WIBRAW5vmibsSvGBsyqihwrkvQqGhw4E60ZdpGyVA2KclVNjdh6N3HRf2
   EgiglUIiwcO4w3odOol7tdT4nSPIt3AV2gNzYapzY2bmDsF1j4sr04mAw
   5hsGgUDRG2OvrdsUhnVxVzFSWDvSDA1OLEqyhUsqd5GWTeyzPjr1dkxea
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="346245452"
X-IronPort-AV: E=Sophos;i="5.99,230,1677571200"; 
   d="scan'208";a="346245452"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2023 08:46:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="818597719"
X-IronPort-AV: E=Sophos;i="5.99,230,1677571200"; 
   d="scan'208";a="818597719"
Received: from abenich-mobl.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.123.129])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2023 08:46:20 -0700
Subject: [PATCH v2] cxl: Warn of flexible array in struct cxl_root_decoder
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     dan.j.williams@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com, ira.weiny@intel.com
Date:   Thu, 27 Apr 2023 08:46:19 -0700
Message-ID: <168261037969.369141.13800655850844046872.stgit@djiang5-mobl3>
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
index 044a92d9813e..999c0aa5ed54 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -419,6 +419,7 @@ struct cxl_root_decoder {
 	cxl_calc_hb_fn calc_hb;
 	void *platform_data;
 	struct mutex range_lock;
+	/* This must be the last member of the struct. It contains a flexible array */
 	struct cxl_switch_decoder cxlsd;
 };
 


