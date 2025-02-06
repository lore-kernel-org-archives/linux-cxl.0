Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D161EDA2E
	for <linux-cxl@vger.kernel.org>; Thu,  6 Feb 2025 17:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738861292; cv=none; b=twPsddCPAuUN0ak3QoZV2jQBwNOZXEGz06wIc6F/12AAdWmuF70gHMJj70G5XvmmTHDiRfgy1IoOjIjOBuJeMyvs5Ij++uqCXx9bqkWNXI0IrEdSsDALFfRUsLh4KgTGHi4Jp19KCtC/E7oxiUZ0lm8Aqrm8ik8zUeJSgPvgXoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738861292; c=relaxed/simple;
	bh=mUQxeAoVhGLDKfZCjmQ+zwGLwy+EoSUmrYxPfxXIL6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uh6abiHygKwPLKjyTOC69HGFfZhPLHurSYao5EKE1xi0A3ICx3wUHKw2axPfCzlIzUKTT+eGWqhUlsmnLF9v/ff0woOV+61yZTPFb3LmrmnZaJFMU+lP4tG6SSrnZKWe6/jK3yC9ptPRTx0vJ8br54YKG6HWc5KDqOGmiu6crig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=NkIXopTr; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="NkIXopTr"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7be8f28172dso55362085a.3
        for <linux-cxl@vger.kernel.org>; Thu, 06 Feb 2025 09:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1738861289; x=1739466089; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OgBoTjTd0P6BFI3Nbzw9+84X02WOLlHkP1rNoeDXlds=;
        b=NkIXopTrIiKEVYjUtldwS67oh1iABkZl5vv5sXrd8hUM80sF+WxAd+LcL45rhx1b9T
         B+fTolK+Ilaq2g7yt587b9WNhMKblPdZOXH2GXkoIZFB6wBMLtSv9YsCoW7LW5pqS+Lt
         m9FIyulpjayclUUPAyJeq9PeWVFqkkxoqH+m+RivG+rYO4MtG7EGjXHg3QIjTCmPg8+2
         WZP581FWEMqClswqJxoZ3H5QNLW6nSq24j3CmgSYrNmRJC6Sv9gjqP/dkHO5olHKAFeL
         Q/R2yCkhvDjlaHar8mgiLchHp5xRCBoMxL5YlxOP4elQ2kBuOXXome7cK6gL/gNbaz+O
         RGBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738861289; x=1739466089;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OgBoTjTd0P6BFI3Nbzw9+84X02WOLlHkP1rNoeDXlds=;
        b=kM1wNItHmYiEGmK2Wqjrjj7XoIzjrNetN5zopB5ow4l0ZiWflrxlnyciYVFX24xYn8
         zSL9oL8uESibeXuoFLQg1yP+SCw8TohL9cvLzWp1/1KufNeRKI4dUjSHbT+VGlmDo145
         dvQMjIbDUdxjFEmbpOijAshn9lp2jaJ7YEhOIkKInoLPebw5aBgwyNdat76P+KTYNXeC
         81Y6HZtpr9zKeJjVeuuCaAcwy2jedRPHG/0FCWd3KnyBzlN+TxhQXT+VL1rZsUnxh1zr
         fnf39ceLz+bOHT3xIEaHvxMxt/UHBsIHb/l28iFjIOYUz9ofIwCxaH0kZvveynm3gj/I
         ydzw==
X-Gm-Message-State: AOJu0YySEkt3d4z6jmvA94pwMWox4ETHMHqzeC+zqRhTGF+4aK3jTN85
	5LqhpqVVM4gafvm+gTw1+PuLmBgCNKSE1SwCevDDYmLNIMfPs5jNMPHjR2iBL+M=
X-Gm-Gg: ASbGncsYXFGNrDCovNIKtBkO0SQS5s8q2srqRI6N1YQWOkqM7sPH/GACsHTvE5w3SSd
	+WHPWakvJCq3FIA2FYBidlNpkQXZzF7gPSJ5lut0WvSfdM03vVfCTKqugixaOJOvya1p7+Ketvi
	RohpD0+8Y518jGCy/ZEuIwqoR2BU6wLq3J7DLZbsOy7o0WQsODwNITluspUyaP/RO/H9cV1SdwZ
	lCx2KYgEFFdCASbQxa/kDJoPxSyWp+2GW+nfSD+KgfOz67fvjpVftFr39UkCEfpRefQGTCPU0+C
	QLWaoKKJm9yD6Lz+aik8XgliFXRYmiaqdgIufmm1KLAxZxiDeMrsOjx506Yv8g8TSIK7I978pg=
	=
X-Google-Smtp-Source: AGHT+IEz2w/jzoGAbYYUG4jWVTjuyIsaInPSObipS3QKdXNC4LTgYymhViMzJNqRP4gdORV7RtRXSg==
X-Received: by 2002:a05:620a:2602:b0:7b6:d1f6:3df with SMTP id af79cd13be357-7c039fcf500mr1192368485a.21.1738861289178;
        Thu, 06 Feb 2025 09:01:29 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c041e9f4desm79480285a.81.2025.02.06.09.01.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 09:01:28 -0800 (PST)
Date: Thu, 6 Feb 2025 12:01:26 -0500
From: Gregory Price <gourry@gourry.net>
To: Terry Bowman <terry.bowman@amd.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, nifan.cxl@gmail.com, dave@stgolabs.net,
	jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	dan.j.williams@intel.com, bhelgaas@google.com, mahesh@linux.ibm.com,
	ira.weiny@intel.com, oohall@gmail.com, Benjamin.Cheatham@amd.com,
	rrichter@amd.com, nathan.fontenot@amd.com,
	Smita.KoralahalliChannabasappa@amd.com, lukas@wunner.de,
	ming.li@zohomail.com, PradeepVineshReddy.Kodamati@amd.com,
	alucerop@amd.com
Subject: Re: [PATCH v5 01/16] PCI/AER: Introduce 'struct cxl_err_handlers'
 and add to 'struct pci_driver'
Message-ID: <Z6Tq5mWoxiD3LyQ3@gourry-fedora-PF4VCD3F>
References: <20250107143852.3692571-1-terry.bowman@amd.com>
 <20250107143852.3692571-2-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250107143852.3692571-2-terry.bowman@amd.com>

On Tue, Jan 07, 2025 at 08:38:37AM -0600, Terry Bowman wrote:
> CXL.io provides protocol error handling on top of PCIe Protocol Error
> handling. But, CXL.io and PCIe have different handling requirements
> for uncorrectable errors (UCE).
> 
> The PCIe AER service driver may attempt recovering PCIe devices with
> UCE while recovery is not used for CXL.io. Recovery is not used in the
> CXL.io case because of potential corruption on what can be system memory.
> 
> Create pci_driver::cxl_err_handlers structure similar to
> pci_driver::error_handler. Create handlers for correctable and
> uncorrectable CXL.io error handling.
> 
> The CXL error handlers will be used in future patches adding CXL PCIe
> Port Protocol Error handling.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Fan Ni <fan.ni@samsung.com>

Reviewed-by: Gregory Price <gourry@gourry.net>
