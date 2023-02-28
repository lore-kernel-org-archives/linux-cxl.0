Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BFAEC64EC7
	for <linux-cxl@archiver.kernel.org>; Tue, 28 Feb 2023 15:47:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbjB1Pr0 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 28 Feb 2023 10:47:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjB1PrZ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 28 Feb 2023 10:47:25 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBFA54C22
        for <linux-cxl@vger.kernel.org>; Tue, 28 Feb 2023 07:47:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677599244; x=1709135244;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=jg7OFbM61BCcAlxZ3xQci0h+HEiVqaTTRGM2VuJouXg=;
  b=hqyIAAKv0DGXZhr5Uallu1ifWziZKNpNUKaaaCEa5k4cwvuocIdt2H7y
   KkN80jTmilNl0x/D/yvrUWoND++9YtUoKXFgMR3rqSgKjYSHgn18YIJJ+
   +pwws3pjuREq97J7sATaS2G9vixFhYvrTi9lk4DcbDpS6Zmy47LBVF2zC
   4Apqn1Ax7hso9U2/MJeuOKk9Em/6ulzkDKIRhZYZ5YGWFarr0xGV4mJos
   zJUfjZAo2lXBwRmR4XKrsXMoYQiWWaNEbWAbOlvhxef6vhP+5xOtPka6j
   ISh8enC1TkO0uU7sWFXqkm3xzkq/NYA1s+cdSwJItlefh/G9I+PLk9Lv0
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="313840084"
X-IronPort-AV: E=Sophos;i="5.98,222,1673942400"; 
   d="scan'208";a="313840084"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2023 07:44:57 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="1003264853"
X-IronPort-AV: E=Sophos;i="5.98,222,1673942400"; 
   d="scan'208";a="1003264853"
Received: from nmorar-mobl.amr.corp.intel.com (HELO [10.212.1.236]) ([10.212.1.236])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2023 07:44:57 -0800
Message-ID: <6aa99bed-5f73-479b-a4e1-c170d821e1fc@intel.com>
Date:   Tue, 28 Feb 2023 08:44:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.0
Subject: Re: [PATCH] cxl/mbox: Drop extra struct resource cast
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-cxl@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linuxarm@huawei.com
References: <20230228152112.14774-1-Jonathan.Cameron@huawei.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230228152112.14774-1-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 2/28/23 8:21 AM, Jonathan Cameron wrote:
> DEFINE_RES_MEM() is a wrapper around the DEFINE_RES_NAMED()
> macro which already has the (struct resource) cast.
> 
> Fixes warnings with W=1 C=1
>    CC [M]  drivers/cxl/core/mbox.o
>    CHECK   drivers/cxl/core/mbox.c
> drivers/cxl/core/mbox.c:1064:18: warning: cast to non-scalar
> drivers/cxl/core/mbox.c:1064:18: warning: cast from non-scalar
> 
> Fixes: 52c4d11f1dce ("resource: Convert DEFINE_RES_NAMED() to be compound literal")
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
> 
> I'm seeing a couple of other instances of this
> drivers/acpi/arm64/gtdt.c
> arch/arm/mach-shmobile/pm-rcar-gen2.c
> 
> Might get around to fixing them but more than happy if someone beats me to it.
> 
>   drivers/cxl/core/mbox.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index f2addb457172..dce16088ceee 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -1052,8 +1052,7 @@ int cxl_mem_create_range_info(struct cxl_dev_state *cxlds)
>   	struct device *dev = cxlds->dev;
>   	int rc;
>   
> -	cxlds->dpa_res =
> -		(struct resource)DEFINE_RES_MEM(0, cxlds->total_bytes);
> +	cxlds->dpa_res = DEFINE_RES_MEM(0, cxlds->total_bytes);
>   
>   	if (cxlds->partition_align_bytes == 0) {
>   		rc = add_dpa_res(dev, &cxlds->dpa_res, &cxlds->ram_res, 0,
