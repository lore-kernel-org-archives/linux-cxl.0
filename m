Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7820125A3
	for <linux-cxl@vger.kernel.org>; Fri, 23 Feb 2024 07:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708672617; cv=none; b=gqEU6PSvwNIcs8M6yssAWLsvxtwwp7N++YOJXwLPIMcN2Ti/8ycKqL2qjMN2Ho+39eJtTfA/IZ1nIWz1BdRYx9d3J1QHaGNK5HJ7Zy9UtEKwMyeoGuIXtZPhILviPqYe2ylPjskkdUkxbm26fswrgusAahIbQLJ0kr1DhUABuxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708672617; c=relaxed/simple;
	bh=7FZ0tanncwixNL+/T37kvS0VNPfhzazC1DTFbFG79b4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HqVr2keTFV90DGbsXvW3QW7ze9hJ0YBtT+lGi5UC3Dj8iWWuHFiCc8QERBS1RUU9authRSrUHj2pxRKTVXHgqcMFJKwUNggklifj0/ztW2viMObnS4bzlqB4Eg7CWSOZKDXnqYHl5MpKqAuKvXCPWhO6nQ34nhyjDZ0uNPQrcJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cxurx48X; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cxurx48X"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d8da50bffaso3999915ad.2
        for <linux-cxl@vger.kernel.org>; Thu, 22 Feb 2024 23:16:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708672615; x=1709277415; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zt4y0iusXDXWfZiS3sX3qZDc0utPZM5TYOfbkIoo4AU=;
        b=Cxurx48X5I6vSCMcaNpaScs9PlKBGDyZ15rrPuedeTdnMYlT08UzHfovRCQrSlCdTn
         ER8Hni+jzQjevRAqp/5QSMg0jMPdfAnWVx8HqM9uWP0tfMUjY0kWrOP8zn60+S5+SxA+
         HR4MUEh3djZl8ySa5bVLQCpXg/x6IaPJu06rrMMcXFjSZWIFH5y62VYpND+Kd+DY7Yjj
         BuP20LRXUWDytwSw8nYZdaJndoxu49+EY5favuUqqm39KDyW48q5PR+8oQ4BPZT2+WQ/
         93CsMRAcK4G3zG3K/Tufql+iGJqSyO+dJTGTie7p/r6iRBJ06ddGkuCr4eQh8vz8fyJ8
         lacw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708672615; x=1709277415;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zt4y0iusXDXWfZiS3sX3qZDc0utPZM5TYOfbkIoo4AU=;
        b=EZb8IK1MFVNQ+PWYsY2ty1/9/byq07LjMc3c5QO6RzkfzOE1Z3+xZz2ADTBQkTZ4nB
         2cX63wE/FufChqXcLi7HBUgydLAQyo96wSQxtAsifOoGPe3abwUz+4Rxz61l0YOWqvXt
         bEsvkQfAKQjiupku1Jaft+9+4l6MiZcD3VL21lXIBTVDpWxPSMUePRD8V9NgoYrkoI5W
         kx+Wqc7aGFFLjAA1n6FPoHPldQE4IqfEWI+JzUkvKJMK13zbaT0dKoCK05XKyu0muFa+
         hSI4scsqO6uCoeEEj2T+TCS8sWbNlXtL6zGPPW90pzYdC4G4oTZYyQmeD261EoX/hCqy
         3aUg==
X-Forwarded-Encrypted: i=1; AJvYcCUp+r+n90DPRzRasGqivin9gdJ7FQdz6DzLMbC96ZOvOwNe3TEpISrCy7KkIg01d19yhjvzcF7Y+xLCOlfONRBRCWiJIfbyaKWT
X-Gm-Message-State: AOJu0Yx6VWBO4u+ALWe7wxWX4BIq7zQ/3xvra0Bz7dm2a4lCGMeIqOzK
	eYoi1ur8+Iv3U2WOTfk4q8og3XfJ47NhCnV02oA3eMkCl6IboPb4
X-Google-Smtp-Source: AGHT+IEsD6/eqL694nm/5mE9RuBxkEC+4T3bbgV/cQIB7VosgKP0eDeGIiqYoJd0158WBuhZtW0qIw==
X-Received: by 2002:a17:902:930a:b0:1d9:3843:3f07 with SMTP id bc10-20020a170902930a00b001d938433f07mr1012172plb.61.1708672614581;
        Thu, 22 Feb 2024 23:16:54 -0800 (PST)
Received: from [172.30.1.72] ([211.197.219.189])
        by smtp.gmail.com with ESMTPSA id r7-20020a170902be0700b001dc23e877bfsm4999873pls.268.2024.02.22.23.16.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 23:16:54 -0800 (PST)
Message-ID: <6fad2a96-aba6-46a1-a1ef-85be4faba59b@gmail.com>
Date: Fri, 23 Feb 2024 16:16:53 +0900
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/10] hw/mem/cxl_type3: Add DC extent list
 representative and get DC extent list mailbox support
Content-Language: en-US
To: nifan.cxl@gmail.com, qemu-devel@nongnu.org
Cc: jonathan.cameron@huawei.com, linux-cxl@vger.kernel.org,
 gregory.price@memverge.com, ira.weiny@intel.com, dan.j.williams@intel.com,
 a.manzanares@samsung.com, dave@stgolabs.net, nmtadam.samsung@gmail.com,
 jim.harris@samsung.com, Fan Ni <fan.ni@samsung.com>
References: <20240221182020.1086096-1-nifan.cxl@gmail.com>
 <20240221182020.1086096-8-nifan.cxl@gmail.com>
From: Wonjae Lee <wj28.lee@gmail.com>
In-Reply-To: <20240221182020.1086096-8-nifan.cxl@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024-02-22 오전 3:16, nifan.cxl@gmail.com wrote:
> From: Fan Ni <fan.ni@samsung.com>
> 
> Add dynamic capacity extent list representative to the definition of
> CXLType3Dev and add get DC extent list mailbox command per
> CXL.spec.3.1:.8.2.9.9.9.2.
> 
> Signed-off-by: Fan Ni <fan.ni@samsung.com>
> ---
>   hw/cxl/cxl-mailbox-utils.c  | 71 +++++++++++++++++++++++++++++++++++++
>   hw/mem/cxl_type3.c          |  1 +
>   include/hw/cxl/cxl_device.h | 23 ++++++++++++
>   3 files changed, 95 insertions(+)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index f95e417683..dae7fe00ed 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -83,6 +83,7 @@ enum {
>           #define CLEAR_POISON           0x2
>       DCD_CONFIG  = 0x48,
>           #define GET_DC_CONFIG          0x0
> +        #define GET_DYN_CAP_EXT_LIST   0x1
>       PHYSICAL_SWITCH = 0x51,
>           #define IDENTIFY_SWITCH_DEVICE      0x0
>           #define GET_PHYSICAL_PORT_STATE     0x1
> @@ -1344,6 +1345,73 @@ static CXLRetCode cmd_dcd_get_dyn_cap_config(const struct cxl_cmd *cmd,
>       return CXL_MBOX_SUCCESS;
>   }
>   
> +/*
> + * CXL r3.1 section 8.2.9.9.9.2:
> + * Get Dynamic Capacity Extent List (Opcode 4801h)
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
> +    CXLDCExtentList *extent_list = &ct3d->dc.extents;
> +    CXLDCExtent *ent;
> +    uint16_t out_pl_len;
> +    uint32_t start_extent_id = in->start_extent_id;
> +
> +    if (start_extent_id > ct3d->dc.total_extent_count) {

Hello,

Shouldn't it be >= rather than >?

(I accidentally replied to v3 with the same comment above, so please 
ignore that.)

Thanks,
Wonjae

