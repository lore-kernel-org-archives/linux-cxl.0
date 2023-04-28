Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 223AFC77B61
	for <linux-cxl@archiver.kernel.org>; Fri, 28 Apr 2023 16:05:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbjD1QF1 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 28 Apr 2023 12:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjD1QF0 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 28 Apr 2023 12:05:26 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A6202709
        for <linux-cxl@vger.kernel.org>; Fri, 28 Apr 2023 09:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682697925; x=1714233925;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9IumtC2lonueo4e5OqEqYNIk1+cvaDY+u/lw9h39ob0=;
  b=RmVkdk+t1NAFCQkaeBoY7Wc1pGsLk+cwteZ6GOa+s14SAgQ1nlj85UrF
   mSlk5ol9FSfF/xzTdogoBfVKT3Llkf2jRpTwhrnwQah/eZDZUCG9pOXdN
   YT9XR1zbtV+Ddhm7vrZR+/qCML4ldL7cCJXt1sce/l/zI4MsyJSM8d9Uj
   A4dfLCxkZq71QmfBT4HziDb+3vFOnVicMbu4Av+WCi1dcNwQYkNLyVfHu
   jw6pEfCs+zBuJQPt7vuxoRPRYMjeWu5+nOLVTl2jyCJLkOS2itMqTnGDy
   qnQuo623yUsvtoCjbednFRP15Cy3LN6XGA2H+Rte1MwkDFqa0PlxfqkQ1
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10694"; a="350696728"
X-IronPort-AV: E=Sophos;i="5.99,235,1677571200"; 
   d="scan'208";a="350696728"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2023 09:05:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10694"; a="672236379"
X-IronPort-AV: E=Sophos;i="5.99,235,1677571200"; 
   d="scan'208";a="672236379"
Received: from egliskay-mobl.amr.corp.intel.com (HELO [10.212.108.170]) ([10.212.108.170])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2023 09:05:18 -0700
Message-ID: <aa9e8e29-3682-a226-8e1b-ccfb0071c327@intel.com>
Date:   Fri, 28 Apr 2023 09:05:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.0
Subject: Re: [PATCH 3/4] test: Support test modules located in 'updates'
 instead of 'extra'
Content-Language: en-US
To:     Dan Williams <dan.j.williams@intel.com>, vishal.l.verma@intel.com
Cc:     linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev
References: <168236637159.1027628.7560967008080605819.stgit@dwillia2-xfh.jf.intel.com>
 <168236638863.1027628.11883188611397194858.stgit@dwillia2-xfh.jf.intel.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <168236638863.1027628.11883188611397194858.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 4/24/23 12:59 PM, Dan Williams wrote:
> Since kernel commit:
> 
> b74d7bb7ca24 ("kbuild: Modify default INSTALL_MOD_DIR from extra to updates")
> 
> ...the kernel build process deposits the nfit_test can cxl_test modules in

s/can/and/ ?

> /lib/modules/$KVER/updates. This is more widely supported across multiple
> distributions as a default override for modules that ship in their native
> directory.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>   test/core.c |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/test/core.c b/test/core.c
> index 5d1aa23723f1..a354f41dcba0 100644
> --- a/test/core.c
> +++ b/test/core.c
> @@ -209,7 +209,7 @@ retry:
>   			break;
>   		}
>   
> -		if (!strstr(path, "/extra/")) {
> +		if (!strstr(path, "/extra/") && !strstr(path, "/updates/")) {
>   			log_err(&log_ctx, "%s.ko: appears to be production version: %s\n",
>   					name, path);
>   			break;
> 
> 
