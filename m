Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6569209F32
	for <linux-cxl@vger.kernel.org>; Tue, 18 Mar 2025 15:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742313392; cv=none; b=qciPvPTvMZow8aW4ipb7Or4w68bphhUINsoWxQyRljPoNm0efmUeqbpW+FviOOpAD/wRIfxdx1dhCjH4VBB09sWsTlYXkQswfHNeNBRTf/Da2DZ7YQJaGMjQgW+CcKCL0+AXcZ5rJ8fBRT/tw45Kz28pqsZX+iMV/DIqe99DvKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742313392; c=relaxed/simple;
	bh=nBOaC+O6rjma+MOwupNMEnd7AqjxIBl6e2+w/cMTThM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VlAAuVPpOzWUoGcesoxDY6yAc2qEHWc7NKaLtNoXZhZwzlukJZp86taGwZ2ZZRUDapQB2DZiGTh9+vlp5mEC+4pA3H+SoC7SHrVtm1i2GaCUOHXHD0R5BtOrK0v0YkvUUbrOoN2T+LE8nDMTp1UniikgY/JhvgwuWp21b2X/sIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZHGY63HnJz6H6m1;
	Tue, 18 Mar 2025 23:51:38 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 42A54140933;
	Tue, 18 Mar 2025 23:56:26 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 18 Mar
 2025 16:56:25 +0100
Date: Tue, 18 Mar 2025 15:56:24 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <anisa.su887@gmail.com>
CC: <qemu-devel@nongnu.org>, <nifan.cxl@gmail.com>, <dave@stgolabs.net>,
	<linux-cxl@vger.kernel.org>, Anisa Su <anisa.su@samsung.com>
Subject: Re: [PATCH 2/9] cxl-mailbox-utils: 0x5600 - FMAPI Get DCD Info
Message-ID: <20250318155624.00006410@huawei.com>
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
X-ClientProxiedBy: lhrpeml100010.china.huawei.com (7.191.174.197) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 17 Mar 2025 16:31:29 +0000
anisa.su887@gmail.com wrote:

> From: Anisa Su <anisa.su@samsung.com>
> 
> FM DCD Management command 0x5600 implemented per CXL 3.2 Spec Section 7.6.7.6.1
> 
> Signed-off-by: Anisa Su <anisa.su@samsung.com>
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

Single line comment should be fine here.

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
    } QEMU_PACKED *out = (void *)payload_out;
> +    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
> +    CXLDCRegion region;
> +    int i;
> +
> +    if (ct3d->dc.num_regions == 0) {
> +        return CXL_MBOX_UNSUPPORTED;
> +    }
> +
> +    out = (void *)payload_out;
Why not just do this at declaration above?
It is harmless to set it then even if we exit earlier
I think.

> +
> +    /* TODO: num hosts set to 1 for now */

Unless this changes later in the set, no need for a todo here.
This simply denotes what we are emulating. Maybe we will make
it more flexible in future, maybe not.

> +    out->num_hosts = 1;
> +    out->num_regions_supported = ct3d->dc.num_regions;
> +    /* TODO: only prescriptive supported for now */

Likewise, not a todo that needs comment. Just a current setting.
As long as we never make it nor support this we are fine for
compatibility etc.  The CXL stuff doesn't support migration anyway
so not problems there.

> +    stw_le_p(&out->add_select_policy_bitmask,
> +             CXL_EXTENT_SELECTION_POLICY_PRESCRIPTIVE);
> +    stw_le_p(&out->release_select_policy_bitmask,
> +             CXL_EXTENT_REMOVAL_POLICY_PRESCRIPTIVE);
> +    /* TODO: sanitize on release bitmask cleared for now */

As with above, not really a todo, more of a choice made for now.

> +    out->sanitize_on_release_bitmask = 0;
> +
> +    stq_le_p(&out->total_dynamic_capacity,
> +             ct3d->dc.total_capacity / CXL_CAPACITY_MULTIPLIER);
> +
> +    for (i = 0; i < ct3d->dc.num_regions; i++) {
> +        region = ct3d->dc.regions[i];
> +        memcpy(&out->region_blk_size_bitmasks[i],
> +                &region.supported_blk_size_bitmask, 8);

sizeof(out->region_blk_size_bitmasks[i]) 

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
>      cxl_copy_cci_commands(cci, cxl_cmd_set_t3_fm_owned_ld_mctp);
> +    if (ct3d->dc.num_regions) {
> +        cxl_copy_cci_commands(cci, cxl_cmd_set_fm_dcd);
> +    }
>      cci->d = d;
>      cci->intf = intf;
>      cxl_init_cci(cci, payload_max);
> diff --git a/hw/cxl/i2c_mctp_cxl.c b/hw/cxl/i2c_mctp_cxl.c
> index 7d2cbc3b75..df95182925 100644
> --- a/hw/cxl/i2c_mctp_cxl.c
> +++ b/hw/cxl/i2c_mctp_cxl.c
> @@ -46,6 +46,9 @@
>  /* Implementation choice - may make this configurable */
>  #define MCTP_CXL_MAILBOX_BYTES 512
>  
> +/* Supported FMAPI Cmds */
> +#define FMAPI_CMD_MAX_OPCODE 0x57
> +
>  typedef struct CXLMCTPMessage {
>      /*
>       * DSP0236 (MCTP Base) Integrity Check + Message Type
> @@ -200,7 +203,8 @@ static void i2c_mctp_cxl_handle_message(MCTPI2CEndpoint *mctp)
>          if (!(msg->message_type == MCTP_MT_CXL_TYPE3 &&
>                msg->command_set < 0x51) &&
>              !(msg->message_type == MCTP_MT_CXL_FMAPI &&
> -              msg->command_set >= 0x51 && msg->command_set < 0x56)) {
> +              msg->command_set >= 0x51 &&
> +              msg->command_set < FMAPI_CMD_MAX_OPCODE)) {

Hmm. There is a visibility problem here we should address but probably not
by introducing a new define.  Maybe we should move the enum from
cxl-mailbox-utils.c in a precursor patch.

Jonathan


>              buf->rc = CXL_MBOX_UNSUPPORTED;
>              st24_le_p(buf->pl_length, len_out);
>              s->len = s->pos;

