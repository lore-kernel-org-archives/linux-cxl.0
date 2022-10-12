Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0087EC433FE
	for <linux-cxl@archiver.kernel.org>; Wed, 12 Oct 2022 01:18:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbiJLBSc (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 11 Oct 2022 21:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiJLBSb (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 11 Oct 2022 21:18:31 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C769B5303C
        for <linux-cxl@vger.kernel.org>; Tue, 11 Oct 2022 18:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665537510; x=1697073510;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jdnDNd+7jzmdcy2OiWfqKC4bMtxctuDn5DpwQX55+tA=;
  b=ZOWLdPS6+ciHK3d1D/JG24nHtj9INww9D4omOd21GqwPL3mVufGVUu6N
   Nvf1saAik686paH/6p84faqmDuA5eZbnYrqwTmPLpadKqvSt5ZY3gUVYS
   DzmVDS4zfk3lj38lQSNcSu/XC0RiuYhqpVMCC2e/b9xgjlIUsE07QYuje
   r6TG4bp+JCMJI2miX6vm4yvbirdW//d/79Jkyd9XfQY80dqUf3jJbjnQG
   rRDRcz3gRFK3UGGPA6stCnq8AhjlM3ws6spU8hY2yhluxtDFewGgnVox4
   LylqoDnOhB2KhC/rHl5tlUI47dj6GHNN7OZD4+ym4Qbzjj36DW6mkPJ1m
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10497"; a="285048351"
X-IronPort-AV: E=Sophos;i="5.95,177,1661842800"; 
   d="scan'208";a="285048351"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2022 18:18:30 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10497"; a="689465237"
X-IronPort-AV: E=Sophos;i="5.95,177,1661842800"; 
   d="scan'208";a="689465237"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.98.149])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2022 18:18:30 -0700
Date:   Tue, 11 Oct 2022 18:18:28 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     linux-cxl@vger.kernel.org, dan.j.williams@intel.com,
        ira.weiny@intel.com, vishal.l.verma@intel.com
Subject: Re: [PATCH] cxl: update var names for interleave ways conversion
 macros
Message-ID: <Y0YV5G0TSG3zwKnB@aschofie-mobl2>
References: <166552461397.1940763.17766745890158322847.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <166552461397.1940763.17766745890158322847.stgit@djiang5-desk3.ch.intel.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, Oct 11, 2022 at 02:43:33PM -0700, Dave Jiang wrote:
> Change var names for interleave ways macros to clearly indicate which
> variable is encoded and which is the actual ways value.
> 
> iw == interleave ways
> eniw == encoded interleave ways
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/cxl.h |   22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 7a4f740d710c..c0d826084465 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -78,14 +78,14 @@ static inline int cxl_to_granularity(u16 enig, unsigned int *ig)
>  }
>  
>  /* Encode defined in CXL ECN "3, 6, 12 and 16-way memory Interleaving" */

Above comment can be updated:
CXL 8.2.4.19.7 CXL HDM Decoder n Control Register


> -static inline int cxl_to_ways(u8 eniw, unsigned int *val)
> +static inline int cxl_to_ways(u8 eniw, unsigned int *iw)
>  {
>  	switch (eniw) {
>  	case 0 ... 4:
> -		*val = 1 << eniw;
> +		*iw = 1 << eniw;
>  		break;
>  	case 8 ... 10:
> -		*val = 3 << (eniw - 8);
> +		*iw = 3 << (eniw - 8);
>  		break;
>  	default:
>  		return -EINVAL;
> @@ -102,20 +102,20 @@ static inline int granularity_to_cxl(int ig, u16 *enig)
>  	return 0;
>  }
>  
> -static inline int ways_to_cxl(unsigned int ways, u8 *iw)
> +static inline int ways_to_cxl(unsigned int iw, u8 *eniw)
>  {
> -	if (ways > 16)
> +	if (iw > 16)
>  		return -EINVAL;
> -	if (is_power_of_2(ways)) {
> -		*iw = ilog2(ways);
> +	if (is_power_of_2(iw)) {
> +		*eniw = ilog2(iw);
>  		return 0;
>  	}
> -	if (ways % 3)
> +	if (iw % 3)
>  		return -EINVAL;
> -	ways /= 3;
> -	if (!is_power_of_2(ways))
> +	iw /= 3;
> +	if (!is_power_of_2(iw))
>  		return -EINVAL;
> -	*iw = ilog2(ways) + 8;
> +	*eniw = ilog2(iw) + 8;
>  	return 0;
>  }
>  
> 
> 
