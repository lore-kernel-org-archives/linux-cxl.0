Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792687603;
	b=V7ztEUIhJxNR/H5MSzVIwiFJeyvtHcY1gCPbhDRqBpmWAWPwJHclnlI7RdCJ9s8OwSNl
	 1ly8uA+ZAKQJTMlOnJew2brGXXKveSg9Wvhe5BJ6WPL+6xnq7S/+nVOWjp/MtIZlk5xlE
	 7EVgczRm/zTQ2+iZyQOT7OwS7qNkLr2ttArdto1WTvboCnPV3SWt4lX9StvoOHA6joBDI
	 Jkb8vxByjQ7c5Z7emfdGc4x2XUwdhAWsOAe9BC4QopkPYouFerBv+3mtwDJWxbdYTuRHI
	 RU1MyfhtJpXO7OoZ/t16oaY3PS4RdOfjQs10jxqh3xaelvrLBrq7rA6p59/iEuEITGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792687603;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=yBrOxbFSFCvT+f6YwccRu0+NATw9eg/EBC16z8r25jk=;
	b=YXwaiSVqH57JoACfvIhS0r1hKMNSjqR1B/UraOe0TVIeme4vrrJmYhYSY6xasXp6t5/6
	 dsaG7+a6UmdMDClP7Jx9czdfaolePi4Jx0ve7ra3hqSwi3ZcCmHxhOwDWqLysY9LvM6vR
	 wdb/U2x833wRld2hZ8HF4dZ1vXtewJI0oPF7pKi2Qh4XI4J2Tbe91AePwZFTlld8hbDOx
	 txT2nfGrTBYfT4uikdCRhuQZAd+SvKBunu0EOjvQHaxx9MV1Oavo0SHIVnb5UdP5EHZUT
	 kSesdb3Sj4b3gIwrYu4coo5g+c44QUbVRaPFJmCLDqRQfSss59tjRdN/jaqg5c18PFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=n8hoAo+C;
	arc=none smtp.remote-ip=209.85.160.177
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8021606A32D
	for <linux-cxl@vger.kernel.org>; Thu, 22 Oct 2026 16:46:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B8021606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=n8hoAo+C
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-5366463571cso22210821cf.3
        for <linux-cxl@vger.kernel.org>; Thu, 22 Oct 2026 09:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1792687602; x=1793292402; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=yBrOxbFSFCvT+f6YwccRu0+NATw9eg/EBC16z8r25jk=;
        b=n8hoAo+CxFauy6i7/WcNoAFjNgIEG0mAmL0g8lLDlpSzlUApelASfcNQdlOJMPXptK
         R/govxDtflumQfuKsarXH9RZTgktNL/BPWuU8k63zVwOK5e8GHGWXlIoc6L2rUpZAOUP
         UGBOCx/pJZ7ivbbNnfbO/DStxcUFCbagB1pYXRRR1N97nEeswVXCXSmDRFz9DqGFju5/
         12xLLAYoupr/q57CIIKuRWyfe1VVtgZrb+UqTRp1Z0yjW50l/67IuuceEYMnDy0Hna2T
         YLDD4mqrTV12VJzqGPOK2tuPE4IUzdL+tF+YVQwFJboeBgeZIdBSLXty5MlKrR5mg39X
         kxfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792687602; x=1793292402;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yBrOxbFSFCvT+f6YwccRu0+NATw9eg/EBC16z8r25jk=;
        b=t+J/X9tuRLYLFuWQHCO3aWb+doDFj1p16b67I7sstui6zFbXj33k75iO9Hjtl0EQz/
         q6QaGeBaQAOhPxNQ2v2HwY/JZWttkgopW8/EyKDHQrdU/yS/yduzJDTlHvK1HSsCz9Pq
         pWi+Q7eCKX9t9OldZlT49j07k7jfwoZIcAYq5eeKIHzxCYhQEm0LtcTYW2mYgNcXM1J0
         zMAlDpFb7Ce3pr16NbF1XEYzYTHtYo8Z3KhUJQaTYPDE36AP78MYvB3Hp2fltBB+m8Fo
         YF9xcUMLUSvUPFQX0gcDoC8kYocpLRKR2CSxZc9/Nh5VeWi/GbWBA+X7uyGCqUYKMnRe
         VEqg==
X-Forwarded-Encrypted: i=1; AKwUvBx4JFIXU5YIZXlBDwZzaaQp0dgLNWybHb4cNtGYpBnH3mLbh15/GRGrPmczR1e9WSBmLdM+a8pcoo0=@vger.kernel.org
X-Gm-Message-State: AFq9FYKRBdFKwrXDLy7Q4GR6KzXDWed4X/9/xgub8L5bc7xXZwUzbAjd
	/qgn1eE4yug/ZuHsG8xmmednKHLN1vDeCMQ/+G3h/vnE7wWoFE5+IYyfjXyBhcg26M5zCToeqyp
	COtqZ
X-Gm-Gg: AYBFou3uQ1rM8zY4vjCF7XKTno3pWE13X+0gdSeHrGFId/d+y6Gql4tyhPNZ/rFwF7H
	aqnDtSI6StkOlrs0S7+MaDMaDoU1WHxSlnMsScab2DIU56xtmJnGvgU9Phz+rPiKYRqiN19R6BV
	9OWQtQV3EAO+EUYvAVtovqCRquCM1cF16Y5EfXGbv0UszrBS0PRM97mWTjiRp0Bspua817eH+G3
	swdu7eJ83HRx0ZKvHnZYxwI07i4kP31ECfrn1ocgPjR0ROGRgLho2zs2taM4Ikt0UowDUMK37vQ
	fO5ZiTo4RolR7WqiWgHhg3deZ/CoSI6ZHozO30oPf8Dzo+xExgk5OpxFCee6MgKUFQzfdQ0A6lC
	l92jTDv1NpXHezC2c5ZU6YG7aNtHhuvLs4lQoDmwCm8lpp5Ek8LVeU+WjG3GSyPmvmIVHOzVCnR
	xKUHalRspBgPH4soJX8051165aeCCzD8PoOMKNdMGAsZCKoGVoAjUsinIPyC5mzW+nW7aC1rkMa
	dn8AnPee/YdiwUznQhtPJAJRKhlVfx/mw5DHkUJd12yCAenJk9xQtyUek5oZyY1dWvH3FZ1sN1K
	9iWERQYGyQYdZZexe0cKPxUSIcE7Bqwo7yEQxvm6uUqkaX1A
X-Received: by 2002:a05:622a:e197:20b0:533:3228:74ad with SMTP id d75a77b69052e-5369b8112famr65415051cf.34.1792687601560;
        Thu, 22 Oct 2026 09:46:41 -0700 (PDT)
Received: from [192.168.86.58] (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-536ab6cd0dcsm31216581cf.6.2026.10.22.09.46.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 09:46:41 -0700 (PDT)
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 3/6] daxctl: offline whole-device memory via atomic
 unplug when available
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: Alison Schofield <alison.schofield@intel.com>
Cc: "Gregory Price (Meta)" <gourry@gourry.net>, nvdimm@lists.linux.dev, 
 linux-cxl@vger.kernel.org
In-Reply-To: <atly9gd-Rsf-AoqB@aschofie-mobl2.lan>
References: <20261016214248.443247-1-gourry@gourry.net>
 <20261016214248.443247-4-gourry@gourry.net>
 <atly9gd-Rsf-AoqB@aschofie-mobl2.lan>
Date: Thu, 22 Oct 2026 12:46:40 -0400
Message-Id: <179268760050.4072493.10054383256417425305.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-10-21 19:20 -0700, Alison Schofield wrote:
> On Fri, Oct 16, 2026 at 05:42:45PM -0400, Gregory Price (Meta) wrote:
> > +	/*
> > +	 * Unplug atomically where supported, even if already offline, so
> > +	 * no agent can online blocks before a later unbind.
> > +	 */
> > +	state = daxctl_dev_get_kmem_state(dev);
> > +	unplug = state != DAXCTL_KMEM_UNKNOWN && state != DAXCTL_KMEM_UNPLUGGED;
> > +
> 
> Hi Greg,
> 
> I see you called this out in the cover letter, and that the kernel is
> deliberately combining offlining and removing memory to avoid the race
> before unbind.
> 
> But, this does change the behavior of the command "daxctl offline-memory".
> Previously it left memory blocks present but offline and now it removes
> them entirely.
> 
> Should offline-memory keep its existing behavior of leaving memory blocks
> offline, and use atomic unplug only when reconfiguring the device?
>

The kernel explicitly does not allow `echo offline > dax/state` because
this just creates the race we're trying to resolve.

I suppose my pushback is: why does it matter that daxctl offline-memory
changes in this way? If daxctl supports the atomic interface, it all just
works. It's a bit more work (additional hot-unplug) but if the memory is
already offline that's not that expensive.

The only scenario I could come up with is having two versions of daxctl
fight with each other (old - no awareness of dax/state, new - uses
dax/state) but is this a real concern?

> > +	if (unplug) {
> > +		rc = daxctl_dev_set_kmem_state(dev, DAXCTL_KMEM_UNPLUGGED);
> > +		if (rc < 0 && num_on == 0) {
> > +			/* already offline, unplug is best effort */
> 
> When num_on == 0, another agent could online a block between the earlier
> check and the unplug and that memory would then be removed.
> 
> I see this noted in the commit message. Is that worth documenting for
> users?
> 

Yes that's intended, and yeah should probably update the docs.

~Gregory

-- 
~Gregory

