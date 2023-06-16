Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94BBBEB64DA
	for <linux-cxl@archiver.kernel.org>; Fri, 16 Jun 2023 15:56:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbjFPP41 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 16 Jun 2023 11:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjFPP40 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 16 Jun 2023 11:56:26 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ADE82D43
        for <linux-cxl@vger.kernel.org>; Fri, 16 Jun 2023 08:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686930985; x=1718466985;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JF/N0em98+IVAlVLsM34BMwu8/HjwfswqWAbK1dKVYk=;
  b=njZM6QYJEl+W1XCPUWZZrJsW1lpbFS9fZEx9yH+RgNKgrWO7qruUZXR1
   BIhzavVOb1QD5z5vDITS0DJ3nhWyGchm+8PW4MnpZ8egLuzTkiZJDtY5w
   a3dv8VrL4C2h+lGdHXftV/kQNjpNUwPhLaChHEcwaSRSwF1VvWqQ2/OFT
   guZYy50YR5IFmzP8+6D4Mg8Mk4dYmQhIezSaOjBDjrrY6r1vCJec7W2ve
   MgrLIdAIrfOeRmDb5bxE636sVdCxvcsN1YqFOJmiKzKmCUA1cL3u3pjkg
   tAaju+cHR0XtYIdrdJTobR8r/SWQ/LDs9FbdfA9yrG4+44wLT13brnbtM
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="356737612"
X-IronPort-AV: E=Sophos;i="6.00,247,1681196400"; 
   d="scan'208";a="356737612"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2023 08:56:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="778198856"
X-IronPort-AV: E=Sophos;i="6.00,247,1681196400"; 
   d="scan'208";a="778198856"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.55.57])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2023 08:56:24 -0700
Date:   Fri, 16 Jun 2023 08:56:22 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Navneet Singh <navneet.singh@intel.com>,
        Fan Ni <fan.ni@samsung.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-cxl@vger.kernel.org
Subject: Re: [PATCH 2/5] cxl/region: Add dynamic capacity cxl region support.
Message-ID: <ZIyGJjCQ92ng+qoH@aschofie-mobl2>
References: <20230604-dcd-type2-upstream-v1-0-71b6341bae54@intel.com>
 <20230604-dcd-type2-upstream-v1-2-71b6341bae54@intel.com>
 <ZIpZmn69Z1PyVsED@aschofie-mobl2>
 <648bc397c5380_1c7ab42946e@iweiny-mobl.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <648bc397c5380_1c7ab42946e@iweiny-mobl.notmuch>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, Jun 15, 2023 at 07:06:15PM -0700, Ira Weiny wrote:
> Alison Schofield wrote:
> > On Wed, Jun 14, 2023 at 12:16:29PM -0700, Ira Weiny wrote:
> > > From: Navneet Singh <navneet.singh@intel.com>
> > > 
> > > CXL devices optionally support dynamic capacity. CXL Regions must be
> > > created to access this capacity.
> > > 
> > > Add sysfs entries to create dynamic capacity cxl regions. Provide a new
> > > Dynamic Capacity decoder mode which targets dynamic capacity on devices
> > > which are added to that region.
> > 
> > This is a lot in one patch, especially where it weaves in and out of
> > existing code. I'm wondering if this can be introduced in smaller
> > pieces (patches). An introductory patch explaining the DC DPA 
> > allocations might be a useful chunk to pull forward. 
> 
> The patch is < 800 lines long.  And would be closer to 700 lines if there
> were not 8 different 'modes' for the various DC regions.
> 
> It is also very self contained in that it implements the region creation
> for DC DPAs fully.  And I know that Dan prefers patches larger if they are
> all part of the same functionality.
> 
> Dan?

Ira,
I found the patch difficult to review, and hope that it can be 
presented in a way that is easier to review. I don't know if
that results in separate patches.

It's hard for me to imagine that it wasn't conceived of in 
smaller chunks, that could be presented, but I don't know.

I'll go back and review the patch now, and point out where,
I found it difficult to follow.

Alison




> 
> Ira
