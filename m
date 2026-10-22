Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792687754;
	b=ugkov2B7FExy4YR5kNXvdsAP7gLJyawKt7w9r7afs0vL7hogLzTnn1h8a+aqgerTQtJq
	 oSqaD0Cu/MZ2NvSfYETFXIHb8Wdne5fmPWLwFbKme0+bbjL2IbdZ5+vpcRjA13hyFigon
	 VMMSgZuf1gCSIYoIgAomW5rK7IvdK+VZ+3pzrtqTSktIz7vtC3fnqIw7eqsnDj5IySI3D
	 PsysCQF4PMJlFw+/HUDJekRMCdEVTYfMkpRmPlxNM3gfJZF9jYejLeE9Urr9LHr6BwlRS
	 TImoXnuoGmdVba/sDs574+pUp9PqslHH3MBa0d1M0/Ox1qyRpYidXclPSBrXsWRAdGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792687754;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=awSiD3BNPmvugsib7uxM0TSdgkvyo47qanCTaG8r0Rc=;
	b=e/okZvGVDoKLSOMpgFTYNz0qp5Ych4Z5uyor0/3TF7OM28S79KEJcHwtodCtEQsrpqJ/
	 z0bJm2me8mqOf2ZQ7k/LJM8s+2UyJ7TkPiOouE/Z8XPmaeT3wpaANW26V8fMu2m40Dbs3
	 9bS3b83jxIMAvjAtIR4d3gEnn+xCxPSp0rCgzo/KMsYal4pug7g9CIkgobj7MFfbn3SLC
	 ikws0j9zDEkB98/XH8utXg4QgUPQw9YHy6BCfVCWvfdiSViGfAe0yit4CzpQ4RHar2uYE
	 lsF5v9HdfPpCRnI4h6NxNrXHqmkm9h0iycmu4g8LtzBKYuWe7/MuZ8X5TJ11Vnxo1mQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=AZN37U6f;
	arc=none smtp.remote-ip=209.85.222.174
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1CB3606A319
	for <linux-cxl@vger.kernel.org>; Thu, 22 Oct 2026 16:49:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1CB3606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=AZN37U6f
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-93f259cdc86so196717485a.3
        for <linux-cxl@vger.kernel.org>; Thu, 22 Oct 2026 09:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1792687753; x=1793292553; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=awSiD3BNPmvugsib7uxM0TSdgkvyo47qanCTaG8r0Rc=;
        b=AZN37U6fQcydxSjG+mrW7XCUA5Aq/ABJtte/SOw3ipA7PAQjjgP3WdcT+mBQoanmsv
         sunjrTZhkagh/bmLocuj6yBqZ0vXhvqmOipq5+9hAKq06UUd8eMRJa9wyyUoYRjhgwAl
         wMSUgRDtbskGl000WBUvZRRm3ozh+v+op9IZFF2TdyYe5jRFBC49Bk6n2wmBdBeLLssC
         opQvWDTyR8MNkZqqxvvqjiB/q5FrIAXPN9GW/CRkmpj9oDAbDxkAwgrflW2JBmx9Cblg
         P/jWoBoXvCwdOg2M8ehD8ZeTrf8mJOR/8l32FHwpFjq3zNuP6+Peh7Nkf1pVBy4lmNS8
         8wCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792687753; x=1793292553;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=awSiD3BNPmvugsib7uxM0TSdgkvyo47qanCTaG8r0Rc=;
        b=0++PhuY4TVmsebXJCGU7Hk9EsOmcn0cvlY8uGjUZSkZg7N0mm/EWVJwTYoRKOtdM8A
         NUP/IfDKYO3zL/WX/VQ7iZC17wUGIubQfkeGnNI80XrMhvyKF7u4idyVFlUuNwCS9/W0
         608HBO30fJ1rt3CbnXENykJuUvjNlXYl2cruiVaggEPAs3qv2M6v/YUR/4EZUKkXDasx
         IXCPR1nWfqUwGSBqzDlvkcEpmKpImSe8Gkcxsz3AF5fydq3LcaeP23NGrGH2cZLTXNTO
         NKqXFI7gONITgRO8XHdN+7wPT2o6T1sV8CxcVao+fBk60nrphfhVIIkBZeTC2pLByQcw
         Zz0w==
X-Forwarded-Encrypted: i=1; AKwUvByAK+93MBGkjGqv3bR1AU3H/05CYqITmrUVj/2KDwEpYGnpxSPSYuDQVTnWcYaTDqeAvj3oIRERbeE=@vger.kernel.org
X-Gm-Message-State: AFq9FYJwfMPBQcAxE5Pau34143rTDYJmUhOvUfuJqNjyJj1expTzWVDk
	rMlAcF+r5Y+Mic1NUL1zjD6UIgonW1/9jtkCsQoqEGg72SHTDXRiZmIuEWQLYyF4aCCUvQWvWuM
	bwtAs
X-Gm-Gg: AYBFou2a73Fy4Z0CXaFQWlMVBGlZB/sUrEoK2i+wtlbRFWUDPzKWRpiNm6plSDTjxC4
	4oh1ike/OFVz5PErgVzsfmwwB+NNaIymY9jZXmbt+jQyq3OeBWgQ/Z4gnketpDFrt0i++yEhkZv
	aBZiTV0F3FYUVcxgLS9+ZKpu+vIOv3/pf4lGHOlKBvML8qH2XVtqogHQZFRKc0k9w/gq1xAwSki
	zTbQuo/1FKHvDLEsn5uJs8/oqAUinVtmYC6OIdsbeDsXaKM8Xfml8z3bBD1e8AUjpc3O45Etb60
	+kfskLoBgZ1LeP67t7yVdzv51Gi1wTjeZhthyjsaKkRZpPGOQrICSEu8GfUswVCPcT1WpqzAbcU
	II81R8JcZZbe1l+DXwFF/Im7A0lvoLNOghaUtmC6YMiHNMmgZ9v57nahD0LCZyqvR87VYI2PIxx
	GU+5811CwWPopfhHY/89sPYYHbN7QxMzU7z4lcmiasgL9nei3Pj+kfHSLJRpcibgDpjTz2QuQmP
	DMznlAWEtArwTFBYjd7NAH81IqurgrwLJuJkHSs9aeK/rO3Jor0uX0NAtWmRcK15Rf+oBc/qAJQ
	7QOPsLQ5IAtHJMSl61B/H6UWTpk=
X-Received: by 2002:a05:620a:450b:b0:93f:1823:308f with SMTP id af79cd13be357-93f6f87bdffmr2749585a.81.1792687752774;
        Thu, 22 Oct 2026 09:49:12 -0700 (PDT)
Received: from [192.168.86.58] (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f56e0b402sm560253585a.33.2026.10.22.09.49.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 09:49:12 -0700 (PDT)
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
Subject: Re: [PATCH 6/6] test/daxctl-devices.sh: cycle offline/online to
 cover unplug and replug
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: Alison Schofield <alison.schofield@intel.com>
Cc: "Gregory Price (Meta)" <gourry@gourry.net>, nvdimm@lists.linux.dev, 
 linux-cxl@vger.kernel.org
In-Reply-To: <atl2HyXaNB6-6j8f@aschofie-mobl2.lan>
References: <20261016214248.443247-1-gourry@gourry.net>
 <20261016214248.443247-7-gourry@gourry.net>
 <atl2HyXaNB6-6j8f@aschofie-mobl2.lan>
Date: Thu, 22 Oct 2026 12:49:11 -0400
Message-Id: <179268775162.4072493.12508126317533540624.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-10-21 19:34 -0700, Alison Schofield wrote:
> On Fri, Oct 16, 2026 at 05:42:48PM -0400, Gregory Price (Meta) wrote:
> > From: Gregory Price <gourry@gourry.net>
> > 
> > Repeat the online/offline pair to cover onlining from 'unplugged', and
> > check that offline-memory unplugs an already offline device. After each
> > step, check block counts and, where present, daxX.Y/state and the
> > 'hotplug_state' reported by 'daxctl list'.
> 
> Hi Greg,
> 
> Please change how the tests handle the absence of the new sysfs attribute.
> If a test expects the new interface, a missing attribute should cause
> the test to fail, with a clear error message. We have had problems in
> the past with tests silently not executing letting defects go undetected.
> 

ack

> Note that we don't require backward compatibility for the unit tests.
> The utilities must continue working with older kernels, but tests for new
> functionality should fail loudly when that functionality is missing.
> (I'm aware that not all tests follow that guideline, and they need fixing.)
> 

this is slightly confusing, but noted.  I would have expected the tests
to test backward compatibility.  But ack.

> Please also leave the existing test cases as they were and run the new
> state-dependent cases last.
> 

ack.

> A few stale state cases would exercise daxctl behavior that the kernel
> selftest can't cover - 
> 
>   - Offline one memory block out-of-band, verify that daxctl list
>     reports hotplug_state "inconsistent", then verify that
>     offline-memory still leaves the device unplugged with its blocks
>     removed.
> 
>   - Offline all blocks out-of-band, then verify that
>     "reconfigure-device -m devdax" succeeds and the blocks are removed.
> 
>   - With all blocks offline but the device state still reporting
>     online, verify that online-memory falls back to the per-block path
>     and brings everything online.
> 

good idea.

> For "blocks removed", please check that the device's memory blocks
> are gone from /sys/devices/system/memory.  ie verify in sysfs directly
> independent of the libdaxctl code being tested.
> 

ack

> About multi-range devices-
> 
> I found that libdaxctl undercounts memory blocks on multi-range devices.
> I'm posting a separate fix and test for that. Nothing in this series needs
> to change. I'll cc you for review.
> 

ack

> Our ndctl emulation can't exercise multi-range hotplug, but the kernel
> selftest can run against a real multi-range device. Could you add coverage
> there, including the partial-add case where the kernel reports success
> even though not all ranges were added?
> 

ack.

Thanks Alison!

-- 
~Gregory

