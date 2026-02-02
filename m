Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5CB36213F
	for <linux-cxl@vger.kernel.org>; Mon,  2 Feb 2026 18:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770055335; cv=none; b=UV39DtpqqjS0qwbjqhBE/wTL3IA2TkQjTU9+p1UdObzHcKa1j9uE8sSKM7yEjwD4CT3LAeKIAl31dJ7oqUYEx/qVDlRzmrGAsI9Pazy6yCm5OXG/L5wYOd+y75m3CqnMO9H510c39gyrkQVoRnBavedslRdQK5m7KyXwei1cli4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770055335; c=relaxed/simple;
	bh=MbAgTX+hDTfHzpvyoNvAv/VH86Gp5D8IWac2rvKmaY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YXTtgzx8czA7WHDyqrlx0GM0LaA52nJojQSVLRyDhI47mT/99CIIkp8jWmGimiaNZ5T1xAwkFTajxAhtHi3xFi1CYmZA28oJL45eZXzLIWA0qP3z6W5X13zHxkreZmcr8+wl909bdmrgINNlb/9urLwyfO6RDwuBO1WlAAbjl9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Aj1JpC+x; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Aj1JpC+x"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-502b0aa36feso50717061cf.1
        for <linux-cxl@vger.kernel.org>; Mon, 02 Feb 2026 10:02:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1770055333; x=1770660133; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NMO26NJqLzUacsptvD643N0i+a1yKYqxDegqXwZutbI=;
        b=Aj1JpC+xrABNzYNRpCdkZPyfq4fpyHofQgTKnTflpXvwKssxlbTrRAytGzhuPWUdNK
         CfRYx9eV/CaKWasmMIYZOb3PbKKbRph2X5q9IzvXiW3Zp4VcIzjHLGh5BGVQq11KaLfK
         HIfPvH1wqREF7DiOxjT+o1zGx22ZdlKX59n2D/PmifZQ5eB6tz2BfWcSischrqsnggfy
         1F79UPbPyw6n/UOrq3Aqn8haN46JgwftdoHEVRWplbueekIRggnWnH6OMK1GDMW35go/
         vTvErql0wX5l2Qey8bJa5VH/Q24DExcroGeIQO0uC294obNNfFCH8LyGWZIWtX+AXCgn
         9mRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770055333; x=1770660133;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NMO26NJqLzUacsptvD643N0i+a1yKYqxDegqXwZutbI=;
        b=hUDmK5ugynD9h/D7DITSx5UnJVWn7tHoKILPQyLjnxKMq/ugcwURwA9VE179twzuOd
         0E1+w5X5+XbAfDuXbb/SfH0uiOIhhdWlSSqHzb9yqUEueDYUsrJIZcA8JTz4qsJzODsa
         +Q2mVnJllm0TRxtsJGx5UUGz1bPuGfQ2295SZqsvapyc2x4lvdha9rDhFRHYyzKRUSKV
         /fr42GLH50D14ShjXSTGC+JL/pxCR9exLFsaEMIBzOlg9Rs8hM40jZYcfLD3ymH9igUV
         8Lec+A16Qgc8HLtSFFfLgrPIYYOnpd5gx+SVjN5CJMRq9xoSWan8+yk8BaYNmZCo0/uH
         5Ajg==
X-Forwarded-Encrypted: i=1; AJvYcCUeAMZp7RP2EW4khU4S5TGajsuLhnjm1NlkxqEqWWYV8qN+e588zlL8DFquBFJVE9N3mtVmjiHpZXI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6KdUm4rJbqme2agjNi26q+4kPFxbj/DlKZh5BdxzMkwc1dNw9
	iAjio2UuvCKwQ9IoTvrwnL2AqjRTwDr8TUn5+WIJHecPX8QKftJsF8NbLmRV6ikO7yY=
X-Gm-Gg: AZuq6aICpfRSp0sWryiHh94IQ4nsxq1CQjtmPZ5G/0+94rJCPnCRkZJWBlwyMrueCOL
	+3wGSieWxOFBfz12zXSoABkzBJDhni0UNJv/A+VORXyAMtoNbmP1NSN2i85AR6gpnvICgxMgiUm
	ATFo9FCydy1OZKEmSgGspdEEvjhNS1sAxiONNPIhepuBgRu1a7pT//ld2Kw29iGC0hu47JFUQOM
	XY+ompl/shtEA7UstP2Tvq5sQcQfl3U3mVdblMf7nO92nQidi3xBrnOJSMOE9CdikJU/ixhjCTP
	tb5jc76swQsHD8hyP9f19XWvns65jntTknc1iVHEORVLhP2lETdg7UktDkVCP9pMc/DwtmQeXbp
	d47Zib3wuCWP1eTfjFpuR5yEvHrMGniSS7PXg/74IdMo8aVvlrzk/frYeOSh5ae5E6IPNnQNb+8
	Mse48h0JpMRhKZW1ChnXETXqhkroxAseeca14KGAPRbH+BrP+PBYXkJfB+SkxlD7tWXwpzog==
X-Received: by 2002:ac8:5a54:0:b0:501:45d7:10cd with SMTP id d75a77b69052e-506092c7f24mr3163751cf.20.1770055332821;
        Mon, 02 Feb 2026 10:02:12 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-894d36c5430sm119862196d6.22.2026.02.02.10.02.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 10:02:12 -0800 (PST)
Date: Mon, 2 Feb 2026 13:02:10 -0500
From: Gregory Price <gourry@gourry.net>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: linux-mm@kvack.org, linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, kernel-team@meta.com, dave@stgolabs.net,
	dave.jiang@intel.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com, willy@infradead.org, jack@suse.cz,
	terry.bowman@amd.com, john@jagalactic.com,
	David Hildenbrand <david@kernel.org>,
	Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 2/9] mm/memory_hotplug: add __add_memory_driver_managed()
 with online_type arg
Message-ID: <aYDmor_ruasxaZ-7@gourry-fedora-PF4VCD3F>
References: <20260129210442.3951412-1-gourry@gourry.net>
 <20260129210442.3951412-3-gourry@gourry.net>
 <20260202172524.00000c6d@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260202172524.00000c6d@huawei.com>

On Mon, Feb 02, 2026 at 05:25:24PM +0000, Jonathan Cameron wrote:
> On Thu, 29 Jan 2026 16:04:35 -0500
> Gregory Price <gourry@gourry.net> wrote:
> 
> > Enable dax kmem driver to select how to online the memory rather than
> > implicitly depending on the system default.  This will allow users of
> > dax to plumb through a preferred auto-online policy for their region.
> > 
> > Refactor and new interface:
> > Add __add_memory_driver_managed() which accepts an explicit online_type
> > and export mhp_get_default_online_type() so callers can pass it when
> > they want the default behavior.
> 
> Hi Gregory,
> 
> I think maybe I'd have left the export for the first user outside of
> memory_hotplug.c. Not particularly important however.
> 
> Maybe talk about why a caller of __add_memory_driver_managed() might want
> the default?  Feels like that's for the people who don't...
>

Less about why they want the default, more about maintaining backward
compatibility.

In the cxl driver, Ben pointed out something that made me realize we can
change `region/bind()` to actually use the new `sysram/bind` path by
just adding a one line `sysram_regionN->online_type = default()`

I can add this detail to the changelog.

> 
> Other comments are mostly about using a named enum. I'm not sure
> if there is some existing reason why that doesn't work?  -Errno pushed through
> this variable or anything like that?
> 

I can add a cleanup-patch prior to use the enum, but i don't think this
actually enables the compiler to do anything new at the moment?

An enum just resolves to an int, and setting `enum thing val = -1` when
the enum definition doesn't include -1 doesn't actually fire any errors
(at least IIRC - maybe i'm just wrong). Same with

   function(enum) -> function(-1) wouldn't fire a compilation error

It might actually be worth adding `MMOP_NOT_CONFIGURED = -1` so that the
cxl-sysram driver can set this explicitly rather than just setting -1
as an implicit version of this - but then why would memory_hotplug.c
ever want to expose a NOT_CONFIGURED option lol.

So, yeah, the enum looks nicer, but not sure how much it buys us beyond
that.

> It's a little odd to add nice kernel-doc formatted documentation
> when the non __ variant has free form docs.  Maybe tidy that up first
> if we want to go kernel-doc in this file?  (I'm in favor, but no idea
> on general feelings...)
>

ack.  Can add some more cleanups early in the series.

> > +	if (online_type < 0 || online_type > MMOP_ONLINE_MOVABLE)
> 
> This is where using an enum would help compiler know what is going on
> and maybe warn if anyone writes something that isn't defined.
>

I think you still have to sanity check this, but maybe the code looks
cleaner, so will do. 

~Gregory
