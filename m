Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADBBC1C84C5
	for <linux-cxl@vger.kernel.org>; Tue,  1 Jul 2025 15:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751385013; cv=none; b=YTr3Ig6Dk6mXd/7QD2GxPzmvPsk79vPvaizxsdpEg0kLYIqaVYnAD7vIlL7DtxBqBYtCwFACfGx3rmF88Z5rBNxVU497WdjmCHg2jbpjZrsO4GZ2tD+uJ40lsv/7zB3h9cNELZWpvGG57BKaCoano9ZCmrY8RXa+h40WBEgCAsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751385013; c=relaxed/simple;
	bh=tqxNDhwgnjsCc1ne/regeJTtRqC/qZnIK4KZZBaQKPQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rG/rYkfjEC/cIZ45pSx1PjLHryXI6PhL9DHsv427hY799szObIGFkMXCR6Ju7N4K/9p/UjqTzq/RxvYn1QbeEzcrH2yguxhrmlnNNnJ83l6W67lfkFbdYnW8qb4jv3ymUZCPGlktDiMJKtNlnRmQ4G4gXnbLNFP9fgeoWIFNAMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b/nn/olF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b/nn/olF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751385010;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P/uTjjueacCrk9iWxrSPigoGAnsDBOasrqX6cOjFTgQ=;
	b=b/nn/olFUrtYXTmDEyu1gdrfOtKW7+BtAOCbZ9EgcOdo2JwXwXnvW4fdLiugzcnoQTuEKt
	+hVvsn5YZv5GF2CiacByGm4tBOtc82/aD7bbpoLVwI8MeZQnOCJ09ESMFflblkmJ6dsAwC
	BLwJCJWkNCnXsh+F3s2crBPt66fAgsI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-VNSAnZ0fP1aPAmHA4kw2OQ-1; Tue, 01 Jul 2025 11:50:09 -0400
X-MC-Unique: VNSAnZ0fP1aPAmHA4kw2OQ-1
X-Mimecast-MFC-AGG-ID: VNSAnZ0fP1aPAmHA4kw2OQ_1751385008
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-453018b4ddeso33568485e9.3
        for <linux-cxl@vger.kernel.org>; Tue, 01 Jul 2025 08:50:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751385008; x=1751989808;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P/uTjjueacCrk9iWxrSPigoGAnsDBOasrqX6cOjFTgQ=;
        b=OI+ZSdOi1x456h1hvF9STrQ0vNiBZUHmcr2ZA+fMUYfMkNBRPnP+VIMVhQumdPglRH
         JM9XwZoSfm3l3VYilheRMvJrAMjVObXS6A/bbbsBa5yjdRdW9risvS+3uuHv6rGNhSLT
         u1ORclog34Y6FUyJgiOX4SyItww7R4TS8p46lq6dO9rE9sINAgvP4Pj+TCnFlhmTwpDf
         BlosLoPBUG8XNC/+QoATIbi51UBJY+SddJw85oVzA+o49PsS23xpSkV/Dmi2dYNuX54S
         Qs+d6Luty/eyqL8rPUcdKt2DpnqJ2biY/Tjn+k0x79REshpAp32S8Tt/Uv0JttaWuCaK
         rkIw==
X-Forwarded-Encrypted: i=1; AJvYcCUjz3NcK3h9k/0JXJHbhKH1wXASA5x3UYQHh8QH4ksTotbqfI2NrMX1uDtGQKfjaRRj/fgFWc35W4Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHDMmBedDahr/L/KdFcLJ/xRiyzXHPDtaAJERHfJisBREi1Dvi
	uiQ64z0vQWUJGVhUJmTH1+FErSmZnxbdYlgFpGkq5Eh7PCQplcXjBfTYJYUrW/B9u5cgQp+PM5D
	t3bHsjSVIFaO5qFeaZaEmOVh0Dif7bxfa7VlrWosb5tH7Zfvx07ycGSu8WPPYWA==
X-Gm-Gg: ASbGncuPIj2cgIjbsAZuXHw/+iFqOdIT5i1kZc8c9oFid7AvpEMf0rSjvAmXnFwH1Lb
	NHxAx84FWYQ4dnF6yBvbKoiYdWnYFTGh6LCDAjckIX6CeuuMnLQBwMRn2DjpBpLcJSzrPOxAWYC
	Yi1lM6DTiYxdbw/KDSWxYnzgIOdOWPjqswoESfRSgBhy/JO7QHIbSU7l5Lqtm1cBadIw8OByssL
	iRLKiya4H9IbEvhEaRsTTahPcCPuGzLUcbN97xTygH3UTCRcGw00lXDaOILZJJe22qQkvoMj3kJ
	nlTwQwVGr823e7+KW9yYSHOWA10mmVz61QzaHXns+MrEZMda2Z0sHhOnDfg4L0zDmmPQ+Q==
X-Received: by 2002:a05:600c:5491:b0:43c:fe90:1279 with SMTP id 5b1f17b1804b1-4538ee85900mr166291375e9.21.1751385008183;
        Tue, 01 Jul 2025 08:50:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFSjaCcv20JTLT5Z7l8zZE31W6uvOWaFUFaBFf+SLQsvyeRfijy3L3xJoCafOP1uED7rnpNlg==
X-Received: by 2002:a05:600c:5491:b0:43c:fe90:1279 with SMTP id 5b1f17b1804b1-4538ee85900mr166290895e9.21.1751385007628;
        Tue, 01 Jul 2025 08:50:07 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874? ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4538a40766csm171425715e9.32.2025.07.01.08.50.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jul 2025 08:50:07 -0700 (PDT)
Message-ID: <93f59259-c720-4c54-8829-fb13cdb8abdb@redhat.com>
Date: Tue, 1 Jul 2025 17:50:05 +0200
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: eric.auger@redhat.com
Subject: Re: [PATCH qemu v16 1/5] hw/cxl-host: Add an index field to
 CXLFixedMemoryWindow
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, qemu-devel@nongnu.org,
 Fan Ni <fan.ni@samsung.com>, Peter Maydell <peter.maydell@linaro.org>,
 mst@redhat.com, Zhijian Li <lizhijian@fujitsu.com>,
 Itaru Kitayama <itaru.kitayama@linux.dev>
Cc: linuxarm@huawei.com, linux-cxl@vger.kernel.org, qemu-arm@nongnu.org,
 Yuquan Wang <wangyuquan1236@phytium.com.cn>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250625161926.549812-1-Jonathan.Cameron@huawei.com>
 <20250625161926.549812-2-Jonathan.Cameron@huawei.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250625161926.549812-2-Jonathan.Cameron@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Yc8oWB0rycyLxISP7ZF5SptJ0TJuAXPvbb6VVRHTOuQ_1751385008
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/25/25 6:19 PM, Jonathan Cameron via wrote:
> To enable these to be found in a fixed order, that order needs to be known.
> This will later be used to sort a list of these structures so that address
> map and ACPI table entries are predictable.
>
> Tested-by: Li Zhijian <lizhijian@fujitsu.com>
> Reviewed-by: Li Zhijian <lizhijian@fujitsu.com>
> Reviewed-by: Fan Ni <fan.ni@samsung.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
>
> ---
> v16: Tested tag
> ---
>  include/hw/cxl/cxl.h | 1 +
>  hw/cxl/cxl-host.c    | 9 ++++++---
>  2 files changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/include/hw/cxl/cxl.h b/include/hw/cxl/cxl.h
> index 75e47b6864..b2bcce7ed6 100644
> --- a/include/hw/cxl/cxl.h
> +++ b/include/hw/cxl/cxl.h
> @@ -27,6 +27,7 @@
>  typedef struct PXBCXLDev PXBCXLDev;
>  
>  typedef struct CXLFixedWindow {
> +    int index;
>      uint64_t size;
>      char **targets;
>      PXBCXLDev *target_hbs[16];
> diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
> index e010163174..b7aa429ddf 100644
> --- a/hw/cxl/cxl-host.c
> +++ b/hw/cxl/cxl-host.c
> @@ -24,13 +24,15 @@
>  
>  static void cxl_fixed_memory_window_config(CXLState *cxl_state,
>                                             CXLFixedMemoryWindowOptions *object,
> -                                           Error **errp)
> +                                           int index, Error **errp)
>  {
>      ERRP_GUARD();
>      g_autofree CXLFixedWindow *fw = g_malloc0(sizeof(*fw));
>      strList *target;
>      int i;
>  
> +    fw->index = index;
> +
>      for (target = object->targets; target; target = target->next) {
>          fw->num_targets++;
>      }
> @@ -325,14 +327,15 @@ static void machine_set_cfmw(Object *obj, Visitor *v, const char *name,
>      CXLState *state = opaque;
>      CXLFixedMemoryWindowOptionsList *cfmw_list = NULL;
>      CXLFixedMemoryWindowOptionsList *it;
> +    int index;
>  
>      visit_type_CXLFixedMemoryWindowOptionsList(v, name, &cfmw_list, errp);
>      if (!cfmw_list) {
>          return;
>      }
>  
> -    for (it = cfmw_list; it; it = it->next) {
> -        cxl_fixed_memory_window_config(state, it->value, errp);
> +    for (it = cfmw_list, index = 0; it; it = it->next, index++) {
> +        cxl_fixed_memory_window_config(state, it->value, index, errp);
>      }
>      state->cfmw_list = cfmw_list;
>  }

