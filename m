Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC223D81
	for <linux-cxl@vger.kernel.org>; Tue,  5 Nov 2024 21:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730841526; cv=none; b=U2YtcthAHdWGnmIIYt/4bv8OPA5vpf5AdKTdECepAKqSM/XDnBG7mO8bFftJsgV7REtoyv/XudLIDcRgffsTjTw32eotl8F5JWwA2jNi6xVzRUG5DaSsAJZmF+oq+NG9WiWnspiuDQfoH0pAXeIiKkoNBvKYLx7Bhd/lAEX9AAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730841526; c=relaxed/simple;
	bh=+cBvygbr/VJaiYoAC6XIP91ENrhEnJE/c85jypFdimk=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mlMadERiU8I156T33WhykeK+vN3OxnWttM2uKPuePIGgzkMW4gvkw8hniV/9YoJb5fXmxrnw0aLAqQjCAsl7PvV1GJ9vExzRnuA9kNjsFeoQQ5S7RROME/71lE49amovmfaNNgrVm6ewgW0iNQ0ujAt2SZk27IWyxG6/P7uZwIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MTaTPTSg; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MTaTPTSg"
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e29687f4cc6so4826687276.2
        for <linux-cxl@vger.kernel.org>; Tue, 05 Nov 2024 13:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730841524; x=1731446324; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tEdrMlvscGRAELTFBlq9FDu6pV5+7du0Bd+t/STrdCg=;
        b=MTaTPTSgPLKNh5WnmGMB4PgES8PvdR32+Tvv9LJf1N5yuvGlv8wqNiOaSR5d3/IoPw
         43X7a8VYxThXWju+ypBaIGiYAiysRZNKr7hMofmfSIZ+Y+dg0Nn6rCdNg3ueN717S6wK
         8X2SzvTH4jvE/f2Y3AXq81yij9PVlwnib5iPpcUaYDhcpDqGKuFoSskspgAeX3gdt/XR
         22MG2E1/9WyXQIOdMjIgP+Zr+01VTmcJuUZ8D6FicAOypSRWVVKxW5zsiQcJZAOUGoAS
         sVOm3h6I0nx7txbip7PZwCpmm1YNvFY030eDf3xABIi/CTSjQBUt9Sg8MbRVS2onLT4Y
         Stfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730841524; x=1731446324;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tEdrMlvscGRAELTFBlq9FDu6pV5+7du0Bd+t/STrdCg=;
        b=iv1iwrAmGY3gozyND3OA0XRp4YZWwLdU/46HTUE05+zvVU6jNiCEoia5qnh62hTn5F
         l59qqsbfdfnbzHvuoM/QFFUj/rfr69RWU9oNAtjy0de2BhlIswv1/3lCmvJ0H16FN5Zw
         eITxvKVlxbgTQOH1+LPZ7qWyzGYRdNM7pClfqIhtxHzatkdLA4ZqIhaQczOPiITZ/kvO
         li10SBvLrRw784FZsWdEV9hozD7kSRVk+8+p/F19SVuQKfSx3VXyGUfEGmn0VCg0OaXs
         KBlvV4gF4HsuzhfySzgh79U4Oq3nHk6UhTCgT2ujGI2iQWSFi6G0JOgFOzT0g0LWBEQ2
         +6kw==
X-Gm-Message-State: AOJu0YzbJ64T2TKKOaJZC13oWQxISrK8AQ9RU06jz2jo2eJ1Nj1QjoMK
	NYLrrfJoWyZOfnjdsZC0Ou3kbx3vt4LwmYmsIpjbV3klixzlAShrOuFmpQ==
X-Google-Smtp-Source: AGHT+IHfZcpEmqQofUMS9b6VJaypOwQchI4XxAVqs2DUyEbtqcHs7YBBVy7fOL7cI65GETtJFgk0LA==
X-Received: by 2002:a05:6902:2509:b0:e30:e6cb:26a1 with SMTP id 3f1490d57ef6-e3302568b80mr14357745276.16.1730841524222;
        Tue, 05 Nov 2024 13:18:44 -0800 (PST)
Received: from fan ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e30e8acda8fsm2717068276.46.2024.11.05.13.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 13:18:43 -0800 (PST)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Tue, 5 Nov 2024 13:18:42 -0800
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-cxl@vger.kernel.org, mst@redhat.com, qemu-devel@nongnu.org,
	Esifiel <esifiel@gmail.com>, linuxarm@huawei.com
Subject: Re: [PATCH qemu 06/10] hw/cxl: Avoid accesses beyond the end of
 cel_log.
Message-ID: <ZyqLsvEhS80kQabs@fan>
References: <20241101133917.27634-1-Jonathan.Cameron@huawei.com>
 <20241101133917.27634-7-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241101133917.27634-7-Jonathan.Cameron@huawei.com>

On Fri, Nov 01, 2024 at 01:39:13PM +0000, Jonathan Cameron wrote:
> Add a check that the requested offset + length does not go beyond the end
> of the cel_log.
> 
> Whilst the cci->cel_log is large enough to include all possible CEL
> entries, the guest might still ask for entries beyond the end of it.
> Move the comment to this new check rather than before the check on the
> type of log requested.
> 
> Reported-by: Esifiel <esifiel@gmail.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  hw/cxl/cxl-mailbox-utils.c | 22 +++++++++++++---------
>  1 file changed, 13 insertions(+), 9 deletions(-)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 2aa7ffed84..5e571955b6 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -937,24 +937,28 @@ static CXLRetCode cmd_logs_get_log(const struct cxl_cmd *cmd,
>  
>      get_log = (void *)payload_in;
>  
> +    if (get_log->length > cci->payload_max) {
> +        return CXL_MBOX_INVALID_INPUT;
> +    }
> +
> +    if (!qemu_uuid_is_equal(&get_log->uuid, &cel_uuid)) {
> +        return CXL_MBOX_INVALID_LOG;
> +    }
> +
>      /*
>       * CXL r3.1 Section 8.2.9.5.2: Get Log (Opcode 0401h)
>       *   The device shall return Invalid Input if the Offset or Length
>       *   fields attempt to access beyond the size of the log as reported by Get
> -     *   Supported Logs.
> +     *   Supported Log.
>       *
> -     * The CEL buffer is large enough to fit all commands in the emulation, so
> -     * the only possible failure would be if the mailbox itself isn't big
> -     * enough.
> +     * Only valid for there to be one entry per opcode, but the length + offset
> +     * may still be greater than that if the inputs are not valid and so access
> +     * beyond the end of cci->cel_log.
>       */
> -    if (get_log->length > cci->payload_max) {
> +    if ((uint64_t)get_log->offset + get_log->length >= sizeof(cci->cel_log)) {
>          return CXL_MBOX_INVALID_INPUT;

Oh. This patch actually addresses my concern in the previous patch.
Maybe we can combine the changes in this patch and the previous one
together. Other than that 

Reviewed-by: Fan Ni <fan.ni@samsung.com>

>      }
>  
> -    if (!qemu_uuid_is_equal(&get_log->uuid, &cel_uuid)) {
> -        return CXL_MBOX_INVALID_LOG;
> -    }
> -
>      /* Store off everything to local variables so we can wipe out the payload */
>      *len_out = get_log->length;
>  
> -- 
> 2.43.0
> 

-- 
Fan Ni
