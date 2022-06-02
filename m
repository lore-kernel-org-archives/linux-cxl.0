Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E079C43334
	for <linux-cxl@archiver.kernel.org>; Thu,  2 Jun 2022 15:44:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236547AbiFBPoh (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 2 Jun 2022 11:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236555AbiFBPog (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 2 Jun 2022 11:44:36 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2642C2A80C0
        for <linux-cxl@vger.kernel.org>; Thu,  2 Jun 2022 08:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654184675; x=1685720675;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nAhEz1djCOAWhxdW97lUdRn+XYH7LvOIlcq3JtiHRDc=;
  b=Q+Gq17zch0nUkX/FVkP0PgOV7bumt054EtLTLduBx6hoLJSPGPR5fAq0
   wuhNyDlHNO2jtGLVMC2SO+8oIXol/o5uNBJjhFzpYzE/Bu7qn5smH/bDJ
   iiDrZEHPUcRIehi8bYFbEcMTyN6Crm3hojgne1iHbJ/7sq4gfJvGqPAq+
   2D0cxS2jlNAoFwi8ZXTdtyUVOPf/slwJAwn4mzFRY7MIsaxLFN9wk+Z0s
   yAzV4uu/gEaOLAuQWG7A7HpNA1ieFa6wtQVRIEWypcFNamKx/7QAd8cPb
   +fQEedRWVNta+5Uws41x1MeqCEcYXqtzRiyMRkvef9LbaYv8JwLJ+v5x3
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10366"; a="258058706"
X-IronPort-AV: E=Sophos;i="5.91,271,1647327600"; 
   d="scan'208";a="258058706"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2022 08:44:32 -0700
X-IronPort-AV: E=Sophos;i="5.91,271,1647327600"; 
   d="scan'208";a="757042153"
Received: from sebanner-mobl.amr.corp.intel.com (HELO vverma7-desk1.intel.com) ([10.212.99.17])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2022 08:44:30 -0700
From:   Vishal Verma <vishal.l.verma@intel.com>
To:     <linux-cxl@vger.kernel.org>
Cc:     <nvdimm@lists.linux.dev>, Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Steven Garcia <steven.garcia@intel.com>
Subject: [ndctl PATCH] libcxl: fix a segfault when memdev->pmem is absent
Date:   Thu,  2 Jun 2022 09:44:27 -0600
Message-Id: <20220602154427.462852-1-vishal.l.verma@intel.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1136; h=from:subject; bh=nAhEz1djCOAWhxdW97lUdRn+XYH7LvOIlcq3JtiHRDc=; b=owGbwMvMwCXGf25diOft7jLG02pJDEkzbt0OZkn3i2N8fc0ygeXxligvBlmvNVqtZ/i0Y8wEzS6+ DjnZUcrCIMbFICumyPJ3z0fGY3Lb83kCExxh5rAygQxh4OIUgIl8PcrwP4Xxo2ivtqs9Z7INb//MA6 snW16dlVsVceLsZFfOiDWikgz/k/Z+O6h7yPXoiWl5Z2udz9uszDXSKz/yW4bTfqHsUdNJDAA=
X-Developer-Key: i=vishal.l.verma@intel.com; a=openpgp; fpr=F8682BE134C67A12332A2ED07AFA61BEA3B84DFF
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

A CXL memdev may not have any persistent capacity, and in this case it
is possible that a 'pmem' object never gets instantiated. Such a
scenario would cause free_pmem () to dereference a NULL pointer and
segfault.

Fix this by only proceeding in free_pmem() if 'pmem' was valid.

Fixes: cd1aed6cefe8 ("libcxl: add representation for an nvdimm bridge object")
Reported-by: Steven Garcia <steven.garcia@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 cxl/lib/libcxl.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/cxl/lib/libcxl.c b/cxl/lib/libcxl.c
index 1ad4a0b..2578a43 100644
--- a/cxl/lib/libcxl.c
+++ b/cxl/lib/libcxl.c
@@ -50,9 +50,11 @@ struct cxl_ctx {
 
 static void free_pmem(struct cxl_pmem *pmem)
 {
-	free(pmem->dev_buf);
-	free(pmem->dev_path);
-	free(pmem);
+	if (pmem) {
+		free(pmem->dev_buf);
+		free(pmem->dev_path);
+		free(pmem);
+	}
 }
 
 static void free_memdev(struct cxl_memdev *memdev, struct list_head *head)

base-commit: 4229f2694e8887a47c636a54130cff0d65f2e995
-- 
2.36.1

