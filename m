Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792687231;
	b=Cewu2xrEgGA18r72G5cq/pFxYg9t3D0fAJdEhnyBdhBq/JlRuRzDGW/QmYsk3oNN2eRw
	 JHiDR34D/Wog2VVkjhtGu2fwqJ/8FXKU8nyCTLdmesddaEr936QjzjDFC8XQq1H8NTFMO
	 8hcoFLC1Zpe3W3j+Xv10nPvmqA8jDbXw1Ps4fda8EI9zugA4Cs3gcU07Qd/R9UlMAmv8X
	 5ytN5kjrCPEbDqk/5YIAQ4yV887Sd6GDjglM6SsHENy39YgNSW5b9oZBI4zGCJuqknzFe
	 5tf5Tc9w7NqSsrfF1b8KY5vh9hU1y1vg7aapvCtO9IYoVQ95Bn0LWrf9U6lslh6XDIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792687231;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=pBCWQ7jscdfKZcHIgslgXKhcbj8ko2Frw+3Y69vYvjU=;
	b=DtShdnBCX1Z2mkO9Xap7YIV21FKU33GzSVAye3KO/VNKzM+E6PpNvpXvXXM9VQ6FaYsv
	 kIiQBnCcIbPw7yOdrCPrY9Cm+TnkL1vaWZrOqmHl98JR71usZzM7k07WVTf9lhiDKp3sY
	 Qn83WyGJEVCto6BbMFoasAstQx1oidn29sd9Ef7piI3bIErvylihPfN7HiQotd91sm5gj
	 sXiDtwZt93isb9HpR8Jx1Qokzl+kQkYoTtNA1/0ePpE5naKM7HxtmYbdGKbdCheJBqQGH
	 4Z2EG88Imm+RUjghOtHbzVc1dk7nw/tqhwm5r4fYN/WGxizYONcEXp2El5ukNm+iy6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=jAT0T3jb;
	arc=none smtp.remote-ip=209.85.222.171
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC1D606A31B
	for <linux-cxl@vger.kernel.org>; Thu, 22 Oct 2026 16:40:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4DC1D606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=jAT0T3jb
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-93e4c00d71aso220549185a.3
        for <linux-cxl@vger.kernel.org>; Thu, 22 Oct 2026 09:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1792687230; x=1793292030; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=pBCWQ7jscdfKZcHIgslgXKhcbj8ko2Frw+3Y69vYvjU=;
        b=jAT0T3jbrY+4q8F+V6rIRrgFs+wEAK/kxFUjg4VMXiR8FrEqqBoFQFhxhMWKr+YPiL
         myzlKAmHJPL8N0q5qaVLeC4ef4bzaTJXgSXgjnpjrC+yDJuBn9g6R23Sa0m9h+Wqs65Y
         Q18dEzwzC/VqutGQVoH9wlsDq1d3wTdVzQ8MWIa7y05Upf+BtC67AHH7qWavQqRYlqIV
         6MjvEFWmF51gMLYXNWuoJsnak73Gc3T8zvztwcrbcJF/nVIaB0s/LSt0MYcNA+j5h9R3
         GxmGsUypfwzTM6FrLO18UtYaQthsXREwmsdS9Vrqq9eeB4pwn2iXkxHaLEfB0m341t5z
         fmDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792687230; x=1793292030;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pBCWQ7jscdfKZcHIgslgXKhcbj8ko2Frw+3Y69vYvjU=;
        b=y2AyOThLkcz3giU2qBMrF0Xc3QiqyMjc9SOilSXBAszUuIH2DT1/1dpI6uDmUOsS7V
         x2z6qhu37TgN6DrOgaSUNhixfZkHCUcBMrgTtsl8z3Qg8Mu+ikVzh+bAO2pwtLd27Ul/
         Y9i99MOZiYXhxFUwX7dz6x6OptX4GGYz6VogDANqAT70wc04IAuND+Et0hf+ESuNnQh7
         J3UkU5Nb7DF2e02+/JanaA/9lupz4ETEtFGxVmW3JASbPImtKG2Oqstowu7ovpiXEeM+
         p6EkXBeJ8HfGnJS/0FXAo0agmfhAOfltA1gYaja2w3NwX/6TL9ldHAZY8MHwpsMVi/N4
         Btaw==
X-Forwarded-Encrypted: i=1; AKwUvBwhMnRoHsnI+lIFWlQP+4i7Nqvwh83qzddJ2TugZ0SY20qGCv3r3GS6w/OI62u3Xhrp55vWy2knEuo=@vger.kernel.org
X-Gm-Message-State: AFq9FYJX3NzatiEdwqPWGUnHhlPdN8iabbA9edj6Qy/8mE5z75PTeShu
	jtZX4kL//bymdrIIzZHEu17812lXdGUd4D6n7yQtDS9MavfnwoYDh+XmAfqQ7cT8X9Mpj0W8co6
	O9r1j
X-Gm-Gg: AYBFou3aDE0jHH6emkFKDall4VoGoXn5FTlTWzkf5/NjDFvjJ9CvHFmZ6bpCdsUXECF
	vHotv2X+ovkwGoz/pkwHoSCJRdmk3XukeM4xdoz9/WSXe9Bc3FJ1m1wiTOJT/bIuqxcElJK7Knc
	u98k0ljqguB07npYN9PPmwZkssVdGDsFgk5YSbadm4aOhm/XGK1oA9UmLI3QGaw7GvMhwD7nVOb
	V8kXVY3lklsEeHyBTZMva4TS8cEkSIIzt2W/i54wMNKj0rCojVYq7ZVQ4lYxmzhceDrFfqOWwrQ
	e5OyZzqJXC1vTSOD0ZDsmJNbkW7S7mY4ZSqnVVmcKZjbeVluqbLlp9UzOm/T0gdUqR8j1V6veV+
	a/aNsNgE2PZDxdw2R/7tnp7pjqKdMEZKwRhuejX523eQvRw6wlttC9KjYpoMUDyNB/Df4pQyx0n
	7AInc+4k6pW5woR3ydaA/sFcyXbvHGZyOIpxrl+l8BWE6iJ74VosiOMcIMFW68HM9UKWsJAkeGQ
	LlKoYx7uD4roqnv47ZR9IXbxNzYgoVNrI0tg+uRZANgm1IDwy/+Np8x+qkZKPtfMfzHM/XmtMuT
	FqSjoBhhmnB1uvJEgGMaee1sb8w=
X-Received: by 2002:a05:620a:4394:b0:93f:38ee:68b9 with SMTP id af79cd13be357-93f6f657640mr3328385a.28.1792687230176;
        Thu, 22 Oct 2026 09:40:30 -0700 (PDT)
Received: from [192.168.86.58] (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f56e1db54sm552080985a.36.2026.10.22.09.40.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 09:40:29 -0700 (PDT)
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
Subject: Re: [PATCH 2/6] daxctl: online whole-device memory atomically when
 available
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: Alison Schofield <alison.schofield@intel.com>
Cc: "Gregory Price (Meta)" <gourry@gourry.net>, nvdimm@lists.linux.dev, 
 linux-cxl@vger.kernel.org
In-Reply-To: <atlxIz7uZhH9y_ac@aschofie-mobl2.lan>
References: <20261016214248.443247-1-gourry@gourry.net>
 <20261016214248.443247-3-gourry@gourry.net>
 <atlxIz7uZhH9y_ac@aschofie-mobl2.lan>
Date: Thu, 22 Oct 2026 12:40:28 -0400
Message-Id: <179268722868.4072493.14547635108872148543.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-10-21 19:12 -0700, Alison Schofield wrote:
> On Fri, Oct 16, 2026 at 05:42:44PM -0400, Gregory Price (Meta) wrote:
> > From: Gregory Price <gourry@gourry.net>
> > +	if (param.no_movable)
> > +		target = DAXCTL_KMEM_ONLINE;
> > +	else
> > +		target = DAXCTL_KMEM_ONLINE_MOVABLE;
> > +
> 
> Hi Greg, 
> 
> A couple of things here...
> 
> The atomic --no-movable path uses DAXCTL_KMEM_ONLINE, leaving zone selection
> to the kernel. With memory_hotplug.online_policy=auto-movable, IIUC this could
> place memory in ZONE_MOVABLE despite --no-movable.
> 
> The per-block path checks the resulting zone and fails if it isn't ZONE_NORMAL,
> but the atomic path skips that check.
> 
> Should this use DAXCTL_KMEM_ONLINE_KERNEL instead, or retain DAXCTL_KMEM_ONLINE
> and add the same zone check?
>

I think you are right, let me go test.

> 
> > +	if (state == DAXCTL_KMEM_OFFLINE) {
> > +		/*
> > +		 * Onlining requires 'unplugged'. Don't unplug memory another
> > +		 * agent onlined meanwhile (a small window remains).
> > +		 */
> 
> With this, a "reconfigure-device -m system-ram" may add the memory twice.
> First kmem adds it offline at probe and then daxctl unplugs it and adds it
> back online. If that re-add fails, the device is left unplugged rather than
> offline.
>

This was the intended behavior because otherwise a concurrent
block/state change would end up making the blocks unrecoverable.

> I get that falling back to per-block onlining would reopen the race this
> series is addressing. Could the kernel interface support transitioning
> directly from offline to an online state instead? It seems that would avoid
> both the extra hotplug work and the left-unplugged failure case.
> 

This is an unfortunate wart for backward compatibility sake.  It would
have been preferable to create the dax device without auto-hotplugging
the kmem region (hotplug but offline), but that would break userspace.

I can take another look whether i can get offline->online to work
internally, but this may still require the hotplug work you're concerned
about.

-- 
~Gregory

