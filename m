Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFA83C00140
	for <linux-cxl@archiver.kernel.org>; Mon,  8 Aug 2022 21:06:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236912AbiHHVGy (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 8 Aug 2022 17:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231742AbiHHVGx (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 8 Aug 2022 17:06:53 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7DFBDF56
        for <linux-cxl@vger.kernel.org>; Mon,  8 Aug 2022 14:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659992812; x=1691528812;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Ikwv9l/izZOrjj/xbtxn0S26mokU9imWVDsFoVq8f/c=;
  b=TaKdmhdXa3N9r3iksUrYHvmnR9D4KOneuKqovDajgYd4QE4eZFM2Gzjs
   ydhn+/2oVCBTVEv0/DojNYGRzalsPcOT8KFghx1JfnhQQqumKZYhosPeu
   T4XhsFRN7U64nNMJuUwJ00QMabR9QEkANGRwtMDTLepp9as3f3oC5hFLf
   ecdjqEZM7DuFSMgzEnIsxvywB2GevuENPm1ODl4EaI1wX4YTFDi6ZPP+6
   jhXFdbUnzu1kmeD7q8t3MpsUidL8Hi3B+3BmF+WrSppxBlZtLhfkzScw7
   2/Z37b0nKQ0/PFmHx6yqd5b1uTHYnccMkbYFyZ20sk4jsPXb3wi2BYW98
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10433"; a="291472278"
X-IronPort-AV: E=Sophos;i="5.93,222,1654585200"; 
   d="scan'208";a="291472278"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2022 14:06:52 -0700
X-IronPort-AV: E=Sophos;i="5.93,222,1654585200"; 
   d="scan'208";a="932219807"
Received: from djiang5-desk4.jf.intel.com ([10.165.157.96])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2022 14:06:51 -0700
Subject: [PATCH 0/3] Add sanity check for interleave setup
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     dan.j.williams@intel.com, vishal.l.verma@intel.com,
        ira.weiny@intel.com, alison.schofield@intel.com,
        Jonathan.Cameron@huawei.com
Date:   Mon, 08 Aug 2022 14:06:51 -0700
Message-ID: <165999244272.493131.1975513183227389633.stgit@djiang5-desk4.jf.intel.com>
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

---

Dave Jiang (3):
      cxl: Add check for result of interleave ways plus granularity combo
      cxl: Add CXL spec v3.0 interleave support
      tools/testing/cxl: Add interleave check support to mock cxl port device


 drivers/cxl/core/hdm.c       |  4 +++
 drivers/cxl/core/region.c    | 17 +++++++++-
 drivers/cxl/cxl.h            | 13 ++++++++
 drivers/cxl/cxlmem.h         | 60 ++++++++++++++++++++++++++++++++++++
 tools/testing/cxl/test/cxl.c |  2 ++
 5 files changed, 95 insertions(+), 1 deletion(-)

--

