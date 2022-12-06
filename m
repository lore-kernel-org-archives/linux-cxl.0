Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5958C352A1
	for <linux-cxl@archiver.kernel.org>; Tue,  6 Dec 2022 17:06:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232037AbiLFRG2 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 6 Dec 2022 12:06:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233776AbiLFRGZ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 6 Dec 2022 12:06:25 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D69431134
        for <linux-cxl@vger.kernel.org>; Tue,  6 Dec 2022 09:06:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670346384; x=1701882384;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xsWNOOGhWB3DEReUjhEKGcgAF88zwmJ9SANSTf4HMdQ=;
  b=impz9U2avIHQy0zKg9GV1QRfSosR2CyuFuKrGNQOYFeexWpOWO7s8giV
   tBDqxgBMT4xzXBp0Cvt2woGtxpy/cTaf6TUtOIq+lR6oftAngDtxdY3lE
   22iH2VnGZRsxGuJsFV7od/sLfhUGIPt25XGUuFSO1HQBcP8y3f5xD9DL4
   P+c3CaXQOfONXIrpHg28cAxLL1uqnNpJb2dPsqGBiSMU60iamF9lU8nKv
   ODu359mP32RpP3PHIqBIDQfJx7+/iTvM4E7radEuRE0jb6ksNlLKcGBwE
   QkphVJetrVWyPaS85Yg6AxOSEZES5hO2RCOZabeZnY8YpTedch3GvAB/9
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="316697572"
X-IronPort-AV: E=Sophos;i="5.96,222,1665471600"; 
   d="scan'208";a="316697572"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2022 09:06:24 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="677043197"
X-IronPort-AV: E=Sophos;i="5.96,222,1665471600"; 
   d="scan'208";a="677043197"
Received: from djiang5-mobl2.amr.corp.intel.com (HELO [10.212.108.100]) ([10.212.108.100])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2022 09:06:23 -0800
Message-ID: <231c12a4-eb10-9c29-5fff-898fa7072ba2@intel.com>
Date:   Tue, 6 Dec 2022 10:06:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.5.1
Subject: Re: [PATCH] cxl/pci: Add some type-safety to the AER trace points
Content-Language: en-US
To:     Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Steven Rostedt <rostedt@goodmis.org>
References: <167030091477.4045167.15174636482098463885.stgit@dwillia2-xfh.jf.intel.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <167030091477.4045167.15174636482098463885.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 12/5/2022 9:28 PM, Dan Williams wrote:
> The first argument to the CXL AER trace points is the source device.
> Pass a 'const struct device *' rather than a 'const char *' for more
> type precision / safety.
> 
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>   drivers/cxl/pci.c          |    4 ++--
>   include/trace/events/cxl.h |   16 ++++++++--------
>   2 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 6cec9fa9326c..cced4a0df3d1 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -562,7 +562,7 @@ static bool cxl_report_and_clear(struct cxl_dev_state *cxlds)
>   	}
>   
>   	header_log_copy(cxlds, hl);
> -	trace_cxl_aer_uncorrectable_error(dev_name(dev), status, fe, hl);
> +	trace_cxl_aer_uncorrectable_error(dev, status, fe, hl);
>   	writel(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK, addr);
>   
>   	return true;
> @@ -644,7 +644,7 @@ static void cxl_cor_error_detected(struct pci_dev *pdev)
>   	status = le32_to_cpu(readl(addr));
>   	if (status & CXL_RAS_CORRECTABLE_STATUS_MASK) {
>   		writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
> -		trace_cxl_aer_correctable_error(dev_name(dev), status);
> +		trace_cxl_aer_correctable_error(dev, status);
>   	}
>   }
>   
> diff --git a/include/trace/events/cxl.h b/include/trace/events/cxl.h
> index 72c3e2870a9e..ad085a2534ef 100644
> --- a/include/trace/events/cxl.h
> +++ b/include/trace/events/cxl.h
> @@ -45,16 +45,16 @@
>   )
>   
>   TRACE_EVENT(cxl_aer_uncorrectable_error,
> -	TP_PROTO(const char *dev_name, u32 status, u32 fe, u32 *hl),
> -	TP_ARGS(dev_name, status, fe, hl),
> +	TP_PROTO(const struct device *dev, u32 status, u32 fe, u32 *hl),
> +	TP_ARGS(dev, status, fe, hl),
>   	TP_STRUCT__entry(
> -		__string(dev_name, dev_name)
> +		__string(dev_name, dev_name(dev))
>   		__field(u32, status)
>   		__field(u32, first_error)
>   		__array(u32, header_log, CXL_HEADERLOG_SIZE_U32)
>   	),
>   	TP_fast_assign(
> -		__assign_str(dev_name, dev_name);
> +		__assign_str(dev_name, dev_name(dev));
>   		__entry->status = status;
>   		__entry->first_error = fe;
>   		/*
> @@ -89,14 +89,14 @@ TRACE_EVENT(cxl_aer_uncorrectable_error,
>   )
>   
>   TRACE_EVENT(cxl_aer_correctable_error,
> -	TP_PROTO(const char *dev_name, u32 status),
> -	TP_ARGS(dev_name, status),
> +	TP_PROTO(const struct device *dev, u32 status),
> +	TP_ARGS(dev, status),
>   	TP_STRUCT__entry(
> -		__string(dev_name, dev_name)
> +		__string(dev_name, dev_name(dev))
>   		__field(u32, status)
>   	),
>   	TP_fast_assign(
> -		__assign_str(dev_name, dev_name);
> +		__assign_str(dev_name, dev_name(dev));
>   		__entry->status = status;
>   	),
>   	TP_printk("%s: status: '%s'",
> 
