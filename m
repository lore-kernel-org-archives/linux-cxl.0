Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C2D2C761A6
	for <linux-cxl@archiver.kernel.org>; Fri, 31 Mar 2023 19:11:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbjCaTK7 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 31 Mar 2023 15:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjCaTK6 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 31 Mar 2023 15:10:58 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A74422EAE
        for <linux-cxl@vger.kernel.org>; Fri, 31 Mar 2023 12:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680289857; x=1711825857;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=i5gl9SGdP20E1QuwclacAyDKlRopohqmw1haEG4Ev+A=;
  b=Bf/8uG+Qp1WViRVo/yWgkk0f80N4M2/d9ZYBaIsSG7kTAgo8IYfFJxfs
   ffWnx/YhgBe5BM7Z6UNLK84z/5ldSSwwdZHTUm0B3aHguUuWs7u9XYZAN
   BMQzsHwIddLAcTBqINOqTjOhxjThi+M1rXzr2f9HrwpkyD8/JtvNG8v9T
   JkE9Y9LFbhuLaP8sihne1dB98FagjjOkzE8rSsTrjnZHYhZg0HUO4xnHI
   2q4ZPQU5ydq74oVF5DBNsWbrqr5j2d3/ExPmwgXBnKt7G6HyDsofVUIC2
   6jrM558n4LSqeahVQntYFLuDbEeytuD60m5Qi5m0usTg8G78SEStRGkUC
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10666"; a="321193712"
X-IronPort-AV: E=Sophos;i="5.98,307,1673942400"; 
   d="scan'208";a="321193712"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2023 12:10:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10666"; a="715560267"
X-IronPort-AV: E=Sophos;i="5.98,307,1673942400"; 
   d="scan'208";a="715560267"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.212.71.212]) ([10.212.71.212])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2023 12:10:55 -0700
Message-ID: <69215b71-15f6-385c-982f-4504c575b029@intel.com>
Date:   Fri, 31 Mar 2023 12:10:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.9.0
Subject: Re: [PATCH v5 07/12] cxl/mbox: Block inject and clear poison opcodes
 in raw mode
Content-Language: en-US
To:     alison.schofield@intel.com,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>
Cc:     linux-cxl@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <cover.1679892337.git.alison.schofield@intel.com>
 <0ca99f94e976a776b5ab7af86b75a556354daab7.1679892337.git.alison.schofield@intel.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <0ca99f94e976a776b5ab7af86b75a556354daab7.1679892337.git.alison.schofield@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 3/26/23 10:03 PM, alison.schofield@intel.com wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> Inject and clear poison are commands intended for debug environments,
> and can cause data corruption if issued without validation. They are
> kernel exclusive commands not available to userspace through ioctls,
> but could be submitted via the raw mode ioctl.
> 
> Add inject and clear poison to the cxl_disabled_raw_commands[] list.
> Attempts by userspace to issue either command via the RAW ioctl fail
> with -EPERM.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>   drivers/cxl/core/mbox.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index a8369ef56f61..b380208f85c2 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -89,6 +89,9 @@ static struct cxl_mem_command cxl_mem_commands[CXL_MEM_COMMAND_ID_MAX] = {
>    *
>    * CXL_MBOX_OP_[GET_]SCAN_MEDIA: The kernel provides a native error list that
>    * is kept up to date with patrol notifications and error management.
> + *
> + * CXL_MBOX_OP_[INJECT|CLEAR]_POISON: The kernel provides a debugfs interface
> + * to these commands. See: Documentation/ABI/testing/debugfs-cxl
>    */
>   static u16 cxl_disabled_raw_commands[] = {
>   	CXL_MBOX_OP_ACTIVATE_FW,
> @@ -97,6 +100,8 @@ static u16 cxl_disabled_raw_commands[] = {
>   	CXL_MBOX_OP_SET_SHUTDOWN_STATE,
>   	CXL_MBOX_OP_SCAN_MEDIA,
>   	CXL_MBOX_OP_GET_SCAN_MEDIA,
> +	CXL_MBOX_OP_INJECT_POISON,
> +	CXL_MBOX_OP_CLEAR_POISON,
>   };
>   
>   /*
