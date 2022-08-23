Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED814C32793
	for <linux-cxl@archiver.kernel.org>; Tue, 23 Aug 2022 07:21:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240675AbiHWHVV (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 23 Aug 2022 03:21:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240646AbiHWHVU (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 23 Aug 2022 03:21:20 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1625B61D9A
        for <linux-cxl@vger.kernel.org>; Tue, 23 Aug 2022 00:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661239280; x=1692775280;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8rJ8gEEBtVLYGXTt1L5arjJ8aeJKmNlD+4PYtRRCVes=;
  b=YA1GT5aP4qJZkeZOrAmPIh1ttpCvQkyYe3rE7MxX33bHUUWbOmpKQ2M3
   KVtELmTz1VKNzUCvOME0We6vC+C4lDG2lukd/u3rEMub3Qod3R0tsiSAh
   jQiNp39Jk+2CaAmNJN0ejR1bm1MmvemJhyZcZPJlUuvfWsM1KcU8VaLco
   3B3cElfFNQj0Go+OvdO3rLqb12bppDeb0C1vsCpxajWAogGK/jjLdqNjs
   SPF4l8hJIPewzIefvSuTn5geiryGRZI0BNmOi+JlgpEctGbdtON80faxF
   bBgbXYv50Awc5MMPjPfBZrlYmqYPNOcnxDhszVaql8OfPqYshklMD2X5T
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10447"; a="273366246"
X-IronPort-AV: E=Sophos;i="5.93,256,1654585200"; 
   d="scan'208";a="273366246"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 00:21:11 -0700
X-IronPort-AV: E=Sophos;i="5.93,256,1654585200"; 
   d="scan'208";a="735388590"
Received: from skummith-mobl1.amr.corp.intel.com (HELO vverma7-desk1.intel.com) ([10.212.54.206])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 00:21:11 -0700
From:   Vishal Verma <vishal.l.verma@intel.com>
To:     <linux-cxl@vger.kernel.org>
Cc:     <nvdimm@lists.linux.dev>, Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [ndctl PATCH 3/3] cxl/filter: Fix an uninitialized pointer dereference
Date:   Tue, 23 Aug 2022 01:21:06 -0600
Message-Id: <20220823072106.398076-4-vishal.l.verma@intel.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220823072106.398076-1-vishal.l.verma@intel.com>
References: <20220823072106.398076-1-vishal.l.verma@intel.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=837; h=from:subject; bh=8rJ8gEEBtVLYGXTt1L5arjJ8aeJKmNlD+4PYtRRCVes=; b=owGbwMvMwCXGf25diOft7jLG02pJDMks9Y82rpzD9XiPz/5/vlEpvj4ZhrEnntescBLlLH+lvv2L 0NGTHaUsDGJcDLJiiix/93xkPCa3PZ8nMMERZg4rE8gQBi5OAZjIF26G//XTtos/2bts0aWdBZu67K u9vihHn/V2i10ef3njrovLT5cx/A/f9Wu7/eOY2Gv8V9hlvoaa1UXqhR/Srv4bxPg4/KrfeUYA
X-Developer-Key: i=vishal.l.verma@intel.com; a=openpgp; fpr=F8682BE134C67A12332A2ED07AFA61BEA3B84DFF
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Static analysis points out that there was a chance that 'jdecoder' could
be used while uninitialized in walk_decoders(). Initialize it to NULL to
avoid this.

Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 cxl/filter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cxl/filter.c b/cxl/filter.c
index 9a3de8c..56c6599 100644
--- a/cxl/filter.c
+++ b/cxl/filter.c
@@ -796,7 +796,7 @@ static void walk_decoders(struct cxl_port *port, struct cxl_filter_params *p,
 	cxl_decoder_foreach(port, decoder) {
 		const char *devname = cxl_decoder_get_devname(decoder);
 		struct json_object *jchildregions = NULL;
-		struct json_object *jdecoder;
+		struct json_object *jdecoder = NULL;
 
 		if (!p->decoders)
 			goto walk_children;
-- 
2.37.2

