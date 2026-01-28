Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545FE371042
	for <linux-cxl@vger.kernel.org>; Wed, 28 Jan 2026 18:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769624200; cv=none; b=XTAdq95keg3IJnClGikTe9425phemlLq6/CyZmVTJAFFselCxtjcQ76mdDCzt7HXtsHcYklLQUm80D28dvcA3idR75hNtZTKvlk3+r8TodSmqycVaNdoyPh13HmnImGt5V5sDhk+TYh34tOPPrCsZpaSmvU7q2qOMtSlXdbWZws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769624200; c=relaxed/simple;
	bh=SzaEkHJ6lO3mnr3Gz9LNzCtQBsN07qjBnbdebFuPu7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gpwKmVe5A0m6/T0dosnTLDyV/7EenpOhT8MoXzlFF0jl0GZRxWgpZLDJa4wFGrt/yHu5cSYls/3eFDy/mvKJ9GKH+gT435sxFcjB1h4jjNDbdChqx+Or/28X72Hj345ECQ8sVcJDrwbXRHrflyXbEiDzbuLPQ9yPBxtvKfsrw2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=T8CEPVFa; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="T8CEPVFa"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-5013d163e2fso1211761cf.0
        for <linux-cxl@vger.kernel.org>; Wed, 28 Jan 2026 10:16:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1769624198; x=1770228998; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MzpsQ+H0kvDykFhR/H3liY3VNrCQxpTibwv9sPj593I=;
        b=T8CEPVFa71H5zSmtYYf23scNNoF0JA0ra/Q5ElkBxRzGy+57lZm+f5PKcB1rTOZld8
         FHuIOdYQxSAmxloJ/P9k5V/xsrb02xexubMsYbgixajiMtd55+JnQzF2PrMwMhBrqEcI
         YVphgRsPSuzp/lDHUx+eG7wv8opx8lybngkF37Oy0t9Im5TM6Wjz6U4iv1QBPpXyurdZ
         4blKOTiagGlIRGAfMDqPC7irnoOBda2hN6tsmNsqfk8AWBeufYI4u6lJwrmDaVrIUzoE
         YknZMFWs5F0ioGNizyPnKVdF8OK5V0uYXRXXo9aMPy3XsKbqTr/gXrccnRLvXBxW4hTQ
         UmPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769624198; x=1770228998;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MzpsQ+H0kvDykFhR/H3liY3VNrCQxpTibwv9sPj593I=;
        b=vLKsw7+/AkIlKgREX6j3PoiuWcV+qwXnrUnOwKz0N8IFr/kyoVjQHUPNKRp01WTiJW
         C6s/3uI+4igpWTmxOXmpFtU4GpRqpyZCygQCr1rby1kc6dddeX2wuBBGXLXEJno0DfeF
         VnwrfHO1g4W6a1a4kU4p6lllClXB0q6yOy48hyx5OeqB2vvp/Vrft/PGvp03s8B7exG1
         qdcSOG7a68QpqB51tSom7OpWRco5LxRZkmghtaO2jRDyn3k2QruMKeINycVLh+jx/2W+
         84CkSS3h0WPWYr+2dX9EoSlyPvKLmge4oRW9kh9QcXbH4f/JOgRnqf+QQht2Ep4SvvD/
         +bLA==
X-Forwarded-Encrypted: i=1; AJvYcCU6CbNcgRVGNeCs7DOM5AEdg6C15tmUR88iOKXT62lnFBYB83EeS17C1IwxIHnCZxHxAbLgBae/ubg=@vger.kernel.org
X-Gm-Message-State: AOJu0YydNbkWKOJQSrYQrRo1dDaSXMAZ93+8n6N6piaZ8eWGQKrZliQ6
	YC350GCIV7j8lwmOR9uCvVVmOEqtMjszogF4HrKQ5Tig9yELF3gNjPwhT+82Ai4QKLo=
X-Gm-Gg: AZuq6aKA67vdMmO5F6PL6vON8VnbxoM4fWI7w2nx/6eJNei+POwICXJg7COaOe7WLz5
	HfJeGnmJfCkGq0qMUVDDxE+96S3Zj/itt57b1Xr2n88qByJLoHDWB7a0Lh+YMO6D9g0+JUv46P4
	IKPraubdB/hd3AounWF4n6Z9tM6hjApL39qnZK4Zai2kA1avEEt+ODdKwl+PLgw9GnKXd3IfEmX
	ej1SeVzXxFkApUTaU8pD2TERPKzCdQnW8cdgvHIuPDAAv+LsxNCtpksW2CbIk1K8Bp0cbd+rPbO
	tm6lN/Wef7HN6YIMDBFDZglTle35oyPdAA9Q8UveU/sFJSQBuQIa83oU0OgDHO61GdkdiqRzDUk
	VQwdwIvLvmsDMArpGSkJEEsZvNJ7JTkNG8ioxhzK9uiBcTrvoWd5MmTgxOReAi4uJOwEL0OAJYU
	ht+gZlWw0978ldmuI6oYz5rcq5ry9VqiBR7csUKRrraT2HzCxQJRFTLNx3xc3HmigHJ91/vw==
X-Received: by 2002:ac8:5f06:0:b0:502:f26f:1368 with SMTP id d75a77b69052e-5032fa0c361mr72456561cf.63.1769624196574;
        Wed, 28 Jan 2026 10:16:36 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-894d36a997esm22282296d6.3.2026.01.28.10.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 10:16:36 -0800 (PST)
Date: Wed, 28 Jan 2026 13:16:34 -0500
From: Gregory Price <gourry@gourry.net>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Learner cxl <learnercxl@gmail.com>, linux-cxl@vger.kernel.org
Subject: Re: ubuntu 24.04 not showing mem0 in "cxl list -M"
Message-ID: <aXpSgkmybmyuDPnK@gourry-fedora-PF4VCD3F>
References: <CAFNvhHedX__1LdABSRqLXf4rtUWdoK-difOcr7TCWrAfG9Ssgg@mail.gmail.com>
 <e338b34e-72f9-4523-972b-314acd4a5630@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e338b34e-72f9-4523-972b-314acd4a5630@intel.com>

On Wed, Jan 28, 2026 at 08:33:52AM -0700, Dave Jiang wrote:
> > 
> > If we do lspci | grep cxl ---  we can see the memory expander but
> >    there is no mem0 in /sys/bus/cxl/devices
> > 
> > root@amdgenoa1:/sys/bus/cxl/devices$ ls -l
> > total 0
> > lrwxrwxrwx 1 root root 0 Jan 28 06:31 root0 ->
> > ../../../devices/platform/ACPI0017:00/root0
> > root@amdgenoa1:/sys/bus/cxl/devices$
> 
> So you have an ACPI0017 device but no ACPI0016 (CXL host bridge) devices. Without those, the CXL devices cannot be enumerated. So maybe a BIOS issue?

consider dump acpi tables - see ACPI Debugging

https://docs.kernel.org/driver-api/cxl/platform/acpi.html

look at the CEDT contents and share if possible

~Gregory
