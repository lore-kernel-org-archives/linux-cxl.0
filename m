Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638DE1F4191
	for <linux-cxl@vger.kernel.org>; Mon,  8 Sep 2025 21:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757367488; cv=none; b=qryhUq03Ybqp/FdRqt+CW+lq/Y3G0ITTmCSikP14QEPTfG7ElssL1wanYlWiIe5Ko0DN++ZIjCdNStJ6qSBDR3IE6fj09UoDLx7Ak59ItsTQqVfq38ko6uPJp4jg2Md2yWyUa0iuqzjV3QeMXbR/Z9t/LSDyduYU/MhIqDQcJ9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757367488; c=relaxed/simple;
	bh=sGKAUSPWt72301AlV1XawXJ3CDU4bmDDcpLUoU+28l4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dIUT/RaN5KaBcV4vxPJdZ9hu8NA5IhzDdkfsabonbdCaaLjTKMJ7tu50Ykjmmu3fyOSypXtDmWMdPGFzWoJJxqZ50oR3vaInnJoNRGOyhCD8YgtEyzI062WayZVYN7RsRDqOXfK9xx3kg9R9VRhyRMSBi/zSeEkOL7d/KN296iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Vh0pxMpP; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Vh0pxMpP"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-81076e81a23so528824885a.3
        for <linux-cxl@vger.kernel.org>; Mon, 08 Sep 2025 14:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1757367485; x=1757972285; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NtWqIRzbFovdcSLeep8mjuBoNwQeZf18KQ3SwdIPUDE=;
        b=Vh0pxMpP9cid/A5EtkxHj+Iii/llPJEjGsr7LVeNKO3UCU3jJB835m0RWCAVqDKFIM
         wd6oP2aWsKSuC8Y9ZyKjeVRxLlc4MSbW45zUtP3fQ0Jx+83JIBACtqLIYb7oC84w1poc
         Km6B7BbjJyEzoc+54ancWEoAeg8tfucaGsJb8vpbEBo4ye4qwjsbf336ocbhO2QQRqR3
         0lmfOS/+ERPmaShUEVapWj/epoxALYa7qtMNguaObmsupDTLrSuvTEaSM6FZxmy7FabJ
         crloxkg5SgUr41wl72O6XztRgzewNSOeiaWMQl0uEIns4gePL9+EpLpc1CHk4zc0dqPI
         +5/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757367485; x=1757972285;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NtWqIRzbFovdcSLeep8mjuBoNwQeZf18KQ3SwdIPUDE=;
        b=vIvJfZ9nLoIUGjjf04ISg4KFOuXjgqT7iilS1BRND/kbrLRNnGYbsxcDhnyAdxgEbF
         yKJqjGVuH6sQr2XjMcELQj403RG8lIx/pDrDZcovT1V7j9OKcuGRRob3mRqDL+kfPWTV
         K/2giYKd+48kuxkGLBkQkkLTtGtAFgKjqLw5X6kta1xYk+5/+FHUjeTnYxsf5g9WP75M
         zU9VROp1Gml1h1xGFSEdut0yV2tBusRZa3LzKeoQGDsk7vnxp0/NvPkvXneGUJZz7h2b
         eL5UDgo4Fb5NMWt2DGIku0r79ehA2HA+vjNLDTFum7bDyR8X7+LPN8P+QsC2rH0fW1JG
         zduQ==
X-Forwarded-Encrypted: i=1; AJvYcCUyeJMKKOIbagbpI5pPJoKLebcCg0vyT6G4CJjMqRWJ9kvgz9Zho342q0Iv5DBttkgI9uPsvSr5358=@vger.kernel.org
X-Gm-Message-State: AOJu0YytHxxGmANvY06uWmy9SATZeC4tPTr80g84c97DB/WbyaINLsRH
	azMMUHLTigUqM060pI3MsR1xBpsa82X2RRu1hMz+e3anAEPqsjZqbYPbu6MBD1XFFFk=
X-Gm-Gg: ASbGncscHYr1j54uxwebm7fpN+h3AJzW44U9IfVLEc0B/TGTfkUwoUj6OZGpsmMKMTs
	/vtr2kwu8lwmtWIOgq4EzFpGx5qm1LwelhU0ulxQ8YTNBIu1EjJk3boj40HoERcGDIA0ih7nIhZ
	bZRSZqh4NgXXHIzUT7zJcxv96rrKkvT5U7FAne2LGTAvBBI1/5kSNWcbLDpaM+cOsHwad4bhq6v
	fRTJakyuRA+wwpUdBWIxukGH4KULGWOVH9mITbV4P/K1AxWpDmkFrOOmL7KNtCsbChlxZ4h141W
	U8GqoN1/TwvSrMgqjcUXhYMWx1vNQuVDcJCbicWW4qtmxojpdb0lBDiZZO2dRcF4O7q3strGP3j
	e5Ca2AHMiP1IzRVkhZCHJpMmvjohJFSTAiLJpr+IqDYe0TD/+mLcuCB4v4AdpFbEkWmUKb3wVe/
	eXCJwA
X-Google-Smtp-Source: AGHT+IGlwkMwHqETiA01AKALwBe420gp98TAGKqwCprXx942usJ9cIL4QaLvUEMs6r4ETu/CxJ4FOw==
X-Received: by 2002:a05:620a:d81:b0:804:6af0:277a with SMTP id af79cd13be357-813c30f0e45mr946958585a.70.1757367484981;
        Mon, 08 Sep 2025 14:38:04 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (ip-185-104-139-70.ptr.icomera.net. [185.104.139.70])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-81b5ee69108sm9067585a.56.2025.09.08.14.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 14:38:04 -0700 (PDT)
Date: Mon, 8 Sep 2025 17:38:01 -0400
From: Gregory Price <gourry@gourry.net>
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: rafael.j.wysocki@intel.com, dave.jiang@intel.com,
	dan.j.williams@intel.com, jonathan.cameron@huawei.com,
	alejandro.lucero-palau@amd.com, ira.weiny@intel.com,
	alison.schofield@intel.com, a.manzanares@samsung.com,
	linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Rafael J . Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2] cxl/acpi: Rename CFMW coherency restrictions
Message-ID: <aL9MuRca9SfRAINy@gourry-fedora-PF4VCD3F>
References: <20250908160034.86471-1-dave@stgolabs.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250908160034.86471-1-dave@stgolabs.net>

On Mon, Sep 08, 2025 at 09:00:34AM -0700, Davidlohr Bueso wrote:
> ACPICA commit 710745713ad3a2543dbfb70e84764f31f0e46bdc
> 
> This has been renamed in more recent CXL specs, as
> type3 (memory expanders) can also use HDM-DB for
> device coherent memory.
> 
> Link: https://github.com/acpica/acpica/commit/710745713ad3a2543dbfb70e84764f31f0e46bdc
> Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>

Reviewed-by: Gregory Price <gourry@gourry.net>

> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
>  drivers/cxl/acpi.c           |  4 ++--
>  include/acpi/actbl1.h        |  4 ++--
>  tools/testing/cxl/test/cxl.c | 18 +++++++++---------
>  3 files changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index 26c494704437..2cf75b553f26 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -128,9 +128,9 @@ static unsigned long cfmws_to_decoder_flags(int restrictions)
>  {
>  	unsigned long flags = CXL_DECODER_F_ENABLE;
>  
> -	if (restrictions & ACPI_CEDT_CFMWS_RESTRICT_TYPE2)
> +	if (restrictions & ACPI_CEDT_CFMWS_RESTRICT_DEVMEM)
>  		flags |= CXL_DECODER_F_TYPE2;
> -	if (restrictions & ACPI_CEDT_CFMWS_RESTRICT_TYPE3)
> +	if (restrictions & ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM)
>  		flags |= CXL_DECODER_F_TYPE3;
>  	if (restrictions & ACPI_CEDT_CFMWS_RESTRICT_VOLATILE)
>  		flags |= CXL_DECODER_F_RAM;
> diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
> index 99fd1588ff38..eb787dfbd2fa 100644
> --- a/include/acpi/actbl1.h
> +++ b/include/acpi/actbl1.h
> @@ -560,8 +560,8 @@ struct acpi_cedt_cfmws_target_element {
>  
>  /* Values for Restrictions field above */
>  
> -#define ACPI_CEDT_CFMWS_RESTRICT_TYPE2      (1)
> -#define ACPI_CEDT_CFMWS_RESTRICT_TYPE3      (1<<1)
> +#define ACPI_CEDT_CFMWS_RESTRICT_DEVMEM      (1)
> +#define ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM (1<<1)
>  #define ACPI_CEDT_CFMWS_RESTRICT_VOLATILE   (1<<2)
>  #define ACPI_CEDT_CFMWS_RESTRICT_PMEM       (1<<3)
>  #define ACPI_CEDT_CFMWS_RESTRICT_FIXED      (1<<4)
> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> index 6a25cca5636f..ba50338f8ada 100644
> --- a/tools/testing/cxl/test/cxl.c
> +++ b/tools/testing/cxl/test/cxl.c
> @@ -210,7 +210,7 @@ static struct {
>  			},
>  			.interleave_ways = 0,
>  			.granularity = 4,
> -			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_TYPE3 |
> +			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM |
>  					ACPI_CEDT_CFMWS_RESTRICT_VOLATILE,
>  			.qtg_id = FAKE_QTG_ID,
>  			.window_size = SZ_256M * 4UL,
> @@ -225,7 +225,7 @@ static struct {
>  			},
>  			.interleave_ways = 1,
>  			.granularity = 4,
> -			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_TYPE3 |
> +			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM |
>  					ACPI_CEDT_CFMWS_RESTRICT_VOLATILE,
>  			.qtg_id = FAKE_QTG_ID,
>  			.window_size = SZ_256M * 8UL,
> @@ -240,7 +240,7 @@ static struct {
>  			},
>  			.interleave_ways = 0,
>  			.granularity = 4,
> -			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_TYPE3 |
> +			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM |
>  					ACPI_CEDT_CFMWS_RESTRICT_PMEM,
>  			.qtg_id = FAKE_QTG_ID,
>  			.window_size = SZ_256M * 4UL,
> @@ -255,7 +255,7 @@ static struct {
>  			},
>  			.interleave_ways = 1,
>  			.granularity = 4,
> -			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_TYPE3 |
> +			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM |
>  					ACPI_CEDT_CFMWS_RESTRICT_PMEM,
>  			.qtg_id = FAKE_QTG_ID,
>  			.window_size = SZ_256M * 8UL,
> @@ -270,7 +270,7 @@ static struct {
>  			},
>  			.interleave_ways = 0,
>  			.granularity = 4,
> -			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_TYPE3 |
> +			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM |
>  					ACPI_CEDT_CFMWS_RESTRICT_PMEM,
>  			.qtg_id = FAKE_QTG_ID,
>  			.window_size = SZ_256M * 4UL,
> @@ -285,7 +285,7 @@ static struct {
>  			},
>  			.interleave_ways = 0,
>  			.granularity = 4,
> -			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_TYPE3 |
> +			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM |
>  					ACPI_CEDT_CFMWS_RESTRICT_VOLATILE,
>  			.qtg_id = FAKE_QTG_ID,
>  			.window_size = SZ_256M,
> @@ -302,7 +302,7 @@ static struct {
>  			.interleave_arithmetic = ACPI_CEDT_CFMWS_ARITHMETIC_XOR,
>  			.interleave_ways = 0,
>  			.granularity = 4,
> -			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_TYPE3 |
> +			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM |
>  					ACPI_CEDT_CFMWS_RESTRICT_PMEM,
>  			.qtg_id = FAKE_QTG_ID,
>  			.window_size = SZ_256M * 8UL,
> @@ -318,7 +318,7 @@ static struct {
>  			.interleave_arithmetic = ACPI_CEDT_CFMWS_ARITHMETIC_XOR,
>  			.interleave_ways = 1,
>  			.granularity = 0,
> -			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_TYPE3 |
> +			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM |
>  					ACPI_CEDT_CFMWS_RESTRICT_PMEM,
>  			.qtg_id = FAKE_QTG_ID,
>  			.window_size = SZ_256M * 8UL,
> @@ -334,7 +334,7 @@ static struct {
>  			.interleave_arithmetic = ACPI_CEDT_CFMWS_ARITHMETIC_XOR,
>  			.interleave_ways = 8,
>  			.granularity = 1,
> -			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_TYPE3 |
> +			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM |
>  					ACPI_CEDT_CFMWS_RESTRICT_PMEM,
>  			.qtg_id = FAKE_QTG_ID,
>  			.window_size = SZ_512M * 6UL,
> -- 
> 2.39.5
> 
