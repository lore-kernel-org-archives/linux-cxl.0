Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5917C433EF
	for <linux-cxl@archiver.kernel.org>; Thu,  2 Sep 2021 17:59:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEEE1610A2
	for <linux-cxl@archiver.kernel.org>; Thu,  2 Sep 2021 17:59:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbhIBSAd (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 2 Sep 2021 14:00:33 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3721 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346876AbhIBSA2 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 2 Sep 2021 14:00:28 -0400
Received: from fraeml702-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4H0pYM5rfBz6866J;
        Fri,  3 Sep 2021 01:57:43 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml702-chm.china.huawei.com (10.206.15.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Thu, 2 Sep 2021 19:59:27 +0200
Received: from localhost (10.52.127.69) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Thu, 2 Sep 2021
 18:59:27 +0100
Date:   Thu, 2 Sep 2021 18:59:28 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, Ben Widawsky <ben.widawsky@intel.com>,
        <vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
        <nvdimm@lists.linux.dev>, <ira.weiny@intel.com>
Subject: Re: [PATCH v3 19/28] cxl/mbox: Convert 'enabled_cmds' to
 DECLARE_BITMAP
Message-ID: <20210902185928.00001f8f@Huawei.com>
In-Reply-To: <162982122744.1124374.6742215706893563515.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <162982112370.1124374.2020303588105269226.stgit@dwillia2-desk3.amr.corp.intel.com>
        <162982122744.1124374.6742215706893563515.stgit@dwillia2-desk3.amr.corp.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.127.69]
X-ClientProxiedBy: lhreml715-chm.china.huawei.com (10.201.108.66) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, 24 Aug 2021 09:07:07 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> Define enabled_cmds as an embedded member of 'struct cxl_mem' rather
> than a pointer to another dynamic allocation.
> 
> As this leaves only one user of cxl_cmd_count, just open code it and
> delete the helper.
> 
> Acked-by: Ben Widawsky <ben.widawsky@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Nice

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/core/mbox.c |   10 +---------
>  drivers/cxl/cxlmem.h    |    2 +-
>  2 files changed, 2 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 706fe007c8d6..73107b302224 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -324,8 +324,6 @@ static int cxl_validate_cmd_from_user(struct cxl_mem *cxlm,
>  	return 0;
>  }
>  
> -#define cxl_cmd_count ARRAY_SIZE(cxl_mem_commands)
> -
>  int cxl_query_cmd(struct cxl_memdev *cxlmd,
>  		  struct cxl_mem_query_commands __user *q)
>  {
> @@ -341,7 +339,7 @@ int cxl_query_cmd(struct cxl_memdev *cxlmd,
>  
>  	/* returns the total number if 0 elements are requested. */
>  	if (n_commands == 0)
> -		return put_user(cxl_cmd_count, &q->n_commands);
> +		return put_user(ARRAY_SIZE(cxl_mem_commands), &q->n_commands);
>  
>  	/*
>  	 * otherwise, return max(n_commands, total commands) cxl_command_info
> @@ -805,12 +803,6 @@ struct cxl_mem *cxl_mem_create(struct device *dev)
>  
>  	mutex_init(&cxlm->mbox_mutex);
>  	cxlm->dev = dev;
> -	cxlm->enabled_cmds =
> -		devm_kmalloc_array(dev, BITS_TO_LONGS(cxl_cmd_count),
> -				   sizeof(unsigned long),
> -				   GFP_KERNEL | __GFP_ZERO);
> -	if (!cxlm->enabled_cmds)
> -		return ERR_PTR(-ENOMEM);
>  
>  	return cxlm;
>  }
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index b7122ded3a04..df4f3636a999 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -116,7 +116,7 @@ struct cxl_mem {
>  	size_t lsa_size;
>  	struct mutex mbox_mutex; /* Protects device mailbox and firmware */
>  	char firmware_version[0x10];
> -	unsigned long *enabled_cmds;
> +	DECLARE_BITMAP(enabled_cmds, CXL_MEM_COMMAND_ID_MAX);
>  
>  	struct range pmem_range;
>  	struct range ram_range;
> 

