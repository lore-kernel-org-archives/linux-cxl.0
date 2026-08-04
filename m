Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D5346EC92
	for <linux-cxl@vger.kernel.org>; Tue,  4 Aug 2026 15:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785858328; cv=none; b=u5LaJniL7NfQVIN23+BCX4T1RaQQfufTuVVsMK1yx/8i3h4DZJF3pwVR8817DE1K9rQyQaTudf1Pe/EFepaRoeKfd/WZleJv4bYEX/uBF0FnHKSWY2ArmEUyjCioKEpWC1SRLkx//778eoBuJxq4Oa1sb6bJY1Hz0u9p7+AIzG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785858328; c=relaxed/simple;
	bh=udcDnCZOafJFJBg/CawTNl6gae2dFtyKioVGErWlQrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R1oCa+6ZnoSVhQewCcbYyrqBq9a5UKfmpPn3xXelFyg8vzgMC5R3rmYFpxeULzXTm3NrqPzFlKIvlrr1tceOsBLyZeJh5x15ozuqL5LiGCnQQMRVs4t+QxEgjAV8KyVUp1XCmgW7M9PX0VY2mmNrvzdRF6pX/WOKqrIEz0jTnKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=FxmdHqCQ; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="FxmdHqCQ"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-934956bee57so415404785a.2
        for <linux-cxl@vger.kernel.org>; Tue, 04 Aug 2026 08:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1785858322; x=1786463122; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EwAZOjeHlqWn9v6/BYYDkI9dqxumArr6QgC+CpKgPx8=;
        b=FxmdHqCQsJIzOzLRaXOvvoGvXgSN/NR9EToj/FKsuQ1JaV2770IfumQH1YF0CR8Rjq
         p9r4ph3qXVTorJnXJuTn2a60Ep1pDQicGhOxntvAaMcXZ3uV6eIRCKYqeTNjlSwFdo+y
         L5/KO6cw9mvQKonXOnqforSK7UnmLOTq2qeg959jtcOMedypZ39+YSeEb51u8ZjYV6EF
         2qH1nUB5Gd73c7W6GQ8m9POB73eJnfROA0SsuwrueX0F8yTJYlH/7VH83W554jNX/w5v
         R+4UAFvYYHTXGRjItPhlflDWBCkPub3UID7VhsC9yt7mfKqX69UF3C2b//DRqdTw0Sz8
         OqJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785858322; x=1786463122;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EwAZOjeHlqWn9v6/BYYDkI9dqxumArr6QgC+CpKgPx8=;
        b=L9yRD3yTc6Fsbtuyo3avbjFFtFbkkf7SibwHbgQk8sDn05bQnqO6ILVKkdXMmiGncN
         9jEtush8hgpl3UcGK6tWSV3oh16l8dBQMg1hptzWpI8SPqZa6yCz1UBvnHLlQcNZSghc
         /TgPxRRmoGRLRrIIofwhIq+GsGNaFwYceZwzBGG4oNNXzJn7e5yNAVE5bh+wyj0MGMsi
         QqTtp3YGQVgItfkrO7ANlbwxU+z4+oMwD2RKV03E6s7s1g2yw7OA3nHcfxVKInuY+4EL
         a/fZ7NB/9nkHntSCYk/7Z6y553tE3mmiwqTTqv3xa3PEbF9s1wIEMKbCGP+SeaJVg2B3
         fUMQ==
X-Forwarded-Encrypted: i=1; AHgh+RqbgMP47NrXaFFXEML1KsX4C8ji4XnaGyXZSouvKhO3bVYU3aG45r3JFORemAVaGNjFLikwIMaFGBM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeiaVEslaai8L8o2VItVSWdNPFc9nlhooMm1tdGo+vy4TtB0f6
	UPlHd7WodsrNJinwJxTUfeKcaGkZL3YdANIqCqkTXoaCkBWlnRBwrw5V7hICOvyYwkU=
X-Gm-Gg: AR+sD109/OpmDLTPEswQvZ/UOMN0LBNdqrUHdda8DMfnD0p8YEwaM5U+/NHceyFohDm
	SaiU71C9wmB4CFih69Z97lSLqT3+XCRIfMEDG72mVSqdgBU77/KvYv1fm4HQQ+sv9AvNCJEM+eQ
	rVzuIy4lmC2en1dRGyNnV6M5c7aGuXZ2tL45diegXQeuW87PK2xq77lrJ6HQMSSeFbPy/OfP/eO
	fJWbgS8a+hL659W/duYQDLK74fZEARL0+wY2XYb3/8HCBmsWGCwrTGBP4IZNvwAxsmIZe//bohO
	FIdkzPw1O+LxbEaxxaSvnf+yArNGDRxr8mdQvBhnzefs+yMv/KQyw7t/jo3lAyMzFtDx7ZFhawI
	I3j9Z8fJw1E5QiyLanxHpD3LKhgw4db8LPPCOl19jCmolT2ZIcqqwCZQ5EYWcbjmnxnq3es5L1u
	Px5L/+FH6mbegcyGp9GnhVVA68bYStkRhiSW98ol6U+8jcnVY+PDEAU1b2BOGsKvfxbeZSWbGp4
	kCEH2weT09HrBOaBfLaJnXbBiUmB+wPQYEIbOWO4t/XUSkprxr+4RM=
X-Received: by 2002:a05:620a:3c11:b0:931:369:ff0a with SMTP id af79cd13be357-934a0a705b9mr2027822185a.35.1785858321563;
        Tue, 04 Aug 2026 08:45:21 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-936418e2f7dsm103209485a.35.2026.08.04.08.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 08:45:21 -0700 (PDT)
Date: Tue, 4 Aug 2026 11:45:19 -0400
From: Gregory Price <gourry@gourry.net>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Alison Schofield <alison.schofield@intel.com>, 
	Anisa Su <anisa.su887@gmail.com>, linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Dave Jiang <dave.jiang@intel.com>, Fan Ni <nifan.cxl@gmail.com>, 
	Li Ming <ming.li@zohomail.com>, Vishal Verma <vishal.l.verma@intel.com>, 
	Davidlohr Bueso <dave@stgolabs.net>, Ira Weiny <iweiny@kernel.org>, 
	Benjamin Cheatham <benjamin.cheatham@amd.com>, Wonjae Lee <wj28.lee@samsung.com>, 
	Junhee Park <jh9934.park@samsung.com>, Heesoo Kim <habil.kim@samsung.com>, 
	Anisa Su <anisa.su@samsung.com>
Subject: Re: [PATCH v12 1/8] cxl/mbox: Flag support for Dynamic Capacity
 Devices (DCD)
Message-ID: <anIImeZdIa1lRbtc@gourry-fedora-PF4VCD3F>
References: <20260731084901.1512819-1-anisa.su@samsung.com>
 <20260731084901.1512819-2-anisa.su@samsung.com>
 <anEIZOTDKsj15Nhp@aschofie-mobl2.lan>
 <20260804001245.079b16ae@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260804001245.079b16ae@jic23-huawei>

On Tue, Aug 04, 2026 at 12:12:45AM +0100, Jonathan Cameron wrote:
> > 
> > When I view how this lands in the entirety of cxl_walk_cel() it seems
> > to needlessly be different from the pattern set by poison and security
> > handling in the same function and structures. Could this follow that
> > more closely?  Doing so would remove this 'tail' work here of checking
> > and setting the boolean.
> > 
> > This appended diff touches patch 2 where it has the first caller, but
> > pasting all here for simplicity - you'll apply per patch if you take it.
> > 
> > The bitmap lives in mds structure and it is already where the bool is now.
> > The only piece of the poison and security pattern not worth copying
> > yet is the wrapper struct cxl_poison_state and struct cxl_security_state
> > exist because each grew a mutex and other per-class state, and DCD has
> > none of that in this series (yet).
> Hi Alison,
> 
> This rang a bell as I remembered Ira did it this way originally -
> so I did some archaeology.
> 
> [PATCH v8 01/21] cxl/mbox: Flag support for Dynamic Capacity Devices (DCD)
> https://lore.kernel.org/all/67786b76a0c5_f58f294b1@dwillia2-xfh.jf.intel.com.notmuch/
> 
> Dan's point was that we need that infrastructure for poison and security
> because a subset is a realistic possibility. For DCD today it's all or
> nothing so why keep a bitmap around?
> 
> I agree there is merit in having all the command types handled the same
> but perhaps it is clearer to just have a bool.  Of course when someone
> adds another DCD command on the device side (which by definition will have
> to be optional) then we will need to revisit.
> 

Yeah, and it's not really binding ABI so no need for complexity until we
get there.  Honestly the feature bit check is essentially the same as
the bitmap check at this point, so seems find to push that
generalization off until we actually need it.

~Gregory
