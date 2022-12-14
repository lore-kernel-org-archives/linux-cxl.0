Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A85EEC4332F
	for <linux-cxl@archiver.kernel.org>; Wed, 14 Dec 2022 00:25:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237205AbiLNAZp (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 13 Dec 2022 19:25:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236946AbiLNAZX (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 13 Dec 2022 19:25:23 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 937CFBC83
        for <linux-cxl@vger.kernel.org>; Tue, 13 Dec 2022 16:25:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670977522; x=1702513522;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WuX5Ni1zMmbFtgxAUJWSCLA953JcY5rJhbJy8za9GUo=;
  b=kX3+nPZwDAeUGzfo22K2tG22hpg58b3HYMsfdJyFnIpmey3GbJjBtXmW
   VtudBpAzEOFM/6/XCMNWG9AzlmVe9j3S9qcPJ+6PueYqGD/7Tjq24ShjG
   Sh/3G+1vyZaTSVX8LKqvMV6ETH4+P7YO+UZU/vLS3tr2yQboBfnoJWh2S
   sBXFyCr2nHKNepHDDVtv2xNm3915AlrptVhDhRiOFuPSmGH8UOesX80bi
   EPplHQoLo78F4ZvSRqxFjamESw6Sf0pYfl8PZdFaB6D0pAoDX/LYvRejC
   ulCewiaTdz1Vz3ogoRLW/usC0up34uBK6ctpXhmTd/pgJIeTTKvrJ/SMu
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10560"; a="404540089"
X-IronPort-AV: E=Sophos;i="5.96,242,1665471600"; 
   d="scan'208";a="404540089"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2022 16:25:22 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10560"; a="823084711"
X-IronPort-AV: E=Sophos;i="5.96,242,1665471600"; 
   d="scan'208";a="823084711"
Received: from mesplin-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.37.170])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2022 16:25:21 -0800
Subject: [ndctl PATCH 0/5] cxl/test: Reliability fixes
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Vishal Verma <vishal.l.verma@intel.com>,
        Matthew Ho <sunfishho12@gmail.com>, vishal.l.verma@intel.com,
        patches@lists.linux.dev
Date:   Tue, 13 Dec 2022 16:25:21 -0800
Message-ID: <167097752151.1189953.3189708700022130101.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Following up on the last round of updates [1], add support for the
recently landed RCH enabling in the v6.2 kernel, and improve the
reliability of test execution.

For RCH support 'cxl list' now understands that some CXL endpoints do
not have an intervening cxl_port object instance between themselves and
the CXL root object.

The largest change by lines of code is support for flushing udev event
queue in response to API calls that mutate the topology. This reduced
the need for manually invoked 'udevadm settle' in tests and end user
scripts.

[1]: http://lore.kernel.org/r/167053487710.582963.17616889985000817682.stgit@dwillia2-xfh.jf.intel.com

---

Dan Williams (3):
      cxl/lib: Add cxl_wait_probe()
      cxl/test: Fix cxl-topology.sh expectations
      cxl/test: More backtrace detection

Vishal Verma (2):
      cxl/list: include --endpoints in -v listings
      cxl/filter: enumerate endpoints and memdevs in an RCH


 cxl/filter.c              |    8 ++++
 cxl/lib/libcxl.c          |   91 +++++++++++++++++++++++++++++++++++----------
 cxl/lib/meson.build       |    1 
 cxl/lib/private.h         |    1 
 cxl/list.c                |    1 
 test/common               |    1 
 test/cxl-create-region.sh |    4 +-
 test/cxl-labels.sh        |    3 +
 test/cxl-region-sysfs.sh  |    1 
 test/cxl-topology.sh      |    4 +-
 10 files changed, 89 insertions(+), 26 deletions(-)

base-commit: 95faaa09cf1c455a1b5d2fb934a0b96367d0f189
