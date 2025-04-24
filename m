Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3398B221263
	for <linux-cxl@vger.kernel.org>; Thu, 24 Apr 2025 10:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745490662; cv=none; b=tsM/tnE014fgIu/xDUyVuG32C1DtPSPDHf6Nq+g6hOutd79nEkNFISoXHW/KRwBuUO7kLdGUs8Si8GYKBuIya0g0w6TvPn/VYGiw2HZL50BEtHQsrjw5i+UrtntzQZQuOU2hjduY1KJh8c1YdaqFF4UiMHkfpBSCyUo6S5TqX7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745490662; c=relaxed/simple;
	bh=bmapII+OmPe84QPdM3DcdagihFw4mXyFkc9rXblVJX8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QdYH8cBPH6EoyVqmtjJytFXIG211w5q0ih1HePDJKTVTCKHnPWqsiNFOIy4IgN8Z2NCKfSylqDZJL+apdK+tLCv9VyHcgQZI5eR8U/wZYhEc/srXttA+uC5RslBlBV565BL4QiJzCqn2JoMsocnVsW0Xm/cSQNfXj3OfXlB4yho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZjsZh52c0z6K9Kf;
	Thu, 24 Apr 2025 18:26:20 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 3F98B140136;
	Thu, 24 Apr 2025 18:30:57 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 24 Apr
 2025 12:30:56 +0200
Date: Thu, 24 Apr 2025 11:30:55 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <anisa.su887@gmail.com>
CC: <qemu-devel@nongnu.org>, <nifan.cxl@gmail.com>, <dave@stgolabs.net>,
	<linux-cxl@vger.kernel.org>, Anisa Su <anisa.su@samsung.com>
Subject: Re: [PATCH 2/9] cxl-mailbox-utils: 0x5600 - FMAPI Get DCD Info
Message-ID: <20250424113055.0000419f@huawei.com>
In-Reply-To: <20250317164204.2299371-3-anisa.su887@gmail.com>
References: <20250317164204.2299371-1-anisa.su887@gmail.com>
	<20250317164204.2299371-3-anisa.su887@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 17 Mar 2025 16:31:29 +0000
anisa.su887@gmail.com wrote:

> From: Anisa Su <anisa.su@samsung.com>
> 
> FM DCD Management command 0x5600 implemented per CXL 3.2 Spec Section 7.6.7.6.1
> 
> Signed-off-by: Anisa Su <anisa.su@samsung.com>

It's been too long so I'll look over this again as a precursor
to looking at the later patches... Might well duplicate things
I said before. :(


> ---
>  hw/cxl/cxl-mailbox-utils.c | 67 ++++++++++++++++++++++++++++++++++++++
>  hw/cxl/i2c_mctp_cxl.c      |  6 +++-
>  2 files changed, 72 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 1b62d36101..e9991fd1a7 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -122,6 +122,8 @@ enum {
>          #define MANAGEMENT_COMMAND     0x0
>      MHD = 0x55,
>          #define GET_MHD_INFO 0x0
> +    FMAPI_DCD_MGMT = 0x56,
> +        #define GET_DCD_INFO 0x0
>  };
>  
>  /* CCI Message Format CXL r3.1 Figure 7-19 */
> @@ -3341,6 +3343,62 @@ static CXLRetCode cmd_dcd_release_dyn_cap(const struct cxl_cmd *cmd,
>      return CXL_MBOX_SUCCESS;
>  }
>  
> +/*
> + * CXL r3.2 section 7.6.7.6.1: Get DCD Info (Opcode 5600h)
> + */
> +static CXLRetCode cmd_fm_get_dcd_info(const struct cxl_cmd *cmd,
> +                                      uint8_t *payload_in,
> +                                      size_t len_in,
> +                                      uint8_t *payload_out,
> +                                      size_t *len_out,
> +                                      CXLCCI *cci)
> +{
> +    struct {
> +        uint8_t num_hosts;
> +        uint8_t num_regions_supported;
> +        uint8_t rsvd1[2];
> +        uint16_t add_select_policy_bitmask;
> +        uint8_t rsvd2[2];
> +        uint16_t release_select_policy_bitmask;
> +        uint8_t sanitize_on_release_bitmask;
> +        uint8_t rsvd3;
> +        uint64_t total_dynamic_capacity;
> +        uint64_t region_blk_size_bitmasks[8];
> +    } QEMU_PACKED *out;

You could set this directly to (void *)payload_out; here

> +    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
> +    CXLDCRegion region;
Why not use a pointer?  Only copying from the region
I think.

> +    int i;
> +
> +    if (ct3d->dc.num_regions == 0) {

This check shouldn't be needed as we don't register the commands
if we have no regions.


> +        return CXL_MBOX_UNSUPPORTED;
> +    }
> +
> +    out = (void *)payload_out;
> +
> +    /* TODO: num hosts set to 1 for now */
> +    out->num_hosts = 1;
> +    out->num_regions_supported = ct3d->dc.num_regions;

> +    stq_le_p(&out->total_dynamic_capacity,
> +             ct3d->dc.total_capacity / CXL_CAPACITY_MULTIPLIER);
> +
> +    for (i = 0; i < ct3d->dc.num_regions; i++) {
> +        region = ct3d->dc.regions[i];
> +        memcpy(&out->region_blk_size_bitmasks[i],
> +                &region.supported_blk_size_bitmask, 8);
> +    }
> +
> +    *len_out = sizeof(*out);
> +    return CXL_MBOX_SUCCESS;
> +}
> +
>  static const struct cxl_cmd cxl_cmd_set[256][256] = {
>      [INFOSTAT][BACKGROUND_OPERATION_ABORT] = { "BACKGROUND_OPERATION_ABORT",
>          cmd_infostat_bg_op_abort, 0, 0 },
> @@ -3462,6 +3520,11 @@ static const struct cxl_cmd cxl_cmd_set_sw[256][256] = {
>                                       cmd_tunnel_management_cmd, ~0, 0 },
>  };
>  
> +static const struct cxl_cmd cxl_cmd_set_fm_dcd[256][256] = {
> +    [FMAPI_DCD_MGMT][GET_DCD_INFO] = { "GET_DCD_INFO",
> +        cmd_fm_get_dcd_info, 0, 0},

space before }

> +};
> +
>  /*
>   * While the command is executing in the background, the device should
>   * update the percentage complete in the Background Command Status Register
> @@ -3764,7 +3827,11 @@ void cxl_initialize_t3_fm_owned_ld_mctpcci(CXLCCI *cci, DeviceState *d,
>                                             DeviceState *intf,
>                                             size_t payload_max)
>  {
> +    CXLType3Dev *ct3d = CXL_TYPE3(d);

Blank line here.

Run checkpatch over the patch series. Might catch little things like this.

>      cxl_copy_cci_commands(cci, cxl_cmd_set_t3_fm_owned_ld_mctp);
> +    if (ct3d->dc.num_regions) {
length, len_out);
>              s->len = s->pos;

