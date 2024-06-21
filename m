Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F21B168C20
	for <linux-cxl@vger.kernel.org>; Fri, 21 Jun 2024 07:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718953958; cv=none; b=iuVmoGHcdnOuCQQ1aqpqx2Nf6OhKK3Sehlzyy9HB2CcOXyIrzZosL27ENhcl/Iee6353Hnn6P1x8RPB5vMWYR1VlH69trNORyBIn2ArVUtKiOAk6gKXzZJ36TzUK7ZwLo0XFFRLrfuiO+nPJk4+0Y4rfX3ONWbAUj5cIudxhfjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718953958; c=relaxed/simple;
	bh=t4qq/jMiGnxrp5BYlBkmNLXJVDdDBuIgqirUGO8bPfw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mDPciCxBSC9fvm7ef9gEkg8ZHc1S8rWKD4oti2nD6dV7M0OFZaefPj82JmGHks/4C/FDGPiNsAPwdGZZVn7xexY4lhCz3CwD3m/n2ryrMRQk7d3QhEqFsM8lN6kzHLdPfw+mYSWKLZp+SzkAdtkf76XiV6MmusSDpoRt4AAadEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pjYE0fcm; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pjYE0fcm"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a6ef64b092cso189127666b.1
        for <linux-cxl@vger.kernel.org>; Fri, 21 Jun 2024 00:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718953954; x=1719558754; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+X3r3iWIZnsDCFWQKHQoaKS+fjEdqxnm5cTkv/byPH8=;
        b=pjYE0fcmHaw0T1EhtX1EyqPa7iLeaNSiGlErlAJj5QqxB4F49QtdgP3PM1ozWTBawS
         rT8v1T0s9lNZ79XCeCv5r/Q2A/lu6gZc8mxi7kSjBgu7euo4D/6gUGpD8tEc1qG0AnAn
         tl3leXOV5GVCaG27FpiiegWPnDX+8UekaEPHVXEKaTG0oKBXtCcfdAtTSiypTqRYD4Ot
         lTsfOWgowyp4iT7R9KTXciB0SeXdMfwn/GOn8aunBpf+K4MNpKh2dNmQMgsCW6ZMOBHZ
         04RXvKdD66fIq6ggHOdsV/Nem6ap6KT4zQsC+fP96HDGbwl2hGWXv/FZPK6T8EjQjoH0
         dxCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718953954; x=1719558754;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+X3r3iWIZnsDCFWQKHQoaKS+fjEdqxnm5cTkv/byPH8=;
        b=AkwnPQdXP+dfBGXF3wE+OCAXADL5fwzp9zmyMwH31gS6RpvooUVaenTwco5cFR0kY7
         2+Z053BneG1p1SNU3uaONr0ZUSEyXt6oWchroNJLZUvtNBqhgZBNjnEPcbg2OMiCkipC
         ItOwCdZpzsRU+mJDjvTqggFrThqDL40q0f5g2bkNFpvzAXNnXcFFyQnIENa0MxjhUwx+
         BmSh+mrZ6cSoYa1yk50FruYX8tHhiHJJ6U3srCh0yFqpCGZ/fK0MUEFwKDKR2lSvLyu8
         HrNii3YQF/a3/P100UzJpyQvEqqLUBFqMKw+CXwurxS5+dn1/6LkCnbUEBMWSJpnE3ZD
         2NBQ==
X-Gm-Message-State: AOJu0YzvsZBYbUqGxg6RwXzCNxpU6KEVbzy72utJ6KT8iSVkQWNmi+FP
	1GGy7rK9EmSeSV3mklJKbid2E0xIDD/5sSuVPyX6SKjH4qP+lAHeDUOe0yr1sKE=
X-Google-Smtp-Source: AGHT+IGDJt4eeNhXv751/YEEHTjXvtvEWkZD5alLeIkIR1Kuc8t5AALKvfHYqcG3IrFQoZbVt7a9rQ==
X-Received: by 2002:a17:907:1888:b0:a6f:ae81:174 with SMTP id a640c23a62f3a-a6fae81070dmr532101366b.18.1718953954206;
        Fri, 21 Jun 2024 00:12:34 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.128.209])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6fcf5490eesm50524766b.111.2024.06.21.00.10.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jun 2024 00:12:33 -0700 (PDT)
Message-ID: <140c112f-450c-4cc8-a57c-36a96d29130c@linaro.org>
Date: Fri, 21 Jun 2024 09:10:09 +0200
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 1/4] bswap: Add the ability to store to an unaligned 24
 bit field
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, qemu-devel@nongnu.org,
 Michael Tsirkin <mst@redhat.com>, Fan Ni <fan.ni@samsung.com>
Cc: linux-cxl@vger.kernel.org, linuxarm@huawei.com,
 Ira Weiny <ira.weiny@intel.com>, Michael Roth <michael.roth@amd.com>,
 Dave Jiang <dave.jiang@intel.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Mike Maslenkin <mike.maslenkin@gmail.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>
References: <20230526170010.574-1-Jonathan.Cameron@huawei.com>
 <20230526170010.574-2-Jonathan.Cameron@huawei.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20230526170010.574-2-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Ira & Jonathan,

On 26/5/23 19:00, Jonathan Cameron wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> CXL has 24 bit unaligned fields which need to be stored to.  CXL is
> specified as little endian.
> 
> Define st24_le_p() and the supporting functions to store such a field
> from a 32 bit host native value.
> 
> The use of b, w, l, q as the size specifier is limiting.  So "24" was
> used for the size part of the function name.
> 
> Reviewed-by: Fan Ni <fan.ni@samsung.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>   docs/devel/loads-stores.rst |  2 ++
>   include/qemu/bswap.h        | 25 +++++++++++++++++++++++++
>   2 files changed, 27 insertions(+)
> 
> diff --git a/docs/devel/loads-stores.rst b/docs/devel/loads-stores.rst
> index d2cefc77a2..dab6dfa0ac 100644
> --- a/docs/devel/loads-stores.rst
> +++ b/docs/devel/loads-stores.rst
> @@ -36,6 +36,7 @@ store: ``st{size}_{endian}_p(ptr, val)``
>   ``size``
>    - ``b`` : 8 bits
>    - ``w`` : 16 bits
> + - ``24`` : 24 bits
>    - ``l`` : 32 bits
>    - ``q`` : 64 bits
>   
> @@ -65,6 +66,7 @@ of size ``sz`` bytes.
>   Regexes for git grep
>    - ``\<ld[us]\?[bwlq]\(_[hbl]e\)\?_p\>``
>    - ``\<st[bwlq]\(_[hbl]e\)\?_p\>``
> + - ``\<st24\(_[hbl]e\)\?_p\>``

Interestingly this regexp mentions st24_be_p() but this patch
only adds st24_le_p() and st24_he_p().

No need to update the regexp, I'll post a patch with st24_be_p()
since I have use for it.

>    - ``\<ldn_\([hbl]e\)?_p\>``
>    - ``\<stn_\([hbl]e\)?_p\>``
>   
> diff --git a/include/qemu/bswap.h b/include/qemu/bswap.h
> index 15a78c0db5..933a66ee87 100644
> --- a/include/qemu/bswap.h
> +++ b/include/qemu/bswap.h
> @@ -8,11 +8,23 @@
>   #undef  bswap64
>   #define bswap64(_x) __builtin_bswap64(_x)
>   
> +static inline uint32_t bswap24(uint32_t x)
> +{
> +    return (((x & 0x000000ffU) << 16) |
> +            ((x & 0x0000ff00U) <<  0) |
> +            ((x & 0x00ff0000U) >> 16));
> +}
> +
>   static inline void bswap16s(uint16_t *s)
>   {
>       *s = __builtin_bswap16(*s);
>   }
>   
> +static inline void bswap24s(uint32_t *s)
> +{
> +    *s = bswap24(*s & 0x00ffffffU);
> +}
> +
>   static inline void bswap32s(uint32_t *s)
>   {
>       *s = __builtin_bswap32(*s);
> @@ -26,11 +38,13 @@ static inline void bswap64s(uint64_t *s)
>   #if HOST_BIG_ENDIAN
>   #define be_bswap(v, size) (v)
>   #define le_bswap(v, size) glue(__builtin_bswap, size)(v)
> +#define le_bswap24(v) bswap24(v)
>   #define be_bswaps(v, size)
>   #define le_bswaps(p, size) \
>               do { *p = glue(__builtin_bswap, size)(*p); } while (0)
>   #else
>   #define le_bswap(v, size) (v)
> +#define le_bswap24(v) (v)
>   #define be_bswap(v, size) glue(__builtin_bswap, size)(v)
>   #define le_bswaps(v, size)
>   #define be_bswaps(p, size) \
> @@ -176,6 +190,7 @@ CPU_CONVERT(le, 64, uint64_t)
>    * size is:
>    *   b: 8 bits
>    *   w: 16 bits
> + *   24: 24 bits
>    *   l: 32 bits
>    *   q: 64 bits
>    *
> @@ -248,6 +263,11 @@ static inline void stw_he_p(void *ptr, uint16_t v)
>       __builtin_memcpy(ptr, &v, sizeof(v));
>   }
>   
> +static inline void st24_he_p(void *ptr, uint32_t v)
> +{
> +    __builtin_memcpy(ptr, &v, 3);
> +}
> +
>   static inline int ldl_he_p(const void *ptr)
>   {
>       int32_t r;
> @@ -297,6 +317,11 @@ static inline void stw_le_p(void *ptr, uint16_t v)
>       stw_he_p(ptr, le_bswap(v, 16));
>   }
>   
> +static inline void st24_le_p(void *ptr, uint32_t v)
> +{
> +    st24_he_p(ptr, le_bswap24(v));
> +}
> +
>   static inline void stl_le_p(void *ptr, uint32_t v)
>   {
>       stl_he_p(ptr, le_bswap(v, 32));

