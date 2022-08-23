Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C738C3F6B0
	for <linux-cxl@archiver.kernel.org>; Tue, 23 Aug 2022 07:45:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241066AbiHWHpj (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 23 Aug 2022 03:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241208AbiHWHpf (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 23 Aug 2022 03:45:35 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EA116069C
        for <linux-cxl@vger.kernel.org>; Tue, 23 Aug 2022 00:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661240735; x=1692776735;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8rJ8gEEBtVLYGXTt1L5arjJ8aeJKmNlD+4PYtRRCVes=;
  b=I9hT4zIgRBMFiT5iqJAYXsHYuS+E7xVe4U6m2RT8rIribp+CXhZym0NS
   vGHhRz9FsYrehl6MDLISfc/M0tJoo0x5e9kxHJtY8RYgwacVHVvb0fZxO
   0QZ2CjEQv6pfEsPtYBvB4IsuhpQWctBvTuq7WlfrAONRWMyc2sgrbm1UG
   tu9JEE3GsuJLKSIh1xoyyb+xDcbmwfpXKnXFw4fSA2LqTJvYixKm+2vJo
   q+PaaHKqhQzFHiMzyxZ+S3fS37OlJcu/0vWD3xVVbVvHPvi54FNmwkCj5
   s44tArhgYYt052HhOBfdU3Fyj/gc8cFYoNA9Fr5JMYepXoRHy8UkYQx81
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10447"; a="280590978"
X-IronPort-AV: E=Sophos;i="5.93,256,1654585200"; 
   d="scan'208";a="280590978"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 00:45:32 -0700
X-IronPort-AV: E=Sophos;i="5.93,256,1654585200"; 
   d="scan'208";a="609254291"
Received: from skummith-mobl1.amr.corp.intel.com (HELO vverma7-desk1.intel.com) ([10.212.54.206])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 00:45:32 -0700
From:   Vishal Verma <vishal.l.verma@intel.com>
To:     <linux-cxl@vger.kernel.org>
Cc:     <nvdimm@lists.linux.dev>, Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [ndctl PATCH v2 3/3] cxl/filter: Fix an uninitialized pointer dereference
Date:   Tue, 23 Aug 2022 01:45:27 -0600
Message-Id: <20220823074527.404435-4-vishal.l.verma@intel.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220823074527.404435-1-vishal.l.verma@intel.com>
References: <20220823074527.404435-1-vishal.l.verma@intel.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=837; h=from:subject; bh=8rJ8gEEBtVLYGXTt1L5arjJ8aeJKmNlD+4PYtRRCVes=; b=owGbwMvMwCXGf25diOft7jLG02pJDMksrdM3rpzD9XiPz/5/vlEpvj4ZhrEnntescBLlLH+lvv2L 0NGTHaUsDGJcDLJiiix/93xkPCa3PZ8nMMERZg4rE8gQBi5OAZiIyiOG/wX/NYz45jFHbWr5+WSb+n OdS7/OXvjpeWjSLc3QKTH7Za4x/JXbVLHZoVGZ7/kyYz+B535NvI8U37H1mP8scRNc++L1CyYA
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

