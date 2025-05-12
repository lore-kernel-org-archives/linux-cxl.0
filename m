Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87EE8267F65
	for <linux-cxl@vger.kernel.org>; Mon, 12 May 2025 23:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747092169; cv=none; b=hmrzQqC8fDQzosVEInDPMI1DfFEwrzQn9HnmW8Vf4KlgAaI9ye84BNCQCqckJWGh5HIitgmtadmV76ZNwNk3hDCTL8JRpvuQXXKikmp3iAN73opvhczYbG3KQqjzgrqJ9MXIfEV3BN1sgjfUdoOkIkZCZay7BoCbK8zkJxsbxM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747092169; c=relaxed/simple;
	bh=8QV63ZeK82zaeUMGjGSCyyi7ZPB6N83H+neOuJEIHNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H1tBYAxix7fVnZg9UJjjBymBAulV2C1H7NWo8THpSRQ9uF916TARUCK2WvslvYmFJCMKjewi0xzUlXNUCuRJwA9p3QOcgDFdPl+0uoJKURWEvxz7pHFRntnhB6yjNsxSPa6cgKS9yeYLdMKDq+ZaYhzYunAqXqzScYGcSCjEe7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=e8x/qITM; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="e8x/qITM"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6f53d271b7cso44673066d6.2
        for <linux-cxl@vger.kernel.org>; Mon, 12 May 2025 16:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1747092165; x=1747696965; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5jkt0ZTtnxVT0Fjxc3OfhXNx+LgFr799Cqodw+ag0XE=;
        b=e8x/qITMzwPV1wzZMPV8Qmx9mUcwWFLDZ1hIkQ1dfCx+LHOkvxCdtNSCXG0yB9U2Tt
         4agILe4LTSI4jyH+k8GroLvtGh3hU7mkRyPsGih4aw8CfRSSpJKR+xIhASl0ybawnBA9
         EcNxdIQdrUK5ffQDm6kTHh/WeL7JUCN4AWtz8YsETW3vEt+LlSRl7JJr8rgtT8r1mpuS
         hY0ZSqZdvY2f/yWyUaCtLQlGoQ/kmAJMpuzIv1gWzwGVpqJN1Yjlgq5OMUYuzoe23KSz
         +cbv8XR/hUTuRGj6QwYS7kXZQ38n2/lqnTMBiPUT9exbHCMwXJRkYGtDnUofe95VydK+
         /nhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747092165; x=1747696965;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5jkt0ZTtnxVT0Fjxc3OfhXNx+LgFr799Cqodw+ag0XE=;
        b=KZs6h+ZgqnoPvISaHJV+cs6UysmZUYkKn4I3N4lgWfVPwu/5tny3BOgzJiFYW6yOU7
         T5P/wAbRjr99A4h3RMmx9hBSatD5v0zx72oPlmEufl+sJ4oMm1oynEvEWA5inLYQmjUu
         VKVInO4b4di8X5181gv4Ewe+5HgKd/4R6ky1Bvnjyu7wyK/gZ2AP1WD26ODx57mVfiaz
         kW2/7z3RlORPsEgl/Uo12NySy6tIqU/9TPt1CSXAJsABh9LWL/COYoiqHEcr+Fdw6Cuu
         sFBVY/uctQ62vQHyBWIY1GooW0KZQySj9nSfaNIHCxwoCEiXxqn7M0Mtq5NrQyKtHFTV
         pfDQ==
X-Gm-Message-State: AOJu0Yz47/3FGMVJP5pi0QelWKHBtVb9he3kORpVk/Xz0j1ab5U5Dkqv
	9Tzs0oxKLF2797T6CqqXxQVZy6arzRp2pGRUsOc6+OPTxQWpaj8pWgcw6BVlyjc=
X-Gm-Gg: ASbGnctZShCTvMR3XThKOZrreUo5TiP14NiW4wyY2qVEeyCnIbSdTvnokIliJ1bv7tf
	tlqjfp5XN/ldRIORyQ7kTKxXRsb1j/NeYpPJlobfuPVMDuTR0zN80pZjgVvZbe0W6sj2SoF/CqY
	EfvP3wpYWvrHMCT5fBIeeqlv3alet/8Swo5C6sd1PTKltEC8UoZGcju7YzfX/lma+h+W6BhOGlx
	xyR3q5NyymsAhn1zEgjfJ00FgWEQ/tgdDXx26q9eWkrRM2xlIpFpYNk8bpwQhBQ8MNZZJgjLnyB
	vgTa4pwF5zz+8Ud8fe5HGGqMpk6L7toLz60c7pa13l1Go/eGbiBvFHXL1E8/50hKpPM+2Dl2xl4
	o0//4/XditresK+Rn0Kn7hoiBvu9Bu2M=
X-Google-Smtp-Source: AGHT+IEpJbFQRhO+lDwtLTNlPn4mXIlKeDMD51VI/PuTcgz1q8t124IwQ59ij5lyVuEVA/gq3wvZ8g==
X-Received: by 2002:a05:6214:2405:b0:6f4:c824:9d4a with SMTP id 6a1803df08f44-6f6e47c339cmr228299066d6.13.1747092165369;
        Mon, 12 May 2025 16:22:45 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-42.washdc.ftas.verizon.net. [96.255.20.42])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f6e3a52490sm58716856d6.96.2025.05.12.16.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 16:22:44 -0700 (PDT)
Date: Mon, 12 May 2025 19:22:43 -0400
From: Gregory Price <gourry@gourry.net>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	dave@stgolabs.net, jonathan.cameron@huawei.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, dan.j.williams@intel.com, corbet@lwn.net
Subject: Re: [PATCH v3 03/17] cxl: docs/devices - add cxl device and protocol
 reference
Message-ID: <aCKCw7wvvfiad0Q2@gourry-fedora-PF4VCD3F>
References: <20250512162134.3596150-1-gourry@gourry.net>
 <20250512162134.3596150-4-gourry@gourry.net>
 <e5211a03-617b-43f8-8ba4-b75557e283da@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5211a03-617b-43f8-8ba4-b75557e283da@intel.com>

On Mon, May 12, 2025 at 04:08:24PM -0700, Dave Jiang wrote:
> > +As of v6.14, Linux does not provide a formalized interface to manage DCD
> > +devices, however there is active work on LKML targeting future release.
> 
> I wonder instead of referring to a kernel version, maybe refer to the CXL maturity map on support status.
> 
> DJ
> 

This is a good idea for cxl-specific stuff.  There was another patch or
two with working like this.  Might be worth collecting these all and
just updating the wording in a follow up patch.

~Gregory
