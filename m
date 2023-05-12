Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5217FC77B75
	for <linux-cxl@archiver.kernel.org>; Fri, 12 May 2023 21:31:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238676AbjELVbw (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 12 May 2023 17:31:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbjELVbv (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 12 May 2023 17:31:51 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6655535A0
        for <linux-cxl@vger.kernel.org>; Fri, 12 May 2023 14:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683927108; x=1715463108;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=aTBip5HJFDAsCeQBxXbvBdHG4p4+I085fK0TlB9Ar94=;
  b=Zkoaox4yvI0+Xbz8sCdnEmggQ0VcziDbjwKDrEXttJlL8NZaChzpD9zw
   Dki0cM4lMLdmqAGQfpxmyAnYkg4AVsqpGIiGMiqTiKl6OI5hPjOyF36eU
   wABwCJt4Tp/oBPgmjALdpYdvs9X+d/JCo62ZRe0+y/44J1c8H7qH5iWR8
   8Fd5E4Xn0N3KBHTXO98BvJqrOjfCReZ4vyfaOhSB0G/Y6N2w4BHo6RA2h
   GZpMqM2VrQXoqejA/tzvLlsi1henEMUt39ntvatmdEi/GZqEtkSkGvbYj
   WVNk8hzGTkHctwaNHu6NlDj7TLIogmnjTfHXLuke2trZSjYPOkk4OE538
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="416528303"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="416528303"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2023 14:31:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="946763601"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="946763601"
Received: from mlswanso-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.252.139.105])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2023 14:31:35 -0700
Subject: [PATCH] tools/testing/cxl: Use DEFINE_STATIC_SRCU()
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     vishal.l.verma@intel.com, dave.jiang@intel.com,
        ira.weiny@intel.com, alison.schofield@intel.com
Date:   Fri, 12 May 2023 14:31:35 -0700
Message-ID: <168392709546.1135523.10424917245934547117.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Starting with commit:

95433f726301 ("srcu: Begin offloading srcu_struct fields to srcu_update")

...it is no longer possible to do:

static DEFINE_SRCU(x)

Switch to DEFINE_STATIC_SRCU(x) to fix:

tools/testing/cxl/test/mock.c:22:1: error: duplicate ‘static’
   22 | static DEFINE_SRCU(cxl_mock_srcu);
      | ^~~~~~

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 tools/testing/cxl/test/mock.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/cxl/test/mock.c b/tools/testing/cxl/test/mock.c
index c4e53f22e421..de3933a776fd 100644
--- a/tools/testing/cxl/test/mock.c
+++ b/tools/testing/cxl/test/mock.c
@@ -19,7 +19,7 @@ void register_cxl_mock_ops(struct cxl_mock_ops *ops)
 }
 EXPORT_SYMBOL_GPL(register_cxl_mock_ops);
 
-static DEFINE_SRCU(cxl_mock_srcu);
+DEFINE_STATIC_SRCU(cxl_mock_srcu);
 
 void unregister_cxl_mock_ops(struct cxl_mock_ops *ops)
 {

