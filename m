Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80073C4338F
	for <linux-cxl@archiver.kernel.org>; Wed, 11 Aug 2021 16:59:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48D6061008
	for <linux-cxl@archiver.kernel.org>; Wed, 11 Aug 2021 16:59:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbhHKRAG (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 11 Aug 2021 13:00:06 -0400
Received: from mga07.intel.com ([134.134.136.100]:7946 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229484AbhHKRAF (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Wed, 11 Aug 2021 13:00:05 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10073"; a="278919212"
X-IronPort-AV: E=Sophos;i="5.84,313,1620716400"; 
   d="scan'208";a="278919212"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2021 09:59:41 -0700
X-IronPort-AV: E=Sophos;i="5.84,313,1620716400"; 
   d="scan'208";a="469472103"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2021 09:59:39 -0700
Received: from andy by smile with local (Exim 4.94.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mDrZl-008JWR-Az; Wed, 11 Aug 2021 19:59:33 +0300
Date:   Wed, 11 Aug 2021 19:59:33 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev,
        Jonathan.Cameron@huawei.com, ben.widawsky@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        ira.weiny@intel.com
Subject: Re: [PATCH 10/23] libnvdimm/labels: Add uuid helpers
Message-ID: <YRQB9Yvh3tmT9An4@smile.fi.intel.com>
References: <162854806653.1980150.3354618413963083778.stgit@dwillia2-desk3.amr.corp.intel.com>
 <162854812073.1980150.8157116233571368158.stgit@dwillia2-desk3.amr.corp.intel.com>
 <YROE48iCZNFaDcSo@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YROE48iCZNFaDcSo@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, Aug 11, 2021 at 11:05:55AM +0300, Andy Shevchenko wrote:
> On Mon, Aug 09, 2021 at 03:28:40PM -0700, Dan Williams wrote:
> > In preparation for CXL labels that move the uuid to a different offset
> > in the label, add nsl_{ref,get,validate}_uuid(). These helpers use the
> > proper uuid_t type. That type definition predated the libnvdimm
> > subsystem, so now is as a good a time as any to convert all the uuid
> > handling in the subsystem to uuid_t to match the helpers.
> > 
> > As for the whitespace changes, all new code is clang-format compliant.
> 
> Thanks, looks good to me!
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Sorry, I'm in doubt this Rb stays. See below.

...

> >  struct btt_sb {
> >  	u8 signature[BTT_SIG_LEN];
> > -	u8 uuid[16];
> > -	u8 parent_uuid[16];
> > +	uuid_t uuid;
> > +	uuid_t parent_uuid;

uuid_t type is internal to the kernel. This seems to be an ABI?

> >  	__le32 flags;
> >  	__le16 version_major;
> >  	__le16 version_minor;

...

> >  struct nd_namespace_label {
> > -	u8 uuid[NSLABEL_UUID_LEN];
> > +	uuid_t uuid;

So seems this.

> >  	u8 name[NSLABEL_NAME_LEN];
> >  	__le32 flags;
> >  	__le16 nlabel;

...

I'm not familiar with FS stuff, but looks to me like unwanted changes.
In such cases you have to use export/import APIs. otherwise you make the type
carved in stone without even knowing that it's part of an ABI or some hardware
/ firmware interfaces.

-- 
With Best Regards,
Andy Shevchenko


