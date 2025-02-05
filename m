Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15381E0DE4
	for <linux-cxl@vger.kernel.org>; Wed,  5 Feb 2025 20:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738785722; cv=none; b=avqkHEzv83hnrcHl1pTmf9EgF2V6K9E/+Eb++8pPvbmz1Y2Hv5Is2OY47JQtT8k/QT8LvRTufPI/g5u/RTRya5eeT5Rq4sej1TXBRV5qHAEVudG0V+92ZaQKffmFiWpbVAfvD5ppyemzHqqZ5ssnpYX5vJ+vEWHRPJZAOUiZM9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738785722; c=relaxed/simple;
	bh=DTEdzO1IPs/iSbUR9qTXfHT/WQX6NcWLD+GyM4n0aio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gvr/u2ZitcK+iv0onwMFOrp1GRUk7lKUectX0CDTavAGPG63bC389Af5Oap8zKh4VfXnXiibxRo+W/pDPBV/gxLMwaMrJq86YBUpRfpjlcfHu4lv3ilEPd/mr4Bp9c65PGFcERkrbwVBSvuYc2oUjgUww+SwXfWEUvTuvz76QzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=iTizeO0r; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="iTizeO0r"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7bcf32a6582so10145185a.1
        for <linux-cxl@vger.kernel.org>; Wed, 05 Feb 2025 12:02:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1738785720; x=1739390520; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8VSpDNdk25O/o+fZMp288PyURrK/8ijexeUi7ezV/7c=;
        b=iTizeO0r8Q+SRPcDmjAneRsrBLngOQZuafT9vZ/vSQRDumKLFpdr7DSF2z1JGnAdw3
         hMnMBxrkLlV3iM7VYjqnqa9zh3xAHpC8GScBf28XzHnognANSaih+MXQzmWmvICOSLUb
         83JILGv+KliLiSI2Xh1RuTARjLFjrBN2b9NiVam/PJEYOw41GHHiKfPOfSPLt/z/gzWh
         tlW0WWvqEIuLiGF4KvChHc5wcsIr2w0IaHTup2aoNkNWwAupWpiofjdJay2hzFo4NLNI
         mhQb05IAdSD4Bc11fMKZEUQyvcqrdhjWCLkRGEKKoYko4cPkl5AiBThijVBDBt/qqpUI
         65mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738785720; x=1739390520;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8VSpDNdk25O/o+fZMp288PyURrK/8ijexeUi7ezV/7c=;
        b=a8detzwEU/zmK8jA+hffkJFXTFgn2vUZdFsqhDiHoLxmBVe4RzjvvJsDowuOAtbsKG
         xTnOVCHtfYQ25y4GIDVPomOc8bDSckh/ALkDUC3xIqxuY/X5+3vrwiyAqe5frBuKsy2x
         BaeqvIUYOTSF+JJmmKiTN3yLiuj3ojzp1dglIUe03rLw9q9OFdiemlg1rjFe48Y4y7Fu
         QT6O/b34Ht+N1M2SlOrHxOVI7Dj+Cl5oBafNF5q/MYxGYYaaKp+tL/Nj0NlXXp7DHtzj
         LPIwMvx+T6G6eGBesEUikYR0Hw8gqkGAuIU+GQx0O7jnJuY3tobrZEXaCLzwpHEU+VXN
         xhFw==
X-Forwarded-Encrypted: i=1; AJvYcCVGAoOecbW/AQRpdX+DXIXx30pJDlgMhY11q4JdB5ZqIkKQOWC7k2Vxibs83GjK55J84NUlu8FtNv4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ4hL8LPThIt3fqyp5b0cRQEdd94Wq4AVTbcTr8IuO+JVjg4XL
	7RTuAea4tQTQ7peE5UfaFKG+PN4fGGra9QxEgLGUjiC88fWGloLDwA5rA0b/WGM=
X-Gm-Gg: ASbGnctog4R7xR4kzJtwE1sLiOSxianWoEBJEuarK+ifJ6PkIGzLrVFCS+tBvrfO7h1
	H3iRhN/et2vGiRFXTBUaMW7xUNF/1Rt9dl5m+syZFBvA8IKTGSy5bp2CD0z5s1YUVo78TkMotUE
	bWjZ4yIHk59G7nDhGVGGliqXIZtOcjtZboj6cx0rqgf90pFfdxSmSi1BqicKUoh5fFRBJKIccy0
	3iPQTm/6kRQY/57o+TIhXbGGxZaPFZ834YXD0HdrHLxYuuM+BYhXV2oJpw3lwI0zEfF/5xYzJvo
	B04h3Wd/JmVPoPBnV4MeXHJ66cxuHgptsAkwJIS86ofk9JnazPNTm2C9kz8g2CCpKhSoVserhw=
	=
X-Google-Smtp-Source: AGHT+IEYVi/m8wptbaxkhbPZJ+EcqbJYgjUqN7w7U6N9+LnXprFFxitg56LH3NaoPg3BvPn36ADc1A==
X-Received: by 2002:a05:6214:f6c:b0:6d8:8256:41d4 with SMTP id 6a1803df08f44-6e42fbacae6mr68306776d6.19.1738785719721;
        Wed, 05 Feb 2025 12:01:59 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e4390abbf9sm2594556d6.94.2025.02.05.12.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 12:01:59 -0800 (PST)
Date: Wed, 5 Feb 2025 15:01:57 -0500
From: Gregory Price <gourry@gourry.net>
To: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>,
	Terry Bowman <terry.bowman@amd.com>
Subject: Re: [PATCH v6 6/6] cxl/pci: Add trace logging for CXL PCIe Port RAS
 errors
Message-ID: <Z6PDtW0omzmMjjXN@gourry-fedora-PF4VCD3F>
References: <20250123084421.127697-1-Smita.KoralahalliChannabasappa@amd.com>
 <20250123084421.127697-7-Smita.KoralahalliChannabasappa@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250123084421.127697-7-Smita.KoralahalliChannabasappa@amd.com>

On Thu, Jan 23, 2025 at 08:44:21AM +0000, Smita Koralahalli wrote:
> The CXL drivers use kernel trace functions for logging endpoint and
> Restricted CXL host (RCH) Downstream Port RAS errors. Similar functionality
> is required for CXL Root Ports, CXL Downstream Switch Ports, and CXL
> Upstream Switch Ports.
> 
> Introduce trace logging functions for both RAS correctable and
> uncorrectable errors specific to CXL PCIe Ports. Use them to trace
> FW-First Protocol errors.
> 
> Co-developed-by: Terry Bowman <terry.bowman@amd.com>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>

Reviewed-by: Gregory Price <gourry@gourry.net>

> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 9d4b5f39b21a..766447c169c8 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -1168,6 +1168,7 @@ static void cxl_cper_handle_prot_err(struct cxl_cper_prot_err_work_data *data)
>  		pci_get_domain_bus_and_slot(data->prot_err.agent_addr.segment,
>  					    data->prot_err.agent_addr.bus,
>  					    devfn);
> +	int port_type;
>  
>  	if (!pdev)
>  		return;
> @@ -1176,6 +1177,18 @@ static void cxl_cper_handle_prot_err(struct cxl_cper_prot_err_work_data *data)
>  	if (pdev->driver != &cxl_pci_driver)
>  		return;
>  
> +	port_type = pci_pcie_type(pdev);
> +	if (port_type == PCI_EXP_TYPE_ROOT_PORT ||
> +	    port_type == PCI_EXP_TYPE_DOWNSTREAM ||
> +	    port_type == PCI_EXP_TYPE_UPSTREAM) {

Almost wish this was a macro for the sake of style, but not worth it.

"corr_prot_err" and "port_prot_err" kind of blend at first glance. Not
worth holding anything up.

> +		if (data->severity == AER_CORRECTABLE)
> +			cxl_cper_trace_corr_port_prot_err(pdev, data->ras_cap);
> +		else
> +			cxl_cper_trace_uncorr_port_prot_err(pdev, data->ras_cap);
> +
> +		return;
> +	}
> +
>  	if (data->severity == AER_CORRECTABLE)
>  		cxl_cper_trace_corr_prot_err(pdev, data->ras_cap);
>  	else
> -- 
> 2.17.1
> 
