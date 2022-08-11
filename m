Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5158DC25B06
	for <linux-cxl@archiver.kernel.org>; Thu, 11 Aug 2022 23:56:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235701AbiHKX4x (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 11 Aug 2022 19:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234910AbiHKX4w (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 11 Aug 2022 19:56:52 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65D6D9E2D9
        for <linux-cxl@vger.kernel.org>; Thu, 11 Aug 2022 16:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660262210; x=1691798210;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nIMrNpMksycqdDIEt0oK0J29qwVLIjfrvZ57ZdU3FYs=;
  b=YZPY1QEStZDmQtlsVwP1PwEKOuJ/AnA2eLWo+g0mwoqLXyDu0HTUNKbc
   deUzex3RNon/jJCc52rtAXyMWVH/U8G2fuvV98ThP6M1yWcqcNP3VbEX9
   UiwAm6zzrcitZ/8phwthVBZDWreL/QL5ly5b+ktMfKgeb42gvJDxaBhwc
   Ili9TyxrGqiAq/Df8ZLECc7ek+STznLGD6aozGYJvAvZJQciNNbuq67fZ
   5zzbSqTLtDsbqksofMjXrabiiFh9592auctRG97jCs9xGba9DDs/LYmUS
   C5q7pMR8XSMZk8OuMo5/CdkY7d/TrdAjLT1Ern2d1hrpyIm4Fz1nIMZ6N
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10436"; a="271260941"
X-IronPort-AV: E=Sophos;i="5.93,231,1654585200"; 
   d="scan'208";a="271260941"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2022 16:56:50 -0700
X-IronPort-AV: E=Sophos;i="5.93,231,1654585200"; 
   d="scan'208";a="665604907"
Received: from djiang5-desk4.jf.intel.com ([10.165.157.96])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2022 16:56:49 -0700
Subject: [PATCH v2 0/3] Add sanity check for interleave setup
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     dan.j.williams@intel.com, vishal.l.verma@intel.com,
        ira.weiny@intel.com, alison.schofield@intel.com,
        Jonathan.Cameron@huawei.com
Date:   Thu, 11 Aug 2022 16:56:49 -0700
Message-ID: <166026184968.1454405.494690416353090765.stgit@djiang5-desk4.jf.intel.com>
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
 drivers/cxl/core/region.c    | 11 +++++++-
 drivers/cxl/cxl.h            |  2 ++
 drivers/cxl/cxlmem.h         | 50 ++++++++++++++++++++++++++++++++++++
 tools/testing/cxl/test/cxl.c |  3 +++
 5 files changed, 71 insertions(+), 1 deletion(-)

--

