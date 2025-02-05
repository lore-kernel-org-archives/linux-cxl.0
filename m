Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADFD01DBB03
	for <linux-cxl@vger.kernel.org>; Wed,  5 Feb 2025 19:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738783059; cv=none; b=hlSz8FOlcWQ/TPiqgLcVFoJg65dYZ3A6UTqGC8D+f70XD6diZXV9yz5CYC4px1JnHuVQz/mFxFgfZC91U2IW3DN0bZFGPncIFFZH8H/f02oiAVeS+PwQlo6ctqePMpFICCSnX/seNFqUsvxybTKzafNsZ+WxMvudoZSKtUg0Bvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738783059; c=relaxed/simple;
	bh=XLYpLYH+lbFcCgkKm8AppmEwarNkV6tLVU4HUATQ84A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CHZSo8kTBqicJxbiHXilfleGCnbCVf8C9BHns2EZwNW43a1WI+q/IoepFX3ijkPD34d9HoiO3Gh/L2wE9eIKdIehMCsRuSuiUSlSj8HklZ3KLWH0t4JATq3HJpMZce4wSLkFX9EiEWpe5tcOZFkCzKHJNmgHG4aTccx6r6YC9Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=mkQp6EC+; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="mkQp6EC+"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7b7041273ddso5222985a.3
        for <linux-cxl@vger.kernel.org>; Wed, 05 Feb 2025 11:17:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1738783055; x=1739387855; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=q6hZ5i4uGM77E91i+vVgQnF7/jN3WqwvtuuTzpTp8gk=;
        b=mkQp6EC+MBn16sjKBaDVue3xzKtM8pdMcl8/1Xd9qR+R3+mmnWv2XQZbp2TpmUlQfk
         ioDo7kQm9eNMmDpDyF+jpVLb3jRgYxDgyJpvU1Y991nXQJCB163k+kb4VsFluMbAZsSI
         fAJICTk/eqd68lC82SxZmtVTr1Dbz6V8+iynjkQtHksgiIfwJW9shQieaMbjiqncBh7g
         Otpzfp4Z5QFKbehC7LHlmszvjXL1kKp2iW4VhArXQtKsH2bJ/WhMZR8KFekWxvyURT1/
         ebnckl8kXdwtwbwH1lxV/t1qMfqh2ibASD/dVD7fegROmpbOrt63lukP7jS5/oVbrpfz
         shmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738783055; x=1739387855;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q6hZ5i4uGM77E91i+vVgQnF7/jN3WqwvtuuTzpTp8gk=;
        b=g7yDGHQsnsp9bl3AbUKFez9Y9skzezRIAQMd1yJFKZhN5ka0nPb+Rn4UuhUU34Fa7N
         P2PwnDcklcrqZZ0b1pfegxWe+w/AE6A13WqMMSJtfSIUHGSRQpNm72y0a5PVv5pAs+KA
         eHRkc1/Ud8lySSbJ2/BfNX7M1cgH+TxQlV9mlyb4pqDNg5OX8H9aEF+QRbqcJvuac4tt
         7NQIHVxoa2ObJhpUFlddpnCxpnlNSY+BuhfpfGCN/c9JqW06xYnfO/yMoGGY5jI5vetP
         CLBPM3a0IUA4nKi8gxOxe+yv/BBfJu3/Sc5YhiyNkoce4ZQqapSeTKGwRTmf6Y3z9vTN
         QymQ==
X-Forwarded-Encrypted: i=1; AJvYcCXsx9hRwpNWJrbcafokOOi0OQoHHHMRp0YMMo9lRejnO+ulZTEn7bZy/Ibjn8+svCv9abEur1pRWtI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCskMqy4ttK2g4SAlqSIvhFpUcxh3LIxd/8n7/vH0B1kS3UGlx
	QKEQ3Uxc6kKHKRO6FC1tiTT5pysKcTlpFGi+j2k1PoiFIbO+DA2awPBfjfNCjNA=
X-Gm-Gg: ASbGncsT/xsG53PxkZcZ1jy2/ZxSTGTCkGnsFD78nN8SJJcrUdBZaK8UZIYP1nH1Rcj
	rUPMuAuRKY0N3FzlUlS6EtLwMJhYnTXnslusjtgeLVUUA+dLOocCKcgHHroolTlUBv/1Xc3aI21
	RYo5jJRI+TUuDgvdMk5SKAwC9NXm+9pa4qR3+03WRrE8EDxslNMTD/Tk6IeiFakBddVNaAD4dea
	82lz0l6urQRLeynDaLuywXeVXHup+y/vXg9D+WIoo4xcaZJwPckYxNLYGKcLU7EtegpU5VU/6SB
	oWFMuXnFelu4Nbw9WdYEr5YZMl0pHceEiNJl5/z6aTuIyMj+DR3BzDpqi4Y9SGOmRi1Dr9IJ6Q=
	=
X-Google-Smtp-Source: AGHT+IFZQarDTzB54Kw6beyPzV5fjHD8DeB0Ab1xvPcLzHDuFGzQUMrAaJDjENdFi/8n2EjfAvGJ5Q==
X-Received: by 2002:a05:620a:4089:b0:7b1:1180:a455 with SMTP id af79cd13be357-7c039f9974bmr572670685a.22.1738783055498;
        Wed, 05 Feb 2025 11:17:35 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c00a8d0573sm781697585a.37.2025.02.05.11.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 11:17:35 -0800 (PST)
Date: Wed, 5 Feb 2025 14:17:33 -0500
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
Subject: Re: [PATCH v6 1/6] efi/cper, cxl: Prefix protocol error struct and
 function names with cxl_
Message-ID: <Z6O5Tbf3l8A8_uEt@gourry-fedora-PF4VCD3F>
References: <20250123084421.127697-1-Smita.KoralahalliChannabasappa@amd.com>
 <20250123084421.127697-2-Smita.KoralahalliChannabasappa@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250123084421.127697-2-Smita.KoralahalliChannabasappa@amd.com>

On Thu, Jan 23, 2025 at 08:44:16AM +0000, Smita Koralahalli wrote:
> Rename the protocol error struct from struct cper_sec_prot_err to
> struct cxl_cper_sec_prot_err and cper_print_prot_err() to
> cxl_cper_print_prot_err() to maintain naming consistency. No
> functional changes.
> 
> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>

Reviewed-by: Gregory Price <gourry@gourry.net>
