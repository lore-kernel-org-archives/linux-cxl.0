Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDBFB1F0991
	for <linux-cxl@vger.kernel.org>; Tue, 25 Nov 2025 21:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764104692; cv=none; b=mTXhaA83J4Y7job/jTfM+VsXFOPQ9oNOBXkTRq90PTIxf7B2Hl9J6tdTi0xuRJudzL9D38vnmclTQZ2JRHh56u7J7FfHsPMtdJEl3lKWmGWrYNvX/dS1hreW0cs59YjNjADI2mtTDkYzXhhOxfmDHA1DByC0Fy+TK3Tqthqq6ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764104692; c=relaxed/simple;
	bh=0qyloZq8qlNOzbSE2pgyQCppB48fkdKHAMugYCKWFuw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eLGimlh9A8BabJB5xaNCFUkU8an3q2x5DFyeanZVITPNm1YrDias0xlmw4I7SxPnqXTwQFfZ7EpzseOW3bXZCTgJCnNn1gd1e0Z9GMV5UPYJASRE4NZ7uYLXNy4wWreE+3WzlchD1nW6+AfwDkLmvPrlqco4uT/6hCk9FsMiCGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=ZTdMQhsr; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="ZTdMQhsr"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-88249766055so71382626d6.1
        for <linux-cxl@vger.kernel.org>; Tue, 25 Nov 2025 13:04:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1764104689; x=1764709489; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZzTW557EZUQWy5F7YY4el9Gdo69i0nw3CIVgsER2LHk=;
        b=ZTdMQhsrrzSOH3LcwlU30KzynfVkMzHj3Ifj9BS8oh8ZiYJvudG66fLQuB5JjhUY1h
         U3FN/0GVGepDxybuyxSdUQktU5JN1V2ydos2KNERCQDya11ELU+LKkuAfHLCHOLpaSdc
         QjSyFsi9/ws5YyvZnTmAN2a/B2ymRxExeKHPpW1WImNpENV3ofxEQ+w4+Fe0sU5+x9sF
         t2rsGauFrmKHB+DIFpMRVr+fp9VA9LHDPpNMm9ry1CspoHJlssFLbJ/bA6nogsO25fZL
         6HxqZz+gpTO+Yt5aPeBGuCEiFtMTQHPUFiaZ92BZLBSG4tGnXp08HOzkEzIXX/KtLCzQ
         WAIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764104689; x=1764709489;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZzTW557EZUQWy5F7YY4el9Gdo69i0nw3CIVgsER2LHk=;
        b=bcXiPqVOOaZJf7eV6miIQKGUo9GmzxwpS/RCVRz7NqkNSjU+4ZLl9hx+w5gzd4QzzB
         iFCmA6evpkD8bFOTK9keZvwiUMy0EhJpM95DPdpdYo7EyVE7tg750Ko5u2XaSQIk3pCB
         EeIznWK7lfMpnsinUdx7ByyJA7dNwlGBn45rjWc3KrdqFu9R9fEhFBwHFmSM3d1qbTBT
         cKapC94sR3nPVqJZawmx5YT3OF5xid+k7KLi9vKNoW3v9MXxRREic+ovaSOctkVPWU2H
         iZjYTgDfQao/aM2fr5D4d7A/Gpy2nE6BwFhPfCaJApRv1Bel+mMHRLkKlMP0685jh+RP
         7bGw==
X-Forwarded-Encrypted: i=1; AJvYcCUYMysTX3NEzCmpgrOs8X/ehgRTC0dvUpIcNxmdQtXDShH459c6B2G18S2GdNPim3M2vP/hbFMq2eY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqLQHgQaAq7ATouKny6aJ4+U4RKbu7ViBFiE26UpLh5AaL09Bm
	db8B6xQqkgs5s6TRxDu7gU/Qon3J5PlR2POvc/O4Ibs1Xz+yQJD2Fn3mnDJW378ZBfU=
X-Gm-Gg: ASbGncspBoxA9VZyh25gJ1PRzethnHmpvrIIzJJsQz7ye5QLdf41YguNlyPOYAClfjD
	uBRKREZjpRB5YtY5S5V7xKxRtKtHTXzRaNuvIeJW+w3m+8drc9yZNvIbg2gbe/I41G07hu2elVp
	cwxwHBpxRlpgKS2w+UtvC+WH0Xlsz0z4wBKuw5Kg2JzUXfWexa8rj8O26QWjBKrM5gXRMyHinCU
	2fvIYvfPp+JCkKYEED4reJX9GFXb+8vA7sisgtur+Nf0K7GYUhHgtmX3JOTwh8Cqosvn6JMA+Q8
	9HM5E9QWn4mlaiXq2q9vMCXEQWU8AEcgkHYbJ9w9MEPqFY6esofvpBZPCKyy48+/dU/cA2StSd0
	XMPqAcdrnfVFY41/ezhcOrLy/8m3BiEUyqS4mvZiIUSVc2QeOPMCInysrZAqpKsEXfXaf9TANbL
	TmhEuJP+txaE2dYkFDT0ZUHeuZZLL4+msXMq5ZTI87DYurooCLF7JKj+vyVXGZIRqfsuU30g==
X-Google-Smtp-Source: AGHT+IGfqBV0DyHb9MXT1llkdskdyRgDxfF/lb14XEQJ9fhORnG8Fi/7Z6MLn49UBtDOcWNU9WHn+A==
X-Received: by 2002:ad4:4eaa:0:b0:880:4695:466b with SMTP id 6a1803df08f44-8847c4d53camr276713726d6.30.1764104689305;
        Tue, 25 Nov 2025 13:04:49 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8846e599ac9sm131231076d6.49.2025.11.25.13.04.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 13:04:48 -0800 (PST)
Date: Tue, 25 Nov 2025 16:04:46 -0500
From: Gregory Price <gourry@gourry.net>
To: Alison Schofield <alison.schofield@intel.com>
Cc: Robert Richter <rrichter@amd.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>
Subject: Re: [PATCH v6 00/11] cxl: ACPI PRM Address Translation Support and
 AMD Zen5 enablement
Message-ID: <aSYZ7t9QrxiAsyL4@gourry-fedora-PF4VCD3F>
References: <20251114004021.1310661-1-rrichter@amd.com>
 <aReKmdOeHBBDWMuC@aschofie-mobl2.lan>
 <aRs4ILR8EEwnfOtQ@rric.localdomain>
 <aSOxXX7xX4jYqqvF@aschofie-mobl2.lan>
 <aSS7n40Hmiaf7ibc@gourry-fedora-PF4VCD3F>
 <aSUh-9fXFGsK_Z1_@aschofie-mobl2.lan>
 <aSW1MlUSs2jjdVjO@gourry-fedora-PF4VCD3F>
 <aSXbTe7lTbvzgwGe@aschofie-mobl2.lan>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aSXbTe7lTbvzgwGe@aschofie-mobl2.lan>

On Tue, Nov 25, 2025 at 08:37:33AM -0800, Alison Schofield wrote:
> On Tue, Nov 25, 2025 at 08:54:58AM -0500, Gregory Price wrote:
> 
> Could be your devices don't support inject or clear. At init time we set
> the bits inidicating what poison opcodes the device supports, see
> cxl_set_poison_cmd_enabled().
> 50d527f52cbf ("cxl/mem: Add debugfs attributes for poison inject and clear")
> 
> Devices may support list but not inject and clear. Look for this attribute:
> /sys/bus/cxl/devices/memX/trigger_poison_list. If that is present, then a
> quicker, maybe fruitful check, may be 'cxl list -M --media-errors'. If you're
> lucky ;) your devices come pre-loaded with poison. That cmd will emit the
> poisoned DPAs and if part of a region, the SPAs too. cxl-list is getting that
> all from the kernel trace log, so if you don't have 'cxl list', just trigger
> directly and examine the trace log.
> 

Unfortunately it appears my devices do not support any of this :[

[ /sys/kernel/debug/cxl]$ ls mem0/
dpamem

Is all I have

~Gregory
