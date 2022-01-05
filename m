Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50663C433EF
	for <linux-cxl@archiver.kernel.org>; Wed,  5 Jan 2022 21:33:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244520AbiAEVdT (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 5 Jan 2022 16:33:19 -0500
Received: from mga12.intel.com ([192.55.52.136]:14713 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244535AbiAEVcG (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Wed, 5 Jan 2022 16:32:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641418326; x=1672954326;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Lqxas7Jp2n48528XZYMSoM/T1vo3G5+Ksw7UW8FLeP8=;
  b=VlrP+/yzNK0jLhw8Y8ZixrvT5vsxkbE/3YiI3fpEvNMBIcxw6q2LXONZ
   REPNyeU452EpvVn1aXmS+gdrvKTTDB1ocsdO1T0YOoXyzuK65JX1omGRp
   HC3dT4Kja7uKzi/7fUMA5nPuC1rW9UMHRrriWKMNMXrEEJrSmeIIBS7Ta
   uei5oETReY6f6Ya9i/sYXhla7wXqmcfYTVyBQgkbLyTtiULqaL5Wb6ufR
   xSFdrd+G551PdZYySoxPNDdeQFi45SZ7Bx6cMVKHAdEjYULeTEy5dVKSN
   BqLG6+jm33u0zus5GF9k86HWjl1lz3NBheF0gG1UyahgLaAHbxOc75xop
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="222535851"
X-IronPort-AV: E=Sophos;i="5.88,264,1635231600"; 
   d="scan'208";a="222535851"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2022 13:32:05 -0800
X-IronPort-AV: E=Sophos;i="5.88,264,1635231600"; 
   d="scan'208";a="574526270"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2022 13:32:05 -0800
Subject: [ndctl PATCH v3 05/16] ndctl/test: Skip BLK flags checks
From:   Dan Williams <dan.j.williams@intel.com>
To:     vishal.l.verma@intel.com
Cc:     nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org
Date:   Wed, 05 Jan 2022 13:32:05 -0800
Message-ID: <164141832529.3990253.16538298357542644310.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <164141829899.3990253.17547886681174580434.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <164141829899.3990253.17547886681174580434.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

With the removal of BLK-mode support, test/libndctl will fail to detect the
JEDEC format on the nfit_test bus. Report + skip that check rather than
fail the test when that happens.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 test/libndctl.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/test/libndctl.c b/test/libndctl.c
index 0d6b9dd5b04b..aa624289c708 100644
--- a/test/libndctl.c
+++ b/test/libndctl.c
@@ -2536,7 +2536,7 @@ static int check_dimms(struct ndctl_bus *bus, struct dimm *dimms, int n,
 				fprintf(stderr, "dimm%d expected formats: %d got: %d\n",
 						i, dimms[i].formats,
 						ndctl_dimm_get_formats(dimm));
-				return -ENXIO;
+				fprintf(stderr, "continuing...\n");
 			}
 			for (j = 0; j < dimms[i].formats; j++) {
 				if (ndctl_dimm_get_formatN(dimm, j) != dimms[i].format[j]) {
@@ -2544,7 +2544,7 @@ static int check_dimms(struct ndctl_bus *bus, struct dimm *dimms, int n,
 						"dimm%d expected format[%d]: %d got: %d\n",
 							i, j, dimms[i].format[j],
 							ndctl_dimm_get_formatN(dimm, j));
-					return -ENXIO;
+					fprintf(stderr, "continuing...\n");
 				}
 			}
 		}

