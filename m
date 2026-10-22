Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792687623;
	b=qD4xizAyQ466AN/iWtYEbLJC0ngELVnvlmANv/jHxe9LrNMwLt7fwEaPQCOKk5BF5jvg
	 7YFawdRRZ+RU+ui5UoVS01m+Hh/02gwf5yGoAVpu50pbeIVM/T5oEfZPfr5PMmHFzGskW
	 WHx/sEHV9jWQfMB3B7Sr+vRFSJUW4F6PlxSqS618ygIcdzCM+NYsMR8cFzwoghszSEaT8
	 HQr+L8BMjUXHIIz5xI5vLCvykQCo6PdvY5Mch57Nq8kzpMvDQHb8eQQ9v2g8uNVuZmrCo
	 LD6YMEVnfKILEuYC02Hzp7Z8q6UVrl3ixf4vQK10d9uzL4J1gom5O8HXhMIq1KRX7vg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792687623;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=ID7yPTkzSVBQ72KhpcA430seexsA3T46pQ/u8vjuDwg=;
	b=H86IRcH59+zai7CWsz22hGYHMPtWcOH/CSFUCnMLCasjfWm6h7VmTt+SiJrm6c/h1Lls
	 f32u+34kpNL+InuLqVjhW8PwKa1m4D4fmMzS/W4uxPgpz4Z9HhDmet3fw8AdzM0QcpxHq
	 9YjLNSjXRobfAwrhSmDJ1OhhQomehMfgd8qfWLx4PR+ZrqEJpt0VGdwjYbJN51f+TSO9N
	 euL00A2ZMdbr+hYmE/7tyZJMFNLR5Omk3El6DImTikOqp6O80TmMCFGt30Bl+sW/eOnnG
	 5R2A7dxrQ84D4dhmY4WRVc9yB7jL+Qpu29bLpCi2TapfbVVoxXt0u19J+WLgGgTM1EA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=MfN+It82;
	arc=none smtp.remote-ip=209.85.219.45
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493FF606A319
	for <linux-cxl@vger.kernel.org>; Thu, 22 Oct 2026 16:47:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 493FF606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=MfN+It82
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-91b52ba422cso686956d6.2
        for <linux-cxl@vger.kernel.org>; Thu, 22 Oct 2026 09:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1792687622; x=1793292422; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ID7yPTkzSVBQ72KhpcA430seexsA3T46pQ/u8vjuDwg=;
        b=MfN+It82abS5XSK8Bm9dxYz2UmPMR2nY9k+2xnr/PaDAavVYqBm5jL8MxPXuN8VrXN
         P3o+habyzmAZCNL2fjJS5mM7D2VSsfOnsNMzqi/RAViVwTxBq7tIEjOrcQ72xcU7cpRx
         E1RQZfwFDanX8bEF0/8g9FLJfqQ3yPbf01fZ1cIbyeiEJVOt6HmtagVsvNjuh+91XoTW
         oFWD8f4UG0DIp4q6RhS2drWPtgMQ1y3JFw9U+KeGeLTM5gsc7covDeIp9ybps7j8HVtH
         lF2dLG+bH9yud9ihVy5VWXVHz3HLgE0iQyNw6iCrx07aDx0Z9I1KmKukAU2dCD3SgIM4
         Fx3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792687622; x=1793292422;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ID7yPTkzSVBQ72KhpcA430seexsA3T46pQ/u8vjuDwg=;
        b=JvmKRRM/OtUbCC7bmz/r6gbSrRQgqM3KRY3oobUHpwfcVrJWVKpCeRLw3AmxGk60tx
         v1j4WWeGhf6+xN/Z0NvtyNB9t8ZIWsOgBznlzeHNim9J/HmvIVUwFGT4js/iqty8jpR3
         syHSStl9AnZXTpOzISCSDzOKb5EZRXmpcDKrXm9jT59idfUvNdCb8n9HSgjVhDB42bCL
         bTrP3TOzybl93Knd7CGkJXJ8B/xcv26H4B1eFd7B8hDusCOCG+XKeVy/7r+qeqSyujrL
         xW3ZXmzb7e2ZSKRCPVsJh9UZkdQTx6yoX/qopJI1LYHkg6CCekMVjb+xzbqC4iffbUoP
         ODCA==
X-Forwarded-Encrypted: i=1; AKwUvBy3SQ4ofpLJrEwbH2BQ/jvELnaernRAiQbBIuz1SmZz61TNWLO0e6bkkdpgJzIh5iXXv5ZyaCMbXE8=@vger.kernel.org
X-Gm-Message-State: AFq9FYITL22VOqqsO+PGvaN3YSEHNCCjF32H4ETkBkC9SJV0l03Kx0ZW
	35v5Cn54LEYel7GtWx2bfGUbpoJGHaeg7DO8AB1cxqjagVaIj30XqCjoWY3ctw9c9Qng3u4T3B/
	5e562
X-Gm-Gg: AYBFou1TLf+8zaXCwTFpzE7tqMjMJrgAp1Gm7HbTKs3FVaw9xMRKfg+W6l6efRlq/je
	/8ktJgy5OvIOhwJrn/RK0AvdhSehL7DD1M0fjlAxs2sgc9PDMR1x+5D7T0g40JQSsuXD8g6I2eQ
	zy/ivfctTwjne/+6ffFuGY2A5+/0ESpUCfMVWDqbABi09xjVhjKy0WAQtxUDP0TeoUDUnhGnsl+
	/2IN22crr8MfWaMtC9ZJVAtOiRqrQwR/q57aFuwpj2Fmjl54pp3NwwcteInfM6pCN/80VAynB9N
	VlhCuiQOZWgrQbzFeVGr1TtNLVbmb9PSqW7D1b+410P6HJJQ/zuNzahes3dtDkhsoWMhEVUwGbb
	O02/BmXWxDbcTyu/htpOnW6rheKOhwpHtNu04rAHvtSj1VuzQVv4+lezUIqwG7CL811o+AbE3G8
	F0uRIaZ3YEQsBtIpuAKTF3yju1XnvALKy+d2AMDxGDq7PvlLk8dmg3CWvitE2Hh9HifoGghCNYR
	Gugy53usXWJECbo19oLggo54DquZOtPtqovBZEutvQ0hd365ltT1023gmMllyAbKOw2W9957Njj
	aagD59saeL7SMq6VgS/HBNt2jlY=
X-Received: by 2002:a05:6214:5c0a:b0:912:6380:fe33 with SMTP id 6a1803df08f44-91c12f03979mr98117236d6.40.1792687622201;
        Thu, 22 Oct 2026 09:47:02 -0700 (PDT)
Received: from [192.168.86.58] (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c3709b14bsm1484856d6.30.2026.10.22.09.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 09:47:01 -0700 (PDT)
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
Subject: Re: [PATCH 5/6] Documentation: describe atomic whole-device
 hotplug in daxctl man pages
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: Alison Schofield <alison.schofield@intel.com>
Cc: "Gregory Price (Meta)" <gourry@gourry.net>, nvdimm@lists.linux.dev, 
 linux-cxl@vger.kernel.org
In-Reply-To: <atlzl3h4cslBaV6j@aschofie-mobl2.lan>
References: <20261016214248.443247-1-gourry@gourry.net>
 <20261016214248.443247-6-gourry@gourry.net>
 <atlzl3h4cslBaV6j@aschofie-mobl2.lan>
Date: Thu, 22 Oct 2026 12:47:01 -0400
Message-Id: <179268762113.4072493.10493501438623710837.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-10-21 19:23 -0700, Alison Schofield wrote:
> On Fri, Oct 16, 2026 at 05:42:47PM -0400, Gregory Price (Meta) wrote:
> > From: Gregory Price <gourry@gourry.net>
> > 
> > Document that online-memory and offline-memory use daxX.Y/state where
> > available, that offlining always removes the memory blocks and how
> > that affects reconfigure-device, and the 'hotplug_state' attribute of
> > 'daxctl list'.
> 
> Hi Greg,
> 
> Can you add hotplug_state to sample outputs in daxctl-list.txt and
> cxl-list.txt?
>

ack

-- 
~Gregory

