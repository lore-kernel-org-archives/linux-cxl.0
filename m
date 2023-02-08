Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90C08C636D6
	for <linux-cxl@archiver.kernel.org>; Wed,  8 Feb 2023 20:00:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231549AbjBHUAs (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 8 Feb 2023 15:00:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231330AbjBHUAr (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 8 Feb 2023 15:00:47 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E726139CD1
        for <linux-cxl@vger.kernel.org>; Wed,  8 Feb 2023 12:00:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675886443; x=1707422443;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=KaRzxRlvB9BcP0nu0QZVD/lvIYofxBcR+epWn7ufvY0=;
  b=DDdyLqe0nCpRWGcOUg0isPhZG0fimNd/K7DB0Jyf88ZeztXfrBuwjF+q
   ySzKJ6IaJIW+Z/S8U+WROHZmerCLzuJrhpsGvt6FZIx82YVcTU9IfIb9Y
   yLc1o0aTa3JXVJbPROq4GCVDKokn5eoyCv2C7ehfztufyiI3UcsAB+9Cs
   QP09oYbx7i29CG8EoVXpu0ZOn4JOAJjthA5VSgi661n4DsRy5DNEuqhlM
   VRXjD8k5TG8lmCYjgRSbez0dM79DmS+cSV70anss5vAwnc9bw0dAzACgx
   V4Qx2VxBRcZG+Znh5Ss6zeb+t/a/7HhjKCN4FOvk0v9uCZvVrKSPOkP7c
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="329935452"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="329935452"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 12:00:42 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="776174665"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="776174665"
Received: from laarmstr-mobl.amr.corp.intel.com (HELO vverma7-desk1.local) ([10.251.6.109])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 12:00:42 -0800
From:   Vishal Verma <vishal.l.verma@intel.com>
Date:   Wed, 08 Feb 2023 13:00:29 -0700
Subject: [PATCH ndctl v2 1/7] cxl/region: skip region_actions for region
 creation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230120-vv-volatile-regions-v2-1-4ea6253000e5@intel.com>
References: <20230120-vv-volatile-regions-v2-0-4ea6253000e5@intel.com>
In-Reply-To: <20230120-vv-volatile-regions-v2-0-4ea6253000e5@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Gregory Price <gregory.price@memverge.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        nvdimm@lists.linux.dev, Ira Weiny <ira.weiny@intel.com>
X-Mailer: b4 0.13-dev-ada30
X-Developer-Signature: v=1; a=openpgp-sha256; l=1701;
 i=vishal.l.verma@intel.com; h=from:subject:message-id;
 bh=KaRzxRlvB9BcP0nu0QZVD/lvIYofxBcR+epWn7ufvY0=;
 b=owGbwMvMwCXGf25diOft7jLG02pJDMmP/2cuedrLONf39nU/2YL5sonFfCbeCpF3/KT3at06p
 Sn4NSS4o5SFQYyLQVZMkeXvno+Mx+S25/MEJjjCzGFlAhnCwMUpABMpFGL4pyWlv2i3kMLrrD7P
 4pjEiafu7Uk2v2F2ePscu7n97/nmTmdk+Pdd2UVPRk3J+5nENMcDOZM8dx5s6vDg/mmUZjhz1pN
 vHAA=
X-Developer-Key: i=vishal.l.verma@intel.com; a=openpgp;
 fpr=F8682BE134C67A12332A2ED07AFA61BEA3B84DFF
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Commit 3d6cd829ec08 ("cxl/region: Use cxl_filter_walk() to gather create-region targets")
removed the early return for create-region, and this caused a
create-region operation to unnecessarily loop through buses and root
decoders only to EINVAL out because ACTION_CREATE is handled outside of
the other actions. This results in confusing messages such as:

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
back to returning early for create-region.

Fixes: 3d6cd829ec08 ("cxl/region: Use cxl_filter_walk() to gather create-region targets")
Cc: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
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

