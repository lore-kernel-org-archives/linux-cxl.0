Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E7F2C4321E
	for <linux-cxl@archiver.kernel.org>; Fri,  2 Dec 2022 14:25:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232976AbiLBOZA (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 2 Dec 2022 09:25:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiLBOY7 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 2 Dec 2022 09:24:59 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F213C82CC
        for <linux-cxl@vger.kernel.org>; Fri,  2 Dec 2022 06:24:59 -0800 (PST)
Received: from frapeml100008.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NNw9m1WLkz6HJG7;
        Fri,  2 Dec 2022 22:21:48 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 frapeml100008.china.huawei.com (7.182.85.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 2 Dec 2022 15:24:57 +0100
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 2 Dec
 2022 14:24:57 +0000
Date:   Fri, 2 Dec 2022 14:24:56 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <dave.jiang@intel.com>,
        <nvdimm@lists.linux.dev>, <dave@stgolabs.net>
Subject: Re: [PATCH 3/5] cxl/pmem: Enforce keyctl ABI for PMEM security
Message-ID: <20221202142456.00007617@Huawei.com>
In-Reply-To: <166993221008.1995348.11651567302609703175.stgit@dwillia2-xfh.jf.intel.com>
References: <166993219354.1995348.12912519920112533797.stgit@dwillia2-xfh.jf.intel.com>
        <166993221008.1995348.11651567302609703175.stgit@dwillia2-xfh.jf.intel.com>
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

On Thu, 01 Dec 2022 14:03:30 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> Preclude the possibility of user tooling sending device secrets in the
> clear into the kernel by marking the security commands as exclusive.
> This mandates the usage of the keyctl ABI for managing the device
> passphrase.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Seems reasonable.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/cxl/core/mbox.c |   10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 8747db329087..35dd889f1d3a 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -704,6 +704,16 @@ int cxl_enumerate_cmds(struct cxl_dev_state *cxlds)
>  		rc = 0;
>  	}
>  
> +	/*
> +	 * Setup permanently kernel exclusive commands, i.e. the
> +	 * mechanism is driven through sysfs, keyctl, etc...
> +	 */
> +	set_bit(CXL_MEM_COMMAND_ID_SET_PASSPHRASE, cxlds->exclusive_cmds);
> +	set_bit(CXL_MEM_COMMAND_ID_DISABLE_PASSPHRASE, cxlds->exclusive_cmds);
> +	set_bit(CXL_MEM_COMMAND_ID_UNLOCK, cxlds->exclusive_cmds);
> +	set_bit(CXL_MEM_COMMAND_ID_PASSPHRASE_SECURE_ERASE,
> +		cxlds->exclusive_cmds);
> +
>  out:
>  	kvfree(gsl);
>  	return rc;
> 

