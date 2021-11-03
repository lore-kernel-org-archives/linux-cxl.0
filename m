Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86114C433F5
	for <linux-cxl@archiver.kernel.org>; Wed,  3 Nov 2021 22:34:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50515610FD
	for <linux-cxl@archiver.kernel.org>; Wed,  3 Nov 2021 22:34:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbhKCWgy (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 3 Nov 2021 18:36:54 -0400
Received: from mga01.intel.com ([192.55.52.88]:60761 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229618AbhKCWgy (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Wed, 3 Nov 2021 18:36:54 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10157"; a="255248651"
X-IronPort-AV: E=Sophos;i="5.87,207,1631602800"; 
   d="scan'208";a="255248651"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2021 15:34:17 -0700
X-IronPort-AV: E=Sophos;i="5.87,207,1631602800"; 
   d="scan'208";a="729796950"
Received: from chungyus-mobl.amr.corp.intel.com (HELO intel.com) ([10.252.137.219])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2021 15:34:14 -0700
Date:   Wed, 3 Nov 2021 15:34:13 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     "Weiny, Ira" <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        linux-cxl@vger.kernel.org
Subject: Re: [PATCH] cxl/cxlmem: Remove unused cxlmd field
Message-ID: <20211103223413.n6fmf3gtop56wssz@intel.com>
References: <CAPcyv4hcgh2gb8qsS_UXTBSGqYfMPnC6p5kkvNUjm+V6kVKM5g@mail.gmail.com>
 <20211103204103.3687550-1-ira.weiny@intel.com>
 <CAPcyv4gQeZ6PUQswGe61Vd7u0qXOEL8V9Bp0FMJxfj480yh=LA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4gQeZ6PUQswGe61Vd7u0qXOEL8V9Bp0FMJxfj480yh=LA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 21-11-03 15:13:21, Dan Williams wrote:
> On Wed, Nov 3, 2021 at 1:41 PM <ira.weiny@intel.com> wrote:
> >
> > From: Ira Weiny <ira.weiny@intel.com>
> >
> > This field was left over when the connection between the cxl_memdev and
> > cxl_mem was tighter.  It is no longer set nor used so remove it.[1]
> >
> > [1] https://lore.kernel.org/linux-cxl/CAPcyv4hcgh2gb8qsS_UXTBSGqYfMPnC6p5kkvNUjm+V6kVKM5g@mail.gmail.com/
> 
> Looks good, although I'll probably fixup the subject to:
> 
>     cxl/memdev: Remove unused cxlmd field
> 
> ...to start to standardize on a prefix format of
> cxl/$(infrastructure_area/C file name). Previous commits used
> "cxl/mem:", but I think going forward that prefix can be used for
> changes related to the driver in "cxl_mem.ko". Where "cxl/memdev:" is
> for changes related to the base 'struct cxl_memdev' infrastructure.
> 
> The only reason that drivers/cxl/cxlmem.h has that redundant mention
> of "cxl" in filename is to avoid collisions with
> "arch/um/include/shared/mem.h" on ARCH=um builds. So "cxl/cxlmem:"
> triggered my naming finickiness.

I agree with the subject fixup, and patch is:
Acked-by: Ben Widawsky <ben.widawsky@intel.com>

I think there can be cases made for when it might not be a specific C file that
is in the subject, but this isn't one of them.
