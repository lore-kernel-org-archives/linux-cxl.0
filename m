Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB4C3EB64DA
	for <linux-cxl@archiver.kernel.org>; Fri,  7 Jul 2023 22:18:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbjGGWSF (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 7 Jul 2023 18:18:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232566AbjGGWSE (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 7 Jul 2023 18:18:04 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7563A1BE1
        for <linux-cxl@vger.kernel.org>; Fri,  7 Jul 2023 15:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688768279; x=1720304279;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NiWXyrQZc7iVoeUaZNGdj9rnfhIniy3NK5acZ/MWF/o=;
  b=P0k9TlsBzvBTIpfUScw7BEYZOAL+T2fxP7J3qmXdAGTEtAB18eoS5Kpc
   wIu2NokGY4ebj9XvK1r16wtl3w5wfbFfEH5L9m4flu8wJdOH+YrouZxQs
   /U1tvUQPygHINPw//MKTGslR5kBZL3s374+sFvga/JR+d7qyAC26JpLSm
   XXGu8TkEesr5njlaglmd9HtXwolPgCHFxIzKy+EriIlTjh0bN2PQW+08q
   LUCX85xbMGqflXEmWBewPRVYf8OowCSP0vdVCdDhQpeCDTCA5EbPjtwLF
   RgdSEjAz97hEKgG+2XHXvvLuN08rQ0mCof1gGIM+9D0J0kGwVjBjPtHGa
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10764"; a="430056809"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="430056809"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2023 15:17:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10764"; a="749691967"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="749691967"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.116.182])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2023 15:17:59 -0700
Date:   Fri, 7 Jul 2023 15:17:58 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Breno Leitao <leitao@debian.org>
Cc:     vishal.l.verma@intel.com, ira.weiny@intel.com, bwidawsk@kernel.org,
        dan.j.williams@intel.com, linux-cxl@vger.kernel.org
Subject: Re: [PATCH] cxl/acpi: Release device after dev_err
Message-ID: <ZKiPFu0KY0alQxCJ@aschofie-mobl2>
References: <20230707161616.3554167-1-leitao@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230707161616.3554167-1-leitao@debian.org>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, Jul 07, 2023 at 09:16:16AM -0700, Breno Leitao wrote:
> Kfence is detecting a user-after-free in the CXL, when cxl_decoder_add()
> fails. Kfence drops this message, after the following:
> 
>   BUG: KFENCE: use-after-free read in resource_string
> 
> This is happening in cxl_parse_cfmws(), and here is a simplified flow
> that is coming from Kfence.
> 
> Use-after-free:
> 	_dev_err
> 	cxl_parse_cfmws
> 	acpi_table_parse_entries_array
> 	acpi_table_parse_cedt
> 	cxl_acpi_probe
> 
> Free:
> 	cxl_decoder_release
> 	device_release
> 	kobject_put
> 	cxl_parse_cfmws
> 	acpi_table_parse_entries_array
> 	acpi_table_parse_cedt
> 	cxl_acpi_probe
> 
> Alloc:
> 	cxl_decoder_alloc
> 	cxl_parse_cfmws
> 	acpi_table_parse_entries_array
> 	acpi_table_parse_cedt
> 	cxl_acpi_probe
> 	platform_probe
> 
> From my reading of the issue, the device struct being used by
> dev_err() was removed in the put_device() before.

Hi Breno, 

I'm not familiar w kfence, but I don't follow what it finds
suspect here. Does kfence point to exact offensive lines of
code, or ???

The put_device() removed &cxld->dev and the dev_err() that
this patch moves the put after, was using 'dev', which was
assigned from ctx.dev. It is not the same as &cxld->dev. I
wonder if Kfence thinks we can get to the next dev_dbg()
statement and misuse &cxld->dev.

More below...


> 
> Put the device just after the message is printed.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  drivers/cxl/acpi.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index 658e6b84a769..5179bf4211d8 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -291,14 +291,13 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
>  	}
>  	rc = cxl_decoder_add(cxld, target_map);
>  err_xormap:
> -	if (rc)
> -		put_device(&cxld->dev);
> -	else
> -		rc = cxl_decoder_autoremove(dev, cxld);
>  	if (rc) {
>  		dev_err(dev, "Failed to add decode range [%#llx - %#llx]\n",
>  			cxld->hpa_range.start, cxld->hpa_range.end);
> +		put_device(&cxld->dev);
>  		return 0;
> +	} else {
> +		rc = cxl_decoder_autoremove(dev, cxld);
>  	}
>  	dev_dbg(dev, "add: %s node: %d range [%#llx - %#llx]\n",
>  		dev_name(&cxld->dev),
> -- 
> 2.34.1
> 

(pulled in fresh code snippet to get the dev_dbg() in view.)

>	}
>	rc = cxl_decoder_add(cxld, target_map);
>err_xormap:
>	if (rc)
>		put_device(&cxld->dev);
>

This puts &cxld->dev, not dev.

>
>	else
>		rc = cxl_decoder_autoremove(dev, cxld);
>	if (rc) {
>		dev_err(dev, "Failed to add decode range [%#llx - %#llx]\n",
>			cxld->hpa_range.start, cxld->hpa_range.end);
>		return 0;

This return avoids getting to the next dev_dbg() statement after
put_device(). We cannot get to the next dev_dbg() statement when
rc is non zero, but it seems kfence thinks we can.

>	}
>	dev_dbg(dev, "add: %s node: %d range [%#llx - %#llx]\n",
>		dev_name(&cxld->dev),

If we could get here, after the put_device(), that would be bad.

>		phys_to_target_node(cxld->hpa_range.start),
>		cxld->hpa_range.start, cxld->hpa_range.end);
>
>	return 0;

