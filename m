Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A861E4685
	for <linux-cxl@vger.kernel.org>; Tue,  1 Apr 2025 05:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743485188; cv=none; b=XO85IOE0SubIGro3z+CGuIB9iM9SWU+6aOjRE+VuJF+v1OoD2XvVX77giwPKEKZnHG0vcqE8/SwZHDxU7cjWFDR2N6ebX/lhdhk6HCFTdtbv0NvrwgTetp9ZSDWDGZjwqU5yMnzH/rE4sZ28t7QcSuQlqzvHLrxZ9fS/oFc6Tfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743485188; c=relaxed/simple;
	bh=v1zl01o+pg0nV6AdRbp0f/EWVnmh/e0rB3H0HnZ24sM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MXiYgKitYI4eBaq2k1yzx0RYYHSRFyTmyXEduKxtUSOFLhxbKPkBdoS01OXu2C2XRSJgOptaLdw5AvylvPjLkipbWwtfQCZ7BwegZUVOSyj0rxfSSIQIRCKFm/zPha6pWdst1qxEuo6LUyHbgkENpP3U84Hf5QKfFmS3mOv3tEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=lgKC+G1z; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="lgKC+G1z"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6ecf0e07954so68969986d6.1
        for <linux-cxl@vger.kernel.org>; Mon, 31 Mar 2025 22:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1743485185; x=1744089985; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=d+Mgpj4yrfHwR2sSJO4BhWOtOStGYWK2zknVZa5Zibs=;
        b=lgKC+G1znttIDfISuXaUZN7NeNQKF1LfP1so73vkXQmyULnjamhE4+4iTJLzQn+poK
         7K4UPO7UYbCDa/a9N5RcPelDnsZ3bZQC7tAlYev+z0H1EU3q4n2IHdddkNLnli9pnGbE
         j/Z+X96BQf88me4tIcHnVud+swe/tyHhBtlYS67Z+927Bychb7CytJ69D6w8OX/xoHp7
         QpbU6TOtf5Lbuy8WZtaSdMLJZP/8+4a2gq1a5JOLb29/TT7v86CWo63aV5vUrK/tkfSM
         jHu3N1ee9ZzH8s710WL3IjaG86ZE+2P7oiX+cGu8SlR/8QveBzjdhqP5UQOGvdVv0PJU
         h8yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743485185; x=1744089985;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d+Mgpj4yrfHwR2sSJO4BhWOtOStGYWK2zknVZa5Zibs=;
        b=iGZ+ASd0lWoQ+7YG1LDPvV2e1GkDFIkoMKyPY/gwY1kxGzCbnp7wGWfEurWku6mIsL
         bDaJn1xtciHdH29wmD/UXLUE7bEa2XFmDlgnbd6xDUjFm/yPUvkAyFjAA0OX9gCEjO24
         CBNcN4ft0fTsYxjhu92yEohByB9HycWUFFnQ2eDvQWUAcPUb0ej8Q3B0I5YnTGPj6Wfm
         MoXMMCwqVj+w4xeEslw+sK8wFgcQoXld7Gcl5SSylpka0uV0+9Ih3YEyetYlzYD82phK
         wf/t4O24OKbgH3ZsbFFZDhwhfAgB/G/1M/0dPrHYj1nNdJKVxgnZp/WxEYzPTJLY8vxL
         hWCg==
X-Forwarded-Encrypted: i=1; AJvYcCWtTL42NXgXe+GioFSTv2bAZof0XhBCG4sXTti/uXUwfDyCXOA9wgNidrmd99hOmYu/tBvCqeKyEps=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqTcq7kH8qk2vA7PPgwqQwdhvxqPrK0+ISsExsitItpmtoQrN5
	UogAYtS05tPuFrRXRkJSCpdp36ufewuC9HslfLQHfDLSVKRRBMQY41ebikj+VI9QleediluE73y
	v
X-Gm-Gg: ASbGncsD3gXHYKYuCMzFabI3etArO2RAzKSJAHOx9wfZGFVHv+tnheESMTqMVpldJ07
	7x/D/scbR9JDolFARYdR8mS3Jl5WUlWdrzGqk9v9meT0DAT3HWqvcY9ZS+U1pWw2u6odEifaTvo
	xF7lmBj1Umbb7/h8P3LL3pbK4hxY40iAPX8bq9Rx4FFbM8KkX+SJppwapicoTK+QTToxSvLl9X/
	saTlRaPrgI93+iGnP26ZZgSwoP2/kykbGN2yRPisOwrcdSBYaeu76aqzl8SQADG+gldFvdsnkYI
	RWCKLzLbrF+XtRFe7WMgc0PUZ6JFcyIUU5mBioZuy2yZ5g5KW8lJcP1Kho5Rx6rNVVppdyDUpwv
	U9rE62scry/OdXoE0JAO3Cd2gMs4=
X-Google-Smtp-Source: AGHT+IEu51bw47CDQBc1JI6NS5MPm9GXudL8MfmB+EAmAFi6Bv1GscrPtwU828XNPIKeVkrAGQIHpA==
X-Received: by 2002:a05:6214:d85:b0:6e8:fa72:be4c with SMTP id 6a1803df08f44-6eed5f4d3b1mr152699686d6.1.1743485185576;
        Mon, 31 Mar 2025 22:26:25 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eec9659722sm56976496d6.51.2025.03.31.22.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 22:26:25 -0700 (PDT)
Date: Tue, 1 Apr 2025 01:26:23 -0400
From: Gregory Price <gourry@gourry.net>
To: Robert Richter <rrichter@amd.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>
Subject: Re: [PATCH v2 10/15] cxl/region: Use root decoders interleaving
 parameters to create a region
Message-ID: <Z-t4_ymJsKEIz_r6@gourry-fedora-PF4VCD3F>
References: <20250218132356.1809075-1-rrichter@amd.com>
 <20250218132356.1809075-11-rrichter@amd.com>
 <Z-tIkR_bEkDPUyp4@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-tIkR_bEkDPUyp4@gourry-fedora-PF4VCD3F>

On Mon, Mar 31, 2025 at 09:59:45PM -0400, Gregory Price wrote:
> I have discovered on my Zen5 that either this code is incorrect, or my
> decoders are programmed incorrectly.
> 
> decoderN.M  |  ig  iw
> ----------------------
> decoder0.0  |  2   256
> decoder3.0  |  1   256
> decoder6.0  |  1   256
> region0     |  2   512 <--- Wrong
> 
> *Arch quirk aside*, everything except region is as expected.
>
... snip ...
> 
> Looking at a normal system, we'd expect this configuration:
> 
> decoderN.M  |  ig  iw
> ----------------------
> decoder0.0  |  2   256
> decoder3.0  |  1   512
> decoder6.0  |  2   256
> 
> The above code produces the following:
> 	[1,512]
> 	[2,1024] <--- still wrong
> 
... snip ...
> 
> Can we not just always report the parent ways/granularity, and skip all
> the math?  We'll always iterate to the root, and that's what we want the
> region to match, right?
> 
> Better yet, can we not just do this in the region creation code, rather
> than having the endpoint carry it through to the region for some reason?
> Avoid adding the duplicate ways/granularity field all together.
> 

Having tested just using the root decoder data, i now get the expected
1:512, but i realized the issue is also that the regionref uses the
endpoint->decoder interleave ways/granularity

Before:
[]cxl region0: pci0000:d2:port1 cxl_port_setup_targets expected
               iw: 1 ig: 1024   [... snip ...]
[]cxl region0: pci0000:d2:port1 cxl_port_setup_targets got
               iw: 1 ig: 256    [... snip ...]

After:
[]cxl region0: pci0000:d2:port1 cxl_port_setup_targets expected
               iw: 1 ig: 512 
[]cxl region0: pci0000:d2:port1 cxl_port_setup_targets got 
               iw: 1 ig: 256

This makes sense, as the Zen5 quirk here is that the endpoints are
programmed with a 0-base for just their capacity, and they have no
interleave set on them - while the host bridges have 1:256 to match
the endpoint and 2:256 in the root is the only "correct" (in-spec)
programming of the topology.

I think the only choice here is to have another arch_check_interleave()
check here in `cxl_port_setup_targets()` that checks for this.  I
haven't run the numbers on what the results would be if the HB had 1:512
instead of 1:256, but I imagine there lies another round of madness.

~Gregory

