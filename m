Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22C2DC00140
	for <linux-cxl@archiver.kernel.org>; Fri,  5 Aug 2022 06:49:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237539AbiHEGt1 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 5 Aug 2022 02:49:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237415AbiHEGt0 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 5 Aug 2022 02:49:26 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3FE77390A
        for <linux-cxl@vger.kernel.org>; Thu,  4 Aug 2022 23:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659682165; x=1691218165;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=r4Mn3XYQcmhGA68d1fKHIdrfas7rslbsPKdL6+cxRMg=;
  b=MKp/KsU6r3x7VpmPLnQLqtaofyXzFQ5nVqNErMsPhLtIHLKX1HwUDwQJ
   aQ5QGiIjARCn61hPnlyTb/SzcTlujxNXpKQNrZIoF65WRfgTbEKRCn5pl
   fO12uJcS9rbJKF6x+oxUjHT5dkHYoWPUBJSliZfaYHtapSTlxnw8tc90/
   CY8HRrHuD8kaFHzLjmGc8HZt5QUeCoikeKTJCAwynbTdTPhu2gmi6wOuR
   fyCHxBG6HIZ8OsVY32AH7pfbS8Guu+b+8Jdqj9B8xbqU1HHY6tAX5BZQI
   sFTOLIleSyXq+etvpi8Pcly0DmcAC3ketWVbQB/9tkgWuah4CXvR5h/q0
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10429"; a="270517678"
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="270517678"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2022 23:49:25 -0700
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="779655493"
Received: from sogeden-mobl1.amr.corp.intel.com (HELO vverma7-desk1.intel.com) ([10.212.235.254])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2022 23:49:24 -0700
From:   Vishal Verma <vishal.l.verma@intel.com>
To:     <linux-cxl@vger.kernel.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH] cxl/region: reset the cxl endpoint decoder HPA range on teardown
Date:   Fri,  5 Aug 2022 00:49:18 -0600
Message-Id: <20220805064918.925115-1-vishal.l.verma@intel.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2094; h=from:subject; bh=r4Mn3XYQcmhGA68d1fKHIdrfas7rslbsPKdL6+cxRMg=; b=owGbwMvMwCXGf25diOft7jLG02pJDElv9maZin+pD66S2JfFs+Rpk+ss641XXz/b9HdqS83GXQ3i 283nd5SyMIhxMciKKbL83fOR8Zjc9nyewARHmDmsTCBDGLg4BWAil1UZGf6eO3PufJj3nt+n5jMtX8 ixoCZTLNNdRHr7zpmLFZd0K2cw/A+vux24ffnHLY++Fuws4X54k6/4eU5KysVYWW/hD2LX5/EDAA==
X-Developer-Key: i=vishal.l.verma@intel.com; a=openpgp; fpr=F8682BE134C67A12332A2ED07AFA61BEA3B84DFF
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

The endpoint decoder HPA range gets set up during cxl_region_attach, but
cxl_region_detach() neglects to reset it back to a 'free' state. As a
result, a create-destroy-create cycle with the same region parameters
results in the second create-region failing with an EBUSY when trying to
reserver DPA.

  # cxl create-region -d decoder3.2 -m mem4 -g 1024
  cxl region: create_region: decoder11.1: set_dpa_size failed: Device or resource busy
  cxl region: cmd_create_region: created 0 regions

Set the endpoint decoder's hpa_range to [0, -1] to mark it as free in
cxl_region_detach().

Fixes: 292bdc6af8f2 ("cxl/region: Move HPA setup to cxl_region_attach()")
Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 drivers/cxl/core/region.c | 4 ++++
 1 file changed, 4 insertions(+)

Hi Dan,

This is a fixup-to-a-fixup, and the commit in Fixes: is only in
'preview'. Feel free to squash this into the original fix if you so
prefer.

Another question - should we be resetting the endpoint decoder's mode to
CXL_DECODER_DEAD while in here? I notice that a freed decoder still
lists mode:pmem in cxl-list.

---

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index a68e4e0cf169..f0c8966a69c1 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1369,6 +1369,10 @@ static int cxl_region_detach(struct cxl_endpoint_decoder *cxled)
 	}
 	p->targets[cxled->pos] = NULL;
 	p->nr_targets--;
+	cxled->cxld.hpa_range = (struct range) {
+		.start = 0,
+		.end = -1,
+	};
 
 	/* notify the region driver that one of its targets has departed */
 	up_write(&cxl_region_rwsem);

base-commit: 65fc1c3d26b96002a5aa1f4012fae4dc98fd5683
prerequisite-patch-id: 151ffe5b355fcc040b69b651037b239b28ce459d
prerequisite-patch-id: 5c3f0d23262513eb991f7db058736e20b601a897
prerequisite-patch-id: 63825d8f66bf5eda9fe23ab3d995de15a516754c
prerequisite-patch-id: d5ea0349921af5ce2670b4a0f9cc09662e8d6163
prerequisite-patch-id: 6f974183c2c44c4d5b32f2496af7935ec59bc402
-- 
2.37.1

