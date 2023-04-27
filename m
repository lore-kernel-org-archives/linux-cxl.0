Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C421C77B61
	for <linux-cxl@archiver.kernel.org>; Thu, 27 Apr 2023 15:48:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243992AbjD0PsR (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 27 Apr 2023 11:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243830AbjD0PsQ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 27 Apr 2023 11:48:16 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C002D79
        for <linux-cxl@vger.kernel.org>; Thu, 27 Apr 2023 08:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682610493; x=1714146493;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=n4soCfceMqRxSMId8+pcz93PLLEDo1GlWsKFesA6lKQ=;
  b=JEFpby34yNJslvcT23UKPbROzQXYOgf3c+gvs5Eci1T/TttT4m1IMwLX
   z6kazI6UU0R7cDNZQMQD2nTyqIdGSZnb/p8DmY6ljBhzp7DA5KFExIQKR
   IutrX8o1zTeGvkiqlUCHhOxFrjgk80M4BwpyrqmJax7/P7rCeNBD9nTPg
   FZN58iCQ9S4u93Rgm8sEPA7pucIkPlbQayc04H4AK+Jy074xDJOcDuRQZ
   YXzRjeEmrCBsSngTra4Yq0URuCNi+BplMhHpomMNQPCl6QgptezxMZaw3
   gelBUwj2iG+j3+WXIO7PZCm+V+UI2ytG9pmwes3/yvwTlRmWGPVKzTexf
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="327090165"
X-IronPort-AV: E=Sophos;i="5.99,230,1677571200"; 
   d="scan'208";a="327090165"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2023 08:48:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="724965283"
X-IronPort-AV: E=Sophos;i="5.99,230,1677571200"; 
   d="scan'208";a="724965283"
Received: from abenich-mobl.amr.corp.intel.com (HELO [10.212.123.129]) ([10.212.123.129])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2023 08:48:02 -0700
Message-ID: <f016a0e0-9b2b-4d2a-f9c9-4757525ee351@intel.com>
Date:   Thu, 27 Apr 2023 08:48:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.0
Subject: Re: [PATCH v2] cxl: Warn of flexible array in struct cxl_root_decoder
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     dan.j.williams@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com, ira.weiny@intel.com
References: <168261037969.369141.13800655850844046872.stgit@djiang5-mobl3>
In-Reply-To: <168261037969.369141.13800655850844046872.stgit@djiang5-mobl3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 4/27/23 8:46 AM, Dave Jiang wrote:
> The 'cxl_switch_decoder' member in 'cxl_root_decoder' must be the last
> element due to 'cxl_switch_decoder' has a flexible array at the
> end of the struct. Any variables placed after will be corrupted.
> Add a warning comment to 'cxl_root_decoder'.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Please disregard this version. Diff wasn't updated.

> 
> ---
> v2:
> - Clarify subject (Alison)
> - Fit comment under 80 chars. (Alison)
> ---
>   drivers/cxl/cxl.h |    1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 044a92d9813e..999c0aa5ed54 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -419,6 +419,7 @@ struct cxl_root_decoder {
>   	cxl_calc_hb_fn calc_hb;
>   	void *platform_data;
>   	struct mutex range_lock;
> +	/* This must be the last member of the struct. It contains a flexible array */
>   	struct cxl_switch_decoder cxlsd;
>   };
>   
> 
> 
