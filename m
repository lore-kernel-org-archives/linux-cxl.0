Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B00EC636D6
	for <linux-cxl@archiver.kernel.org>; Wed,  8 Feb 2023 20:01:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbjBHUBB (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 8 Feb 2023 15:01:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231697AbjBHUA7 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 8 Feb 2023 15:00:59 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 347111E1F6
        for <linux-cxl@vger.kernel.org>; Wed,  8 Feb 2023 12:00:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675886452; x=1707422452;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=fAX98Edco08kfSF7rWrzM8w/+1K3xvv+FOGwue7EYAU=;
  b=FyqX2A2+Xf0Mb5q/i5q12ZxkUP7+/JvDAdyqEgkOvT1ld9RXk4qQBiPN
   1Jmot4BoPhFdFNL1AwvZoLrQYg/rtWK3VJHLQpJeKZTXGXHIenyuFWr8K
   3sJaV062n0XzZyuO/kzTbykQfsbTCOi0h4XM+iWJ2db3hsOoMVrn5AsOg
   7PkGVukivSp/d4yC9ycB3b/SrLJq25arcDwybZrprAW+LO46md+gc44xm
   UtPxguLZErza0fcZDSupeDIykBigWH0Y7LpCnw+0zuyvTGG7fDkC99ZtK
   HHhskR2b6ofj2inyegJenXuZNzwHHb7PJp+EUIFtKk7/DoLn3ZQ/32IuR
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="329935488"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="329935488"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 12:00:46 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="776174686"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="776174686"
Received: from laarmstr-mobl.amr.corp.intel.com (HELO vverma7-desk1.local) ([10.251.6.109])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 12:00:45 -0800
From:   Vishal Verma <vishal.l.verma@intel.com>
Date:   Wed, 08 Feb 2023 13:00:34 -0700
Subject: [PATCH ndctl v2 6/7] cxl/list: Include regions in the verbose
 listing
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230120-vv-volatile-regions-v2-6-4ea6253000e5@intel.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=678;
 i=vishal.l.verma@intel.com; h=from:subject:message-id;
 bh=D7UqXnSXmnYe3Bfxk/zLNeSNw21I6tydyTN5ZJBJa10=;
 b=owGbwMvMwCXGf25diOft7jLG02pJDMmP/2fKTJ/3QP3My1t17q6vXz245xbas+3BkqkbvOKaZ
 59yurPCs6OUhUGMi0FWTJHl756PjMfktufzBCY4wsxhZQIZwsDFKQAT0Tdg+GenyxWTuPNqTl+2
 ctDVyJnxgSaeZUeuGhrfTzBuzVXOW83IcC7kzA7x6FBXv1SnFL0CvgePKuvERE/Krv+oZPpePn0
 VFwA=
X-Developer-Key: i=vishal.l.verma@intel.com; a=openpgp;
 fpr=F8682BE134C67A12332A2ED07AFA61BEA3B84DFF
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Dan Williams <dan.j.williams@intel.com>

When verbose listing was added, region listing support was not available, so
it got missed. Add it now.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 cxl/list.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/cxl/list.c b/cxl/list.c
index e3ef1fb..4e77aeb 100644
--- a/cxl/list.c
+++ b/cxl/list.c
@@ -126,6 +126,7 @@ int cmd_list(int argc, const char **argv, struct cxl_ctx *ctx)
 		param.endpoints = true;
 		param.decoders = true;
 		param.targets = true;
+		param.regions = true;
 		/*fallthrough*/
 	case 0:
 		break;

-- 
2.39.1

