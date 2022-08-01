Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94380C00144
	for <linux-cxl@archiver.kernel.org>; Mon,  1 Aug 2022 19:37:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbiHAThK (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 1 Aug 2022 15:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbiHAThJ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 1 Aug 2022 15:37:09 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6DE22B62A
        for <linux-cxl@vger.kernel.org>; Mon,  1 Aug 2022 12:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659382628; x=1690918628;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7xNI8HUanTXY4tkhzcR0hLgdBr2Av98NqqjQjVP/4CM=;
  b=gM8duUzTlFXbsFSGsCDNYW6Fdn/Ig0QFmLZstshOYoZjHDu4QeVznwmx
   wcbfYa1Kju85Z81bh5isCbb6fcFClEwzXOPvWDiTYoXc79qCMIJBKwuif
   eBN6/L6zg1RjKKR3qwfmziPvP7AYGcSvoFBl/D3UQUjGqKAiAUM4m63tg
   wtjO7fdwLHQxRbPbC4Phb4vCaRA8/zs8cO3hB8HaFRETKxi5gXhmf7ejN
   eivOte2+f4W9XIKDRAelVyBkFK8IgoPVUio1UZlX1YH6WHYWoaABf0E26
   oaOUT657Nkdfdl+Y+QRd5+cRArEFepHxq3Clth1giEnnitCipIGl1i78Q
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10426"; a="353234231"
X-IronPort-AV: E=Sophos;i="5.93,208,1654585200"; 
   d="scan'208";a="353234231"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2022 12:37:08 -0700
X-IronPort-AV: E=Sophos;i="5.93,208,1654585200"; 
   d="scan'208";a="552633844"
Received: from alison-desk.jf.intel.com (HELO alison-desk) ([10.54.74.41])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2022 12:37:08 -0700
Date:   Mon, 1 Aug 2022 12:35:07 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 3/5] cxl/acpi: Minimize granularity for x1 interleaves
Message-ID: <20220801193507.GB1722942@alison-desk>
References: <165853775181.2430596.3054032756974329979.stgit@dwillia2-xfh.jf.intel.com>
 <165853776917.2430596.16823264262010844458.stgit@dwillia2-xfh.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <165853776917.2430596.16823264262010844458.stgit@dwillia2-xfh.jf.intel.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, Jul 22, 2022 at 05:56:09PM -0700, Dan Williams wrote:
> The kernel enforces that region granularity is >= to the top-level
> interleave-granularity for the given CXL window. However, when the CXL
> window interleave is x1, i.e. non-interleaved at the host bridge level,
> then the specified granularity does not matter. Override the window
> specified granularity to the CXL minimum so that any valid region
> granularity is >= to the root granularity.
> 
> Reported-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

> ---
>  drivers/cxl/acpi.c |    6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index eb436268b92c..67137e17b8c9 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -140,6 +140,12 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
>  		.end = res->end,
>  	};
>  	cxld->interleave_ways = ways;
> +	/*
> +	 * Minimize the x1 granularity to advertise support for any
> +	 * valid region granularity
> +	 */
> +	if (ways == 1)
> +		ig = 256;
>  	cxld->interleave_granularity = ig;
>  
>  	rc = cxl_decoder_add(cxld, target_map);
> 
