Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20F2EC3A5A7
	for <linux-cxl@archiver.kernel.org>; Thu,  8 Dec 2022 10:59:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbiLHK7k (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 8 Dec 2022 05:59:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbiLHK7R (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 8 Dec 2022 05:59:17 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF58C8B3A3
        for <linux-cxl@vger.kernel.org>; Thu,  8 Dec 2022 02:51:15 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NSWC51JJBz67qsH;
        Thu,  8 Dec 2022 18:50:25 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 8 Dec
 2022 10:51:13 +0000
Date:   Thu, 8 Dec 2022 10:51:12 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <dave.jiang@intel.com>,
        <ira.weiny@intel.com>
Subject: Re: [PATCH 4/4] cxl/security: Drop security command ioctl uapi
Message-ID: <20221208105112.00003e44@Huawei.com>
In-Reply-To: <167030056464.4044561.11486507095384253833.stgit@dwillia2-xfh.jf.intel.com>
References: <167030054261.4044561.2164047490200738083.stgit@dwillia2-xfh.jf.intel.com>
        <167030056464.4044561.11486507095384253833.stgit@dwillia2-xfh.jf.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, 05 Dec 2022 20:22:44 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

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

Makes sense

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/cxl/core/mbox.c      |   17 -----------------
>  include/uapi/linux/cxl_mem.h |    6 ------
>  2 files changed, 23 deletions(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index c36a3589377a..b03fba212799 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -65,12 +65,6 @@ static struct cxl_mem_command cxl_mem_commands[CXL_MEM_COMMAND_ID_MAX] = {
>  	CXL_CMD(GET_SCAN_MEDIA_CAPS, 0x10, 0x4, 0),
>  	CXL_CMD(SCAN_MEDIA, 0x11, 0, 0),
>  	CXL_CMD(GET_SCAN_MEDIA, 0, CXL_VARIABLE_PAYLOAD, 0),
> -	CXL_CMD(GET_SECURITY_STATE, 0, 0x4, 0),
> -	CXL_CMD(SET_PASSPHRASE, 0x60, 0, 0),
> -	CXL_CMD(DISABLE_PASSPHRASE, 0x40, 0, 0),
> -	CXL_CMD(FREEZE_SECURITY, 0, 0, 0),
> -	CXL_CMD(UNLOCK, 0x20, 0, 0),
> -	CXL_CMD(PASSPHRASE_SECURE_ERASE, 0x40, 0, 0),
>  };
>  
>  /*
> @@ -717,17 +711,6 @@ int cxl_enumerate_cmds(struct cxl_dev_state *cxlds)
>  		/* Found the required CEL */
>  		rc = 0;
>  	}
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
>  out:
>  	kvfree(gsl);
>  	return rc;
> diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_mem.h
> index 82bdad4ce5de..c71021a2a9ed 100644
> --- a/include/uapi/linux/cxl_mem.h
> +++ b/include/uapi/linux/cxl_mem.h
> @@ -41,12 +41,6 @@
>  	___C(GET_SCAN_MEDIA_CAPS, "Get Scan Media Capabilities"),         \
>  	___C(SCAN_MEDIA, "Scan Media"),                                   \
>  	___C(GET_SCAN_MEDIA, "Get Scan Media Results"),                   \
> -	___C(GET_SECURITY_STATE, "Get Security State"),			  \
> -	___C(SET_PASSPHRASE, "Set Passphrase"),				  \
> -	___C(DISABLE_PASSPHRASE, "Disable Passphrase"),			  \
> -	___C(FREEZE_SECURITY, "Freeze Security"),			  \
> -	___C(UNLOCK, "Unlock"),						  \
> -	___C(PASSPHRASE_SECURE_ERASE, "Passphrase Secure Erase"),	  \
>  	___C(MAX, "invalid / last command")
>  
>  #define ___C(a, b) CXL_MEM_COMMAND_ID_##a
> 

