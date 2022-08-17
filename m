Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A7C0C32772
	for <linux-cxl@archiver.kernel.org>; Wed, 17 Aug 2022 21:22:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241223AbiHQVWB (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 17 Aug 2022 17:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233446AbiHQVWA (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 17 Aug 2022 17:22:00 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12663A61F8
        for <linux-cxl@vger.kernel.org>; Wed, 17 Aug 2022 14:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660771320; x=1692307320;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6EaW6u8QngBuh6zk7ZxPWQ4L5alvQ/apItGwG+3+9+E=;
  b=BYXdq08ERRVaGG8NpnhKDoMW9MF4c5FvLUlC/wSR0kEu7uuAorH9kYfS
   lGXhGVSMxkDXQ+lYaQOMWAkCD7akrbINqZnbJzrf06OVc6wMqvMftPTeW
   Cfo5OyxqxxOJ1MYVk6ythHBGuEsGkyxp+vJT+oProR6RH2hiWCXyLnX0L
   bNry8nxu+2r32evy/W9rt943f/lpoEiY+6YM9c0pa4YvQIQ5fZZbY2EZl
   b9+zC3OU8o/tXxtHS1MIoGBHiumm+RxOxV8uYqefBzWkqnj/UoTy+MFG2
   d4hlFnxiFV4xdWuv7yidoxrRauiRt1skUnktj9x3A13/zMMCBxf6vLWMy
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10442"; a="291358766"
X-IronPort-AV: E=Sophos;i="5.93,244,1654585200"; 
   d="scan'208";a="291358766"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2022 14:21:54 -0700
X-IronPort-AV: E=Sophos;i="5.93,244,1654585200"; 
   d="scan'208";a="558279063"
Received: from djiang5-desk4.jf.intel.com ([10.165.157.96])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2022 14:21:53 -0700
Subject: [PATCH v4 3/6] tools/testing/cxl: Add interleave check support to
 mock cxl port device
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     dan.j.williams@intel.com, vishal.l.verma@intel.com,
        ira.weiny@intel.com, alison.schofield@intel.com,
        Jonathan.Cameron@huawei.com
Date:   Wed, 17 Aug 2022 14:21:53 -0700
Message-ID: <166077131383.1743055.4589788759198107631.stgit@djiang5-desk4.jf.intel.com>
In-Reply-To: <166077102447.1743055.17158560277276060113.stgit@djiang5-desk4.jf.intel.com>
References: <166077102447.1743055.17158560277276060113.stgit@djiang5-desk4.jf.intel.com>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Attach the cxl mock hdm to the port device to allow cxl_interleave_verify()
to check the interleave configuration. Set the interleave_mask as well
to support the new verification code.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 tools/testing/cxl/test/cxl.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index a072b2d3e726..3ce353a20b80 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -398,6 +398,9 @@ static struct cxl_hdm *mock_cxl_setup_hdm(struct cxl_port *port)
 		return ERR_PTR(-ENOMEM);
 
 	cxlhdm->port = port;
+	cxlhdm->interleave_mask = GENMASK(14, 8);
+	cxlhdm->interleave_cap = CXL_HDM_INTERLEAVE_CAP_DEFAULT;
+	dev_set_drvdata(&port->dev, cxlhdm);
 	return cxlhdm;
 }
 


