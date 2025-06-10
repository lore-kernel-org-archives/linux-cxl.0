Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10FC724113C
	for <linux-cxl@vger.kernel.org>; Tue, 10 Jun 2025 16:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749573556; cv=none; b=TqOYjOGjIZkCmP4OUa/rDJFTKDVzkgmgUugcvC5FdjZZj0HMbC0sS+zJmgEdFqbJOU64xCRzu+u+Vy5ADwINfwgrCBSzwknhBLxnf49inBQB80rivjoRAvXQDHNbo/97zzS+4Nfu2LJdLCSfWYEro/+gFfGhevHxDXYuBVKGHUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749573556; c=relaxed/simple;
	bh=qGKxIr7vaJwc2+N5paf22a3ELCXvXEngqAPhPpd6nSY=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ILkzD/ymnTBsp/PZTa1xQ0+eH813ZuZ/cucF2mHD7slPA7maR2CuD05LwEztObX2x/ENHGwdQjJhGy3zEdrre0N4QWENoKyx8xPL8T+mz6IkSdp+Wgx4KMeskbUB4sj9VF9Xk5vWjiPNSPgCNpmXAU+jGw1+T7Aah7rUA7H9SEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bGvXG4n38z6L5FT;
	Wed, 11 Jun 2025 00:34:54 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 556DF140427;
	Wed, 11 Jun 2025 00:39:10 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 10 Jun
 2025 18:39:09 +0200
Date: Tue, 10 Jun 2025 17:39:05 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Jonathan Cameron via <qemu-devel@nongnu.org>, <linuxarm@huawei.com>
CC: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Klaus Jensen
	<k.jensen@samsung.com>, <cminyard@mvista.com>, Fan Ni <fan.ni@samsung.com>,
	Anisa Su <anisa.su@samsung.com>, <linux-cxl@vger.kernel.org>,
	<mst@redhat.com>, Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?=
	<philmd@linaro.org>
Subject: Re: [RFC PATCH qemu 3/5] hw/cxl/i2c_mctp_cxl: Initial device
 emulation
Message-ID: <20250610170104.00001392@huawei.com>
In-Reply-To: <20250609163334.922346-4-Jonathan.Cameron@huawei.com>
References: <20250609163334.922346-1-Jonathan.Cameron@huawei.com>
	<20250609163334.922346-4-Jonathan.Cameron@huawei.com>
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

On Mon, 9 Jun 2025 17:33:31 +0100
Jonathan Cameron via <qemu-devel@nongnu.org> wrote:

> The CCI and Fabric Manager APIs are used to configure CXL switches and
> devices. DMTF has defined an MCTP binding specification to carry these
> messages. The end goal of this work is to hook this up to emulated CXL
> switches and devices to  allow control of the configuration.
> 
> Since this relies on i2c target mode, this can currently only be used with
> an SoC that includes the Aspeed I2C controller.
> 
> Note, only get timestamp added for now.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Not very important given this is an RFC, but a chunk of code in here isn't
used so I'll drop it from future version...
(I noticed whilst wondering why Anisa didn't update it in they
 FMAPI DCD series).

> ---
>  include/hw/cxl/cxl_device.h               |   8 +
>  include/hw/pci-bridge/cxl_upstream_port.h |   1 +
>  hw/cxl/cxl-mailbox-utils.c                |  49 ++++
>  hw/cxl/i2c_mctp_cxl.c                     | 289 ++++++++++++++++++++++
>  hw/cxl/Kconfig                            |   4 +
>  hw/cxl/meson.build                        |   4 +
>  6 files changed, 355 insertions(+)
> 
> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index 6086d4c85b..8d87c7151e 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -360,6 +360,10 @@ int cxl_process_cci_message(CXLCCI *cci, uint8_t set, uint8_t cmd,
>                              size_t len_in, uint8_t *pl_in,
>                              size_t *len_out, uint8_t *pl_out,
>                              bool *bg_started);
> +
> +void cxl_initialize_t3_mctpcci(CXLCCI *cci, DeviceState *d, DeviceState *intf,
> +                               size_t payload_max);
> +

> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 475547f212..4c9852642e 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -3690,6 +3690,29 @@ void cxl_initialize_mailbox_t3(CXLCCI *cci, DeviceState *d, size_t payload_max)
>      cxl_init_cci(cci, payload_max);
>  }
>  
> +static const struct cxl_cmd cxl_cmd_set_t3_mctp[256][256] = {
> +    [INFOSTAT][IS_IDENTIFY] = { "IDENTIFY", cmd_infostat_identify, 0, 0 },
> +    [INFOSTAT][GET_RESPONSE_MSG_LIMIT] = { "GET_RESPONSE_MSG_LIMIT",
> +                                           cmd_get_response_msg_limit, 0, 0 },
> +    [INFOSTAT][SET_RESPONSE_MSG_LIMIT] = { "SET_RESPONSE_MSG_LIMIT",
> +                                           cmd_set_response_msg_limit, 1, 0 },
> +    [TIMESTAMP][GET] = { "TIMESTAMP_GET", cmd_timestamp_get, 0, 0 },
> +    [LOGS][GET_SUPPORTED] = { "LOGS_GET_SUPPORTED", cmd_logs_get_supported, 0,
> +                              0 },
> +    [LOGS][GET_LOG] = { "LOGS_GET_LOG", cmd_logs_get_log, 0x18, 0 },
> +    [TUNNEL][MANAGEMENT_COMMAND] = { "TUNNEL_MANAGEMENT_COMMAND",
> +                                     cmd_tunnel_management_cmd, ~0, 0 },
> +};
> +
> +void cxl_initialize_t3_mctpcci(CXLCCI *cci, DeviceState *d, DeviceState *intf,
> +                               size_t payload_max)
> +{
> +    cxl_copy_cci_commands(cci, cxl_cmd_set_t3_mctp);
> +    cci->d = d;
> +    cci->intf = intf;
> +    cxl_init_cci(cci, payload_max);
> +}
> +
At some point a while back, when adding tunneling we decided to pretend
we have an MLD (because it's more general) and as such introduced the fm owned
mctpcci.  That's the one one that is used for the landing point of mctp
links to a type 3 device.  So this code is unused.


