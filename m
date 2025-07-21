Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4CA01D516A
	for <linux-cxl@vger.kernel.org>; Mon, 21 Jul 2025 02:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753064076; cv=none; b=faIAvaQhtml63lzlygSysjI+IZ8XAbM2xvIvrOEiQ+SWiTcy0CylO1C5xA7k7nxO/Cl0+BTMkmG5UZ6br2knHZ99KK3thOkFpbROJX4M10MDid+xC7hbgcoXG6FWm7QtHt8y0fLSfP+OiAbX7IBTyq6bDp9UKLHc5a50XHP71Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753064076; c=relaxed/simple;
	bh=cvrc5ZmdCSIyzSYdVh1ST3+8fJc6m3kOwdyLMterUjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a58xVX8Igti/8+pMUQt4BVSQZFQtsGR4joSpKWB3d1IA1Rtp2vVKQwXo7VEN3EQmtsySdBG4l6EzhCHdo5rwjkNoCMYiYrxbUhVfCRdKaK+E6ltgfSa/vt0ZNNPp+SjzFbJ9PdIIo8nhhg5bIZjn2P7mK/Ip5JRzEb6+DXCaYFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=GbhzYDGp; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="GbhzYDGp"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7dd8773f9d9so379868185a.2
        for <linux-cxl@vger.kernel.org>; Sun, 20 Jul 2025 19:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1753064073; x=1753668873; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nme9beJ/B5ceTMlqYPH1qkWLKsTVJ7R5Q3B64Q6hIZU=;
        b=GbhzYDGpNRXpjAS+Mbo4V3j3pMU425njK9HA66zTCM93XIJzNJWWaGHGqrtFbmemSF
         gC1Txp1r+ipxjZU3GSskypKBUbCjGzayIOoNkLugzUgxPt47Y50Cz5KOIc83Hr3bTY5Z
         xUbFZ0ab7fDBejKQpFLqo+mNSpW46gOvCFI6FQsG8oGbl82EG7S0HWt8qODBbijZNQp+
         qvb6KNAro+x24izK21/MHshMibGcYpHjDsGwcrlBvnoQfKJ/pS2bxBuCEORJWYdhYWVO
         qOBVLZ/W74MqMbRthC5wJUG/SSykzO3j/YQcOQu1POVy50QdElP+gFpRw4ujAg6sIvS4
         BZaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753064073; x=1753668873;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nme9beJ/B5ceTMlqYPH1qkWLKsTVJ7R5Q3B64Q6hIZU=;
        b=Pnp8f71R6puhz6fqgIutVGPBE8vlARUN0/6vF/i6tymOZJNem2gFfhd54PzjbdngL5
         zIvTjE6FRoZ9kWSRCFs860GUGnn+tjkvzhRW+/Hv9IkHWTOGFn485oonKk7oSgv+HjUS
         YYGyQuxDfMLYADDAO9O1cD7IHpVTFT3UroVLHetlW2csb4CiwXa/ogBhZkjour6tsgQE
         UhCJTDf0EBWpipwIZTLP0WYj5MLQECYZtYJOI4gw9gxqLqITqMQ6Rpd8cLeKlCiSJuhr
         1SZi2cdvwpHJCDFt2EB0jL7RINpN75fO5oKv6t1Oa37QWXIvl999kzSmACAe/GLEaJHY
         dZXQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/xFoMmt95Ze2knI14fpM1gmVk+Es5sHBvrWWRydWc4cIxGxbNa1QgaDYZtxMRl/b72iNrUf8zq3s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8hp7F+ZH0/i+bTdafMxE6yXu1SfvH8octTGzR34cbqnPgBiWq
	H2+Jlb+ldEkBZ6R8eSFJWRY62eEc1+PYRDkPVktles2mLBzUkBa7Wdw9ph1m6qn8VOQ=
X-Gm-Gg: ASbGncvXdRmdHNex6FWeIxFOtPAF6QyGMkxCtCMqqW4Z3ZDRRgzIEIn8f0kKhM8+DLf
	cvFBnWoirvuLlcHQ5mhIGMMTIKatcQutqCblqJN1FQpAtOQ6wK7qna2B4RqyhXdJcEUeh1h8PS7
	55W06WZ1ADgJ39tH/roYQcnwki+WR+XlmViv1AbS7FYUU+o4NLp6SdHmc2Nq9iauSfT3E1JrhMG
	AtQaeKdLF5rBHlT4jI4CTEquDPHt31Uuk39pFRSPy70JLM6WbQndTgE25lwVU0QzMO3nLkxeC1s
	OvzXYA9H56DN7fhAQpbcJUE0dXxGqEVRsnv+BXNIlIFAP2qMrubj9QmqDcYQXPPjP86Q0KHCZaZ
	mMXtcrG/AKWKjoQXJI5KDmmcvXi/p6914Ylo2bSuLVEDLeH9OBTLQpf4Nu6TtVRU7L/PTL94Pt1
	NTToqrjrb3Zq3u
X-Google-Smtp-Source: AGHT+IEclEDqbrM5ANfunIcJAFve96S9CLx4lLFxK1uu2tLx/R9z5iVAWhVWRGOjMcc9s0sBKxe6fw==
X-Received: by 2002:a05:620a:4398:b0:7e0:8487:cdc5 with SMTP id af79cd13be357-7e342b4310bmr2459539085a.33.1753064073461;
        Sun, 20 Jul 2025 19:14:33 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-42.washdc.ftas.verizon.net. [96.255.20.42])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e356c9230asm358410285a.93.2025.07.20.19.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jul 2025 19:14:33 -0700 (PDT)
Date: Sun, 20 Jul 2025 22:14:31 -0400
From: Gregory Price <gourry@gourry.net>
To: "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>
Cc: 'Alison Schofield' <alison.schofield@intel.com>,
	"'dan.j.williams@intel.com'" <dan.j.williams@intel.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: Re: Question about Exact Match Requirement for Switch-to-Endpoint
 Decoder Mapping in CXL
Message-ID: <aH2ih0Rrz1qlCEV_@gourry-fedora-PF4VCD3F>
References: <OS9PR01MB12421AEA8B27BF942CD0F18B19057A@OS9PR01MB12421.jpnprd01.prod.outlook.com>
 <aHhWnE3ETrl_rZjL@aschofie-mobl2.lan>
 <OS9PR01MB12421676B7FC8FF44F4F171D09051A@OS9PR01MB12421.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OS9PR01MB12421676B7FC8FF44F4F171D09051A@OS9PR01MB12421.jpnprd01.prod.outlook.com>

On Thu, Jul 17, 2025 at 10:52:26AM +0000, Yasunori Gotou (Fujitsu) wrote:
> (I'm unsure why each endpoint has two decoders.)
> 
> 
>             +-------------------------------------------+
>             |                 CPU/Host                  |
>             | <decoder 0.0 >       <decoder  0.1>       |
>             |       |                  |                |
>             | <decoder 5.0 >       <decoder  5.1>       |
>             +------+-------------------+----------------+
>                    |                   |
>                    |PCIe x8 lane       |PCIe x8 lane
>              +--------------------+--------------------+
>              | CXL memory endpoint| CXL memory endpoint|
>              | (f1:00.0)          |  (f4:00.0)         |
>              | (DPA 0---128GB)    | (DPA 0---128GB)    |
>              | <decoder 9.0>      | <decoder 10.0>     |
>              | <decoder 9.1>      | <decoder 10.1>     |
>              +--------------------+--------------------+
> 
> 
> During system boot initialization, the CXL driver references the HPA address assignments
> of each decoder configured by the firmware.

This all starts with the firmware and the ACPI tables.  It would
probably be helpful for you to dump the contents of the acpi tables and
compare them to the examples here:

https://docs.kernel.org/driver-api/cxl/platform/example-configs.html

Depending on your platform, you might be able to follow the instructions
here to dump your CEDT.

https://docs.kernel.org/driver-api/cxl/platform/acpi.html

The number of decoders is irrelevant and defined by the device.  They
can be present but left un-programmed/disabled by the firmware 
(base=0, length=0) - that's not an issue and usually expected.

> However, the firmware implementation of decoder addressing was as follows:
> 
> ----------------------------------------------------------------------------------------------------------------
> Decoder 9.0: HPA (Addr A)        ~ (Addr A + 128G - 1) | Decoder 10.0 HPA (Addr A)        ~ (Addr A + 128G - 1)
> Decoder 9.1: HPA (Addr A + 128G) ~ (Addr A + 256G - 1) | Decoder 10.1 HPA (Addr A + 128G) ~ (Addr A + 256G - 1)
> ----------------------------------------------------------------------------------------------------------------
> 

> This clearly has the following issues, and the CXL driver failed to initialize the CXL memory:
> 
>  - The decoders of the two devices on the left and right indicate the same HPA.
>    (Again, I did not specify interleave.)
>  - All decoders indicate a range of 128GB for the HPA size,
>    which allocates twice the HPA size for the actual device size.
> 

This makes sense if interleave is intended.

You'd expect the following relationships:

        Decoder0.0                Decoder0.1
	    |                         |
        Decoder5.0                Decoder5.1
       /          \              /          \
  Decoder9.0   Decoder10.0   Decoder9.1  Decoder10.1

If you're not expecting interleave, then firmware is just wrong to
program endpoint decoders as described above - although TECHINCALLY
it could still accomplish the job with the following relationships:

        Decoder0.0                Decoder0.1
	    |                         |
        Decoder5.0                Decoder5.1
	    |                         |
        Decoder9.0                Decoder10.1

But if you're doing this - there's no reason to even program the other
decoders - so the firmware is just doing something odd and the driver
just does not support such a quirk (patches welcome).

I'd suggest checking the contents of the CEDT to see if the CFMWS
describe interleave being set.  Then I would check decoder5.0 and 5.1 to
see if interleave was set there as well.  But at the end of the day then
the last example (below) is the "cannonically correct" way to program
the endpoints "according to linux" (as of 6.15/6.16).

> At that time, the firmware engineers told me that the Decoder Count in the
> "CXL HDM Decoder Capability Register" is read-only according to the CXL specification,
> so neither the OS driver nor the firmware can change it. 

This is correct.

> - Assign all different addresses to the HPAs.
> - Each decoder is responsible for 64GB, which is half the device size.
> ----------------------------------------------------------------------------------------------------------------
> Decoder 9.0: HPA (Addr A)        ~ (Addr A +  64G - 1) | Decoder 10.0 HPA (Addr A + 128G) ~ (Addr A + 192G - 1)
> Decoder 9.1: HPA (Addr A + 64G)  ~ (Addr A + 128G - 1) | Decoder 10.1 HPA (Addr A + 192G) ~ (Addr A + 256G - 1)
> ----------------------------------------------------------------------------------------------------------------
>
> However, this method did not work. The HPA assignments for Decoder 5.0 and 5.1 were as follows:
> ----------------------------------------------------------------------------------------------------------------
> Decoder 5.0: HPA (Addr A)        ~ (Addr A + 128G - 1) | Decoder  5.1 HPA (Addr A + 128G) ~ (Addr A + 256G - 1)
> ----------------------------------------------------------------------------------------------------------------
> 
> As a result, the CXL driver failed the initialization of the CXL memory regions
> due to the exact address matching place by match_switch_decoder_by_range().
> 

You would need additional host bridge and root decoders for this to
work, since interleave is not set.  This is because the driver expects
non-interleave relationships between root, switch (host bridge), and
endpoint decoders to be 1:1.

i.e. for the above endpoint configuration to work you'd need

decoder0.0  decoder0.1  decoder0.2   decoder0.3
   |            |           |            |
decoder5.0  decoder5.1  decoder5.2   decoder5.3
   |            |           |           |
decoder9.0  decoder9.1  decoder10.0  decoder10.1

> 
> 
> Afterward, I requested the firmware team disabling Decoder 9.1 and Decoder 10.0 by 
> turning off commit bit of control register of these decoders as follows:
> 
> ----------------------------------------------------------------------------------------------------------------
> Decoder 9.0: HPA (Addr A)        ~ (Addr A + 128G - 1) | Decoder 10.0 HPA (Addr A + 128G) ~ (Addr A + 256G - 1)
> Decoder 9.1: disabled                                  | Decoder 10.1 disabled
> ----------------------------------------------------------------------------------------------------------------
> 
> This is exactly the same address with Decoder 5.0 and 5.1.
> As a result, match_switch_decoder_by_range() passed, and I could see two regions to use the CXL memory.
> 

This is the configuration you want.

> But, I could not find the reason why decoder 9.1 and decoder 10.1 must be disabled.

See prior answer - it makes validating the decoder relationships easier
at the expensive of "pure flexiblity" - which is not a use case here as
these decoders are being programmed by firmware and therefore should be
static.

~Gregory
