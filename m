Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671A01D45E8
	for <linux-cxl@vger.kernel.org>; Thu,  5 Mar 2026 00:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772670583; cv=none; b=k/n3CeBWtSazwy31xV/ZIDL2rwQHarGmOc7xYPFX9Zq5pRSDZ54E50niGK+Uf+nn20Sk2naKtW1Vxuo+tS8jDPY6vqE1hmlE3dfg4cXBsDB1plhCFnCJj3/RkgfLVrM93WEKZJnG3bpjiciWiD3mFqA0MZYU6Fo0fgQsCJaPC+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772670583; c=relaxed/simple;
	bh=BIPtPP38tnypiwd1WskyXbCRSqYTysccN8S8I0LJE4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u/+36LKXUCFvJBUAEB9X1zGq6lLRcxGtUK3Itz83Kjo/8Ne7fRdKIfRNh6KiEPZH28ZYYpYRkCokBvpHUSvhl9fh3UBA0m8pzU2s4TSDTArR9IAPsX/NnGwZ0bBjV+V4JPzlYroPM7I5cbi2vIjyYMonWQcv9XRbKkoE9R9zNNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=GbcjlVO4; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="GbcjlVO4"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8cb4136d865so982572185a.1
        for <linux-cxl@vger.kernel.org>; Wed, 04 Mar 2026 16:29:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1772670581; x=1773275381; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fnNZ8h0uyYV+1nNOGA71Wg9+gmZY5aGpsyFvnFBw2lU=;
        b=GbcjlVO4UajXN3osuSQSGcu08EIYUybVhUD9uOUGrqlF6gFv/tQTeR323IoVmRjVFk
         rGwQzT/P2fXJqOZir7vXMFa+jmy5XdlccS4VZqgcRTQApOZOdWr2I5gY0HFk2InxsaWH
         rvtUfpWRZUnNXqNwbZbCSou3YZP8Eb6ajayJeOcIo56LcfiyYQi8QQQYX6ILLQ1M8w2E
         QEEjKsu4799RNLzOuUiuGH9y3S3UdElK5gO3JUHm1UsS2qHQec8eFC4x9Mct3eXwdDvo
         mZAWreWjvbCiGYAzJmfL0C4QTmVmVSRGTXkH1cCxyHNROFD5g6d6NehjR7Twct9f19I6
         40og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772670581; x=1773275381;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fnNZ8h0uyYV+1nNOGA71Wg9+gmZY5aGpsyFvnFBw2lU=;
        b=aRmOY4DbnXPkr4Scdeaf6fviApu5dAkbty/9BaLz8szCcxH34UVS9aG1LtG+jccgZz
         8ROHoIODtwdsI3/WzYWJmVlGm8fMxfoKzzOSd9kld74SKShzTHIIY6c2qmM/zwpLJE8F
         eELWHJTfkt0H7dWS836SHVR0KsKyVzInNcoR6CrM3wm6W9cP517fqKQRPsDTNVZeuXZh
         MCioiv7xRnhTD5DkX0dOyb1e5iEdIErINfcBH1Ga5r9oLNzJZH3nRsIzOFXMb+wZMEDC
         DabxtS1BFC35i9QEy3mf7BSqA/WZHK1qObSblB8CqPv7SAWt4RK/cX9K+rc4FFa4j+HP
         WLvg==
X-Forwarded-Encrypted: i=1; AJvYcCWED7eWbdieGhrVOfWGS+vp0QDpA0tw4h88eiob1pTL6Jba/R+NOJ1Tht8hWABzmoxyTnA0Kfhvigk=@vger.kernel.org
X-Gm-Message-State: AOJu0YweR2a005ktxCgrg0Ig79wJCiui+uXEGUxBv/V6Ic9Vu7xo3F7S
	fA0E3thef12jYJz+wcl9nor7iEjk4lghs1RTet2rPMbQ2a3PadoFh7FacEvLaKwE9D0=
X-Gm-Gg: ATEYQzz4A1O2tkcz8qWJgPWXf/CJYoUpiurXp1JuDbrUS7no3P8YSW7pIctL/LmpO9v
	9nvzQB6xrlkVgKF1x44x0Jw5ogEur45m5Z70uu22sIFbg6DoEHPy+zrkaTpUNXn+RMh/rh4qYDU
	e91+PRuMmnYFS0SKgT97PEDfeVlYVq7BZcZ2RKNCSfTJi6RcRU1GUQrGmCh0QOvv9pEZC3fsqBM
	H6O6h2jIYwkQTpsg7QDkmaFsyC3lBx/fCdOZFKChm9Dp3BduJCy2d4kT3V9Ai1ho0CZ6M0ze+GO
	Dbc0iXwVriC4nPerwZkNX4PGERAXCkUfym7EBcatlq7G6c3/GGgEXasUCQe7mhca67fwu5hH18F
	NI2UP4S+eJy/56LB9Qs+m9DsaEm+1aOIIZbLZ+86wXnmEQAd7uFpvOwWNzf3dNwzoasDzODZizl
	k3T6i7XvK2puMPChZuaHySeO3j0xVbDyWWPHDdWNE8n+1DmlowjYqG52NtehFDcz6tCjFhhJm3N
	T380F/Z1Q==
X-Received: by 2002:a05:620a:450f:b0:8cb:3bca:bb46 with SMTP id af79cd13be357-8cd5afa3a2cmr517112485a.64.1772670581306;
        Wed, 04 Mar 2026 16:29:41 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cbbf746fc5sm1736858385a.51.2026.03.04.16.29.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 16:29:40 -0800 (PST)
Date: Wed, 4 Mar 2026 19:29:38 -0500
From: Gregory Price <gourry@gourry.net>
To: "Huang, Kai" <kai.huang@intel.com>
Cc: "Schofield, Alison" <alison.schofield@intel.com>,
	"nunodasneves@linux.microsoft.com" <nunodasneves@linux.microsoft.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"rafael@kernel.org" <rafael@kernel.org>,
	"thorsten.blum@linux.dev" <thorsten.blum@linux.dev>,
	"wangyuquan1236@phytium.com.cn" <wangyuquan1236@phytium.com.cn>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Williams, Dan J" <dan.j.williams@intel.com>,
	"lenb@kernel.org" <lenb@kernel.org>,
	"xueshuai@linux.alibaba.com" <xueshuai@linux.alibaba.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH] ACPI: NUMA: Only parse CFMWS at boot when CXL_ACPI is on
Message-ID: <aajOckpcmQwYydVQ@gourry-fedora-PF4VCD3F>
References: <20260304213342.5776-1-kai.huang@intel.com>
 <aaizNh-0LEvRQMCy@gourry-fedora-PF4VCD3F>
 <aai-K2tEdIp5B4XP@aschofie-mobl2.lan>
 <aajGuOC-G_dFYpwa@gourry-fedora-PF4VCD3F>
 <4809035f61dcd6ace773532efe46b0f1928be313.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4809035f61dcd6ace773532efe46b0f1928be313.camel@intel.com>

On Thu, Mar 05, 2026 at 12:14:52AM +0000, Huang, Kai wrote:
> On Wed, 2026-03-04 at 18:56 -0500, Gregory Price wrote:
> > 
> > This basically says if specifically CXL_ACPI is built out, the NUMA
> > structure is forever lost - even though it's accurately described by
> > BIOS.  
> > 
> 
> The normal NUMA info described in SRAT is still there.  It only avoids
> detecting CFMWS, which doesn't provide any NUMA info actually -- that's why
> kernel assigns a 'faked' NUMA node for each of them.
> 
> So we are not losing anything AFAICT.

Well, I'm mostly confused why there are CEDT entries for hardware that
presumably isn't even there - unless this platform is reserving space
for future hotplug.  Just want to make sure we're not adjusting for
strange firmware behavior.

The only platform we've seen this behavior on previously was QEMU, but
that was because it never emitted SRAT, so i was wondering if there's
odd firmware behavior going on (emitting CEDTs when it shouldn't) before
we jump to dropping nodes that would have otherwise have been present
on existing systems who might have compiled CXL_ACPI out.

You are taking something away by nature of compiling something out by
default that was previously not compiled out by default.

~Gregory
