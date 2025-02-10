Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8371A239F
	for <linux-cxl@vger.kernel.org>; Mon, 10 Feb 2025 06:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739167209; cv=none; b=rFwDjK0++suv/+BjDpxAjW1zVI+BSIatNwNQpltm3ub4fbXTbaogtXmnaw3x617rI3LLUH/VS9EVwni0LbLkSA7+/B0fJ5dh6V8FT0LblzMhpjjwCE10ZCVpUoYrxncIML4XMdbFEZwtnjPH1TGS4YY60dM+U8j6nuQqVnLvU7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739167209; c=relaxed/simple;
	bh=mK8iz7bLRPDbKyiHp0IffWZZjD7Aii5NSpwyRZOiFj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O+wcrpfTg8shUqgzg1dgHZ1ChW1iJ0Xy8Fcun0t9CCQyn+vNjyfYQcsPW6OznjLNemdsMrc1Kw41alE6iJwnYgB9c93vChbeGjE4O6PTN4WGNAq8cEvQeAdU5qD6jxZQjUuTY0eUk2AycJE5EjVJrRHZ7370y14i/SS5BygIq0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=H3hAfm8/; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="H3hAfm8/"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7c053a107b8so150614485a.3
        for <linux-cxl@vger.kernel.org>; Sun, 09 Feb 2025 22:00:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1739167205; x=1739772005; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=amAQ/fip1zjjPAFrEnkAcUMSCHVM3BmAahoIJR9K7hU=;
        b=H3hAfm8/gJk2YvfyJ7WvTnIKu8CTwaFhEZfuFgyd+otgKf+xje9FBVh07QMfoIsSDR
         hkkUvofXtffiyKfsx9Haz6o/yhiqQIEjyPDPI7S/akxErXwD/V3qz7NazAkadDJI8lY7
         7DZRCK0GuS6nrAmYGpifh245EhC5cCseDhJ5qUX2+Hky2cQcHQHuZycVE+bhngh0Rw2f
         yqRHzHC+YrL3JUiTKUWi8rfsFscr1TXSZ21c1+PGfngRSJsl2no5vmJOx3xJutT5DyNA
         3q77Xy9F+6e9NZFDDOS/wqOHgrQ3ViklUNWpTBK2BIHMCOmOYVdr5mt9wxu2ImUlrl4h
         uzXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739167205; x=1739772005;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=amAQ/fip1zjjPAFrEnkAcUMSCHVM3BmAahoIJR9K7hU=;
        b=qOTMkD7zJqFReE7PIWhsggggSBKdyWUL/HKMLBaentBMQvWMxeB6spOfN7Gl6iunYA
         vK9tY3qhqVVpu4wr9WWb+dEgAKxWYFGnV2n2Jb6qDDpL5htkMBZajUsOiRbB98RRmf8Q
         nxzpQqx2xpeU2STGa/V1zioHp96NBlNILsIe16L8d8Zc9OcscZKPi8UQs9+2Ou8s93oh
         bKxkS5sBfS74qo7FkbekzlAhekwysvCjDKQUQHMX6ExpvvD9ygOm/u5UlaDYo8yHRtk6
         xsKBxXZ14lw9fs5IjyZA1Cs0fueKyAybRo8dwkrLuP+hnkqUqaDHWMjRot/rZreXBBgF
         mSLw==
X-Forwarded-Encrypted: i=1; AJvYcCVs/suNannnwDUiqzHn3/FFyXF3bn6R1kBAkM5wwRYvl1wnAqTMWlDqsdsmHAn6KFulTGHUgpogUWs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMVXmrgNcywgaStSrR0fQKJF36F38kMiYhgNHkuMxazkRCBoaF
	cQqo6Zo1e9n/kWptXIdvWuCTo4YVMtCnWo0pl8UkVySLh4v/O/P8ppybHKVQfgE=
X-Gm-Gg: ASbGnctYrpQ8VphzMU7l/re7DMKgAtZ6lt92HCX5ETrN9veE4K6Y8QxRo3N1gt/hw0K
	z885sQD4RB2cCThFhVfJ+PvKiRcv0hfpcWT7vzvw5DeI2lh3MyA44Pfyi9eRZAQ/znf4eit5Iat
	rVhZ1QKn1zh7MeqMlUEwu/GAd5cRqIequMJNPyWvwGM5QUZgqn8ExZhAq99D0yz1pRw6Xj0CZ5r
	lYRU56rMRbvhD8BS34l2rZC2qXmaOXqfQOVAjGVlth8Z7uH22dCs9EBki1JuIHi5zz78fkwSwt0
	bvQpvcHqg0C7QDiF01cPBUJDDWSf2Aht6dy/KvU8v7JoiP79I3a5U3fcfNuMLa9f3BsQb9qmWg=
	=
X-Google-Smtp-Source: AGHT+IHhwRLl2TltpPoSTD0m1jyHAGjWZCwGLbFlLxrmsv3fIf/VYYOQNaeDAvY04Qt2kVJcxb3hLQ==
X-Received: by 2002:a05:620a:f14:b0:7b1:5763:4ba2 with SMTP id af79cd13be357-7c047c7504dmr2264001985a.40.1739167205217;
        Sun, 09 Feb 2025 22:00:05 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c04e111a58sm257668385a.92.2025.02.09.22.00.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2025 22:00:04 -0800 (PST)
Date: Mon, 10 Feb 2025 01:00:02 -0500
From: Gregory Price <gourry@gourry.net>
To: "Harry (Hyeonggon) Yoo" <42.hyeyoo@gmail.com>
Cc: Honggyu Kim <honggyu.kim@sk.com>, Byungchul Park <byungchul@sk.com>,
	kernel_team@skhynix.com, Matthew Wilcox <willy@infradead.org>,
	lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
	linux-cxl@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] Restricting or migrating unmovable kernel
 allocations from slow tier
Message-ID: <Z6mV4vwkP0weiLie@gourry-fedora-PF4VCD3F>
References: <Z54hUTXRsw0LYQ8b@localhost.localdomain>
 <Z54p4QOnAlTYm6DG@casper.infradead.org>
 <20250207072024.GA48419@system.software.com>
 <Z6XLCeU0vjIOYGKe@gourry-fedora-PF4VCD3F>
 <ada54160-461c-4942-a4dc-43f7eab0f1bf@sk.com>
 <Z6XYQjCLK6umaoIS@gourry-fedora-PF4VCD3F>
 <Z6lli5cRHh1Ffvql@MacBook-Air-5.local>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6lli5cRHh1Ffvql@MacBook-Air-5.local>

On Mon, Feb 10, 2025 at 11:33:47AM +0900, Harry (Hyeonggon) Yoo wrote:
> 
> Premise: Some ZONE_NORMAL capacity exists on CXL memory
>          due to its large capacity.
>
What you actually need to show to justify increasing the complexity is
(at least - but not limited to)

1) structures you want to migrate are harmful when placed on slow memory

   ex) Is `struct page` on slow mem actually harmful? - no data?
   ex) Are page tables on slow mem actually harmful? - known, yes.

2) The structures cannot be made to take up less space on local tier

   ex) struct page can be shrunk - do that first
   ex) huge-pages can be deployed - do that first

3) the structures take up sufficient space that it matters

   ex) struct page after shrunk might not - do that first
   ex) page tables with multi-sized huge pages may not - do that first

4) Making the structures migratable actually does something useful

   are `struct page` or page tables after #2 and #3 both:

   a) going through hot/cold phases enough to warrant being tiered

   b) hot enough for long enough that migration matters?

   You can probably actually (maybe?) collect data on this today - but
   you still have to contend with #2 and #3.

>
> I don't understand why we shouldn't introduce more kernel movable memory
> if that turns out to be beneficial?
> 

No one is going to stop research you want to do. I'm simply expressing
that I think it's an ill-advised path to take.

~Gregory
