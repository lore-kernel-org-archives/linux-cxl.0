Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E540D2C0F9B
	for <linux-cxl@vger.kernel.org>; Fri, 15 Aug 2025 15:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755271685; cv=none; b=SXE9h8048TNPHoeDYDfcNFn9O2Q4KhozH6ReZa9nksxQdPwypME1j5d3BUocWeBWbugN8ka0sVlwod3QX2soDd9rd7sJapSIMTn0SCzvZ3bpwoCvqzRD+bUb0I9uroBmeLZivTpydqUFBTiTycV8DrAI+N2VuoAOC2bQDk8R/s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755271685; c=relaxed/simple;
	bh=s2yqtxVv04BTA67cMsL/qLJJXvrwx4L7S0PZzmFjIgY=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kCzkyhzkhwMANlPFSitXUjZC46Kpoi+qXkK17iAhaDZbAd2crh/QN1JteqlIH2E4ztM7SRA+31+GqSbXBUsNAA6vx3Rrbdgjofdv9DwqiXXdm3W0WNlXifUKSBtCZq5ga8JmrlKfMpk2R1ZNdEj2xKteaMSldRONquxSuyEMzLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4c3QsP3TLgz6L5Gd;
	Fri, 15 Aug 2025 23:25:13 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id EDAA9140432;
	Fri, 15 Aug 2025 23:28:00 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 15 Aug
 2025 17:28:00 +0200
Date: Fri, 15 Aug 2025 16:27:58 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Davidlohr Bueso <dave@stgolabs.net>
CC: <dave.jiang@intel.com>, <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<alison.schofield@intel.com>, <alucerop@amd.com>, <a.manzanares@samsung.com>,
	<anisa.su@samsung.com>, <linux-cxl@vger.kernel.org>, "Rafael J. Wysocki"
	<rafael.j.wysocki@intel.com>
Subject: Re: [PATCH 2/3] acpi, tables: Rename coherency CFMW restrictions
Message-ID: <20250815162758.00000c6d@huawei.com>
In-Reply-To: <20250812010228.2589787-3-dave@stgolabs.net>
References: <20250812010228.2589787-1-dave@stgolabs.net>
	<20250812010228.2589787-3-dave@stgolabs.net>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500012.china.huawei.com (7.191.174.4) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 11 Aug 2025 18:02:27 -0700
Davidlohr Bueso <dave@stgolabs.net> wrote:

> This has been renamed in more recent CXL specs, as
> type3 (memory expanders) can also use HDM-DB for
> device coherent memory.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>

actbl1 is generated from acpica (more or less anyway).
So you need to make the changes there..

That makes renaming trickier.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ca321d1ca6723ed0e04edd09de49c92b24e3648e

is an example of such a rename.

Seems like a reasonable thing to do - can we decouple this from
the rest of the set?

> ---
>  drivers/cxl/acpi.c           |  4 ++--
>  include/acpi/actbl1.h        |  4 ++--
>  tools/testing/cxl/test/cxl.c | 18 +++++++++---------
>  3 files changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index 712624cba2b6..9b32392c82fc 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -113,9 +113,9 @@ static unsigned long cfmws_to_decoder_flags(int restrictions)
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

