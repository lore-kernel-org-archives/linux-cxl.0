Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9330120AF97
	for <linux-cxl@vger.kernel.org>; Tue,  4 Feb 2025 10:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738666429; cv=none; b=LPr9Smg/7cnPhVVm15xrGzv0XOEhLV6TkG3tM9V0qe+ne/e1JQy5WyhUYb8EkuLnrcz3uWGW2/y88wmPMll9S3fappumvucqqyw2zzpDZcrxPskH3hU8lXDIv1hJbEGqs4BeqbowpszpVB7fKDNvgL9c+YZZyO1DssnRi4fSC6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738666429; c=relaxed/simple;
	bh=0WTd3+SZOV5YJrRy7KCqahaTrGix6mcYxyvjFyVLCG4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H0QqLkwvwaOp79FzkWOZ4aAupj8jhtCfKsLc0KEj9DxaatsMdWtLq7JrjibKJUehAbufaZdT7IxuaK15eI+bkGY7MjEI20aGLtPxAUugojLUlvrfWbTtFlY4R7oaZQdnyx5ZGjWqIXhSfgJUnOi49EX/ss79xqXZ2TqYc9Xrp+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YnKvl421fz6HJc8;
	Tue,  4 Feb 2025 18:52:51 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id E149A1400CA;
	Tue,  4 Feb 2025 18:53:43 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 4 Feb
 2025 11:53:43 +0100
Date: Tue, 4 Feb 2025 10:53:42 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Arpit Kumar <arpit1.kumar@samsung.com>
CC: <qemu-devel@nongnu.org>, <gost.dev@samsung.com>,
	<linux-cxl@vger.kernel.org>, <nifan.cxl@gmail.com>, <dave@stgolabs.net>,
	<vishak.g@samsung.com>, <krish.reddy@samsung.com>,
	<a.manzanares@samsung.com>, <alok.rathore@samsung.com>
Subject: Re: [PATCH 2/3] hw/cxl/cxl-mailbox-utils.c: Added support for Clear
 Log (Opcode 0403h)
Message-ID: <20250204105342.00000c31@huawei.com>
In-Reply-To: <20250203055950.2126627-3-arpit1.kumar@samsung.com>
References: <20250203055950.2126627-1-arpit1.kumar@samsung.com>
	<CGME20250203060053epcas5p137fe4cbd5661afdfd2602dbc7facdcb9@epcas5p1.samsung.com>
	<20250203055950.2126627-3-arpit1.kumar@samsung.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500009.china.huawei.com (7.191.174.84) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon,  3 Feb 2025 11:29:49 +0530
Arpit Kumar <arpit1.kumar@samsung.com> wrote:

Add some description of what is being added here.

Key issue in here is that clearing the CEL doesn't make
sense. It is a description of what the device supports, there
is no state to clear in it.  To add this command you need
to pick a different log.

Jonathan


> Signed-off-by: Arpit Kumar <arpit1.kumar@samsung.com>
> Reviewed-by: Alok Rathore <alok.rathore@samsung.com>
> Reviewed-by: Krishna Kanth Reddy <krish.reddy@samsung.com>
> ---
>  hw/cxl/cxl-mailbox-utils.c | 36 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 3d66a425a9..5fd7f850c4 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -77,6 +77,7 @@ enum {
>          #define GET_SUPPORTED 0x0
>          #define GET_LOG       0x1
>          #define GET_LOG_CAPABILITIES   0x2
> +        #define CLEAR_LOG     0x3
>      FEATURES    = 0x05,
>          #define GET_SUPPORTED 0x0
>          #define GET_FEATURE   0x1
> @@ -1115,6 +1116,39 @@ static CXLRetCode cmd_logs_get_log_capabilities(const struct cxl_cmd *cmd,
>      return CXL_MBOX_SUCCESS;
>  }
>  
> +/* CXL r3.1 Section 8.2.9.5.4: Clear Log (Opcode 0403h) */
> +static CXLRetCode cmd_logs_clear_log(const struct cxl_cmd *cmd,
> +                                     uint8_t *payload_in,
> +                                     size_t len_in,
> +                                     uint8_t *payload_out,
> +                                     size_t *len_out,
> +                                     CXLCCI *cci)
> +{
> +    int32_t cap_id;
> +    struct {
> +        QemuUUID uuid;
> +    } QEMU_PACKED QEMU_ALIGNED(8) * clear_log = (void *)payload_in;
> +
> +    cap_id = valid_log_check(&clear_log->uuid, cci);
> +    if (cap_id == -1) {
> +        return CXL_MBOX_INVALID_LOG;
> +    }

Follow on from previous patch, if this returns the cap pointer,
the following code wont have to index the array and should end up simpler.

> +
> +    if (cci->supported_log_cap[cap_id].param_flags.clear_log_supported) {
I would flip this.
    if (!(cap->param_flags & PARAM_FLAG_CLEAR_LOG_SUPPORTED)) {
        return CXL_MBOX_UNSUPPORTED;
    }

    
> +        switch (cap_id) {
> +        case CEL:

So if we return the cap as suggested, it will have to reference what it is
or provide a callback (which might be cleaner as this grows).

However, what does clearly the command effects log mean?
This makes no sense.  So if you want to implement clear_log you
need to implement a different log to clear.

> +            memset(cci->cel_log, 0, (1 << 16) * sizeof(struct cel_log));
> +            cci->cel_size = 0;
> +            break;
> +        default:
> +            return CXL_MBOX_UNSUPPORTED;
> +        }
> +    } else {
> +        return CXL_MBOX_UNSUPPORTED;
> +    }
> +    return CXL_MBOX_SUCCESS;
> +}
> +
>  /* CXL r3.1 section 8.2.9.6: Features */
>  /*
>   * Get Supported Features output payload
> @@ -2882,6 +2916,8 @@ static const struct cxl_cmd cxl_cmd_set[256][256] = {
>      [LOGS][GET_LOG] = { "LOGS_GET_LOG", cmd_logs_get_log, 0x18, 0 },
>      [LOGS][GET_LOG_CAPABILITIES] = { "LOGS_GET_LOG_CAPABILITIES",
>                                       cmd_logs_get_log_capabilities, 0x10, 0 },
> +    [LOGS][CLEAR_LOG] = { "LOGS_CLEAR_LOG", cmd_logs_clear_log, 0x10,
> +                          CXL_MBOX_IMMEDIATE_LOG_CHANGE},
>      [FEATURES][GET_SUPPORTED] = { "FEATURES_GET_SUPPORTED",
>                                    cmd_features_get_supported, 0x8, 0 },
>      [FEATURES][GET_FEATURE] = { "FEATURES_GET_FEATURE",

