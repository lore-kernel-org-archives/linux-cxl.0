Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B7F1AAD0
	for <linux-cxl@vger.kernel.org>; Fri, 23 Feb 2024 09:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708679411; cv=none; b=NWXy2JRpWLcBtV7FbIZ4f6DABxHuURLqVc+QJfPlQxpZnIIidURIsmHP6CCCtwunxEVfg4pGgj9dwb6oBiICQ0MNCH7E79ynAEyP3Lu2bOdCnCYVB/E4glIFCVWT+bw8SMDpOrq7R16QdQFNFdqN3ppiy+f9bamaLMGJudGC55Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708679411; c=relaxed/simple;
	bh=U3ZhYHBez9oKKXuDyPfqM+SMLNtkhZr6k4/QPCBKO9c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RKocyz6KnyyhJkRRQwbhZN/z/K+c6cAVKRzblvSOJRsC/gZdYwrkn2Rzfk+hvOvitwujPEBlltfnUHB3kkul4LXGOobaxwwj8qUbg2W6E9n6qgQAWCe7+J19dp1SqZxuuC6U12MxJxT8MXH6rWtMt1k9z6qCkii6BozmH8+HYRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L7lWfKr/; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L7lWfKr/"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-295c8b795e2so511785a91.0
        for <linux-cxl@vger.kernel.org>; Fri, 23 Feb 2024 01:10:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708679409; x=1709284209; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i7088AgHa1OAqA61tMttin5VX75haYu/ICj6HSRJocc=;
        b=L7lWfKr/4kCZjwW7prvhs0IbfKprJaMpAU+mzwShHot/f4vCuorFXOagzuPq43T91y
         CkoLFUmvTUOoS9zd9/Qz7ByFbTdv0I35cqWgs/udxGEZKo4qF/LEaaUYufKiC4c1BaOh
         6merWIFD221SuyY4riIYrkZeYYVyB3n6uf/4nmUvJ67LXMoHKFZAqBwFfTFUeFKinhWy
         e/VmwfzA/qt7TeoUpxnVfspMMIjZohALCWSliwqXLcIwUf+s/ohDzyTtohm+3UCUj0t2
         4Bx3Xp9KQswUREkZ/eiR0oljZcv7C3/4FgoEaF1OxVdyX7we6QvNnrMOBtVCgDOoprwe
         Ribw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708679409; x=1709284209;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i7088AgHa1OAqA61tMttin5VX75haYu/ICj6HSRJocc=;
        b=STm6z6uxxGcLEIaxB2FllnlmhJjQQ3BpCOOss8ARgqcOTScd2eFyx/es7xYW9+GwVq
         j5VgVCEFjQ6SQoiSIgyiq+8fm4V7M5XCEYRGk/s7QcXtgk0cy04ECgIbXyDG/DXKjRb/
         lI8Fc0qeFklB2ednjaoty3cBI5yYivmNvE0kUVXcb+7Yfc/e9RzHuMNbleM2IvkbK4iK
         wzTfzYN//1PrTEYW1NoBtCMsUlpk3nyp8DmLm72vF6a5cQaP9lZgmfBqOSQVI+e7XNKP
         /mxqoLM5SfqLgMXRaqdESQFVh8k8biaCP9KA8MR6Gp5rYp9/b1/rsLlwAii4g/S4DGbL
         xPpA==
X-Forwarded-Encrypted: i=1; AJvYcCWUwKTQDqEemPuKE/DASJe7bSXSv0hcG7Esz33RojUbVLjS7voJL7Zgw0H29XsvFNijlb7dbyj6hpPx8AFtbwXu+XDH+M8amcq/
X-Gm-Message-State: AOJu0YydIVcTNw4sOJDb1vqXNINSAT2fqrMIT/ylSLwCscU4wpOTPfyF
	2JZ32okeZt/JPuyX0IejnIp5Fp1gyWMFbUmU6iMx353m0UX3FWYQ
X-Google-Smtp-Source: AGHT+IHCs7N7AR1WscQ+RxKqewpNJ204dTv8cjZrnZyzFnjfD1/ZJjzCG7gLLLLxhsrAcX/bbYe2/g==
X-Received: by 2002:a17:90a:6888:b0:29a:7380:53a with SMTP id a8-20020a17090a688800b0029a7380053amr1246186pjd.34.1708679408952;
        Fri, 23 Feb 2024 01:10:08 -0800 (PST)
Received: from [172.30.1.72] ([211.197.219.189])
        by smtp.gmail.com with ESMTPSA id se13-20020a17090b518d00b00299b31de43esm921900pjb.45.2024.02.23.01.10.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Feb 2024 01:10:08 -0800 (PST)
Message-ID: <698e6bc2-d38f-46e2-837c-3c6777d49139@gmail.com>
Date: Fri, 23 Feb 2024 18:10:08 +0900
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/10] hw/cxl/cxl-mailbox-utils: Add mailbox commands
 to support add/release dynamic capacity response
Content-Language: en-US
To: nifan.cxl@gmail.com, qemu-devel@nongnu.org
Cc: jonathan.cameron@huawei.com, linux-cxl@vger.kernel.org,
 gregory.price@memverge.com, ira.weiny@intel.com, dan.j.williams@intel.com,
 a.manzanares@samsung.com, dave@stgolabs.net, nmtadam.samsung@gmail.com,
 jim.harris@samsung.com, Fan Ni <fan.ni@samsung.com>
References: <20240221182020.1086096-1-nifan.cxl@gmail.com>
 <20240221182020.1086096-9-nifan.cxl@gmail.com>
From: Wonjae Lee <wj28.lee@gmail.com>
In-Reply-To: <20240221182020.1086096-9-nifan.cxl@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024-02-22 오전 3:16, nifan.cxl@gmail.com wrote:
> From: Fan Ni <fan.ni@samsung.com>
> 
> Per CXL spec 3.1, two mailbox commands are implemented:
> Add Dynamic Capacity Response (Opcode 4802h) 8.2.9.9.9.3, and
> Release Dynamic Capacity (Opcode 4803h) 8.2.9.9.9.4.
> 
> Signed-off-by: Fan Ni <fan.ni@samsung.com>
> ---
>   hw/cxl/cxl-mailbox-utils.c  | 288 ++++++++++++++++++++++++++++++++++++
>   include/hw/cxl/cxl_device.h |   2 +
>   2 files changed, 290 insertions(+)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index dae7fe00ed..65ed28f700 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c

[snip]

> +/*
> + * CXL r3.1 Table 8-168: Add Dynamic Capacity Response Input Payload
> + * CXL r3.1 Table 8-170: Release Dynamic Capacity Input Payload
> + */
> +typedef struct CXLUpdateDCExtentListInPl {
> +    uint32_t num_entries_updated;
> +    uint8_t flags;
> +    uint8_t rsvd[3];
> +    /* CXL r3.1 Table 8-169: Updated Extent List */

I'm not sure why this was changed, but in r3.1 the table is simply 
renamed to "Updated Extent"

...

> +/*
> + * CXL r3.1 section 8.2.9.9.9.3: Add Dynamic Capacity Response (opcode 4802h)

It's too trivial, but it's written as "Opcode" in other comments.
: Opcode 4802h

...

> +/*
> + * CXL r3.1 section 8.2.9.9.9.4: Release Dynamic Capacity (opcode 4803h)

And here, too
: Opcode 4803h

...

> @@ -1462,6 +1744,12 @@ static const struct cxl_cmd cxl_cmd_set_dcd[256][256] = {
>       [DCD_CONFIG][GET_DYN_CAP_EXT_LIST] = {
>           "DCD_GET_DYNAMIC_CAPACITY_EXTENT_LIST", cmd_dcd_get_dyn_cap_ext_list,
>           8, 0 },
> +    [DCD_CONFIG][ADD_DYN_CAP_RSP] = {
> +        "ADD_DCD_DYNAMIC_CAPACITY_RESPONSE", cmd_dcd_add_dyn_cap_rsp,
> +        ~0, IMMEDIATE_DATA_CHANGE },
> +    [DCD_CONFIG][RELEASE_DYN_CAP] = {
> +        "RELEASE_DCD_DYNAMIC_CAPACITY", cmd_dcd_release_dyn_cap,
> +        ~0, IMMEDIATE_DATA_CHANGE },

For consistency, how about setting the names of commands as follows?
: DCD_ADD_DYNAMIC_CAPACITY_RESPONSE
: DCD_RELEASE_DYNAMIC_CAPACITY

Thanks,
Wonjae

