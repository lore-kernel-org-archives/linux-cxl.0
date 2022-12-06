Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90BCAC352A1
	for <linux-cxl@archiver.kernel.org>; Tue,  6 Dec 2022 16:56:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232511AbiLFQ4s (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 6 Dec 2022 11:56:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231990AbiLFQ4r (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 6 Dec 2022 11:56:47 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACE2F1FF8E
        for <linux-cxl@vger.kernel.org>; Tue,  6 Dec 2022 08:56:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670345806; x=1701881806;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ogpqdro3gpMwfCO10RwJiyKcYI7EO4ufQ6AHsExhxNQ=;
  b=hVuAxcv+AbGeOXlisy95JytELa6sdRHfFtXBeNBYYM8BDv+p5YunMMIG
   rxBdgGiC09c7UNoZ3Ke3rz3ChD2BFnBhyZWqQGIX1+c/x8Qn+0oUgHDLL
   PZ4ZIpWImpvV+BFPnI1CEWU1lSzs7nl27w99vP8HDabFaseJ/CQEyp/MC
   +gos44dBFZocnwKwiCiAeeUPPAHTXaHHG/jItYCwTiaJdakLModt12oU4
   qyAQpaOfuZ3tQmS0YrvHQ87CvPt0E6KTqcE1ttrS6XgCnSI24uuYUlEhY
   g32jsmvI4mp7vz916ppPyzOYcwhXSgk8dcBzEx3axn9ZBZNp2s+//0NAt
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="297031146"
X-IronPort-AV: E=Sophos;i="5.96,222,1665471600"; 
   d="scan'208";a="297031146"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2022 08:56:46 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="820643246"
X-IronPort-AV: E=Sophos;i="5.96,222,1665471600"; 
   d="scan'208";a="820643246"
Received: from djiang5-mobl2.amr.corp.intel.com (HELO [10.212.108.100]) ([10.212.108.100])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2022 08:56:45 -0800
Message-ID: <ee039ca8-4d50-b707-5208-e0cc02af231b@intel.com>
Date:   Tue, 6 Dec 2022 09:56:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.5.1
Subject: Re: [PATCH 4/4] cxl/security: Drop security command ioctl uapi
Content-Language: en-US
To:     Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Cc:     ira.weiny@intel.com
References: <167030054261.4044561.2164047490200738083.stgit@dwillia2-xfh.jf.intel.com>
 <167030056464.4044561.11486507095384253833.stgit@dwillia2-xfh.jf.intel.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <167030056464.4044561.11486507095384253833.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 12/5/2022 9:22 PM, Dan Williams wrote:
> CXL PMEM security operations are routed through the NVDIMM sysfs
> interface. For this reason the corresponding commands are marked
> "exclusive" to preclude collisions between the ioctl ABI and the sysfs
> ABI. However, a better way to preclude that collision is to simply
> remove the ioctl ABI (command-id definitions) for those operations.
> 
> Now that cxl_internal_send_cmd() (formerly cxl_mbox_send_cmd()) no
> longer needs to talk the cxl_mem_commands array, all of the uapi
> definitions for the security commands can be dropped.
> 
> These never appeared in a released kernel, so no regression risk.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>   drivers/cxl/core/mbox.c      |   17 -----------------
>   include/uapi/linux/cxl_mem.h |    6 ------
>   2 files changed, 23 deletions(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index c36a3589377a..b03fba212799 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -65,12 +65,6 @@ static struct cxl_mem_command cxl_mem_commands[CXL_MEM_COMMAND_ID_MAX] = {
>   	CXL_CMD(GET_SCAN_MEDIA_CAPS, 0x10, 0x4, 0),
>   	CXL_CMD(SCAN_MEDIA, 0x11, 0, 0),
>   	CXL_CMD(GET_SCAN_MEDIA, 0, CXL_VARIABLE_PAYLOAD, 0),
> -	CXL_CMD(GET_SECURITY_STATE, 0, 0x4, 0),
> -	CXL_CMD(SET_PASSPHRASE, 0x60, 0, 0),
> -	CXL_CMD(DISABLE_PASSPHRASE, 0x40, 0, 0),
> -	CXL_CMD(FREEZE_SECURITY, 0, 0, 0),
> -	CXL_CMD(UNLOCK, 0x20, 0, 0),
> -	CXL_CMD(PASSPHRASE_SECURE_ERASE, 0x40, 0, 0),
>   };
>   
>   /*
> @@ -717,17 +711,6 @@ int cxl_enumerate_cmds(struct cxl_dev_state *cxlds)
>   		/* Found the required CEL */
>   		rc = 0;
>   	}
> -
> -	/*
> -	 * Setup permanently kernel exclusive commands, i.e. the
> -	 * mechanism is driven through sysfs, keyctl, etc...
> -	 */
> -	set_bit(CXL_MEM_COMMAND_ID_SET_PASSPHRASE, cxlds->exclusive_cmds);
> -	set_bit(CXL_MEM_COMMAND_ID_DISABLE_PASSPHRASE, cxlds->exclusive_cmds);
> -	set_bit(CXL_MEM_COMMAND_ID_UNLOCK, cxlds->exclusive_cmds);
> -	set_bit(CXL_MEM_COMMAND_ID_PASSPHRASE_SECURE_ERASE,
> -		cxlds->exclusive_cmds);
> -
>   out:
>   	kvfree(gsl);
>   	return rc;
> diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_mem.h
> index 82bdad4ce5de..c71021a2a9ed 100644
> --- a/include/uapi/linux/cxl_mem.h
> +++ b/include/uapi/linux/cxl_mem.h
> @@ -41,12 +41,6 @@
>   	___C(GET_SCAN_MEDIA_CAPS, "Get Scan Media Capabilities"),         \
>   	___C(SCAN_MEDIA, "Scan Media"),                                   \
>   	___C(GET_SCAN_MEDIA, "Get Scan Media Results"),                   \
> -	___C(GET_SECURITY_STATE, "Get Security State"),			  \
> -	___C(SET_PASSPHRASE, "Set Passphrase"),				  \
> -	___C(DISABLE_PASSPHRASE, "Disable Passphrase"),			  \
> -	___C(FREEZE_SECURITY, "Freeze Security"),			  \
> -	___C(UNLOCK, "Unlock"),						  \
> -	___C(PASSPHRASE_SECURE_ERASE, "Passphrase Secure Erase"),	  \
>   	___C(MAX, "invalid / last command")
>   
>   #define ___C(a, b) CXL_MEM_COMMAND_ID_##a
> 
