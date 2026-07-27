Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B06E3DCDA7
	for <linux-cxl@vger.kernel.org>; Mon, 27 Jul 2026 08:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785142152; cv=none; b=eO06V90fav3HzfDIrqQCteYrGstSSNeQ55PzSNt13NQdq3aB7h10Lo2CiwHr3QNulcJr20OhhaPByv3wdc8KJ/fs6ova6hrr5pW/MosWzoMZONSLK1DCgEObNy7z9YWavy7fzZMgqfQ4Sj/TuGnt1Dr32LXKal9tA+lCE1s8YA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785142152; c=relaxed/simple;
	bh=QtVtF+emtAEp6tAC7JP0vz9bclhpiBSUebczGQnuBG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=OVQSNkV32hA3i1mU1UPP27W4sfMBpX8KjcL1ypa1f7OYbp+LcWzjgJbGKiFmq5P9+7+S+4I6tTqDMNAaGYr4TXnfogWMSzghNSGfbJfuCRLTNzcbeLSqI6h8RnRcoIiIXEzfYaORwMzf737Z0aM772v3/4qAcKtE2vnyYhrNJx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=An8c8WJk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="An8c8WJk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785142150;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7kGEMn6eHQoaN4NfeViWqhPxe4bRXVeNsFNfkePmaKU=;
	b=An8c8WJk2Q4KtPY33b0o+HAUzyEMEev5V3oouq9ShQ8tzvsDBxHfJvbaRLp0jDtjqS8ISE
	70/WT3cArMZrFoAKyFPnR49/nL8L6E5wvrRcUK5dxSe+5waKlEM3PvwJGohndnQ4Pht2Xs
	6ezhSc5fDL515i5svYWtqUESIiyFya0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-546-PALZ9Nd6PsGoGGlpA6quNg-1; Mon, 27 Jul 2026 04:49:08 -0400
X-MC-Unique: PALZ9Nd6PsGoGGlpA6quNg-1
X-Mimecast-MFC-AGG-ID: PALZ9Nd6PsGoGGlpA6quNg_1785142148
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-495495ad5ddso13621655e9.3
        for <linux-cxl@vger.kernel.org>; Mon, 27 Jul 2026 01:49:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785142147; x=1785746947;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=7kGEMn6eHQoaN4NfeViWqhPxe4bRXVeNsFNfkePmaKU=;
        b=MTGStHSxIRqUBDZBO5vKSpry+vC/LW5oyiUkSTjHO1+fFp3zKQBX8HHSRBrP6Mrs4a
         aMF7kZ0LIhYmH8uHboLXnn1O8XZanVy6IDM0Rx3JlqI7fnvdFLUEhqdazsUPhcUofLcX
         1eFuLyP63BBNqmO7n+nIk67FelyUwgogaazui88W6JQ9YJ0etPO2qhZ7DadCrDURqgnI
         tnm+4oV2Qla/nQfUvVQwdP0ZOMA/V9zLpoCDy6OdKXjN51OI0dqmr7utCYIObBYJBvEH
         AVSev8wx5W1MsrC4zBVLyHtIOwq+bT1NUeGzAA4tZ5+u2tz9DZjnz6MmTTWMxPks4rcv
         7CgA==
X-Forwarded-Encrypted: i=1; AHgh+RqOZrAnhjBjf3kw12G0ZSXtSsV8/XBaXbRrYqlaf4YZhYgkjeXcB7IakUB/s5G6otSp7B2S9bI53YQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz9PrnaJC4mOFtEdQ6jXHE0Jq9XAKPq/CKoHnVRqHgX4eIoTzd
	g1sPRGT/eK8xIAvYSIRfUPx1JMtAC/OapYAEKiFm7evWyz3vLhya8KSDrM0RiFNnVE2ieNs+ePi
	Fvsu6AIgc02WZ0aQaKXqMWtf5n+6Zt/rNLVM4b0UvDDN0/BttNSQ33QtiBM90IA==
X-Gm-Gg: AR+sD121UX6bnZADg7Tw2vY24PkgCck2saHNonLlCtEIxtuKiwCLKvgcMTKI5x5WoVW
	b78PIid6383oHtsBMzAgULes5LLScSIMAWhEBgZgza6Awer9qjeUsmNeYOPkhFehf4inJ8uEoI3
	44mSlrISoDIAs0ZbpIm0u4x/lMVAIIjn+N6kr/Mr9273zocgJwSklXvO98tXT5ZK1vHzCkr9Mxt
	chjYsneoSmKGItOAziq18RL04IRQt4+7NaDD3JKGOzbcBJHU5bwbNc7ueu9J+NMwvgdlupNPRKP
	ifJGyjHGQZUsBBu5mwuOuvY4XGEtaJCKDVjyiVAUPgxCZYTl2XtN1HifqirH42Dr3+7dYmuAW6Q
	CQqhxHhJwW5baNz4nokjTVQ==
X-Received: by 2002:a05:600c:354f:b0:495:5062:17f9 with SMTP id 5b1f17b1804b1-496b5702398mr112625765e9.30.1785142147437;
        Mon, 27 Jul 2026 01:49:07 -0700 (PDT)
X-Received: by 2002:a05:600c:354f:b0:495:5062:17f9 with SMTP id 5b1f17b1804b1-496b5702398mr112625255e9.30.1785142146952;
        Mon, 27 Jul 2026 01:49:06 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-37-66.inter.net.il. [80.230.37.66])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4957f9928fdsm233687885e9.1.2026.07.27.01.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 01:49:06 -0700 (PDT)
Date: Mon, 27 Jul 2026 04:49:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org,
	Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
	Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
	Dmitry Osipenko <dmitry.osipenko@collabora.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
	qemu-block@nongnu.org, Jonathan Cameron <jic23@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
	Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	Roman Bolshakov <rbolshakov@ddn.com>,
	Phil Dennis-Jordan <phil@philjordan.eu>,
	Wei Liu <wei.liu@kernel.org>, linux-cxl@vger.kernel.org,
	Brian Cain <brian.cain@oss.qualcomm.com>,
	Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
	Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@mailo.com>,
	Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH v2 07/12] Fix some -Werror=maybe-uninitialized
Message-ID: <20260727043137-mutt-send-email-mst@kernel.org>
References: <20260727-fix2-v2-0-d0c4831ed7ea@redhat.com>
 <20260727-fix2-v2-7-d0c4831ed7ea@redhat.com>
 <20260726165049-mutt-send-email-mst@kernel.org>
 <CAJ+F1C+jzxfbWbmLoU6vMobKUr0VFkpnr--FyPcy8o1=Q0vY-g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAJ+F1C+jzxfbWbmLoU6vMobKUr0VFkpnr--FyPcy8o1=Q0vY-g@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: RqoSgEKJfcpCu2m946devaK0QycmMuOqIgP5MsjDHP0_1785142148
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Mon, Jul 27, 2026 at 01:07:32AM +0400, Marc-André Lureau wrote:
> Hi
> 
> On Mon, Jul 27, 2026 at 12:53 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Mon, Jul 27, 2026 at 12:44:06AM +0400, Marc-André Lureau wrote:
> > > When compiled with -Og, gcc produces many false-positives
> > > gcc (GCC) 16.1.1 20260515 (Red Hat 16.1.1-2).
> >
> > it hurts if you do it? so don't do it then?
> 
> We are not far from getting it working, we can accommodate a bit of
> code while making it a bit clearer for the reader too.

I don't know, dead code does not make things clear to me.
And it burns tokens for LLMs)


I simply do not at all cherish to have yet another weird config
that will trip up CI and then I am wasting time either
"fixing" it myself or wasting even more time communicating with
contributors.



Used uninitialized warnings is already not great with -O2.
How about simply disabling them with -Og?
Is -Wno-error=maybe-uninitialized enough?
Default build will catch enough errors and that seems enough for me.

> >
> > > We already use auto-var-init=zero, but better be explicit.
> >
> > explicit about false positives?
> 
> Explicit initialization

I don't really think it's better. Maybe it's required to make the
tool work, but it would be even better to avoid the noise.


If I see A = 123; I expect it was worth my time to read it.

> >
> > > Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> > > ---
> > >  target/i386/cpu.c             | 3 ++-
> > >  target/i386/emulate/x86_mmu.c | 4 ++--
> > >  2 files changed, 4 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> > > index 5805d33ab92d..28e4435df23f 100644
> > > --- a/target/i386/cpu.c
> > > +++ b/target/i386/cpu.c
> > > @@ -7734,7 +7734,7 @@ static void x86_cpuid_get_avx10_version(Object *obj, Visitor *v,
> > >  static bool x86_cpu_apply_avx10_features(X86CPU *cpu, uint8_t version,
> > >                                           Error **errp)
> > >  {
> > > -    const AVX10VersionDefinition *def;
> > > +    const AVX10VersionDefinition *def = NULL;
> > >      CPUX86State *env = &cpu->env;
> > >
> > >      if (!version) {
> > > @@ -7757,6 +7757,7 @@ static bool x86_cpu_apply_avx10_features(X86CPU *cpu, uint8_t version,
> > >              break;
> > >          }
> > >      }
> > > +    assert(def != NULL);
> > >
> > >      if (def->version < version) {
> > >          error_setg(errp, "avx10-version can be at most %d", def->version);
> >
> >
> > what does assert have to do with gcc warnings?
> 
> That's what is expected at this point,

of course - it is dereferenced 1 line below.
what I worry about is people seeing this and blindly adding
these asserts all over.

> unfortunately the compiler
> doesn't care we help it here. I can drop it
> 
> > > diff --git a/target/i386/emulate/x86_mmu.c b/target/i386/emulate/x86_mmu.c
> > > index 8d4371467fd7..65bcccd4751e 100644
> > > --- a/target/i386/emulate/x86_mmu.c
> > > +++ b/target/i386/emulate/x86_mmu.c
> > > @@ -185,8 +185,8 @@ static MMUTranslateResult walk_gpt(CPUState *cpu, target_ulong addr, MMUTranslat
> > >      int largeness = 0;
> > >      target_ulong cr3 = x86_read_cr(cpu, 3);
> > >      uint64_t page_mask = pae ? PAE_PTE_PAGE_MASK : LEGACY_PTE_PAGE_MASK;
> > > -    MMUTranslateResult res;
> > > -
> > > +    MMUTranslateResult res = MMU_TRANSLATE_PAGE_NOT_MAPPED;
> > > +
> >
> >
> > This is not 0 as the commit log implies.
> 
> Initializing with 0 implies defaulting to MMU_TRANSLATE_SUCCESS - not
> the best choice here.

when I see this I go "ok there is probably an early exit I better
remember it" - and then it turns out there isn't and I am left confused.

-- 
MST

