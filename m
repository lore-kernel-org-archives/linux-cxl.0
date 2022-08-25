Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 943F7ECAA24
	for <linux-cxl@archiver.kernel.org>; Thu, 25 Aug 2022 16:09:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236857AbiHYQJS (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 25 Aug 2022 12:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242959AbiHYQJP (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 25 Aug 2022 12:09:15 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B518B943D
        for <linux-cxl@vger.kernel.org>; Thu, 25 Aug 2022 09:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661443755; x=1692979755;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iojtyF3+UVw9VQBCGoZrJ+6EfM3nRg8+vvuPRr7Cafk=;
  b=KD5pjAyywxc4R534S19jtTJ34AnlecevR+euxB4/0amWTRYU/5olIiEV
   +rvM7d7vVugMixLw+/bUh+oSo59LbOMv64zLCN14BTctRUkHBNprUmwf2
   8QbfVtLut+ffcGpqGpQCQNTgiMjfAcAXjk9tiZ+aDTIcTZFSm5isSTLVL
   bjeAOSlQZMY3QOR7mG/WjZM4KR2Efrw8u6rCNiAzOgEUY5bOKDPpMm5E+
   KYur24MTUrbO1EyMX7HEBn9K9TNTy40+4TVdy50VYvrHCOCjgLlSbF2Gq
   jMIlM19u+AIGTf5TCNS2BxuLY0Jb29u0R4w0BwxBB+8sfL3bUVZbNGvpo
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10450"; a="274034821"
X-IronPort-AV: E=Sophos;i="5.93,263,1654585200"; 
   d="scan'208";a="274034821"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2022 09:07:53 -0700
X-IronPort-AV: E=Sophos;i="5.93,263,1654585200"; 
   d="scan'208";a="639661045"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2022 09:07:52 -0700
Subject: [PATCH v5 3/6] tools/testing/cxl: Add interleave check support to
 mock cxl port device
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     dan.j.williams@intel.com, vishal.l.verma@intel.com,
        ira.weiny@intel.com, alison.schofield@intel.com,
        Jonathan.Cameron@huawei.com
Date:   Thu, 25 Aug 2022 09:07:51 -0700
Message-ID: <166144367188.745916.2815396662040037518.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <166144343809.745916.16054560464363829844.stgit@djiang5-desk3.ch.intel.com>
References: <166144343809.745916.16054560464363829844.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Attach the cxl mock hdm to the port device to allow cxl_interleave_capable()
to check the interleave configuration. Set the interleave_mask as well
to support the new verification code.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 tools/testing/cxl/test/cxl.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index 4b361ed63333..85000d1b5812 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -398,6 +398,8 @@ static struct cxl_hdm *mock_cxl_setup_hdm(struct cxl_port *port)
 		return ERR_PTR(-ENOMEM);
 
 	cxlhdm->port = port;
+	cxlhdm->interleave_mask = GENMASK(14, 8);
+	cxlhdm->interleave_cap = CXL_HDM_INTERLEAVE_CAP_BASELINE;
 	dev_set_drvdata(&port->dev, cxlhdm);
 	return cxlhdm;
 }


