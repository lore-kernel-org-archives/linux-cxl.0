Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D479C25B06
	for <linux-cxl@archiver.kernel.org>; Thu, 11 Aug 2022 23:57:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235980AbiHKX5H (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 11 Aug 2022 19:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234910AbiHKX5G (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 11 Aug 2022 19:57:06 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A0479E2D9
        for <linux-cxl@vger.kernel.org>; Thu, 11 Aug 2022 16:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660262226; x=1691798226;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sckOKfrLsCaMpezkbRORhs3sScWR3PH/m3WaHEilYCs=;
  b=ZZNLDfP3KoAyJD84751FhmnHc6zETzN06pkzGe0Hv557So7XTNkERWzj
   koV2JX9hQuBAAoykhxXUObMRGFiruRLh8CSYCC8KYUbzVx0JnG59oUGrJ
   eKBneZ8lJbYMQE75lELREnfqfdYjfnXpA+zVOVMya3K7FzJlkfgcjQyfo
   YaMSEWUfcP/JjTVZ4svW2gKFsy+lzQj1tjp9WnMiYLQSpoSmNfYMqFwnI
   NKa3ft3oxc+bMz3wnf9rDIdk7sjVOK4l4IC/58VpvjPIVdcBgnG4mM0Fy
   NciKAUQfT1ShheN9kviLa8uCJBvbOuKImaVAq+jJh21b5IUtSZ+UdtcYC
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10436"; a="271260955"
X-IronPort-AV: E=Sophos;i="5.93,231,1654585200"; 
   d="scan'208";a="271260955"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2022 16:57:05 -0700
X-IronPort-AV: E=Sophos;i="5.93,231,1654585200"; 
   d="scan'208";a="638714328"
Received: from djiang5-desk4.jf.intel.com ([10.165.157.96])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2022 16:57:05 -0700
Subject: [PATCH v2 3/3] tools/testing/cxl: Add interleave check support to
 mock cxl port device
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     dan.j.williams@intel.com, vishal.l.verma@intel.com,
        ira.weiny@intel.com, alison.schofield@intel.com,
        Jonathan.Cameron@huawei.com
Date:   Thu, 11 Aug 2022 16:57:05 -0700
Message-ID: <166026222564.1454405.200833694547817544.stgit@djiang5-desk4.jf.intel.com>
In-Reply-To: <166026184968.1454405.494690416353090765.stgit@djiang5-desk4.jf.intel.com>
References: <166026184968.1454405.494690416353090765.stgit@djiang5-desk4.jf.intel.com>
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
 


