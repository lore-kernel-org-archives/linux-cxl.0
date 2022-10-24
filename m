Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED7AAECAAA1
	for <linux-cxl@archiver.kernel.org>; Mon, 24 Oct 2022 17:23:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231450AbiJXRXp (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 24 Oct 2022 13:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbiJXRXN (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 24 Oct 2022 13:23:13 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 343FD108DDE
        for <linux-cxl@vger.kernel.org>; Mon, 24 Oct 2022 08:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666627091; x=1698163091;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=0iEMpFkBwrPlxdATyzegV+tqWD5CMhKZ2e4+KkpiE/8=;
  b=euN8T2fXEyrUZGUitLFqG1V176wX7D7695fLiBE2D5tp9eDm6zumPbk/
   fOw4fZ9dJ3LO7IJ4H8v2i+ubRs5gH5rIjsbrPZMlcQaUYGZ8bMXa3W/Rh
   DZH6IQJm32QScpQ6j9VkoRvs+kvVKIM6eUxPWF/Vn0jXrnuVJw9ta8orh
   36Ug29hwLvZNezEXu/phl9qaR6U18l1fJhBA0Jh3vTkebFFOjdS3eJUvp
   wVQ82HYF+G6Uii3OnSKb8uLkq52aF3xc+yfo2RDp9RjjfWxXqWqr/KWoF
   AW5sJEuuCk+OwGJU68rHy1eQ1pH3owEIFWhWOCAYgSgXoL7LZAlZvH7zw
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="287849467"
X-IronPort-AV: E=Sophos;i="5.95,209,1661842800"; 
   d="scan'208";a="287849467"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 08:40:17 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="773863368"
X-IronPort-AV: E=Sophos;i="5.95,209,1661842800"; 
   d="scan'208";a="773863368"
Received: from djiang5-mobl2.amr.corp.intel.com (HELO [10.212.92.195]) ([10.212.92.195])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 08:40:16 -0700
Message-ID: <4aaf4290-0581-9a32-0058-3cabc9705def@intel.com>
Date:   Mon, 24 Oct 2022 08:40:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.0
Subject: Re: [PATCH v2] cxl: check decoder count for end device
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com
References: <166662591658.231711.18305612334545370247.stgit@djiang5-desk3.ch.intel.com>
Content-Language: en-US
In-Reply-To: <166662591658.231711.18305612334545370247.stgit@djiang5-desk3.ch.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org


On 10/24/2022 8:39 AM, Dave Jiang wrote:
> CXL spec rev3.0 8.2.4.19.1 added definition for up to 32 decoders. It also
> indicates that for devices, only 10 decoders should be advertised. Add
> check on number of decoders greater than 10 for devices and reset to 10 to
> force spec compliance.
>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>


Please ignore. Need to fix the warning.


> ---
>
> v2:
> - Remove decoder count reassignment from violation (Dan)
>
>   drivers/cxl/core/hdm.c |   10 ++++++++++
>   1 file changed, 10 insertions(+)
>
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index d1d2caea5c62..ff53c758e95a 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -71,9 +71,19 @@ EXPORT_SYMBOL_NS_GPL(devm_cxl_add_passthrough_decoder, CXL);
>   static void parse_hdm_decoder_caps(struct cxl_hdm *cxlhdm)
>   {
>   	u32 hdm_cap;
> +	struct device *dev = &cxlhdm->port->dev;
>   
>   	hdm_cap = readl(cxlhdm->regs.hdm_decoder + CXL_HDM_DECODER_CAP_OFFSET);
>   	cxlhdm->decoder_count = cxl_hdm_decoder_count(hdm_cap);
> +	/*
> +	 * CXL spec rev3.0 8.2.4.19.1 indicates CXL devices shall not advertise
> +	 * more than 10 decoders. Switches and Host Bridges may advertise up to
> +	 * 32 decoders. Set the decoders to 10 for devices if more than 10 are
> +	 * found.
> +	 */
> +	if (is_cxl_endpoint(cxlhdm->port) && cxlhdm->decoder_count > 10)
> +		dev_warn(dev, "Reset decoders count (%d) to 10, spec violation!\n",
> +			 cxlhdm->decoder_count);
>   	cxlhdm->target_count =
>   		FIELD_GET(CXL_HDM_DECODER_TARGET_COUNT_MASK, hdm_cap);
>   	if (FIELD_GET(CXL_HDM_DECODER_INTERLEAVE_11_8, hdm_cap))
>
>
