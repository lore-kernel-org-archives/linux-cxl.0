Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7453890F7
	for <linux-cxl@vger.kernel.org>; Fri, 19 Jun 2026 13:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781874770; cv=none; b=ssjz7UJVBVOUL5SY5HjYdqUf9nQIAmjprb3aqx1nCkIz4qIWXux/BPUbcYG+QzlCnBuc7afvxsQiVxuFKYjcc5aR/CSykMQ0tKPe9Y9zQ0CIthyWr+QQsiBVXwSFmXnYCuuAQw4tcr5Z7dKkM6JByWy/fZaKnd4lsMK2/ciA6p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781874770; c=relaxed/simple;
	bh=Nkuj7e0uLIcw2dQ+72Ht/EJgUArLcj7dXa28YZgE0v4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XeTp/zi8bnJTq2e88GAPByFN4DeZ99rYw5CRgLpTwT8T5BkXSUobbxdcKV6vvmoSw3ZvmgWTYC7PYrElmbhqwjqcHuiP57KszwpSgRXYHlvEs1Cq6APmATxQ/n6bLY+JQj4l5A3xn/uCoX+pRoOGNMKmM3QEj+wdyvAPoPkFRl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m2swHUjb; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m2swHUjb"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-4624a44e152so1755074f8f.2
        for <linux-cxl@vger.kernel.org>; Fri, 19 Jun 2026 06:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781874768; x=1782479568; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cYYIAxjrT/iNiD/3UYstOUuE19cihfkCG33B5fDVbBM=;
        b=m2swHUjbXSoTp6MOCg72HAv5y/+zClcauNiU8Q/5IOeS+TgDn5P9BZ8BMHvDD4C1Cs
         xJfvaTUOTSE8Ns9RV79cjIwNdfocl5E4GZr32924oCOp6d9ycUndMPe73zI2hJFrhqLj
         kMtpReM53tcAEEbyg52JU054ALYJDZ98GQEe9Pdb5J7T3ntMMx1pk3vDp5KpCInqopft
         P0eDwLGOQJUKvFtgmEzddeB5xfFMmbM0Rvs+1dpP4bp/cgMuEVnncRwRU/pyQx0Ad73M
         tXDDWh/3ASLZbJspZ0VUqedfnbo2WAIeGYa7gQUpp8Jl3LTCSJ3cwxX80/cD7Ts36CDn
         axOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781874768; x=1782479568;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cYYIAxjrT/iNiD/3UYstOUuE19cihfkCG33B5fDVbBM=;
        b=CJWLiIyZvxs3MpWnfLHRSL6ymMKyCs+9/OswGj40IOEQYSfO7RvEjEgkHt8/Ftwiqf
         ZLd43TALkzAXi++k6cM61ZVqm8ZQ+lqp1XogUHWKoCoaE4/MZHOAwKQigi+KOBYkcz3d
         9c1zEsjpupkKdjlOcgHVWh/DsyhM6e9Fj0Ol8UowU0F9jM6wImLEwm1N+G/GFu2KFd9j
         YJGFqY0rn4m/T0fkfpRsBOd6OgugOSOU9l3Y9RrgL7W29eTdzyQ0gWs3VnUTptgGAoLy
         W2Vmn3Ra9dP05yrhQ51qpXO43NuoDWIkS5Y9/akhjvqQK+1yLPYAOMNvU2+Wamo/vEA8
         Fomw==
X-Forwarded-Encrypted: i=1; AFNElJ90KFiQ+4uznu2MAh5qZxkruRzMGnxLYCzGLPnipFCoQUHlYzdl3YbL15DbSamXZj5NIQBtfThKaSQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYJEQYnDNPB9wvhxzRsD+2MNTwHgw9E+bxbI0kZFGXnX4PD/ux
	xuSw50wSBoCK2G+2a0lwa4CdOVqMH459iz87rW9zC1dUKivABVxF/KFX
X-Gm-Gg: AfdE7ckbVPH2lAjbkMueZdSAsuuH7XVQZdxt4MJLj0Q3Fda0d6vGLZZY0HcfjNnAkZ4
	c1PrQTvh0ToTpPSwaXqeRFGtZ0rP141mCTIc9NLeBntd/dS7p0z7ubNzHEt71QN/MIo9rbRmQ4s
	dls9tDKdtI1zKfiAFDaY/2zFtxJr2iLMAcAIcoVEVVN6D7fJEB79uUrADSzB3UwWAiwIocSH9ou
	W+kIXvNSbUJVMLxq0NlIIzz7o5lVYwtilU/bY0djGfBQjMD4q7wVOO0xJvliGZmFCBx029fg4vJ
	03Y7qdGSEnSpVb+WiTSDRGRQIym0k6cvxXxMginQmYy1PlGtrAZrYmoFlTh616lka4oX9lHwZgj
	IkanN60Uce0l0AIlAVkwWNzrvd1l7pKNB/lUOKUgAOchYEgQItfUrzNSX8731Fbe4Sy9f7oq9c0
	btKB5DVz3TrMrlt+bMmMvyHf8BStMrXXXTuCgnAKmpTHTAb+iULoTDLUUgWBCOzsNrjNDIsKnHD
	nxLEXzhcN3GHw==
X-Received: by 2002:a5d:5d8a:0:b0:460:1233:ecf2 with SMTP id ffacd0b85a97d-46508afa0eemr6766999f8f.30.1781874767770;
        Fri, 19 Jun 2026 06:12:47 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4650bc42a3asm7999337f8f.31.2026.06.19.06.12.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jun 2026 06:12:47 -0700 (PDT)
Message-ID: <f28ab562-5caa-487e-a837-dbc0ac24a46c@gmail.com>
Date: Fri, 19 Jun 2026 14:12:45 +0100
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v28 1/5] sfc: add cxl support
To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, djbw@kernel.org, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, dave.jiang@intel.com
Cc: Alejandro Lucero <alucerop@amd.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Dan Williams <dan.j.williams@intel.com>
References: <20260618181806.118745-1-alejandro.lucero-palau@amd.com>
 <20260618181806.118745-2-alejandro.lucero-palau@amd.com>
Content-Language: en-GB
From: Edward Cree <ecree.xilinx@gmail.com>
In-Reply-To: <20260618181806.118745-2-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/06/2026 19:18, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Add CXL initialization based on new CXL API for accel drivers and make
> it dependent on kernel CXL configuration.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Acked-by: Edward Cree <ecree.xilinx@gmail.com>
> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
...
> diff --git a/drivers/net/ethernet/sfc/net_driver.h b/drivers/net/ethernet/sfc/net_driver.h
> index b98c259f672d..de3fc9537662 100644
> --- a/drivers/net/ethernet/sfc/net_driver.h
> +++ b/drivers/net/ethernet/sfc/net_driver.h
> @@ -1197,14 +1197,23 @@ struct efx_nic {
>  	atomic_t n_rx_noskb_drops;
>  };
>  
> +#ifdef CONFIG_SFC_CXL
> +struct efx_cxl;
> +#endif
> +
>  /**
>   * struct efx_probe_data - State after hardware probe
>   * @pci_dev: The PCI device
>   * @efx: Efx NIC details
> + * @cxl: details of related cxl objects
> + * @cxl_pio_initialised: cxl initialization outcome.
>   */
>  struct efx_probe_data {
>  	struct pci_dev *pci_dev;
>  	struct efx_nic efx;
> +#ifdef CONFIG_SFC_CXL
> +	struct efx_cxl *cxl;
> +#endif
>  };

The documented cxl_pio_initialised member does not appear to exist.
Will this not cause a kerneldoc build error?
