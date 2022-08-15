Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D22AC00140
	for <linux-cxl@archiver.kernel.org>; Mon, 15 Aug 2022 18:11:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231430AbiHOSLr (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 15 Aug 2022 14:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230452AbiHOSLp (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 15 Aug 2022 14:11:45 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 639DD20BE8
        for <linux-cxl@vger.kernel.org>; Mon, 15 Aug 2022 11:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660587104; x=1692123104;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=mSWri90QO7ga3Wbj6QCyV9It2jBSgr76DPP1Ty8qjds=;
  b=RTG8uq2djccqg92avOQz3HUYg1kewKb550NoY8/++ZfeaNF0X6/hLGRO
   GPUI44cMgfdsHrSZoO8p5oYglBUfmsHobs96FvfWMFQK5rCNBrzc1RaYG
   T3Tp7BzwUcY+yMuzAyxQijxzI7AdCeCyB74e1OhXbTNogOlD/bbLD/QFb
   yauQWqZYN+d/9Yruma9L0enTqj/+9aKXHdP5Vk7r+OOfJVO6FqnYeDZvU
   //4vvnL3mBEp2ykpmDCHrcJgZ5N0pMZcbFqGeM15sxEu1msefaejWmtsL
   rAdsIKDw8MzG75Jb/ASampxCgKXqJ4lIolxdArItn03tuClAWmSCvO8uS
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10440"; a="292025720"
X-IronPort-AV: E=Sophos;i="5.93,238,1654585200"; 
   d="scan'208";a="292025720"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2022 11:11:43 -0700
X-IronPort-AV: E=Sophos;i="5.93,238,1654585200"; 
   d="scan'208";a="666753673"
Received: from djiang5-desk4.jf.intel.com ([10.165.157.96])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2022 11:11:43 -0700
Subject: [PATCH v3 0/3] Add sanity check for interleave setup
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     dan.j.williams@intel.com, vishal.l.verma@intel.com,
        ira.weiny@intel.com, alison.schofield@intel.com,
        Jonathan.Cameron@huawei.com
Date:   Mon, 15 Aug 2022 11:11:43 -0700
Message-ID: <166058698949.1520730.1888371264289688061.stgit@djiang5-desk4.jf.intel.com>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

The small series adds sanity check for the combination of interleave ways
and interleave granularity during region and port configuration. The
calculation references CXL spec 3.0 8.2.4.19.13 implementation note #3. The
checks also added HDM CAP retrieval for the support of new interleave ways
where 3, 6, and 12 ways support as well as 16 ways support.

v3:
- Move cxl_interleave_capable() to core/region.c. (Dan)
- Open code verify of interleave ways against cap mask. (Dan)

v2:
- Change cxl_interleave_verify() to cxl_interleave_capable(). (Dan)
- Move error output inside verify function. (Dan)
- Remove unneeded enums. (Dan)
- Use is_power_of_2() to detect encoded interleave ways. (Dan)
- Change iw to eiw and ig to eig for encoded values. (Alison)
- Change interleave capabilities to mask for easier comparison. (Dan)
- Change valid_interleave() to valid_interleave_ways()
- Add setting fo interleave_cap to cxl_test. (Dan)

---

Dave Jiang (3):
      cxl: Add check for result of interleave ways plus granularity combo
      cxl: Add CXL spec v3.0 interleave support
      tools/testing/cxl: Add interleave check support to mock cxl port device


 drivers/cxl/core/hdm.c       |  6 +++++
 drivers/cxl/core/region.c    | 50 +++++++++++++++++++++++++++++++++++-
 drivers/cxl/cxl.h            |  2 ++
 drivers/cxl/cxlmem.h         |  5 ++++
 tools/testing/cxl/test/cxl.c |  3 +++
 5 files changed, 65 insertions(+), 1 deletion(-)

--

