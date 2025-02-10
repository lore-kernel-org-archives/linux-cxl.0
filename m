Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76DC62595
	for <linux-cxl@vger.kernel.org>; Mon, 10 Feb 2025 02:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739154838; cv=none; b=EHk5TyRQ3tTBxvndse+eWs8SA6dwVYeigj1hlr9ipFNnLqdlsrWjsnzAdwNsgpd6kgmO6QTkV7UnPYTi6iYTzEjGBqOeGCmbwMVjDDfd6mN25QT/0t9eeuZBQ0NDZcSWLPAyupOzIMTCEZKrV6QmvIvrNhPbHkvTlRH3RtZb9xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739154838; c=relaxed/simple;
	bh=IjFkwAl2Y6c5mCJ/LxqC9CAIFshXQ2y2l0FFUZGFQa8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H20qU0TNKeyapSUK4QZnv5jmsxI61BfaJO1JL4JEYJW3uadkS61XI0RMRUxOjcVkCnZHcH9GmLD1pdGbmH9WgGXw+RsguEMA1xIsyK4875sWrIwsRM3RLI8rfY6aM8+qr8QN3j8fDpy2acnks6GDfozBrmYIOJigJnmns9+VYJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KIxpysRS; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KIxpysRS"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-21f0444b478so54330905ad.0
        for <linux-cxl@vger.kernel.org>; Sun, 09 Feb 2025 18:33:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739154837; x=1739759637; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2LHy9O0Q+cIdK9P5Oe27RcBt/wwySHmUVPiYjBKRzVU=;
        b=KIxpysRSROt0AezVh94f2C0TEeIOp+9GofMRJMXrX1tH4Pbov8wjfgrgMLzhvCObMc
         j5RtQFtE1wUDkunM/ATlkKiYVsT9WrOSEiyLDSW8n44/nNHnuravKNJDkK85WN8g7uP0
         l9LnYWUKTT/Wal/l89lL2p+eWokqJiJc/pJ7b0zWopplO0ii0UO8nr0wvpBadJwyDzbR
         y8pgmiHu69+xCoop+UTvgGQwMwb/VobvE/pFOIRb2Q7OeNZiBucZeYOoEk1VahgzmFt9
         X0z2FKlHi2RxSuXNDEKY5uqg0Vful0qpR/Ca78L18GbqsZg1psJ3eQK70lqgvcLZGKhS
         tTAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739154837; x=1739759637;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2LHy9O0Q+cIdK9P5Oe27RcBt/wwySHmUVPiYjBKRzVU=;
        b=b3uWjazFqylpHoevssgIkm6O4ingvDjrNzlhbx/6U9jgt8E/u0+XyXqyLGv5G4ol0S
         XYikGu0gvtuI3zlXzmaREkI7UI1pJyEr/Az4pD9eUD4CPKsq+gQARnyxuTSdN8dTAiiz
         lTXJUPFH9Sm6SyLv8vPA9zXfOFb785RnHrfb5pvX8CEL0cQa6CEBNdM8/QdNORZoMcRe
         6Nm23fvNlPcBJUr7tQTOfUV81RAXNLG0nnvLLrQuKw1tqWaVt6KYcbJOH+xn12mbKew9
         mHAsM2abyyt0fglIJEdek62H/2mcrrVn3Vr5WFOFg7lSGjVfVVa8CV5R800Xb0aLre/J
         Qexw==
X-Forwarded-Encrypted: i=1; AJvYcCWw6s7modrUkSFFB3Hl2Jj4ok8TU5LLal8V/pFf0cVN4r1f4rVAUSsPQRjvrIhyUhrurw1zs/Di9PA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSf8Q+yiNzG1D7E+R9Q1+GuY4uTlvbUO2fjJxkbIdRsO9JDZb+
	wl2QXzwHgH9yaxM7QtY0FkgUfD3f0AxZSXsKQJUf4U7nb/YyufDW
X-Gm-Gg: ASbGncvpaO0REj/dKDiozif5dNdFEq0HOhaIIxSoAyrOL9CyMsZqsayNQD9B6x0wZ2t
	TksCjTMsOEU1lYA3LEIAGqk2ZySFCfv3/094yAFj9eSgyMX/OnaUgHIbPLjKSkpXiANicpiAMLs
	2ElbvZ1CV/ioHYTwihdl5M2BulGPKgr9qFoAHvRUvGW8DwYaLhUgQCIdLMPZ9YXerzn+JvNOE6C
	Qt1KtNu7FCeK5lLG8J9Dvyw2dLgWFE5Hi8b3Dln6koYQ80JL8rVw8dZzWfwlN3qtOfDEt+lHxli
	WAhixDCkNvIU2VP2Lth59tmb+US/vFdOad9XZw==
X-Google-Smtp-Source: AGHT+IGR450gXz9KJwUJnT7T725UtrcbaCiY5e5ht7Rj5/IYKCs0AAKsEkN5x5JHedKYw93ADjnHlA==
X-Received: by 2002:a05:6300:630e:b0:1ee:48a:c2fe with SMTP id adf61e73a8af0-1ee048ac301mr16364304637.2.1739154836431;
        Sun, 09 Feb 2025 18:33:56 -0800 (PST)
Received: from MacBook-Air-5.local ([210.123.245.130])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73048ad2688sm6472529b3a.47.2025.02.09.18.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2025 18:33:55 -0800 (PST)
Date: Mon, 10 Feb 2025 11:33:47 +0900
From: "Harry (Hyeonggon) Yoo" <42.hyeyoo@gmail.com>
To: Gregory Price <gourry@gourry.net>
Cc: Honggyu Kim <honggyu.kim@sk.com>, Byungchul Park <byungchul@sk.com>,
	kernel_team@skhynix.com, Matthew Wilcox <willy@infradead.org>,
	lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
	linux-cxl@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] Restricting or migrating unmovable kernel
 allocations from slow tier
Message-ID: <Z6lli5cRHh1Ffvql@MacBook-Air-5.local>
References: <Z54hUTXRsw0LYQ8b@localhost.localdomain>
 <Z54p4QOnAlTYm6DG@casper.infradead.org>
 <20250207072024.GA48419@system.software.com>
 <Z6XLCeU0vjIOYGKe@gourry-fedora-PF4VCD3F>
 <ada54160-461c-4942-a4dc-43f7eab0f1bf@sk.com>
 <Z6XYQjCLK6umaoIS@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6XYQjCLK6umaoIS@gourry-fedora-PF4VCD3F>

On Fri, Feb 07, 2025 at 04:54:10AM -0500, Gregory Price wrote:
> On Fri, Feb 07, 2025 at 06:34:43PM +0900, Honggyu Kim wrote:
> > On 2/7/2025 5:57 PM, Gregory Price wrote:
> > 
> > > The default kernel stack size is like 16kb.  You'd need like 100,000
> > > threads to eat up 1.5GB, and 2048 threads only eats like 32MB.
> > > 
> > > It's not an interesting amount of memory if you have a 20TB system.
> > 
> > The amount might be small, but having those data in slow tier can
> > make performance degradation if it is heavily accessed.
> > 
> > The number of accesses isn't linearly corelated to the size of the
> > memory region.
> > 
> 
> Right, I started by saying:
> 
> [CXL is] "generally not fit for kernel use"
> 
> I have the opinion that CXL memory should be defaulted to ZONE_MOVABLE,

Agreed, when the ratio of slow to fast capacity makes it feasible.

> but I understand the pressure on ZONE_NORMAL means this may not be
> possible for large capacities.

Yes, I this is when we start consider some ZONE_NORMAL capacity on CXL memory.

> I don't think the solution is to make kernel memory migratable and allow
> kernel allocations on CXL.

IMHO the relevant questions here are:

Premise: Some ZONE_NORMAL capacity exists on CXL memory
         due to its large capacity.

Q1. How aggressively should the kernel avoid allocating kernel allocations
from ZONE_NORMAL in slow tier (and instead reclaim pages in fast tier)? e.g.:
  - Only when there's no easily reclaimable memory?
  - Or as a last resort before OOM?
  - Or should certain types of kernel allocations simply not be allowed
    from slow tier?

Q2. If kernel allocations are made from slow tier anyway, would it be
worthwhile to migrate _certain types_ of kernel memory back to fast tier later
when free space becomes available? (sounds like a promotion policy)

> There's a reason most kernel allocations are not swappable.

Because most kernel allocations cannot be swapped, with a few exceptions.

However, there's non-LRU page migration functionality where kernel
allocations can be migrated.

I don't understand why we shouldn't introduce more kernel movable memory
if that turns out to be beneficial?

-- 
Harry
