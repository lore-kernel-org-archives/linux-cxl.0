Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5B92C76196
	for <linux-cxl@archiver.kernel.org>; Fri, 31 Mar 2023 19:10:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbjCaTKZ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 31 Mar 2023 15:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjCaTKY (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 31 Mar 2023 15:10:24 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D439C1D937
        for <linux-cxl@vger.kernel.org>; Fri, 31 Mar 2023 12:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680289823; x=1711825823;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=SYcB2x2Gm8ATVdgdR9ZEaaPiPDn789VN92ADayMAvFE=;
  b=AlVb67VLfGwcGj/gFlJSHjiShQ5smE6Vz3vbX11WYnnzpaL+eyK9gKxG
   xFvboidA/3Z7onXSP0pIHuIdEMJ/oHltRxAvE3XF/QcxkwKUHjk2gxLj+
   3zYAwIJfTCJpFh9X0y7cIkPDwbL36f3Gs9cmxRe1gB5W2NcJLsZdv5psV
   v8c4RtxW6I40WaU6pF0L/oxiFbG1GVQVleBzVjs/7ynkfvdO6Qesha97H
   QqqC3oDq6W5kaClTULMGjgLMCpyw+HwWP8kDsh12+3EdU8Oy4RbOIJNy6
   7ksBHRPeeL6HXKfWJPgcSt2XJcyYWUfPSyGXc9mgstwbWsy4gYa3qj9RX
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10666"; a="321193532"
X-IronPort-AV: E=Sophos;i="5.98,307,1673942400"; 
   d="scan'208";a="321193532"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2023 12:10:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10666"; a="715560017"
X-IronPort-AV: E=Sophos;i="5.98,307,1673942400"; 
   d="scan'208";a="715560017"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.212.71.212]) ([10.212.71.212])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2023 12:10:16 -0700
Message-ID: <1576040e-e8db-bc78-2fa3-622c8f7da8ec@intel.com>
Date:   Fri, 31 Mar 2023 12:10:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.9.0
Subject: Re: [PATCH v5 06/12] cxl/memdev: Make inject and clear poison cmds
 kernel exclusive
Content-Language: en-US
To:     alison.schofield@intel.com,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>
Cc:     linux-cxl@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <cover.1679892337.git.alison.schofield@intel.com>
 <d88366e1b749c0100f2480f0036117667b62bc95.1679892337.git.alison.schofield@intel.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <d88366e1b749c0100f2480f0036117667b62bc95.1679892337.git.alison.schofield@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 3/26/23 10:03 PM, alison.schofield@intel.com wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> Inject and clear poison commands are intended to be used in debug
> mode only, and if improperly used, can lead to data corruption. The
> kernel provides a debugfs interface to issue these commands [1]
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
> [1] Documentation/ABI/testing/debugfs-cxl
> [2] include/uapi/linux/cxl_mem.h
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>   drivers/cxl/core/memdev.c    |  6 ++++++
>   include/uapi/linux/cxl_mem.h | 20 +++++++++++++++-----
>   2 files changed, 21 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 71ebe3795616..617d8378ca9a 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -11,6 +11,8 @@
>   
>   static DECLARE_RWSEM(cxl_memdev_rwsem);
>   
> +static __read_mostly DECLARE_BITMAP(exclusive_cmds, CXL_MEM_COMMAND_ID_MAX);
> +
>   /*
>    * An entire PCI topology full of devices should be enough for any
>    * config
> @@ -628,6 +630,10 @@ struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds)
>   	cxlmd->cxlds = cxlds;
>   	cxlds->cxlmd = cxlmd;
>   
> +	set_bit(CXL_MEM_COMMAND_ID_INJECT_POISON, exclusive_cmds);
> +	set_bit(CXL_MEM_COMMAND_ID_CLEAR_POISON, exclusive_cmds);
> +	set_exclusive_cxl_commands(cxlds, exclusive_cmds);
> +
>   	cdev = &cxlmd->cdev;
>   	rc = cdev_device_add(cdev, dev);
>   	if (rc)
> diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_mem.h
> index 86bbacf2a315..6294278f9dcb 100644
> --- a/include/uapi/linux/cxl_mem.h
> +++ b/include/uapi/linux/cxl_mem.h
> @@ -74,17 +74,27 @@ static const struct {
>    * @id: ID number for the command.
>    * @flags: Flags that specify command behavior.
>    *
> - *         CXL_MEM_COMMAND_FLAG_USER_ENABLED
> + *         CXL_MEM_COMMAND_FLAG_ENABLED
>    *
>    *         The given command id is supported by the driver and is supported by
>    *         a related opcode on the device.
>    *
>    *         CXL_MEM_COMMAND_FLAG_EXCLUSIVE
>    *
> - *         Requests with the given command id will terminate with EBUSY as the
> - *         kernel actively owns management of the given resource. For example,
> - *         the label-storage-area can not be written while the kernel is
> - *         actively managing that space.
> + *         The given command id is for kernel exclusive use and is not
> + *         available to userspace. Requests will terminate with EBUSY.
> + *
> + *         The exclusive flag may be temporal, and only set while the
> + *         kernel actively owns management of the given resource. For
> + *         example, the label-storage-area can not be written while the
> + *         kernel is actively managing that space.
> + *
> + *         The exclusive flag can be permanent, as in commands that can
> + *         never be issued through the ioctl interface.
> + *
> + *         INJECT_POISON and CLEAR_POISON are permanently kernel exclusive,
> + *         and are supported through a debugfs interface.
> + *         See: Documentation/ABI/testing/debugfs-cxl
>    *
>    * @size_in: Expected input size, or ~0 if variable length.
>    * @size_out: Expected output size, or ~0 if variable length.
