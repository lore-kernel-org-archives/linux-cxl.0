Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621B52DB7AD
	for <linux-cxl@vger.kernel.org>; Wed, 11 Feb 2026 15:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770825567; cv=none; b=TD4B8xCBY27FHcIgku4IpE4SNCP7WYSA7MKRkAP9UFhDSngO3isCX9XfP77JlXEP7Vn1uEzOJA+QYSzLss8xA39cWCCSRn3tEg2OG37HeKfLCqYWF40FqNPNBl6wkTeaBwS7qhBcOPiC9QTRKgU7TxKd/Bg+G/1xPUTxU8V08vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770825567; c=relaxed/simple;
	bh=IKUNIkEymglVf4BArYHDRxPhT6lG79lU/pszt7Itru4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iI8stdJ3yr9Q57tYke1RjVXm1Ma8GLI7+i1siWqDxf/00VJ0aetKEYIOAm0MmiTk6ZbR7EUTjrSyvqUWmKveGoen20ZqorFFFAo7yfX/mGiCeUFzzk2AdJw3tb5Q4rlDm2otV1JM3LGmF4gr3yVG+msGJlPg/B2ORidHQk0rUEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Gz9k/tQ5; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Gz9k/tQ5"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8c532d8be8cso651598985a.2
        for <linux-cxl@vger.kernel.org>; Wed, 11 Feb 2026 07:59:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1770825565; x=1771430365; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=d6RAzUSXpBXql+F9ay58cLMbqKb0I7SnNahqduMaG0U=;
        b=Gz9k/tQ5DXjaqatbqgzegv2A7jxsoqQbbhQV1PWY4ZxSLD2kCu51X9GIvl3NgIPqdb
         AQzXPlSHzq78UlEXtPm5EmvJc3jFM8cGxYExpvcKpAzPTxTv7HGekTFIbGV8ml7PKdaY
         nZ8bSpgFiKkAztAc1F0Lrj/zl0MCfMyuj7Spa4Tgl4i974sSkJPkq8hYCSfjvlpRce5S
         xwiMuoIsq4nqkllXaaPU4EfglXVcl1Bj69eO52YCUms9S5Cbm7cUi9+SB71o4KyjnJIk
         yj439usJWaW0m6AInf5KkKPQ8/ucBjygsEiL6HT91srd373LvCzk+NZJzcvCqK0Xxg5D
         7yAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770825565; x=1771430365;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d6RAzUSXpBXql+F9ay58cLMbqKb0I7SnNahqduMaG0U=;
        b=v3JeAWmhyrYSo8pL2RLoCnEpp3MC9wjM+6os1zgOGtlDK+9CZX4VNGRBBKq8HdI7ia
         mduiRZwRB8eDS5zjum4ZSuwTrcffvnqRAXSlsQuhjC/pQi0fIa+J0qIu6Y3aZTT/0ISG
         84UKBJAsLluyEVjlVxk7wy/wMbieg3EHoFMG7t0Oa/CK5WUmLITfUAV/ubHwx0Sxcn3W
         FrcDtJOANeYhvPxX9Bc9Xa3G1BM/P6Nh63SPfZ4W9lOpgOGfA7dUF2bpZwBUS/+p1tmC
         3RQSBYFSg4uh+dr95/EVl1a6FKuRDYFjm0Fg+DfTZCU9tIAjkZ/CVLiZyTZ7BS60CFSh
         DxTQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9+EIw2tW7KjnSKrkoCUXgQ0FUCniX2CQsqj0oOz81Td35Ld8sjbZ1SJ0unUghz797tKpVpAXoxTw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLKXg8Tqtikl3IFraRagzco9aq2N0DxZL4oGAGMLcGgKj/3sLC
	Djp5CPhoH/5lVY5m5bb95McasOcdXd29xtfFMnWeLTjgohW8b100PivFGFg7G70B2w8=
X-Gm-Gg: AZuq6aL8CNM6wZDa4u4KMRhmGXd8AT+T6TkY/5bxIwS3g+InRENvnVeE5cnaOBH+6w6
	Yqs86KqSUnXysryyAiSwxhDlxg0zIxKwIsuUxlyOBFFUCFHhn/8S5epTj6BIGEYlQKJ2qn2vPsb
	KuGllZ7jM2OXCZb4ikTm9PUtdKLcU7ffBYTp5jX67s3TSpZJ1ykLsNsN19JF5eFmfdJm4b3h2P4
	Tu4Zk6mgphMGgZkfSMwtr9lpI4fecUtMK747FGlKtLdR03h0Bzr3J6lnOeRN3gpgCShZnVKZJrM
	7iolEoa7DVVt+AeG3eieQ/R2/M0t1Lmv2HtVHId8XRcGhaNfi9D5EyptpB6IiUFvgjmWogHQCvl
	VdUzjA2I/MGKxmSnJeENYO2ldCvZiAe88oBnGxP43wrWZo4cDARF7Frlx0yg3MNfh/SbO/5+Lzx
	0fa8rhO8X3EqLc2kXWxGU07nll7jxLrBdognEvWY+QpGMMDPcT5ThnqBNqR0BWip3l3BJ/M5ecZ
	+IaasYZVw==
X-Received: by 2002:a05:620a:3184:b0:8a2:3be9:1d79 with SMTP id af79cd13be357-8cb2a2bf77emr255258885a.18.1770825565157;
        Wed, 11 Feb 2026 07:59:25 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb2b20f240sm139552185a.40.2026.02.11.07.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 07:59:24 -0800 (PST)
Date: Wed, 11 Feb 2026 10:59:22 -0500
From: Gregory Price <gourry@gourry.net>
To: Alison Schofield <alison.schofield@intel.com>
Cc: Vishal Aslot <vaslot@nvidia.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Li Ming <ming.li@zohomail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	"open list:COMPUTE EXPRESS LINK (CXL)" <linux-cxl@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 1/2] cxl_test: enable zero sized decoders under hb0
Message-ID: <aYynWqJ7u-v-6WsZ@gourry-fedora-PF4VCD3F>
References: <20251015024019.1189713-1-vaslot@nvidia.com>
 <20251015024019.1189713-2-vaslot@nvidia.com>
 <aPXgLp1Em6wKlx0t@aschofie-mobl2.lan>
 <aPZE3Spas-IvHmfd@gourry-fedora-PF4VCD3F>
 <aPaNzeGqUHf6gGIu@aschofie-mobl2.lan>
 <aPeSqjqU6BH9gvcw@gourry-fedora-PF4VCD3F>
 <aYyaicFMzfsd8eSq@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYyaicFMzfsd8eSq@gourry-fedora-PF4VCD3F>

On Wed, Feb 11, 2026 at 10:04:41AM -0500, Gregory Price wrote:
> Revisiting this - it might be reasonable to allow post-lock ordering if
> *all* decoders in beyond the programmable one are zero-locked.
> 
> Seems ok? Thoughts?
> 

Sorry, got myself a bit mixed up, lets me a bit more precise, there are
annoying corner conditions here that make reasoning about this
difficult, and the mild ambiguity in the spec doesn't imbue confidence.

[open] = programmable
[programmed] = usually auto-decoder, but some cases may allow runtime
               programming, i haven't logic'd that out.


                    Post-lock   Legal
decoder        0             1             2     ...     N
------------------------------------------------------------------
            [open]       [zero-lock]  [zero-lock]   [zero-lock]
	    [open]         [open]     [zero-lock]   [zero-lock]
	  [programmed]     [open]     [zero-lock]   [zero-lock]
	  [programmed]  [programmed]  [zero-lock]   [zero-lock]


In these cases you basically act as-if the zero-locked decoders
essentially don't exist.



                   Pre-lock    Legal
decoder        0             1             2     ...     N
------------------------------------------------------------------
	  [zero-lock]    [zero-lock]  [zero-lock]      [open]
	  [zero-lock]    [zero-lock]  [zero-lock]    [programmed]
	  [zero-lock]    [zero-lock]  [programmed]     [open]
	  [zero-lock]    [zero-lock]  [programmed]   [programmed]

Again, in these causes you just act like the decoders don't exist.


                           Illegal
decoder        0              1             2      ...     N
------------------------------------------------------------------
            [open]       [zero-lock]      [open]      [zero-lock]
          [programmed]   [zero-lock]      [open]      [zero-lock]
            [open]       [zero-lock]   [programmed]   [zero-lock]
          [zero-lock]       [open]      [zero-lock]   [zero-lock]
          [zero-lock]       [open]      [zero-lock]     [open]
          [zero-lock]       [open]      [zero-lock]     [open]
          [zero-lock]       [open]      [zero-lock]   [programmed]

These cases are all illegal because there is always some form of
decoder committed out-of-order in the presence of at least one locked
decoder (the zero-locks).


                           Questionable
decoder        0              1             2      ...     N
------------------------------------------------------------------
	  [zero-lock]    [programmed]   [zero-lock]    [zero-lock]
          [programmed]   [zero-lock]    [programmed]   [zero-lock]
	  [zero-lock]    [programmed]   [zero-lock]    [programmed]
******    [zero-lock]    [programmed]   [zero-lock]  [open]...[open]


In these cases, it's only really legal IFF the programmed decoder(s) are
auto-decoders, because it means an out-of-order condition is impossible.

I think you can validate this on probe, but it's annoying

if zero-lock decoder is present
	a) all decoders prior to the zero-lock are locked (zero | auto)
	b) all decoders after the zero-lock are locked*

* if an open decoder appears after a zero-lock, all decoders after
  the open decoder must also be open. (supports corner case above)


I... think that works?  It's annoying though lol.

~Gregory
