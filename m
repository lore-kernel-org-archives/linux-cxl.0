Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86B6CC43219
	for <linux-cxl@archiver.kernel.org>; Fri,  4 Nov 2022 23:25:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbiKDXZk (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 4 Nov 2022 19:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbiKDXZL (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 4 Nov 2022 19:25:11 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82224B7E8
        for <linux-cxl@vger.kernel.org>; Fri,  4 Nov 2022 16:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667604310; x=1699140310;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Unif0ktkbRSL1susswj+zgSqiw7X+CQyR0ZnBdn9460=;
  b=Bl5Qwp/31inySl8BT1mL8Z78E9HIUitLNuVJsJdvAjT2fh81V1aPXhJf
   sl1O6GPiXdHifvyw12KYEU8gksnlO+WwxmESm38t7E/Bedk4ZJ7tRJmPY
   qgxAZNxHUhX8xfLeOudnOH4TjBVK4QLLJQGgGRJAvgvPBU1Ahsb7Upwfe
   0q9/8m7XQzpqySYJSnAYzt4mve3VockVMX5XPSKDYb8R5DGvXEUuAL4N8
   pU7xhqEeinMlSLRiwGX4RNHq9A0RM/ASVgyyzfdc2+tX3higl6n4j/BjS
   KgPQmyXqh59+k1cmsWQYayQAddu5BcIDW0b6+zNSrkizjAdHSm2S8A3mQ
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10521"; a="372203346"
X-IronPort-AV: E=Sophos;i="5.96,139,1665471600"; 
   d="scan'208";a="372203346"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2022 16:25:09 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10521"; a="629887493"
X-IronPort-AV: E=Sophos;i="5.96,139,1665471600"; 
   d="scan'208";a="629887493"
Received: from djiang5-mobl2.amr.corp.intel.com (HELO [10.212.112.74]) ([10.212.112.74])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2022 16:25:09 -0700
Message-ID: <599244d2-70af-dda3-a1c0-d098c88c1f4a@intel.com>
Date:   Fri, 4 Nov 2022 16:25:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.1
Subject: Re: [RFC PATCH v2 1/4] cxl/mbox: Use local cxl_device_state variable
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-cxl@vger.kernel.org
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>, linuxarm@huawei.com,
        "Viacheslav A . Dubeyko" <viacheslav.dubeyko@bytedance.com>
References: <20221025104243.20836-1-Jonathan.Cameron@huawei.com>
 <20221025104243.20836-2-Jonathan.Cameron@huawei.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20221025104243.20836-2-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 10/25/2022 3:42 AM, Jonathan Cameron wrote:
> Given we have cxlds as a local variable, use that rather than
> getting it again from cxlmd.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

This patch can be split out and go upstream as a cleanup now right?

> ---
>   drivers/cxl/core/mbox.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 0c90f13870a4..dd9e0aac37ae 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -539,7 +539,7 @@ int cxl_send_cmd(struct cxl_memdev *cxlmd, struct cxl_send_command __user *s)
>   	if (copy_from_user(&send, s, sizeof(send)))
>   		return -EFAULT;
>   
> -	rc = cxl_validate_cmd_from_user(&mbox_cmd, cxlmd->cxlds, &send);
> +	rc = cxl_validate_cmd_from_user(&mbox_cmd, cxlds, &send);
>   	if (rc)
>   		return rc;
>   
