Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D548AC636D7
	for <linux-cxl@archiver.kernel.org>; Tue, 21 Feb 2023 16:45:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234231AbjBUQpK (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 21 Feb 2023 11:45:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234973AbjBUQor (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 21 Feb 2023 11:44:47 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA1062D14C
        for <linux-cxl@vger.kernel.org>; Tue, 21 Feb 2023 08:44:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676997878; x=1708533878;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ZhwehMAw41GtMcDVQ6KHdWKXOcaiQZygQ73vYJx2B24=;
  b=FtzpAWi3YG8EDRh89bsy/K/oC1nn9S6FDmdEU2Cvf4xJ/feYFAUzrJSF
   Uq4KUkZUU6XLzVGA0NIgQ1jMZx5URmaoFOATmw+qmayfLkmXuhVqSFeYB
   /z2xcf8H/gM/jncVlEai2Usfy6xunVLo55me1QP9av8PQ48gHDZM4onu9
   p3oAKFlOzXsNUVPRRdMThxhSJIpKdeqLelDqQQnpZBotqDDtjAQ/TcNtF
   UuoneJ/MQl0x/09QYE8CeTSZCCNgjaOq8fKeZwECyTEe3Y/K6YR4ZGLBL
   7jBfSD45xjiN6aCgTkE8v30BdOBW+7JxpWtG71lS7LZ9AoCq93Nn57exb
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10628"; a="334879621"
X-IronPort-AV: E=Sophos;i="5.97,315,1669104000"; 
   d="scan'208";a="334879621"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2023 08:44:14 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10628"; a="845740346"
X-IronPort-AV: E=Sophos;i="5.97,315,1669104000"; 
   d="scan'208";a="845740346"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.213.184.163]) ([10.213.184.163])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2023 08:44:14 -0800
Message-ID: <5cc778de-3ae5-56b9-84d2-9e543c1fc93c@intel.com>
Date:   Tue, 21 Feb 2023 09:44:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.0
Subject: Re: [PATCH ndctl 1/3] cxl/event_trace: fix a resource leak in
 cxl_event_to_json()
Content-Language: en-US
To:     Vishal Verma <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org
Cc:     nvdimm@lists.linux.dev, Dan Williams <dan.j.williams@intel.com>
References: <20230217-coverity-fixes-v1-0-043fac896a40@intel.com>
 <20230217-coverity-fixes-v1-1-043fac896a40@intel.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230217-coverity-fixes-v1-1-043fac896a40@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 2/17/23 5:40 PM, Vishal Verma wrote:
> Static analysis reports that a 'return -ENOMEM' in the above function
> bypasses the error unwinding and leaks 'jevent'.
> 
> Fix the error handling to use the right goto sequence before returning.
> 
> Fixes: 8dedc6cf5e85 ("cxl: add a helper to parse trace events into a json object")
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>   cxl/event_trace.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/cxl/event_trace.c b/cxl/event_trace.c
> index a973a1f..76dd4e7 100644
> --- a/cxl/event_trace.c
> +++ b/cxl/event_trace.c
> @@ -142,7 +142,8 @@ static int cxl_event_to_json(struct tep_event *event, struct tep_record *record,
>   				jobj = num_to_json(data, f->elementsize, f->flags);
>   				if (!jobj) {
>   					json_object_put(jarray);
> -					return -ENOMEM;
> +					rc = -ENOMEM;
> +					goto err_jevent;
>   				}
>   				json_object_array_add(jarray, jobj);
>   				data += f->elementsize;
> 
