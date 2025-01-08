Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1311D1FF1C6
	for <linux-cxl@vger.kernel.org>; Wed,  8 Jan 2025 15:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736351348; cv=none; b=jS8Dmi2QPveHqcFwNiMfriaI1wXNm4MxSUW3CpjTWfWT/DthbTU+Ul5+Wh4OgFmfQGNWkSnG2eJqlrvkWywITp22OSfORh5DF7JwnWBbUuB5TE0uHhhHSSc7ZwYUWPRQnBH4u1JQT0XyQyIEOoc7W3YhSXM4MyhBIERiYuIoMBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736351348; c=relaxed/simple;
	bh=sSN9SsnKUvhFGRU7W7zxKA1llCrUP281HeNA3cTvtB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y50hF5eVj1mgahikZog75mWouB/eTRV6mgmWcRLWJ6WfBh+1OzNoeuYD2kAPTURuYGUYM8GDRaaaev4UZfjTH85Ch1bkOgtvrH7mIw25Qm2d2rbvmsnEsC2hcZaqathAInSUtpyrbcbfrAY0dXyavb9lHgTt1JJvmiwUpUi7Bjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=ErrXIV6R; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="ErrXIV6R"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7b8618be68bso1279904085a.3
        for <linux-cxl@vger.kernel.org>; Wed, 08 Jan 2025 07:49:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1736351346; x=1736956146; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7Bl9NAgWdHPyMnimBgt9SxNHGqBRfOL35wQpFjiOOKs=;
        b=ErrXIV6R/sbM/zOERPIZoIV1M2zNEI2EATw5d4GuD28AHfwPSXQK2+jzx/fIsY+gvd
         9lTdNaHE/ycXvYAZJ0l49qNwlG80vpIC+iFoknZ1J3p7Nhdi2PHKXMkqagK+I8oPjTxB
         ZsCfncy39NyBbvTHTDTb3af2RkgDPpmueOYuIBLjska7YN8lz4cin2vQVVHTpI7/Z5Oz
         81KeJsKG4KvPQGxypiTZOU1xCbqxafrM1t3Jr0TmmgAzluTQryeZlH0aj90ediHNk4Ez
         Xb/xcuRhkebIydNSRzrgtb7h0hWN2pJLESvMKVv5e0LxNSzJ0XSZ9iMUyONu17rc460Y
         wqVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736351346; x=1736956146;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Bl9NAgWdHPyMnimBgt9SxNHGqBRfOL35wQpFjiOOKs=;
        b=pAVfzMtc5dNP2myZaAYgjwoiO4E75ireg8ae/1AIWfTbdd0nI7A1yZFJmzn4cISTQV
         OuM6fQys/l+hj7knSoXFVu/jxgcf5GhjCeFTTykn9oM9v9vu2RGVU5JpPE/UGXVSqA4L
         7nMgcdCOYqqwO1+AtsCRc0tTcWATbFOdGB6CLIFDaWvOPSUUKxrkTusAtE3fYKle6WOJ
         HrMyxOGOd/Z24M6z5PLrMwB4xmhsIZkx3SDbGKfTpFETMvWB2e1bc2poYGU9nODdPxlT
         CJBlKmn0DfX4Gy6+0fjrDRm/FFQtBA7MLoqsEAJ6+G9XsyK901KYKwC0EyZd6B+Wu2QA
         5HbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSwh1HrbpxXZ/PdCgWb7ooHcB4pUQ6t6dhlZWfSSZNGikCJmCGayBh1QEHG3blbuZoX8H/Q4GLwUo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVmkenk+/MYo+seg88YPbg34NfNFXvwN/xs9mEJOVroCkSzIze
	H5TVal3299Npi15VbrBtsv24avKxW1Lsb0k55LpW4yHF+CUihc5PK5C2C6YKUf8=
X-Gm-Gg: ASbGnctatRKRjp4vS3INiegA+P6JWSCtNhnDrcoEI34tsIa0gDbLdOheWgM4VGdxIcg
	VupVZMSLr3fwuS8IOV4RGE5txCni6lp36quH8go/WcZMSFyu8fBxCfQg42o6SQiTfX+7GGjeTUM
	/PCsGC/jSo/NVg0Rbg5Ex0W2mfghMTJ7O/YN/v7tuGu2AxMib9rG78b8tr9c1pItyiL0O4eHXIS
	WqHzdLWLBB8GBfJa/xgvuWkyj8O3l/VMZDD2XYX8H5eTv2L/+0bUu2/l+ZqPt9FaBAcYlFfVht4
	kTKXXY/vRh3atQf/vxosZK84DrvZVnm670Zs/kM=
X-Google-Smtp-Source: AGHT+IEYLiVsJfufHVMLMQPh+XJKnZPJL0IfuMAUQ5CxOx+0YXj+k1LaimRPU/dsQWrxcqrDfsvS3w==
X-Received: by 2002:a05:620a:4551:b0:7b6:7257:1359 with SMTP id af79cd13be357-7bcd972f20cmr513055585a.13.1736351345978;
        Wed, 08 Jan 2025 07:49:05 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b9ac478d35sm1682775485a.90.2025.01.08.07.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 07:49:05 -0800 (PST)
Date: Wed, 8 Jan 2025 10:49:03 -0500
From: Gregory Price <gourry@gourry.net>
To: Robert Richter <rrichter@amd.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Terry Bowman <terry.bowman@amd.com>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
Subject: Re: [PATCH v1 25/29] cxl/amd: Enable Zen5 address translation using
 ACPI PRMT
Message-ID: <Z36eb0ZFFK46bYOQ@gourry-fedora-PF4VCD3F>
References: <20250107141015.3367194-1-rrichter@amd.com>
 <20250107141015.3367194-26-rrichter@amd.com>
 <Z324ueZ0Rxj4Sq6t@gourry-fedora-PF4VCD3F>
 <Z36RMyf21c3l2ilW@rric.localdomain>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z36RMyf21c3l2ilW@rric.localdomain>

On Wed, Jan 08, 2025 at 03:52:35PM +0100, Robert Richter wrote:
> On 07.01.25 18:28:57, Gregory Price wrote:
> > On Tue, Jan 07, 2025 at 03:10:11PM +0100, Robert Richter wrote:
> > > 
> > > Add a function cxl_port_setup_amd() to implement AMD platform specific
> > > code. Use Kbuild and Kconfig options respectivly to enable the code
> > > depending on architecture and platform options. Create a new file
> > > core/amd.c for this.
> > > 
> > 
> > A build option here specific to AMD doesn't seem the best. At Meta,
> > we try to maintain a platform agnostic kernel for our fleet (at least
> > for build options), and this would necessitate us maintaining separate
> > builds for AMD systems vs other vendors.
> > 
> > Is there a reason to simply not include it by default and just report
> > whether translation is required or not? (i.e. no build option)
> 
> There is no (menu) option for CXL_AMD, it is just checking the
> dependencies to AMD_NB (and indirectly arch, platform and vendor). In
> that case it is always enabled.
> 

Ah! I completely misunderstood the build option, my bad.  This makes
sense, sorry about that

~Gregory
