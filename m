Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E949C4708C
	for <linux-cxl@archiver.kernel.org>; Tue,  6 Dec 2022 10:08:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234242AbiLFKIa (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 6 Dec 2022 05:08:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235506AbiLFKIG (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 6 Dec 2022 05:08:06 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 489F529353
        for <linux-cxl@vger.kernel.org>; Tue,  6 Dec 2022 01:58:51 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NRG4d1VJ8z6HJZY;
        Tue,  6 Dec 2022 17:55:29 +0800 (CST)
Received: from localhost (10.45.155.47) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 6 Dec
 2022 09:58:49 +0000
Date:   Tue, 6 Dec 2022 09:58:47 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, Dave Jiang <dave.jiang@intel.com>,
        "Steven Rostedt" <rostedt@goodmis.org>
Subject: Re: [PATCH] cxl/pci: Add some type-safety to the AER trace points
Message-ID: <20221206095847.00006490@Huawei.com>
In-Reply-To: <167030091477.4045167.15174636482098463885.stgit@dwillia2-xfh.jf.intel.com>
References: <167030091477.4045167.15174636482098463885.stgit@dwillia2-xfh.jf.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.45.155.47]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, 05 Dec 2022 20:28:34 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> The first argument to the CXL AER trace points is the source device.
> Pass a 'const struct device *' rather than a 'const char *' for more
> type precision / safety.
> 
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
I guess this is slightly nicer.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/pci.c          |    4 ++--
>  include/trace/events/cxl.h |   16 ++++++++--------
>  2 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 6cec9fa9326c..cced4a0df3d1 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -562,7 +562,7 @@ static bool cxl_report_and_clear(struct cxl_dev_state *cxlds)
>  	}
>  
>  	header_log_copy(cxlds, hl);
> -	trace_cxl_aer_uncorrectable_error(dev_name(dev), status, fe, hl);
> +	trace_cxl_aer_uncorrectable_error(dev, status, fe, hl);
>  	writel(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK, addr);
>  
>  	return true;
> @@ -644,7 +644,7 @@ static void cxl_cor_error_detected(struct pci_dev *pdev)
>  	status = le32_to_cpu(readl(addr));
>  	if (status & CXL_RAS_CORRECTABLE_STATUS_MASK) {
>  		writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
> -		trace_cxl_aer_correctable_error(dev_name(dev), status);
> +		trace_cxl_aer_correctable_error(dev, status);
>  	}
>  }
>  
> diff --git a/include/trace/events/cxl.h b/include/trace/events/cxl.h
> index 72c3e2870a9e..ad085a2534ef 100644
> --- a/include/trace/events/cxl.h
> +++ b/include/trace/events/cxl.h
> @@ -45,16 +45,16 @@
>  )
>  
>  TRACE_EVENT(cxl_aer_uncorrectable_error,
> -	TP_PROTO(const char *dev_name, u32 status, u32 fe, u32 *hl),
> -	TP_ARGS(dev_name, status, fe, hl),
> +	TP_PROTO(const struct device *dev, u32 status, u32 fe, u32 *hl),
> +	TP_ARGS(dev, status, fe, hl),
>  	TP_STRUCT__entry(
> -		__string(dev_name, dev_name)
> +		__string(dev_name, dev_name(dev))
>  		__field(u32, status)
>  		__field(u32, first_error)
>  		__array(u32, header_log, CXL_HEADERLOG_SIZE_U32)
>  	),
>  	TP_fast_assign(
> -		__assign_str(dev_name, dev_name);
> +		__assign_str(dev_name, dev_name(dev));
>  		__entry->status = status;
>  		__entry->first_error = fe;
>  		/*
> @@ -89,14 +89,14 @@ TRACE_EVENT(cxl_aer_uncorrectable_error,
>  )
>  
>  TRACE_EVENT(cxl_aer_correctable_error,
> -	TP_PROTO(const char *dev_name, u32 status),
> -	TP_ARGS(dev_name, status),
> +	TP_PROTO(const struct device *dev, u32 status),
> +	TP_ARGS(dev, status),
>  	TP_STRUCT__entry(
> -		__string(dev_name, dev_name)
> +		__string(dev_name, dev_name(dev))
>  		__field(u32, status)
>  	),
>  	TP_fast_assign(
> -		__assign_str(dev_name, dev_name);
> +		__assign_str(dev_name, dev_name(dev));
>  		__entry->status = status;
>  	),
>  	TP_printk("%s: status: '%s'",
> 

