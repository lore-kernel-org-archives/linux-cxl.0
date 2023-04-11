Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2D33C77B6F
	for <linux-cxl@archiver.kernel.org>; Tue, 11 Apr 2023 06:42:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbjDKGmw (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 11 Apr 2023 02:42:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbjDKGmu (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 11 Apr 2023 02:42:50 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FBF5172C
        for <linux-cxl@vger.kernel.org>; Mon, 10 Apr 2023 23:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681195366; x=1712731366;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=ws3OIFgdCaaVGrg+ov7NA8iMejO4xMcRaURgYYOOSM8=;
  b=K1VZGHgpjvRDYzhjkNjIwNKrQx5agkDuBNvySxxOhTq5DpVF3Tc8FKQk
   sbazWa7GcLLl0RNde8FqkJJODf/u7QM8SlWTsnKCB+oNt5EjmKcYBvjT6
   ygodzEUzSx+sgoW+BvlDxJozmmS5KIer7c+ky5n4sBgFxr2VG/oNz6PGw
   +C3Z2ZFUszgLyjJxGGh2cUQTY64PFPnbqWT3u1vzhinOt4sD65t2LsXMc
   bDaWHi4Cq1BJe7qf5Rp/ZT6qCGdwZb9jDs4llkwBg9rbO8LMFzeXv+/kl
   uVw7ZhTXKyL3kRdCEzvMzlC1PCkFU1yP2ikJBBwDX2+RyCABYX+6YF8ma
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="341027780"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="341027780"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2023 23:42:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="1018255338"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="1018255338"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2023 23:42:18 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Gregory Price <gregory.price@memverge.com>
Cc:     Dragan Stancevic <dragan@stancevic.com>,
        lsf-pc@lists.linux-foundation.org, nil-migration@lists.linux.dev,
        linux-cxl@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [LSF/MM/BPF TOPIC] BoF VM live migration over CXL =?utf-8?Q?m?=
 =?utf-8?Q?emory=E2=80=8B?=
References: <5d1156eb-02ae-a6cc-54bb-db3df3ca0597@stancevic.com>
        <ZDCv3lxLbquITy8M@memverge.com>
Date:   Tue, 11 Apr 2023 14:37:50 +0800
In-Reply-To: <ZDCv3lxLbquITy8M@memverge.com> (Gregory Price's message of "Fri,
        7 Apr 2023 20:05:50 -0400")
Message-ID: <87v8i22abl.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Gregory Price <gregory.price@memverge.com> writes:

[snip]

> 2. During the migration process, the memory needs to be forced not to be
>    migrated to another node by other means (tiering software, swap,
>    etc).  The obvious way of doing this would be to migrate and
>    temporarily pin the page... but going back to problem #1 we see that
>    ZONE_MOVABLE and Pinning are mutually exclusive.  So that's
>    troublesome.

Can we use memory policy (cpusets, mbind(), set_mempolicy(), etc.) to
avoid move pages out of CXL.mem node?  Now, there are gaps in tiering,
but I think it is fixable.

Best Regards,
Huang, Ying

[snip]
