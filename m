Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BBBEECAAD8
	for <linux-cxl@archiver.kernel.org>; Fri, 16 Sep 2022 16:27:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbiIPQ1q (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 16 Sep 2022 12:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiIPQ1q (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 16 Sep 2022 12:27:46 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE9BF8E440
        for <linux-cxl@vger.kernel.org>; Fri, 16 Sep 2022 09:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663345664; x=1694881664;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=csfU7e4bennr+mK+W7ypjZE/jPf6/BeNjlTitYbPekY=;
  b=EtM0Q41/PQQXi6FAfKCtpJBkjS09DabVp5htW8skDMIuR+ALw6b6l3Ko
   a//ZOxRDK4U58BtjVVSSfC/VcUtLcYdgslGYDq+lvm95k/vKYz5VADvjT
   RO617K9CDiLCb4eZfmWdM+2C87z3OG5TWEb0z92y9ssTtecaCEXlpWvM/
   ruGsi5sWLuUAkffdunzePfjMvXYtlqg7XNUhdLLltiSAfBk/1sV08tr0r
   Yf4RtdEDuEtr65PgwCahA5W5sXx4w9AS7gM3K8DVdseG6Oromnf2ZxDRK
   WSZmHYqudTp1JjMO6IsbecaSaF9TzCmnEfuMKyFLvYeCtO3S1pzYfUo4c
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10472"; a="279409820"
X-IronPort-AV: E=Sophos;i="5.93,320,1654585200"; 
   d="scan'208";a="279409820"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2022 09:26:51 -0700
X-IronPort-AV: E=Sophos;i="5.93,320,1654585200"; 
   d="scan'208";a="595303940"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.54.10])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2022 09:26:50 -0700
Date:   Fri, 16 Sep 2022 09:26:48 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>
Cc:     linux-cxl@vger.kernel.org
Subject: Re: [PATCH v3 2/3] cxl/acpi: Support CXL XOR Interleave Math (CXIMS)
Message-ID: <YySjyPtc0Oges2zH@aschofie-mobl2>
References: <cover.1663291370.git.alison.schofield@intel.com>
 <6cbe113e3aebc732d10cb77a316f547b581f22fa.1663291370.git.alison.schofield@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6cbe113e3aebc732d10cb77a316f547b581f22fa.1663291370.git.alison.schofield@intel.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, Sep 15, 2022 at 06:30:23PM -0700, alison.schofield@intel.com wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> When the CFMWS is using XOR math, parse the corresponding
> CXIMS structure and store the xormaps in the root decoder
> structure. Use the xormaps in a new lookup, cxl_hb_xor(),
> to find a targets entry in the host bridge interleave
> target list.
> 
> Defined in CXL Specfication 3.0 Section: 9.17.1
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> ---
>  drivers/cxl/cxl.h  |   2 +
>  drivers/cxl/acpi.c | 132 +++++++++++++++++++++++++++++++++++++++++++--
>  2 files changed, 129 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index f680450f0b16..0a17a7007bff 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -330,12 +330,14 @@ struct cxl_switch_decoder {
>   * @res: host / parent resource for region allocations
>   * @region_id: region id for next region provisioning event
>   * @calc_hb: which host bridge covers the n'th position by granularity
> + * @platform_data: platform specific configuration data
>   * @cxlsd: base cxl switch decoder
>   */
>  struct cxl_root_decoder {
>  	struct resource *res;
>  	atomic_t region_id;
>  	struct cxl_dport *(*calc_hb)(struct cxl_root_decoder *cxlrd, int pos);
> +	void *platform_data;
>  	struct cxl_switch_decoder cxlsd;
>  };
>  
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index fb649683dd3a..3ff0fd6e3e93 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -9,6 +9,106 @@
>  #include "cxlpci.h"
>  #include "cxl.h"
>  
> +struct cxims_data {
> +	int nr_maps;
> +	u64 xormaps[];
> +};
> +
> +/*
> + * Find a targets entry (n) in the host bridge interleave list.
> + * CXL Specfication 3.0 Table 9-22
> + */
> +static struct cxl_dport *cxl_hb_xor(struct cxl_root_decoder *cxlrd, int pos)
> +{
> +	struct cxl_switch_decoder *cxlsd = &cxlrd->cxlsd;
> +	struct cxims_data *cximsd = cxlrd->platform_data;
> +	struct cxl_decoder *cxld = &cxlsd->cxld;
> +	int ig = cxld->interleave_granularity;
> +	int iw = cxld->interleave_ways;
> +	int i, eiw, n = 0;
> +	u64 hpa, mask;
> +
> +	if (dev_WARN_ONCE(&cxld->dev,
> +			  cxld->interleave_ways != cxlsd->nr_targets,
> +			  "misconfigured root decoder\n"))
> +		return NULL;
> +
> +	if (iw == 1)
> +		/* Entry is always 0 for no interleave */
> +		return cxlrd->cxlsd.target[0];
> +
> +	hpa = cxlrd->res->start + pos * ig;
> +
> +	if (iw == 3) {
> +		/* Initialize 'i' for the modulo calc */
> +		i = 0;
> +		goto no_map;
> +	}
> +
> +	/* IW: 2,4,6,8,12,16 begin building 'n' using xormaps */
> +	for (i = 0; i < cximsd->nr_maps; i++)
> +		n |= (hweight64(hpa & cximsd->xormaps[i]) & 1) << i;
> +
> +no_map:
> +	/* IW: 3,6,12 add a modulo calculation to 'n' */
> +	if (!is_power_of_2(iw)) {
> +		eiw = ilog2(iw / 3) + 8;
> +		mask = GENMASK(51, eiw + ig);

lkp i386 build warned:
>> drivers/cxl/acpi.c:56:10: warning: shift count is negative
+[-Wshift-count-negative]
                   mask = GENMASK(51, eiw + ig);
                          ^~~~~~~~~~~~~~~~~~~~~

Will change to GENMASK_ULL.

> +		n |= (hpa & mask) % 3 << i;
> +	}
> +
> +	return cxlrd->cxlsd.target[n];
> +}

snip

> +
> 
