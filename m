Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4081D2EB873
	for <linux-cxl@vger.kernel.org>; Wed, 14 Jan 2026 17:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768410745; cv=none; b=AEGc77ctAZXi/z26JO/VWPMUO0i5CVhVfT86WSOBrvW0CaJbzhtfVua7xQp9u/TCIreL3lPlag8tbgcEVi3kmdaBJOJpWzVk2xk+NWzMasuBZ8ZgQPBue7i65NX6lFJDIfUWoXmoqOBGvE9bmhRzrYN/qys6bOGUkgna2L1WpZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768410745; c=relaxed/simple;
	bh=p77GEG+mB5piIaHLHG+aeaef+IL/MBZBpezD3NGQ3tE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=stewVjQcITxFWQTcbqihK+6n/UQpRRNKXo6hGuTzZzSv2MdWaO53a7hvJYoK5wj0JIa6UJ2SAn/+him/pSkagJ4TfDD5a2bBIv8qB+h29aLXKMKM4fGE5MNJWHOp/gFtkPiJ9SpG3k5nJOQVMhQ3Rqz7PWtuoMpijBkOfNZyOmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=s2jof0uC; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="s2jof0uC"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8b29ff9d18cso2865485a.3
        for <linux-cxl@vger.kernel.org>; Wed, 14 Jan 2026 09:12:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1768410743; x=1769015543; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cLZK+PqSn6nIdPCyk8+Al7PM0O31XRvufO9b7gKXcTo=;
        b=s2jof0uCl1iZ13S42/5fpW0CtM5ymEri39FcjNMund88KbT8hu00kIYh+zLBIqzqnn
         +4tjMImmWWIy2S1mMnRbFXVBHgdyphuAXMJ7fdnysBq9DuwkkJwFd7JbH2CTQiRLtm37
         7m7xKy0P7RCzSsHF19q7MeLNfFRN4D9DPmD8XClJosItg/yyi73x1LqR/YBJOtYxMNl8
         kMoxg/lk2fHrTFmU9EEL9C1IiXWogCnMraHl38L3kfyAefaNSjwGphgwPDNL507W6+cA
         R9El/Qs8uvqAcv1QlLil33zTXza0vGN2DeQ6Q2YShPwOt/l1YKhGLqRMEttJsY/9qKl3
         qQfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768410743; x=1769015543;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cLZK+PqSn6nIdPCyk8+Al7PM0O31XRvufO9b7gKXcTo=;
        b=HLQrD0PXAq8mv8u0T5SZ1/WFTPsfcC9v1uzu/KRTnTB0MN4KO1mN9AW6HS8AydVd1S
         eer77Icun1biUzYxCFzj+xDh0xKVsnqX7zQDGqcB89GABHJAb/+df93ZIVJr0fr+/By7
         JUTR3HP0mYPhTQw1cjV8TtnAaxrM+5D5gnVVSod4P6Ur5IDR0zqhp0d4/FuK0g0QxFiY
         sMM9Sy3EwvlCHGNTvgNeg1UYIx/iZNoJ41T9K1E6beemGlaGlnX6dZGDWr7X72cieL4z
         rgq+5f1sf8xvLoVDYwAQxJoc0WlAN+1pANa2qVCU35WZXryv6Ia9Ewvcy1C33QLtZ09d
         KZog==
X-Forwarded-Encrypted: i=1; AJvYcCV9QHYvRQANXyxtEsj9IysimFg/X5GIIRgLtNJ4ql2M642dLYD+N2xfx0ncVkJKaOAhqtKo0960kPs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1+a0g4U4KM40jCo5Y0860XlI9JxWw8IWWOTpxDgAx/ctYVLrC
	YSCUO7Ob8E7kN2X6pGO/F4MoPSAo+OaAPyVGql5h3Z8LO3aks/kc934rYpdoIknHXH7xGMaN5fl
	NP1ods0Y=
X-Gm-Gg: AY/fxX57AzZJiTUe4MEhwdFK+TiWfwDiW/VLNl/xGIj4Hpq9KPVXWZxdktv4a5rybc1
	yBdi4Q/rhH7LpwPVrFTpdxN/u+Vzsf/cBOyUp9S7/kDseMvmFUQGS8EEnEEgQyrsqBi+WxhqkVZ
	Fs2Lc7IZkzAORkGBU8ClbSihzSPOi3lwmQjZCmxrsmtU8gowRnYRqYEmsBmn0Yu3Uix+JnFYDVs
	TIVEgXrfUyYGwGB6TMfzqpdhxxzuxTXWaaJ0Y7OaM+BL5lKYbDbsRkmt4yufbeeUcI5qI3WpYFC
	zuFS8rusLFONAFFleoI+WHgkot1u1ecDhkdp69gJsj+WttDA90ydHg69u2yfxqPMj9GaHOfR4rY
	HlT0xr7fM4QdW/DD5BX3ggSHyLBISIn+a7tMkvdIo9DaPleGsg9YKVkpsOiZ5oHppoHIelcdHd9
	53VJ2fgZNxf6IeqQhQEwNi2N26Y3Dd+mDuSOx0x4SDbPHdn1PMVBmwKHU65OTRkaxGCrbdes7LJ
	DG2Ie7H
X-Received: by 2002:a05:620a:f03:b0:8b2:d6eb:8203 with SMTP id af79cd13be357-8c531808de8mr358190785a.69.1768410743009;
        Wed, 14 Jan 2026 09:12:23 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c530be76d1sm201549285a.48.2026.01.14.09.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 09:12:22 -0800 (PST)
Date: Wed, 14 Jan 2026 12:11:49 -0500
From: Gregory Price <gourry@gourry.net>
To: "David Hildenbrand (Red Hat)" <david@kernel.org>
Cc: linux-mm@kvack.org, linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
	kernel-team@meta.com, dan.j.williams@intel.com,
	vishal.l.verma@intel.com, dave.jiang@intel.com, mst@redhat.com,
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, osalvador@suse.de, akpm@linux-foundation.org
Subject: Re: [PATCH 2/8] mm/memory_hotplug: extract __add_memory_resource()
 and __offline_memory()
Message-ID: <aWfOVd3_GGTNHKNt@gourry-fedora-PF4VCD3F>
References: <20260114085201.3222597-1-gourry@gourry.net>
 <20260114085201.3222597-3-gourry@gourry.net>
 <c4ed9675-269c-4764-86d5-87f4f83fc74d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4ed9675-269c-4764-86d5-87f4f83fc74d@kernel.org>

On Wed, Jan 14, 2026 at 11:14:21AM +0100, David Hildenbrand (Red Hat) wrote:
> On 1/14/26 09:51, Gregory Price wrote:
> > Extract internal helper functions with explicit parameters to prepare
> > for adding new APIs that allow explicit online type control:
> > 
> >    - __add_memory_resource(): accepts an explicit online_type parameter.
> >      Add MMOP_SYSTEM_DEFAULT as a new value that instructs the function
> >      to use mhp_get_default_online_type() for the actual online type.
> >      The existing add_memory_resource() becomes a thin wrapper that
> >      passes MMOP_SYSTEM_DEFAULT to preserve existing behavior.
> > 
> >    - __offline_memory(): extracted from offline_and_remove_memory() to
> >      handle the offline operation with rollback support. The caller
> >      now handles locking and the remove step separately.
> 
> 
> I don't understand why this change is even part of this patch, can you
> elaborate? You don't add any "explicit parameters to prepare for adding new
> APIs that allow explicit online type control" there.
> 
> So likely you squeezed two independent things into a single patch? :)
>
> Likely you should pair the __add_memory_resource() change with the
> add_memory_driver_managed() changed and vice versa.
> 

I tried to keep the refactor work and the new feature work separate.

But yeah that's fair i can just add them to the respective path.

> > +	/* Use system default online type from mhp_get_default_online_type(). */
> > +	MMOP_SYSTEM_DEFAULT,
> 
> I don't like having fake options as part of this interface.
> 
> Why can't we let selected users use mhp_get_default_online_type() instead?
> Like add_memory_resource(). We can export that function.
> 

Wasn't sure if that was preferred, I can do that.

I think i eventually ended up doing that in DAX anyway, I just never
came back around to clean it up.

ack.

~Gregory
