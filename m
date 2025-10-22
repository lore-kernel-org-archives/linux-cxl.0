Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA073016F7
	for <linux-cxl@vger.kernel.org>; Wed, 22 Oct 2025 20:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761166691; cv=none; b=SWh5wDF+7DtFx3WTFZHcnNtL4LZzHSXRaBdNDfsWS64WbZ0ZENmLYD677JaBpm8j7u6X6v/YTGx3QErNmZ62fGx4ppAy5DyAP5xR90T/GeIc47NqCnMljtNVhidTuAzNiO0mQlBo7+AvLnzLWZHrI8WxG5IfyvM7T3QZdHDH/Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761166691; c=relaxed/simple;
	bh=TQpYo82do9fbPBhDgOo/xfuRqTcK0JdKSr5C7vhi+wM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l4BXWBe59ol/AHVpb9uzuA212eM0EHI7OJ4VbtTZVQnzAxMKGML2BR4ymnzDNen3axBkZ+5oPFHe6gSRcs7fLHg/OA3T07nTYNPnbNp9AmH0guUp3jZKD5lzeE6SDElwMgqJCF2/I2CQ4Azg2OI9wctbKVlKxvdEu3lc1BH3HAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v7XkJIrI; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v7XkJIrI"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-63c44ea68f6so3824a12.0
        for <linux-cxl@vger.kernel.org>; Wed, 22 Oct 2025 13:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761166686; x=1761771486; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KntpGwyw2h1eRy075Psp2+8kVtmZoXi9VrfpKSJ4LV4=;
        b=v7XkJIrI7Mdd37n2sXuirq21chYlo91VOEZZVE+iNnlxw/nrfkxFwGYL3J6q8gXcPZ
         wpzTemHYt+RbcRcTIASA44rzxN1qMzjpRF6OVs41oJKdYGK1cCCBgd0fqvqg5e5S7/hi
         Pvjb9bp8egNQv/lJlr5sb1pMC++aKLCIhrPvf5oZcUMKmJ/L0i/QyjM8OeNpUSEprhuI
         76JNV+8BzUNY8ZyIW5QjqfMoOYLoxdj03JDcE1+3Ij5my2SpSqXdsLbSpNberXHbnxnU
         G2riA+BaPsf5yB4FzraXY+Vp0ZOLtVwQd/571ZbEVJZ6LXZZUL4Ya6rYKeqet7WTxJ5/
         Q+/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761166686; x=1761771486;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KntpGwyw2h1eRy075Psp2+8kVtmZoXi9VrfpKSJ4LV4=;
        b=i2kCuTr1ceJa8Tf2m2V2i1GkTyjKbUejs2XOCXtzaz8ZNwZEYbHzDKBRcRnaA8epih
         EprdEwaBBg4f8wgoiMspIFv+qh8TMV6MEPjp5S/S8M1Pwb3/9bBz2m0lCs8MLhh3ybjX
         IJ458GyFrMUGZ4YhgQpKqp6OaQx6chC+A31P7ROJyhSEvf+LKJlPio95LRVyH9wzwL9H
         G4sqCIB6Ig9E9S7cJpMxTuQLWdhAOXEW7qQ7VpMMc3O22qmyh/D02TImA23TAAq/iOwQ
         VraNbAi0D1irWgJycLnlKN9ad9OvNuseI+l4pHUnwtrIHPQN1DjrF96QbbWJ3IO6BOLo
         2cjQ==
X-Forwarded-Encrypted: i=1; AJvYcCXaGCHf8OdB6slJuMCVfP8Ijqc6p/yr3bTal1DdDqIuFiLSbl2dShidwGgb+oSszAQM7eG6dXRPKug=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr8fdLlPYZuaRVPKnEATDUGInNEhc2mW65VA8a6DiYSBeAA2lh
	7sYfCh1iULrs9b78zWJOQDiyLlC8jhfjh0o+7ZhfQjnO1u8C2xxFS1a3TWKGWVafTFiYOLkB30s
	A1ZxG3q2AQ9Kj1cgbIUMMVWnEEmRGv6H1HcEH6mEW
X-Gm-Gg: ASbGnctIKRqgThqiOwMuWcL/U+jRYYL1Ol9ZmW0ItZ5Op02euED7e/nzSZrjIbvuRCk
	BbJse5j/xd0uGr6OuKQzW3056sMy1JOMUkaubCkp+hXwpPQ84vyEl9jzY036ZuMC2Fusk7ZsPqR
	pI0yle37p8SVAulzDQIK5p1wEddKpXST/PWciJNL+tSwEDkFju6qZP6DnEEHLwOfNujPgW9yhS4
	lWiGX5efnuNTjNY6HQWHiimu2GMgRRbIk7GSEWKMIFxuoIGCelmywVROAViywzLqvQCA0I20XYt
	E315Gcm3xNpQzJjIP8kkj/W0aA==
X-Google-Smtp-Source: AGHT+IHgF4j/mUZEDqZAl++xOkAYLCnDO8Iy/nIey1xYjKyG9Wp2IkcKh6OYcT7hZgMYLxTQIiT4e0yyMs4NIgQAgdA=
X-Received: by 2002:a05:6402:461c:20b0:63e:11ae:ff2e with SMTP id
 4fb4d7f45d1cf-63e3dfecdf6mr6012a12.3.1761166686350; Wed, 22 Oct 2025 13:58:06
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251002131900.3252980-1-mclapinski@google.com>
In-Reply-To: <20251002131900.3252980-1-mclapinski@google.com>
From: =?UTF-8?B?TWljaGHFgiBDxYJhcGnFhHNraQ==?= <mclapinski@google.com>
Date: Wed, 22 Oct 2025 13:57:55 -0700
X-Gm-Features: AS18NWD7w3Vu9VTTfAZBw3yA23oVp-mhN22JxweH_RPe5JsaBthUo_xHsiEjfTs
Message-ID: <CAAi7L5cJ=D76pD4tb5Bs0ULGXMEOM_yQcftFBQMZmzDJTzBZ+g@mail.gmail.com>
Subject: Re: [PATCH 1/1] dax: add PROBE_PREFER_ASYNCHRONOUS to the pmem driver
To: Dan Williams <dan.j.williams@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

ping

On Thu, Oct 2, 2025 at 6:19=E2=80=AFAM Michal Clapinski <mclapinski@google.=
com> wrote:
>
> Comments in linux/device/driver.h say that the goal is to do async
> probing on all devices. The current behavior unnecessarily slows down
> the boot by synchronous probing dax_pmem devices, so let's change that.
>
> Signed-off-by: Michal Clapinski <mclapinski@google.com>
> ---
>  drivers/dax/pmem.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/dax/pmem.c b/drivers/dax/pmem.c
> index bee93066a849..737654e8c5e8 100644
> --- a/drivers/dax/pmem.c
> +++ b/drivers/dax/pmem.c
> @@ -77,6 +77,7 @@ static struct nd_device_driver dax_pmem_driver =3D {
>         .probe =3D dax_pmem_probe,
>         .drv =3D {
>                 .name =3D "dax_pmem",
> +               .probe_type =3D PROBE_PREFER_ASYNCHRONOUS,
>         },
>         .type =3D ND_DRIVER_DAX_PMEM,
>  };
> --
> 2.51.0.618.g983fd99d29-goog
>
