Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F2C4C77B72
	for <linux-cxl@archiver.kernel.org>; Fri, 14 Apr 2023 21:49:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbjDNVtr (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 14 Apr 2023 17:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbjDNVtq (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 14 Apr 2023 17:49:46 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F302D51
        for <linux-cxl@vger.kernel.org>; Fri, 14 Apr 2023 14:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681508980; x=1713044980;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FhKO7rTM+SbgKoY76JOa2b2LKYRr/ZhSQJSbhxMo0U0=;
  b=JkwlXr4ElI67cA1XVOCJYUjfQFDNcx82yUY7xY5th6fzjYDdw0C04MdB
   osi+pgFR6Z6f+CegIFeT6fx+wudRRQz1ujlbAv65jVpSDgTvCHEcMKTw8
   HZyqrXU5ZfeN7b3wb68CvRC8/HFrgtNbID0cf0hB1cVchDT1hhqhxhLnZ
   ZVlqzPNP3YN79wKLH7r/6FiLkUU/MHbZ2h9FNPwbDZN5VRyYhJbIkOyHF
   HO4ruOHvzjo23BEkoVf8yx8xpKBdBD60nQ7XYMflX10JmoxIjtDRy1E9F
   7ybEN6CJNSKDFPP/EN/VYd8VW5wq6lC5hoUBJqdaPvJkqqhJqYx/3BNFO
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10680"; a="343333867"
X-IronPort-AV: E=Sophos;i="5.99,198,1677571200"; 
   d="scan'208";a="343333867"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2023 14:49:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10680"; a="779342284"
X-IronPort-AV: E=Sophos;i="5.99,198,1677571200"; 
   d="scan'208";a="779342284"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.22.80])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2023 14:49:40 -0700
Date:   Fri, 14 Apr 2023 14:49:38 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     vishal.l.verma@intel.com, linux-cxl@vger.kernel.org
Subject: Re: [NDCTL PATCH 0/3] ndctl: Add support of QoS Throttling Group
 (QTG) id for CXL CLI
Message-ID: <ZDnKciEJe80+2yrz@aschofie-mobl2>
References: <168149412855.4013891.16386221304030694671.stgit@djiang5-mobl3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <168149412855.4013891.16386221304030694671.stgit@djiang5-mobl3>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, Apr 14, 2023 at 10:42:55AM -0700, Dave Jiang wrote:
> The series adds support for the kernel enabling [1] of QoS Throttling Group
> (QTG) id. The kernel exports a QTG id for the root decoders (CFMWS) and as
> well as for the CXL memory devices. The QTG id exported for a device is
> calculated by the driver during device probe. Currently a QTG id is exported
> for the volatile partition and another for the persistent partition. In the
> future QTG id(s) will be exported for DCD regions. Display of QTG id is
> through the CXL CLI list command.
> 
> A QTG id check as also been added for region creation. A warning is emitted
> when the QTG id of a memory range of a CXL memory device being included in
> the CXL region assembly does not match the QTG id of the root decoder. Options
> are available to suppress the warning or to fail the region creation. This
> enabling provides a guidance on flagging memory ranges being used is not
> optimal for performance for the CXL region to be formed.

Can you cut/paste me some cxl list sample output?  I'm not going to be
trying this out to review.

Thanks!


> 
> [1]: https://lore.kernel.org/linux-cxl/168088732996.1441063.10107817505475386072.stgit@djiang5-mobl3/T/#t
> 
> ---
> 
> Dave Jiang (3):
>       ndctl: Add QTG ID support for the root decoder
>       ndctl: Add QTG ID support for the memory device
>       ndctl: add QTG ID check for region creation
> 
> 
>  Documentation/cxl/cxl-create-region.txt |  9 ++++
>  cxl/json.c                              | 22 +++++++++-
>  cxl/lib/libcxl.c                        | 31 ++++++++++++++
>  cxl/lib/libcxl.sym                      |  3 ++
>  cxl/lib/private.h                       |  3 ++
>  cxl/libcxl.h                            |  5 +++
>  cxl/region.c                            | 57 ++++++++++++++++++++++++-
>  7 files changed, 128 insertions(+), 2 deletions(-)
> 
> --
> 
