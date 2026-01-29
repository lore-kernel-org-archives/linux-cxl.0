Received: from mail-qv1-f66.google.com (mail-qv1-f66.google.com [209.85.219.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF08358D0B
	for <linux-cxl@vger.kernel.org>; Thu, 29 Jan 2026 20:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769719396; cv=none; b=kLPARUpX6l+tp6BbSfC9N6TsnJ3NHUCSNwjwCghNR04RUeT52Pokyqgp2b2fEbynANr0jk70Bbs3R2XgVGwqf0gYjtsq4FR1iIjlzCT2VXLDvYdNHHLhUNXJJX3cMYbkhEk+d1rt1sVsYGDlcJDvQAWP+tjZODub/xvxBiTLjtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769719396; c=relaxed/simple;
	bh=MXRZMhTFIu5HcDpj8rUezC5KCEg+KaWd9yWl/bvgGNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BN26FGH8Qw54DX318ijHH5keCB71B1a7Bee72gcx4zBxwQSPWxPl76jhaVEVAvAupkW9GUrkQe/jd52H43t32a41YKZh58rel1HeVoVPpSe6HD9UrqpNnGKF2BOf6q7f7dHnZiAVeNjf+Och9717JEw/6ViNWfCV+2j816xxggE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=lYyRS8wI; arc=none smtp.client-ip=209.85.219.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="lYyRS8wI"
Received: by mail-qv1-f66.google.com with SMTP id 6a1803df08f44-894770e34afso18057666d6.0
        for <linux-cxl@vger.kernel.org>; Thu, 29 Jan 2026 12:43:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1769719394; x=1770324194; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eg7PLSaHNBLtWxomA8C/yelAjg1aEAhvFf2XisCVshQ=;
        b=lYyRS8wIO10LkC/kShXuau7YatDR5uPzqfb2nCFFS3z01xkUTh9+WrW0iWiMbKz1NX
         NqJyU4MIOZg2OMyCfz16nN9wUuh3meignjJzlp1EQbkgqJSLKkoNG6ix9YlRUsabJRgs
         /Wj51hA8ZwYKoxFGUUKMWlC3q3BxFk231+uKCy8UhZSU5g24FYoiCZ6Uk0pA1CN5JQQX
         DdE9OjD/F2AkJr0W1ugnhPeHBduwPNMxexsAsqAtueYWY70flPmdp1UVt0f8ujX6Hq6Q
         ybAjHgdUAiPT3u7vFYAAs1fuk8RV+m/s2Tobl+X76KrAOe1HOgdXhhWwXUaNbADcDeIo
         mm4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769719394; x=1770324194;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eg7PLSaHNBLtWxomA8C/yelAjg1aEAhvFf2XisCVshQ=;
        b=F3qZTIrcaOr2711l1HRoSayTHqeEPm7+ra4dHZZZcbIU8HtLdVM8642GEHG14dR5RG
         rJDF5/CtE8Sy5bLXYLsGpZbAnT6/SC3ONYR7Iyro2ouW4w2eDaurv1zZ3Pq177W4FixB
         J45B9aOOVx9SHLHNemMSoiOsYKJiTRPzF+8Ud/myPRUfvl4xoQ8qMOtTTjCnpFZ14EKa
         hWZROx5PBu++WfIoR/eqLXZueQBUqYelVM+FSZ0cQsnq4z+cypdR83UBgjhp7HdPRGIj
         Q+KzZhX0yRB+fA2hZm4GqyQgJMsDNIXU53kWrlunLskCVafSg4Mx3WE6j/DETv491Hsw
         KB5Q==
X-Gm-Message-State: AOJu0YypvrcgR3PhfxUUWG6EayIrxOug+qSGr7I/B0/bFtM3Wf+1qZEe
	rfYzpoLCkcPtmb52mJTOobJt2QoiwsNp/ILknBRCNT+rwi7fI3jUxdlA9cEc0vIYuNGOBuTSv8I
	XMiDNPp0=
X-Gm-Gg: AZuq6aKExgHQ/GvbXnBiVZvyOoS5C6DzkJs4GrNz3vF3XU2vHf9lkhW/SoE9hbZo9Tw
	10VwBlxPUnzzA8ySf0Da8tywDWnuD8uvwDjLR8fFR59X36IpkY09qEIeEfyLTMHR5uIseCH2RWP
	adGIr3YlqMAasP3HMhJ231bC5x/37nLY0QBlpCM5matsQcBKHGBmvq1HNwlE9I7TVhZpNIWXhUg
	4E8qxsol8KJL07fp2SBazMeDz+3xCJqrlK9vINfvEJw3TKgKGc30pk6z6NzFAzkHtfC+x1vdn9K
	6DAwmy8ABXFoyxbN5Y+3AzFkfvQO/5qfK4cRJTcMGcji/94C51poUHU/BagY+/iMYKp3dhIKNYG
	vmVfsCJarEcNEpMpxNbqk0p4aPL4zvzPynoFU1PKUYIwbqbbcIf76KSM+fXt277E7Ggb0FJT5cR
	gNSfr8WrDjuKwEHtnmCuFbUOhEVhYAgcqk12Frnp9JOFhwdWH/Rs7tS5oXA0lHX1Kg5UCbdg==
X-Received: by 2002:a05:6214:519c:b0:88a:2ebd:1e3a with SMTP id 6a1803df08f44-894ea0aeb16mr11058626d6.62.1769719394335;
        Thu, 29 Jan 2026 12:43:14 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-894d36c7591sm45346856d6.16.2026.01.29.12.43.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 12:43:13 -0800 (PST)
Date: Thu, 29 Jan 2026 15:43:12 -0500
From: Gregory Price <gourry@gourry.net>
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, jonathan.cameron@huawei.com,
	dave.jiang@intel.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com, anisa.su@samsung.com,
	dongjoo.seo1@samsung.com, s.neeraj@samsung.com
Subject: Re: [PATCH v2 1/3] drivers/cxl: introduce cxl_region_driver field
 for cxl_region
Message-ID: <aXvGYJjULVhNiEMV@gourry-fedora-PF4VCD3F>
References: <20260113202138.3021093-1-gourry@gourry.net>
 <20260129191039.kodgkum445ws5rhs@offworld>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260129191039.kodgkum445ws5rhs@offworld>

On Thu, Jan 29, 2026 at 11:10:39AM -0800, Davidlohr Bueso wrote:
> On Tue, 13 Jan 2026, Gregory Price wrote:
> 
> > The CXL driver presently has 3 modes of managing a cxl_region:
> >  - no specific driver (bios-onlined SystemRAM)
> >  - dax_region (all other RAM regions, for now)
> >  - pmem_region (all PMEM regions)
> > 
> > Formalize these into specific "region drivers".
> 
> I think your overall idea of these region driver backends to isolate use
> cases makes a lot of sense and helps untangle things. This series is a good
> step and nicely moves ad-hoc complexity out of region.c.
> 

fyi this is being respun entirely to include the end-to-end solution
described here:

https://lore.kernel.org/linux-cxl/aXErSP1zKnv4koKG@gourry-fedora-PF4VCD3F/

Posting shortly

~Gregory
