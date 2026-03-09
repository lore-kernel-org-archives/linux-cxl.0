Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9B186323
	for <linux-cxl@vger.kernel.org>; Mon,  9 Mar 2026 00:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773014787; cv=none; b=NZB7jIEbCL07yw9hj9lGIu4a9gg4mG++H3KjehHImquxYYmMu0CZlAEbBzFO6RN2dyONpPzNwxQe+A5KgrODsLF+HeqwAI1RiX2yZT0SdwLkElVaOo+tWOquLjBfjbCgSzz93bzkVcxIqamrnj4TzgVMB46iDS5MDCWSkXpf+us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773014787; c=relaxed/simple;
	bh=GWAy4SlMgiiwMcJuaHhTNI8/YoEwWVInasLRrMpru8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DUSwcolH81aPj+J61aXoQFuD+5iqnksP7VN837tqiltSo2WJT2VMER6m9PMv/QTuSeoCjunWWzcm5Qph8iizXIVJvIE+07GAseer4GGn9LEKLQJgEtwABuFXP7s18n+6+rcsz90ec4u01e91gbsAiAd630H0tF88/Z9jOz07WHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=q5Mq8Zim; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="q5Mq8Zim"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-899ed41208fso147127446d6.1
        for <linux-cxl@vger.kernel.org>; Sun, 08 Mar 2026 17:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1773014784; x=1773619584; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E63/CSKkVqJAC9JwqiUKsNfXHYaOZS6yvHj9VcfqZOQ=;
        b=q5Mq8ZimzAmQAvCl4LRsYoTfV8vKR4edPgDtkja/uvxinS/YTlrSoXy6ixxBCHJN0e
         NzJjMTDQty/4gfg4cpWdquehDv45bIs0UYwUFnpm43PIxbCDr3z2i/29fM6uFTro6TqW
         NRC8dC0A/eeAvX0J8g6v2GV2JpP4jyc3nPluHR9UMt88tFfEbFekp9KroRcaRutDKo3t
         2UoNEbkhh5Gdf46Ff9trb3uBrH+yRIaK0rEy3eqZf7Wge+Kj8dWcs3TvG2/AikkSrG2t
         Bv7euFGgUXvxItk3PFESsO0lhhkPj5vDmHt5SWzcR43MJvBiCfq9KseLj4YMswakJ/jE
         NQCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773014784; x=1773619584;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E63/CSKkVqJAC9JwqiUKsNfXHYaOZS6yvHj9VcfqZOQ=;
        b=pail3DAFbUSGyr9eFDoR65zuNXNSEVEhOzR47Liv4aWwQFxCvLOyikltUUx0mj104d
         mlXU1cOP4Wwth8KdujzCStIfGfNmv2nI9E6vBlPfw15bwN9kr1t90coflc3xRoiEQg5A
         ME/IdwVDctqwa7+RCtKSBe0PdPGY/+iwAiRULsNNHTMCqFVfQfZOB9lPhVX9ax4bjhwN
         26y90fzxrEzZvzhxnhAWeL/qYRPWEI5afN15k+GjK+NLlvZxYx4IS/QAu9+f/Nfzqgh3
         o+zo/sWU1UyPMGmrM7MMMsLDpkoLzwyopsaCnEm/uBy4cRyd4jxET9yXQdzoFZVCAQLy
         bMkg==
X-Forwarded-Encrypted: i=1; AJvYcCUxV6w7hnTQ2R3u1fCUhh+FI99BGTUHvIMtEu6BakWsiW8fVzZLXjqrjruHv8gSBMBwoH4sbduku0g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6EKftv44emNr8bHT+5WidMUaXxd38DPN2bTdtrNtuEnVLRFpJ
	fdjml2X1c8YvDeEwPIeKIH8GWUE62kdK3c/KHAqA/hipR97W4R6fRwlEpN7Y76aKQhc=
X-Gm-Gg: ATEYQzz8JL1j/71Mkbxu6hEaBpPwv5aNwZsoxmYlvzo+W483qkTPugWB8XLy2JaDjx2
	0wear4R9uDU9zQjwpUsiYvICRG26VuVMwMG5q1C6MRxY6V5j7SdcwGBTdL/7F1QigeNjGz3FbiK
	rPGrvPZgNjao/DbbWYTGRVD405uzHriCnBbiMMHlYMszrA24L54FI8zv5FS3gW3iEcokBBEmEoE
	jGSzbRC14rOJAjxBFI3JxEFCxSytoZtXTBNMTw5zIcZNMvX8HWiAbnq6LT7rJTwxBhOHjSiszbZ
	jHV5P45zTllOU20BJzsbH+YPXlhP/n44ug1MVGzU5rhExHvPMCa2CeBXuOCxcS8dOG2KAGXh6Y7
	tJDagdWuOGccOp6ccfQx6v/iToSABPCahWheZ1sVGWg6aIVlvbXcGHkZyxm13tf8f5/aTY3ULnj
	FVYi5szqBMugcb6xOYaiRz9tHk5tT2ZWdmRURhPIy76aqovtnXI4ReuI77lYu9sNdr1tn/QQW2m
	NsyCP7ZJA==
X-Received: by 2002:a05:6214:f6a:b0:89a:7d9:34a0 with SMTP id 6a1803df08f44-89a30a8006emr148896126d6.29.1773014784142;
        Sun, 08 Mar 2026 17:06:24 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a316ec97dsm66613336d6.42.2026.03.08.17.06.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2026 17:06:23 -0700 (PDT)
Date: Sun, 8 Mar 2026 20:06:21 -0400
From: Gregory Price <gourry@gourry.net>
To: Kai Huang <kai.huang@intel.com>
Cc: rafael@kernel.org, lenb@kernel.org, dan.j.williams@intel.com,
	alison.schofield@intel.com, akpm@linux-foundation.org,
	nunodasneves@linux.microsoft.com, xueshuai@linux.alibaba.com,
	thorsten.blum@linux.dev, wangyuquan1236@phytium.com.cn,
	linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ACPI: NUMA: Only parse CFMWS at boot when CXL_ACPI is
 on
Message-ID: <aa4O_TC7Kzbov6bv@gourry-fedora-PF4VCD3F>
References: <20260308222313.14014-1-kai.huang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260308222313.14014-1-kai.huang@intel.com>

On Mon, Mar 09, 2026 at 11:23:13AM +1300, Kai Huang wrote:
> On CXL platforms, the Static Resource Affinity Table (SRAT) may not
> cover memory affinity information for all the CXL memory regions.  Since
> each CXL memory region is enumerated via a CXL Fixed Memory Window
> Structure (CFMWS), during early boot the kernel parses the CFMWS tables
> to find all CXL memory regions and sets a NUMA node for each of them.
> This memory affinity information of CXL memory regions is later used by
> the CXL ACPI driver.
> 
... snip ...
> 
> Signed-off-by: Kai Huang <kai.huang@intel.com>

lgtm

Reviewed-by: Gregory Price <gourry@gourry.net>

