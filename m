Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888C5335BDB
	for <linux-cxl@vger.kernel.org>; Thu,  6 Nov 2025 17:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762449110; cv=none; b=mjyvqIBIQJjdfYknwDEECr0GMxZRAgVRnyTUAH9D0ltcC+2ms8uIjOU5j2EfTc0M5nHSZkNCHp9/MDkeNBBiwwhFOpGMODpy6KQnQPrqeS5nWdIs+xfYzcekRx8ZHch3e+qEZxIuBr7JQLmYIQFjmdIXc/rCuzwFAD+n6zkG28E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762449110; c=relaxed/simple;
	bh=pBncupXbWkCVN1fOd+MWv1n3EGow7Y78ZsUbGG2oPVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CMkbaklaMByiUxkiiUpEu2+jv1mXQwL7svPmgHoNchngy1CpLgozTNZrtcgvz630Rc5l5FP3qC5TqLH72n9WDf+RTZjBWyRt8gBVqtU16N8MlYrLiwYJJ/jT9m5PN5AYBZ2R5IcJZFm8hDOGvErvpNU6bQD0qcooqeSeJf4RDz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=n3jgQyNj; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="n3jgQyNj"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-87a092251eeso28611916d6.0
        for <linux-cxl@vger.kernel.org>; Thu, 06 Nov 2025 09:11:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1762449106; x=1763053906; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aKXFhe1XgNsEqIm7n3PyjdJL5U3TbOb6yB6jqMWUHW0=;
        b=n3jgQyNjKBrhEYmKfs/HF2geSjgYhKEq/bvuMz+VOrujjHOqwIquqimWN0g+HE9GkX
         g7dmaS/0I1VcZDwOhuzZ0E3s5jszR4aejv/zhci+5kjtZtUSDfgGLxTqvNV9wNtwkgJg
         6c9UswPNUOIZVbs3MFqSmpIuVfRf/GqLVnhfCIi8kEDITV4xJUZU/Gk8hyDWxDBQeb1Q
         TF3fuiUrV247AzlODSNdJnDB6KUl7bt75G73tPjEtWNk1CY+o+PSVjVPKoBBsusmYdKo
         5TsdrLz12KzkYH0lCQyZROfKzU44EOxioSd/znx5IlpYFdiuUNkIFgBdp0QuPvzYk12P
         omgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762449106; x=1763053906;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aKXFhe1XgNsEqIm7n3PyjdJL5U3TbOb6yB6jqMWUHW0=;
        b=EHdqLoMhTMfdmOVE2w9P9JlvvOkKCZVJsXcDl7kCgrJvHis/S/ApDF78nOiqlHzXGq
         fjW6ZKe6uy3LtfyFvbE03pRxF4j30qDYlsC5gfvRdXGCJJQFbCf6EM+Lwzirq0OAi+Fo
         XUCFT/t4MJIbPupiNTpNJ3G6W2Yn4ks4HOT0w+kIhhj84bNOEbMGVRJVxbnDDyiUl/V6
         CXg+HXSmVpY+WcXpb40rQk4Igd1ACzaWRL23UQkhbueE1pzuqnCQvxZ3gaAbf4hBKI2T
         y4zZMxZSvRYNrLkKEo4UuvapE42B6op1Mk70iQXhcE4WWAh6OB4gb/F4CMxahrFqJH+G
         47Eg==
X-Forwarded-Encrypted: i=1; AJvYcCXl2e3MI5ckJ7GYVv4ruo5Gn+NLzcosbE6COGYVymPtfiZk9KaWCT6OgjbBU2+RAeUEEkVcDtYIBRk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyS/SGljy/we6ptkMzFbyfiKcMXn1d1nyuz+l6gd+ipDVIlSuCA
	GU05XuFg8XMLPJn227Lu8JcDb07qW2t/c+cV4/aQjG5i+JE931BQ7G/FXkALD54DeTg=
X-Gm-Gg: ASbGncsMEd1rojxLztAW7kvHMvt00BSDDTJtJyynXu/gz4ciKbx5HdiUquKgYnx7kMW
	fXK9YAlhYtv4IjFg5SdDfeIeunYk6LjOxSg49MGt3SJdj66PTmTNE/Ec6Sr2nPWeTUPHuQGXO2G
	aayCX5+tV+1YZMNX1PwTGTC4Zif75nVHb7wQJt8lXfFrDA36JnUMEIrr+zinAc6x0cbLkMRomPc
	FVxKz3hLXypVzPdDoS05B6MiCBLFzay2ZYJ+1+aFEB2QypMlBg/CCypwOOlTHWZFm4lQ9DW9B86
	a8kHnBPBxxaScv26Tu+ugWZfIUfa6pHDW3LQIc6wbhvJIHerFm8ZzS0dv3dlNOWho6OLS3VC61/
	jup1jUjkSfQ8lN9oamNnKG8X3Lt9GjfNA+Z+IR1KtaZiczjt/7LQUkeuaWoePXw06u/OwgASCid
	KBBY01Wq5OcCfk7s59/tWEWnf+Q3tl2SuXpA1k4ldjlgpla42G3ydpqMaqOqs=
X-Google-Smtp-Source: AGHT+IGtpHAhkhHyR6o5AHtiwz5cY+ehhjfBP8n5EpJqyPwP3g9GbLdMDu/RgBohpPPk3DUjCzmC2Q==
X-Received: by 2002:a05:6214:62e:b0:880:53a8:404d with SMTP id 6a1803df08f44-88082834ec4mr51601596d6.3.1762449106390;
        Thu, 06 Nov 2025 09:11:46 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-880829ca35csm22268686d6.35.2025.11.06.09.11.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 09:11:45 -0800 (PST)
Date: Thu, 6 Nov 2025 12:11:42 -0500
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
Subject: Re: [RESEND v13 17/25] cxl: Introduce cxl_pci_drv_bound() to check
 for bound driver
Message-ID: <aQzWzp4DdSqTj9Hc@gourry-fedora-PF4VCD3F>
References: <20251104170305.4163840-1-terry.bowman@amd.com>
 <20251104170305.4163840-18-terry.bowman@amd.com>
 <aQuOiK8S31w44pYR@gourry-fedora-PF4VCD3F>
 <aQufg2Nfq8YqkwHl@gourry-fedora-PF4VCD3F>
 <aQvO-eBboCOhRDOO@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQvO-eBboCOhRDOO@gourry-fedora-PF4VCD3F>

On Wed, Nov 05, 2025 at 05:26:01PM -0500, Gregory Price wrote:
> On Wed, Nov 05, 2025 at 02:03:31PM -0500, Gregory Price wrote:
> > On Wed, Nov 05, 2025 at 12:51:04PM -0500, Gregory Price wrote:
> > > 
> > > [    2.697094] cxl_core 0000:0d:00.0: BAR 0 [mem 0xfe800000-0xfe80ffff 64bit]: not claimed; can't enable device
> > > [    2.697098] cxl_core 0000:0d:00.0: probe with driver cxl_core failed with error -22
> > > 
> > > Probe order issue when CXL drivers are built-in maybe?
> > > 
> > 
> 
> moving it back but leaving the function seemed to work for me, i don't
> know what the implication of this is though (i.e. it's unclear to me
> why you moved it from point a to point b in the first place).
> 
> (only tested this on QEMU)

also tested on Zen5 systems and others.  Seems stable to me.

~Gregory
