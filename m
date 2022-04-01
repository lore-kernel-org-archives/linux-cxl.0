Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFD98C433EF
	for <linux-cxl@archiver.kernel.org>; Fri,  1 Apr 2022 15:53:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345533AbiDAPyv (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 1 Apr 2022 11:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355353AbiDAPOh (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 1 Apr 2022 11:14:37 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1519B2B51A6
        for <linux-cxl@vger.kernel.org>; Fri,  1 Apr 2022 07:57:01 -0700 (PDT)
Received: from fraeml706-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KVNVK07GHz67GrG;
        Fri,  1 Apr 2022 22:54:17 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml706-chm.china.huawei.com (10.206.15.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Fri, 1 Apr 2022 16:56:59 +0200
Received: from localhost (10.202.226.41) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 1 Apr
 2022 15:56:58 +0100
Date:   Fri, 1 Apr 2022 15:56:55 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     <alison.schofield@intel.com>
CC:     Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v5 9/9] cxl/pmem: Remove CXL SET_PARTITION_INFO from
 exclusive_cmds list
Message-ID: <20220401155655.000065df@Huawei.com>
In-Reply-To: <accc6abc878f0662093b81490a1a052f2ff6f06e.1648687552.git.alison.schofield@intel.com>
References: <cover.1648687552.git.alison.schofield@intel.com>
        <accc6abc878f0662093b81490a1a052f2ff6f06e.1648687552.git.alison.schofield@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-ClientProxiedBy: lhreml712-chm.china.huawei.com (10.201.108.63) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, 30 Mar 2022 18:27:19 -0700
alison.schofield@intel.com wrote:

> From: Alison Schofield <alison.schofield@intel.com>
> 
> With SET_PARTITION_INFO on the exclusive_cmds list for the CXL_PMEM
> driver, userspace cannot execute a set-partition command without
> first unbinding the pmem driver from the device.
> 
> When userspace requests a partition change to take effect on the
> next reboot this unbind requirement is unnecessarily restrictive.
> The driver does not need to enforce an unbind because partitions
> will not change until the next reboot. Of course, userspace still
> needs to be aware that changing the size of persistent capacity
> on the next reboot will result in the loss of data stored. That
> can happen regardless of whether it is presently bound at the time
> of issuing the set-partition command.
> 
> When userspace requests a partition change to take effect immediately,
> restrictions are needed. The CXL_MEM driver currently blocks the usage
> of immediate mode, making the presence of SET_PARTITION_INFO, in this
> exclusive commands list, redundant.
> 
> In the future, when the CXL_MEM driver adds support for immediate
> changes to device partitions it will ensure that the partition change
> will not affect any active decode. That means the work will not fall
> right back here, onto the CXL_PMEM driver.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
I gave a an RB on v3...  To make it easy for whoever
picks this up.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/pmem.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/cxl/pmem.c b/drivers/cxl/pmem.c
> index 564d125d25ef..35c6f3af18f2 100644
> --- a/drivers/cxl/pmem.c
> +++ b/drivers/cxl/pmem.c
> @@ -344,7 +344,6 @@ static __init int cxl_pmem_init(void)
>  {
>  	int rc;
>  
> -	set_bit(CXL_MEM_COMMAND_ID_SET_PARTITION_INFO, exclusive_cmds);
>  	set_bit(CXL_MEM_COMMAND_ID_SET_SHUTDOWN_STATE, exclusive_cmds);
>  	set_bit(CXL_MEM_COMMAND_ID_SET_LSA, exclusive_cmds);
>  

