Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D149111CA9
	for <linux-cxl@vger.kernel.org>; Fri,  3 Oct 2025 14:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759501397; cv=none; b=qKo/6U4vqcwOrO7ZkdKnL90+e+a/mvRtWWHz6pZ2Ey9PA7ptEm65MFzvgeuNp1GySKYhsznwRFPjIU2me967yXTikuTjBzzZS/FSuWlWREsX9zropK8k56DAJli5wUEEHcMuSCr5x2X9tJ4pin28GpgFviLXH53n3o7v11ZOwpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759501397; c=relaxed/simple;
	bh=ZNLnSKgncLVUeolihAdlLxpg3H+yQFxMlDR0Lih5oq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c9UkvI7d+X2C03roZndFNPyWxRRCsbLQ0rua5VhqG4RewBLV6GCiINceb24diAbLjNtsKuboH/UQAP3tBhQcOczfABxpy1svTMRG/xWVjWvgpOD9jtQf6SAELinNVtgKbM2viJj5a1EqnXjGvvSY7OSjtmhdMDEe7Fk/RAUsESI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=t21BLodu; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="t21BLodu"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8599c274188so201475585a.1
        for <linux-cxl@vger.kernel.org>; Fri, 03 Oct 2025 07:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1759501394; x=1760106194; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TjshectPsoU5xexsh0W+Ld8Cl13e7LDyb1Q/bzYB9s8=;
        b=t21BLoduIcBkV6cwRIewUUSB/FR0EiQHy4rQgIBtmcdDTuzOSCJ3SHj8lBurq/rbnZ
         eSbTbMkLU8gcJFhBiLnJ9TamDAIC/nskd70L9Abrbztd/npm3Lq0B3Aj9Xt8fkE7rlE8
         cxag7qRKvhs/zXYp95CkoK+CE24K9+YpuUO3Szyctw4pE6HjE4E0sNH/CvRTruV83gM/
         FsFGWtjZ+2mwL/y/ONt4dih5kT1Fm745hyt1IK01tHK5lPrmViVWkaPw78+oEP5QPFDf
         PLu7O6S2IJjFeArAy5Eq9tYTPjwFMGSC4SYlzqTwjVhIidnmgMgsKLeQvYu65waPM1Rb
         Z07Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759501394; x=1760106194;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TjshectPsoU5xexsh0W+Ld8Cl13e7LDyb1Q/bzYB9s8=;
        b=SIJuvvKq2qh9e9F3zCHO9I4MSdBZEi0/qyasWuV6l9JorFAxGkSlqorwlUnPcnp9K0
         7aFReR3iptTwNGZnR1PvOfY/KR7hkosz+TwVNfn7W7FRvxWa1y1GrDNvN9rbP6mweoVX
         7cKx56jNQ6DXIlOOOdHxgfHkdnGk/YjS4vPLlvamRTYvDviIPYSP9+UBkqkTPOGa6mTS
         NrGb46/fz4nm2INMkSb/+D4NRBu1OKRgPkpfaJdkRV3Oay6mOav8famhLqz+SeRnTc4U
         ANe1ntUY9Gno5PPFeehOyr/lKyjYpdp+B7oOSCdHau0z18vJjQFjVSyOTYGPnlTKtVQa
         vx+A==
X-Forwarded-Encrypted: i=1; AJvYcCWUH+nCWPv3E7EsgRS7VyIbNnYaOT8efYZnCyUN40aI3KPRPOQYcsVvy8riplfjHcWQOWUMx0HXMzY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3mIoGog1MWJs9kH4cgpBbPA/MoD9biGFYrW9KlQkLjDBmbyV3
	6iXAM2PtPq0yo5JvsbJ9FiEY3a80USC998Glxi+W0+IkzKT3Q1xpR08a2M8xSixwMSDZVP4+JkF
	0JW6y
X-Gm-Gg: ASbGncs0Haycn1ZcKwNitS1iNIYWNe9GyxTW/HYqB4VGSFADQcMZn10tQUGfmSO+07b
	ycsSqUO8wSZNWboeI6AORLV7P2aeNoyu+IhMb/pRpwpWbMC43i8M89iCrP8ZKGH6Zs0mwLGe1Kc
	b7OrbGIzx4xMbKFQL7AlhYsvMCSWzxbrrsJEp1L1PQeZ5rAXP7Y0/2AxIC2D7QT8BTxTkIqrKIG
	PRGdtNx4QwLdibXjP04xVACiuNNsGPzOxR252ifkoZAWrFnO9isMdjQ4+rgRTjdT3c6vEeTAcTi
	HX7o1RpdY2lHQ4d4i1VfbqFss93qI0eryvqlBWrmFAZfg6hbiNJp7rHrBtXnUGAbmV25NI327rJ
	uOlVvwPbLn0izbfRtNqIs5Ip2pNxDaBs9SaohSiNvrIBM5q2//jH0l0UsiXjFl+X2q2TgCI47Ot
	zDNzdWhpp/DJ5bWx0H4C8EiRDBEQ6dWzW9sJ5T+u71
X-Google-Smtp-Source: AGHT+IEGOuseBzlPlNuROJrG6WSd4huQymSIrENqcNpGScmGjW7j99oTy4VgsNRVtRatqijlGlv6iQ==
X-Received: by 2002:a05:620a:1a8f:b0:818:dd40:405 with SMTP id af79cd13be357-87a38377379mr466910185a.64.1759501394537;
        Fri, 03 Oct 2025 07:23:14 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-87771129f41sm427021885a.3.2025.10.03.07.23.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 07:23:14 -0700 (PDT)
Date: Fri, 3 Oct 2025 10:23:12 -0400
From: Gregory Price <gourry@gourry.net>
To: Vishal Aslot <vaslot@nvidia.com>
Cc: Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Li Ming <ming.li@zohomail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Zijun Hu <zijun.hu@oss.qualcomm.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cxl/hdm: allow zero sized committed decoders
Message-ID: <aN_cUPzzwUy-s36n@gourry-fedora-PF4VCD3F>
References: <SN7PR12MB81316C958DF0F4B10369B928BBE6A@SN7PR12MB8131.namprd12.prod.outlook.com>
 <aN4SSEmaCaxbeiwJ@gourry-fedora-PF4VCD3F>
 <02a4b5f1-ad29-4825-9040-ff96e328f674@intel.com>
 <SN7PR12MB8131EE31375531673BCF0C62BBE4A@SN7PR12MB8131.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN7PR12MB8131EE31375531673BCF0C62BBE4A@SN7PR12MB8131.namprd12.prod.outlook.com>

On Fri, Oct 03, 2025 at 01:03:16AM +0000, Vishal Aslot wrote:
> > ________________________________________
> > From: Dave Jiang <dave.jiang@intel.com>
> > Sent: Thursday, October 2, 2025 10:32 AM
> > To: Gregory Price; Vishal Aslot
> > Cc: Davidlohr Bueso; Jonathan Cameron; Alison Schofield; Vishal Verma; Ira Weiny; Dan Williams; Li Ming; Peter Zijlstra; Dan Carpenter; Zijun Hu; linux-cxl@vger.kernel.org; linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH] cxl/hdm: allow zero sized committed decoders
> > 
> > External email: Use caution opening links or attachments
> > 
> > 
> > On 10/1/25 10:48 PM, Gregory Price wrote:
> >> On Wed, Oct 01, 2025 at 08:37:26PM +0000, Vishal Aslot wrote:
> >>> @@ -1210,6 +1210,11 @@ int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
> >>>                 rc = init_hdm_decoder(port, cxld, target_map, hdm, i,
> >>>                                       &dpa_base, info);
> >>>                 if (rc) {
> >>> +                       if (rc == -ENOSPC) {
> >>> +                               put_device(&cxld->dev);
> >>> +                               rc = 0;
> >>> +                               continue;
> >>> +                       }
> >>
> >> How do you suggest actually testing this? I briefly poked at this in
> >> QEMU trying to commit decoders, but i found myself incapable of
> >> exercising this path.
> 
> I tested it locally with our BIOS (UEFI) where we commit and lock all decoders and
> all except decoder 0 are zero-sized.
> 

Ahhh, so are you saying that you will only ever observe the following
(as an example)

endpoint decoders...
decoder2.0   ->  available and can be programmed
decoder2.1   ->  size=0, locked
...
decoder2.N   ->  size=0, locked

or are you suggesting the following is valid:

decoder2.0   ->  size=0, locked
decoder2.1   ->  available and can be programmed
...
decoder2.N   ->  available and can be programmed

~Gregory
