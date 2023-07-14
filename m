Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88901EB64DC
	for <linux-cxl@archiver.kernel.org>; Fri, 14 Jul 2023 18:35:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235999AbjGNSfQ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 14 Jul 2023 14:35:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235872AbjGNSfQ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 14 Jul 2023 14:35:16 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 262B32713
        for <linux-cxl@vger.kernel.org>; Fri, 14 Jul 2023 11:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689359712; x=1720895712;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=inBIHJo3CNqIq7SLViz6cm8ueZD1rHJGc4MqK9jh1TI=;
  b=lP2NmS1xQVpLeLuRo/3z5mMmarpcIsakWv1YJyXaFLHM1bMDdyK6HceK
   kNtouLq/Ka0sTl6oy4jJjAwOD5F3mC7VL2krjzruMvYfFIioBe/Tc/dlC
   EJac9fYxsSn1IQrEEsdgpm40B8r+fTl2cLurpgTvGd1mnR0bckWg/eYs6
   dq6/6bpHXw4nxy5j12+RjwQw4CoVNEkDTLuah/GbHPtFREpgNSgAH5qR1
   GiCDzeur9rkECXAsLMi15Ix180MXZwgZekriuqRTsjk47rMT2RvRtHXDp
   NAlBjkFpLVYUOUKp+WugzqL3iFNbUzYbyFqWJdS91Xcj6X7309Ngav88i
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10771"; a="363011810"
X-IronPort-AV: E=Sophos;i="6.01,206,1684825200"; 
   d="scan'208";a="363011810"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2023 11:35:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10771"; a="812549911"
X-IronPort-AV: E=Sophos;i="6.01,206,1684825200"; 
   d="scan'208";a="812549911"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.212.181.205])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2023 11:35:10 -0700
Date:   Fri, 14 Jul 2023 11:35:09 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     vishal.l.verma@intel.com, dan.j.williams@intel.com,
        dave.jiang@intel.com, fan.ni@samsung.com, a.manzanares@samsung.com,
        linux-cxl@vger.kernel.org
Subject: Re: [PATCH 2/2] cxl/memdev: Introduce sanitize-memdev functionality
Message-ID: <ZLGVXQnn63mImOTY@aschofie-mobl2>
References: <20230713195455.19769-1-dave@stgolabs.net>
 <20230713195455.19769-3-dave@stgolabs.net>
 <ZLC/6mWTE+2WxcGd@aschofie-mobl2>
 <72wb3boxuugrb35cz2riexiyfszzc4pc43v7i5ufct7kszjoso@x4gjsuohw4kc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72wb3boxuugrb35cz2riexiyfszzc4pc43v7i5ufct7kszjoso@x4gjsuohw4kc>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, Jul 14, 2023 at 08:00:43AM -0700, Davidlohr Bueso wrote:
> On Thu, 13 Jul 2023, Alison Schofield wrote:
> 
> > On Thu, Jul 13, 2023 at 12:54:51PM -0700, Davidlohr Bueso wrote:

snip

> > > +
> > > +	/* let Sanitize be the default */
> > > +	if (!param.secure_erase && !param.sanitize)
> > > +		param.sanitize = true;
> > > +
> > > +	if (param.secure_erase)
> > > +		rc = cxl_memdev_sanitize(memdev, "erase");
> > > +	if (param.sanitize)
> > > +		rc = cxl_memdev_sanitize(memdev, "sanitize");
> > > +	else
> > > +		rc = -EINVAL;
> > 
> > What's the deal w supporting secure erase with sanitize?
> > Seems useless, but perhaps it's cheap.
> 
> It is what it is. The secure erase option passed as a program
> parameter seemed a natural fit - in addition, both operations
> are logically grouped under the Sanitize category per specs.
> 
> Vishal was fine with this, did you have anything in mind?

If the tool accepts both cmdline options at the same time, it's
implying that there is value in doing the secure-erase followed
by the sanitize.

Does the user get more value by doing both, or is secure-erase useless
when followed immediately by sanitize?

Alison


> 
> Thanks,
> Davidlohr
