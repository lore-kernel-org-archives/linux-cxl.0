Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88815C352A1
	for <linux-cxl@archiver.kernel.org>; Tue,  6 Dec 2022 17:05:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbiLFRFY (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 6 Dec 2022 12:05:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233776AbiLFRFL (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 6 Dec 2022 12:05:11 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65D8C1134
        for <linux-cxl@vger.kernel.org>; Tue,  6 Dec 2022 09:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670346310; x=1701882310;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=G84p1m7+H3NkHOy4atWM0yZph4JB/kYyCRF6MixQ3rM=;
  b=j8CFlhzzI8pmPuvfo1swgnxrY1fFLUl91RmX7r8prc53xYkhLFx5g4GL
   RChHFS+3qABRSKlK+xZcAjoQHzbIMYzUjPQAtNSSoOfr6+Cvog/+/5TkV
   w0LvgCfcujozkhd7dJAazTSs7KcWbTRJ5dtTOCCUtzEIG3UPNAMg5EwFk
   dPylfMBvEaKCEHuoFyiDGO7TND0pKpIV/phrqDQjO8UEm6yWTMCH1ov3s
   AryVYWKQ4JEAE++A3PX8MjgD1l77aIg5om77AOhVzfBXpnPWwtZ79CBMV
   KcDRzFbMXDl5SybCn8V2VelIzU8pGpXyJJBRuMrvDBxFvP/p90St9Km5J
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="316697031"
X-IronPort-AV: E=Sophos;i="5.96,222,1665471600"; 
   d="scan'208";a="316697031"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2022 09:04:56 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="677042482"
X-IronPort-AV: E=Sophos;i="5.96,222,1665471600"; 
   d="scan'208";a="677042482"
Received: from djiang5-mobl2.amr.corp.intel.com (HELO [10.212.108.100]) ([10.212.108.100])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2022 09:04:56 -0800
Message-ID: <baa7fdb3-15c4-c233-7be4-e45cdfa77174@intel.com>
Date:   Tue, 6 Dec 2022 10:04:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.5.1
Subject: Re: [PATCH] cxl/pci: Remove endian confusion
Content-Language: en-US
To:     Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <167030092025.4045167.10651070153523351093.stgit@dwillia2-xfh.jf.intel.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <167030092025.4045167.10651070153523351093.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 12/5/2022 9:28 PM, Dan Williams wrote:
> readl() already handles endian conversion. That's the main difference
> between readl() and __raw_readl(). This is benign on little-endian
> systems, but big endian systems will end up byte-swabbing twice.
> 
> Fixes: 2905cb5236cb ("cxl/pci: Add (hopeful) error handling support")
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>   drivers/cxl/pci.c |    7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index cced4a0df3d1..33083a522fd1 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -548,15 +548,14 @@ static bool cxl_report_and_clear(struct cxl_dev_state *cxlds)
>   		return false;
>   
>   	addr = cxlds->regs.ras + CXL_RAS_UNCORRECTABLE_STATUS_OFFSET;
> -	status = le32_to_cpu((__force __le32)readl(addr));
> +	status = readl(addr);
>   	if (!(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK))
>   		return false;
>   
>   	/* If multiple errors, log header points to first error from ctrl reg */
>   	if (hweight32(status) > 1) {
>   		addr = cxlds->regs.ras + CXL_RAS_CAP_CONTROL_OFFSET;
> -		fe = BIT(le32_to_cpu((__force __le32)readl(addr)) &
> -				     CXL_RAS_CAP_CONTROL_FE_MASK);
> +		fe = BIT(FIELD_GET(CXL_RAS_CAP_CONTROL_FE_MASK, readl(addr)));
>   	} else {
>   		fe = status;
>   	}
> @@ -641,7 +640,7 @@ static void cxl_cor_error_detected(struct pci_dev *pdev)
>   		return;
>   
>   	addr = cxlds->regs.ras + CXL_RAS_CORRECTABLE_STATUS_OFFSET;
> -	status = le32_to_cpu(readl(addr));
> +	status = readl(addr);
>   	if (status & CXL_RAS_CORRECTABLE_STATUS_MASK) {
>   		writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
>   		trace_cxl_aer_correctable_error(dev, status);
> 
