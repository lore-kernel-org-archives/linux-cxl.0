Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D3E4C433EF
	for <linux-cxl@archiver.kernel.org>; Thu,  7 Oct 2021 22:08:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33BFA61042
	for <linux-cxl@archiver.kernel.org>; Thu,  7 Oct 2021 22:08:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233341AbhJGWKe (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 7 Oct 2021 18:10:34 -0400
Received: from mga14.intel.com ([192.55.52.115]:20310 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233180AbhJGWKe (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Thu, 7 Oct 2021 18:10:34 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10130"; a="226665997"
X-IronPort-AV: E=Sophos;i="5.85,355,1624345200"; 
   d="scan'208";a="226665997"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2021 15:08:38 -0700
X-IronPort-AV: E=Sophos;i="5.85,355,1624345200"; 
   d="scan'208";a="657567813"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2021 15:08:37 -0700
Date:   Thu, 7 Oct 2021 15:08:37 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     alison.schofield@intel.com
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        linux-cxl@vger.kernel.org
Subject: Re: [PATCH] cxl/acpi: Do not fail cxl_acpi_probe() based on a
 missing CHBS
Message-ID: <20211007220837.GG3114988@iweiny-DESK2.sc.intel.com>
References: <20211007213426.392644-1-alison.schofield@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211007213426.392644-1-alison.schofield@intel.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, Oct 07, 2021 at 02:34:26PM -0700, Schofield, Alison wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> When an ACPI0016 Host Bridge device is present yet no corresponding
> CEDT Host Bridge Structure (CHBS) exists, the ACPI probe method
> fails.
> 
> Rather than fail, emit this warning and continue:
> cxl_acpi ACPI0017:00: No CHBS found for Host Bridge: ACPI0016:02
> 
> This error may occur on systems that are not compliant with the
> ACPI specification. Compliant systems include a CHBS entry for
> every CXL host bridge that is present at boot.
> 
> Suggested-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> ---
>  drivers/cxl/acpi.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index af1c6c1875ac..dadc7f64b9ff 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -288,7 +288,7 @@ static int add_host_bridge_uport(struct device *match, void *arg)
>  	dport = find_dport_by_dev(root_port, match);
>  	if (!dport) {
>  		dev_dbg(host, "host bridge expected and not found\n");
> -		return -ENODEV;
> +		return 0;
>  	}
>  
>  	port = devm_cxl_add_port(host, match, dport->component_reg_phys,
> @@ -377,9 +377,11 @@ static int add_host_bridge_dport(struct device *match, void *arg)
>  	}
>  
>  	chbs = cxl_acpi_match_chbs(host, uid);
> -	if (IS_ERR(chbs))
> -		dev_dbg(host, "No CHBS found for Host Bridge: %s\n",
> -			dev_name(match));
> +	if (IS_ERR(chbs)) {
> +		dev_warn(host, "No CHBS found for Host Bridge: %s\n",
> +			 dev_name(match));
> +		return 0;
> +	}
>  
>  	rc = cxl_add_dport(root_port, match, uid, get_chbcr(chbs));
>  	if (rc) {
> -- 
> 2.31.1
> 
