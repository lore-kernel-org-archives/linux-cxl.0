Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA905C00140
	for <linux-cxl@archiver.kernel.org>; Mon,  8 Aug 2022 21:07:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238401AbiHHVHJ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 8 Aug 2022 17:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231742AbiHHVHI (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 8 Aug 2022 17:07:08 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2395D13D19
        for <linux-cxl@vger.kernel.org>; Mon,  8 Aug 2022 14:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659992828; x=1691528828;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=G3KtEHLTDZ7iieneU7MKz5kvxsY8gnUxjsOBVX2Rf08=;
  b=ia8QdKViC68vldHYSDh58qZm5EKoAWIdVztVYd4Edt5352n5Fg0H2E9X
   x3JeMxVVvdru3sLSCBXK5E1sHvRF8Si68wQYeLbiOmijtSKjPEIm/TGk5
   O6tYobmwFj8a7IHDZZHYczglqRRs3zgtC+K4nB/2a3xU3ifsjUn2898Ba
   T3nL/omramoM+VLSpAWgL2J4uubGNNV6DuXaRlINhYfSSd7qUnBFt0XCd
   sx8vLlOd/98s0Z51xHSsDJgvkShyBfB6Q4nB1IbFnlErwRDZ3avt1buU5
   actKJjBPWdM7nGStijNLQYgt+3J+zfW6/wEYTkcBvHwTCfdHakOgQvwVU
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10433"; a="277626542"
X-IronPort-AV: E=Sophos;i="5.93,222,1654585200"; 
   d="scan'208";a="277626542"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2022 14:07:07 -0700
X-IronPort-AV: E=Sophos;i="5.93,222,1654585200"; 
   d="scan'208";a="637460672"
Received: from djiang5-desk4.jf.intel.com ([10.165.157.96])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2022 14:07:07 -0700
Subject: [PATCH 3/3] tools/testing/cxl: Add interleave check support to mock
 cxl port device
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     dan.j.williams@intel.com, vishal.l.verma@intel.com,
        ira.weiny@intel.com, alison.schofield@intel.com,
        Jonathan.Cameron@huawei.com
Date:   Mon, 08 Aug 2022 14:07:07 -0700
Message-ID: <165999282767.493131.3574006385715039923.stgit@djiang5-desk4.jf.intel.com>
In-Reply-To: <165999244272.493131.1975513183227389633.stgit@djiang5-desk4.jf.intel.com>
References: <165999244272.493131.1975513183227389633.stgit@djiang5-desk4.jf.intel.com>
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

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 tools/testing/cxl/test/cxl.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index a072b2d3e726..5a9f33703ee7 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -398,6 +398,8 @@ static struct cxl_hdm *mock_cxl_setup_hdm(struct cxl_port *port)
 		return ERR_PTR(-ENOMEM);
 
 	cxlhdm->port = port;
+	cxlhdm->interleave_mask = GENMASK(14, 8);
+	dev_set_drvdata(&port->dev, cxlhdm);
 	return cxlhdm;
 }
 


