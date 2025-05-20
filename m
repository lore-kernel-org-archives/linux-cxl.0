Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB50248166
	for <linux-cxl@vger.kernel.org>; Tue, 20 May 2025 16:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747759512; cv=none; b=gFIppgsQNR0Do0YqgVLfeoVJCl6I4luofOqhTxkDXVZR15awTglhuJHcvftdeYWe+HvQ1gqvxdRsg2PqXoWR1F7g2y4w6k4W0sqTu/b8h4lEXwfajc6F3vR8rJTbC1ahjleJuFMK4mNlnfJ7+m/ruYfu28BZyupFlySNcfF3lww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747759512; c=relaxed/simple;
	bh=+3mR5/jLtJzd5rTP+MCwMngTHGkDEzNUtEBNMD+IrNY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eHgmKfDwIB07fL4KW3GaH3WA5tu5EKJA7stoZkxZWJ8yZRn5s/LuF6twL8rCYfMuSdRtQ/u+z0S2dg/4kvqygspaoAqJ/bb+Tpu8Jg6iwcxTiKc3144NuiGXB6/6Ltt8Fufhvi7ekP8sEemKrD412r79Ql3GHhKpTOuLksBo9mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bdFkX5n3; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bdFkX5n3"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-30e5430ed0bso5763485a91.3
        for <linux-cxl@vger.kernel.org>; Tue, 20 May 2025 09:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747759509; x=1748364309; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=m+7SV2xh38BX70rkK3rxPOunQ+UQDLRyf1uVTWn74ko=;
        b=bdFkX5n3WKppDzqQ9smXhPSTDGjWHIKe9uz5UKj7sPEtI4SrL9UPBA9QjqOlHR/ohy
         xP+FTzfepl6/rJQh7Bmq3XoIp+6eCvQnkJBIbue2SfT1ReGafPE37DGBg0olUVqK+y9u
         K7cCMl95q2cZSbgTlJQp8cCCTc/ex1DiNyAaDvI6K9qC+Cmw8OYK1d7ujZq9GphiV0DW
         IA9qDjZ9IJ63/eRptY2FnxmZYg5725Tw6qINIojQCcIrOvRdcHiiKgzBiRHYpD9AjAmh
         ULeUBZKjvRDv62XHsLLhcQoFnC4BWcCH5kMU6tk/gutzkRAcw+/jbGjKiSI5SMJIOcuN
         NldQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747759509; x=1748364309;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m+7SV2xh38BX70rkK3rxPOunQ+UQDLRyf1uVTWn74ko=;
        b=gm995VxUZ3zsQM5KVcEvmerwd3xRUbxDevQSfLjBNRrCTQ9ExIuPaXHwj7siZdYi6C
         OY+QnriYI3LQ63dV+u7rKiUUTZdxenafZEKzNqtEHv6MHSLFHOrP1FOQCNShYhUCSyQa
         pz1QuQWyV5vQSKpJoOixnuDCrcwudMJZ340gbXAsr2Ch33Yx7YPW1BYOHr8itN/1B1LE
         q+FKJ+Xe0pFdHiUQUo47hrZ6SqVJri5hOBNJT5ZM+qwM+3s/Z4Ybc/KwKw7KdKGwgNw6
         v2NiSRj3tnEHy15KHXI/uLinro6lxWL3x9/mrQx1G7k0g/dCRHqSWfzDAiq/q06t7iA2
         yRnA==
X-Forwarded-Encrypted: i=1; AJvYcCXQYwZ0A0vhDgv9Ar5IfN9oDu5C8oFe/gV5ymRa+vyD3rjT2p/cnBdDf+XjKNTkpXSM9fQacFGZe/k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaVsK9/A4VQ/7oLn6/79BJrasqTpm+AyBxmN07XHfoY8J9pah0
	wLoVpc80NBRK6D9AdxW6mr5jawWMUxN0o67MBrN8Inj7c3xku7Fhro1/rUshGA==
X-Gm-Gg: ASbGncufX64uYAoAxx64CJ62iYuJkp9XjT96PbVkNBdANc0vB8yFp/D29BQ2Pgfneqg
	gG0Nh9+aw+NinVQZfkT//MWoXaTfttlVJR+Uv09t9wiMRgCAPx+XIBb8LjYd2U0Eiw1jR7S1cEH
	Hz07Ob62yHn+BytZ62EHUJ7P3xKQAkzCxXZ0J9HkOetS6Olsihs8u4aL/KF4xjQuwQPGdsXNUW1
	Bbxm/NtAGzrVDN12PP3cMoKsmLBwxWW5i5Pkvzi/6UOuTs11+ZIejtpB8iFrMDARbHH0GQqsH8+
	IVtO260fYoA7Lvce9oCqtr3JfuLZ981VILCFeIwmRA==
X-Google-Smtp-Source: AGHT+IFYCgM3TXmWDKu3+6RnTMM49ylrOwg9WGXbHuSOn26XlFcn63AoApwUU7jmZQgDlbaxxsvmTw==
X-Received: by 2002:a05:6a00:a81:b0:742:9f58:ccce with SMTP id d2e1a72fcca58-742acce364cmr22946284b3a.12.1747759498132;
        Tue, 20 May 2025 09:44:58 -0700 (PDT)
Received: from lg ([2601:646:8f03:9fee:2c89:c0cf:1cbd:96d3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a96deaf4sm8144837b3a.23.2025.05.20.09.44.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 09:44:57 -0700 (PDT)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Tue, 20 May 2025 09:44:55 -0700
To: anisa.su887@gmail.com
Cc: qemu-devel@nongnu.org, Jonathan.Cameron@huawei.com, nifan.cxl@gmail.com,
	dave@stgolabs.net, linux-cxl@vger.kernel.org,
	Anisa Su <anisa.su@samsung.com>
Subject: Re: [PATCH v2 05/10] cxl_events.h: Move definition for
 dynamic_capacity_uuid and enum for DC event types
Message-ID: <aCyxh8oN-NtI7eXo@lg>
References: <20250508001754.122180-1-anisa.su887@gmail.com>
 <20250508001754.122180-6-anisa.su887@gmail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250508001754.122180-6-anisa.su887@gmail.com>

On Thu, May 08, 2025 at 12:01:01AM +0000, anisa.su887@gmail.com wrote:
> From: Anisa Su <anisa.su@samsung.com>
> 
> Move definition/enum to cxl_events.h for shared use in next patch
> 
> Signed-off-by: Anisa Su <anisa.su@samsung.com>
> ---

Reviewed-by: Fan Ni <fan.ni@samsung.com>

>  hw/mem/cxl_type3.c          | 15 ---------------
>  include/hw/cxl/cxl_events.h | 15 +++++++++++++++
>  2 files changed, 15 insertions(+), 15 deletions(-)
> 
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index 05d4c861f1..6ad48f55ce 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -1982,21 +1982,6 @@ void qmp_cxl_inject_memory_module_event(const char *path, CxlEventLog log,
>      }
>  }
>  
> -/* CXL r3.1 Table 8-50: Dynamic Capacity Event Record */
> -static const QemuUUID dynamic_capacity_uuid = {
> -    .data = UUID(0xca95afa7, 0xf183, 0x4018, 0x8c, 0x2f,
> -                 0x95, 0x26, 0x8e, 0x10, 0x1a, 0x2a),
> -};
> -
> -typedef enum CXLDCEventType {
> -    DC_EVENT_ADD_CAPACITY = 0x0,
> -    DC_EVENT_RELEASE_CAPACITY = 0x1,
> -    DC_EVENT_FORCED_RELEASE_CAPACITY = 0x2,
> -    DC_EVENT_REGION_CONFIG_UPDATED = 0x3,
> -    DC_EVENT_ADD_CAPACITY_RSP = 0x4,
> -    DC_EVENT_CAPACITY_RELEASED = 0x5,
> -} CXLDCEventType;
> -
>  /*
>   * Check whether the range [dpa, dpa + len - 1] has overlaps with extents in
>   * the list.
> diff --git a/include/hw/cxl/cxl_events.h b/include/hw/cxl/cxl_events.h
> index 38cadaa0f3..758b075a64 100644
> --- a/include/hw/cxl/cxl_events.h
> +++ b/include/hw/cxl/cxl_events.h
> @@ -184,4 +184,19 @@ typedef struct CXLEventDynamicCapacity {
>      uint32_t tags_avail;
>  } QEMU_PACKED CXLEventDynamicCapacity;
>  
> +/* CXL r3.1 Table 8-50: Dynamic Capacity Event Record */
> +static const QemuUUID dynamic_capacity_uuid = {
> +    .data = UUID(0xca95afa7, 0xf183, 0x4018, 0x8c, 0x2f,
> +                 0x95, 0x26, 0x8e, 0x10, 0x1a, 0x2a),
> +};
> +
> +typedef enum CXLDCEventType {
> +    DC_EVENT_ADD_CAPACITY = 0x0,
> +    DC_EVENT_RELEASE_CAPACITY = 0x1,
> +    DC_EVENT_FORCED_RELEASE_CAPACITY = 0x2,
> +    DC_EVENT_REGION_CONFIG_UPDATED = 0x3,
> +    DC_EVENT_ADD_CAPACITY_RSP = 0x4,
> +    DC_EVENT_CAPACITY_RELEASED = 0x5,
> +} CXLDCEventType;
> +
>  #endif /* CXL_EVENTS_H */
> -- 
> 2.47.2
> 

-- 
Fan Ni
