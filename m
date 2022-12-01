Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 798C4C4321E
	for <linux-cxl@archiver.kernel.org>; Thu,  1 Dec 2022 21:57:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbiLAV5e (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 1 Dec 2022 16:57:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231266AbiLAV5b (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 1 Dec 2022 16:57:31 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F89AC3FF7
        for <linux-cxl@vger.kernel.org>; Thu,  1 Dec 2022 13:57:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669931850; x=1701467850;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=YuLGJY/W/2CbAUBIRBk7hrWz1SyxVSdB4NS2xcnKGoo=;
  b=E6BFLSH2k4qW6amqdNTqwZ/RGN1td6nRAXF9g6GEDJKeMsUgM89OKGdr
   ueUTsnmM2wex0FGVfVAxhV2ynfEna4O2GyD227tlr4lN5XnGABqDZXxyD
   cpGuL8as7Y8GG3jaXUc7R5BQoL4fd4TgVzpnSifP30bvU9HS0Hyz3c9Hs
   Jz722D4Yqb6KFOY/CwKeUBJod9ng7AUE012YWmnLabJfEaFXyHqbxRfjM
   awxtWWDB3Ys5/V7aIswsmWMHFUH75qd9Hr4awqM2wUxGrGRd+1u4Rmmhy
   +Fc1L8npERZLa/hfeZN0l8KoRBW19fzJ2raf4AdNLZv5engQPycklvfq5
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="295502645"
X-IronPort-AV: E=Sophos;i="5.96,210,1665471600"; 
   d="scan'208";a="295502645"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2022 13:57:30 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="638543510"
X-IronPort-AV: E=Sophos;i="5.96,210,1665471600"; 
   d="scan'208";a="638543510"
Received: from djiang5-mobl2.amr.corp.intel.com (HELO [10.212.66.184]) ([10.212.66.184])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2022 13:57:29 -0800
Message-ID: <bfaeb182-7b80-2330-1649-e2433de076f3@intel.com>
Date:   Thu, 1 Dec 2022 14:57:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.5.0
Subject: Re: [PATCH v6 06/12] tools/testing/cxl: Make mock CEDT parsing more
 robust
Content-Language: en-US
To:     Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Cc:     Alison Schofield <alison.schofield@intel.com>,
        Robert Richter <rrichter@amd.com>, terry.bowman@amd.com,
        bhelgaas@google.com, nvdimm@lists.linux.dev
References: <166993040066.1882361.5484659873467120859.stgit@dwillia2-xfh.jf.intel.com>
 <166993043433.1882361.17651413716599606118.stgit@dwillia2-xfh.jf.intel.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <166993043433.1882361.17651413716599606118.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 12/1/2022 2:33 PM, Dan Williams wrote:
> Accept any cxl_test topology device as the first argument in
> cxl_chbs_context.
> 
> This is in preparation for reworking the detection of the component
> registers across VH and RCH topologies. Move
> mock_acpi_table_parse_cedt() beneath the definition of is_mock_port()
> and use is_mock_port() instead of the explicit mock cxl_acpi device
> check.
> 
> Acked-by: Alison Schofield <alison.schofield@intel.com>
> Reviewed-by: Robert Richter <rrichter@amd.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>   tools/testing/cxl/test/cxl.c |   10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> index facfcd11cb67..8acf52b7dab2 100644
> --- a/tools/testing/cxl/test/cxl.c
> +++ b/tools/testing/cxl/test/cxl.c
> @@ -320,10 +320,12 @@ static int populate_cedt(void)
>   	return 0;
>   }
>   
> +static bool is_mock_port(struct device *dev);
> +
>   /*
> - * WARNING, this hack assumes the format of 'struct
> - * cxl_cfmws_context' and 'struct cxl_chbs_context' share the property that
> - * the first struct member is the device being probed by the cxl_acpi
> + * WARNING, this hack assumes the format of 'struct cxl_cfmws_context'
> + * and 'struct cxl_chbs_context' share the property that the first
> + * struct member is cxl_test device being probed by the cxl_acpi
>    * driver.
>    */
>   struct cxl_cedt_context {
> @@ -340,7 +342,7 @@ static int mock_acpi_table_parse_cedt(enum acpi_cedt_type id,
>   	unsigned long end;
>   	int i;
>   
> -	if (dev != &cxl_acpi->dev)
> +	if (!is_mock_port(dev) && !is_mock_dev(dev))
>   		return acpi_table_parse_cedt(id, handler_arg, arg);
>   
>   	if (id == ACPI_CEDT_TYPE_CHBS)
> 
