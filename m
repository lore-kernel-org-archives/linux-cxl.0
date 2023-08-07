Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05360C001B0
	for <linux-cxl@archiver.kernel.org>; Mon,  7 Aug 2023 14:28:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbjHGO2J (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 7 Aug 2023 10:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234092AbjHGO2F (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 7 Aug 2023 10:28:05 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 096F9F0
        for <linux-cxl@vger.kernel.org>; Mon,  7 Aug 2023 07:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691418485; x=1722954485;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=w0NdACBQd8S24q5ewB+9ymxEbqntXLLVHYaze7jjWF0=;
  b=mP/lAnAuwD+Q2EvyvmzdbWJxYZhzLYdtjQRLKfA7+rSyv3nOWajmQpaT
   5qALwAne6ZUbG+w/EmSqUepT/Owko3GWIsaPnwHmDJxIxNcD9y9gQ5n5B
   eTQ8HmHTzzQswRbUOug1TiRXL4iWZ/qTUSVzLrJI4k1Hyhb6w/559eKwT
   TiRS7LgXj3pOw+Z8L1eD6WuVgLU8oxdagc2XwYr+CVyd5id2LwqaTEOc1
   EijojJjikeamJLArn3342LGHnChlsWRnUNgMaagEVb3EDg+iU+kkAHTWD
   sL4fbaw5QxtTL9t2gUoJbjYC87tZVkL/YkJJRlAOJib6PeQUwhT6cBNok
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="370556054"
X-IronPort-AV: E=Sophos;i="6.01,262,1684825200"; 
   d="scan'208";a="370556054"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2023 07:28:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="707887232"
X-IronPort-AV: E=Sophos;i="6.01,262,1684825200"; 
   d="scan'208";a="707887232"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006.jf.intel.com with ESMTP; 07 Aug 2023 07:28:02 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qT1DE-00FJgw-38;
        Mon, 07 Aug 2023 17:28:00 +0300
Date:   Mon, 7 Aug 2023 17:28:00 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     alison.schofield@intel.com, Davidlohr Bueso <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-cxl@vger.kernel.org
Subject: Re: [PATCH] cxl/mbox: Remove useless cast in
 cxl_mem_create_range_info()
Message-ID: <ZND/cKkWvby8hPl6@smile.fi.intel.com>
References: <20230804190309.1665132-1-alison.schofield@intel.com>
 <20230807143334.00005448@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230807143334.00005448@Huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, Aug 07, 2023 at 02:33:34PM +0100, Jonathan Cameron wrote:
> On Fri,  4 Aug 2023 12:03:09 -0700
> alison.schofield@intel.com wrote:
> 
> > From: Alison Schofield <alison.schofield@intel.com>
> > 
> > DEFINE_RES_MEM() returns a struct resource so the cast is not needed.
> > Remove it.

> Good to call out this is a result of Andy's cleanup
> 
> 42c4211f1 ("resource: Convert DEFINE_RES_NAMED() to be a compound literal")
> 
> I thought we'd long caught all of these (IIRC there were a few at the time).
> Ah well.

We caught only compile-time errors. The "casting" of the compound literal is
only a warning which doesn't affect code generation.

Btw, Alison, the commit message should really be more clear about those macros.
They are compound literals, which are associated with the corresponding data
type. It's not a cast there, but only on the side of the user. I'm not a native
speaker to suggest on how to amend, maybe Jonathan can help?

-- 
With Best Regards,
Andy Shevchenko


