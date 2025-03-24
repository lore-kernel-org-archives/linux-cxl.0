Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C129ABA36;
	Mon, 24 Mar 2025 09:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742806996; cv=none; b=qiPRPF7+ILMv1H5kOXMaFShOw8HvbicmlLcoaf4XEwyufhtWk6/jUfk9NUHW6wiw5Jh0hdw31p+XPTtuuQB0QJ/C9AogMIFUCAM8+HN9zIC7/dvkcc3EKyDK/CmU27/vfMAiSYK9jYh2yHkDPFD5SMemTJN/lJAr2WmnZD/v8S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742806996; c=relaxed/simple;
	bh=hnvXGF50uBsNkaYmmEw/Gu4b4XAYpCJ1akHPT7SsV5s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=URTDvxNchs5J9xEhlEa41WJxyyQeQl80ErShQ5G9tBbMQ3GGJZu5UoqfcqDvBccKYN0ja57bVAVnoedfYstprcFfumhmBoYUyYXP0mr4ij/AkcQYusHdQXNXU3lOTDGONzbsP0Au794uFptl62nBrTXQ+Jek4E2JDUa1iaKTFb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-85-67e11c41a64b
From: Rakie Kim <rakie.kim@sk.com>
To: Gregory Price <gourry@gourry.net>
Cc: Joshua Hahn <joshua.hahnjy@gmail.com>,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	dan.j.williams@intel.com,
	ying.huang@linux.alibaba.com,
	david@redhat.com,
	Jonathan.Cameron@huawei.com,
	kernel_team@skhynix.com,
	honggyu.kim@sk.com,
	yunjeong.mun@sk.com,
	Rakie Kim <rakie.kim@sk.com>
Subject: Re: [PATCH v3 1/3] mm/mempolicy: Fix memory leaks in weighted interleave sysfs
Date: Mon, 24 Mar 2025 17:47:50 +0900
Message-ID: <20250324084757.965-1-rakie.kim@sk.com>
X-Mailer: git-send-email 2.48.1.windows.1
In-Reply-To: <Z91xsVv98wp7TVrq@gourry-fedora-PF4VCD3F>
References: 
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHLMWRmVeSWpSXmKPExsXC9ZZnka6jzMN0g83bVC3mrF/DZjF96gVG
	i6/rfzFb/Lx7nN1i1cJrbBbHt85jtzg/6xSLxeVdc9gs7q35z2qxek2GA5fHzll32T262y6z
	e7QcecvqsXjPSyaPTZ8msXucmPGbxWPnQ0uP9/uusnl83iQXwBnFZZOSmpNZllqkb5fAlfF7
	cjdzwS3eij37J7E0MN7i6mLk5JAQMJH4ePo4K4y97v4cxi5GDg42ASWJY3tjQEwRAVWJtivu
	XYxcHMwCH5gk9m1tYAWJCwuES7TOEAXpZAEqmf/rOiOIzStgLLF06gsWiImaEg2X7jGBlHMK
	mEmcX+UIEhYS4JF4tWE/VLmgxMmZT8DKmQXkJZq3zmYGWSUh8JxN4u2rl4wQcyQlDq64wTKB
	kX8Wkp5ZSHoWMDKtYhTKzCvLTczMMdHLqMzLrNBLzs/dxAgM9WW1f6J3MH66EHyIUYCDUYmH
	d8PL++lCrIllxZW5hxglOJiVRHiPsT5MF+JNSaysSi3Kjy8qzUktPsQozcGiJM5r9K08RUgg
	PbEkNTs1tSC1CCbLxMEp1cBoomy/k/PK7pl9mbv/BYf/XMncraHx5PLicEflLu6edxM/Lavs
	iJarq/j4226/lYHJ4rzaPuUfd2J8j7HP4dC7mBTjKe+xrPgDS/2nY9p3tDKXzI2+IVy9X0PE
	3X9HG1/v1qmsL3hmm79/nZ12weR203IGtYsmMRd2Rr3Pnq9oW332Unra4h1KLMUZiYZazEXF
	iQBCdcCvcQIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBLMWRmVeSWpSXmKPExsXCNUNNS9dR5mG6wfOtUhZz1q9hs5g+9QKj
	xdf1v5gtft49zm7x+dlrZotVC6+xWRzfOo/d4vDck6wW52edYrG4vGsOm8W9Nf9ZLQ5de85q
	sXpNhsXvbSvYHPg8ds66y+7R3XaZ3aPlyFtWj8V7XjJ5bPo0id3jxIzfLB47H1p6vN93lc3j
	220Pj8UvPjB5fN4kF8AdxWWTkpqTWZZapG+XwJXxe3I3c8Et3oo9+yexNDDe4upi5OSQEDCR
	WHd/DmMXIwcHm4CSxLG9MSCmiICqRNsV9y5GLg5mgQ9MEvu2NrCCxIUFwiVaZ4iCdLIAlcz/
	dZ0RxOYVMJZYOvUFC8RETYmGS/eYQMo5Bcwkzq9yBAkLCfBIvNqwH6pcUOLkzCdg5cwC8hLN
	W2czT2DkmYUkNQtJagEj0ypGkcy8stzEzBxTveLsjMq8zAq95PzcTYzA8F5W+2fiDsYvl90P
	MQpwMCrx8G54eT9diDWxrLgy9xCjBAezkgjvMdaH6UK8KYmVValF+fFFpTmpxYcYpTlYlMR5
	vcJTE4QE0hNLUrNTUwtSi2CyTBycUg2MOUdX2J74/Pivvup9GdOaryqx4kYGtVzrJq177Xmw
	9szUimtNUraOHoueWN0yqpr9Vnjyr/hVsx8q77fRtTNKNfL88vxvhnwUL8+cSdd8On8WbVz1
	c9UcV8kjm9zXhJ0X2H3Lnmf7s50Hwuz7y5m61s4+tfVyTem8J7ofVe9xJy+6fO91+eZyNyWW
	4oxEQy3mouJEAGffsUdrAgAA
X-CFilter-Loop: Reflected

On Fri, 21 Mar 2025 10:03:29 -0400 Gregory Price <gourry@gourry.net> wrote:
> On Fri, Mar 21, 2025 at 01:37:22PM +0900, Rakie Kim wrote:
> > As you mentioned, I agree that Patch 1 may be a bit unclear.
> > In fact, Patch 1 and Patch 2 share similar goals, and in my view,
> > they only provide complete functionality when applied together.
> > 
> > Initially, I thought that Patch 1 was the fix for the original issue and
> > considered it the candidate for a backport.
> > However, upon further reflection, I believe that all changes in Patch 1
> > through Patch 3 are necessary to fully address the underlying problem.
> > 
> 
> Patch 1 does address the immediate issue of calling kfree instead of the
> appropriate put() routine, so it is fine to keep this separate.

Understood. I will keep this patch as-is for now, as you suggested.

> 
> > Therefore, I now think it makes more sense to merge Patch 1 and Patch 2
> > into a single patch, then renumber the current Patch 3 as Patch 2,
> > and treat the entire set as a proper -stable backport candidate.
> >
> 
> The set adds functionality and changes the original behavior of the
> interface - I'm not clear on the rules on backports in this way.
> 
> Would need input from another maintainer on that.
> 
> Either way, I would keep it separate for now in case just the first
> patch is desired for backport.  Maintainers can always pick up the set
> if that's desired.
> 
> (It also makes these changes easier to review)
> ~Gregory

In that case, I agree it's better to treat only Patch 1 as a backport
candidate for now. As for the remaining patches, it would be more appropriate
to discuss their inclusion with other maintainers at a later point.

Rakie

