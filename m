Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F357218AB9
	for <linux-cxl@vger.kernel.org>; Sun, 26 Jul 2026 21:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785100066; cv=pass; b=cEfBsR2+u6NNL3rogHjb8l2D02PjSNpHCiXijp3/10jkUpia8HzEB2/WAwVO5fOf+d83EiDzO6GYTTHgC+QhFSF/Sn3JqhJ98fBLV/xxb5i2yI5A0yQXEJ9QhbINvrkh2yqJdErDoWks8AR9b7hQt0GBi2MW7wZN46z3k215/GY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785100066; c=relaxed/simple;
	bh=PNYbpdm+jW7ZeReFTuyrB9QSrPz/9GjkhykSu24Ifbk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rbg10s+5l7xfcRuaQJaiGNqeOTpKl6zAk3yRUnBxiXhMVv1YwcsDHMgbtSHng+x/bMKmHWokg0D0Yzi1/1yZkSzlcEdS/08NyPJFUibPGUdjwDArBHtHAm1MEKdokDf4MoDtLIjG+pUszNWGVa2r3COMBaEgUk9MCE9MVg01NnU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=eaJicovD; arc=pass smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="eaJicovD"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-ca957432c7fso1470236a12.1
        for <linux-cxl@vger.kernel.org>; Sun, 26 Jul 2026 14:07:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785100064; cv=none;
        d=google.com; s=arc-20260327;
        b=gIxNNHrzTB2bYM8HFfRAEKfJ2OloX7Hst8J/3f3mCnEhIBXHHyU/SvOLbIaZNJPyMd
         tKwJ69qtwEzkoDwwx1uaBZMcCO400x6/zfLoM6KvMvUkCj+URYL0lO6j8JiidcDac37B
         dPBY45u3+iL1pJIuyopdr19mQZ+lxE9V8659zMUEKac5tsOLO0fAg5DPlNn990XnkZvJ
         2H2JE2cJU5HZalV+EQGuNOU3iiI1oefC/bneaAwsfVilI4A3Co/SSSuJBzgAfRV2JGk5
         ZuyP0pdvRHnUESdMYwG4n1NICQNmaOSF6oVGVd8Pyt074D6uTUByofIWHVfHC8X6TaUG
         /u4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=u2r7pEfz1ix8vkd0ThXfCOiLoWXimpXZCkwczzll1VY=;
        fh=hFHgHWTXJXhG/xtoMgSxjV9nATNAEsgwq0xc2Lz0Hnk=;
        b=iMoRjKJvsseO2u6vrFtj5xsm6fxR4UvEfu1+DxpBk6V82Xd5lk9/B0PAvmc0sE2GTm
         O7FF7/05RSg36xy5fI9SHx4VETbv5vfR2X9Xo1F7dvCp5GdEAOGyHyE12h4xWgiQXQG1
         OSSITKdInmtn8tjOjC1Jo64lMgsTzR+xXPiFxI6/+O2ehPgti+6EofpCLPGeYamNKRI9
         kZUm2tHjVeBZBhOvDRBl8nFBbPZpGV/Yt5NuQsAyLNJmrojtrhwY1oKTE8zukru7xxgh
         R6V8wf/9Mtid5b3HjjRfqW8V7rLSWBu7DrR/AWG/H2zRU9AE9Mu+Fp3o4qpBvOAlz8oL
         JUEA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785100064; x=1785704864; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=u2r7pEfz1ix8vkd0ThXfCOiLoWXimpXZCkwczzll1VY=;
        b=eaJicovDjsQt/vWcoN7GpBY9bkYv+89jg0Eib9a7W1t594ixSp6GET+TiQxRLwKJkT
         lHw/IxhmXwaWq6+gw1pcjBVNmRhwrm8ExPb0Csz35J82NYH32A7Lbo8Nteu1f8ZF1xfb
         CNySu22aKzMskeDpP83TkkL/VeDgp9b2gGeHPaePQ82q8p06KU4+ekwgQuJLiB8FQKBJ
         1KKbCktwz8T57CQx3/AlRe7u+z9YNt+dPcdDbBbyhZmlImh9GwVOQiwiGUjlfOUs8qcc
         ZFeWDHEKmztdCbvuPgQNm8Hpoiud18gwmmqJV+2BvrpLvxL+P4o16gQcEOwlxBpq/LZg
         Q+HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785100064; x=1785704864;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u2r7pEfz1ix8vkd0ThXfCOiLoWXimpXZCkwczzll1VY=;
        b=KLMnJYaFFVFeEdhI32CLYvBe+rJSl9HmUznRQZvsIRgBxpggJSFTj4+QoM1sS12SJu
         4qwDohLZy8ljeK5uC83MOY2AYXwcn30BMGVG1dWcchNaBXJp5J+fbxHFH1PuWZ/iKUsm
         zxpv8he8UYTYHx+90couF/IFf3GGQBtLE/x7DhNAScUNtm8OPj2JN+yY3+Sju6BZcyUj
         IjSo0Hg0pP6c8KqRvm06QE+4zakDgbrgmCGygpjZEUkRF8A+c4PTHrn5zI1d5aywOaXK
         t2VXrfIYsjoYh5BFBNMMHNfX7Zbb8BPbL1Ck7Pz/4C7UkaSWQeg00Upp3vwG1n86nUVJ
         jE6w==
X-Forwarded-Encrypted: i=1; AHgh+RrQOPBu0HIFyt/Gs8qhHU1NIyYwouTCiZ5n8NNUB2uTZxHX/WOXfQIKDgaxpK+Yaz8UoAcIiTyDVyc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7cG85FTwXkINju/u62OSsMesHIBlUt2Y3l84VnN0jW+EqFBW0
	G9fykuzFeuZ+19dHmRu0kULO6YSzEyWtYfocxqLHRR1TpO6JHkbRTZvoLasA5JaT77iSgnNx2w/
	zrNOebmvSCW6k0l0oZwnyYuUzKC78mO0=
X-Gm-Gg: AR+sD11hA1ZVOahPg0mb4Do0ABgIqVtZWCSsIkUXqkBf4t2w/vLZHDn/qN6wHCxXSI9
	WYuc3EFRsyBeeOJS6kFQFXu2u83ngThHTwFdaNslwFgL8vA1DPH9GmBpzQgohpYdRDS2Rfl/KrQ
	XA8EpOOGu0wwgROZblEIMRiJsJ5XYjW6Fcgu4sHku92seKTV64kpjt1W2wC2UqRVsoSdCGbtZ1e
	YUQEkL47wJ8azBqzEw+xrxznaicttvSXOezWb1YsBVMmXc5tgd76i0UsogUXfNUNq8XnrtH7uPK
	C5Bsyo7aBiJgmd97Pg==
X-Received: by 2002:a05:6a21:695:b0:3c3:64cc:311a with SMTP id
 adf61e73a8af0-3c67dd65ec9mr5862823637.22.1785100064432; Sun, 26 Jul 2026
 14:07:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260727-fix2-v2-0-d0c4831ed7ea@redhat.com> <20260727-fix2-v2-7-d0c4831ed7ea@redhat.com>
 <20260726165049-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260726165049-mutt-send-email-mst@kernel.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 27 Jul 2026 01:07:32 +0400
X-Gm-Features: AUfX_mzEvwCCsNgyO1efvLmuth4XGgxSCbse45Oox1CmDal_x5wIx9hKzgHU0tQ
Message-ID: <CAJ+F1C+jzxfbWbmLoU6vMobKUr0VFkpnr--FyPcy8o1=Q0vY-g@mail.gmail.com>
Subject: Re: [PATCH v2 07/12] Fix some -Werror=maybe-uninitialized
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
	Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
	Dmitry Osipenko <dmitry.osipenko@collabora.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org, 
	Jonathan Cameron <jic23@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, 
	=?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
	Zhao Liu <zhao1.liu@intel.com>, Roman Bolshakov <rbolshakov@ddn.com>, 
	Phil Dennis-Jordan <phil@philjordan.eu>, Wei Liu <wei.liu@kernel.org>, linux-cxl@vger.kernel.org, 
	Brian Cain <brian.cain@oss.qualcomm.com>, 
	Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
	=?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
	Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Mon, Jul 27, 2026 at 12:53=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com=
> wrote:
>
> On Mon, Jul 27, 2026 at 12:44:06AM +0400, Marc-Andr=C3=A9 Lureau wrote:
> > When compiled with -Og, gcc produces many false-positives
> > gcc (GCC) 16.1.1 20260515 (Red Hat 16.1.1-2).
>
> it hurts if you do it? so don't do it then?

We are not far from getting it working, we can accommodate a bit of
code while making it a bit clearer for the reader too.

>
> > We already use auto-var-init=3Dzero, but better be explicit.
>
> explicit about false positives?

Explicit initialization

>
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  target/i386/cpu.c             | 3 ++-
> >  target/i386/emulate/x86_mmu.c | 4 ++--
> >  2 files changed, 4 insertions(+), 3 deletions(-)
> >
> > diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> > index 5805d33ab92d..28e4435df23f 100644
> > --- a/target/i386/cpu.c
> > +++ b/target/i386/cpu.c
> > @@ -7734,7 +7734,7 @@ static void x86_cpuid_get_avx10_version(Object *o=
bj, Visitor *v,
> >  static bool x86_cpu_apply_avx10_features(X86CPU *cpu, uint8_t version,
> >                                           Error **errp)
> >  {
> > -    const AVX10VersionDefinition *def;
> > +    const AVX10VersionDefinition *def =3D NULL;
> >      CPUX86State *env =3D &cpu->env;
> >
> >      if (!version) {
> > @@ -7757,6 +7757,7 @@ static bool x86_cpu_apply_avx10_features(X86CPU *=
cpu, uint8_t version,
> >              break;
> >          }
> >      }
> > +    assert(def !=3D NULL);
> >
> >      if (def->version < version) {
> >          error_setg(errp, "avx10-version can be at most %d", def->versi=
on);
>
>
> what does assert have to do with gcc warnings?

That's what is expected at this point, unfortunately the compiler
doesn't care we help it here. I can drop it

> > diff --git a/target/i386/emulate/x86_mmu.c b/target/i386/emulate/x86_mm=
u.c
> > index 8d4371467fd7..65bcccd4751e 100644
> > --- a/target/i386/emulate/x86_mmu.c
> > +++ b/target/i386/emulate/x86_mmu.c
> > @@ -185,8 +185,8 @@ static MMUTranslateResult walk_gpt(CPUState *cpu, t=
arget_ulong addr, MMUTranslat
> >      int largeness =3D 0;
> >      target_ulong cr3 =3D x86_read_cr(cpu, 3);
> >      uint64_t page_mask =3D pae ? PAE_PTE_PAGE_MASK : LEGACY_PTE_PAGE_M=
ASK;
> > -    MMUTranslateResult res;
> > -
> > +    MMUTranslateResult res =3D MMU_TRANSLATE_PAGE_NOT_MAPPED;
> > +
>
>
> This is not 0 as the commit log implies.

Initializing with 0 implies defaulting to MMU_TRANSLATE_SUCCESS - not
the best choice here.
