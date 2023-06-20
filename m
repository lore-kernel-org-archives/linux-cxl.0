Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3676BEB64D7
	for <linux-cxl@archiver.kernel.org>; Tue, 20 Jun 2023 23:19:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbjFTXS6 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 20 Jun 2023 19:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjFTXSr (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 20 Jun 2023 19:18:47 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C1A1703;
        Tue, 20 Jun 2023 16:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687303126; x=1718839126;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=q1bkxpygv4LAUMocA4P5yZKR1qZoIrHDfX+FBbKE9ls=;
  b=B5GWuKA4SZotZh+Gd3tYQg4YgDz2G8EjddP1HMfh976RYqOhIeE5Zygc
   Br6HbBA3l0ZS0hfjifQiOui8zqxOJPNJBNcjUbvn2YTI7SpKCCXG6rBZK
   bXGPCWm943cE92HTavR3VbCqcUOaDjEuNkToqK/zhmFBgLTPZv/DiIe+L
   FGP9Bzlaau4CYAX4saS02GBRxo4XdJ/uR9viPD8w6NWOrs6PfELD3/w+e
   xNi3sbfU+LGXb31RZXM1QkLrR8pZX9Vwb+Z1oLnVbauBf/IqjqXxYn8Ix
   9Og6D8gXcnL02+B0/h6hlao+lMR/g9uFKuE5YiC6ESHGa2HEk1lxG6syO
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="358879758"
X-IronPort-AV: E=Sophos;i="6.00,258,1681196400"; 
   d="scan'208";a="358879758"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 16:18:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="708479549"
X-IronPort-AV: E=Sophos;i="6.00,258,1681196400"; 
   d="scan'208";a="708479549"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.112.123])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 16:18:44 -0700
Date:   Tue, 20 Jun 2023 16:18:43 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Tarun Sahu <tsahu@linux.ibm.com>
Cc:     nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org,
        linux-kernel@vger.kernel.org, dave.jiang@intel.com,
        dan.j.williams@intel.com, vishal.l.verma@intel.com,
        aneesh.kumar@linux.ibm.com, jaypatel@linux.ibm.com
Subject: Re: [PATCH] dax/kmem: Pass valid argument to
 memory_group_register_static
Message-ID: <ZJIz07hQiXr/MghO@aschofie-mobl2>
References: <20230620140332.30578-1-tsahu@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230620140332.30578-1-tsahu@linux.ibm.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, Jun 20, 2023 at 07:33:32PM +0530, Tarun Sahu wrote:
> memory_group_register_static takes maximum number of pages as the argument
> while dev_dax_kmem_probe passes total_len (in bytes) as the argument.

This sounds like a fix. An explanation of the impact and a fixes tag
may be needed. Also, wondering how you found it.

Alison

> 
> Signed-off-by: Tarun Sahu <tsahu@linux.ibm.com>
> ---
>  drivers/dax/kmem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
> index 7b36db6f1cbd..898ca9505754 100644
> --- a/drivers/dax/kmem.c
> +++ b/drivers/dax/kmem.c
> @@ -99,7 +99,7 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
>  	if (!data->res_name)
>  		goto err_res_name;
>  
> -	rc = memory_group_register_static(numa_node, total_len);
> +	rc = memory_group_register_static(numa_node, PFN_UP(total_len));
>  	if (rc < 0)
>  		goto err_reg_mgid;
>  	data->mgid = rc;
> -- 
> 2.31.1
> 
