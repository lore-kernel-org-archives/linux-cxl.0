Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA317C49361
	for <linux-cxl@archiver.kernel.org>; Fri, 18 Jun 2021 14:04:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AA656128C
	for <linux-cxl@archiver.kernel.org>; Fri, 18 Jun 2021 14:04:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232152AbhFROGN (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 18 Jun 2021 10:06:13 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3283 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230387AbhFROGN (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 18 Jun 2021 10:06:13 -0400
Received: from fraeml713-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4G60lV2WdMz6M4lK;
        Fri, 18 Jun 2021 21:54:14 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml713-chm.china.huawei.com (10.206.15.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 18 Jun 2021 16:04:01 +0200
Received: from localhost (10.52.125.28) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Fri, 18 Jun
 2021 15:04:01 +0100
Date:   Fri, 18 Jun 2021 15:03:51 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     <ira.weiny@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ben Widawsky" <ben.widawsky@intel.com>,
        <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH V2 3/3] cxl/mem: Adjust ram/pmem range to represent DPA
 ranges
Message-ID: <20210618150351.00004ccc@Huawei.com>
In-Reply-To: <20210617221620.1904031-4-ira.weiny@intel.com>
References: <20210617221620.1904031-1-ira.weiny@intel.com>
        <20210617221620.1904031-4-ira.weiny@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.125.28]
X-ClientProxiedBy: lhreml748-chm.china.huawei.com (10.201.108.198) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, 17 Jun 2021 15:16:20 -0700
<ira.weiny@intel.com> wrote:

> From: Ira Weiny <ira.weiny@intel.com>
> 
> CXL spec defines the volatile DPA range to be 0 to Volatile memory size.
> It further defines the persistent DPA range to follow directly after the
> end of the Volatile DPA through the persistent memory size.

Reference would be good for anyone sanity checking against the spec. I think it's
Table 176 that says this.

> Essentially
> 
> Volatile DPA range   = [0, Volatile size)
> Persistent DPA range = [Volatile size, Volatile size + Persistent size)
> 
> Adjust the pmem_range start to reflect this and remote the TODO.

remove

> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/pci.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 341885345b53..a1fd7923dfb9 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -1635,8 +1635,9 @@ static int cxl_mem_create_range_info(struct cxl_mem *cxlm)
>  	if (cxlm->partition_align_bytes == 0) {
>  		cxlm->ram_range.start = 0;
>  		cxlm->ram_range.end = cxlm->volatile_only_bytes - 1;
> -		cxlm->pmem_range.start = 0;
> -		cxlm->pmem_range.end = cxlm->persistent_only_bytes - 1;
> +		cxlm->pmem_range.start = cxlm->volatile_only_bytes;
> +		cxlm->pmem_range.end = cxlm->volatile_only_bytes +
> +					cxlm->persistent_only_bytes - 1;
>  		return 0;
>  	}
>  
> @@ -1660,15 +1661,12 @@ static int cxl_mem_create_range_info(struct cxl_mem *cxlm)
>  			cxlm->next_volatile_bytes,
>  			cxlm->next_persistent_bytes);
>  
> -	/*
> -	 * TODO: enumerate DPA map, as 'ram' and 'pmem' do not alias.
> -	 * For now, only the capacity is exported in sysfs
> -	 */
>  	cxlm->ram_range.start = 0;
>  	cxlm->ram_range.end = cxlm->active_volatile_bytes - 1;
>  
> -	cxlm->pmem_range.start = 0;
> -	cxlm->pmem_range.end = cxlm->active_persistent_bytes - 1;
> +	cxlm->pmem_range.start = cxlm->active_volatile_bytes;
> +	cxlm->pmem_range.end = cxlm->active_volatile_bytes +
> +				cxlm->active_persistent_bytes - 1;
>  
>  	return 0;
>  }

