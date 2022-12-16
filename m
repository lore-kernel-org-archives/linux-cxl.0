Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BD3DC4332F
	for <linux-cxl@archiver.kernel.org>; Fri, 16 Dec 2022 04:08:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbiLPEIX (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 15 Dec 2022 23:08:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbiLPEIT (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 15 Dec 2022 23:08:19 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 450B0511EA
        for <linux-cxl@vger.kernel.org>; Thu, 15 Dec 2022 20:08:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671163698; x=1702699698;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=06RJpBRepxeaP0t6sFrFAdP8W3611qLjxRUrMcQa+es=;
  b=C/NjcgLbvX+XOwpAPh8iLU9D884le4kVOWFJWLsq1QfHidOpCkJrXIdn
   xMjkcoRV08HQRla3yvfmL0ayPmRJuL+pHyVXtUbXF6cHtW6xMAwuHnw4D
   oKv5ZSUb08OChldJ+XmWFsEsh7tc1RDmFVekuLzzYumOI2yJzwTNkwmWE
   hADWlygyNsY9PjCMifyQjs16zbo1zYN/Y0VAvmNpWAi82tZJ3Bb02CIVN
   eXGHH0kxZ8RgFpcdBUVc2QSdRDRkh3MWPcwMLCTvC0bcgDLRW9C7fEhH0
   DZT1Z13qnUVf1wV18+00fdNQAy0jfqi2EZSOsvEXXr3qd6lui+eCHONRE
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10562"; a="320761013"
X-IronPort-AV: E=Sophos;i="5.96,249,1665471600"; 
   d="scan'208";a="320761013"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2022 20:08:17 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10562"; a="713153471"
X-IronPort-AV: E=Sophos;i="5.96,249,1665471600"; 
   d="scan'208";a="713153471"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.251.5.82])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2022 20:08:17 -0800
Date:   Thu, 15 Dec 2022 20:08:15 -0800
From:   Alison Schofield <alison.schofield@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     vishal.l.verma@intel.com, linux-cxl@vger.kernel.org
Subject: Re: [PATCH 1/2] cxl/region: Fix memdev_filter_pos() memory leak
Message-ID: <Y5vvLwgrafOGk7Jd@aschofie-mobl2>
References: <167106802682.1326377.13483249974201112428.stgit@dwillia2-xfh.jf.intel.com>
 <167106803234.1326377.5020851858779774338.stgit@dwillia2-xfh.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <167106803234.1326377.5020851858779774338.stgit@dwillia2-xfh.jf.intel.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, Dec 14, 2022 at 05:33:52PM -0800, Dan Williams wrote:
> Arrange to free the temporary duplicate of @_csv in all exit paths. Just
> share a common exit path.
> 

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  cxl/region.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/cxl/region.c b/cxl/region.c
> index 15cac64a158c..2202afa440ef 100644
> --- a/cxl/region.c
> +++ b/cxl/region.c
> @@ -183,7 +183,7 @@ static int memdev_filter_pos(struct json_object *jobj, const char *_csv)
>  	for (pos = 0, arg = strtok_r(csv, which_sep(csv), &save); arg;
>  	     arg = strtok_r(NULL, which_sep(csv), &save), pos++)
>  		if (util_cxl_memdev_filter(memdev, arg, NULL))
> -			return pos;
> +			break;
>  	free(csv);
>  
>  	return pos;
> 
