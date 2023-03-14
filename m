Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EF1DC05027
	for <linux-cxl@archiver.kernel.org>; Tue, 14 Mar 2023 18:36:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbjCNSgV (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 14 Mar 2023 14:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbjCNSgJ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 14 Mar 2023 14:36:09 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52077B5B45
        for <linux-cxl@vger.kernel.org>; Tue, 14 Mar 2023 11:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678818941; x=1710354941;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=cXqmczWjn19LHKxt2MSOXLTC9XRnbMsRrIEQk6Zso9U=;
  b=eboPcOr0U/twaFqyTBBAMGM2OynvIbLV3K03wXa2vi9xofLzKg5AHxTM
   YVh7KsxwOLlNH3bxCF486qA0v18YeAyly9404MypqGgj8VVKK5dM78QfF
   DGtAGD2fEDGkrXOy/7JoNJwtpjTQK7jb7GeSAf5wDoGdM0mMMg9f3aaNz
   BQPeR8BvcYVQUDGWScvMbWLLlDSfWggNiKYE6c8C1v68vyAick+eqaC8l
   u2rOdLGk8I4KlYBZ7hfnsiyOkJgVPJYbRLOZZ1N8gGnDkrLArGAZ178cT
   TRdjEoE7ful5f2ry+Awp3t8A4MIyWDDPyzGJnk7BmbgmV/hKOAFliDN7p
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="317162233"
X-IronPort-AV: E=Sophos;i="5.98,260,1673942400"; 
   d="scan'208";a="317162233"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2023 11:35:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="681530813"
X-IronPort-AV: E=Sophos;i="5.98,260,1673942400"; 
   d="scan'208";a="681530813"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.212.15.215]) ([10.212.15.215])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2023 11:34:59 -0700
Message-ID: <cdb8b864-98c3-b4d4-ceec-b0e71fefb10c@intel.com>
Date:   Tue, 14 Mar 2023 11:34:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.0
Subject: Re: [qemu PATCH] hw/cxl/cxl_device: Replace magic number in CXLError
 definition
Content-Language: en-US
To:     Fan Ni <fan.ni@samsung.com>,
        "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc:     "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "alison.schofield@intel.com" <alison.schofield@intel.com>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        Adam Manzanares <a.manzanares@samsung.com>,
        "bwidawsk@kernel.org" <bwidawsk@kernel.org>,
        "gregory.price@memverge.com" <gregory.price@memverge.com>,
        "hchkuo@avery-design.com.tw" <hchkuo@avery-design.com.tw>,
        "cbrowy@avery-design.com" <cbrowy@avery-design.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>
References: <CGME20230314165324uscas1p231d1f8aeceb1b8c118abb76e915e7614@uscas1p2.samsung.com>
 <20230314165317.1550986-1-fan.ni@samsung.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230314165317.1550986-1-fan.ni@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 3/14/23 9:53 AM, Fan Ni wrote:
> Replace the magic number 32 with CXL_RAS_ERR_HEADER_NUM for better code
> readability and maintainability.
> 
> Signed-off-by: Fan Ni <fan.ni@samsung.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>   include/hw/cxl/cxl_device.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index d589f78202..34fde62eac 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -235,7 +235,7 @@ REG64(CXL_MEM_DEV_STS, 0)
>   typedef struct CXLError {
>       QTAILQ_ENTRY(CXLError) node;
>       int type; /* Error code as per FE definition */
> -    uint32_t header[32];
> +    uint32_t header[CXL_RAS_ERR_HEADER_NUM];
>   } CXLError;
>   
>   typedef QTAILQ_HEAD(, CXLError) CXLErrorList;
