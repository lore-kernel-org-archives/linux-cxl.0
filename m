Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC6BC433EF
	for <linux-cxl@archiver.kernel.org>; Sat, 23 Jul 2022 00:58:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbiGWA6E (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 22 Jul 2022 20:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236535AbiGWA5x (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 22 Jul 2022 20:57:53 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 037C0CB746
        for <linux-cxl@vger.kernel.org>; Fri, 22 Jul 2022 17:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658537778; x=1690073778;
  h=subject:from:to:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=ARrGLjwMqGTLAr/rNLHIODZ7DQB5maIT/SP8gAnvGbE=;
  b=fJVymGYp9DQKFu/aviyNQb8mpjtRHche3QNQ38Lcl2DY7V0DJwHQEWqi
   PTnGEHIidSL9RvxVAizpwY/i+JgDd+gxX9cEui0aahDQmIjRGYTT7otQZ
   885U9okYTCwOjPRYqeqBVZttu6ZElKHfJjxuxBrRoIc86sChzUPd//1UA
   GilXzcWtNI2WOVRBWhDd4Nw4EK5XErwIoS4JcM9mdnhckuIVkJImgg24b
   bRLlWtJzQGW/OOoRgJC1EzrZK6tEwhfgefjrCsYY8SlEjcHO/RD/Yzo4o
   0IjHZ5eNMVsgzDtmDmNfyg55260uFza5mYejDWUJl6AdT2rPhjR22kL1L
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10416"; a="286193762"
X-IronPort-AV: E=Sophos;i="5.93,186,1654585200"; 
   d="scan'208";a="286193762"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2022 17:56:04 -0700
X-IronPort-AV: E=Sophos;i="5.93,186,1654585200"; 
   d="scan'208";a="741231914"
Received: from jeescalx-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.116.64])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2022 17:56:03 -0700
Subject: [PATCH 2/5] cxl/region: Delete 'region' attribute from root decoders
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Date:   Fri, 22 Jul 2022 17:56:03 -0700
Message-ID: <165853776328.2430596.4647259305040072751.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <165853775181.2430596.3054032756974329979.stgit@dwillia2-xfh.jf.intel.com>
References: <165853775181.2430596.3054032756974329979.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

For switch and endpoint decoders the relationship of decoders to regions
is 1:1. However, for root decoders the relationship is 1:N. Also,
regions are already children of root decoders, so the 1:N relationship
is observed by walking the following glob:

    /sys/bus/cxl/devices/$decoder/region*

Hide the vestigial 'region' attribute for root decoders.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/port.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 3d2d0119cc3d..bffde862de0b 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -290,7 +290,6 @@ static struct attribute *cxl_decoder_base_attrs[] = {
 	&dev_attr_locked.attr,
 	&dev_attr_interleave_granularity.attr,
 	&dev_attr_interleave_ways.attr,
-	SET_CXL_REGION_ATTR(region)
 	NULL,
 };
 
@@ -345,6 +344,7 @@ static const struct attribute_group *cxl_decoder_root_attribute_groups[] = {
 static struct attribute *cxl_decoder_switch_attrs[] = {
 	&dev_attr_target_type.attr,
 	&dev_attr_target_list.attr,
+	SET_CXL_REGION_ATTR(region)
 	NULL,
 };
 
@@ -364,6 +364,7 @@ static struct attribute *cxl_decoder_endpoint_attrs[] = {
 	&dev_attr_mode.attr,
 	&dev_attr_dpa_size.attr,
 	&dev_attr_dpa_resource.attr,
+	SET_CXL_REGION_ATTR(region)
 	NULL,
 };
 

