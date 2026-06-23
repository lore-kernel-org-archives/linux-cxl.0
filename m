Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E04738886C
	for <linux-cxl@vger.kernel.org>; Tue, 23 Jun 2026 17:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782234083; cv=none; b=ELGL3qbRnFS3wm55WsTjtUw2pSEk3Pnil8zbaKtuS4cHlYqkKA1SR2NrG8B4WL53Ts7YytzmchOpLFzQIDWC4EqA4v6nlEVDC7xSt8to3BK0LMGagNnoSxUu3GIEjIF1wdyUfJBKQVzhEbzAeyzoH54Rn43Rb0PbGeo0I2uXTNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782234083; c=relaxed/simple;
	bh=drTPL+/4sCDq7xFfebBhZN9MFM/p9D5us+A1LEs9MHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nAmKxdOI92IDzrhVbY6X2XougqxkyZaUqP/SfUfxnifX9WR8SbxGkKzNrxE+PWOsOzIMR7GSS1OHKeUZTKPxzXCwJNOvsiqXI7dgX2M71+WSIYt/ESMlp7HK+v3zM95GPwIgzghj2ANmG1mbN4yN0ttpb1XoeRn7toPBMpgKciw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=FEqdijxc; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="FEqdijxc"
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-59ebcbfb2b0so29854e0c.2
        for <linux-cxl@vger.kernel.org>; Tue, 23 Jun 2026 10:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1782234081; x=1782838881; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xvgEVwQ8jfCIcJ0ba/B6osmLE2ZzPQbQhunldQ5OJKk=;
        b=FEqdijxcJOXaYeegZW2MMFnBE3mkI8rzXD59lYgpIOwGvh61Rxt5ZrGQkDxfwNrQMU
         HCA/HAzLxUOmTEFCUMaNlwAdjQxTZF/MX522fK+P9nZeJ9w1xfFm3FLXLTsatuaSjRV/
         RE16PEHWdBvXn/LdxQGn1xMgVKVW4A/6nAP4Nl7ZpyqOy1ii/YeVIzc15XbI7Ck+BpMC
         o6aakjzyiDANXbMf+h7k52ij+lguBMw4AAvDw1qPvn8u1VyOYEx5lljp6XwM4MTWK1XY
         T0o+uz2L6/HLDCu9b0DIxT6ssCMJm4u99VP0B0GQ6BJz1kmYTj7vCpZM+xAvpMb5SQSG
         8rFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782234081; x=1782838881;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xvgEVwQ8jfCIcJ0ba/B6osmLE2ZzPQbQhunldQ5OJKk=;
        b=pvhdEowjFpMV62C1MyJ7VlBPFg2YExvWrNyNDpdyeZtbnLppt7mk4hU7SeV3dNdgxq
         AbGsDb9P8LHBjN/11cTJq4aOHWK7yZemRBdR4GvQMxo9oVUAt9vVpXZmqibKu/LSYL+Z
         5++Y3erUA9NvkMdaH47749bwtreRk0Ynl//OFbGnMEPaovHWxr26/WXkESVSnXe/mdR1
         MPiwitoYDygQdPxjUSab7j57Wl0YgmX/Bg8/B3umFjx0xrkjOyplz056Tur5RtZdyq6T
         472pQsSdFCeKqlK5Bxc3vShasonHl0E4mVstk0QOGxjm0SCwXaz6Jx9FIN7V2rtzewU2
         g4qg==
X-Forwarded-Encrypted: i=1; AFNElJ9i4Lf52FzCkOdp4kgGBfeSmBULRtKgiZfdCuATQPDjPxS0mwkcEjXDqwNe1byS2wi51bgnIxyfayM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvN00+lEUC17cEH3qyL/OvABfJlFKA/TrYY8N7Oe1ot2nKv05d
	wKnC6jRo/VEPizxEOlcnr0HYJFNNTQhx4QDPZ2jCjblpKzpQoIx5EzPprjnnyX6htrg=
X-Gm-Gg: AfdE7cl0aebrIfNtpfOFXCQyyXYBUOUjJnDURJBWvagNL17nNkXNYg6a83Ks3ncpFkj
	z59i3xUDezmLWniHYNrPO/PNcKR5TBM/mjgJrjW+PbHbgREr3tnxvW8ac+BhTFRUFLDn3yZUOFP
	WwAebpG+RsOPM9mjnM5LYzPs60+gjtW3jNbo1FDYaQdlymobowVA/c01T5aPD1lFb4qb0f4FlrM
	N6iuI/oj5Oc2DFYYYlALyokQXMJdker5t24E4KYSa2M5aRNEizKgr324XWJJJRq/YESY3nvGGr/
	cc7oTMFnX2nA0zmpJtrzezd3AYpTyh0CMxYqkZEM7qQSnd/XETuqbuctBVzwGFB+reiMtu/qy5+
	eAeeufmEl+fL4jGUf466U9Wt7aF6Uq2TQTeFvMl4J7rffFxT7MJUldVHCbvKfx5zePYjHpDnuza
	/WWoLQx9CeKxqHuZunGlCEd9MWJbV3iANNY9sh8BD594VP4MQNdVOShsAJvDodDHGKViCx
X-Received: by 2002:a05:6102:8089:b0:631:e729:4575 with SMTP id ada2fe7eead31-72ff3f7fea1mr2054044137.5.1782234074396;
        Tue, 23 Jun 2026 10:01:14 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9260079070bsm327795185a.40.2026.06.23.10.01.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 10:01:13 -0700 (PDT)
Date: Tue, 23 Jun 2026 13:01:09 -0400
From: Gregory Price <gourry@gourry.net>
To: "Dan Williams (nvidia)" <djbw@kernel.org>
Cc: Richard Cheng <icheng@nvidia.com>, dave@stgolabs.net,
	jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, dan.j.williams@intel.com,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	newtonl@nvidia.com, kristinc@nvidia.com, kaihengf@nvidia.com,
	kobak@nvidia.com, vaslot@nvidia.com, smadhavan@nvidia.com
Subject: Re: [PATCH v4 0/2] Support zero-sized HDM decoders
Message-ID: <ajq71cLSc9kb0Ffd@gourry-fedora-PF4VCD3F>
References: <20260607081345.61954-1-icheng@nvidia.com>
 <6a289e3665fc5_4fa78100b1@djbw-dev.notmuch>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6a289e3665fc5_4fa78100b1@djbw-dev.notmuch>

On Tue, Jun 09, 2026 at 04:13:58PM -0700, Dan Williams (nvidia) wrote:
> Richard Cheng wrote:
> > Hello,
> > 
> > This v4 continues Vishal Aslot's "Support zero-sized decoders" series [1]
> > and addresses the v3 review of patch 1's port->hdm_end handling [2].
> > 
> > CXL r3.2 §8.2.4.20.12 and §14.13.10 permit committing an HDM decoder with
> > size 0. BIOS commits and LOCKs such decoders to burn the trailing, unused
> > slots so the OS cannot program regions through them, e.g. a Type 3 device
> > in a Trusted Computing Base (TCB) established via the Trusted Security
> > Protocol (TSP). init_hdm_decoder() rejected these with -ENXIO during port
> > enumeration and aborted the whole port, so affected systems showed nothing
> > under 'cxl list'.
> > 
> > Patch 1 enumerates the decoder into the topology with its HW-reported LOCK
> > state and skips the DPA reservation it does not need.
> > 
> > On port->hdm_end (the v3 review): v3 advanced the watermark for the
> > zero-size decoder. sashiko correctly noted the write was outside
> > cxl_rwsem.dpa, and that advancing it without a balanced release strands
> > hdm_end -- cxl_dpa_free() returns early on !dpa_res, so it can never be
> > decremented past the zero-size id, breaking LIFO teardown of lower
> > decoders. v4 therefore does not touch hdm_end at all. The in-order check
> > in __cxl_dpa_reserve() is its only consumer and is never legitimately
> > reached past such a decoder: the burned slots are trailing, so enumeration
> > reserves no committed decoder after one, and the OS must not program a
> > region through a locked slot. hdm_end stays at the last sized reservation,
> > which is accurate. IMHO, if a non-trailing zero-size layout ever needs
> > support, the check should key off commit_end rather than hdm_end,
> > out of scope here.
> 
> I am not comfortable with this outcome. It assumes that zero-sized
> decoders are always committed. I would much rather keep the meaning of
> hdm_end as the marker of the last decoder set aside for a reservation.
>

(pre: before a program[mable] decoder,   post: after ...)

Pre-locked zero-sized decoders *must* be committed if the non-zero
decoders are programmable.

Post-locked zero-sized committed decoders *are not legal* if the
non-zero decoders are programmable.  They can only be legal IFF the
entire device came up with decoders programmed and locked.

Violating either condition implies an out of order commit has
occurred, and trying to deal with zero-sized decoders as a
special class is just a giant footgun.

Covered this here:
https://lore.kernel.org/linux-cxl/aPeSqjqU6BH9gvcw@gourry-fedora-PF4VCD3F/
https://lore.kernel.org/linux-cxl/aYynWqJ7u-v-6WsZ@gourry-fedora-PF4VCD3F/


So,I agree that zero-sized decoders can't be assumed to be committed.

Consider this case:

            Pre-lock                     Post-lock
decoder        0              1             2      ...     N
------------------------------------------------------------------
	  [zero-lock]    [programmed]   [zero-lock]    [zero-lock]
          ^ must be committed            ^ must not be committed
	                                   unless D1 is locked

Anyway, agree, zero-sized decoders cannot be assumed to always be
commited, and the spec (or at least my last reading) leaves it
ambiguous what state a zero-sized decoder must be in.

~Gregory
