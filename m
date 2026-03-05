Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DCB14C92
	for <linux-cxl@vger.kernel.org>; Thu,  5 Mar 2026 22:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772748756; cv=none; b=UxjIr/a8pW+TX9OTA7N1FKc0GFaeF9rAWkayY6h5muATL5PdAYjgjdK8Ut5mMA5rGLCgTNFvCADKAgVDujbIno/oanU5OiqRckW4idSmMAmKpzJHD3t9Pvi95tVM9eBvZiT8odKUKjyPqS8xQ9yxq6DKoSdOuR4e2RdoNeURe6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772748756; c=relaxed/simple;
	bh=cD7keNVqKO66z5caWaShEkr1oLV7r7N4lIInpsIX6iA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qX9z2DQO4bw04/wcbKtjQqBDvqpxe0JWuNL5dSPY0zdUgfupZiZhKD9eQyaslQRDppkgdfEHYFPn1D54k2uRiSm38Th7LouzafuuLgBM0hTog6t3gkQLaX8OfnOr0W6uPCND8oczyDoufLo7RlnzSqsn9nKAImpCp+dvw3o4C2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=T5/JJkbE; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="T5/JJkbE"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8cb40030be5so741977785a.3
        for <linux-cxl@vger.kernel.org>; Thu, 05 Mar 2026 14:12:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1772748754; x=1773353554; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TaiWtkMQU6fi41Urfn0LehyyPirliXR9UoU6x9wIkJ0=;
        b=T5/JJkbET8gtqlGAmBUzYt3JCPuqZXiFGNUDbpXAQvjSQYDAag7GbZ0xLPcvlRsGLD
         oZ14roYoVFE5LgWBr8Xq9YQ3c9ABqwMfkpWb8gntLkt1vcwGIrZ1MKsU2F1wjm4FaW+h
         2TuRnrINs3XW29nfBOhXcOSTDm9FzgnNhkvJX5Fr3T9GCPOknRIMFf2OU35YALdnyHTz
         V/zQY65h6vVfrXcRTCebiCKOtlUErxiJJ1oReI1tdFgZmfOxtuk5+gPYPI4OnOauRGW9
         oMUxgAw26GPJBgkmd7Pj9RdeKp1/3UOaFo8hRoi7QUGnltUnC2/hyPFdbtuFEOTQ6Csm
         aqvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772748754; x=1773353554;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TaiWtkMQU6fi41Urfn0LehyyPirliXR9UoU6x9wIkJ0=;
        b=gWI6/tebNhl9j0iGu729PbA8BL3Bb34Tjc3LI8xwOAMMmONSB9nhF6Bs/dqTSNqrjm
         CPzGgDPs/4dzsmj3uH3LV3NX1/Wo/7ZcDAViCudTCvTdqOM3GK52As8JyN9TOmy5S+or
         KPsNt2GOl6YlR8WbgNcF/m4bYlws0QY9LB9qS7O78/puqW/rPUCfARy1iGSaS/UahBhe
         fNMdS59GmrlZQ53s28O9d7aW0vRaoqQA5rW5ghd9nc9quzqnK6kU0RJU/JZSPdYb5tpZ
         KgantxlKyEJp2kUdAzA4q3+0OXDz1BMW5VhLIsQtGHRfTqSP+rL5KW6mVqHWeRnqJc4T
         LWxQ==
X-Gm-Message-State: AOJu0YzD8DnxGheE7y7Vn/4TVXNGZ92wWUw9pPYCNiBmOM/paYr/7oAI
	D97aguy9CFgFYYYYgUAsCvDrJ5fhgD3SqIOSw6NJdyto2lcDeMHOe4vndwBTm8uKUv4=
X-Gm-Gg: ATEYQzxo8GfTnT0DVYmBoiO/y6EYBNejlOtooM7YqmDicfxJ/tXxYivLUKiOZmp6+tn
	0bFF45leShyQJJWVswUyVVUD5yYFjKadLtVA3Hfp+omYFLE8yDm8Rz4QInz640qlRG/YEQAFqu+
	NaDJcdlReHP+BrWyC9xoG4HI5dcX57PACm8w/GLOW7zGzQMnC/wXeqhZFntoyYQIB6c3WhmtYVf
	6+OoAgC0M2ljndXKlbLl4IX42Wqx+sC3EQZ5uNUUac0oTqB1xWfAF4OZAACtfOCpM8LKRqSARYi
	EmTwvHVeE2+TgYG9V4P2s15nW6tjWuGdIooEafLSmCv4kyAuHQ5wWP6HTKeA5d0/bXbHmNw+uw/
	TA51ZDrIx4IEs+7gSqGgn/MBlQppQo+KBCtItnztEtlNzUjIc+e/7eCJBKJeGglpPFKZk9dkfXt
	gR0g3fAG4WAaIbfwvfuHX4FN7sTh3a2EDVZPIOfPpi9vDad2wVHXTQN1hCkDayfsZ2Y9yez+8mb
	Knr4rMBWsx6PTzpV4ay
X-Received: by 2002:a05:620a:bcd:b0:8c9:ebf3:7623 with SMTP id af79cd13be357-8cd6d3847f8mr16738185a.20.1772748753917;
        Thu, 05 Mar 2026 14:12:33 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cbbf72d3casm2003253885a.42.2026.03.05.14.12.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 14:12:33 -0800 (PST)
Date: Thu, 5 Mar 2026 17:12:31 -0500
From: Gregory Price <gourry@gourry.net>
To: Keith Busch <kbusch@meta.com>
Cc: linux-cxl@vger.kernel.org, dan.j.williams@intel.com,
	dave.jiang@intel.com, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] cxl/acpi: Fix CXL_ACPI and CXL_PMEM Kconfig tristate
 mismatch
Message-ID: <aan_z0psj080u1e_@gourry-fedora-PF4VCD3F>
References: <20260305204057.1516948-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260305204057.1516948-1-kbusch@meta.com>

On Thu, Mar 05, 2026 at 12:40:56PM -0800, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Commit e7e222ad73d9 moves devm_cxl_add_nvdimm_bridge() into the cxl_pmem
> file, which has independent config compile options for built-in or
> module. The call from cxl_acpi_probe() is guarded by
> IS_ENABLED(CONFIG_CXL_PMEM), which evaluates to true for both =y and =m.
> 
> When CONFIG_CXL_PMEM=m, a built-in cxl_acpi attempts to reference a
> symbol exported by a module, which fails to link. CXL_PMEM cannot simply
> be promoted to =y in this configuration because it depends on LIBNVDIMM,
> which may itself be =m.
> 
> Add a Kconfig dependency to prevent CXL_ACPI from being built-in when
> CXL_PMEM is a module. This contrains CXL_ACPI to =m when CXL_PMEM=m,
> while still allowing CXL_ACPI to be freely configured when CXL_PMEM is
> either built-in or disabled.
> 
> Fixes: e7e222ad73d9 ("cxl: Move devm_cxl_add_nvdimm_bridge() to cxl_pmem.ko")
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>  drivers/cxl/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> index 4589bf11d3fe0..80aeb0d556bd7 100644
> --- a/drivers/cxl/Kconfig
> +++ b/drivers/cxl/Kconfig
> @@ -59,6 +59,7 @@ config CXL_ACPI
>  	tristate "CXL ACPI: Platform Support"
>  	depends on ACPI
>  	depends on ACPI_NUMA
> +	depends on CXL_PMEM || !CXL_PMEM

Trivially looking at this it looks funky lol

alternatively:

https://lore.kernel.org/linux-cxl/20260302200429.803417-1-gourry@gourry.net/

Not sure which one we want here

~Gregory
