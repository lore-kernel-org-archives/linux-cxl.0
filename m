Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F9BEC00140
	for <linux-cxl@archiver.kernel.org>; Fri,  5 Aug 2022 20:27:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241284AbiHEU1s (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 5 Aug 2022 16:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234198AbiHEU1r (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 5 Aug 2022 16:27:47 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAEF71F2E1
        for <linux-cxl@vger.kernel.org>; Fri,  5 Aug 2022 13:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659731266; x=1691267266;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=bUb/YU/C3mOqyRJg0XWyc0awDtcoHi4heKW5APL3r5s=;
  b=noUyZ4ba6az44xTSbCR09Gh2Ldt8tElTqpyMQYurk+/U5viIsYith8LW
   HQqDsX5gESYjryVxD3lPAM1vEnUuIWnM8NyKm6+FeFurCMPv8H5GcYtoW
   TQO0f/0mx2H+Bu29L1aGj+8wqS4GEjWyNohUMKuto8Rn1wz/KDLG4i6a2
   IxVuGJQZblZOscaOy5hshs90ZOXEPDnZ4tpg8PdUv6kXRmXD9Qip1T5NO
   v2G6UBhhyMQQ4SqtVthDWXyLqCMS08MQL3on8e5hz2sz6fqi0AvtFcK5z
   fIqNdX3U/XaBIsXyqy0A2TRgzZH3/N+ZOXz09Fa3+wgl/1hkZDO492EZm
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10430"; a="291057136"
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="291057136"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2022 13:27:35 -0700
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="849440981"
Received: from jivaldiv-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.255.228.201])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2022 13:27:34 -0700
Subject: [PATCH v2 0/3] CXL Region Provisioning Fixes
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        vishal.l.verma@intel.com, ira.weiny@intel.com,
        alison.schofield@intel.com, dave.jiang@intel.com
Date:   Fri, 05 Aug 2022 13:27:34 -0700
Message-ID: <165973125417.1526540.14425647258796609596.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Changes and new fixes since v1 [1]:

While reviewing "cxl/region: Constrain region granularity scaling
factor" [2] it became clear that the attempt to support region granularity >
window (ACPI CFMWS entry) granularity was misguided. Update the
implementation to disallow that configuration, but also allow
unrestricted granularity settings when the window interleave-ways is 1.

Speaking of window interleave-ways == 1 add a fix to
cxl_port_setup_targets() for the case where it does not need to assign
addition address bits to the decode.

Lastly, fix a regression with the original version of "cxl/region: Move
HPA setup to cxl_region_attach()" that broke the establishment of
->hpa_range in switch decoders.

An expansion of cxl_test to backstop these fixes will be posted shortly.

These are based on the updated state of the cxl/pending branch that has
pulled in the reviewed fixes from Dan and Bagas.

[1]: https://lore.kernel.org/r/165853775181.2430596.3054032756974329979.stgit@dwillia2-xfh.jf.intel.com/
[2]: https://lore.kernel.org/r/165853778028.2430596.7493880465382850752.stgit@dwillia2-xfh.jf.intel.com/

---

Dan Williams (3):
      cxl/region: Move HPA setup to cxl_region_attach()
      cxl/region: Fix x1 interleave to greater than x1 interleave routing
      cxl/region: Disallow region granularity != window granularity


 drivers/cxl/core/hdm.c    |   26 ++------------------------
 drivers/cxl/core/region.c |   43 ++++++++++++++++++++++++++++++++++---------
 2 files changed, 36 insertions(+), 33 deletions(-)

base-commit: 2901c8bdedca19e5efdab2ea55b465102231b315
