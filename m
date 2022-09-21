Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3299CECAAD8
	for <linux-cxl@archiver.kernel.org>; Wed, 21 Sep 2022 21:02:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbiIUVCl (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 21 Sep 2022 17:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbiIUVCk (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 21 Sep 2022 17:02:40 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 884ABA032A
        for <linux-cxl@vger.kernel.org>; Wed, 21 Sep 2022 14:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663794157; x=1695330157;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tm8QMskEGivaJ+11MsTQvwARAOh+caR2SfWu3HkJSfk=;
  b=Gu4I+0YiJqrAwUaHv471nhTfrkakWJg7wByIAJDxfKvyaMS6XMfy7zIA
   2geambLdao1WVh5erdlcgZMhbiAxiwXgmZvs3EIbis/+1qbMa8kAOWUUt
   ttuk8sp5OyQ8FqdjUQmESsVfs7bIwalFkttbhmLqzEX5BvsvVJxYzDjZz
   dAOqoB8LTxR30usT+tJAADo1dTWJ9h5CubhY7pyFhoreGIKwLEzXlzvT1
   N7az4GYGrl7WlbJzcZoIw1qonOtdV/sSYeiuzEg2pb78vVP2O/SEcWA05
   WrrDIjg4cuTCU72LeU0B4nfYON4fBT6EFEelYFJJh1cyNTOVa7R1DHy5k
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10477"; a="297724652"
X-IronPort-AV: E=Sophos;i="5.93,334,1654585200"; 
   d="scan'208";a="297724652"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2022 14:02:37 -0700
X-IronPort-AV: E=Sophos;i="5.93,334,1654585200"; 
   d="scan'208";a="681934732"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2022 14:02:37 -0700
Subject: [PATCH 0/4] ndctl: Add security test for cxl devices through nvdimm
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev
Cc:     vishal.l.verma@intel.com
Date:   Wed, 21 Sep 2022 14:02:36 -0700
Message-ID: <166379397620.433612.13099557870939895846.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

This ndctl series add support to test cxl pmem devices through the nvdimm
interface. A new shell script is added for security test due to the
discovery of cxl_test dimms are different than nfit_test based dimms.

---

Dave Jiang (4):
      ndctl: add cxl bus detection
      ndctl/libndctl: Add bus_prefix for cxl
      ndctl/libndctl: Add retrieving of unique_id for cxl mem dev
      ndctl/test: Add CXL test for security


 ndctl/lib/libndctl.c   |  87 +++++++++++++
 ndctl/lib/libndctl.sym |   1 +
 ndctl/lib/private.h    |   1 +
 ndctl/libndctl.h       |   1 +
 test/common            |   7 +
 test/meson.build       |   7 +
 test/security-cxl.sh   | 282 +++++++++++++++++++++++++++++++++++++++++
 7 files changed, 386 insertions(+)
 create mode 100755 test/security-cxl.sh

--

