Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CC89C4332F
	for <linux-cxl@archiver.kernel.org>; Thu, 15 Dec 2022 01:33:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbiLOBdy (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 14 Dec 2022 20:33:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiLOBdx (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 14 Dec 2022 20:33:53 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14BD51573D
        for <linux-cxl@vger.kernel.org>; Wed, 14 Dec 2022 17:33:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671068033; x=1702604033;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=z9eODezsPy7Rw5mnUQGAQgnTCaFN0Ji0CSYnimwBRQM=;
  b=KorMU+hQlrpB7s8jo664cfwXjOFyxIj31Z/uwt95JX8DE8+JuYhqV5lj
   4Glc27hb24bijkNFNDQtubZx1hXFHqSBo0ipMF6A8UW5L/R7KBCVHFf16
   s+KMLgMTQDm2mvKRmcaZk1yaBtcStr5rZU4+Elh5R7441uOmYt5Tl3jfn
   azPSwx0caKTnFGIDJzb0x9XkLTBdTKyv8uBNVbGWtq7++CHG1v7SdsGag
   hwi2wb0mHaM/Ze7K5RVbS6yv6dd0PiWBH4uLYl9gIkb2CxQ8mlkPE3/ST
   ceIXl00/DrKtK2m35PxNlzITLOdQ2IP+bVlwq73QEV61EKILuJQBQTH4p
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10561"; a="345642642"
X-IronPort-AV: E=Sophos;i="5.96,246,1665471600"; 
   d="scan'208";a="345642642"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2022 17:33:52 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10561"; a="823495277"
X-IronPort-AV: E=Sophos;i="5.96,246,1665471600"; 
   d="scan'208";a="823495277"
Received: from shellyki-mobl3.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.212.180.133])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2022 17:33:52 -0800
Subject: [PATCH 1/2] cxl/region: Fix memdev_filter_pos() memory leak
From:   Dan Williams <dan.j.williams@intel.com>
To:     vishal.l.verma@intel.com
Cc:     linux-cxl@vger.kernel.org
Date:   Wed, 14 Dec 2022 17:33:52 -0800
Message-ID: <167106803234.1326377.5020851858779774338.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <167106802682.1326377.13483249974201112428.stgit@dwillia2-xfh.jf.intel.com>
References: <167106802682.1326377.13483249974201112428.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Arrange to free the temporary duplicate of @_csv in all exit paths. Just
share a common exit path.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 cxl/region.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cxl/region.c b/cxl/region.c
index 15cac64a158c..2202afa440ef 100644
--- a/cxl/region.c
+++ b/cxl/region.c
@@ -183,7 +183,7 @@ static int memdev_filter_pos(struct json_object *jobj, const char *_csv)
 	for (pos = 0, arg = strtok_r(csv, which_sep(csv), &save); arg;
 	     arg = strtok_r(NULL, which_sep(csv), &save), pos++)
 		if (util_cxl_memdev_filter(memdev, arg, NULL))
-			return pos;
+			break;
 	free(csv);
 
 	return pos;

