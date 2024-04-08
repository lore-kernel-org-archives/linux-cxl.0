Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8714C29CEF
	for <linux-cxl@vger.kernel.org>; Mon,  8 Apr 2024 07:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712561159; cv=none; b=OvpWtPfHK7S2xfOCyMIqgXnb1OXrQY6dCDRiX0vxLzNiub+IKlyiXVaDjikhnHbr52iorAjgb5G38PnV8TvNeuUQ/iZ3Cn+Na2OqPPzdV6MJCk/WuO51vONhtaBdhoRdnzSglCYSy0caDHYmj+9cPhBSWCb9cwuo14XMScJVC9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712561159; c=relaxed/simple;
	bh=Bo2x+u5kEZPCysluerNEAjddSbPtTdYn1ImUxTXnhu4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sjv445vjOKkbFPoCDkRgSe1Qbp+pCKlgbAIlQXtC3Ubd4++e//tq75M335x+KBnODZcTPjEYm+4BITXekPWGFqfRxPJ/jjEEexgEjT76EUrLe4erqUfzS5pIrTupOnVtHPXS5qLRPQE1I7tLhpJYz1SRS82FXRVrXS+QfQCxpWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PC/AVGkg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PC/AVGkg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712561156;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nwLABuDCF8qRe6Uvxmrk10151XqSu+e28i49NmiBB+g=;
	b=PC/AVGkgxaBdyxGK68cYBPwiV4zF04vOS6CVbIn7Dc1vGSXD+9RGpG7m86bOnnlKWzjAFs
	9KU4SqOZQ3eO/WREtUFO+1iuoQG+e8WoRDCHyJThtS7SNzadd5FKL0O2Pe/yAN1gDCZ8so
	YclYrcDRoLEXoYrBcUgYgM03D0OJH34=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-rUuUUg6dMDG5RWRzgmgrwA-1; Mon, 08 Apr 2024 03:25:55 -0400
X-MC-Unique: rUuUUg6dMDG5RWRzgmgrwA-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-343da0a889dso2497563f8f.0
        for <linux-cxl@vger.kernel.org>; Mon, 08 Apr 2024 00:25:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712561154; x=1713165954;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nwLABuDCF8qRe6Uvxmrk10151XqSu+e28i49NmiBB+g=;
        b=r1BTvAMOOlT94LiTyn7MfC1y/JMsQsNQOH22N7jRDGqx8NTIcHrxHZ3JKcTjeOEkyq
         suumi9znuzsHy+Ddt4C90fpwO9Iegkyr3mm6mAvRIyCBv5toStDCqJ8EOGG+xH5+OOQr
         vgHbIvSdjKTT6oVhMME1F9kVF67mkT9QJi+tJd9IXxKs9vGDhmBjr18zfr/05eEv2VhV
         T8oXcqTBiJJpLmsV8+H58CXjHYMDFYLNo7KSjTPjUqgq1vTjAWtmred5K4jLuKUov88A
         KHKvy/payuCfMVNg/Lglgv+XIa3lod/YSPkKY2qe4awur24l6s/aI/rrLq3TbYRS76Ou
         P4vQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdL5zCZYdt3EfUtwKZ5Yc2OM/CNY16EenFc8gzyjtbkQ4UUwqfWVH8G9Xh6KQBdEITf5XsO+gG9uXyaF+uX64M6veGf5p7J0CC
X-Gm-Message-State: AOJu0YzhYl3Fi39yIa5JBJvgLn64Q+z6VyuZM+/MhtVuwL07fdHCOhMB
	3F9j/8QakeTOxdAh+CKc7HsTXfGEbd5vtUh1I3oRPqxRLMKn1GvQ9nIH4CbMfLC5OTp9vkYQV8A
	fO5hGPhqpIH+5OkNIvF1Jz8tmem8BTrIRaqhY6Vjd9CFc6Y/JPglw5Al/L15Cns6yiOTykqLkl6
	t3xUIwkiHf10s8I0kK9z7eKU3+qkd6I7U9
X-Received: by 2002:adf:fa11:0:b0:343:6187:ff56 with SMTP id m17-20020adffa11000000b003436187ff56mr5588335wrr.56.1712561154333;
        Mon, 08 Apr 2024 00:25:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7vp4sVIdWl1axeaYfPlSN2LmyBCOZdhHUr8UF96pdfvsxS+csccpvCf0L3/n5/uV7hEzhoAM4BevCK6Uz5Cg=
X-Received: by 2002:adf:fa11:0:b0:343:6187:ff56 with SMTP id
 m17-20020adffa11000000b003436187ff56mr5588322wrr.56.1712561154006; Mon, 08
 Apr 2024 00:25:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240406223248.502699-1-richard.henderson@linaro.org> <20240406223248.502699-6-richard.henderson@linaro.org>
In-Reply-To: <20240406223248.502699-6-richard.henderson@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 8 Apr 2024 09:25:42 +0200
Message-ID: <CABgObfY3+FBG3gSmNiT2y8u8KUCUYxTUG10xbOkqrZxeQ9JvPA@mail.gmail.com>
Subject: Re: [PATCH 5/9] target/i386: Preserve DisasContextBase.insn_start
 across rewind
To: Richard Henderson <richard.henderson@linaro.org>
Cc: peter.maydell@linaro.org, Jorgen.Hansen@wdc.com, 
	Jonathan.Cameron@huawei.com, linux-cxl@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 8, 2024 at 9:15=E2=80=AFAM <no-reply@patchew.org> wrote:
> When aborting translation of the current insn, restore the
> previous value of insn_start.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Acked-by: Paolo Bonzini <pbonzini@redhat.com>

The TODO comment in disas_insn() in fact can be expanded a bit.
When/if the table-based decoder takes over completely, decoding can be
moved completely to insn_start, and insn_start could return a bool to
undo the beginning of the translation.

Paolo

> ---
>  target/i386/tcg/translate.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
> index 07f642dc9e..76a42c679c 100644
> --- a/target/i386/tcg/translate.c
> +++ b/target/i386/tcg/translate.c
> @@ -139,6 +139,7 @@ typedef struct DisasContext {
>      TCGv_i64 tmp1_i64;
>
>      sigjmp_buf jmpbuf;
> +    TCGOp *prev_insn_start;
>      TCGOp *prev_insn_end;
>  } DisasContext;
>
> @@ -3123,6 +3124,7 @@ static bool disas_insn(DisasContext *s, CPUState *c=
pu)
>          /* END TODO */
>          s->base.num_insns--;
>          tcg_remove_ops_after(s->prev_insn_end);
> +        s->base.insn_start =3D s->prev_insn_start;
>          s->base.is_jmp =3D DISAS_TOO_MANY;
>          return false;
>      default:
> @@ -6995,6 +6997,7 @@ static void i386_tr_insn_start(DisasContextBase *dc=
base, CPUState *cpu)
>      DisasContext *dc =3D container_of(dcbase, DisasContext, base);
>      target_ulong pc_arg =3D dc->base.pc_next;
>
> +    dc->prev_insn_start =3D dc->base.insn_start;
>      dc->prev_insn_end =3D tcg_last_op();
>      if (tb_cflags(dcbase->tb) & CF_PCREL) {
>          pc_arg &=3D ~TARGET_PAGE_MASK;
> --
> 2.34.1
>

