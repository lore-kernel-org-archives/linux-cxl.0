Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA44DC00140
	for <linux-cxl@archiver.kernel.org>; Fri,  5 Aug 2022 20:38:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237373AbiHEUiR (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 5 Aug 2022 16:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236727AbiHEUiQ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 5 Aug 2022 16:38:16 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7483BDFA
        for <linux-cxl@vger.kernel.org>; Fri,  5 Aug 2022 13:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659731895; x=1691267895;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=t76M7t2D8U6dlCpT4ZvetiRjYf7EaWTDXcspZhiMvaw=;
  b=LCiOgCzG3ujJ3TapcTIaUlWUuoXtmTOYPlON6GrLgrKdwHo9gyYMij9U
   hCRs5xyvChjemasEY+/iGAmaVlfoiBF3lcLs0h0X2bSFtwZf2iWhV5rSH
   HG4TRHBX6TotNLctR4iNEkm3ABHCSyBFHXcVQBs7XSKGd3ZszUrcvtJHH
   zrGGXsnC99A8xVZgTZpbFQl/RviipyoDVVl1CWgWdruaAoqV3n0xlZk7H
   LkjOAgW3Vcy2E98XjH8d/au8c54DAP1/gAQLC+BWXgXj112ZO3hjr/Wpx
   rjecTZCpQwieg62CpOBg4u8+4vXvzut8Ouu48wRvutFUjLInVB37hkScC
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10430"; a="291059544"
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="291059544"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2022 13:38:15 -0700
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="554233184"
Received: from jivaldiv-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.255.228.201])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2022 13:38:14 -0700
Subject: [ndctl PATCH 4/6] cxl/list: Filter decoders by region
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     vishal.l.verma@intel.com, dave.jiang@intel.com,
        ira.weiny@intel.com, alison.schofield@intel.com
Date:   Fri, 05 Aug 2022 13:38:14 -0700
Message-ID: <165973189465.1528532.9072953032089147905.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <165973187080.1528532.8097010788284626448.stgit@dwillia2-xfh.jf.intel.com>
References: <165973187080.1528532.8097010788284626448.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

With a region name in hand, it is useful to be able to filter all the
decoders in the topology that are mapping that region.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 cxl/filter.c |   23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/cxl/filter.c b/cxl/filter.c
index 38ece5528794..9a3de8c75387 100644
--- a/cxl/filter.c
+++ b/cxl/filter.c
@@ -652,6 +652,26 @@ struct cxl_region *util_cxl_region_filter(struct cxl_region *region,
 
 }
 
+static struct cxl_decoder *
+util_cxl_decoder_filter_by_region(struct cxl_decoder *decoder,
+				  const char *__ident)
+{
+	struct cxl_region *region;
+
+	if (!__ident)
+		return decoder;
+
+	region = cxl_decoder_get_region(decoder);
+	if (!region)
+		return NULL;
+
+	region = util_cxl_region_filter(region, __ident);
+	if (!region)
+		return NULL;
+
+	return decoder;
+}
+
 static unsigned long params_to_flags(struct cxl_filter_params *param)
 {
 	unsigned long flags = 0;
@@ -790,6 +810,9 @@ static void walk_decoders(struct cxl_port *port, struct cxl_filter_params *p,
 		if (!util_cxl_decoder_filter_by_memdev(
 			    decoder, p->memdev_filter, p->serial_filter))
 			goto walk_children;
+		if (!util_cxl_decoder_filter_by_region(decoder,
+						       p->region_filter))
+			goto walk_children;
 		if (!p->idle && cxl_decoder_get_size(decoder) == 0)
 			continue;
 		jdecoder = util_cxl_decoder_to_json(decoder, flags);

