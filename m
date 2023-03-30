Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E14A6C761A6
	for <linux-cxl@archiver.kernel.org>; Thu, 30 Mar 2023 18:24:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbjC3SYi (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 30 Mar 2023 14:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbjC3SYh (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 30 Mar 2023 14:24:37 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 164E55FEB
        for <linux-cxl@vger.kernel.org>; Thu, 30 Mar 2023 11:24:36 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PnWv367RTz6J9X5;
        Fri, 31 Mar 2023 02:20:47 +0800 (CST)
Received: from localhost (10.48.159.148) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Thu, 30 Mar
 2023 19:24:32 +0100
Date:   Thu, 30 Mar 2023 19:24:31 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     <alison.schofield@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ben Widawsky" <bwidawsk@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v3 7/8] cxl/memdev: Make inject and clear poison cmds
 kernel exclusive
Message-ID: <20230330192431.0000585e@Huawei.com>
In-Reply-To: <82199c54a421aeb05fb0e3b4a353a4fed8c98bc9.1677704994.git.alison.schofield@intel.com>
References: <cover.1677704994.git.alison.schofield@intel.com>
        <82199c54a421aeb05fb0e3b4a353a4fed8c98bc9.1677704994.git.alison.schofield@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.159.148]
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed,  1 Mar 2023 13:36:32 -0800
alison.schofield@intel.com wrote:

> From: Alison Schofield <alison.schofield@intel.com>
> 
> Inject and clear poison commands are intended to be used in debug
> mode only, and if improperly used, can lead to data corruption. The
> kernel provides a sysfs interface that provides the protection needed
> to issue these commands.[1]
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
> ---
>  drivers/cxl/core/memdev.c    |  6 ++++++
>  include/uapi/linux/cxl_mem.h | 21 ++++++++++++++++-----
>  2 files changed, 22 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index ed3e4517dc3a..f746a0c222b6 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -10,6 +10,8 @@
>  
>  static DECLARE_RWSEM(cxl_memdev_rwsem);
>  
> +static __read_mostly DECLARE_BITMAP(exclusive_cmds, CXL_MEM_COMMAND_ID_MAX);

Seems like a macro to wrap up the DECLARE_BITMAP and the length
so that we don't have to be careful these are the correct size might be useful.



> +
>  /*
>   * An entire PCI topology full of devices should be enough for any
>   * config
> @@ -571,6 +573,10 @@ struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds)
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
I'm guessing tabs and space differences to the above?

Other than those little things LGTM

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

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

