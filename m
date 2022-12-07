Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81356C3A5A7
	for <linux-cxl@archiver.kernel.org>; Wed,  7 Dec 2022 01:12:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbiLGBMm (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 6 Dec 2022 20:12:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbiLGBMl (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 6 Dec 2022 20:12:41 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8525B1D
        for <linux-cxl@vger.kernel.org>; Tue,  6 Dec 2022 17:12:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670375560; x=1701911560;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tTDolpY4Ce7RQrse+cbawkAa49rrImTGPAZ8Jd/hQ4E=;
  b=MwhUrU2bHjKck02MtHFM85YZ9wbixqcCRWiN7PZudlStYoeP0kh2+hOi
   YWKHJuCEYJCu43h95hQjzeVNuhMGQVmNDAK2KB1iv9MTdVbeul4ti0Nxx
   Ud/JMoaV3Vh8PNovDVcsALvx5d/DSDoOGDNBl5OkbDiRFh6pX8KFzVmek
   usvwwhDZTXXbp1V5y9fJd9sioRJ5EOYB11x+dcw9djudvwUqSzvgtxMe1
   ShX09IodJkVIDDj1aa7Dlr/Na/Y+nJMr4/AZe3DW2dog32eCAvAKPMYh1
   uG2Is2yOrVMYSVBNCypyxXPzlD4sAR21rzBofgQOE45tvTBw4o+gL6wns
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="317916739"
X-IronPort-AV: E=Sophos;i="5.96,223,1665471600"; 
   d="scan'208";a="317916739"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2022 17:12:36 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="709877452"
X-IronPort-AV: E=Sophos;i="5.96,223,1665471600"; 
   d="scan'208";a="709877452"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.118.190])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2022 17:12:35 -0800
Date:   Tue, 6 Dec 2022 17:12:33 -0800
From:   Alison Schofield <alison.schofield@intel.com>
To:     Vishal Verma <vishal.l.verma@intel.com>
Cc:     nvdimm@lists.linux.dev, Dan Williams <dan.j.williams@intel.com>,
        linux-cxl@vger.kernel.org
Subject: Re: [PATCH ndctl 1/2] clang-format: Align consecutive macros and
 #defines
Message-ID: <Y4/ogRA0SybTSQ0p@aschofie-mobl2>
References: <20221206-vv-misc-v1-0-4c5bd58c90ca@intel.com>
 <20221206-vv-misc-v1-1-4c5bd58c90ca@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221206-vv-misc-v1-1-4c5bd58c90ca@intel.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, Dec 06, 2022 at 03:46:23PM -0700, Vishal Verma wrote:
> Add AlignConsecutiveMacros: true so that blocks of consecutive #defines
> can be neatly aligned.
> 
> Cc: Dan Williams <dan.j.williams@intel.com>
> Reported-by: Alison Schofield <alison.schofield@intel.com>
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
> ---

Thanks Vishal!
Reviewed-by: Alison Schofield <alison.schofield@intel.com>


>  .clang-format | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/.clang-format b/.clang-format
> index b6169e1..9ea49bf 100644
> --- a/.clang-format
> +++ b/.clang-format
> @@ -13,6 +13,7 @@ AccessModifierOffset: -4
>  AlignAfterOpenBracket: Align
>  AlignConsecutiveAssignments: false
>  AlignConsecutiveDeclarations: false
> +AlignConsecutiveMacros: true
>  #AlignEscapedNewlines: Left # Unknown to clang-format-4.0
>  AlignOperands: true
>  AlignTrailingComments: false
> 
> -- 
> 2.38.1
