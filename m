Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC34080038
	for <linux-cxl@vger.kernel.org>; Mon, 23 Dec 2024 20:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734984516; cv=none; b=WWY9R2pTPXLg6WOaIbpIQcXIBAMRG8wEVlLjmx1uTF1Gg+QO1FQ08bhBTsfnkqqaeOKmexqmcw0PGHG47h2s7UbshmCLpW5ZRLWy5xA7RrmsTyQr9YNGqUM+0kLPmrL/HsbFEiNT3D5NU4hKQCR6WmTBFFUgjwqHcTEBcLG2uIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734984516; c=relaxed/simple;
	bh=Fr0zbI+t6C5HKJXps5JR69FH0zLACer3wS5wrC9k6zA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N3uhJvBwKF7HDkqnBbOsctNJFAgMsoua/Tw3ebK+EZTUgBlGtGT5X4yb9HpaSsV2i946rVOCxqT/2DCZGJGl8aJ3IHBPmSwoPg0E/fEXPWvKQjloSpw6eXzk71f/DVZDT8/cx4pJMn0JVaXu5jGwUHNq5HHombCmjbaRLK28+w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YH8Dv70SWz6L75v;
	Tue, 24 Dec 2024 04:06:55 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 46F36140524;
	Tue, 24 Dec 2024 04:08:08 +0800 (CST)
Received: from localhost (10.47.75.118) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 23 Dec
 2024 21:08:07 +0100
Date: Mon, 23 Dec 2024 20:08:05 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Davidlohr Bueso <dave@stgolabs.net>
CC: <fan.ni@samsung.com>, <dan.j.williams@intel.com>,
	<a.manzanares@samsung.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 3/3] cxl/type3: Add 'dirty-shutdown' parameter
Message-ID: <20241223200746.00001923@huawei.com>
In-Reply-To: <20241220160026.204055-4-dave@stgolabs.net>
References: <20241220160026.204055-1-dave@stgolabs.net>
	<20241220160026.204055-4-dave@stgolabs.net>
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

On Fri, 20 Dec 2024 08:00:26 -0800
Davidlohr Bueso <dave@stgolabs.net> wrote:

> Add a new parameter for type3 memory devices to set the
> dirty shutdown count to a specified value. This allows
> emulating failure paths and informing the admin of such
> event via the Get Health Info command.
> 
> For example, upon a failed GPF, users can boot with
> dirty-shutdown=1 and with the cleared shutdown state,
> to emulate the hardware behavior.
> 
Just noticed, this isn't +CC to qemu-devel.  Please do that
even for patches posted for testing. Makes them easier to
upstream later if we want to as the discussion is all there.

A few comments inline.

Jonathan

> root@cxl:~# cxl list -m mem1 -H
>   {
>     "memdev":"mem1",
>     "pmem_size":2147483648,
>     "health":{
>       "maintenance_needed":false,
>       "performance_degraded":false,
>       "hw_replacement_needed":false,
>       "media_normal":true,
>       "media_not_ready":false,
>       "media_persistence_lost":false,
>       "media_data_lost":false,
>       "media_powerloss_persistence_loss":false,
>       "media_shutdown_persistence_loss":false,
>       "media_persistence_loss_imminent":false,
>       "media_powerloss_data_loss":false,
>       "media_shutdown_data_loss":false,
>       "media_data_loss_imminent":false,
>       "ext_life_used":"normal",
>       "ext_temperature":"normal",
>       "ext_corrected_volatile":"normal",
>       "ext_corrected_persistent":"normal",
>       "life_used_percent":20,
>       "temperature":30,
>       "dirty_shutdowns":1,
>       "volatile_errors":0,
>       "pmem_errors":0
>     },
>     "serial":0,
>     "host":"0000:0e:00.0"
>   }
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
>  hw/cxl/cxl-mailbox-utils.c  | 32 ++++++++++++++++++++++++++++++++
>  hw/mem/cxl_type3.c          |  1 +
>  include/hw/cxl/cxl_device.h |  3 +++
>  3 files changed, 36 insertions(+)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index ff1d3f50610c..85a58ab96bef 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -87,6 +87,7 @@ enum {
>          #define GET_LSA       0x2
>          #define SET_LSA       0x3
>      HEALTH_INFO_ALERTS = 0x42,
> +        #define GET_HEALTH_INFO        0x0
>          #define GET_SHUTDOWN_STATE     0x3
>          #define SET_SHUTDOWN_STATE     0x4
>      MEDIA_AND_POISON = 0x43,
> @@ -1724,6 +1725,35 @@ static CXLRetCode cmd_sanitize_overwrite(const struct cxl_cmd *cmd,
>      return CXL_MBOX_BG_STARTED;
>  }
>  
> +/* CXL r3.2 Section 8.2.10.9.3.1: Get Shutdown State (Opcode 4200h) */
> +static CXLRetCode cmd_health_get_health_info(const struct cxl_cmd *cmd,
> +                                             uint8_t *payload_in,
> +                                             size_t len_in,
> +                                             uint8_t *payload_out,
> +                                             size_t *len_out,
> +                                             CXLCCI *cci)
> +{
> +    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
> +    struct get_health_info_pl {
> +        uint8_t health_status;
> +        uint8_t media_status;
> +        uint8_t additional_status;
> +        uint8_t life_used;
> +        uint16_t device_temperature;
> +        uint32_t dirty_shutdown_count;
> +        uint32_t corrected_volatile_error_count;
> +        uint32_t corrected_persistent_error_count;

This duplicates most of CXLEventMemoryModule (which is defined in the spec
in terms of this payload.

We should factor it out of there an into a header to reuse in two places.
Also make sure the data matches for the stuff like device_temperature.


> +    } QEMU_PACKED *out = (void *)payload_out;
> +
> +    /* anything not set explicitly is considered under normal health */
> +    out->life_used = 20;
> +    out->device_temperature = 30;
> +    out->dirty_shutdown_count = ct3d->dirty_shutdown;
> +    *len_out = sizeof(out);
> +
> +    return CXL_MBOX_SUCCESS;
> +}
> +
>  /* CXL r3.2 Section 8.2.10.9.3.4: Get Shutdown State (Opcode 4203h) */
>  static CXLRetCode cmd_health_get_shutdown_state(const struct cxl_cmd *cmd,
>                                                  uint8_t *payload_in,
> @@ -2911,6 +2941,8 @@ static const struct cxl_cmd cxl_cmd_set[256][256] = {
>           CXL_MBOX_BACKGROUND_OPERATION_ABORT)},
>      [PERSISTENT_MEM][GET_SECURITY_STATE] = { "GET_SECURITY_STATE",
>          cmd_get_security_state, 0, 0 },
> +    [HEALTH_INFO_ALERTS][GET_HEALTH_INFO] = { "HEALTH_INFO_ALERTS_GET_HEALTH_INFO",
> +        cmd_health_get_health_info, 0, 0 },
>      [HEALTH_INFO_ALERTS][GET_SHUTDOWN_STATE] = { "HEALTH_INFO_ALERTS_GET_SHUTDOWN_STATE",
>          cmd_health_get_shutdown_state, 0, 0 },
>      [HEALTH_INFO_ALERTS][SET_SHUTDOWN_STATE] = { "HEALTH_INFO_ALERTS_SET_SHUTDOWN_STATE",
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index 5f365afb4dd1..e622eb9101ce 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -1380,6 +1380,7 @@ static Property ct3_props[] = {
>                       TYPE_MEMORY_BACKEND, HostMemoryBackend *),
>      DEFINE_PROP_LINK("lsa", CXLType3Dev, lsa, TYPE_MEMORY_BACKEND,
>                       HostMemoryBackend *),
> +    DEFINE_PROP_UINT32("dirty-shutdown", CXLType3Dev, dirty_shutdown, 0),
>      DEFINE_PROP_UINT64("sn", CXLType3Dev, sn, UI64_NULL),
>      DEFINE_PROP_STRING("cdat", CXLType3Dev, cxl_cstate.cdat.filename),
>      DEFINE_PROP_UINT8("num-dc-regions", CXLType3Dev, dc.num_regions, 0),
> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index 69e6330fe66d..f756e1a99f33 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -653,6 +653,9 @@ struct CXLType3Dev {
>          uint8_t num_regions; /* 0-8 regions */
>          CXLDCRegion regions[DCD_MAX_NUM_REGION];
>      } dc;
> +
> +    /* Dirty shutdown count */
> +    uint32_t dirty_shutdown;
>  };
>  
>  #define TYPE_CXL_TYPE3 "cxl-type3"

