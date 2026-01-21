Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BB63A7DE9
	for <linux-cxl@vger.kernel.org>; Wed, 21 Jan 2026 23:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769037196; cv=none; b=Td878xXYeeaX/U38N02Uh3JiyWFtHQ7Y2DrJk6IzU/SJHxHIfrYMANnSTD77/cuKpwqvEBPvXScNcWwNNrlCGGPdarGVwrdEEMxFBFr+RZBivJWPoDaveuKsBzqRLNtEwxzrue73nMM7YtD+iK1lirSbxTg+IzIPsTwMdoQChMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769037196; c=relaxed/simple;
	bh=JKWGv2QBEpr9NraO7c0DMd4m2jNrvXSOqOxT/ZV85mg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GQ/zXscDMLa1ypK+md806z8LPqOE/3r2et9BbEdtj1llOXdt5vsBLhEc9qknap+bQfiYmafje5eZRu2fh4EMXvdYZjNQ6tLQFVR42W0Muk10DslNRgOFjBYPfBx03evwwwcD+CEHlYdoik+EPmW/f81IpmOtgNj2r3pZWExX9Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=aJuqbDkA; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="aJuqbDkA"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-501c6665144so3447951cf.0
        for <linux-cxl@vger.kernel.org>; Wed, 21 Jan 2026 15:13:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1769037193; x=1769641993; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IquXnFFosZlOyNmK6bSXL9iR+BIWvsTphuu77XAlhOg=;
        b=aJuqbDkAMeJVzj6D8vY+dtweIDQj3r4yFU42WLysjClCO4/aSSHMGWcrrnj/OXqTUS
         XhGE0M+YNeu7QWGL3TJZICBd5/oQBM/w7ohcC2c2BX3CF1DUk59GjJBW3enktFfT4Ykh
         jH8G4YKyh65WwTW8wPIHqtnoflLn9eaevHYvTYYE8ZJwAdi8/WlsH13bpX7eOLjQRzG1
         kE/awANmNkMhZvcNyZ5Rl3NooNZVbk8bXsNAmeRujB+oirb03b/mG+sxLJKQ3L6+ztOM
         AFIY6oqQCYzBPGQYWcg4ow7sq08XUIrDUF6YjVeRAx7kN99Dd39frGx7izpbN2QZyGLe
         PpHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769037193; x=1769641993;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IquXnFFosZlOyNmK6bSXL9iR+BIWvsTphuu77XAlhOg=;
        b=CebXvAiSfQQv3tEabGqFlBaaCRKpRS/ZeDRBn4iMtkT7Bywow9zpOFr4gCdSq3iqJ+
         jJi15cV78MUSwTHSaMfeDNSjCNNxfuCDFtB1RcGQQ5/1RtKAp9XXEHWyg1D0d9Ca30Bu
         g+s2i+lWfiUEdMsNxFi2monli4ziyeoiUPsx9G265Ndy0SDJ2U9ssaRpct+aX3o8jvxH
         q6oxtJ8y68XaJXduBB+lKK/44YTlc/DYVuEK+xNTLX7YH1w/DTwCqkcQxpqaOAqtlslN
         91peHhcxhP1jhMOI50xORzVK4Q5B9a5K77qXEmNgAgLBUzC2QDmTdWQIoNOdPG1y0C+3
         D0VQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNNZi7sTBHAu7t9Boprk8l838BDYPyqGn/oWIHfyTmgIAkCTjniEolVHNbx2O7iUGViS31vardMgE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMF9WuQKSX7imitLlSmi3yidkQWmgUFct+gibNRsmkJ50X6OFj
	Ewu0xbRhTb+XyBaF8SiyDys6UJRxV41GYpsDoY/AVicAAYIFkpESoUq4XqhTTwAAqbE=
X-Gm-Gg: AZuq6aLa3kU4ZltuBgSILyV78+dUU7SOZ2sG3vtQj58GPekNj9Be8HV9u+u+C5WdBD/
	1MuW42Ote6LcPZ1OLaEHw0dtqX8PeQHnkrxFTjenCUPLq4ljfdwNq6uHCiav3NRvoy6IPNXK597
	yB6DyVq0jLYcSTpU6zMJFovolyp1+CJ9mboNlLu78vAlMHKDiAA9LZ18NAY8gpjTlAgndBPgT/y
	OkydtCMKTZ7ntr7ohV5IG/5byYP/8d5Ujx9fnJbD+VNJuESn0yrRoN8AKhmefbMaYFMXnRswp9c
	bD61WJPfGfXlWDkD7ZHHtLzD5dXM/Z50Xn+Mmaair4ISKtRBIXRKpszJFXcz8cNE1KUS0Be/vAB
	CMn01+oUSRY6Df2+gZ6LA0fFZsaXea4bY8MB5QXIkY2mb03DiRifG8h8n//Djmm5+a6cmFV5Eq/
	fBcQZsm7m5occaXPYzYR9+d62WeX7Hgn2w2sMMkycdheg/WFv0WfCdOLZtqF0YA2+bKIGKMw==
X-Received: by 2002:a05:622a:38b:b0:4ef:c4de:2ac9 with SMTP id d75a77b69052e-502a1dbcb2bmr223833141cf.17.1769037192645;
        Wed, 21 Jan 2026 15:13:12 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-502a1f1b872sm117818431cf.31.2026.01.21.15.13.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 15:13:12 -0800 (PST)
Date: Wed, 21 Jan 2026 18:12:39 -0500
From: Gregory Price <gourry@gourry.net>
To: dan.j.williams@intel.com
Cc: Yazen Ghannam <yazen.ghannam@amd.com>,
	Robert Richter <rrichter@amd.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Dave Jiang <dave.jiang@intel.com>, Ard Biesheuvel <ardb@kernel.org>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>,
	Borislav Petkov <bp@alien8.de>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	John Allen <john.allen@amd.com>
Subject: Re: [PATCH v9 10/13] cxl: Enable AMD Zen5 address translation using
 ACPI PRMT
Message-ID: <aXFdZ_uzXJ8shieZ@gourry-fedora-PF4VCD3F>
References: <CAMj1kXFhBdCPW_+xPR-TmU4M46Jr6DGwtjUtjDQ0EbgPGmL7vQ@mail.gmail.com>
 <20260114180859.00004623@huawei.com>
 <20260115080444.GD830755@noisy.programming.kicks-ass.net>
 <CAMj1kXENYZq-UkCup6FSH_4tmpRe4xJN1_veuSWs-hxxAo=1Ew@mail.gmail.com>
 <20260116143838.GC1890602@noisy.programming.kicks-ass.net>
 <aW5AvfcjLkSP2j42@rric.localdomain>
 <20260119160342.GA659351@yaz-khff2.amd.com>
 <69701f6de978_1d6f1001e@dwillia2-mobl4.notmuch>
 <20260121145817.GB1784626@yaz-khff2.amd.com>
 <69714e9728d2d_1d6f10075@dwillia2-mobl4.notmuch>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69714e9728d2d_1d6f10075@dwillia2-mobl4.notmuch>

On Wed, Jan 21, 2026 at 02:09:27PM -0800, dan.j.williams@intel.com wrote:
> > 
> > I see. So the concern is including model-specific methods that would
> > modify the CXL standard flow, correct?
> 
...
> 
> As I told Robert, I want a generic "Normalized Address" facility of
> which Zen5 is the first user.
> 

Isn't that what this patch functionally is w/ a specific PRM function?

   rc = acpi_call_prm_handler(prm_cxl_dpa_spa_guid, &data);

Or is the request now: replace this with static table data?


point of ignorance: what facility would you use to expose such tables?

-----

When i initialially hacked up driver support for this mode before
getting PRM support, the "hacked up translation code" I was this:

  /* Find 0-based offset into whole interleave region */
  dev = (pdev->bus->number == 0xe1) ? 0 : 1;
  offset = (0x100 * (((norm_addr >> 8) * 2) + dev)) + (norm_addr & 0xff);

  /* Find the SPA base for the address */
  for (idx = 0; idx < cfmws_nr; idx++) {
      size = cxl_get_cfmws_size(idx);
      /* We may have a gap in the CFMWS */
      if (offset < size) {
          *sys_addr = cxl_get_cfmws_base(idx) + offset;
          return 0;
      }
      offset -= size;
   }

------

This makes hard-assumptions about two things:

  device interleave index  - pcidev(0xe1) => 0
  cfmws base               - all CFMWS are used for this one region

cxl_get_cfmws_base() was a call into ACPI code, and the acpi code just
kept a global cache of the raw CEDT CFMWS structures (base + size);

So, assuming you had such tables, it would need to be like:

                  Normalized Decoders Table
    --------------------------------------------------------
    | CXL PCIDev | Decoder  | CFMW SPAN  |  Interleave IDX |
    --------------------------------------------------------
    |     d1     |    0     |    1,2     |        0        |
    |     e1     |    0     |    1,2     |        1        |
    --------------------------------------------------------
  --------------------------------^
  |            CFMW Index Table
  |  -----------------------------------------
  |  | CFMW ID |     BASE       |    SIZE    |
  |  -----------------------------------------
  |  |    0    | 0xb00000....   |     ...    |
  |->|    1    | 0xc05000....   |            |
  |->|    2    | 0x100500....   |            |
     |    3    | 0x200000....   |     ...    |
     -----------------------------------------

-------

The code above turns into

int cxl_normal_translate(pdev, norm_addr, u64* sys_addr)
{
    int i_idx = cxl_nrm_decoder_interleave_index(pdev);
    int span, i;
    u64 offset;

    if (i_idx < 0)
    	return -EINVAL;

    span = cxl_nrm_decoder_window_span(pdev);

    /* Normalized offset into whole region */
    offset = (0x100 * (((norm_addr >> 8) * 2) + i_idx)) + (norm_addr & 0xff);

    /* Find actual CFMW Base (might cross multiple w/ gaps) */
    for (i = 0; i < span; i++) {
        u64 base, size;
	int id;

        id = cxl_nrm_decoder_cfmws_id(i);
	if (id < 0)
	   return -EINVAL;

        if (!cxl_nrm_decoder_cfmws_data(id, &base, &size))
	   return -EINVAL;

	if (offset < size) {
	    *sys_addr = cxl_get_cfmws_base(id) + offset;
	    return 0;
	}
        offset -= size;
    }
    return -EINVAL;
}

Where the cxl_nrm_*() functions just query the exposed tables - however
that actually happens.

--------

I don't know whether the above math is actually true, it's basically
just the simply interleave maths. If something else is going on, then
this whole table thing might not actually work.

The rest of the patch set would more or less stay the same.

~Gregory
