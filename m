Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0E42D5936
	for <linux-cxl@vger.kernel.org>; Fri, 21 Nov 2025 20:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763757103; cv=none; b=XT1xbK6S1ZdZcXw/VjodEl2Lti46/cWtFcXmFwrGsLnX4Qx1AhSIRxfDnsYLo80unie0ISMUCdwzyQtoH1HCShk0KK1UrjlYxcNdAvguzalNzfY7qAUpaarIn9PA13u4aP8FMqu81+b5/08Ae+ejPnA1D8LJQifVuigRKqTwxVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763757103; c=relaxed/simple;
	bh=pa2lyT7lPJyZEw5mcRC6aPDB+evn8VnEjaf3itbvr6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PprYjf8vDXLb0ktTn/f+iQkHojwfgHrmZF0PXzXer+EOk5NSlM8pXjuluuwVwZee4C1cuQX1VM416qNKYlUIwK4YEfeQsPN98zA03m18aWUbbWv9N0TB5dTuBGv4Ol3WTzDcKqlBCN89jVpy3gXeMIX4wpBsTG6F77z8cau7w74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=aqNR1+Wb; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="aqNR1+Wb"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8b2d32b9777so303668085a.2
        for <linux-cxl@vger.kernel.org>; Fri, 21 Nov 2025 12:31:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1763757101; x=1764361901; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MA/eAO+4QVAKat3kknBRmFeqDu1PBA3lvY9XwQeR9u8=;
        b=aqNR1+WbidCa6HATp8DPHIfa9qR6LRVqeSoWpLWjHgmHMiicg+a27Ap9m6O60kigmU
         IJiiaO4ljfSZ7pnaty4Zx9Vtp596BY2tTW3jFm1bd1HALpg6V6wI6f3DWQcKlo2jznEo
         CpSx1H+dqnc6lpTYkza0SknxfUAY9NES5qMs2qGEzdgdTpXwUGT9KaVXRzWpNXNrwBPR
         2VNkMhrfMHb28pVbv5aMdu63XorjCYOraOasTwqVjp08m2Y2jdTargvQ9iWWKYLenEd2
         bKpOr5x0dgaTD2ztiZbjH+GKrO4Zk/UN4KvnH9TqFbZgEwMXnh2js8ghkexZwhvqCrze
         RAIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763757101; x=1764361901;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MA/eAO+4QVAKat3kknBRmFeqDu1PBA3lvY9XwQeR9u8=;
        b=W9W+09q0kj3yv+fA8e7AwYadZ/x0Ue/jxJrt4TwDFh+HgL9IWfKj39j27Oh1OkAEvW
         qd3jDJOeLWeg7Tvwd+A6vPCGZWxKHb9CbX8TsWpkBzK3pt0nbt8BNIhA0WcaWoL+1JvN
         GFeL9mO6Beo6SFBpGXw9YFFRHIN8ZuxNuenDMr5DkPlRUrUrFoWS625KJ61Yxwth0if5
         /ETgIUAflFAxH4GDAr6XFYDI1ERlLgteaTdjfQ27pBzGplHa6Z2sp8RLKlwUfTjFn77D
         3wXy9UhDKhwIQb35YPeCpSBrxyx3B0UkX1A1wlOmTxgbseY7I1YBHY1ibkDziN5TznQe
         74ig==
X-Forwarded-Encrypted: i=1; AJvYcCVle33StavCflBULXA8KguFX7gFJoeVb5rEaestem6TFpMDoBlaFCKNgR2DTKM7Nsugpy+5Q3Krydw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/gEWhU0vOVig7fxk1hj/wfflXSEEFW6OtkQDIOONw/Bke9bRT
	31vJW720Q4B27sImn37zlU5xSTekm0cB530cC17ifbHNEqoOMjeYUpSg/jSCLyk9/FM=
X-Gm-Gg: ASbGnctx2Tx4Dcu3eIstk+cRd3fNt/+XOqbmVAvOYl8RTWFwIS9JkfXkVQ9VzWY5wTH
	etaD9l5jdU6k7llU2oAnkYBxi+nbt33LTR/D6doeVuLGEBCp6gF/NNTqWCUPJIr+W7QCcnWdcHm
	SiVh3HYNo1HudIE97uJJsAks1//0HY7iBANVXNXxymz4Vn/Ln1EtWNC5yUmNcEL6PBaJtgsRVsD
	bbDr4YmGkh1kqXVsWhhyTWPIv1vOfjQ652/nns904r8Z8uQAAT29+q94kkwRJGux6XVJMtxgxCG
	gkzv2zMUoPiJlDAKNaDiiPUdBmnR6bD7ztff+B3s2A5/syw37K9rClKcJ8StX0Guej4RC3IbC/z
	CEM9RA5Ofqihvb7UV7BmY1/T3f/8cBdxakG+vEOdqadz1PIxZwh1lYmHRvoUdldXz5wOGZOeW/P
	6IYJ06qoar4gRelVDGyhmC5jmT5da+2drT1cxg5k0DYqha32ZzwZ1QgIVyVwlJr5VbrGLihg==
X-Google-Smtp-Source: AGHT+IEppsMAgXRJUbmHUqOyXXTw2sZ/0rI2kwFa/51WHf2m//HJeX14YMFewHWFyaSeDb/zst1lPg==
X-Received: by 2002:a05:620a:4086:b0:8b2:e2ca:36b with SMTP id af79cd13be357-8b33d203ae7mr408745385a.3.1763757100743;
        Fri, 21 Nov 2025 12:31:40 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b3295db3e3sm428368085a.43.2025.11.21.12.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 12:31:40 -0800 (PST)
Date: Fri, 21 Nov 2025 15:31:29 -0500
From: Gregory Price <gourry@gourry.net>
To: Terry Bowman <terry.bowman@amd.com>
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, dan.j.williams@intel.com,
	bhelgaas@google.com, shiju.jose@huawei.com, ming.li@zohomail.com,
	Smita.KoralahalliChannabasappa@amd.com, rrichter@amd.com,
	dan.carpenter@linaro.org, PradeepVineshReddy.Kodamati@amd.com,
	lukas@wunner.de, Benjamin.Cheatham@amd.com,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	linux-cxl@vger.kernel.org, alucerop@amd.com, ira.weiny@intel.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [RESEND v13 02/25] PCI/CXL: Introduce pcie_is_cxl()
Message-ID: <aSDMId90SsE71p1W@gourry-fedora-PF4VCD3F>
References: <20251104170305.4163840-1-terry.bowman@amd.com>
 <20251104170305.4163840-3-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251104170305.4163840-3-terry.bowman@amd.com>

On Tue, Nov 04, 2025 at 11:02:42AM -0600, Terry Bowman wrote:
> CXL and AER drivers need the ability to identify CXL devices.
> 
> Introduce set_pcie_cxl() with logic checking for CXL.mem or CXL.cache
> status in the CXL Flexbus DVSEC status register. The CXL Flexbus DVSEC
> presence is used because it is required for all the CXL PCIe devices.[1]
> 
------>8
>  
> +static void set_pcie_cxl(struct pci_dev *dev)
> +{
> +	struct pci_dev *parent;
...
> +	parent = pci_upstream_bridge(dev);
> +	set_pcie_cxl(parent);
> +}
...
> +static inline bool pcie_is_cxl(struct pci_dev *pci_dev)
> +{
> +	return pci_dev->is_cxl;
> +}
> +

We have encountered a crash on QEMU where parent=NULL here

static inline struct pci_dev *pci_upstream_bridge(struct pci_dev *dev)
{
        dev = pci_physfn(dev);
        if (pci_is_root_bus(dev->bus))
                return NULL;

        return dev->bus->self;
}

~Gregory
