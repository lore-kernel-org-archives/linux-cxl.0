Received: from mail-qk1-f195.google.com (mail-qk1-f195.google.com [209.85.222.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD8736923E
	for <linux-cxl@vger.kernel.org>; Fri, 19 Dec 2025 15:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766159768; cv=none; b=fsLWBk3YvVqapmewXu6F6wuAt/iVnRrzgwmJfRj3cbnK2dVMRd32P/UwuJFfhHPTkzv2Ka8WW6Yc3Ae1Uu9TwgRacHuapAaLX2TFOF6jbGLg+l+0kHH4XWNDMUEF+Vj6VBa2zztSAYoedlXNVMjNIgPfyfF6KgmyuBMfNA964V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766159768; c=relaxed/simple;
	bh=udrDqH7m9tAEUdcwb9UBMMMgYYt3mEDbwsWLQknUbFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bLdAnAcQIN4G6zTufPn/aU2rVGduUgxfTd9/+5uwZlKTIJaU6XEOmPE4rut6cSxlE9llKsnOnKFfP4m+l4+CGrP6bwQsxWb8r1qJygXfJkZbt6aR81VMefp5xo2ahJt8vcPf4MXilURpLnfSX6wpC4+61jIofP9NgMPmb+d66LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=G+O9A6kM; arc=none smtp.client-ip=209.85.222.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="G+O9A6kM"
Received: by mail-qk1-f195.google.com with SMTP id af79cd13be357-8b2ea2b9631so178102985a.3
        for <linux-cxl@vger.kernel.org>; Fri, 19 Dec 2025 07:56:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1766159765; x=1766764565; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=G252Wm2bHFmVmyOD5yAM+H+Ep/B9uA42o2RNtCi8kzo=;
        b=G+O9A6kMb02+kiS3XxkbgMctxscgr+GmleYISJKMgQpMsxDUWGzwtkP6ONRSoVScTO
         eVbJzTLIvJvAGz38bqngLJuAupAwS2YWbjU1rVC3JtszCKAwmTVtQpl0cIObS/LL4zpP
         f2phRvUmHh0EB/OCK0/swvH89I3/KAUlYrwFKYOJhYOB+6V1Pgptt+RAriyRTTP0dNa3
         crb3tvEB+doy9lYrPydOdkrI3HJBWvJvhhCWRLaVpKRkwtgKatC1yg3NuLKnIlSd4QP/
         ESib+8bUas8kyZ8gAVkjEY70wp4euBPBYvlH3zt+8nwnAz0KFCZ+Cty5rAfF6wIXyxyq
         DfSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766159765; x=1766764565;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G252Wm2bHFmVmyOD5yAM+H+Ep/B9uA42o2RNtCi8kzo=;
        b=bb9gd99jAnUKy4zNQofF3bBIek+4WRBwIbvxVRFjG+7eYBZBDIW0pkBjYo9hao6rsz
         rlOpFZ3KbbvRe14TuXlcko2oGo/aRBcY8VYwP5+wPZZ5IPqO6uE5jkOucqzIRBgAe3wP
         kdEnHKkjTSRUvN2OidwybDBQC452QQuKUYB+zWCTRo0EcbBzt83VTQTx34iq1zXhz3+q
         WKG9wr6DsphTk0OK5k592z49DcE+kX3uSNN158pr64CA70jJs3YSqTCzQi6yYVA+gJrL
         UAX1FqPBT7gCvWd/NmsIZh0XestqTHzLf+XSPd1D4/oWO4FJA1j8UhBY2azeZUmH+qzY
         0c1w==
X-Gm-Message-State: AOJu0YxN4tM+gfsYAvDrp8suaOVXgcX2hjWCsXIO+HbLxZDN8Z/lpcyQ
	s25LVINl4G6/hUr7uiQzHDbI9542KRW68csFl/mQzzhtPfk06OAb3WgD9m6ZjxlYoaA=
X-Gm-Gg: AY/fxX7g8YvEXHdm5KMup4wOjxdvO1GmeQJAPXefAKom9bNvSYnW2J91Uk/srTzO/wj
	j1TqjyLOF+Sf8XLkO0SwWCvEwPjgQQg4IcNwsdfZJN9tN6Bk/NLuhdQcvELJyxZjuoQ/0hNPp2x
	omAUGFNaVhGmbuTJl383GAO5j3RXIYoa6otmjKFI8LYSBkaVGF0H9ZVk2P2vnEXL3R6oea76qdz
	trzBJW9/MboNrqo9tFvujuALDZAoYKlw6gaA1Oj18sVG6y29xJ/T6u1rNtgRSNOUyskwwUqnQFg
	O9PLW0Q4rfJ92vPN1kX0Ll2PQbDPSiYTuDo3hxXWiOxCWxs4PfZfkktr4h/ORgvG7rP/fanWaSG
	qIcFWBDEVRk7B1KgbgCCqj8t6ar85OFiQ5TXyi4FdO1wt4YFzyuPXGXMx3gHomlSS7p+LBdak5m
	Yvb/3G23s7eTS/IRB84IoWHUaVQDn/X+ZcRDNAbKrL9R18i87UuEXlT9mX0MhL7NXII92AjoT/W
	g87ZpNj
X-Google-Smtp-Source: AGHT+IGmULJofkH7FmYqyF/vaE/KL6pX3RmjYcu7YInfWOqUFvJXXmjUlxYtaAqFnuQKcGB8qosJEA==
X-Received: by 2002:a05:620a:c53:b0:8b2:f182:6941 with SMTP id af79cd13be357-8c08fd222bfmr492220685a.57.1766159765204;
        Fri, 19 Dec 2025 07:56:05 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c0973f0807sm205888485a.41.2025.12.19.07.56.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Dec 2025 07:56:04 -0800 (PST)
Date: Fri, 19 Dec 2025 10:55:27 -0500
From: Gregory Price <gourry@gourry.net>
To: Alejandro Lucero Palau <alucerop@amd.com>
Cc: linux-cxl@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	dave@stgolabs.net, jonathan.cameron@huawei.com,
	dave.jiang@intel.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com, corbet@lwn.net
Subject: Re: [PATCH v2] Documentation/driver-api/cxl: device hotplug section
Message-ID: <aUV1bz3ddsSaj6qZ@gourry-fedora-PF4VCD3F>
References: <20251218170747.1278327-1-gourry@gourry.net>
 <f3699701-0442-4ab8-9f36-963a5b9ea4f4@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3699701-0442-4ab8-9f36-963a5b9ea4f4@amd.com>

On Fri, Dec 19, 2025 at 03:06:21PM +0000, Alejandro Lucero Palau wrote:
> > +To support memory hotplug directly on the host bridge, or on a switch
> > +downstream of the host bridge (but not contained within a CXL memory device),
> > +a platform must construct a CEDT CFMWS at boot with sufficient resources to
> > +support the max possible (or expected) hotplug memory capacity. ::
> > +
> > +         HB0                 HB1
> > +      RP0    RP1             RP2
> > +       |      |               |
> > +     Empty  Empty            USP
> > +                      ________|________
> > +                      |    |    |     |
> > +                     DSP  DSP  DSP   DSP
> > +                      |    |    |    |
> > +                         All  Empty
> > +
> > +For example, a BIOS/EFI may expose an option to configure a CEDT CFMWS with
> > +a pre-configured amount of memory capacity (per host bridge, or host bridge
> > +interleave set), even if no device is attached to Root Ports or Downstream
> > +Ports at boot (as depicted in the figure above).
> 
> All this is fine, but my concern is what the BIOS will do when a device ends
> up being hotplugged. 

It should do nothing more than what is required to bring the device up
and make it visible on the PCIe/CXL link.  BIOS should not be
programmign the device at runtime.

I realize this is likely infeasible for certain setups, like the current
setup of Zen5 and it's address translation setup, but then I think most
platforms right now don't really handle any of this.

> Assuming that programmability from the Host/user space
> for creating regions on demand based on requirements like bandwidth, and
> therefore relying on interleaving and granularity (I know this is not
> trivial but I think this is possible in the near future, or at least
> possible to be demanded) then the BIOS should not do any HDM programming at
> all ...
> 

Correct.

That said, I can only speak from a BIOS -> Linux transition perspective.
I know enough about the ACPI spec, CXL spec, Linux MM, and the Linux
driver to say "what linux expects" - but I have absolutely no idea what
BIOS *actually does* at boot or hotplug time.

If you have some of that perspective, please propose changes to the
documentation based on what is feasible/possible.  All I can do is write
from the base of what I know.

> I think it is worth to document this somehow and maybe to discuss this with
> BIOSes vendors if we consider this convenient.
>

The entire point of this document is really to spell out that the BIOS
is only responsible for setting up the environment *at boot*, and then
at hotplug time the BIOS should do nothing wrt to programming stuff :]

I can add this explicitly at the top of this document in v3 (and
probably should be spelled out in the BIOS/EFI config doc)
https://docs.kernel.org/driver-api/cxl/platform/bios-and-efi.html


Would something like this suffice?

"""
Linux expects BIOS/EFI software to construct sufficient ACPI tables
(such as CEDT, SRAT, HMAT, etc) and platform-specific configurations
(such as HPA spaces and host-bridge interleave configurations) to allow
the Linux driver to subsequently configure the devices in the CXL fabric
at runtime.

Programming of HDM decoders and switch ports is not required, and may be
deferred to the CXL driver based on admin policy (e.g. udev rules).

Some platforms may require pre-programming HDM decoders and locking them
due to quirks (see: Zen5 address translation), but this is not the normal,
"expected" configuration path.  This should be avoided if possible.

For hotplugged devices, BIOS/EFI software is expected to configure
sufficient resources **at boot time** to allow hotplugged devices
to be configured by software (such as proximity domains, HPA regions,
and host-bridge configurations).

BIOS/EFI is not expected (**nor suggested**) to configure hotplugged
devices at hotplug time (i.e. HDM decoders should be leftunprogrammed).
"""

~Gregory
