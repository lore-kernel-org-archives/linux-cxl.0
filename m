Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EC1EC433F5
	for <linux-cxl@archiver.kernel.org>; Fri, 25 Mar 2022 11:18:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351663AbiCYLT4 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 25 Mar 2022 07:19:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346207AbiCYLTz (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 25 Mar 2022 07:19:55 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF1F11EED4
        for <linux-cxl@vger.kernel.org>; Fri, 25 Mar 2022 04:18:20 -0700 (PDT)
Received: from fraeml713-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KPzzf3Q4vz685Wp;
        Fri, 25 Mar 2022 19:15:58 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml713-chm.china.huawei.com (10.206.15.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 25 Mar 2022 12:18:18 +0100
Received: from localhost (10.122.247.231) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 25 Mar
 2022 11:18:17 +0000
Date:   Fri, 25 Mar 2022 11:18:16 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <alison.schofield@intel.com>
CC:     Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v3 8/9] cxl/mbox: Block immediate mode in
 SET_PARTITION_INFO command
Message-ID: <20220325111816.00005cf8@huawei.com>
In-Reply-To: <20220324011126.1144504-9-alison.schofield@intel.com>
References: <20220324011126.1144504-1-alison.schofield@intel.com>
        <20220324011126.1144504-9-alison.schofield@intel.com>
Organization: Huawei Technologies R&D (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhreml745-chm.china.huawei.com (10.201.108.195) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, 23 Mar 2022 18:11:25 -0700
alison.schofield@intel.com wrote:

> From: Alison Schofield <alison.schofield@intel.com>
> 
> User space may send the SET_PARTITION_INFO mailbox command using
> the IOCTL interface. Inspect the input payload and fail if the
> immediate flag is set.
> 
> This is the first instance of the driver inspecting an input payload
> from user space. Assume there will be more such cases and implement
> with an extensible helper.
> 
> In order for the kernel to react to an immediate partition change it
> needs to assert that the change will not affect any active decode. At
> a minimum this requires validating that the device is using HDM
> decoders instead of the CXL DVSEC for decode, and that none of the
> active HDM decoders are affected by the partition change. For now,
> just fail until that support arrives.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>

Follow on comment from one in earlier patch on the use of a goto
to skip the input payload case... Otherwise,

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/core/mbox.c | 41 +++++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxlmem.h    |  7 +++++++
>  2 files changed, 48 insertions(+)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index c323d6792405..1930e203061d 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -218,6 +218,40 @@ static bool cxl_mem_raw_command_allowed(u16 opcode)
>  	return true;
>  }
>  
> +/**
> + * cxl_payload_from_user_allowed() - Check contents of in_payload.
> + * @opcode: The mailbox command opcode.
> + * @payload_in: Pointer to the input payload passed in from user space.
> + *
> + * Return:
> + *  * true	- payload_in passes check for @opcode.
> + *  * false	- payload_in contains invalid or unsupported values.
> + *
> + * The driver may inspect payload contents before sending a mailbox
> + * command from user space to the device. The intent is to reject
> + * commands with input payloads that are known to be unsafe. This
> + * check is not intended to replace the users careful selection of
> + * mailbox command parameters and makes no guarantee that the user
> + * command will succeed, nor that it is appropriate.

Channeling your inner Lawyer :)

> + *
> + * The specific checks are determined by the opcode.
> + */
> +static bool cxl_payload_from_user_allowed(u16 opcode, void *payload_in)
> +{
> +	switch (opcode) {
> +	case CXL_MBOX_OP_SET_PARTITION_INFO: {
> +		struct cxl_mbox_set_partition_info *pi = payload_in;
> +
> +		if (pi->flags && CXL_SET_PARTITION_IMMEDIATE_FLAG)
> +			return false;
> +		break;
> +	}
> +	default:
> +		break;
> +	}
> +	return true;
> +}
> +
>  static int cxl_to_mbox_cmd(struct cxl_dev_state *cxlds,
>  			   struct cxl_mbox_cmd *mbox, u16 opcode,
>  			   size_t in_size, size_t out_size, u64 in_payload)
> @@ -235,6 +269,13 @@ static int cxl_to_mbox_cmd(struct cxl_dev_state *cxlds,
>  	if (!mbox->payload_in)
>  		return PTR_ERR(mbox->payload_in);
>  
> +	if (!cxl_payload_from_user_allowed(opcode, mbox->payload_in)) {
> +		dev_dbg(cxlds->dev, "%s: input payload not allowed\n",
> +			cxl_mem_opcode_to_name(opcode));
> +		kvfree(mbox->payload_in);
> +		return -EBUSY;
> +	}

Ah. This is making the block before the label larger. I'm still doubtful that
the code is more readable with the goto though rather than just having
it indented one more tab.

> +
>  size_out:
>  	/* Prepare to handle a full payload for variable sized output */
>  	if (out_size < 0)
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index d5c9a273d07d..dee574527e50 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -264,6 +264,13 @@ struct cxl_mbox_set_lsa {
>  	u8 data[];
>  } __packed;
>  
> +struct cxl_mbox_set_partition_info {
> +	__le64 volatile_capacity;
> +	u8 flags;
> +} __packed;
> +
> +#define  CXL_SET_PARTITION_IMMEDIATE_FLAG	BIT(0)
> +
>  /**
>   * struct cxl_mem_command - Driver representation of a memory device command
>   * @info: Command information as it exists for the UAPI

