Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDAFDC61DA3
	for <linux-cxl@archiver.kernel.org>; Wed, 22 Feb 2023 01:51:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbjBVBvW (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 21 Feb 2023 20:51:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbjBVBvV (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 21 Feb 2023 20:51:21 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A5DB2CFC8
        for <linux-cxl@vger.kernel.org>; Tue, 21 Feb 2023 17:51:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677030675; x=1708566675;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pZ0ZFSxyw5N9uzcL/dkvXHp8m07Sk2Lx9knjSAuU1gE=;
  b=a899EMJrdsSXIzSd58IA40X2SmfgctYOsgBn0r7RsKWUolr4SlhvFm4L
   bu+P5w4RYZW4otSPyFIJvD926TIh0vhHSHglK5iMQ8T4jHjjzr5Zzc4/1
   MXKiYNkP/5d5pkAz5rY2kNqOBTI04fnQCI8wIS6wbDPvJPFeqlCQ3kRMK
   bRgaEASSP+m2mRcnhc46ZxF9SQBx6WRXaFCP+eVJNzFZf0ylnBvxuXQLg
   VhRpmAG6nXh+EmEC2MQOG7HvLMRvmgkj8T4+632UJ5324XpkM3/+BVd+B
   nAQr3lT6PsvL/juO5+EDtHqcK6ZEkhcyt2ViTSj7yr1Gc+5b85AYKrgRu
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10628"; a="360287985"
X-IronPort-AV: E=Sophos;i="5.97,317,1669104000"; 
   d="scan'208";a="360287985"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2023 17:51:14 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10628"; a="621737196"
X-IronPort-AV: E=Sophos;i="5.97,317,1669104000"; 
   d="scan'208";a="621737196"
Received: from pjois-mobl1.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.101.5])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2023 17:51:14 -0800
Subject: [PATCH 0/2] cxl: DVSEC Range emulation fixups
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        dave.jiang@intel.com
Date:   Tue, 21 Feb 2023 17:51:13 -0800
Message-ID: <167703067373.185722.16579529992799939220.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Jonathan points out that the kernel is too agressive in assuming that
DVSEC range registers are in use, reliably skip emulation if
'mem_enabled' is not set. The helper devm_cxl_setup_emulated_hdm() is
needlessly redoing an allocation, clean that up.

---

Dan Williams (2):
      cxl/hdm: Fix double allocation of @cxlhdm
      cxl/hdm: Skip emulation when driver manages mem_enable


 drivers/cxl/core/hdm.c |   65 ++++++++++++++++++------------------------------
 drivers/cxl/cxl.h      |    4 ++-
 drivers/cxl/port.c     |    2 +
 3 files changed, 28 insertions(+), 43 deletions(-)

base-commit: 23c198e3dfaabbc891681aecb0855b9e0ac791e1
