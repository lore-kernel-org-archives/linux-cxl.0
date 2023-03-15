Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ACF6C6FD1D
	for <linux-cxl@archiver.kernel.org>; Wed, 15 Mar 2023 16:59:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbjCOQ7h (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 15 Mar 2023 12:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbjCOQ7g (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 15 Mar 2023 12:59:36 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2F1730290
        for <linux-cxl@vger.kernel.org>; Wed, 15 Mar 2023 09:59:34 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PcGkj537nz6J9r5;
        Thu, 16 Mar 2023 00:56:29 +0800 (CST)
Received: from localhost (10.126.171.21) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Wed, 15 Mar
 2023 16:59:32 +0000
Date:   Wed, 15 Mar 2023 16:59:31 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     <alison.schofield@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ben Widawsky" <bwidawsk@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v4 7/8] cxl/memdev: Make inject and clear poison cmds
 kernel exclusive
Message-ID: <20230315165931.00007228@Huawei.com>
In-Reply-To: <66f6c36d20fa6ab906fe800bcf7059d1f5a552e6.1678471465.git.alison.schofield@intel.com>
References: <cover.1678471465.git.alison.schofield@intel.com>
        <66f6c36d20fa6ab906fe800bcf7059d1f5a552e6.1678471465.git.alison.schofield@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.171.21]
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, 10 Mar 2023 10:49:08 -0800
alison.schofield@intel.com wrote:

> From: Alison Schofield <alison.schofield@intel.com>
> 
> Inject and clear poison commands are intended to be used in debug
> mode only, and if improperly used, can lead to data corruption. The
> kernel provides a sysfs interface that provides the protection needed
> to issue these commands [1]
> 
> The CXL driver defines Enabled commands in its ABI.[2] Enabled means
> that the device and the driver both support the command. If a device
> supports inject and/or clear, those commands are flagged Enabled.
> 
> The ABI also defines another command flag: Exclusive. Exclusive
> commands are reserved for kernel use. The exclusive flags can be
> temporal, but for inject and clear, the status is permanent.
> 
> Document the exclusivity of Inject and Clear in the ABI kernel doc.
> (Clean up a typo in kdoc too: 'CXL_MEM_COMMAND_FLAG_ENABLED')
> 
> Create an exclusive commands bitmap in the memdev driver, add the
> inject and clear poison commands, and set it in the cxl_dev_state.
> 
> [1] Documentation/ABI/testing/sysfs-bus-cxl
> [2] include/uapi/linux/cxl_mem.h
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>

Trivial whitespace issue inline.  Otherwise LGTM

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>


> ---
>  drivers/cxl/core/memdev.c    |  6 ++++++
>  include/uapi/linux/cxl_mem.h | 21 ++++++++++++++++-----
>  2 files changed, 22 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 5dd334c4caf2..6ca2815d5c12 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -10,6 +10,8 @@
>  
>  static DECLARE_RWSEM(cxl_memdev_rwsem);
>  
> +static __read_mostly DECLARE_BITMAP(exclusive_cmds, CXL_MEM_COMMAND_ID_MAX);
> +
>  /*
>   * An entire PCI topology full of devices should be enough for any
>   * config
> @@ -574,6 +576,10 @@ struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds)
>  	cxlmd->cxlds = cxlds;
>  	cxlds->cxlmd = cxlmd;
>  
> +	set_bit(CXL_MEM_COMMAND_ID_INJECT_POISON, exclusive_cmds);
> +	set_bit(CXL_MEM_COMMAND_ID_CLEAR_POISON, exclusive_cmds);
> +	set_exclusive_cxl_commands(cxlds, exclusive_cmds);
> +
>  	cdev = &cxlmd->cdev;
>  	rc = cdev_device_add(cdev, dev);
>  	if (rc)
> diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_mem.h
> index 86bbacf2a315..6f9ae244f7fd 100644
> --- a/include/uapi/linux/cxl_mem.h
> +++ b/include/uapi/linux/cxl_mem.h
> @@ -74,17 +74,28 @@ static const struct {
>   * @id: ID number for the command.
>   * @flags: Flags that specify command behavior.
>   *
> - *         CXL_MEM_COMMAND_FLAG_USER_ENABLED
> + *         CXL_MEM_COMMAND_FLAG_ENABLED
>   *
>   *         The given command id is supported by the driver and is supported by
>   *         a related opcode on the device.
>   *
>   *         CXL_MEM_COMMAND_FLAG_EXCLUSIVE
>   *
> - *         Requests with the given command id will terminate with EBUSY as the
> - *         kernel actively owns management of the given resource. For example,
> - *         the label-storage-area can not be written while the kernel is
> - *         actively managing that space.
> + *	   The given command id is for kernel exclusive use and is not

Diff gave away an inconsistency here via it's alignment.
Probably just replace the tab with spaces to match previous code.


> + *	   available to userspace. Requests will terminate with EBUSY.
> + *
> + *	   The exclusive flag may be temporal, and only set while the
> + *	   kernel actively owns management of the given resource. For
> + *	   example, the label-storage-area can not be written while the
> + *	   kernel is actively managing that space.
> + *
> + *	   The exclusive flag can be permanent, as in commands that can
> + *	   never be issued through the ioctl interface.
> + *
> + *	   INJECT_POISON and CLEAR_POISON are permanently kernel exclusive.
> + *	   They are supported through a sysfs interface that validates the
> + *	   safety of each command based on the state of the memdev.
> + *	   See: Documentation/ABI/testing/sysfs-bus-cxl
>   *
>   * @size_in: Expected input size, or ~0 if variable length.
>   * @size_out: Expected output size, or ~0 if variable length.

