Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50F3AC4332F
	for <linux-cxl@archiver.kernel.org>; Thu, 15 Dec 2022 01:33:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbiLOBdu (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 14 Dec 2022 20:33:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiLOBdt (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 14 Dec 2022 20:33:49 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B30071573D
        for <linux-cxl@vger.kernel.org>; Wed, 14 Dec 2022 17:33:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671068028; x=1702604028;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VzZaGqgyGGF1L60VKrV6sz+nW6xqfX99wh7T8eIOBPg=;
  b=JSR0/9lSxHffWeA/jJI0ssoPsB2DfByEMq/0GuNt1WwM1mUu5QxpAziB
   Xw1BI+rMhTkReXPlvNHDLj2TWTiajHgFJASz6bXtxLGwQoGBYZc3uYAC1
   V7Gt7268yCJxo2s/q+jLS+I3dapnN63CVEkkbxH9TjvOtnhgzo+sipIbX
   3ZCimcg9tbN+xmNidZyY6cIG2TUAMExZ/HFOdTROoadul8cM7XGFT2+WK
   q5q/XnOalq409iflHtMkt5dy3dfTu/XY7DqCxkJ+oKSnbuvB3KTk32GAZ
   wANmPp/Sx/sH9MIx0wdU4fxz11vpw+YEHxdwhM2byxvxd1G2Vw6dbqEGv
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10561"; a="345642624"
X-IronPort-AV: E=Sophos;i="5.96,246,1665471600"; 
   d="scan'208";a="345642624"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2022 17:33:48 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10561"; a="823495177"
X-IronPort-AV: E=Sophos;i="5.96,246,1665471600"; 
   d="scan'208";a="823495177"
Received: from shellyki-mobl3.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.212.180.133])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2022 17:33:47 -0800
Subject: [PATCH 0/2] cxl/region: Fix a couple memory safety bugs
From:   Dan Williams <dan.j.williams@intel.com>
To:     vishal.l.verma@intel.com
Cc:     Luis Chamberlain <mcgrof@kernel.org>, linux-cxl@vger.kernel.org
Date:   Wed, 14 Dec 2022 17:33:46 -0800
Message-ID: <167106802682.1326377.13483249974201112428.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

memdev_filter_pos() has 2 issues surfaced by unit testing, a leak, and
incorrect sort results.

---

Dan Williams (2):
      cxl/region: Fix memdev_filter_pos() memory leak
      cxl/region: Fix memdev_filter_pos() separator detection


 cxl/region.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)
