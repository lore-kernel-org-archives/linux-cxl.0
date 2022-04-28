Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3160BC433EF
	for <linux-cxl@archiver.kernel.org>; Thu, 28 Apr 2022 22:10:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352791AbiD1WNt (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 28 Apr 2022 18:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352788AbiD1WNs (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 28 Apr 2022 18:13:48 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D800D580EC
        for <linux-cxl@vger.kernel.org>; Thu, 28 Apr 2022 15:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651183832; x=1682719832;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Hrj0oSqW1mU02KYyQv9rVPsdjuM/cGHNMk60O/cQWA4=;
  b=bigoFQL6LsjrK0mIgwoHeiPqlUqBL7YJQWRYgHpZVWZGun09K7hCF+OU
   2p8YjHeaPI+iyMZAEkkVSl74jhFG08b0uEplJyLVYUE0mHcL0BxgW9gR0
   r2Y4B5YFAom2j4zLfhQLYxGmdDHHKlvgvmwIt3ruyJwYSYhhhBhbIpaHx
   asBPbjf60IdxxDS2AT1osVtmmgCoXByj+jaOU0kSksG/zqvtHDQvmTiAK
   jJQnIKMGdrVz8dcmzS7b28i67ULE7d4X4auAaYSR6cohZfU3G/r1ugTF1
   9R7fGKaFJXi+61H7QQluJ/Z7TQh5wVsKr6Pnf7jvayfzVa7gEerp5qny0
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10331"; a="248371617"
X-IronPort-AV: E=Sophos;i="5.91,296,1647327600"; 
   d="scan'208";a="248371617"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2022 15:10:32 -0700
X-IronPort-AV: E=Sophos;i="5.91,296,1647327600"; 
   d="scan'208";a="731735541"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2022 15:10:32 -0700
Subject: [ndctl PATCH 06/10] cxl/list: Auto-enable 'single' mode for port
 listings
From:   Dan Williams <dan.j.williams@intel.com>
To:     vishal.l.verma@intel.com
Cc:     linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev
Date:   Thu, 28 Apr 2022 15:10:32 -0700
Message-ID: <165118383246.1676208.2097194779584921177.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <165118380037.1676208.7644295506592461996.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <165118380037.1676208.7644295506592461996.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

The --single parameter instructs the filter code to gate listing of
ancestor ports. However, that behavior can be inferred by attempts to list
a port without the --ports option, i.e. make:

    cxl list -p $port

...equivalent to:

    cxl list -P -S -p $port

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 cxl/list.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/cxl/list.c b/cxl/list.c
index 1e9d441190a0..940782d33a10 100644
--- a/cxl/list.c
+++ b/cxl/list.c
@@ -104,6 +104,7 @@ int cmd_list(int argc, const char **argv, struct cxl_ctx *ctx)
 			error("please specify entities to list, e.g. using -m/-M\n");
 			usage_with_options(u, options);
 		}
+		param.single = true;
 	}
 
 	log_init(&param.ctx, "cxl list", "CXL_LIST_LOG");

