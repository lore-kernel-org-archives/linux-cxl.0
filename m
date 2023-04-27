Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40213C77B61
	for <linux-cxl@archiver.kernel.org>; Thu, 27 Apr 2023 19:49:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244531AbjD0Ttr (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 27 Apr 2023 15:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344041AbjD0Ttq (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 27 Apr 2023 15:49:46 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 231721FE5;
        Thu, 27 Apr 2023 12:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682624983; x=1714160983;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=c/M4v8T4tBYjFSQO6uQNXTHwPLHX0h6EmoiFaRinEqo=;
  b=YVQTgeeFdZWRS/qaK9aZsftYJemEyggGT11pv0yr9My2HhyGi8nqatp1
   5DjoxuY/NEqo2pE/UeitNtwi6DoM2XOZle2N5W5RFvBSGvAjNgL0nen3S
   aTEkHGtLnv7mx1JI/WQSko6QzZQPvcWtZMSKZ0iLRq+rJDAQokwyyXQIK
   3Q7ilkRPZ7CeOoSWU7ar7cbRSRdpq4ZhrGZlEu/NiNfMfXxy79SCPwEvu
   40YqWk74oQIa8cRZUbrkZeNJ3emqaiQSJYgRj7yQZqX5Axrn7WwjsKV/F
   zQ6VKDh6KCFe9C0CzeoTQIZKvZ47LFs57urUC1Cl+vlr7wNQJCWEIXec+
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="347572330"
X-IronPort-AV: E=Sophos;i="5.99,232,1677571200"; 
   d="scan'208";a="347572330"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2023 12:49:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="763966947"
X-IronPort-AV: E=Sophos;i="5.99,232,1677571200"; 
   d="scan'208";a="763966947"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.57.248])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2023 12:49:42 -0700
Date:   Thu, 27 Apr 2023 12:49:40 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Raghu H <raghuhack78@gmail.com>, linux-cxl@vger.kernel.org,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [STYLE v1 3/3] cxl/core/region:Remove else after return statement
Message-ID: <ZErR1J/PqEvfxHCi@aschofie-mobl2>
References: <20230419111443.231151-1-raghuhack78@gmail.com>
 <20230419111443.231151-4-raghuhack78@gmail.com>
 <644ac94ad6977_182a92946e@iweiny-mobl.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <644ac94ad6977_182a92946e@iweiny-mobl.notmuch>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, Apr 27, 2023 at 12:13:14PM -0700, Ira Weiny wrote:
> Raghu H wrote:
> > The else section here is redundant after return statement, removing it.
> > Sanity and correctness is not affected due to this fix.
> > 
> > Signed-off-by: Raghu H <raghuhack78@gmail.com>
> 
> Ok, per my eyes I would have liked an extra space before the dev_err()
> but...

Well, I asked Rahgu to give us a v2 with mostly patch formatting fixups,
so let's get that extra space too :)

> 
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> 
> > ---
> >  drivers/cxl/core/region.c | 7 +++----
> >  1 file changed, 3 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index f29028148806..1d695107b4a7 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> > @@ -2666,11 +2666,10 @@ static int cxl_region_invalidate_memregion(struct cxl_region *cxlr)
> >  				"Bypassing cpu_cache_invalidate_memregion() for testing!\n");
> >  			clear_bit(CXL_REGION_F_INCOHERENT, &cxlr->flags);
> >  			return 0;
> > -		} else {
> > -			dev_err(&cxlr->dev,
> > -				"Failed to synchronize CPU cache state\n");
> > -			return -ENXIO;
> >  		}
> > +		dev_err(&cxlr->dev,
> > +			"Failed to synchronize CPU cache state\n");
> > +		return -ENXIO;
> >  	}
> >  
> >  	cpu_cache_invalidate_memregion(IORES_DESC_CXL);
> > -- 
> > 2.39.2
> > 
