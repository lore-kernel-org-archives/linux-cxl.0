Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27BC238C29
	for <linux-cxl@vger.kernel.org>; Fri,  6 Feb 2026 13:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770384674; cv=none; b=b0aXV3oxXaMIAzWDnVqHpf14dbnsSMqyds/TxiS8zzyOv2J7j/tInBCZncPkGhl0nG74txp2smhjKD7poxPSaZO1RGmCxXTHb/mRPSYAPMfg00sPXOPCQ/+FV8CW/+ahnYxi0U2928fGXxkQoBbIiMAIueceG4V7GsC5LS9fq+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770384674; c=relaxed/simple;
	bh=AbCOlQJvJwi6LocfIA24cRbzPXJXoBUhj/R077ZlHsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ODMBlFZZzRIYB8F49Uv4Z35yQf4MDUdhQPbKJRRD80CzEwI6A3RyAVKs+u0cJ26UXRzLPZkZzwrIlpIYjV4stUmdRlNFkpevg5CYP4faCij+scPnNdBpSOMUQncDqxiWkl5Z5ETN8++GzHHT4VExmR9tJJP3R+xVwh7dN/bCl0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=eLgQXJ66; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="eLgQXJ66"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-894a2309a29so34781856d6.1
        for <linux-cxl@vger.kernel.org>; Fri, 06 Feb 2026 05:31:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1770384673; x=1770989473; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Di9rrCemg3Phd+bFA7xXmyQkZ2Pz85YWhx7g/X7oYx4=;
        b=eLgQXJ66XjeWwhIqnmDtvR8pTwC3sntqXAec1SFny2TtK1/4tOrKmqIR4FvfURTgd1
         OQwn5ouS1E7B/G17fZccGTD5t2S+czQGwRkZ6yryerc6ei2oskw/IYv5C6KCGXJFGYp5
         GUmnDixIRuo+qbxO4LMy/TieZclW1CH65yT8Mb9EPhQSb/uVsgAr9S8bFKWa0x934VnQ
         gj4Wwo8Qsf/hOpEQusr4wvQmFQrpQsxUBxpq2jQLrY+DoNURDdELXKAqv90tEIne8Gmo
         rk57hGy0csqMz/NG0UZ+tlAKa3JO1tgHfZgzZFN1nOEREXJQYun4RXHTbFZU5yGmC8mr
         3mfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770384673; x=1770989473;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Di9rrCemg3Phd+bFA7xXmyQkZ2Pz85YWhx7g/X7oYx4=;
        b=B2nXEhuDUiLVEVDHlykEVgHudv/G/oZh/RLr3S+NUr3Hu/U2ARi+cb9c6nYINMZIIK
         yjo1plqWPenDBagS21u/6u2Qws4ndWjhvp6/KME7NVrfHrj7FR6vP8kQ+BdlkYhYYNT4
         dwlOGNG6hxaQBoN5+B0h/2pkRBOigxjd4I3tdjriJBoflfsSG9MzsZpjYrQPoVKJoJ7D
         /R8DFt6FepQDCf+7mYU7aJQPOcTc57qPYhpwAEcUf12/2+0q/G8/Y7isArBah3FOR8Wj
         pZxoKFXMhUT7ZBBS/OYbDruVUSrWlKJS+2ldZwhOcjAdb8mCuN6gATyAKUphYElmFWUH
         QI4Q==
X-Forwarded-Encrypted: i=1; AJvYcCV86XLY0v+v3HNyKbKz5xcEMiVYJoW5n0YomUxI5lG10tp8isbCgBXL646eFlG2CbfsQWjsSKHhXdA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7OIkHhCAy+EPvUfC5I5J/7huIYSecVhoZcjVtiRp8VOFZ1BmR
	96oLRjvKubGYQSPlwMKRALqC60mbjpabMX7P8FSw0KxugEttdD26MbL9dBtyq7OkbK8=
X-Gm-Gg: AZuq6aIcyw3PLXByRY1w6K7ZReMCVCQ7GDsNJSvK2xBZsynXGeZDk6SwMU3+XNP8IRH
	ljF16xtInsPZ9TpECEn0yJiy1ufTqRvGpXXTNc/dt64fZL3bXJQ04w9z3RGGTHrynw34iIQ4E9e
	C7Kjpqi1udRS60LD5T9UmpOhlqJ1EFFxnSeGtj/N20laI0cqP3WYuW1w3G8MUICiV+nSoeAwV6J
	gld4dNzxkg8Wsxl9JrDWsuqMy+WupaSTlHtqCIOIc1VW4CpOmllDe72tK2YTKJ0hWycp8M9Nma7
	E/DvC5m9/M2eQxN4yGyIRRMe7im6gaGZn7aV5w4TzY1/Umrz+rRDCVfTy+Nw5A9iL4GZmj+tkdT
	psVZ84CXndhAXVAGZxPApkuCf8Vhmi/rx5CQ2kdVwZGTJPw5/Sz9s3ow9gPzqeuYC2k1OL9tgvu
	8MKpVqTs/CBOSeBiOA9csuC1Qw2Kjw/qaJ03yG0P6xfasWseL8AeB+zsPV2MRus8PjHci4Og==
X-Received: by 2002:a05:6214:2428:b0:894:6540:9112 with SMTP id 6a1803df08f44-8953c150d50mr35637556d6.33.1770384672493;
        Fri, 06 Feb 2026 05:31:12 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8caf9ee9fbasm152145985a.39.2026.02.06.05.31.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 05:31:11 -0800 (PST)
Date: Fri, 6 Feb 2026 08:31:09 -0500
From: Gregory Price <gourry@gourry.net>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Cui Chao <cuichao1753@phytium.com.cn>, dan.j.williams@intel.com,
	Mike Rapoport <rppt@kernel.org>,
	Wang Yinfeng <wangyinfeng@phytium.com.cn>,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 1/1] mm: numa_memblks: Identify the accurate NUMA ID
 of CFMW
Message-ID: <aYXtHa4Y2y_5xgcS@gourry-fedora-PF4VCD3F>
References: <20260108094812.8757ce3ad8370668eaafb29c@linux-foundation.org>
 <9132054c-3017-4af0-84e0-e4359b0794a6@phytium.com.cn>
 <20260115101858.85fd7b8e837c1c92a4fdc5f0@linux-foundation.org>
 <696944eca1837_34d2a10056@dwillia2-mobl4.notmuch>
 <2d1e23ad-7ec1-483b-88b3-70ce19b69106@phytium.com.cn>
 <aXOl9CN_66HywIjZ@gourry-fedora-PF4VCD3F>
 <a90bc6f2-105c-4ffc-99d9-4fa5eaa79c45@phytium.com.cn>
 <20260205145842.efb90572a902ae4c481e6ef6@linux-foundation.org>
 <aYUjf0OrD8f_bJCy@gourry-fedora-PF4VCD3F>
 <20260206110305.00001fbb@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260206110305.00001fbb@huawei.com>

On Fri, Feb 06, 2026 at 11:03:05AM +0000, Jonathan Cameron wrote:
> On Thu, 5 Feb 2026 18:10:55 -0500
> Gregory Price <gourry@gourry.net> wrote:
> 
> I disagree. There is nothing in the specification to say it should do that and
> we have very intentionally not done so in QEMU - this is far from the first
> time this has come up!. We won't be doing so any time soon unless someone
> convinces me with clear spec references and tight reasoning for why it is the
> right thing to do.
> 

Interestingly I've had this exact conversation - in reverse - with other
platform folks, who think CFMWS w/o SRAT is broken.  It was a zealous
enough opinion that I may have over-indexed on it (plus i've read the
numa mapping code and making this more dynamic seems difficult).

> This configuration reflects the pre hotplug / early CXL deployment
> situation. Now we have proper support in Linux we have moved beyond that.
> We do need to solve the dynamic NUMA node cases though and I'm hoping your
> current work will make that a bit easier.

If we want flexibility to ship HPAs around to different nodes at
runtime, that might cause issues. The page-to-nid / pa-to-nid mapping
code is somewhat expected to be immutable after __init, so there could
be nasty assumptions sprinkled all over the kernel.

That will take some time.
---

Andrew if Jonathan is good with it then with changelog updates this can
go in, otherwise I don't think this warrants a backport or anything.

~Gregory
