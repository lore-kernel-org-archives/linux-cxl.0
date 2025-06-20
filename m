Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2257628C86C
	for <linux-cxl@vger.kernel.org>; Fri, 20 Jun 2025 14:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750430902; cv=none; b=T0O32AmCc1Fh0SgbxMjJwEmCDuXH4cmFOlaWnk4lC2cmrUJUiSjf3yBQhZx8DP6p1yW9wDudAqLHYXbm4PaX/glJEmNXkYY8pegF2r1o68buT3ckPDZxeBSPfJBwyD2/+hhlk+NFhw08CiapyxM1VUfFH7qBWT0O5g/GylEmUlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750430902; c=relaxed/simple;
	bh=J8DmG16DzVEKoPKLNLqHX8AQMsWt+YFXQHlF4fi44lc=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VXgoGsPn8GzuvBvqOdhxJoVzpUPYGLxKBUEy/yxQsxfbE2xFv2us1OZtCj2PuSqEp/sfFC3TkPcqSfGTMTXGRSdoU4aY9D9z8qAHujZP8NC7kLxc0tY6uFj8E8W5FKUz48N8EsPpvVTXI2oJzwU03vLLqym1PzLSCzNa5kq+mdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bP0b465hNz6L56V;
	Fri, 20 Jun 2025 22:43:28 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 9A8881400D7;
	Fri, 20 Jun 2025 22:48:15 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 20 Jun
 2025 16:48:15 +0200
Date: Fri, 20 Jun 2025 15:48:13 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <shiju.jose@huawei.com>
CC: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
	<tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>, <linuxarm@huawei.com>
Subject: Re: [PATCH v2 7/7] hw/cxl: Add emulation for memory sparing control
 feature
Message-ID: <20250620154813.00002bbd@huawei.com>
In-Reply-To: <20250619151619.1695-8-shiju.jose@huawei.com>
References: <20250619151619.1695-1-shiju.jose@huawei.com>
	<20250619151619.1695-8-shiju.jose@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 19 Jun 2025 16:16:19 +0100
<shiju.jose@huawei.com> wrote:

> From: Shiju Jose <shiju.jose@huawei.com>
> 
> Memory sparing is defined as a repair function that replaces a portion of
> memory with a portion of functional memory at that same DPA. The subclasses
> for this operation vary in terms of the scope of the sparing being
> performed. The Cacheline sparing subclass refers to a sparing action that
> can replace a full cacheline. Row sparing is provided as an alternative to
> PPR sparing functions and its scope is that of a single DDR row. Bank
> sparing allows an entire bank to be replaced. Rank sparing is defined as
> an operation in which an entire DDR rank is replaced.
> 
> Memory sparing maintenance operations may be supported by CXL devices
> that implement CXL.mem protocol. A sparing maintenance operation requests
> the CXL device to perform a repair operation on its media.
> For example, a CXL device with DRAM components that support memory sparing
> features may implement sparing Maintenance operations.
> 
> The host may issue a query command by setting Query Resources flag in the
> Input Payload (CXL Spec 3.2 Table 8-120) to determine availability of
> sparing resources for a given address. In response to a query request,
> the device shall report the resource availability by producing the Memory
> Sparing Event Record (CXL Spec 3.2 Table 8-60) in which the Channel, Rank,
> Nibble Mask, Bank Group, Bank, Row, Column, Sub-Channel fields are a copy
> of the values specified in the request.
> 
> During the execution of a sparing maintenance operation, a CXL memory device:
> - May or may not retain data
> - May or may not be able to process CXL.mem requests correctly.
> These CXL memory device capabilities are specified by restriction flags
> in the memory sparing feature readable attributes.
> 
> When a CXL device identifies error on a memory component, the device
> may inform the host about the need for a memory sparing maintenance
> operation by using DRAM event record, where the 'maintenance needed' flag
> may set. The event record contains some of the DPA, Channel, Rank,
> Nibble Mask, Bank Group, Bank, Row, Column, Sub-Channel fields that
> should be repaired. The userspace tool requests for maintenance operation
> if the 'maintenance needed' flag set in the CXL DRAM error record.
> 
> CXL spec 3.2 section 8.2.10.7.2.3 describes the memory sparing feature
> discovery and configuration.
> 
> CXL spec 3.2 section 8.2.10.7.1.4 describes the device's memory sparing
> maintenance operation feature.
> 
> Add emulation for CXL memory device memory sparing control feature
> and memory sparing maintenance operation command.
> 
> TODO: Following are the pending tasks, though not sure how to implement.
>  1. Add emulation for memory sparing maintenance operation.

At most wipe the data if advertising that it won't be retained.
No need to actually do anything.

>  2. On query, report memory sparing resource availability in a memory sparing
>     event record if required in the future.
I'd go with a a per device per type set of counters.
Lets just say we have X of them on a device - once used up they are gone.
No need to worry too much on what X is.  Just pick some values so we have
something to test against. 4 maybe enough for testing?


Some comments on previous patch feed through to here.  A few more things inline.

Jonathan

> 
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> ---
>  hw/cxl/cxl-mailbox-utils.c  | 295 ++++++++++++++++++++++++++++++++++++
>  hw/mem/cxl_type3.c          |  44 ++++++
>  include/hw/cxl/cxl_device.h |  40 +++++
>  3 files changed, 379 insertions(+)
> 
>  
> +typedef struct CXLMemSparingMaintInPayload {
> +    uint8_t flags;
> +    uint8_t channel;
> +    uint8_t rank;
> +    uint8_t nibble_mask[3];
> +    uint8_t bank_group;
> +    uint8_t bank;
> +    uint8_t row[3];
> +    uint16_t column;
> +    uint8_t sub_channel;
> +} QEMU_PACKED CXLMemSparingMaintInPayload;
> +
> +static CXLRetCode cxl_perform_mem_sparing(CXLType3Dev *ct3d, uint8_t sub_class,
> +                                          void *maint_pi)
> +{
> +     CXLMemSparingMaintInPayload *sparing_maint_pi = (void *)maint_pi;

Odd spacing

> +
> +    qemu_log_mask(LOG_UNIMP, "Memory Sparing Maintenance Input Payload...\n");
> +    qemu_log_mask(LOG_UNIMP, "flags = %u\n", sparing_maint_pi->flags);
> +    qemu_log_mask(LOG_UNIMP, "channel= %u\n", sparing_maint_pi->channel);
> +    qemu_log_mask(LOG_UNIMP, "rank = %u\n", sparing_maint_pi->rank);
> +    qemu_log_mask(LOG_UNIMP, "nibble_mask[0] = 0x%x\n",
> +                  sparing_maint_pi->nibble_mask[0]);
> +    qemu_log_mask(LOG_UNIMP, "nibble_mask[1] = 0x%x\n",
> +                  sparing_maint_pi->nibble_mask[1]);
> +    qemu_log_mask(LOG_UNIMP, "nibble_mask[2] = 0x%x\n",
> +                  sparing_maint_pi->nibble_mask[2]);
> +    qemu_log_mask(LOG_UNIMP, "bank_group = %u\n",
> +                  sparing_maint_pi->bank_group);
> +    qemu_log_mask(LOG_UNIMP, "bank = %u\n", sparing_maint_pi->bank);
> +    qemu_log_mask(LOG_UNIMP, "row[0] = 0x%x\n", sparing_maint_pi->row[0]);
> +    qemu_log_mask(LOG_UNIMP, "row[1] = 0x%x\n", sparing_maint_pi->row[1]);
> +    qemu_log_mask(LOG_UNIMP, "row[2] = 0x%x\n", sparing_maint_pi->row[2]);
> +    qemu_log_mask(LOG_UNIMP, "column = %u\n", sparing_maint_pi->column);
> +    qemu_log_mask(LOG_UNIMP, "sub_channel = %u\n",
> +                  sparing_maint_pi->sub_channel);

LOG_UNIMP is a bit odd given there is nothing to do really.

> +
> +    switch (sub_class) {
> +    case 0: /* Cacheline Memory Sparing */
> +        qemu_log("Cacheline Memory Sparing\n");
> +        return CXL_MBOX_SUCCESS;
> +    case 1: /* Row Memory Sparing */
> +        qemu_log("Row Memory Sparing\n");
> +        return CXL_MBOX_SUCCESS;
> +    case 2: /* Bank Memory Sparing */
> +        qemu_log("Bank Memory Sparing\n");
> +        return CXL_MBOX_SUCCESS;
> +    case 3: /* Rank Memory Sparing */
> +        qemu_log("Rank Memory Sparing\n");
> +        return CXL_MBOX_SUCCESS;
> +    default:
> +        return CXL_MBOX_UNSUPPORTED;

As previously - I think this is invalid parameter as the command is supported
just not the sub_class.

> +    }
> +}
> +

