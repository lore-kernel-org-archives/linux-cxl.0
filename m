Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6677C00140
	for <linux-cxl@archiver.kernel.org>; Fri, 12 Aug 2022 04:33:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbiHLEdH (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 12 Aug 2022 00:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236879AbiHLEdG (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 12 Aug 2022 00:33:06 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCB929E13D
        for <linux-cxl@vger.kernel.org>; Thu, 11 Aug 2022 21:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660278784; x=1691814784;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DSrE2YOKHIge3c1ksJc4Ydbztcu8ft8C7p4foF8I/JE=;
  b=Ts8Ngo+dFojnE7RIv+lyTW8KREBbFogtX3VrTed82E+KagKXe9twPjly
   jXfnZxJjT++HNQmMLm7ENYZnQhHczaI2STTTXRN0sFdmEJH2WWhQPSXL7
   2zQAQS8j72ZZA5IPYLmmuNBpU6Sd0EuoD3f7aOjxTBjMx+U1dLOcuxus2
   nEhylnkI0Q0SM2Gbr3JbNwFCSkRU+W6oOOiSyJFvRfX//nfUCB1KnGZ0Q
   P7XaxChZY38LXWX81/0ndLyqOj6V6wTqePYB349nzuSoL466u79GNAuUz
   ym6kM5xcLve9ev86+RXjZwVpux5CcwJBZ4MaKfNiVZsYs2nNrLmTjiThJ
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10436"; a="317487172"
X-IronPort-AV: E=Sophos;i="5.93,231,1654585200"; 
   d="scan'208";a="317487172"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2022 21:33:03 -0700
X-IronPort-AV: E=Sophos;i="5.93,231,1654585200"; 
   d="scan'208";a="556394887"
Received: from alison-desk.jf.intel.com (HELO alison-desk) ([10.54.74.41])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2022 21:33:03 -0700
Date:   Thu, 11 Aug 2022 21:30:40 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        "Verma, Vishal L" <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        "Jiang, Dave" <dave.jiang@intel.com>
Cc:     "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] CXL XOR Interleave Arithmetic
Message-ID: <20220812043040.GA1767528@alison-desk>
References: <cover.1660250360.git.alison.schofield@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1660250360.git.alison.schofield@intel.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, Aug 11, 2022 at 01:49:10PM -0700, Schofield, Alison wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> Changes in v2:
> - Use ilog2() of the decoded interleave ways to determine number
> of xormaps, instead of using encoded ways directly. This fixes
> 3, 6, and 12 way interleaves. (Dan)
> 

Dan - Thanks for the message about this breaking 3-6-12.
New version in the works.

> 
> Add support for the new 'XOR' Interleave Arithmetic as defined
> in the CXL 3.0 Specification [1].
> 
> A linux-ized ACPI patch is included here for reference. The actual
> pull request is pending at https://github.com/acpica/acpica/pull/787
> 
> [1]: https://www.computeexpresslink.org/download-the-specification
> 
> 
> Alison Schofield (2):
>   For ACPICA: Add the CXIMS structure definition to the CEDT table
>   cxl/acpi: Support CXL XOR Interleave Math (CXIMS)
> 
>  include/acpi/actbl1.h | 14 ++++++-
>  drivers/cxl/cxl.h     |  2 +
>  drivers/cxl/acpi.c    | 94 ++++++++++++++++++++++++++++++++++++++++---
>  3 files changed, 104 insertions(+), 6 deletions(-)
> 
> 
> base-commit: 1cd8a2537eb07751d405ab7e2223f20338a90506
> -- 
> 2.31.1
> 
