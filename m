Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 361B1C4332F
	for <linux-cxl@archiver.kernel.org>; Fri, 16 Dec 2022 04:06:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbiLPEGt (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 15 Dec 2022 23:06:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbiLPEGs (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 15 Dec 2022 23:06:48 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FCA036D60
        for <linux-cxl@vger.kernel.org>; Thu, 15 Dec 2022 20:06:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671163607; x=1702699607;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cF/DKAodr45aEMhQNS5sv8L1NFjnCUBZVqhU/aOUTCc=;
  b=Sq3iuvR+hIanTFhykeN1v2GjNiLqrsK8Yfhn9rlQ1f6fUvwCH/ebAEmp
   xDOy2sCStLQ8NCmeMGAx/RWmdBKLy3C9NzJ3OK9KCev/2g3wHgJcf6yhL
   pZk9BIHhlGQT1aKYPM5hu4AGRW682YI3sejBu3+wo1iJkJ6je02rwgJFf
   E1uTpf56Tshjl3U9WkcocuPBBckDr34xMKynBAaQtyWbC7tr+qTfV+FDv
   vntMHp8odJhQwQOb8KxY2/JEN9LfwYpaNyLH2CREM1Vb+X4/xZqVY5/44
   0CTF3/UN331NiGtccxXvhi4gLeHpXyCDTU3VduSIveIWJg3vY6QqozXJ2
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10562"; a="405138019"
X-IronPort-AV: E=Sophos;i="5.96,249,1665471600"; 
   d="scan'208";a="405138019"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2022 20:06:47 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10562"; a="649675332"
X-IronPort-AV: E=Sophos;i="5.96,249,1665471600"; 
   d="scan'208";a="649675332"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.251.5.82])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2022 20:06:46 -0800
Date:   Thu, 15 Dec 2022 20:06:45 -0800
From:   Alison Schofield <alison.schofield@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     vishal.l.verma@intel.com, Luis Chamberlain <mcgrof@kernel.org>,
        linux-cxl@vger.kernel.org
Subject: Re: [PATCH 2/2] cxl/region: Fix memdev_filter_pos() separator
 detection
Message-ID: <Y5vu1QLspa+Lpucq@aschofie-mobl2>
References: <167106802682.1326377.13483249974201112428.stgit@dwillia2-xfh.jf.intel.com>
 <167106803771.1326377.10608704295797398750.stgit@dwillia2-xfh.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <167106803771.1326377.10608704295797398750.stgit@dwillia2-xfh.jf.intel.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, Dec 14, 2022 at 05:33:57PM -0800, Dan Williams wrote:
> Stop using the modified version of the @_csv as the string to determine
> the separator it may cause which_sep() to get different answers each
> iteration. Moreover there is no need to retrieve the separator each
> iteration, so just retrieve it once from @_csv.
> 
> If the separator is mismatched it can lead to the sort not following the
> specified device order for create-region.
> 

Tested-by: Alison Schofield <alison.schofield@intel.com>

> Reported-by: Luis Chamberlain <mcgrof@kernel.org>
> Link: https://gist.github.com/mcgrof/aeac639365a651bd77f143cf38eb7493
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  cxl/region.c |    5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/cxl/region.c b/cxl/region.c
> index 2202afa440ef..bb3a10a7713c 100644
> --- a/cxl/region.c
> +++ b/cxl/region.c
> @@ -172,6 +172,7 @@ static struct sort_context {
>  static int memdev_filter_pos(struct json_object *jobj, const char *_csv)
>  {
>  	struct cxl_memdev *memdev = json_object_get_userdata(jobj);
> +	const char *sep = which_sep(_csv);
>  	char *csv, *save;
>  	const char *arg;
>  	int pos;
> @@ -180,8 +181,8 @@ static int memdev_filter_pos(struct json_object *jobj, const char *_csv)
>  	if (!csv)
>  		return -1;
>  
> -	for (pos = 0, arg = strtok_r(csv, which_sep(csv), &save); arg;
> -	     arg = strtok_r(NULL, which_sep(csv), &save), pos++)
> +	for (pos = 0, arg = strtok_r(csv, sep, &save); arg;
> +	     arg = strtok_r(NULL, sep, &save), pos++)
>  		if (util_cxl_memdev_filter(memdev, arg, NULL))
>  			break;
>  	free(csv);
> 
