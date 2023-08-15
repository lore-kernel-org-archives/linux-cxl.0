Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B0C7C001DE
	for <linux-cxl@archiver.kernel.org>; Tue, 15 Aug 2023 16:47:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235910AbjHOQqj (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 15 Aug 2023 12:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238561AbjHOQqe (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 15 Aug 2023 12:46:34 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18AD31B2
        for <linux-cxl@vger.kernel.org>; Tue, 15 Aug 2023 09:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692117993; x=1723653993;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZsoS0YeG0DnZ1qhvs5t2qB9OZuKLl4OqbJFwgOoIKXo=;
  b=LX4MBGK6HFdLVFcZGDlLdCkkI/qeuT8L98lclr2X6hMw7qmwUhuVj0Bb
   3y+kR6ckQr6BwDc9utMIiEAAKLyZ5N/T8yuNyPz/JkqJmYsaanoxazNuu
   eIV2alvH8cAU8OlPrJinTczUv7yvhqfYGotJqrX1gAVVSTje5Uc5Ln1DF
   53Uy4OYU0nSPlSVmO9zAf+fVLI3tEwC/Fyr8Aa0rSUtscSGfqtiq4Y6qd
   UCcjJbsadfbO5wBzhuZ3mRPrFiVKRlOyFT9P3vpoUtnvhv8JbYT5rBCBH
   w1Kc9wVUdIR5Ug4q/daLfKVZRSmtuEz/tqpACDgFOrbHrUumB3szo1/PU
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="352650012"
X-IronPort-AV: E=Sophos;i="6.01,175,1684825200"; 
   d="scan'208";a="352650012"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 09:46:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="857497489"
X-IronPort-AV: E=Sophos;i="6.01,175,1684825200"; 
   d="scan'208";a="857497489"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.27.4])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 09:46:26 -0700
Date:   Tue, 15 Aug 2023 09:46:25 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-cxl@vger.kernel.org
Subject: Re: [PATCH] cxl/mbox: Remove useless cast in
 cxl_mem_create_range_info()
Message-ID: <ZNur4Rt5m9DKhujM@aschofie-mobl2>
References: <20230804190309.1665132-1-alison.schofield@intel.com>
 <20230807143334.00005448@Huawei.com>
 <ZND/cKkWvby8hPl6@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZND/cKkWvby8hPl6@smile.fi.intel.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, Aug 07, 2023 at 05:28:00PM +0300, Andy Shevchenko wrote:
> On Mon, Aug 07, 2023 at 02:33:34PM +0100, Jonathan Cameron wrote:
> > On Fri,  4 Aug 2023 12:03:09 -0700
> > alison.schofield@intel.com wrote:
> > 
> > > From: Alison Schofield <alison.schofield@intel.com>
> > > 
> > > DEFINE_RES_MEM() returns a struct resource so the cast is not needed.
> > > Remove it.
> 
> > Good to call out this is a result of Andy's cleanup
> > 
> > 42c4211f1 ("resource: Convert DEFINE_RES_NAMED() to be a compound literal")
> > 
> > I thought we'd long caught all of these (IIRC there were a few at the time).
> > Ah well.
> 
> We caught only compile-time errors. The "casting" of the compound literal is
> only a warning which doesn't affect code generation.
> 
> Btw, Alison, the commit message should really be more clear about those macros.
> They are compound literals, which are associated with the corresponding data
> type. It's not a cast there, but only on the side of the user. I'm not a native
> speaker to suggest on how to amend, maybe Jonathan can help?

Thanks Andy. I see the language others used in these. Will send a v2.


> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
