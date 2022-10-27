Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14AECC38A2D
	for <linux-cxl@archiver.kernel.org>; Thu, 27 Oct 2022 04:26:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233692AbiJ0E0o (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 27 Oct 2022 00:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232906AbiJ0E0n (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 27 Oct 2022 00:26:43 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5702562A88
        for <linux-cxl@vger.kernel.org>; Wed, 26 Oct 2022 21:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666844802; x=1698380802;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zTQM0f6NEkj/Av1AzWY58Tp52CHR7zs1bSEV4Ak6i3o=;
  b=YTkyyy/wRgIZIvG4waAnNK3XBVZ6pDfj8FdDI3LIx9PWcNEuzY8avtRt
   zdTSdtTpb8VBcrQKpVfi94I4pexcj7swecsB0f5e3my0fq+7DNLtV2525
   FHcFt+r9tHI7p0EJD7YXnl5+wtZ5u6m53d2QyZ5gAgpuhoEPKXhTH5TIH
   weE9FV71voJjCCeTugUhvgMr7hITCpYUB5VRdO1zjPPVkeDcDbqyP6mkr
   vDFwjDchmh9ov9ZqBOZ7jRvlnXhhUtbXBIkS1l4Wr/LXSQC0bwTzP0U/w
   N20+G2oJ2bEzbjnIM2iF/6Ro5xbk0t9SDiY4BA7FhrARjkCSGLnIhcPN4
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10512"; a="334753340"
X-IronPort-AV: E=Sophos;i="5.95,215,1661842800"; 
   d="scan'208";a="334753340"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2022 21:26:39 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10512"; a="632264841"
X-IronPort-AV: E=Sophos;i="5.95,215,1661842800"; 
   d="scan'208";a="632264841"
Received: from haffner-mobl.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.93.244])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2022 21:26:39 -0700
Date:   Wed, 26 Oct 2022 21:26:37 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>
Cc:     linux-cxl@vger.kernel.org
Subject: Re: [PATCH v5 0/3] CXL XOR Interleave Arithmetic
Message-ID: <Y1oIfSLoTcEEDLTX@aschofie-mobl2>
References: <cover.1666841669.git.alison.schofield@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1666841669.git.alison.schofield@intel.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, Oct 26, 2022 at 09:07:40PM -0700, alison.schofield@intel.com wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> Changes in v5:

  - Rebase to 6.1-rc2

> - Add to 'n' for 6 & 12 way. (v3->v4 broke it)
> - Clean up x3 index init. (Dan)
> - Remove unneeded HB's from cxl_test topology.
> - Remove dependency on stale patch in cxl_test.
> 
> Changes in v4:
> - Use GENMASK_ULL to fix i386 arch build (0-day)
> - Use do_div to fix ARM arch build (0-day)
> - Update comments in ACPICA patch to reflect new state of the
>   ACPICA patch - pending again in github.
> 
> Changes in v3:
> - Fix the 3, 6, 12 way interleave (again).
> - Do not look for a CXIMS when not needed for x1 & x3 interleaves
> - New cxl_test patch: Add cxl_test module support for this feature
> - In a separate ndctl patch, cxl test: cxl_xor_region is added
> 
> Changes in v2:
> - Use ilog2() of the decoded interleave ways to determine number
>   of xormaps, instead of using encoded ways directly. This fixes
>   3, 6, and 12 way interleaves. (Dan)
> 
> Add support for the new 'XOR' Interleave Arithmetic as defined
> in the CXL 3.0 Specification:
> https://www.computeexpresslink.org/download-the-specification
> 
> 
> Alison Schofield (2):
>   For ACPICA: Add the CXIMS structure definition to the CEDT table
>   cxl/acpi: Support CXL XOR Interleave Math (CXIMS)
>   tools/testing/cxl: Add XOR Math support to cxl_test
> 
>  drivers/cxl/acpi.c           | 129 +++++++++++++++++++++++++++++++++--
>  drivers/cxl/cxl.h            |   2 +
>  include/acpi/actbl1.h        |  14 +++-
>  tools/testing/cxl/test/cxl.c | 118 +++++++++++++++++++++++++++++++-
>  4 files changed, 254 insertions(+), 9 deletions(-)
> 
> -- 
> 2.37.3
> 
