Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41BF73EB0E6
	for <linux-cxl@vger.kernel.org>; Tue,  9 Jun 2026 23:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781046421; cv=none; b=c5ZTtSj52+UYT/zBJWClCtoSlLJ2icYOgFShAAEKC6dpLjGsM2iL7beNUQZWtYLA5mOCqqjXDRJ5YoqRK0zB9Qsha/Haz9u+TuNxoLrw8Dqpk3gG9cW2+L0pUw/uaHOHnkXxkgDii5OqS3HKuQNpuwEWRPQQMVxx4hC7LhX9BG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781046421; c=relaxed/simple;
	bh=1I7ozYIGveyezJ1/N0vK4hsJrxkJfgZQap4NoElgzdM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Bs9wfA+spq3m3bQf+zI0Og51ZnXC2mtr2UPFspPKr2CN1pMslvcfd1yVZjfCGv3LYHFGyjvQQk36CTzY5nEn0u9LYu3eIFjsZbl48eduRJ0mhI0vaf43UxBtRDTgJ2ALP3KV2/XFtjH4Ifqbz0oEBY9Ypi06RO9PEhB+vJ9ghjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MIlZdu+4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MIlZdu+4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0ECC1F00893
	for <linux-cxl@vger.kernel.org>; Tue,  9 Jun 2026 23:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781046419;
	bh=nxIvlxNdl3PsnLt4pGe8YvLYeqQCOCGka/A/IPj2uOM=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=MIlZdu+4AtHbeTme3YLnEih8B5xGuLP5/+pM9Kc2Vj7/n839z4sah768207yg0dNh
	 D7rjGgjjTyQXAXLIvAvmUnFVhVM5BISNBtbuL4hBBn0UITSteNBtdR7WTMAaXd1qLQ
	 53zRA2ugy2t2TUaeKJmhpscyWw6Iek5EMVs+ltf10/pSgMsSC7GIEz4xTxk2UEx8EO
	 GawoI971wHgfYYoEtrYs7t7uUp4NsXR0NcS03ouVKccH6WEJXPCXjJ2tUC/nq1iJRZ
	 ZBisjKI8o7gygP1uNW/jHuYa2NRlo+i1k0ZeXKVE84Cz8TuErVKabMQ0jGXKA5fKPx
	 EkyHNq88Ts5yw==
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id 056CFF4007C;
	Tue,  9 Jun 2026 19:06:59 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 09 Jun 2026 19:06:59 -0400
X-ME-Sender: <xms:kpwoamrNryB_8W8I42OopWZutEQdUS2p7-7HnhJ8eQWsVqi0aWTGgw>
    <xme:kpwoasGp8dguxcvmCAlz7hJESMHbYLjfFKaWeLPxaQYzmGy-Q3Losbfz1qSZ-p5CI
    2JrE3cwY5XDuzAilN13DrYqFsUzfas4ynRKGKoHTKBLuxh8rBn3eEE>
X-ME-Received: <xmr:kpwoaom10o3ZbwY7X5tYZvWTyPif1w4aMrTnQuvRv7ZJTNw-KhQFuPT9hcl8_uVbnp6bBhSve54S7ghmfMV6KWD8GtMzEt5p4k0>
X-ME-Proxy-Cause: dmFkZTEk51ABAM5OdF0gD8LdtQSh3fDIv9CnvMIKi4BSrvDPdqAjN+tC7z6MncgZdyhnfu
    CPaNIv6Z8uy4HzlIkUEROsf8vBHQSFEmWASUvpNMDMno017ZiTTxX0y2Zk1Y1zFIZfhPRo
    92TIbyK8Bi+9GLbulI+2IG1ZP6g3ba9nC9K46ID4MJpbjvsXSjdCXq5z2KQ0IC3UykslHa
    1v2AGYFo24aMdq1XRM4wauo6Sz1Xl1N/SaNAI0MIGs9hCijyRuHV5S3lWFixVD415+NeAZ
    oIiJkeZ67nPgpBwk5mr0StMG39kMwXCG6aYkuWN0XCBpTtfVpxEhQxXTDF30E5GyOfzOZ4
    5ObxAbvUmZ0xGjpiwvIx1zlG4SnbyQTl78ogyD83LfyjQq6+eEDWSGAsznhJNrUklBTwuI
    Awmnvil7erb/7Nx0Gsmvmft4iFmkcTR/2tJ6At0fivLWA9eLoUOEuCcFFRv697yGGZt5MJ
    XfUMo5BeaXJeptL1BgHnQ0BDX8GKFhvtNfwv+DWi+qMSDznZX4aJ9ILZpyoHysuikye0IG
    0afEckSC3Zl4Z9iWiVROpVO/zV/zyIcdvj62M+G/cZH5PDEfL7nJF2BxzmUXdFKRD0OP+W
    K7y11RoHftCJ+XMqt65WQ9kQgV40u3WmqXZoZ7HOC4Dk7g6jkbwdazDIisfQ
X-ME-Proxy: <xmx:kpwoavnk5sLFApXQiN866RnGEmp6g0tgGOANccpDvMdg5c33RjZBCg>
    <xmx:kpwoapuv9NseeTAmqynCWgdloTj2sDpl3Khbv5K7vbNPN9sDcuus8g>
    <xmx:kpwoaimIadQXJQCfAdvvsBw69UqElenOWm3EmGaMWHBbJCscuAuObQ>
    <xmx:kpwoakvZ4sKrR_eSegiBrnvVq6YLmWCnbzEUrAA35voSBokPvW00-g>
    <xmx:k5woaoenIoiEABj0BBAQcb38OvS3yXCxad8uwEvGPAgJmc8Uax1zFuIl>
Feedback-ID: i67ae4b3e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Jun 2026 19:06:58 -0400 (EDT)
Date: Tue, 09 Jun 2026 16:06:57 -0700
From: "Dan Williams (nvidia)" <djbw@kernel.org>
To: sashiko-bot@kernel.org, 
 Richard Cheng <icheng@nvidia.com>
Cc: linux-cxl@vger.kernel.org
Message-ID: <6a289c91955d1_4fa78100f8@djbw-dev.notmuch>
In-Reply-To: <20260607083040.70A0B1F00893@smtp.kernel.org>
References: <20260607081345.61954-2-icheng@nvidia.com>
 <20260607083040.70A0B1F00893@smtp.kernel.org>
Subject: Re: [PATCH v4 1/2] cxl/hdm: Allow zero sized HDM decoders
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

sashiko-bot@ wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> New issues:
> - [High] Logic error in poison_by_decoder silently skips unmapped DPA poison collection for endpoints with a zero-sized first decoder.
> 
> Pre-existing issues:
> - [High] Stack buffer over-read in init_hdm_decoder leaks kernel stack memory to userspace.
> --
> 
> commit b5ef0cd71d8dea661d93a7fc863b0b6ecc394576
> Author: Richard Cheng <icheng@nvidia.com>
> 
> cxl/hdm: Allow zero sized HDM decoders
> 
> CXL r3.2 8.2.4.20.12 and 14.13.10 permit committing an HDM decoder with
> size 0. This patch allows init_hdm_decoder() to enumerate these decoders
> with their hardware LOCK state instead of aborting the port. It also
> modifies poison_by_decoder() to scan the unmapped DPA tail when a
> decoder has no DPA resource.
> 
> > diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> > index 0c80b76a5f9b4..b61f51134551d 100644
> > --- a/drivers/cxl/core/hdm.c
> > +++ b/drivers/cxl/core/hdm.c
> 
> [ ... ]
> 
> > @@ -1096,6 +1100,13 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
> >  	if (!committed)
> >  		return 0;
> >  
> > +	/*
> > +	 * A committed zero-size decoder reserves no DPA. Leave port->hdm_end
> > +	 * untouched.
> > +	 */
> > +	if (size == 0)
> > +		return 0;
> > +
> >  	dpa_size = div_u64_rem(size, cxld->interleave_ways, &remainder);
> 
> [Severity: High]
> This is a pre-existing issue, but does the interleave ways configuration
> here allow reading out of bounds of the target_list union higher up in
> init_hdm_decoder()?
> 
> drivers/cxl/core/hdm.c:init_hdm_decoder() {
>     ...
>     union {
>         u64 value;
>         unsigned char target_id[8];
>     } target_list;
>     ...
>     if (!cxled) {
>         ...
>         for (i = 0; i < cxld->interleave_ways; i++)
>             cxld->target_map[i] = target_list.target_id[i];
>         return 0;
>     }
>     ...
> }
> 
> Since CXL 3.0 supports up to 16-way interleaving, if interleave_ways is
> greater than 8, will this loop read past the 8-byte target_list.target_id
> array and copy uninitialized kernel stack memory into target_map?

No, hardware should never return an IW setting > 8 for a switch port,
but that could be made more explicit in the code.
