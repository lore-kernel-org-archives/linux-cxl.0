Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05EFA12E56
	for <linux-cxl@vger.kernel.org>; Wed, 24 Jan 2024 14:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706107892; cv=none; b=Fxo6N7fPk7qf+pOG/xFnRQYQjIu1pYalff5QWrHw/RRhgSh2/Hu4aI8RXjKxIG1B8+eDOktIAp1zjEIXDo82vDacp3h5VEt9imHHtZzctwkA1t4M0e4Io5rlPLCnBGFSI8omWdhEfIMNBDu2Oa0cAAkWBEOdHweQZ5KHaJCj8AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706107892; c=relaxed/simple;
	bh=nNDKeZxD6OJLrAh5varZRKgQ5Q9oEhyIrseYumUKQ7o=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mJW2iEWx+YfIQ4AQLzvKKqC/NplGUl8K4WpNxk2hOhBXEs9gvzcFroE+bOONTxqmwdUrWruqRm1Lrwnk5QbqT9b9+m0/HfQnLmj59yvVfn+Tg83Du02TVWwBLR9e18zLxLmQNavW9b0SsnfGagS2dWewvP0k7xYBDP2kCShIPbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TKmzR6KXCz6J9dr;
	Wed, 24 Jan 2024 22:48:19 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 0E4FC140684;
	Wed, 24 Jan 2024 22:51:20 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Jan
 2024 14:51:19 +0000
Date: Wed, 24 Jan 2024 14:51:18 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: <nifan.cxl@gmail.com>
CC: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>,
	<a.manzanares@samsung.com>, <dave@stgolabs.net>, <nmtadam.samsung@gmail.com>,
	<nifan@outlook.com>, <jim.harris@samsung.com>, "Fan Ni" <fan.ni@samsung.com>
Subject: Re: [PATCH v3 2/9] hw/cxl/cxl-mailbox-utils: Add dynamic capacity
 region representative and mailbox command support
Message-ID: <20240124145118.00002f7d@Huawei.com>
In-Reply-To: <20231107180907.553451-3-nifan.cxl@gmail.com>
References: <20231107180907.553451-1-nifan.cxl@gmail.com>
	<20231107180907.553451-3-nifan.cxl@gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue,  7 Nov 2023 10:07:06 -0800
nifan.cxl@gmail.com wrote:

> From: Fan Ni <fan.ni@samsung.com>
> 
> Per cxl spec 3.0, add dynamic capacity region representative based on
> Table 8-126 and extend the cxl type3 device definition to include dc region
> information. Also, based on info in 8.2.9.8.9.1, add 'Get Dynamic Capacity
> Configuration' mailbox support.
> 
> Note: decode_len of a dc region is aligned to 256*MiB, need to be divided by
> 256 * MiB before returned to the host for "Get Dynamic Capacity Configuration"
> mailbox command.
> 
> Signed-off-by: Fan Ni <fan.ni@samsung.com>

Hi Fan,

I'm looking at how to move these much earlier in my tree on basis that
they should be our main focus for merging in this QEMU cycle.

Whilst I do that rebase, I'm taking a closer look at the code.
I'm targetting rebasing on upstream qemu + the two patch sets I just
sent out:
[PATCH 00/12 qemu] CXL emulation fixes and minor cleanup. 
[PATCH 0/5 qemu] hw/cxl: Update CXL emulation to reflect and reference r3.1

It would be good to document why these commands should be optional (which I think
comes down to the annoying fact that Get Dynamic Capacity Configuration isn't
allowed to return 0 regions, but instead should not be available as a command
if DCD isn't supported.

Note this requires us to carry Gregory's patches to make the CCI command list
constructed at runtime rather than baked in ahead of this set.

So another question is should we jump directly to the r3.1 version of DCD?
I think we probably should as it includes some additions that are necessary
for a bunch of the potential use cases.


> ---
>  hw/cxl/cxl-mailbox-utils.c  | 80 +++++++++++++++++++++++++++++++++++++
>  hw/mem/cxl_type3.c          |  6 +++
>  include/hw/cxl/cxl_device.h | 17 ++++++++
>  3 files changed, 103 insertions(+)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 8eceedfa87..f80dd6474f 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -80,6 +80,8 @@ enum {
>          #define GET_POISON_LIST        0x0
>          #define INJECT_POISON          0x1
>          #define CLEAR_POISON           0x2
> +    DCD_CONFIG  = 0x48,
> +        #define GET_DC_CONFIG          0x0
>      PHYSICAL_SWITCH = 0x51,
>          #define IDENTIFY_SWITCH_DEVICE      0x0
>          #define GET_PHYSICAL_PORT_STATE     0x1
> @@ -1210,6 +1212,74 @@ static CXLRetCode cmd_media_clear_poison(const struct cxl_cmd *cmd,
>      return CXL_MBOX_SUCCESS;
>  }
>  
> +/*
> + * CXL r3.0 section 8.2.9.8.9.1: Get Dynamic Capacity Configuration

As per the patch set I just sent out, I want to standardize on references
to r3.1 because it's all that is easy to get.  However if we decide to r3.0
DCD first the upgrade it later, then clearly these need to stick to r3.0 for
now.

> + * (Opcode: 4800h)
> + */
> +static CXLRetCode cmd_dcd_get_dyn_cap_config(const struct cxl_cmd *cmd,
> +                                             uint8_t *payload_in,
> +                                             size_t len_in,
> +                                             uint8_t *payload_out,
> +                                             size_t *len_out,
> +                                             CXLCCI *cci)
> +{
> +    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
> +    struct get_dyn_cap_config_in_pl {
> +        uint8_t region_cnt;
> +        uint8_t start_region_id;
> +    } QEMU_PACKED;
> +
> +    struct get_dyn_cap_config_out_pl {
> +        uint8_t num_regions;
> +        uint8_t rsvd1[7];

This changed in r3.1 (errata? - I haven't checked)
Should be 'regions returned' in first byte.

> +        struct {
> +            uint64_t base;
> +            uint64_t decode_len;
> +            uint64_t region_len;
> +            uint64_t block_size;
> +            uint32_t dsmadhandle;

> +            uint8_t flags;
> +            uint8_t rsvd2[3];
> +        } QEMU_PACKED records[];

There are two fields after this as well.
Total number of supported extents and number of available extents.

That annoyingly means we can't use the structure to tell us where
to find all the fields...


> +    } QEMU_PACKED;
> +
> +    struct get_dyn_cap_config_in_pl *in = (void *)payload_in;
> +    struct get_dyn_cap_config_out_pl *out = (void *)payload_out;
> +    uint16_t record_count = 0, i;

Better to split that on to 2 lines. Never hide setting a value
in the middle of a set of declarations.

> +    uint16_t out_pl_len;
> +    uint8_t start_region_id = in->start_region_id;
> +
> +    if (start_region_id >= ct3d->dc.num_regions) {
> +        return CXL_MBOX_INVALID_INPUT;
> +    }
> +
> +    record_count = MIN(ct3d->dc.num_regions - in->start_region_id,
> +            in->region_cnt);
> +
> +    out_pl_len = sizeof(*out) + record_count * sizeof(out->records[0]);

For r3.1 + 8 for the two trailing fields.

> +    assert(out_pl_len <= CXL_MAILBOX_MAX_PAYLOAD_SIZE);
> +
> +    memset(out, 0, out_pl_len);

As part of the cci rework we started zeroing the whole mailbox payload space
after copying out the input payload.
https://elixir.bootlin.com/qemu/latest/source/hw/cxl/cxl-device-utils.c#L204

So shouldn't need this (unless we have a bug)

Jonathan
