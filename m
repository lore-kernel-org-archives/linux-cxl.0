Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA857C001B0
	for <linux-cxl@archiver.kernel.org>; Tue, 11 Jul 2023 18:11:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231893AbjGKSLb (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 11 Jul 2023 14:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231308AbjGKSLa (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 11 Jul 2023 14:11:30 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14D7110D2
        for <linux-cxl@vger.kernel.org>; Tue, 11 Jul 2023 11:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689099090; x=1720635090;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FzNDZfeyWsdgzwqI5TrBMrNBilKSYnkmwKrckMnt2Lc=;
  b=mkBsoML1XmRFADgYOqDXJ7DI+yrUID7ADf61j/1Yy/Z3gYs/6pjbwNvn
   plXDM98l5vwGqAqTlB62j8det573T594DlBXyaE+mY269JIgicBjenGMU
   uxG4Ca/b6teEOWxADW7eEG6Qt6y7AI/rJ6W1GmnsBaE11VMMxgy9Gp2mz
   37gGw+zmhcQ7V8qOb97f/iaydgexnm6i+st4t7NuWk+y/puB4CIb7j6++
   kmzuD/42q+EqLhURJjlj+PpkJuw3H+vIFiWbLbp+EzoaMc6gFJ+LVcTVQ
   fkp4dI8s4Foe4LBq0SMnDXnkOx+oOjJcN8lYaIvRodsiKZqi5MihvsmtI
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="354579259"
X-IronPort-AV: E=Sophos;i="6.01,197,1684825200"; 
   d="scan'208";a="354579259"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2023 10:52:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="750856563"
X-IronPort-AV: E=Sophos;i="6.01,197,1684825200"; 
   d="scan'208";a="750856563"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.212.140.181])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2023 10:52:40 -0700
Date:   Tue, 11 Jul 2023 10:52:39 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Breno Leitao <leitao@debian.org>
Cc:     vishal.l.verma@intel.com, ira.weiny@intel.com, bwidawsk@kernel.org,
        dan.j.williams@intel.com, linux-cxl@vger.kernel.org,
        ave.jiang@intel.com
Subject: Re: [PATCH v2] cxl/acpi: Release device after dev_err()
Message-ID: <ZK2W50voY8augr8m@aschofie-mobl2>
References: <20230711161704.3033220-1-leitao@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230711161704.3033220-1-leitao@debian.org>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, Jul 11, 2023 at 09:17:04AM -0700, Breno Leitao wrote:
> Kfence detected an user-after-free in the CXL driver. This happens in
> the cxl_decoder_add() fail path. Kfence drops this message:
> 
>   BUG: KFENCE: use-after-free read in resource_string
> 
> This is happening in cxl_parse_cfmws(), where put_device() is called,
> releasing cxld->dev, and then, later, dev_err(cxld->dev) is called
> referencing the released device.
> 
> Just release the device after the message is printed/dev_err().  On top
> of that, cxl_parse_cfmws() must fail (returns rc) in case of
> cxl_decoder_add() or cxl_decoder_autoremove() failing (rc != 0), instead
> of swallowing the error and returning 0.

Breno,

Is kfence satisfied if you do this?

iff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 658e6b84a769..642983da01cb 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -297,7 +297,7 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
                rc = cxl_decoder_autoremove(dev, cxld);
        if (rc) {
                dev_err(dev, "Failed to add decode range [%#llx - %#llx]\n",
-                       cxld->hpa_range.start, cxld->hpa_range.end);
+                       res->start, res->end);
                return 0;
        }
        dev_dbg(dev, "add: %s node: %d range [%#llx - %#llx]\n",

Alison


> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
> v1 -> v2
>  * Return the error (rc) instead of swalling it
> 
> ---
>  drivers/cxl/acpi.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index 658e6b84a769..efead5cc8a89 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -291,14 +291,16 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
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
> -		return 0;
> +		put_device(&cxld->dev);
> +		return rc;
> +	}
> +	rc = cxl_decoder_autoremove(dev, cxld);
> +	if (rc) {
> +		dev_err(dev, "Failed to register autoremove action\n");
> +		return rc;
>  	}
>  	dev_dbg(dev, "add: %s node: %d range [%#llx - %#llx]\n",
>  		dev_name(&cxld->dev),
> -- 
> 2.34.1
> 
