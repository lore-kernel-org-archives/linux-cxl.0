Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 859ABC6FD1A
	for <linux-cxl@archiver.kernel.org>; Tue,  7 Mar 2023 16:11:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230395AbjCGQLB (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 7 Mar 2023 11:11:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbjCGQKo (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 7 Mar 2023 11:10:44 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 093AD2BF05
        for <linux-cxl@vger.kernel.org>; Tue,  7 Mar 2023 08:10:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678205402; x=1709741402;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=UtTMiuZBmqVfmqo4hRx1hPccuh4G6Q+uGh+f6dxG0CA=;
  b=UNwCjtSp0JCtXkG4swVCKTDyMvHbAcBGSRXK8ZyzecQhDkLGkO7IKWeB
   euVIsjbzd1mSKtFbeyX4T4WA7JexLiw8IFtSA9V3hxhjfZvasvfNuteaK
   bkQVjuvqxxCSUWUEgzDiZwsr0o9C5xfzsAdj7Ueo3Pu5AKSBcVwBbwhEH
   sM8qJ4XaZgPbmdTHs7yUgfQRbju1eb0nV/uAfgTuXvmFRBbMGNaLGLCsx
   WQ+FaIIjbHoUS4hYIKJ+cuJCUcirW7qF/zaoqgfrh5DIiQl750qIoG9rC
   f9dL24fCKwq5b90E7KVKo6r4hxka62kwrK/PwgJHAqmFdr+HG7aKOt2MJ
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="335913036"
X-IronPort-AV: E=Sophos;i="5.98,241,1673942400"; 
   d="scan'208";a="335913036"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2023 08:10:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="850751499"
X-IronPort-AV: E=Sophos;i="5.98,241,1673942400"; 
   d="scan'208";a="850751499"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.212.116.173]) ([10.212.116.173])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2023 08:10:01 -0800
Message-ID: <86f92cf2-54ae-c444-c6db-61c8dbf383ec@intel.com>
Date:   Tue, 7 Mar 2023 09:10:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.0
Subject: Re: [PATCH] cxl/mbox: Update CMD_RC_TABLE
Content-Language: en-US
To:     Davidlohr Bueso <dave@stgolabs.net>, dan.j.williams@intel.com
Cc:     Jonathan.Cameron@huawei.com, fan.ni@samsung.com,
        a.manzanares@samsung.com, linux-cxl@vger.kernel.org
References: <20230307042655.6714-1-dave@stgolabs.net>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230307042655.6714-1-dave@stgolabs.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 3/6/23 9:26 PM, Davidlohr Bueso wrote:
> As of CXL 3.0 there have some added return codes, update the
> driver accordingly.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>   drivers/cxl/cxlmem.h | 12 ++++++++++--
>   1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index ccbafc05a636..3e5ed04b9d6b 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -127,7 +127,7 @@ struct cxl_mbox_cmd {
>   };
>   
>   /*
> - * Per CXL 2.0 Section 8.2.8.4.5.1
> + * Per CXL 3.0 Section 8.2.8.4.5.1
>    */
>   #define CMD_CMD_RC_TABLE							\
>   	C(SUCCESS, 0, NULL),							\
> @@ -152,7 +152,15 @@ struct cxl_mbox_cmd {
>   	C(SECURITY, -ENXIO, "not valid in the current security state"),         \
>   	C(PASSPHRASE, -ENXIO, "phrase doesn't match current set passphrase"),   \
>   	C(MBUNSUPPORTED, -ENXIO, "unsupported on the mailbox it was issued on"),\
> -	C(PAYLOADLEN, -ENXIO, "invalid payload length")
> +	C(PAYLOADLEN, -ENXIO, "invalid payload length"),			\
> +	C(LOG, -ENXIO, "invalid or unsupported log page"),			\
> +	C(INTERRUPTED, -ENXIO, "asynchronous event occured"),			\
> +	C(FEATUREVERSION, -ENXIO, "unsupported feature version"),		\
> +	C(FEATURESELVALUE, -ENXIO, "unsupported feature selection value"),	\
> +	C(FEATURETRANSFERIP, -ENXIO, "feature transfer in progress"),		\
> +	C(FEATURETRANSFEROOO, -ENXIO, "feature transfer out of order"),		\
> +	C(RESOURCEEXHAUSTED, -ENXIO, "resources are exhausted"),		\
> +	C(EXTLIST, -ENXIO, "invalid Extent List"),				\
>   
>   #undef C
>   #define C(a, b, c) CXL_MBOX_CMD_RC_##a
