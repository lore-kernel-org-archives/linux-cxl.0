Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49732BAF4
	for <linux-cxl@vger.kernel.org>; Thu, 26 Dec 2024 19:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735241138; cv=none; b=MbVZRwyFSSG7tUhV1qxwq49f3lUd2QsieLHUEjfBmbRxXEoADytVCCuHtj+aPCA3WTCCUMdVYGVYWG7Whmn8WZpia5I4h01jE6WZ41PyJXG4x8+DYLIx4joU1Qb1Qb79WWOtpKO2rt7ckG/TsDoq8dEqdJKr9liRq+RIgwej9DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735241138; c=relaxed/simple;
	bh=TavOlP1RfVMe+4JxuPyZKG1dts4hyvwwPjKtaJCZyy0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RSZNvFxHl8JYmuzR1jgtwDGYn24fzQm/hylaJaX5MDJAormC3tm/F4s/xrP5l/LQC1+OmYUKNFzBNpmWhpt4FCZvQBsSgNk8l0u1CVNTV0PWbd8Yg/RlrCe1dERfqHDg2wsbFencNGydraeS9c6mG4Sc4KdZbXHD0k10Z3kcrPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=cSUxbOyh; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="cSUxbOyh"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7b6fc5bf609so510316385a.1
        for <linux-cxl@vger.kernel.org>; Thu, 26 Dec 2024 11:25:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1735241136; x=1735845936; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bvHPT0ccY32kPKcwl8x32j2H6trMUV124nGwkwGHE2M=;
        b=cSUxbOyheMDf47Jrd5V3CstqmZZifE35gBhbABxiGWaB3Sj9OzQpZpos+Kl/ftSWTu
         T7S1jh8rHjVhiZ5MSvDoQcvkVcZH/DvB2negoTFvWaxcaT16TDssb7rK471n6Y8R5Awi
         YqdpUg7GZXp7LZM26mXZlnS7L0mQyrLDfITsLmDHw9CjCnnI4tKvjx67uF4S0DuRwY+k
         SvuIYTP6VoorhxUgH1TQDD2/D6qXUjFr3jNOwMLM32eRgcsp5HT2kshxQdlYlEXrp3f4
         V3c2Tyn+0YVbU1JEwUUKXR1+hm4WD2KprzvccznMDIsPjW6IdUrzSup7yUzLRaE56pQf
         K1uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735241136; x=1735845936;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bvHPT0ccY32kPKcwl8x32j2H6trMUV124nGwkwGHE2M=;
        b=CFolPMBg4Kms2OYGQnB5o9SwfA373k22b/RJsfQdBLWsvTv5WJo0BWPeA1SDGOGuFD
         DYIuy5t8N+1V+R7+m5nzYvR/ikagCb7frNltCk1/yxcBx97coE8S+yvdSEyoep+yn3Gk
         v0ZzGvZWgnQSvhZlGJWvDVVOVzN7ZKo3RlmTGZ1LPvtlQYO2+0vlCtUasvXa2sWhMT/+
         qwKsrMn8KoPejYjcNtrzFFZLrwx7UaUsR23LaVVVnqP6Ev9wlnKxx7PW2SxR563vGyBq
         IKXpLbgo6I5gnme5rTSm0QI8Uf9e8fmj5F+9wzeKcPA18bS946LvelkmUAPhc5AOOIGi
         TtMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWdpJDVYUqdlNQUp3TZLzbAJxHeImza+Up058EOoBIHCTS42PTQl+VReGhbEfhJRiyWUb8qdDxr6L8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQm8zM69i+KrFgTXTOwntjsqRCjbXfbutt5AdnizCxNyQHm4zh
	rZjj4D92F+9KTy0Sqrc/xczP3rMzyjC7ExRHgG3u9PdHV+pefcSEIh+qOLkRt2Q=
X-Gm-Gg: ASbGncsKHJ5xn1w9l+wJZo3gNasFWcrHdDWGxN9x0aALgNbMuAovUaLwAQYdfBTI7YB
	0Q0GQJGvznNqV5XKs7XR3n13XUl6W2vDWLPnLA/9gtr84BgELOAOGcDn5S+Qaf12uiyuoAlgnn7
	PHlv+LoDClL2lB1cCSFH0Gd7ox6z5aJpuEvn+f75Ph4gfaSCfC4aozl6GYg5feqSn32YOuVZQ6m
	GRGJD5OUXkJ3HUGjcTy9gtuNlBHKU92EvR3cGsMWALQwYLChiJ8fk0AT3a/CBy9wxCcF5FBGvIA
	YniV
X-Google-Smtp-Source: AGHT+IH8lkhAouw1RNl0FDXSDuwCUOie6f3E0Pcyb3IuuD3GIIbIaXZCil62oB59Jbf5u0tpjedBCw==
X-Received: by 2002:a05:620a:24cd:b0:7b1:11ac:627a with SMTP id af79cd13be357-7b9ba79cdeemr3532496985a.25.1735241135714;
        Thu, 26 Dec 2024 11:25:35 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F ([184.169.45.4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b9ac2bc85fsm640184785a.7.2024.12.26.11.25.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Dec 2024 11:25:34 -0800 (PST)
From: Gregory Price <gourry@gourry.net>
X-Google-Original-From: Gregory Price <gourry@gourry-fedora-pf4vcd3f>
Date: Thu, 26 Dec 2024 12:25:20 -0700
To: Alison Schofield <alison.schofield@intel.com>
Cc: Gregory Price <gourry@gourry.net>,
	Nathan Fontenot <nathan.fontenot@amd.com>, dan.j.williams@intel.com,
	linux-cxl@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] cxl: Update Soft Reserved resources upon region creation
Message-ID: <Z22toIWJfsgZJn_a@gourry-fedora-PF4VCD3F>
References: <20241202155542.22111-1-nathan.fontenot@amd.com>
 <Z1tmwOsAtL-wBR3Y@PC2K9PVX.TheFacebook.com>
 <Z1uHgePW0T81r3xC@aschofie-mobl2.lan>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z1uHgePW0T81r3xC@aschofie-mobl2.lan>

On Thu, Dec 12, 2024 at 05:01:53PM -0800, Alison Schofield wrote:
> BIOS labels a resource Soft Reserved and programs a region using
> that range. Later, the existing cxl path to destroy that region
> does not free up that Soft Reserved range. Users cannot create
> another region in it's place. Resource lost. We considered simply
> removing soft reserved resources on region teardown, and you can
> probably find a patches on lore doing just that.
> 
> But - the problem grew. Sometimes BIOS creates an SR that is not
> aligned with the region they go on to program. Stranded resources.
> That's where the trim and give to DAX path originated.
> 
> But - the problem grew. Sometimes the CXL driver fails to enumerate
> that BIOS defined region. More stranded resources. Let's find those
> too and give them to DAX. This is something we are seeing in the
> wild now and why Dan raised its priority.
> 

Hm, this makes me concerned for what happens on "full hotplug" (literal
physical removal/addition) of CXL devices - kind of like we've seen
proposed with E3.S form factor devices from a variety of vendors.

Like what happens in the following scenario (rhetorical question, I want
to test this with QEMU - but i'm on a plane right now and want to get
the experiment process down).

Boot: No CXL device is present

Post-boot: CXL device is physically hot-plugged
 - there won't be a resource registered, so I would presume the ACPI
   / EFI / CXL drivers would register one.

Event 1: CXL device is shutdown and removed
   - Is the resource deleted?  I would presume yes.
   - Is this true if the CXL device *was* present at boot time?

     If i'm following correctly ^ this is the present scenario? 

Lets assume the device was present at boot, and the resource is not
deleted.  Now we have a "stale resource"?

Event 2A: A new CXL device is added
   - Possibility 1: Same capacity - resource is reused?
   - Possibility 2: Lower capacity - resource is chopped up?
   - Possibility 3: Higher capacity - resource is... lost forever?
                    Fails to map? ???

Event 2B: A new CXL device is added on a different PCI dev id, then
          Event 2A occurs.
   - Is the "stale resource" reused here, or is a new one created?

I hadn't really considered the impact of hotplug on the iomem resource
blocks (soft) reserved at boot, but this is concerning.

I remember ~1.5 years ago I was prototyping with hotplug behavior in
QEMU and saw that it was possible to do runtime ACPI/PCI add/remove of
CXL devices - this worked.  But I didn't look at the effects on iomem
resources - now i'm wondering what happens if I try to hot-unplug a CXL
device that was present at boot.

This won't affect me for the immediate future, but if we're mucking
around in this space, might as well ask the question.  I presume we'll
find even worse corner cases here :D :| :[ :<

I do know servers with front-facing E3.S CXL devices intended for
hot-replace exist and are a real use-case. I have no idea how that
is supposed to work the presence of stale iomem resources.

> Dan is also suggesting that at that last event - failure to enumerate
> a BIOS defined region, we tear down the entire ACPI0017 toplogy
> and give everything to DAX.
> 
> What Dan called, "the minimum requirement": all Soft Reserved ranges
> end up as dax-devices sounds like the right guideline moving forward.
>

I guess devils in the details here.  I sense an implication that it's
possible for two distinct pieces of SR-providing hardware (HBM and CXL)
could end up concatonated into a single SR range? That would obviously
necessitate the need for chopping up an SR.  So this all makes sense.

But I don't disagree with the need for this, just concerned that we have
CXL-specific logic landing in mm/ and e820 code.

~Gregory
