Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9D21E47B6;
	Tue,  5 Nov 2024 22:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730845559; cv=none; b=UoaRnwsPACfF6hPTFGshDrdXChOGmNNgvHDwmEqJJqmjmTS5DQQlt/Cab4PGqkvUQ4jcMbTtvXbTVsp7JPaokuI+viUUwh0JX7iILub+pryA6ZWDQF7bo2KhnLVjJhXstH59++395YeETUzTiZ3p+E5uMFJTnClEDcUAHQCdOnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730845559; c=relaxed/simple;
	bh=whOorrZ7Eik9VqbiSx61pa17ruyVQc/3yIyivtvJq7I=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uEFZtRtrhAMeJHKOoBKZnG3Vn/C0it12d562lQwztX89zFT5UYk/Z0MGUwTOu1dJIDHbYkoVno6RNqVc4p7WbUphSxi7879jwKF1UytOCzWE0sItFJ14WCW50mp6MO2eBUjSl3VnyoPjrPGPSiUAlk7uU8310zEDrngCdafhyPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RziXUI56; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RziXUI56"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6e35bf59cf6so3159287b3.0;
        Tue, 05 Nov 2024 14:25:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730845557; x=1731450357; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=52vqhDCmoIhudg9WzxHzapjTakOxz/EJYp8WYdwUHH4=;
        b=RziXUI56Aix5+3BjaNswixVjO34yAltWomcoT703pKg2zQosiSiTYhvaIEf39PQssx
         tc1/bhCxuYKnIUIkaQ02YEJR+iu6j08nodDCJhYF/gcqbHKkZFk8h6dluYhNAy+gVdFm
         Ecv825qPeRRYOrlxZLmq2GLklJlhqkP2kGu+0H9VAVWCYQ66sgYe6XY6IDYeJ3/MzEky
         dMYyAYh5WlFucqMjAqUBvhIMU3wQamrtlKPt4RUQaPQEQXvh8SDuyzVHbf2+C9yRBoOL
         TQ8z+Eq6feIPM/kHreTJV50wzW4+QvpgKsLvWYeTP7nJ5+uTv3UhOWDHWSk+uCoxV5nc
         6peQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730845557; x=1731450357;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=52vqhDCmoIhudg9WzxHzapjTakOxz/EJYp8WYdwUHH4=;
        b=NAsRGKkXZaqLRT2sgyG+G5f1ApP8OpU5nWBPqcPwKTJdGPfarhIwmbs0x0kwQjtQG3
         dO+keQFTzU5OsrvFVUM+G/vza+14qcqTEa/YKzBpc7wjGJgRK8ujOB5n421eeTyttaKR
         KH1mkp1F7HToinwRnZNh2x+gvL9sfox729vM5V2zEza+KHDGXc0krS2bYKHLYqly2qUy
         PQq0v88dTuewWKyyLncntMv+HfEq2U/2l0wulgxuoxIzEs9S+lH+NJSGJ/VjtMAISS0M
         rroFHWGsWzM9PG2J98LWg5oy4HSfpi3HO49DA1Nj2khJ98kj7XZBnnwuFCRMUTomUfUY
         WR5A==
X-Forwarded-Encrypted: i=1; AJvYcCVzEqqtA5+AagjemPMTx7LwCKcSdA22fde6fsyEYiouMG+Ba313XYBIqBhnV20w4BGSFHZRB7zpuWw=@vger.kernel.org, AJvYcCWLv1g1H/MGr/C3+gubvnMqSGyFTbX4Q3QwW9t+k0rzZeAuL8Mi0W5OWl2ItoPVJXPff7BjYaB+9Gf+XrN1@vger.kernel.org
X-Gm-Message-State: AOJu0YzHmJ++cGs7rZOoUkvJ5LoNQ8KOLAH9Y+mp0cqfsEvgEYIRI+o0
	rFXFbBnY99sVGM9trCDiGF3KDQeFE9dm4xwUZiU+mXQNehfNV1Up
X-Google-Smtp-Source: AGHT+IGvoyzktzmHcgdgqqbQC0Cngfe3lnekSdVj/mcoEbJ2ZOjDatY/KoUVzRIFZF5iJDawrsnVmQ==
X-Received: by 2002:a05:690c:6c03:b0:6e2:611:7abd with SMTP id 00721157ae682-6eabf049774mr2127787b3.20.1730845556959;
        Tue, 05 Nov 2024 14:25:56 -0800 (PST)
Received: from fan ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ea8d4ba90asm13947247b3.119.2024.11.05.14.25.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 14:25:56 -0800 (PST)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Tue, 5 Nov 2024 14:25:53 -0800
To: Huang Ying <ying.huang@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Gregory Price <gourry@gourry.net>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Alejandro Lucero <alucerop@amd.com>,
	Ben Cheatham <benjamin.cheatham@amd.com>
Subject: Re: [PATCH] cxl: Rename ACPI_CEDT_CFMWS_RESTRICT_TYPE2/TYPE3
Message-ID: <ZyqbcZJlti6mZZie@fan>
References: <20241104084110.583710-1-ying.huang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104084110.583710-1-ying.huang@intel.com>

On Mon, Nov 04, 2024 at 04:41:10PM +0800, Huang Ying wrote:
> According to the description of the "Window Restrictions" field of
> "CFMWS Structure" in the CXL spec v3.1 section 9.18.1.3: CXL Fixed
> Memory Window Structure (CFMWS), the bit 0 of "Window Restrictions" is
> formerly known as "CXL Type 2 Memory" and renamed to "Device
> Coherent", while the bit 1 is formerly known as "CXL Type 3 Memory"
> and renamed to "Host-only Coherent".  Because type 3 memory can only
> be host-only coherent before, while it can be host-only coherent or
> device coherent with "Back-Invalidate" now.
> 
> To avoid confusion about type 2/3 memory and device/host-only coherent
> in Linux kernel, the patch renames corresponding bit definition from
> ACPI_CEDT_CFMWS_RESTRICT_TYPE2/TYPE3 to
> ACPI_CEDT_CFMWS_RESTRICT_DEVMEM/HOSTONLYMEM.  This makes the kernel
> code consistent with the spec too.
> 
> The patch also renames the corresponding cxl_decoder flags
> CXL_DECODER_F_TYPE2/TYPE3 to CXL_DECODER_F_DEVMEM/HOSTONLYMEM.
> 
> No functionality change is expected.
> 
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Suggested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
> Reviewed-by: Gregory Price <gourry@gourry.net>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Alison Schofield <alison.schofield@intel.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: Alejandro Lucero <alucerop@amd.com>
> Cc: Ben Cheatham <benjamin.cheatham@amd.com>
> ---

Reviewed-by: Fan Ni <fan.ni@samsung.com>

>  drivers/cxl/acpi.c           |  8 ++++----
>  drivers/cxl/core/port.c      |  8 ++++----
>  drivers/cxl/cxl.h            | 14 +++++++-------
>  include/acpi/actbl1.h        | 10 +++++-----
>  tools/testing/cxl/test/cxl.c | 18 +++++++++---------
>  5 files changed, 29 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index 82b78e331d8e..aca8cbb7540d 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -115,10 +115,10 @@ static unsigned long cfmws_to_decoder_flags(int restrictions)
>  {
>  	unsigned long flags = CXL_DECODER_F_ENABLE;
>  
> -	if (restrictions & ACPI_CEDT_CFMWS_RESTRICT_TYPE2)
> -		flags |= CXL_DECODER_F_TYPE2;
> -	if (restrictions & ACPI_CEDT_CFMWS_RESTRICT_TYPE3)
> -		flags |= CXL_DECODER_F_TYPE3;
> +	if (restrictions & ACPI_CEDT_CFMWS_RESTRICT_DEVMEM)
> +		flags |= CXL_DECODER_F_DEVMEM;
> +	if (restrictions & ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM)
> +		flags |= CXL_DECODER_F_HOSTONLYMEM;
>  	if (restrictions & ACPI_CEDT_CFMWS_RESTRICT_VOLATILE)
>  		flags |= CXL_DECODER_F_RAM;
>  	if (restrictions & ACPI_CEDT_CFMWS_RESTRICT_PMEM)
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index a5e6f3d23cfb..8524714968fd 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -125,8 +125,8 @@ static DEVICE_ATTR_RO(name)
>  
>  CXL_DECODER_FLAG_ATTR(cap_pmem, CXL_DECODER_F_PMEM);
>  CXL_DECODER_FLAG_ATTR(cap_ram, CXL_DECODER_F_RAM);
> -CXL_DECODER_FLAG_ATTR(cap_type2, CXL_DECODER_F_TYPE2);
> -CXL_DECODER_FLAG_ATTR(cap_type3, CXL_DECODER_F_TYPE3);
> +CXL_DECODER_FLAG_ATTR(cap_type2, CXL_DECODER_F_DEVMEM);
> +CXL_DECODER_FLAG_ATTR(cap_type3, CXL_DECODER_F_HOSTONLYMEM);
>  CXL_DECODER_FLAG_ATTR(locked, CXL_DECODER_F_LOCK);
>  
>  static ssize_t target_type_show(struct device *dev,
> @@ -326,14 +326,14 @@ static struct attribute *cxl_decoder_root_attrs[] = {
>  
>  static bool can_create_pmem(struct cxl_root_decoder *cxlrd)
>  {
> -	unsigned long flags = CXL_DECODER_F_TYPE3 | CXL_DECODER_F_PMEM;
> +	unsigned long flags = CXL_DECODER_F_HOSTONLYMEM | CXL_DECODER_F_PMEM;
>  
>  	return (cxlrd->cxlsd.cxld.flags & flags) == flags;
>  }
>  
>  static bool can_create_ram(struct cxl_root_decoder *cxlrd)
>  {
> -	unsigned long flags = CXL_DECODER_F_TYPE3 | CXL_DECODER_F_RAM;
> +	unsigned long flags = CXL_DECODER_F_HOSTONLYMEM | CXL_DECODER_F_RAM;
>  
>  	return (cxlrd->cxlsd.cxld.flags & flags) == flags;
>  }
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 0fc96f8bf15c..b9083ce1cf74 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -315,13 +315,13 @@ resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
>   * Additionally indicate whether decoder settings were autodetected,
>   * user customized.
>   */
> -#define CXL_DECODER_F_RAM   BIT(0)
> -#define CXL_DECODER_F_PMEM  BIT(1)
> -#define CXL_DECODER_F_TYPE2 BIT(2)
> -#define CXL_DECODER_F_TYPE3 BIT(3)
> -#define CXL_DECODER_F_LOCK  BIT(4)
> -#define CXL_DECODER_F_ENABLE    BIT(5)
> -#define CXL_DECODER_F_MASK  GENMASK(5, 0)
> +#define CXL_DECODER_F_RAM         BIT(0)
> +#define CXL_DECODER_F_PMEM        BIT(1)
> +#define CXL_DECODER_F_DEVMEM      BIT(2)
> +#define CXL_DECODER_F_HOSTONLYMEM BIT(3)
> +#define CXL_DECODER_F_LOCK        BIT(4)
> +#define CXL_DECODER_F_ENABLE      BIT(5)
> +#define CXL_DECODER_F_MASK        GENMASK(5, 0)
>  
>  enum cxl_decoder_type {
>  	CXL_DECODER_DEVMEM = 2,
> diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
> index 199afc2cd122..e195909928df 100644
> --- a/include/acpi/actbl1.h
> +++ b/include/acpi/actbl1.h
> @@ -551,11 +551,11 @@ struct acpi_cedt_cfmws_target_element {
>  
>  /* Values for Restrictions field above */
>  
> -#define ACPI_CEDT_CFMWS_RESTRICT_TYPE2      (1)
> -#define ACPI_CEDT_CFMWS_RESTRICT_TYPE3      (1<<1)
> -#define ACPI_CEDT_CFMWS_RESTRICT_VOLATILE   (1<<2)
> -#define ACPI_CEDT_CFMWS_RESTRICT_PMEM       (1<<3)
> -#define ACPI_CEDT_CFMWS_RESTRICT_FIXED      (1<<4)
> +#define ACPI_CEDT_CFMWS_RESTRICT_DEVMEM        (1)
> +#define ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM   (1<<1)
> +#define ACPI_CEDT_CFMWS_RESTRICT_VOLATILE      (1<<2)
> +#define ACPI_CEDT_CFMWS_RESTRICT_PMEM          (1<<3)
> +#define ACPI_CEDT_CFMWS_RESTRICT_FIXED         (1<<4)
>  
>  /* 2: CXL XOR Interleave Math Structure */
>  
> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> index 90d5afd52dd0..9d919fc99f6b 100644
> --- a/tools/testing/cxl/test/cxl.c
> +++ b/tools/testing/cxl/test/cxl.c
> @@ -209,7 +209,7 @@ static struct {
>  			},
>  			.interleave_ways = 0,
>  			.granularity = 4,
> -			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_TYPE3 |
> +			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM |
>  					ACPI_CEDT_CFMWS_RESTRICT_VOLATILE,
>  			.qtg_id = FAKE_QTG_ID,
>  			.window_size = SZ_256M * 4UL,
> @@ -224,7 +224,7 @@ static struct {
>  			},
>  			.interleave_ways = 1,
>  			.granularity = 4,
> -			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_TYPE3 |
> +			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM |
>  					ACPI_CEDT_CFMWS_RESTRICT_VOLATILE,
>  			.qtg_id = FAKE_QTG_ID,
>  			.window_size = SZ_256M * 8UL,
> @@ -239,7 +239,7 @@ static struct {
>  			},
>  			.interleave_ways = 0,
>  			.granularity = 4,
> -			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_TYPE3 |
> +			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM |
>  					ACPI_CEDT_CFMWS_RESTRICT_PMEM,
>  			.qtg_id = FAKE_QTG_ID,
>  			.window_size = SZ_256M * 4UL,
> @@ -254,7 +254,7 @@ static struct {
>  			},
>  			.interleave_ways = 1,
>  			.granularity = 4,
> -			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_TYPE3 |
> +			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM |
>  					ACPI_CEDT_CFMWS_RESTRICT_PMEM,
>  			.qtg_id = FAKE_QTG_ID,
>  			.window_size = SZ_256M * 8UL,
> @@ -269,7 +269,7 @@ static struct {
>  			},
>  			.interleave_ways = 0,
>  			.granularity = 4,
> -			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_TYPE3 |
> +			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM |
>  					ACPI_CEDT_CFMWS_RESTRICT_PMEM,
>  			.qtg_id = FAKE_QTG_ID,
>  			.window_size = SZ_256M * 4UL,
> @@ -284,7 +284,7 @@ static struct {
>  			},
>  			.interleave_ways = 0,
>  			.granularity = 4,
> -			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_TYPE3 |
> +			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM |
>  					ACPI_CEDT_CFMWS_RESTRICT_VOLATILE,
>  			.qtg_id = FAKE_QTG_ID,
>  			.window_size = SZ_256M,
> @@ -301,7 +301,7 @@ static struct {
>  			.interleave_arithmetic = ACPI_CEDT_CFMWS_ARITHMETIC_XOR,
>  			.interleave_ways = 0,
>  			.granularity = 4,
> -			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_TYPE3 |
> +			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM |
>  					ACPI_CEDT_CFMWS_RESTRICT_PMEM,
>  			.qtg_id = FAKE_QTG_ID,
>  			.window_size = SZ_256M * 8UL,
> @@ -317,7 +317,7 @@ static struct {
>  			.interleave_arithmetic = ACPI_CEDT_CFMWS_ARITHMETIC_XOR,
>  			.interleave_ways = 1,
>  			.granularity = 0,
> -			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_TYPE3 |
> +			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM |
>  					ACPI_CEDT_CFMWS_RESTRICT_PMEM,
>  			.qtg_id = FAKE_QTG_ID,
>  			.window_size = SZ_256M * 8UL,
> @@ -333,7 +333,7 @@ static struct {
>  			.interleave_arithmetic = ACPI_CEDT_CFMWS_ARITHMETIC_XOR,
>  			.interleave_ways = 2,
>  			.granularity = 0,
> -			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_TYPE3 |
> +			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM |
>  					ACPI_CEDT_CFMWS_RESTRICT_PMEM,
>  			.qtg_id = FAKE_QTG_ID,
>  			.window_size = SZ_256M * 16UL,
> -- 
> 2.39.2
> 

-- 
Fan Ni
