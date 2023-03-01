Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6C6EC64ED6
	for <linux-cxl@archiver.kernel.org>; Wed,  1 Mar 2023 15:47:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbjCAPrj (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 1 Mar 2023 10:47:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbjCAPrf (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 1 Mar 2023 10:47:35 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 323B04347D
        for <linux-cxl@vger.kernel.org>; Wed,  1 Mar 2023 07:47:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677685628; x=1709221628;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Iw21esphieu3bz/xeEOUKMSgq9gPnv+tzL10S7ujcEk=;
  b=QWx5QYI1i+gfwH23Z6Bgpzh77kJnHn3rpAt7E+FWrGQommkCKwMqiw3g
   PIDUCFPWhqcD2UfjuZ8apNB3l0D/oPmeNwMIzMFsnam8HPcY6vUSr1MIr
   7S8XLAZ06YYQw9q0+VSk3NyF3BGq3NdDgL4LUlCHmYRvNUznr69pV2GVA
   NuXLl+VTxdHaDPgkVP32lPDl/UGN/9UUxsP/1lWgQorW1lbtyLieNQa5s
   x4c1wrrOPKHfZcvMgtKr/Gao3Oz9WaMReRw8FxRRBbaNMNeP1+nCsUtbJ
   xWoeA6yV0MPSVDkl6eZXLkKmJ9ubzPJ8jBF/sEbVWqMpRMZb1VK7DcZS6
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="362022761"
X-IronPort-AV: E=Sophos;i="5.98,225,1673942400"; 
   d="scan'208";a="362022761"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 07:46:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="920294720"
X-IronPort-AV: E=Sophos;i="5.98,225,1673942400"; 
   d="scan'208";a="920294720"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP; 01 Mar 2023 07:46:43 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pXOfC-00DojM-1G;
        Wed, 01 Mar 2023 17:46:42 +0200
Date:   Wed, 1 Mar 2023 17:46:42 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-cxl@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
        linuxarm@huawei.com
Subject: Re: [PATCH] cxl/mbox: Drop extra struct resource cast
Message-ID: <Y/9zYlHETHByXRUz@smile.fi.intel.com>
References: <20230228152112.14774-1-Jonathan.Cameron@huawei.com>
 <Y/9zKXOKI1h2nvEI@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/9zKXOKI1h2nvEI@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, Mar 01, 2023 at 05:45:45PM +0200, Andy Shevchenko wrote:
> On Tue, Feb 28, 2023 at 03:21:12PM +0000, Jonathan Cameron wrote:
> > DEFINE_RES_MEM() is a wrapper around the DEFINE_RES_NAMED()
> > macro which already has the (struct resource) cast.
> 
> It's not a cast. As commit message that brought it says: "Converting it to be
> a compound literal..."

...

> > -	cxlds->dpa_res =
> > -		(struct resource)DEFINE_RES_MEM(0, cxlds->total_bytes);

FWIW, here it's also not a cast.

-- 
With Best Regards,
Andy Shevchenko


