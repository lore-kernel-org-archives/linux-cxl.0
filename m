Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D910C05027
	for <linux-cxl@archiver.kernel.org>; Fri, 17 Feb 2023 21:59:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbjBQV7d (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 17 Feb 2023 16:59:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjBQV7c (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 17 Feb 2023 16:59:32 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EDDA59726
        for <linux-cxl@vger.kernel.org>; Fri, 17 Feb 2023 13:59:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676671172; x=1708207172;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9rFXKQKYXkDjn2mTILG5+hmWGqUGN2tqB//SQOvTZtQ=;
  b=HhSFQJvBdHzqVniX4r6MACUi4GpZjTxH7nWX29HGpqMK5z7LQP490s72
   0+ILvmV5n+1KfL/tFjh2zquZy5jtjB04kCbsAEoeq7lieM9aYZufZ4fl/
   ZHXbJrv+qfTONNvwbIYF3YZ28ti0cPdj0vkGQKeeQjk01PzOb8q5tEhzg
   DQMmgd3rY9s+VBrreECmXD/4IfQ9UOlZS1bjdgkEGZBdHJIBlqnKe5KdW
   4wdm/VBchHVFyg1Q5dPErymD7+gylxjSeM6t5I7V6B27ONkZ0Oj3CJHkw
   m/VFnNypmlO6JiPHePQnG57vgqmbh2eJUl4reAdoaFy4WxRYRXUQiRVht
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10624"; a="311727218"
X-IronPort-AV: E=Sophos;i="5.97,306,1669104000"; 
   d="scan'208";a="311727218"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2023 13:59:31 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10624"; a="648208386"
X-IronPort-AV: E=Sophos;i="5.97,306,1669104000"; 
   d="scan'208";a="648208386"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.213.187.252]) ([10.213.187.252])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2023 13:59:30 -0800
Message-ID: <67625ea3-7e5a-d9c1-82db-57227827b96f@intel.com>
Date:   Fri, 17 Feb 2023 14:59:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.0
Subject: Re: [PATCH v4 6/8] hw/cxl: Fix endian issues in CXL RAS capability
 defaults / masks
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        qemu-devel@nongnu.org, Michael Tsirkin <mst@redhat.com>
Cc:     Ben Widawsky <bwidawsk@kernel.org>, linux-cxl@vger.kernel.org,
        linuxarm@huawei.com, Ira Weiny <ira.weiny@intel.com>,
        Gregory Price <gourry.memverge@gmail.com>,
        =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
        Mike Maslenkin <mike.maslenkin@gmail.com>,
        Markus Armbruster <armbru@redhat.com>
References: <20230217172924.25239-1-Jonathan.Cameron@huawei.com>
 <20230217172924.25239-7-Jonathan.Cameron@huawei.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230217172924.25239-7-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 2/17/23 10:29 AM, Jonathan Cameron wrote:
> As these are about to be modified, fix the endian handle for
> this set of registers rather than making it worse.
> 
> Note that CXL is currently only supported in QEMU on
> x86 (arm64 patches out of tree) so we aren't going to yet hit
> an problems with big endian. However it is good to avoid making
> things worse for that support in the future.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>   hw/cxl/cxl-component-utils.c | 18 +++++++++---------
>   1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/hw/cxl/cxl-component-utils.c b/hw/cxl/cxl-component-utils.c
> index 3edd303a33..737b4764b9 100644
> --- a/hw/cxl/cxl-component-utils.c
> +++ b/hw/cxl/cxl-component-utils.c
> @@ -141,17 +141,17 @@ static void ras_init_common(uint32_t *reg_state, uint32_t *write_msk)
>        * Error status is RW1C but given bits are not yet set, it can
>        * be handled as RO.
>        */
> -    reg_state[R_CXL_RAS_UNC_ERR_STATUS] = 0;
> +    stl_le_p(reg_state + R_CXL_RAS_UNC_ERR_STATUS, 0);
>       /* Bits 12-13 and 17-31 reserved in CXL 2.0 */
> -    reg_state[R_CXL_RAS_UNC_ERR_MASK] = 0x1cfff;
> -    write_msk[R_CXL_RAS_UNC_ERR_MASK] = 0x1cfff;
> -    reg_state[R_CXL_RAS_UNC_ERR_SEVERITY] = 0x1cfff;
> -    write_msk[R_CXL_RAS_UNC_ERR_SEVERITY] = 0x1cfff;
> -    reg_state[R_CXL_RAS_COR_ERR_STATUS] = 0;
> -    reg_state[R_CXL_RAS_COR_ERR_MASK] = 0x7f;
> -    write_msk[R_CXL_RAS_COR_ERR_MASK] = 0x7f;
> +    stl_le_p(reg_state + R_CXL_RAS_UNC_ERR_MASK, 0x1cfff);
> +    stl_le_p(write_msk + R_CXL_RAS_UNC_ERR_MASK, 0x1cfff);
> +    stl_le_p(reg_state + R_CXL_RAS_UNC_ERR_SEVERITY, 0x1cfff);
> +    stl_le_p(write_msk + R_CXL_RAS_UNC_ERR_SEVERITY, 0x1cfff);
> +    stl_le_p(reg_state + R_CXL_RAS_COR_ERR_STATUS, 0);
> +    stl_le_p(reg_state + R_CXL_RAS_COR_ERR_MASK, 0x7f);
> +    stl_le_p(write_msk + R_CXL_RAS_COR_ERR_MASK, 0x7f);
>       /* CXL switches and devices must set */
> -    reg_state[R_CXL_RAS_ERR_CAP_CTRL] = 0x00;
> +    stl_le_p(reg_state + R_CXL_RAS_ERR_CAP_CTRL, 0x00);
>   }
>   
>   static void hdm_init_common(uint32_t *reg_state, uint32_t *write_msk,
