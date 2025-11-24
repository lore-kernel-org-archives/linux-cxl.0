Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889AD32E133
	for <linux-cxl@vger.kernel.org>; Mon, 24 Nov 2025 20:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764015013; cv=none; b=C+OvBxdrjDQbXRqZuTCy5IA/1FU/xO+Lg9t2eaSsrFc24ByjBbH7l4bikL1NZuypayIuAP268PxFII1k+hNdkTylFu5+BUpxgtzKVOD/0AmD7vm4BcYeiwL3dUzvz7mKxxeZYe6XUuH2gMiMZ93RGPa6nUYC/63m32yk139UqUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764015013; c=relaxed/simple;
	bh=U4J5LIhPhIUrlIYRlZLmOFMZ7NyIKg4gyAsCshxSUl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GAGOHuGh+zS+wlD2qlLdIOfL7HtdVgxJNZbGryCAPTY02AiW6bbztHxXVCy1iorXp510yXF48n0yI4nVHu54bUg8jsj5/LItLYv85w+/FMcTmfED8szIAOam6jdLl6yOtOntQaosprLUPE3Fz1cqPsJxs5BWT4MAVWFHQrxhfkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=fI6oKa8j; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="fI6oKa8j"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-880499b2bc7so46475116d6.3
        for <linux-cxl@vger.kernel.org>; Mon, 24 Nov 2025 12:10:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1764015010; x=1764619810; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j5XiJyosyzzMdsKAgW22rJ6x95wdGprLZ6ABeyQ0stk=;
        b=fI6oKa8jRYFeDkG9IgIn6sY1JyhKNIF7vpuzugWlfN4VUxCfX2y0k3zcZzmtXEXspN
         v5ZIbVzWctDfpN6+dTT4f0f9EYrFglQbr5ezXwt2seK8kpUCh6IqmYC+iw9zdXLKtqVy
         bV6wX5lIbmkpV1TTvf3zIeB8oJSNcaaMeeBIhEwnPliTPXcFaRMHoB0rxRip50I3k7Gd
         SrxZnO9Cqr/iVka9LAOPjtSXypN++BVP2n7nDk5uAaMWCU5iSHnyJ6qHtuR3KQygTOHZ
         F4leMjk+MvmIyqMLz7rTtZjeONcJpngNDVXCqVkPKTPXAnRpu1/MD4U0FxNFdIFjI290
         j5WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764015010; x=1764619810;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j5XiJyosyzzMdsKAgW22rJ6x95wdGprLZ6ABeyQ0stk=;
        b=GBHCk9FjfYg3bL/JiI8CFOJB6gW45Cw4Yt8CvtwCD1vpVtPypgcestuUQt/r0LZ+e6
         SmZG1HP6lmgcN1nk88iJij/Ldc5lxD5h0PHEqvXLUWkURZWr9OsT86u1lEIrN3Me35pD
         GsNdW9vqXnS3bgH/JD9aEpoTUIwkLP5If8CQzzUC1+Kl5RgdwddA/bTp2/+jeMwU1Npd
         h5AI9K25qJdi/QGwNJOwkNyPae3gEpc/TpRnlFZhq+jbDdXQJFcxg1rmexL5OTQkNP9C
         DHIOVnMDxlI/CK40Fg/9CjWI00UgGuwa/Q64BW5Z51lIvNojd59mt/2JcuuWNLhG+BK7
         IWcQ==
X-Forwarded-Encrypted: i=1; AJvYcCVidJQw6eLWKPS1SIAH92lXLatvCRY1ugbDJcBCNqjPsa38xP7j8HXClNL8wNF7zl9c/QCDNVVR+Zs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLGVX/wiEFRZtTffL4fk98Oi93snfYcTa8bw7DU6QObvLECCgf
	DpRiYe30d9WcPv2U20qMciWhfC9cnXXgP850xtQXHGGriyeqc5DLLEkG4agNBy8u3VM=
X-Gm-Gg: ASbGncvjQmscq8cWv0f7kEyFNwZ+Xhi/pcklQamlcn6dDAOosgWgtFBYQvLOSPr0MxE
	dNRnbpH3ky+QVtEla9BF3smP3i1cyDRVkPK8CjyVp6gIjMH5BVEs+ZDQWXXm5bzGz5rom0xHnY2
	pbUSd2ydmJus+2zwQvXEwbCT+y1TdHkjKwMg5uB5BaiEXpHP4861YwNScbX3IReCA5mfXM6qH+h
	DcpCxS3+YTOzzu69BaETD/LFPEhci7ZmjFzkFn9E8CznggnEY/O7g4USI+GTZ5/kEmf6zhruEia
	6AWhklIVYqOdsBoXEGDgQ7RI/HMIkm/SXEwJIPexfOeceliVbJYArFTqpp7FQJojvwfQm5dLBhf
	ySjIS+mXWSwhgICJVCQr7x8QJ8NdLBw3Wi8rh7HxLUr6pxYFHfvx8xzYCUl0+/QJPloW1zq2PW2
	dEnoAAOJin77+L8I/TKgMKZ2LR2HV1bF/N7NUGJr9Q7d1RqrgY/HNVipGa6alzO8QNll+QGUe7+
	9XDNJqe
X-Google-Smtp-Source: AGHT+IH+mBew+wnxqNp4Sf/TKF7NiE8E4GunBikxiZbXLHLCi3YLBaZ7qmkG/PEwSArVFyFllI63hQ==
X-Received: by 2002:a05:6214:450b:b0:880:4f97:d17b with SMTP id 6a1803df08f44-8863af15b00mr4041916d6.19.1764015010269;
        Mon, 24 Nov 2025 12:10:10 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8846e54d13dsm106455586d6.35.2025.11.24.12.10.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 12:10:09 -0800 (PST)
Date: Mon, 24 Nov 2025 15:10:07 -0500
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
Message-ID: <aSS7n40Hmiaf7ibc@gourry-fedora-PF4VCD3F>
References: <20251114004021.1310661-1-rrichter@amd.com>
 <aReKmdOeHBBDWMuC@aschofie-mobl2.lan>
 <aRs4ILR8EEwnfOtQ@rric.localdomain>
 <aSOxXX7xX4jYqqvF@aschofie-mobl2.lan>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aSOxXX7xX4jYqqvF@aschofie-mobl2.lan>

On Sun, Nov 23, 2025 at 05:14:05PM -0800, Alison Schofield wrote:
> On Mon, Nov 17, 2025 at 03:58:40PM +0100, Robert Richter wrote:
> > On 14.11.25 12:01:29, Alison Schofield wrote:
> > 
> > > Does this work 'as is', no changes required, to support DPA->SPA
> > > (used in CXL Events) or SPA->DPA (used in poison by region offset)?
> > 
> > The PRM handler could be used for to-SPA translations, but it might
> > not fit well to other users such as profiling, tracing and error
> > handling. Those users are executing in a critical path from a
> > performance or stability point of view. Performing a firmware call
> > could cause problems here. Since the to-DPA translation is missing
> > too, a different approach to solve address translation might work
> > better, such as examining the region parameters. The kernel's address
> > translation library could possibly be extended and used too. That
> > needs to be figured out. Also, my main focus for the patches is region
> > enablement.
> 
> If address translations are not supported/supportable, a quick exit
> on any attempt (DPA->SPA or SPA->DPA) with this config seems needed. 
>
> Better to fail and report ULLONG_MAX than leave open the possibility
> of adding the wrong address to trace events or using the wrong address
> in poison by region offset action.
> 
> Maybe you already know that it fails gracefully? If so, then it comes
> down to documenting the limitation.
>


IIRC the to_spa() function wouldn't be populated (will be NULL) if this
is the case, so you wouldn't even be able to call the translation
function.

This was hit in a prior version of the set where I saw it fail on a
system using System Address mode instead of Normalized Address mode.

~Gregory
