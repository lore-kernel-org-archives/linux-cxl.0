Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8052D80038
	for <linux-cxl@vger.kernel.org>; Mon, 23 Dec 2024 20:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734984086; cv=none; b=p4NKxhYnnBpOhvK4Ug2dNduAl+x8UB5X2BDBf//6+2X1zLgafohcNGRq03fbaEAwWlpiFFJf5AgzZ1spbe0fXFkSKM+itMyfkEAg4iavl8ecLy/jMSfnC1WMIW5igIhfjOF9q+jzIjWWz2kGz7KWf/gtjEOzIdNPSR8BLLiiuZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734984086; c=relaxed/simple;
	bh=CFFqzXHEuWA7ddxyhPJwTwkA1v0qflz1qBsdy26O8yA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RVb3TT62fm8RJtgXVUu0o1zNHeEk5IKeSjSzwJyokrM1f5r6Fa7mlyPG2HXDeD2zP+N4fStvTcru7y3THc4xJAWX5IVXp4ihDwC2yiIDbzn9YhlIteWi1/QgSutHZeiw1KasM2iMD5KX6oGsgzRXO+pqBdW7HxfSwhRO8FayTrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YH8223W09z6K9WR;
	Tue, 24 Dec 2024 03:57:30 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 66083140A46;
	Tue, 24 Dec 2024 04:01:21 +0800 (CST)
Received: from localhost (10.47.75.118) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 23 Dec
 2024 21:01:20 +0100
Date: Mon, 23 Dec 2024 20:01:19 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Davidlohr Bueso <dave@stgolabs.net>
CC: <fan.ni@samsung.com>, <dan.j.williams@intel.com>,
	<a.manzanares@samsung.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 2/3] cxl: Support Get/Set Shutdown State commands
Message-ID: <20241223200119.000050f7@huawei.com>
In-Reply-To: <20241220160026.204055-3-dave@stgolabs.net>
References: <20241220160026.204055-1-dave@stgolabs.net>
	<20241220160026.204055-3-dave@stgolabs.net>
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

On Fri, 20 Dec 2024 08:00:25 -0800
Davidlohr Bueso <dave@stgolabs.net> wrote:

> As per the latest spec, add mailbox commands 4203h and 4204h.
> While upon reboot this operation is obviously a nop (flag is
> cleared but the dirty shutdown count is not increased), it
> can still serve to test some basic paths.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
Hi Davidlohr,,

Some trivial stuff inline.


Thanks,

Jonathan

> ---
>  hw/cxl/cxl-mailbox-utils.c  | 49 +++++++++++++++++++++++++++++++++++++
>  include/hw/cxl/cxl_device.h |  2 ++
>  2 files changed, 51 insertions(+)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index f6f993e7bc4f..ff1d3f50610c 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -86,6 +86,9 @@ enum {
>          #define GET_PARTITION_INFO     0x0
>          #define GET_LSA       0x2
>          #define SET_LSA       0x3
> +    HEALTH_INFO_ALERTS = 0x42,
> +        #define GET_SHUTDOWN_STATE     0x3
> +        #define SET_SHUTDOWN_STATE     0x4
>      MEDIA_AND_POISON = 0x43,
>          #define GET_POISON_LIST        0x0
>          #define INJECT_POISON          0x1
> @@ -1721,6 +1724,48 @@ static CXLRetCode cmd_sanitize_overwrite(const struct cxl_cmd *cmd,
>      return CXL_MBOX_BG_STARTED;
>  }
>  
> +/* CXL r3.2 Section 8.2.10.9.3.4: Get Shutdown State (Opcode 4203h) */
> +static CXLRetCode cmd_health_get_shutdown_state(const struct cxl_cmd *cmd,
> +                                                uint8_t *payload_in,
> +                                                size_t len_in,
> +                                                uint8_t *payload_out,
> +                                                size_t *len_out,
> +                                                CXLCCI *cci)
> +{
> +    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
> +    CXLDeviceState *cxl_dstate = &ct3d->cxl_dstate;
> +    struct get_shutdown_state_pl {
> +        uint8_t state;
> +    } QEMU_PACKED;
> +    struct get_shutdown_state_pl *out = (void *)payload_out;
We only need the (void *) for unnamed types.  Where we know the type
might as well get it right. E.g. see cmd_events_set_interrupt_policy.


Mind you, not much point in keeping the type named here.
	struct {
		uint8_t state;
	} QEMU_PACKED = (void *)payload_out;


> +
> +    out->state = cxl_dstate->shutdown_state;
> +    *len_out = sizeof(out);
> +
> +    return CXL_MBOX_SUCCESS;
> +}
> +
> +/* CXL r3.2 Section 8.2.10.9.3.5: Set Shutdown State (Opcode 4204h) */
> +static CXLRetCode cmd_health_set_shutdown_state(const struct cxl_cmd *cmd,
> +                                                uint8_t *payload_in,
> +                                                size_t len_in,
> +                                                uint8_t *payload_out,
> +                                                size_t *len_out,
> +                                                CXLCCI *cci)
> +{
> +    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
> +    CXLDeviceState *cxl_dstate = &ct3d->cxl_dstate;
> +    struct set_shutdown_state_pl {
> +        uint8_t state;
> +    } QEMU_PACKED;

As above. Naming the type isn't that useful and if you want
to should cast to that not a void *

> +    struct set_shutdown_state_pl *in = (void *)payload_in;
> +
> +    cxl_dstate->shutdown_state = in->state;
> +    *len_out = 0;
> +
> +    return CXL_MBOX_SUCCESS;
> +}
> +
>  static CXLRetCode cmd_get_security_state(const struct cxl_cmd *cmd,
>                                           uint8_t *payload_in,
>                                           size_t len_in,
> @@ -2866,6 +2911,10 @@ static const struct cxl_cmd cxl_cmd_set[256][256] = {
>           CXL_MBOX_BACKGROUND_OPERATION_ABORT)},
>      [PERSISTENT_MEM][GET_SECURITY_STATE] = { "GET_SECURITY_STATE",
>          cmd_get_security_state, 0, 0 },
> +    [HEALTH_INFO_ALERTS][GET_SHUTDOWN_STATE] = { "HEALTH_INFO_ALERTS_GET_SHUTDOWN_STATE",
> +        cmd_health_get_shutdown_state, 0, 0 },
> +    [HEALTH_INFO_ALERTS][SET_SHUTDOWN_STATE] = { "HEALTH_INFO_ALERTS_SET_SHUTDOWN_STATE",
> +        cmd_health_set_shutdown_state, 1, 0 },
>      [MEDIA_AND_POISON][GET_POISON_LIST] = { "MEDIA_AND_POISON_GET_POISON_LIST",
>          cmd_media_get_poison_list, 16, 0 },
>      [MEDIA_AND_POISON][INJECT_POISON] = { "MEDIA_AND_POISON_INJECT_POISON",
> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index a64739be25e9..69e6330fe66d 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -292,6 +292,8 @@ typedef struct cxl_device_state {
>      CPMUState cpmu[CXL_NUM_CPMU_INSTANCES];
>      CHMUState chmu[1];
>      CXLEventLog event_logs[CXL_EVENT_TYPE_MAX];
> +
> +    uint8_t shutdown_state;
>  } CXLDeviceState;
>  
>  /* Initialize the register block for a device */

