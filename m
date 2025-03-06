Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF46367
	for <linux-cxl@vger.kernel.org>; Thu,  6 Mar 2025 00:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741219749; cv=none; b=l6Yk+gqhX42lWxZjF3LJ3bz7NLaPWAszILxoBDF06M8F/VQGL6ogm88Kj51d+JqXgXV0qpuw0PAf2b9f5UZ39kNjBoo3tflwl0FZrVDVW1no3uOza9k59uoDcJcs/gkz+ddJZkIg6i2c0a/9xtrssOoxEsiA2YXTvwQTwxY8Lrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741219749; c=relaxed/simple;
	bh=/PL/yCTjIRpzVCj9p4+Qh3kC17MW74dAnh1pilULjIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=goWO7JuQkTgT99wOEUM1o1by9PB48RoEk691gD56Dw/fuIP68Cj78umagNcEiP7WjWOXtv7rUWkbL9+D6uB/g7SgYXq7nG5FdJ/zCKCQUj3BKUchG9emZOnXzZgrWIymfBR+SfuIXr3pWdbDzKkUbBDZDUNw/FZlYPKjeswIHMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=kmyXbeke; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="kmyXbeke"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7be6fdeee35so13201385a.1
        for <linux-cxl@vger.kernel.org>; Wed, 05 Mar 2025 16:09:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1741219746; x=1741824546; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e7n30QZh5MqHhg61ngoUpNHMLZG6JDNKypDXU8n1zfY=;
        b=kmyXbekeOYkv2JlANgMiGQmghxn5r31kP3BnYzrog1g6ADPZhsPtIULpfEQfZwzBg1
         9h3tdvqViS0UKv8IOn+EB8sF3Plag1qARXHOFFAce55ZOTtDe0h9AEHbMC8jfGK1+0Fa
         Qq63vk0Y0kH70PmSlRwCrgYc7IMfy0/gqozN6W6Gos9srdC4M7QfkhOuJG64BLqi5CJH
         OW6Nqukg03pZrJfWq01Kl8JsMVai7aCdhSPIt4h+PSIbe4XvpAZFZvt+2f+2TgKkOnid
         y/Yi7ZwYc5OSQVQkprIFzkg8jO6hdNkfKBesGAXE/RWu5B+65Flw/pCP6VtGyi0BZKZM
         LvBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741219746; x=1741824546;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e7n30QZh5MqHhg61ngoUpNHMLZG6JDNKypDXU8n1zfY=;
        b=mUO0xW2puY9PJz+MAuo/CCXEcXyVIAX7u0eyLXD5N0r+4TvcyHvVk+CzYdzV6mHZHI
         /LdZ16gdWu90DalOPJc6qdlKr6AOzIYYDwX/mZMJKRaI62IN967hdj77gTE2lcv/9gtG
         1JO3cHm4ist4BJE4iT/IB9NH1DHqkcQ6IumTyTxFhuurQrir7APyhxseHyzmKBaNZnCo
         pZyfAIRaIX8+h0bVUNr1Basytq5yaK5u1hKPKi/b6PxAr+im2kb/T1qahu5+C9G0p/qb
         HYHB9n8uL6fcO4CK4bFTyTCpTUpE24aQguHlZACvl9tvz3+m4O0vbPuUC2T0jkLwopQm
         sYag==
X-Forwarded-Encrypted: i=1; AJvYcCURteVfk4yd4e5Q1M1qbFmdazdx0B2d1VV5jM5saB5Ky4sbJv3MZZWUo/1XoxFQWes1B2WKTgW7YH8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqBiv8r6CvwP+g0yP2sR09YXAlVQ83kG2mKgeV9jlQ3meJxfql
	2SrJ6mosKuGQzVu9pLH0Ayzk8/DUx1XScyvXBwf9dzqwYykgo00BDGyuolZ6Sus=
X-Gm-Gg: ASbGnctZ1O2TMjgVTBmMbTNBUxyQlpbnpBXesLZzummvZBDrvD/eUmQU8T+VTFBNo6U
	1kVJpjgJuT710kYPO03utQnGjrpqoy+InC7CoT/YTjTDieaKkxJbqRon/5Ua/eLLnfmEhMD6jqo
	wnLscgUv0LmyjGPt6byiSidrjdc5Ivyv/+2OSw0bxE87ZogoQiES0REcGxXW9mJhkZc6uY26Q/4
	xgLbVrdYCs127gaNUSlqV0PWt+epbnijtSST3lbLwKsTjlXPCDDighXM/CULCWaS89yL3j5OYKh
	4yxY1KU5jwswNj2nwwi5dQLni0nnhHt9W5dMO1CqmYHBJW48NcTVMK7xc0v77veSJ7JWZ7fPQGe
	0yGMwlHVDJeS6arco5KnOHGvJxMs=
X-Google-Smtp-Source: AGHT+IFFxLUQ+KkgPN4iyQlqlwI1Rw/OwtnKQnaDZ4DimWoqed71Ad0cB0V3qblwvHmUbeOh65lMNg==
X-Received: by 2002:a05:620a:2841:b0:7c3:cde7:a685 with SMTP id af79cd13be357-7c3d8de96d9mr870869585a.13.1741219746455;
        Wed, 05 Mar 2025 16:09:06 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3e534e915sm11780685a.46.2025.03.05.16.09.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 16:09:05 -0800 (PST)
Date: Wed, 5 Mar 2025 19:09:02 -0500
From: Gregory Price <gourry@gourry.net>
To: Dave Jiang <dave.jiang@intel.com>
Cc: lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [LSF/MM] CXL Boot to Bash - Section 0: ACPI and Linux Resources
Message-ID: <Z8jnnn7OLa6rwkG1@gourry-fedora-PF4VCD3F>
References: <Z226PG9t-Ih7fJDL@gourry-fedora-PF4VCD3F>
 <Z8jORKIWC3ZwtzI4@gourry-fedora-PF4VCD3F>
 <04e77063-5676-4435-854c-9488075114c5@intel.com>
 <Z8jfigfHaTVR4bLj@gourry-fedora-PF4VCD3F>
 <d34016a1-e834-417c-ba2a-028e4e0e9573@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d34016a1-e834-417c-ba2a-028e4e0e9573@intel.com>

On Wed, Mar 05, 2025 at 04:41:05PM -0700, Dave Jiang wrote:
> I can help write it if there's no great urgency. I'll try to find some time creating a draft and send it your way.
>

No major urgency, this is a best-attempt at background info before LSF.

My goal at LSF is to simply talk about some of the rough edges and
misunderstandings and subtleties associated with "bringing up CXL
memory in XYZ ways". (e.g. what set of constraints you're actually
agreeing to when you bring up CXL in ZONE_MOVABLE or ZONE_NORMAL).

On the back half, I imagine re-working this whole thing.  The structure
here is getting a bit unwieldly - which is to be expected, lots of
moving parts from boot to bash :P

Maybe we can look at converting this into a set of driver docs or
something - though i've been careful not to aggressively define
driver-internal operation since it's fluid.

~Gregory
