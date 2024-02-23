Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22FC9125A3
	for <linux-cxl@vger.kernel.org>; Fri, 23 Feb 2024 07:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708672224; cv=none; b=kxiw2pOMwH/4LqM+xS8pR1860ZVvQHKL9l2pQGt5uc1kC9pCIyUizv4maUANAruth+0IplHlxnZr/+ujobODpWjyuvDUze6gd9kTh68Z5AqTRqjdrmSjEkgIqS7B2CT9ZscbHcWeokQsYk7Kvwi9m0yGnSNqTcCpw8TcMO8oZOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708672224; c=relaxed/simple;
	bh=qrah9Sd1KcpVWmIj0rSXuZFB+vgt/eBFjr0WBUOce+E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s4i92FStz8eudi2fS4CwYaY2Lowy3g7P1HnmTdYgnMjvuZtSKEeE/lE7qTm8LypVh6UIl/J/yXq9THuXdgY2jd6xxPUuAcpBeF/tNEcapoJRrOe8LpOyZk1wxs5S9X3qMOwZ5IyVWAwEOBDO4eahvy97SafHvSxWjB+JgKrzNaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jc74xSub; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jc74xSub"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d95d67ff45so2956235ad.2
        for <linux-cxl@vger.kernel.org>; Thu, 22 Feb 2024 23:10:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708672222; x=1709277022; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UtfyMLzk9ddvun/2ANg20nTf8Zl3q/PYkofgKwLmJx0=;
        b=jc74xSubZcYnxe4mo6tuI3OG2sNwLBjkQpjsYY+AFoWdbcIbIuaGaqZoNk46FKqQhR
         xOPJKuk9gw914Fj89U+C2SvUb+FdKOUZjIIypCW5BQK5tOnYoJDcmuDypozhf0ke39sO
         Rc2ubZiQG+ocZcAqEVHkuRmJ+ngvhjhl2fo8+VUHjSjMjzsinicjkzivPWNdmyx7lCw1
         ZE3Jr48Bew3db6e1MzzQtXl/9Bi90qVvsvt6+m2wF+ZPWZUQ4Ole64MgKQrdmZ3XIFZW
         CuMCiqUQJAMSfCgHuLeQr8MUVtq5iWMPRidnmnDb3IgkPe5Wurz3JmgCahkrxzoVhFLg
         5aaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708672222; x=1709277022;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UtfyMLzk9ddvun/2ANg20nTf8Zl3q/PYkofgKwLmJx0=;
        b=MoWKBC128XJ6rPCVKcrEtJxu7I3b/oM+wN6uWlErRDoWgeAKpNmZqSn2oymv+7VBwb
         eMxgiTuUMB+mrbfhFYazK44K43GUTa8Jd/2w0DqM1IT0fr74cH4hEy6ZfmLXbuQjad9A
         Zn6BQNUFX7aA+qkBIyIjA7MjSvJ52w10Z/65plmQK/AiAgSKhMmFc8XZC0qgVJoClHBv
         7Pi0SBx2LG4s+CMh2GywEJo0V2w+eznRVA4cilaZSfUJ5Tjz3ZdicuSkXJ+Ht8TQOcGs
         oaEAflvC199nPEc9pd6w30t/0S7vKv5353OGKka7cexHIW4BU8n5ZuuP13tckVpdGklr
         ZYdw==
X-Forwarded-Encrypted: i=1; AJvYcCVJkzIZID06kuxwf8QaeYahOU+HUwLMT1aGTWucr8Wufz5khP9DhhU2nNpMo1Vb0AKYLpgbfoso62UxJebamj5Nf3H+K8x4Rvnb
X-Gm-Message-State: AOJu0YzqSyRPbKmnmEfpmtiPu9feBoph8WEB8+8oF6yVucRmStL5eQWH
	nlyqn+4ZE0+WOk4FWCzPIQjtB40pUcZwzOMxg+CiI9IitkIBAaan
X-Google-Smtp-Source: AGHT+IFsVEex3r2kBWsTHTgqIqsf1EJrYCCG9782A0ru9HeMJMvuRUAJTHGbbOPN52GjRpsWawIGmg==
X-Received: by 2002:a17:902:f544:b0:1dc:11f:d954 with SMTP id h4-20020a170902f54400b001dc011fd954mr955919plf.54.1708672222419;
        Thu, 22 Feb 2024 23:10:22 -0800 (PST)
Received: from [172.30.1.72] ([211.197.219.189])
        by smtp.gmail.com with ESMTPSA id f9-20020a170902ab8900b001dc418fdf53sm3084937plr.105.2024.02.22.23.10.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 23:10:22 -0800 (PST)
Message-ID: <9a273d66-22e4-4a5b-80b9-a63b2421872b@gmail.com>
Date: Fri, 23 Feb 2024 16:10:22 +0900
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/9] hw/mem/cxl_type3: Add DC extent list
 representative and get DC extent list mailbox support
Content-Language: en-US
To: nifan.cxl@gmail.com, qemu-devel@nongnu.org
Cc: jonathan.cameron@huawei.com, linux-cxl@vger.kernel.org,
 ira.weiny@intel.com, dan.j.williams@intel.com, a.manzanares@samsung.com,
 dave@stgolabs.net, nmtadam.samsung@gmail.com, nifan@outlook.com,
 jim.harris@samsung.com, Fan Ni <fan.ni@samsung.com>
References: <20231107180907.553451-1-nifan.cxl@gmail.com>
 <20231107180907.553451-7-nifan.cxl@gmail.com>
From: Wonjae Lee <wj28.lee@gmail.com>
In-Reply-To: <20231107180907.553451-7-nifan.cxl@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2023-11-08 오전 3:07, nifan.cxl@gmail.com wrote:
> From: Fan Ni <fan.ni@samsung.com>
> 
> Add dynamic capacity extent list representative to the definition of
> CXLType3Dev and add get DC extent list mailbox command per
> CXL.spec.3.0:.8.2.9.8.9.2.
> 
> Signed-off-by: Fan Ni <fan.ni@samsung.com>
> ---
>   hw/cxl/cxl-mailbox-utils.c  | 73 +++++++++++++++++++++++++++++++++++++
>   hw/mem/cxl_type3.c          |  1 +
>   include/hw/cxl/cxl_device.h | 23 ++++++++++++
>   3 files changed, 97 insertions(+)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 1f512b3e6b..56f4aa237a 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -82,6 +82,7 @@ enum {
>           #define CLEAR_POISON           0x2
>       DCD_CONFIG  = 0x48,
>           #define GET_DC_CONFIG          0x0
> +        #define GET_DYN_CAP_EXT_LIST   0x1
>       PHYSICAL_SWITCH = 0x51,
>           #define IDENTIFY_SWITCH_DEVICE      0x0
>           #define GET_PHYSICAL_PORT_STATE     0x1
> @@ -1286,6 +1287,75 @@ static CXLRetCode cmd_dcd_get_dyn_cap_config(const struct cxl_cmd *cmd,
>       return CXL_MBOX_SUCCESS;
>   }
>   
> +/*
> + * CXL r3.0 section 8.2.9.8.9.2:
> + * Get Dynamic Capacity Extent List (Opcode 4810h)
> + */
> +static CXLRetCode cmd_dcd_get_dyn_cap_ext_list(const struct cxl_cmd *cmd,
> +                                               uint8_t *payload_in,
> +                                               size_t len_in,
> +                                               uint8_t *payload_out,
> +                                               size_t *len_out,
> +                                               CXLCCI *cci)
> +{
> +    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
> +    struct get_dyn_cap_ext_list_in_pl {
> +        uint32_t extent_cnt;
> +        uint32_t start_extent_id;
> +    } QEMU_PACKED;
> +
> +    struct get_dyn_cap_ext_list_out_pl {
> +        uint32_t count;
> +        uint32_t total_extents;
> +        uint32_t generation_num;
> +        uint8_t rsvd[4];
> +        CXLDCExtentRaw records[];
> +    } QEMU_PACKED;
> +
> +    struct get_dyn_cap_ext_list_in_pl *in = (void *)payload_in;
> +    struct get_dyn_cap_ext_list_out_pl *out = (void *)payload_out;
> +    uint16_t record_count = 0, i = 0, record_done = 0;
> +    CXLDCDExtentList *extent_list = &ct3d->dc.extents;
> +    CXLDCDExtent *ent;
> +    uint16_t out_pl_len;
> +    uint32_t start_extent_id = in->start_extent_id;
> +
> +    if (start_extent_id > ct3d->dc.total_extent_count) {

Hello,

Shouldn't it be >= rather than >?

Thanks,
Wonjae
