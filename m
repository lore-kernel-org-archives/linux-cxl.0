Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82509C6379F
	for <linux-cxl@archiver.kernel.org>; Tue,  7 Feb 2023 19:16:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231280AbjBGTQ5 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 7 Feb 2023 14:16:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjBGTQ5 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 7 Feb 2023 14:16:57 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C1618A9B
        for <linux-cxl@vger.kernel.org>; Tue,  7 Feb 2023 11:16:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675797415; x=1707333415;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=XiqSgrEeiTGZTsz88Eua46t0Quv54okbY2837bnGN40=;
  b=WlO1hqUUn20sWXdRu5NK/4ROCRqvBvxDekQB2X4C5MKJ2+p8tWb+m/5a
   g25Tj8SFQSBLCee1abRsQK958p8LqGy+AB8f14k2zTNebmEZtPe9cLbd6
   ZC3cgNvjDn2nnAXlc6GsSnDadK6Myx0lF3tyQZVtFon6upe/NGE1C883B
   PamgI191B9UBNCKBtb+bnVeKMInSw91kgrnWGaDBjYo+GcFfEothLFZxv
   uDnKB3FVNWQa9omslSDmdv/7WlqMVWS+uXt2jC/qQzFzv+/vzUJYXkMqS
   L9kMCxpyaZTIWFaxmYad9KSj01dollcGMAra2Iri9fdGCVx0F9kR8ccsH
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="331733982"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; 
   d="scan'208";a="331733982"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2023 11:16:53 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="735649805"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; 
   d="scan'208";a="735649805"
Received: from fvanegas-mobl.amr.corp.intel.com (HELO vverma7-desk1.local) ([10.209.109.6])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2023 11:16:53 -0800
From:   Vishal Verma <vishal.l.verma@intel.com>
Date:   Tue, 07 Feb 2023 12:16:27 -0700
Subject: [PATCH ndctl 1/7] cxl/region: skip region_actions for region
 creation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230120-vv-volatile-regions-v1-1-b42b21ee8d0b@intel.com>
References: <20230120-vv-volatile-regions-v1-0-b42b21ee8d0b@intel.com>
In-Reply-To: <20230120-vv-volatile-regions-v1-0-b42b21ee8d0b@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Gregory Price <gregory.price@memverge.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>, nvdimm@lists.linux.dev
X-Mailer: b4 0.13-dev-ada30
X-Developer-Signature: v=1; a=openpgp-sha256; l=1601;
 i=vishal.l.verma@intel.com; h=from:subject:message-id;
 bh=XiqSgrEeiTGZTsz88Eua46t0Quv54okbY2837bnGN40=;
 b=owGbwMvMwCXGf25diOft7jLG02pJDMmPFi/2CVmykn2Tse2mVyInL8ZrORy8funVaduHW+fWv
 17g2/VOo6OUhUGMi0FWTJHl756PjMfktufzBCY4wsxhZQIZwsDFKQATiTvB8E+/m43Txpi1gP2Q
 8K/EP7ofrm275/dnvvPxH5O7Micq/TvJ8E83Rf+Jmamv7fL1ltWihYnHqgSfCfZ2r7aVbjVZ9LO
 /iQkA
X-Developer-Key: i=vishal.l.verma@intel.com; a=openpgp;
 fpr=F8682BE134C67A12332A2ED07AFA61BEA3B84DFF
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Commit 3d6cd829ec08 ("cxl/region: Use cxl_filter_walk() to gather create-region targets")
removed the early return for create-region, and this caused a
create-region operation to unnecessarily loop through buses and root
decoders only to EINVAL out because ACTION_CREATE is handled outside of
the other actions. This results in confising messages such as:

  # cxl create-region -t ram -d 0.0 -m 0,4
  {
    "region":"region7",
    "resource":"0xf030000000",
    "size":"512.00 MiB (536.87 MB)",
    ...
  }
  cxl region: decoder_region_action: region0: failed: Invalid argument
  cxl region: region_action: one or more failures, last failure: Invalid argument
  cxl region: cmd_create_region: created 1 region

Since there's no need to walk through the topology after creating a
region, and especially not to perform an invalid 'action', switch
back to retuening early for create-region.

Fixes: 3d6cd829ec08 ("cxl/region: Use cxl_filter_walk() to gather create-region targets")
Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 cxl/region.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cxl/region.c b/cxl/region.c
index efe05aa..38aa142 100644
--- a/cxl/region.c
+++ b/cxl/region.c
@@ -789,7 +789,7 @@ static int region_action(int argc, const char **argv, struct cxl_ctx *ctx,
 		return rc;
 
 	if (action == ACTION_CREATE)
-		rc = create_region(ctx, count, p);
+		return create_region(ctx, count, p);
 
 	cxl_bus_foreach(ctx, bus) {
 		struct cxl_decoder *decoder;

-- 
2.39.1

