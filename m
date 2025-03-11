Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C02232C8E
	for <linux-cxl@vger.kernel.org>; Tue, 11 Mar 2025 16:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741709728; cv=none; b=nP4RAb3ZsGKXh6lJh7cEp00gUSr9pV21j9UJ3YP1Uorx1Xf0cm//JYx7kdVLkSU2A7vKFF1ZlCaiOaH8mqmu6lneLO7dtR995We6hSLKv40wAJQK5yfSRYEwehYQSyj/gBjX0XZM/cDVkgELS0r6l2BTjjfE31LKwGaRJyjsik8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741709728; c=relaxed/simple;
	bh=y9NcK49R6V3WQBMU/3Bd8ThsPavXQqygi3RvWAeH9gg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=POzkU1E0M0W1HbtRj7RKs74LACJxRo5hqQWih76K8f8gBXX6En+JA5kNOwgP0oVoJi774RqtHPLftCavWpSKj4SkpxbdA7QlgzuQpQT/sJ89Vo0olGavCu6yWIds/mJmPWbiD+jZBs3KX7dBTi+1HTRylw55WmyV7Z6Kvn92NBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=jPFxb08y; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="jPFxb08y"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6e900a7ce55so61976146d6.3
        for <linux-cxl@vger.kernel.org>; Tue, 11 Mar 2025 09:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1741709725; x=1742314525; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+ctWxbKDFvJQjTOqLK3W0WOLogRld+0VnOA3SYeJG4o=;
        b=jPFxb08ysrsT6ixCkbd/80JbbbixvuIHBC6Kxxt99wAk4oIp+LDkCdtdKql+jL3mAc
         tJp+yHaY+vKwN8G5nLUPwiJ11VfbN4MhYP+5ems1Qa3zBmmZdFJuRemy3ZgteWVzyX81
         EICgGLKDs5GRuKjok7FPs64qzoDhZhka0aqt4ZyxPGibAFXd7yLcDHLfzwxbhWT+qeUM
         yagttXYVW1syCBpeZKsaRjrjvGrB+TkyWQUXIhLCNuii7w1RZuwO9YMZN/RxdW+ckwdw
         nDw7i0sqnfw/9u1CVbf3cySslnYLQWNBQoiAKORkGe5+ZpxTSenwvSWxGST9ZSdqyepT
         eTYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741709725; x=1742314525;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+ctWxbKDFvJQjTOqLK3W0WOLogRld+0VnOA3SYeJG4o=;
        b=IBlYJs5QDkeiZ8JtD/RSTaYOqzsOfgp3Jvq8GdjtCGqUDxsGrWFQ+2Rcb1bApnvz6D
         KFqEdFxDTUjADaQWuNnk9lzE5rFHMWcVJkHZA+tkWeuIHoBKDIUmLVESOOprN35GeAmw
         NF+g2xIqD4VjXOpEfWCGCZY9PyQ9+TwgJscaowTPLXOM6C87q1dH17rknnCHEibegG6x
         8fDCwjVILAbQFCROcnOT+Pi8CYgSVdjK1sRtbTt7YwrtpZzSo/k4XrJ7ykAB3o2IwlKZ
         EsIfypca0/Jewmw4jXJceLPldqqvGse1HugkfO2mn+NhTgDeCrysZGNud4Uxd1MRaLzN
         KTTg==
X-Forwarded-Encrypted: i=1; AJvYcCUnvvzVDR4veFdDfnoAc3e8Ovy7f4QUOrslH1epGD/J20/D9V2zQW4S2VH7WdeBCeAEA1MdOeU6+t4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuIdKhf9GMCl/Nz7SnqwaTuXrRbULRvkDfEh3t9KWZzeuaaxNT
	Doe+QovvgfPlhVez5QMT750JU4ajuuZ4mTp/qPTARYWNyDehQzJ/je/IiKNLUMc=
X-Gm-Gg: ASbGncs0uj/hXqqPCcgS8i4hiJtH3uvYbqlWcnl3NuV+4MLKpFzqI8RS9xHY8hBpYm8
	ONbLqgEzyWrHpoeSx/VjGoOGbaAEpqv0RcvwxaGq7gNR/zQRau2lpHW4GaEXv8UxIjFA831XCVH
	klyGczYYYWsiw34z6BPMmURg9L+p2xZX8mWT7+GnrKJB9tdgPXplO2FYn92+14fRPqPDoz+65i1
	B4rxRT6b+6rNOuiyCrjlErO1kJ7LvFhiwwYQK269yP/a0SU4lidrohjpbs2oB1Z7sjWUgh5Y0kJ
	i7fFxG6fDOmGG+8+YlC8h4pD2Mbafh6M/ycCYaFfXdXzVq0aKMf3iAT98IPlneIqBEkdeNfn4wI
	VSCeNrs0LrEs8yJdU0UbOl4qHEFI=
X-Google-Smtp-Source: AGHT+IEngW+whjtSsGen92TRPPuxKluaJqI8wEtaAWqqtJh7Qsb0QErvZ+cCKG9luxZznTxhTIBdSA==
X-Received: by 2002:a05:6214:c64:b0:6e8:f65a:67c5 with SMTP id 6a1803df08f44-6e90061f684mr206274106d6.11.1741709725208;
        Tue, 11 Mar 2025 09:15:25 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8f7094611sm74058526d6.50.2025.03.11.09.15.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 09:15:24 -0700 (PDT)
Date: Tue, 11 Mar 2025 12:15:23 -0400
From: Gregory Price <gourry@gourry.net>
To: Zi Yan <ziy@nvidia.com>
Cc: David Hildenbrand <david@redhat.com>, Yang Shi <shy828301@gmail.com>,
	lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: CXL Boot to Bash - Section 3: Memory (block) Hotplug
Message-ID: <Z9BhmzZBOU3NyTkR@gourry-fedora-PF4VCD3F>
References: <Z7TLwtQY3vGUw2bO@gourry-fedora-PF4VCD3F>
 <1b4c6442-a2b0-4290-8b89-c7b82a66d358@redhat.com>
 <Z7TswQbpPV590ADr@gourry-fedora-PF4VCD3F>
 <bda4cf52-d81a-4935-b45a-09e9439e33b6@redhat.com>
 <CAHbLzkqDQcrHLPzk8n0SMgkidH2ByCqdwfYXX=uBPQfOArWf8A@mail.gmail.com>
 <Z7d3vVdJ8UWU5oex@gourry-fedora-PF4VCD3F>
 <4ae838ee-b079-408e-8799-e9530ca50417@redhat.com>
 <0C5749C4-B3EE-4393-A8EA-AA56B399E9E3@nvidia.com>
 <Z9BdwFZ-ZRpMSabG@gourry-fedora-PF4VCD3F>
 <7A60A7B1-0BFF-45ED-8A11-06F0D5286723@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7A60A7B1-0BFF-45ED-8A11-06F0D5286723@nvidia.com>

On Tue, Mar 11, 2025 at 12:08:03PM -0400, Zi Yan wrote:
> On 11 Mar 2025, at 11:58, Gregory Price wrote:
> 
> > On Tue, Mar 11, 2025 at 10:53:41AM -0400, Zi Yan wrote:
> >> On 20 Feb 2025, at 14:26, David Hildenbrand wrote:
> >>
> >>> Yes, the only way to get some 1 GiB pages is by using larger memory blocks (e.g., 2 GiB on x86-64), which comes with a different set of issues (esp. hotplug granularity).
> >>
> >> An alternative I can think of is to mark a hot-plugged memory block dedicated
> >> to memmap and use it for new memory block’s memmap provision. In this way,
> >> a 256MB memory block can be used for 256MB*(256MB/4MB)=16GB hot plugged memory.
> >> Yes, it will waste memory before 256MB+16GB is online, but that might be
> >> easier to handle than variable sized memory block, I suppose?
> >>
> >>>
> >
> > The devil is in the details here.  We'd need a way for the driver to
> > tell hotplug "use this for memmap for some yet-to-be-mapped region" -
> > rather than having that allocate naturally.  Either this, or a special
> > ZONE specifically for memmap allocations.
> 
> Or a new option for memmap_on_memory like “use_whole_block”, then hotplug
> code checks altmap is NULL or not when a memory block is plugged.
> If altmap is NULL, the hot plugged memory block is used as memmap,
> otherwise, the memory block is plugged as normal memory. The code also
> needs to maintain which part of the altmap is used to tell whether
> the memmap’d memory block can be offline or not.
>

Also just to be clear, this is only an issue if you intend to use CXL
memory for something like 1GB Gigantic pages - which do not support
ZONE_MOVABLE anyway.  So for this to matter your system must:

1) Require smaller than 1GB alignment for memblocks, and
2) ZONE_NORMAL CXL memory.

The whole thing is mitigated by telling your platform vendor to align
memory base to 2GB and having DCD's allocate in 2GB aligned extents.

Both of these are reasonable requirements for hardware, requiring a
major kernel reconfiguration seems less reasonable.

We should continue talking, but I've reached the conclusion that simply
telling platform vendors to fix their alignment is a better overall
solution.

~Gregory
