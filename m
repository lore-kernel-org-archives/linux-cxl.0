Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 844EAC54EAA
	for <linux-cxl@archiver.kernel.org>; Mon, 30 Jan 2023 16:31:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237540AbjA3Qbq (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 30 Jan 2023 11:31:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236233AbjA3Qbq (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 30 Jan 2023 11:31:46 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3B7F3525C
        for <linux-cxl@vger.kernel.org>; Mon, 30 Jan 2023 08:31:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675096305; x=1706632305;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=LhP26Gf4vsD0ppY9KxFZKxe7LRkvrpyAYwaF5AXBxDs=;
  b=lkD9jgg00ZJdqc7ZuXVPAbbP40rvC1UFztiwL+FyeF2+kOAoCaH6YudT
   +L9ph/23tzZo4suoIfciY9N3FHg46Na9sUmmQ6fheVs+5fCcNSbe5QtU4
   P1q6td7x2CCpUxcdM0RynwJGo5YJ9d0Kx5t4Otf4SabO4mHU9JMA4nyEm
   PeAKYw61clQQH6Bs+NVF6KK+CaFD2NLuqTcKuhmnDYKqMlqcHqaHhdKUt
   Xx7CsASy9xCLfAnKRZeU+kQfQLi7kWk82NjgJHbThRviBJocmLcL2WI3p
   2aEulAnUrkNWjOXehACWPmqvNVyaGqQM4Lw1fC7n/WyEIHofaqs5z+P/i
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="329716526"
X-IronPort-AV: E=Sophos;i="5.97,258,1669104000"; 
   d="scan'208";a="329716526"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 08:31:44 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="772574583"
X-IronPort-AV: E=Sophos;i="5.97,258,1669104000"; 
   d="scan'208";a="772574583"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.212.68.245]) ([10.212.68.245])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 08:31:40 -0800
Message-ID: <4a01329f-c6e2-243c-158f-8ba101ddb68d@intel.com>
Date:   Mon, 30 Jan 2023 09:31:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.0
Subject: Re: [PATCH] cxl/mbox: Add missing parameter to docs.
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-cxl@vger.kernel.org
Cc:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>, linuxarm@huawei.com
References: <20230130153437.3153-1-Jonathan.Cameron@huawei.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230130153437.3153-1-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 1/30/23 8:34 AM, Jonathan Cameron wrote:
> Kernel-doc should be complete, so add documentation for the status
> parameter.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> 
> ---
> Fixes  ("cxl/mem: Read, trace, and clear events on driver load")
> 
> Bad fixes tag is deliberate as patch is currently only in the cxl/pending
> branch. Feel free to squash this or drop the fixes entirely.
> 
> I'm odd and for various reasons run W=1 builds. The resulting
> warning has been irritating me, hence the fixlet.
> ---
>   drivers/cxl/core/mbox.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index a0bd2170af48..03909b6cef55 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -913,6 +913,7 @@ static void cxl_mem_get_records_log(struct cxl_dev_state *cxlds,
>   /**
>    * cxl_mem_get_event_records - Get Event Records from the device
>    * @cxlds: The device data for the operation
> + * @status: Event Status register value identifying which events are available.
>    *
>    * Retrieve all event records available on the device, report them as trace
>    * events, and clear them.
