Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11301CDFCC
	for <linux-cxl@vger.kernel.org>; Fri,  7 Feb 2025 09:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738922059; cv=none; b=MloC1kTzxHV3nMDe5G7QZsSFHECgYSgdnV/BBRCaxOFhmGUCb1y8NA2kirRMZsA8yS39ge74C10ZkhJsNZt81I1exWtxpKUUJAgctnVTfCps//pVvRWFeIneOrvye9MkWhQPKjRy2A5Qc9rmvVH6bRUio5t9VTmPowYKco2xUdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738922059; c=relaxed/simple;
	bh=Rx6SUVN+7ovkwLxbqIYhsHjK/BGDXtP7BbvwiY9VIs8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JrhPAfElMfb/mYcHnmyCxObuF5M9O/AppCU1p9L/X/P48Po6xydToYXlN309FUsrjUsK0OmmL9hzr8gS/7NBTVpgpKfm68Y8ZEszeU0XSls9C0lYe8WbT7ElzpBFo+4Xn5RNRaGyZGAsL5ZUJeacc0keLUawdpd0MQU1O7ZbdVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=J2759lrN; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="J2759lrN"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7b6e9317a2aso247812985a.0
        for <linux-cxl@vger.kernel.org>; Fri, 07 Feb 2025 01:54:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1738922053; x=1739526853; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ICigtFivcifkpGmnUP0PlwlMfhS9Ngy2Rm3Uut/jeRA=;
        b=J2759lrNmiG/IQe68T2QpVQ1COZZsA0whAe6WI2l9WTCrb5d2lPYXCsPBE5yHP9GtY
         iQBwtrwTdXcGYILAFV5iKSKwFQbCX7bwjrgpk1z4aqIj5XNmz/faGloYq/HzIFWwJ+Ao
         9sbouqre9PtdSiA3mhDEqHSLoBW/NItYaw+FzjpMnCJnqIwHZ6wVSKW8AqKlUNSbxnjj
         OzqrZHbkYbgrJ9ygrerVrsHEE+akyMK9Kxx16xzzhiiujlSsLFrLM+yF0pb0uZjC+oiJ
         VI4bLi03oFlWKuGUqUswOpFFHIhIbtmrpMJxrECn7mqiYhGV7mpqmxtKyhFZznTrq/O2
         dUIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738922053; x=1739526853;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ICigtFivcifkpGmnUP0PlwlMfhS9Ngy2Rm3Uut/jeRA=;
        b=PpR1yU1YywOILnnUhn3617OdojLL/FxN10QS4dvFOP7DzqK5Iw+FfcKy0GVtPnlgPn
         EwCDrcZ7nF9F9ogaL8CkX/9uzMTlIwEmNT3gSOZGHwDSZel0nQ4nWdxIElqr/KOhEWy9
         o6YAUhp1vYFXDX1kFh0HO4zZStRdIwGEHEM3hic9khlCdLNT7CwtWeQGRLRYOdzrDqFa
         BBgSvxG+sq1lfMNzN/5FYvGqBoPdK0vSc38N4/tlXyZP1xo7RaMpNlehIUPnCOmqZ+46
         OdkRLCdoa45k9jWWej8yYbbmoBgctr0cn0CtH1wqJ217+21lwzdI0O2SOKPQcWoEjniv
         nN2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXH3b+jdTH6jo55ZTlZrZugNYR3OxkvrEYhcgctPmXpfYYZeLWayat4KoQAJZcewEdeFYtj2u8JG2U=@vger.kernel.org
X-Gm-Message-State: AOJu0YymIIkuMsIUzZHMwXklCthujZ/sR7i1B17bmO/Dpk6a/DOacfFA
	QJ5NpkV1qqECpEfbRitX0J3KLB46KHqiQyQUFVzNBeFIKoSTtVi55hYCy4AUBo0=
X-Gm-Gg: ASbGnctDgLBMSxbqAuiGYPT3oPBDyLRbtx0GxZsKhEdEk3djbiPeSoICWAMYfKzRKON
	D0xLONr7+DUqKweJ1KFZD4OItV8hgRPS3hBtTZN7PkstFDBEyjiuoDJSq/rIToNK2k/FXINImd7
	zajBHUb9+qcN1SikCx5Yv/Xu0D966irhTIfVpN55ZmUBIrk9MIklPClUQrNvI30aOqpEwhZUOHF
	JBjLf+iL86lVDsZk+46s1IKIAweO80JFo3woWhacmFg4prIZ7R5PWHxkIWkehPovelQatLAU5OE
	M3GSIBxojGJ7A29764Aw6LSet1IL+d/IgdqowvRtwENkQyWpJYFDw45Bd3IIW1eZaHAT72UApQ=
	=
X-Google-Smtp-Source: AGHT+IE935dLEAom6CKBRb6MFRAJjtVBwRQlplz4Q1/PpNm74NViOX4mql03TqBvBXafr+TIQ/4sPw==
X-Received: by 2002:a05:620a:410c:b0:7b6:d273:9b4f with SMTP id af79cd13be357-7c047eb2f81mr350229385a.11.1738922053541;
        Fri, 07 Feb 2025 01:54:13 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c041eb7f89sm167312585a.110.2025.02.07.01.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 01:54:12 -0800 (PST)
Date: Fri, 7 Feb 2025 04:54:10 -0500
From: Gregory Price <gourry@gourry.net>
To: Honggyu Kim <honggyu.kim@sk.com>
Cc: Byungchul Park <byungchul@sk.com>, kernel_team@skhynix.com,
	Matthew Wilcox <willy@infradead.org>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
	linux-cxl@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] Restricting or migrating unmovable kernel
 allocations from slow tier
Message-ID: <Z6XYQjCLK6umaoIS@gourry-fedora-PF4VCD3F>
References: <Z54hUTXRsw0LYQ8b@localhost.localdomain>
 <Z54p4QOnAlTYm6DG@casper.infradead.org>
 <20250207072024.GA48419@system.software.com>
 <Z6XLCeU0vjIOYGKe@gourry-fedora-PF4VCD3F>
 <ada54160-461c-4942-a4dc-43f7eab0f1bf@sk.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ada54160-461c-4942-a4dc-43f7eab0f1bf@sk.com>

On Fri, Feb 07, 2025 at 06:34:43PM +0900, Honggyu Kim wrote:
> On 2/7/2025 5:57 PM, Gregory Price wrote:
> 
> > The default kernel stack size is like 16kb.  You'd need like 100,000
> > threads to eat up 1.5GB, and 2048 threads only eats like 32MB.
> > 
> > It's not an interesting amount of memory if you have a 20TB system.
> 
> The amount might be small, but having those data in slow tier can
> make performance degradation if it is heavily accessed.
> 
> The number of accesses isn't linearly corelated to the size of the
> memory region.
> 

Right, I started by saying:

[CXL is] "generally not fit for kernel use"

I have the opinion that CXL memory should be defaulted to ZONE_MOVABLE,
but I understand the pressure on ZONE_NORMAL means this may not be
possible for large capacities.

I don't think the solution is to make kernel memory migratable and allow
kernel allocations on CXL.

There's a reason most kernel allocations are not swappable.

> Thanks,
> Honggyu
