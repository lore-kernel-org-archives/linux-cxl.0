Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF6B4C4332F
	for <linux-cxl@archiver.kernel.org>; Mon,  5 Dec 2022 15:54:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231918AbiLEPyp (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 5 Dec 2022 10:54:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbiLEPyn (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 5 Dec 2022 10:54:43 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8C9613D44
        for <linux-cxl@vger.kernel.org>; Mon,  5 Dec 2022 07:54:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670255682; x=1701791682;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=t6+ntCM1cR1hnfO3IWXwlZYRI1wFY/xNf9nhRyMZV5o=;
  b=dZW/PQMczITlWn3qs4IedGZn/adiABzucrGpMaht7xsyZlSGWg3aiPA1
   KbxALPmJB3PGVjZuySazxhl83jKtysMa8mchjBCpjlfD8dsRZ4aOQKmU+
   kv4ajzWtiV451effR1BX+Scfv3eHJ/b2zrtLy/VfVpa28CNCnUsu5UBAz
   mjsZ8UhfFXrm/aGnLPY+kFC07MACk20VZ7QISGXN23uNlt3sAT9zhgESj
   UDwPTE0G9Ea0gIsRKtij+7wt8bqDvs2Qct1lfPd/EWnmv7phgzIZ0javv
   Fw5MbDwAqDe5r3ITQ89yPO2TIZJQKwrxlJWJm9poj2L48NckGZKavPfd+
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="380675856"
X-IronPort-AV: E=Sophos;i="5.96,219,1665471600"; 
   d="scan'208";a="380675856"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 07:54:42 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="788121901"
X-IronPort-AV: E=Sophos;i="5.96,219,1665471600"; 
   d="scan'208";a="788121901"
Received: from djiang5-mobl2.amr.corp.intel.com (HELO [10.212.26.166]) ([10.212.26.166])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 07:54:38 -0800
Message-ID: <55150f8b-f1ea-c41d-4c54-970e2c86fe2a@intel.com>
Date:   Mon, 5 Dec 2022 08:54:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.5.1
Subject: Re: [PATCH] cxl/acpi: Fail decoder add if CXIMS for HBIG is missing
Content-Language: en-US
To:     alison.schofield@intel.com,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>
Cc:     linux-cxl@vger.kernel.org
References: <20221205002951.1788783-1-alison.schofield@intel.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20221205002951.1788783-1-alison.schofield@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 12/4/2022 5:29 PM, alison.schofield@intel.com wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> The BIOS provided CXIMS (CXL XOR Interleave Math Structure) is required
> for calculating a targets position in an interleave list during region
> creation. The CXL driver expects to discover a CXIMS that matches the
> HBIG (Host Bridge Interleave Granularity) and stores the xormaps found
> in that CXIMS for retrieval during region creation.
> 
> If there is no CXIMS for an HBIG, no maps are stored. That leads to a
> NULL pointer dereference at xormap retrieval during region creation.
> 
> Add a check during ACPI probe for the case of no matching CXIMS. Emit
> an error message and fail to add the decoder.
> 
> Fixes: f9db85bfec0d ("cxl/acpi: Support CXL XOR Interleave Math (CXIMS)")
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
> 
> Not sure the Commit-ID in Fixes tag will persist. (from cxl/pending)
> 
>   drivers/cxl/acpi.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index 657ef250d848..420e322c85a1 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -282,6 +282,11 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
>   						   cxl_parse_cxims, &cxims_ctx);
>   			if (rc < 0)
>   				goto err_xormap;
> +			if (!cxlrd->platform_data) {
> +				dev_err(dev, "No CXIMS for HBIG %u\n", ig);
> +				rc = -EINVAL;
> +				goto err_xormap;
> +			}
>   		}
>   	}
>   	rc = cxl_decoder_add(cxld, target_map);
> 
> base-commit: d72a5b810410c076d4dd63fe542a5a4d6c145cfa
