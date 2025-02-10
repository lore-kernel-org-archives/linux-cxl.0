Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B551225A25
	for <linux-cxl@vger.kernel.org>; Mon, 10 Feb 2025 15:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739202483; cv=none; b=A31WjIYWJn2uXMFVae++q/Ua19T41I6BsxfaBTHHy1XrKiPdQGaFuaSZ4CwWdmvnXZm26tQUhNYHW8BK+0be7a9+9VLHnJken8GW5upw/867T/+hfHDI03PD9qf/5v0a21EQV7kqAghLdMZMjq+lGbcnonpJVxjRUoOBagvkcHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739202483; c=relaxed/simple;
	bh=aaQp6UXfDnDkU+eohOzHtrdA4zutzbDQalJ/rl6CIHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=As6SZlV8u/YpG9s04nVggJ/sNgBV4SyNXUaoVeSzEsGGo4xBzMgMwilLbTGVBWJhIQxuU3XkxBHA7ElVnAmT+X3CumJADdoZfXEzV1BjGDigCh1LreTJ+pkrIJaq5djCHou4cPzMH/8NMv8T7mHQlzRYw2Lu1ub6L3LJore7goc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Tdz/zEqy; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Tdz/zEqy"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7c05f3da684so103131385a.3
        for <linux-cxl@vger.kernel.org>; Mon, 10 Feb 2025 07:48:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1739202480; x=1739807280; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=scf6LsLMNzR6qLH2W09TET7dtyLFemYsjByRE6dLrGE=;
        b=Tdz/zEqy2QZdSce1TdbmfdGZwGFt/gwJGgXla97uC9ILKKsbgBVTZiAyqpfwBtyU5S
         ZT/ZDXoEnuuiAWpuxmY07NpwixAD13ZhmGNPRnNxr+K4osOqR7EytSKjRaZRUEQgaDCG
         meMxbBoQfwHwg6RaFg26epYqHgCzyCHiuOsOG35bWE+G2FZM82y9hgPsHnIP9VM5DEPR
         WFX5XFUZ7r3Z5ORGCizI9Uu3CnbyVPk/VcpSsNhL0LuwqO9lbr+L4VN/fgOHTgbOlSKd
         WnSBVRHbNKJSzx5yBrr9/gXJUSlaomnNmVRBp9I5Bq6IcVL00zb4qTcxVrl4ozOvGasZ
         MDvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739202480; x=1739807280;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=scf6LsLMNzR6qLH2W09TET7dtyLFemYsjByRE6dLrGE=;
        b=mpQIKo/xb7HTAYOqgT6NgIp+0gvxRE7oFm09MbUAFaH7lRHJbDl998Hzmex/bLXYZF
         wMX6Nv4kkrEwvAP2rZ13cYR/tH9o/8uA5y5GfS+QFi+akjmEuN9jwf01rUPRrxNViWzz
         auK4v1US9+lRoutSimBF48OoLbDLCrfZ9atkNCb2oNvz7vtQOw1SWzrTCBRO1cRJi7Pb
         PRP3nJvkvh+z1IdpQgd7jNJ7cn3Q9NNgNMYqJOfcSAau5fV1V1owLs13AgFwksWnEjVP
         tO8Calp3jN6MiYz6fx5WKVBne6jxHhqlA4BsfSOlW+kjNT7jFik5v0dsdeSjT1hJB+nK
         vepQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtQTTrwo2g/pgficVP3JlRhsSRuGH7QVKeOw8TmuShslvvnTa8Lu8GRCldByzLM/bypQ9C4fuCNHM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVPHaLW/hjFDljPhX4puMwKXNGUzB2FI6EXYm7QsPqnRNeZT06
	kaDzEtoUoYRgG/VWgRVUwHcMEaLUbR4JFKlgIEOF4qKM14L97fXwX7TDejavsZU=
X-Gm-Gg: ASbGncuH3YCDdlHBDkNmzYsPxxwnPcZvQ0+3LjYvly6b8FP8aTZRit5Ln8xh5bTxOZQ
	FbbwZrFeDdw5Hg96y19/xUsxwktXJSifb+jDLecH4f/p0BLdgNjJM4k8ilGQCrpoNaYXD5CZ3Ba
	+iqqlqRemMWSK1d7xhMajcLeN5EWzJxj/g0Gq3nz0atYpkwsxROkn48MMg9RJNyEnI9O8MiyrWX
	STAH7JceFLavLYpO57lMIsf/+CMKTD5LSCBO05qBOGT+jBTr8nobIGZZ+1oIF2D2RChl07dQuFR
	jeRGOuF4ECwxjoo8Th3qqjAHJ34KBYl6ki4J6sLj39gOP5fn5S54nL8sAnjYyqdzuIPjRJhovA=
	=
X-Google-Smtp-Source: AGHT+IF+9w/S2qqVqso0iSOh3zyyAqLUx/0XWLymiMNKjonGL2rgcCdQ4hNi707V2QJoPsvO3un6Fg==
X-Received: by 2002:a05:620a:4004:b0:7c0:5e82:8228 with SMTP id af79cd13be357-7c0686e0506mr27675085a.21.1739202480261;
        Mon, 10 Feb 2025 07:48:00 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47183bc479fsm22813441cf.17.2025.02.10.07.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 07:47:59 -0800 (PST)
Date: Mon, 10 Feb 2025 10:47:58 -0500
From: Gregory Price <gourry@gourry.net>
To: Byungchul Park <byungchul@sk.com>
Cc: "Harry (Hyeonggon) Yoo" <42.hyeyoo@gmail.com>,
	Honggyu Kim <honggyu.kim@sk.com>, kernel_team@skhynix.com,
	Matthew Wilcox <willy@infradead.org>,
	lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
	linux-cxl@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] Restricting or migrating unmovable kernel
 allocations from slow tier
Message-ID: <Z6ofrm1u7itAP32b@gourry-fedora-PF4VCD3F>
References: <Z54hUTXRsw0LYQ8b@localhost.localdomain>
 <Z54p4QOnAlTYm6DG@casper.infradead.org>
 <20250207072024.GA48419@system.software.com>
 <Z6XLCeU0vjIOYGKe@gourry-fedora-PF4VCD3F>
 <ada54160-461c-4942-a4dc-43f7eab0f1bf@sk.com>
 <Z6XYQjCLK6umaoIS@gourry-fedora-PF4VCD3F>
 <Z6lli5cRHh1Ffvql@MacBook-Air-5.local>
 <Z6mV4vwkP0weiLie@gourry-fedora-PF4VCD3F>
 <20250210071741.GB39454@system.software.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210071741.GB39454@system.software.com>

On Mon, Feb 10, 2025 at 04:17:41PM +0900, Byungchul Park wrote:
> On Mon, Feb 10, 2025 at 01:00:02AM -0500, Gregory Price wrote:
> > 
> >    You can probably actually (maybe?) collect data on this today - but
> >    you still have to contend with #2 and #3.
> 
> Ah.  You seem to mean those works should be serialized.  Right?  If it
> should be for some reason, then it could be sensible.
> 

I'm suggesting that there isn't a strong reason (yet) to consider such a
complicated change.  As Willy has said, it's a fairly fundamental change
for a single-reason (CXL), which does not bode well for its acceptance.

Honestly trying to save you some frustration. It would behoove you to
find stronger reasons (w/ data) or consider different solutions. Right
now there are stronger, simplers solutions to the ZONE_NORMAL capacity
issue (struct page resize, huge pages) for possible capacities.

I also think someone should actively ask whether `struct page` can be
hosted on remote memory without performance loss.  I may look into this.

~Gregory
