Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE7734FF55
	for <linux-cxl@vger.kernel.org>; Thu,  9 Jul 2026 17:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783617325; cv=none; b=RHfyJlapNVb0LRe4V3L8DQWZtanCVyPEF9ju6H1q7KnksFiWpeyz91oiNTOzXRuvA3TUUu+0ivUeG5yXlLw3S1S4+qzG7Gfy9gI7/MB5UsDrxy9mnBnLQevGyf4jptIpJToi+4MkMK7RpaBXIF+Px+KIdZuznYa2OSadhZ41wCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783617325; c=relaxed/simple;
	bh=SzROYG8BwD/EB/+MUjQ4u1vhoaHs3/zZwllWfULF+qU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GU6UXce7BIR8O+P2lnuH1ru6I9Hpf/98mhtFPtXBIWOH+8njDKOCMzhmRMIJEgDF7lTRgTgaCnkQH7b2DmQDoVtCE7h8h+cUmwNr2JXGHYlEVCAiWaKLMyltkWWXNscr4zhR0066hr2jYyDVRx0RiIFmuRdggccK9wL0WZ4LtKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=gk0zhMxP; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="gk0zhMxP"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8ef1dc934d1so1159856d6.0
        for <linux-cxl@vger.kernel.org>; Thu, 09 Jul 2026 10:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1783617323; x=1784222123; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=46UkRwT/i/djJx+KopbYZyKUrVPhRVpwIJdu7TzJpII=;
        b=gk0zhMxPCwdMeia9k1VETsBkdLdlSUiHgtr/lxI34cIdfLJu788hSwNC4UXQj5RHLF
         mex7yejvsPB2SSYb0a4ATL4mvLDHXVUcofAXP/G3aV+/e0HzaKcNf7cLVkkR85oNiD9m
         LoDWnj2LMAt7utzVlJ+XOrCTJtE7qaFqyJFxZygEzxhwSHJrCxDozHyHA1XvlQH+Jrbc
         imd7n4XXsQhloWf3R6EbXswShRm0e35oZVkp68wjNPOA5N6uqxNHp9O3nOq0N97Y+El4
         7JS46cJLFNDyaPU2IWeXp0FUfg5eqh6HlWZMjjHIIOI/dAnwK60yX0GXfS4seLtNgcRL
         L6tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783617323; x=1784222123;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=46UkRwT/i/djJx+KopbYZyKUrVPhRVpwIJdu7TzJpII=;
        b=FOjOxg16Re05AyhfUZ8GhowQ/u3wefF1tJ1Bbg4Y0oXnetk/JcH/Kd7Aqy8abKEO4U
         780EB9J/xSnBbe3ASp9f1fJwMu9FJyMLJUBtoIscK52k7IfRcqF2UHyRnG12TFKxhRqC
         mhKZ9+p8ZcVnyyhqRZibguGRJ0sZN9JCl4adcKINRoCAkBZdc6bJ688/YVuBIIJ85q8A
         n9ef5j9Q49eh6Tre6ZjYOWjLw4OHunHAh0wJjNl0E/hUneOV0/2JKVHaEWIuJEZXAfqA
         kAviwXUvmsfq77qR4c7PVDRQ1pBMkUfEKu/GkcA0w7sId1LEvun8I4/hz8JzS4La2cnh
         OnGQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr8H2Y+RpIJfq8DIhJyjLLc2tiZ9PB4DKvNsNK35q5l10zuIva77Uf7/nGLB1mcGQHFgx6Wa1rJvbU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6kNh8nVShavKA07BMgdp6wpTohhaT7GXPlGqyvhg/OWGYWLUw
	miuKsEfPi8Xi7Slp43kUkftOAUL/X1M8UCw5DhWTdwOgUTPdGAsJvs0j7iL+vzgnl+M=
X-Gm-Gg: AfdE7cnd55t4mNaP4GVrIi7KFxQzC4NIM437lEVlbwaeDP1wXEcsFQaRP5/x7GpGHsJ
	j/xgd2ZoyZZ9IXVrGJ38R3k0rYV50h+sRIr+qM6GaEPiPwIJmZg36wmc0sSczFpWC7o0fhXsBxT
	+gFbEXb3Zl4UbmeEMeXLHuPGhPMdByTfVSH39dMgCfe/ST56GGNa2txIC4PqEBD0tqHeuD8MBlF
	p5iQ2pRmPQS1+Gavnrd4cDwIJ8BTbwlpYdJQaKtPI8Ha0NUi/auUP7INPRcORX3WILj0TfMnpK1
	CzC8k7dCOexx1NkegN+TUVnwR02hmuFrgZNp31so0seuVzZniWE1LK53pP+OTD9nZ9dqpT2d/2E
	ZrC0kruAeqcIMnctXrler3gFeKwHHwuBtJmaNMap687Jh0PyNlRheoVmeibQKo0yWtUUYiJ67E6
	PJtzYvBceL/Xtf+/N5pelxvbcxB+qgF31fWMtmS51ZUcYivBDgGxiHdExHJum7jCFq9AtT
X-Received: by 2002:a05:6214:6014:b0:8e9:f45f:107b with SMTP id 6a1803df08f44-90242143c3amr1641696d6.34.1783617322803;
        Thu, 09 Jul 2026 10:15:22 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd7c1d8fcsm22085656d6.25.2026.07.09.10.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 10:15:22 -0700 (PDT)
Date: Thu, 9 Jul 2026 13:15:17 -0400
From: Gregory Price <gourry@gourry.net>
To: Richard Cheng <icheng@nvidia.com>
Cc: linux-mm@kvack.org, nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
	driver-core@lists.linux.dev, linux-kselftest@vger.kernel.org,
	kernel-team@meta.com, david@kernel.org, osalvador@suse.de,
	gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org,
	djbw@kernel.org, vishal.l.verma@intel.com, dave.jiang@intel.com,
	alison.schofield@intel.com, akpm@linux-foundation.org,
	ljs@kernel.org, liam@infradead.org, vbabka@kernel.org,
	rppt@kernel.org, surenb@google.com, mhocko@suse.com,
	shuah@kernel.org, iweiny@kernel.org,
	Smita.KoralahalliChannabasappa@amd.com, apopple@nvidia.com
Subject: Re: [PATCH v6 06/10] mm/memory_hotplug: add
 offline_and_remove_memory_ranges()
Message-ID: <ak_XJWglABmKfSiU@gourry-fedora-PF4VCD3F>
References: <20260630211842.2252800-1-gourry@gourry.net>
 <20260630211842.2252800-7-gourry@gourry.net>
 <ak9ee95F7pJpCKMo@MWDK4CY14F>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ak9ee95F7pJpCKMo@MWDK4CY14F>

On Thu, Jul 09, 2026 at 04:45:51PM +0800, Richard Cheng wrote:
> On Tue, Jun 30, 2026 at 05:18:38PM +0800, Gregory Price wrote:
> > +/**
> > + * offline_and_remove_memory_ranges - offline and remove multiple memory ranges
> > + * @ranges: array of physical address ranges to offline and remove
> > + * @nr_ranges: number of entries in @ranges
> > + *
> > + * Offline and remove several memory ranges as one operation, serialized
> > + * against other hotplug operations by a single lock_device_hotplug().
> > + *
> > + * This offlines all ranges before removing any of them.  If offlining any
> > + * range fails, the entire process is reverted and nothing is removed.
> > + * This provides a fully atomic semantic for unplugging an entire device.
> > + *
> > + * Each range must be memory-block aligned in start and size.
> > + *
> > + * Return: 0 on success, negative errno otherwise.  On failure no range has
> > + * been removed.
> > + */
> 
> I think this can return 1, and it shouldn't.
> device_offline() returns 1 when a block is already offline, and phase 1 passes that value through as-is.
> 

I just realized try_offline_memory_block() already clamps the value to 0

static int try_offline_memory_block(struct memory_block *mem, void *arg)
{
...
    rc = device_offline(&mem->dev);
...
    /* Ignore if already offline. */
    return rc < 0 ? rc : 0;
}

But this is a bit non-obvious, let me see about making this a little
bit clearer.

~Gregory
