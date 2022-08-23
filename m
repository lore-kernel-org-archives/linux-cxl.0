Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4361C32774
	for <linux-cxl@archiver.kernel.org>; Tue, 23 Aug 2022 07:21:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240648AbiHWHVV (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 23 Aug 2022 03:21:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240547AbiHWHVU (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 23 Aug 2022 03:21:20 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9642C61D94
        for <linux-cxl@vger.kernel.org>; Tue, 23 Aug 2022 00:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661239279; x=1692775279;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+bAm66mVTsrkUhFwkgCp2pQKGp1jx2WlAystbymshh8=;
  b=iH4R4rx5vM+NT1hB4VaS6xFGcZW7H5zAGJOrak1Qj4qT4jjzQUfNdV+T
   NPZZsHmqX2khvrFFA6b6ry7pKeIkNWNYliFm4fFeiv82zEAEp+Ys2y/Kj
   iCfbVga+dc+dfrr5alBdvDR7vJkXZFeL/BgKWAc1KmWZBafCcVuvYFpww
   DLg9DT33G+XuMIT1JVI+x3l1kZhBCfQMUkFQHyDuSx/eVePd5n67Dv86+
   LuRukJMCqzogG9OfBSD6Hbe3+3H7keN9UeHhcxGKNQyW9uOo3bD4GuXzN
   ygrQ0pWqIt95DQz6IGYvyrQrWslgYUx8SSl5Nv56m0SEGCjxu0HWClCs9
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10447"; a="273366243"
X-IronPort-AV: E=Sophos;i="5.93,256,1654585200"; 
   d="scan'208";a="273366243"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 00:21:10 -0700
X-IronPort-AV: E=Sophos;i="5.93,256,1654585200"; 
   d="scan'208";a="735388581"
Received: from skummith-mobl1.amr.corp.intel.com (HELO vverma7-desk1.intel.com) ([10.212.54.206])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 00:21:10 -0700
From:   Vishal Verma <vishal.l.verma@intel.com>
To:     <linux-cxl@vger.kernel.org>
Cc:     <nvdimm@lists.linux.dev>, Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [ndctl PATCH 0/3] cxl: static analysis fixes
Date:   Tue, 23 Aug 2022 01:21:03 -0600
Message-Id: <20220823072106.398076-1-vishal.l.verma@intel.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=494; h=from:subject; bh=+bAm66mVTsrkUhFwkgCp2pQKGp1jx2WlAystbymshh8=; b=owGbwMvMwCXGf25diOft7jLG02pJDMks9feMbG9M95mg8eJ8ivfWpEWCq/l/hjxYpMj4zZORNdb8 w26ejlIWBjEuBlkxRZa/ez4yHpPbns8TmOAIM4eVCWQIAxenAFxkJyPDscKi7mP1J24U3jzdIRZbZ/ MpWXbm4XOC9T/ExC+tVD/+meG/7/64OX4e/x5+OH8z35f9dLYXl8yZi27XV+Vd3rZm9U19PgA=
X-Developer-Key: i=vishal.l.verma@intel.com; a=openpgp; fpr=F8682BE134C67A12332A2ED07AFA61BEA3B84DFF
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Fix a small handful of issues reported by scan.coverity.com for the
recent region management additions.

Vishal Verma (3):
  cxl/region: fix a dereferecnce after NULL check
  libcxl: fox a resource leak and a forward NULL check
  cxl/filter: Fix an uninitialized pointer dereference

 cxl/lib/libcxl.c | 3 ++-
 cxl/filter.c     | 2 +-
 cxl/region.c     | 2 --
 3 files changed, 3 insertions(+), 4 deletions(-)


base-commit: 9a993ce24fdd5de45774b65211570dd514cdf61d
-- 
2.37.2

