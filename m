Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3D1EC433F5
	for <linux-cxl@archiver.kernel.org>; Thu, 28 Apr 2022 22:10:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352785AbiD1WNp (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 28 Apr 2022 18:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352791AbiD1WNj (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 28 Apr 2022 18:13:39 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7080D4B1CA
        for <linux-cxl@vger.kernel.org>; Thu, 28 Apr 2022 15:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651183823; x=1682719823;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eWAKZOCEiukJwwwO0K/9Rdi7TNhtTLDtQjOlHQTdGi0=;
  b=ggK5JBwSYT2pOZGy6yPnnKCKOZ3CNhQAnK7Z57ZII1vzMnzXu2OKJrb7
   AxzNLepWtDVj4JOHiV7KCUN3YdrQWg4KgFCWP8L/EXS7EOByVI+PvDrkn
   N9FRRv0GzLF/y7jBpXGZ/2pG9TiZXu83yfgCxSr1ATMw20Cg5P/ra9zK6
   RYx7b1Ce8qLeLGYRImo2eve+VeLXHsvHTJdKG/WMWkxriub5VwFpLtC+8
   wnYWO53+7zlp6xOjJKoWzKCFTsBprDSGjZRUcoO5XjnACtW//3hGxRNtN
   jaadd4ouzJSBqEoVb95q99+gytJQLRoE14LDkKvbahri175QVaGV07B6k
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10331"; a="264028240"
X-IronPort-AV: E=Sophos;i="5.91,296,1647327600"; 
   d="scan'208";a="264028240"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2022 15:10:23 -0700
X-IronPort-AV: E=Sophos;i="5.91,296,1647327600"; 
   d="scan'208";a="808817284"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2022 15:10:22 -0700
Subject: [ndctl PATCH 04/10] cxl/port: Fix disable-port man page
From:   Dan Williams <dan.j.williams@intel.com>
To:     vishal.l.verma@intel.com
Cc:     linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev
Date:   Thu, 28 Apr 2022 15:10:22 -0700
Message-ID: <165118382203.1676208.17234717366569348622.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <165118380037.1676208.7644295506592461996.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <165118380037.1676208.7644295506592461996.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

The man page was copied from the enable-port. Fix up some enable-port
leftovers, and duplicated --endpoint option description.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 Documentation/cxl/cxl-disable-port.txt |    6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/Documentation/cxl/cxl-disable-port.txt b/Documentation/cxl/cxl-disable-port.txt
index de13c07d149b..ac56f20e8e6d 100644
--- a/Documentation/cxl/cxl-disable-port.txt
+++ b/Documentation/cxl/cxl-disable-port.txt
@@ -5,7 +5,7 @@ cxl-disable-port(1)
 
 NAME
 ----
-cxl-disable-port - activate / hot-add a given CXL port
+cxl-disable-port - disable / hot-remove a given CXL port and descendants
 
 SYNOPSIS
 --------
@@ -22,7 +22,6 @@ OPTIONS
 	Toggle from treating the port arguments as Switch Port identifiers to
 	Endpoint Port identifiers.
 
-
 -f::
 --force::
 	DANGEROUS: Override the safety measure that blocks attempts to disable a
@@ -31,9 +30,6 @@ OPTIONS
 	firmware and disabling an active device is akin to force removing memory
 	from a running system.
 
-	Toggle from treating the port arguments as Switch Port identifiers to
-	Endpoint Port identifiers.
-
 --debug::
 	If the cxl tool was built with debug disabled, turn on debug
 	messages.

