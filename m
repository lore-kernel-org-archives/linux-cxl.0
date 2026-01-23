Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2633A2951B3
	for <linux-cxl@vger.kernel.org>; Fri, 23 Jan 2026 16:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769186811; cv=none; b=HdbZ7zcNv0ItgEbCnVt8KGigAjF6qJclAi/QneyZNT7Ujc3se3mlHs5iW0Um59A54EEuogmn9vy8OyXIOYgT8NZnZ/Ev3MtqboyEHtYAJ+E/xOfP0lVNb7JtRdRgoT+xrESbGdgZ2TqM1sdj8UdJXPdAe6w4qVJEv3jFUhvGA2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769186811; c=relaxed/simple;
	bh=5ckwJ77QprgG79RR703TmI0mFHZDRgR3NSrhHEKrshA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IbtqhG5NywMD13JWCe5DbXC0xie2EyU0q9ubEZj1J25k8DQ8H21inQKzz3yYlBffQ2lOkWwq8dUAilnpLJVpmSQTa+1wGOPfFkgwd48mKZTZJjJLVyocea/hfiqAKzDzObhVbp/KiQLtLBOw5XWZBGX+bIKRlpm1C0shLpLJX70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Mtr9O1MF; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Mtr9O1MF"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8c538d17816so356899485a.0
        for <linux-cxl@vger.kernel.org>; Fri, 23 Jan 2026 08:46:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1769186809; x=1769791609; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U7RDSeFPc9RAEmgUI/q4GyqNftjtecnDQ1tYQGKeuS8=;
        b=Mtr9O1MF7lxcCUNXXdKNwsqOaohl/EU+QBt2vGV8oUFAYSQiPExEQOp+lrmat7TxiZ
         P7msxj4N05ETHePQqvpd1suwvnPXPx9QvJLRF4uSdv1SkvQqw0UqJ7bvRsKsMr6Z0jTb
         wzyhcRuq7DrFl3o/Giv2bGn7mAcGLUlUCC66QU0MdKtU3ULxetdF1qdU47dlsQhT1yRC
         7IYFAM8TwWevvKgEcyyuqkOhSgsgi7EuZBij9xmkcR/xDDQkNxPT6HHPQLIm0N5x5Bze
         EqKukMsl9HAL2EacDTFBjrgZcZIOJDfsvGItOBtlQfMhXYMs1cnErXdFRGXRccFkJfqh
         KAIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769186809; x=1769791609;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U7RDSeFPc9RAEmgUI/q4GyqNftjtecnDQ1tYQGKeuS8=;
        b=O43rtsBIrSYPIiZz8hgKK17dUlteb3A6I31wzENKp11OMiaQHo58bLi37Sfa/Tgubf
         gQyUaMkCNuBFlxn5gBPRpzi7qtuUQWMoq3elu+1jpAseCvtF7fogJPoJcTEhhG+rc6ij
         Iu0G3F4bsJtQvacodSs90+qMpA5UiHrfk/dU0mfjrvVYWqtgDdGrUpd2aabv9QxFYZpK
         /sYn88I1CfiQoh0yIUJRQOiqhpddM8pomvF5CNYEEDZv1f8xKOYHX9svi/mCZV/UeTZH
         tNiAJjuNf0LgGAKTjNY0cVyFZPM7z+bSN+LmWnQbfuE7th4WErHeJt/BUJsmj1sRjujR
         HQNQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/HLXhk80bMoCsy9ym+YzDbIqd+KyEnEKQojQcKCLeZhRLJkl6x0PJVzDPeTK8JVVjpoVcA8SmD1o=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy1aaYU/CSjA1JSiP2+ZbYZE9IwA25+mjGZKH6nYKhGFIQeeiU
	mP1KzUYt/4blxntYCEpgYI/fC++Yoa3KNK26iDfeHZONgKFqM52uW0a4fafmq/LoA0FWjbmCQDH
	8e+lGKIE=
X-Gm-Gg: AZuq6aKJ+MtWMqEjWAk7K665g8fO7RxLULn14PlQc0uHDMIrWvoIsB4wucms7Rq4BFc
	KCh5fN9d7XblTfGnVIcxsuPQzpN+BAKS08CjAZaH5jZCzQYEOEaoHDTIEqipQmTUh6s1k1uWboa
	OKUcJqcnu7JgeT2g7meNVBV+iTJeHgT6RMHNzdUy2PMG5YmtC/kbavh98RC3BU2cn3MsD+GinS6
	3Hn+P0tf8smFbEIJFpUX/D2GdMtQ1o07h8tBEncGk4lWisSHk1ITM1xFC1GFsEkBuUJPBkQjjN9
	oABdoa6szFer7kkCIYDjuVd/Y1YymysWn55c13BdGnN77FM+r8zcL0eAY9UHz0xjQwWTp5jhFhh
	82QZnmRf6/QytTgANymqbLoV+sg0M0CqOW1ojkuvoynFDNfizwQ5C+iI4XMlob59+xos+ZbX7bV
	zjYtTErycBnVvuMID2cW8subJVlXYJGuEvmFi1XWhOhUl0h3dcRge01i4eiDqgFHitupcjyw==
X-Received: by 2002:a05:620a:7106:b0:8b6:164e:e0c with SMTP id af79cd13be357-8c6e2d91b4amr471653885a.25.1769186807459;
        Fri, 23 Jan 2026 08:46:47 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89491841c81sm20690466d6.20.2026.01.23.08.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 08:46:46 -0800 (PST)
Date: Fri, 23 Jan 2026 11:46:44 -0500
From: Gregory Price <gourry@gourry.net>
To: Cui Chao <cuichao1753@phytium.com.cn>
Cc: dan.j.williams@intel.com, Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Mike Rapoport <rppt@kernel.org>,
	Wang Yinfeng <wangyinfeng@phytium.com.cn>,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v2 1/1] mm: numa_memblks: Identify the accurate NUMA ID
 of CFMW
Message-ID: <aXOl9CN_66HywIjZ@gourry-fedora-PF4VCD3F>
References: <20260106031042.1606729-1-cuichao1753@phytium.com.cn>
 <20260106031042.1606729-2-cuichao1753@phytium.com.cn>
 <20260108094812.8757ce3ad8370668eaafb29c@linux-foundation.org>
 <9132054c-3017-4af0-84e0-e4359b0794a6@phytium.com.cn>
 <20260115101858.85fd7b8e837c1c92a4fdc5f0@linux-foundation.org>
 <696944eca1837_34d2a10056@dwillia2-mobl4.notmuch>
 <2d1e23ad-7ec1-483b-88b3-70ce19b69106@phytium.com.cn>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d1e23ad-7ec1-483b-88b3-70ce19b69106@phytium.com.cn>

On Thu, Jan 22, 2026 at 04:03:49PM +0800, Cui Chao wrote:
> 2.Why a Kernel Update is Recommended Over a Firmware Update:
> 
> In the scenario of dynamic CXL region creation, the association between the
> memory's HPA range and its corresponding NUMA node is established when the
> kernel driver performs the commit operation. This is a runtime, OS-managed
> operation where the platform firmware cannot intervene to provide a fix.
>

This is not accurate

The memory-to-node association for CXL memory is built by acpi logic:

   linux/drivers/acpi/numa/srat.c

Specifically:

   acpi_parse_memory_affinity()  /* if SRAT entry exists */
      -> numa_add_memblk(node, start, end)

   acpi_parse_cfmws()  /* if no SRAT entry exists */
      -> numa_add_reserved_memblk(node, start, end)


This patch implies the latter is occurring - as it queries the reserved
block associations - meaning your platform is not shipping SRAT tables
for CXL memory regions.

We have only seen this in QEMU - and this is correctable in firmware.

But if this is shipped hardware, letting us know the platform lets us
know whether we should backport it.

---

All that said, this does look harmless, and seems reasonable - but the
changelog should reflect what the hardware is doing above.

~Gregory
