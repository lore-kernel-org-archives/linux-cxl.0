Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E077C00140
	for <linux-cxl@archiver.kernel.org>; Fri,  5 Aug 2022 20:37:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235839AbiHEUhx (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 5 Aug 2022 16:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234198AbiHEUhw (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 5 Aug 2022 16:37:52 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF2C431F
        for <linux-cxl@vger.kernel.org>; Fri,  5 Aug 2022 13:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659731871; x=1691267871;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+/t/0fsG5otEgT5ZP1S4Vyv84T6cV7f5d0A2IfFn2/s=;
  b=ZORUp3rQ6q/DuYYkG3GvWryd0dt4Ph3n0MIahWqRARJqiR2EJL0p5r11
   QTmnGaVKTfNZPXZfhEnauiYKkxhgLTLIosIa48KSVz61QxI/1Cez0aG+9
   e1VTuvjlsCa/gqBSyZd4IYxOyknAL04/PTPgL9NwjOVYO8ylTBNreaIjH
   uEIT+60FK+EqN/AQZnejNS6jY51q6i1SjZfdX2K1IK06EqXDrUO83YCXO
   jVQPhmXOQN3wHkf/kwPCafaUfUnts7yI7Ohqo1oxxxUMG/ctSbN9OLYzq
   Ncp+Kyq1zdxvMGz4TcZjxuxwV0dpJeN0HLVuiVPPh5V3xZ5tDEaP7lSxy
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10430"; a="352008487"
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="352008487"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2022 13:37:51 -0700
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="632143970"
Received: from jivaldiv-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.255.228.201])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2022 13:37:51 -0700
Subject: [ndctl PATCH 0/6] cxl/test: Add more region ABI validation
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        vishal.l.verma@intel.com, dave.jiang@intel.com,
        ira.weiny@intel.com, alison.schofield@intel.com
Date:   Fri, 05 Aug 2022 13:37:51 -0700
Message-ID: <165973187080.1528532.8097010788284626448.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Expand cxl-region-sysfs.sh to validate that all decoders in the test
region are setup per expectations. In support of that testing, decoder
listings gain 'interleave_ways', 'interleave_granularity', and 'region'
attributes, while port listings gain a 'depth' attribute. Decoders can
now be filtered by their associated region.

---

Dan Williams (6):
      cxl/test: Validate endpoint interleave geometry
      cxl/list: Add interleave parameters to decoder listings
      cxl/list: Add region to decoder listings
      cxl/list: Filter decoders by region
      cxl/list: Add 'depth' to port listings
      cxl/test: Validate switch port settings in cxl-region-sysfs.sh


 Documentation/cxl/lib/libcxl.txt |    8 ++++++
 cxl/filter.c                     |   23 +++++++++++++++++
 cxl/json.c                       |   32 +++++++++++++++++++++++
 cxl/lib/libcxl.c                 |   39 +++++++++++++++++++++++++++++
 cxl/lib/libcxl.sym               |    2 +
 cxl/libcxl.h                     |    2 +
 test/cxl-region-sysfs.sh         |   52 +++++++++++++++++++++++++++++++++++++-
 7 files changed, 156 insertions(+), 2 deletions(-)
