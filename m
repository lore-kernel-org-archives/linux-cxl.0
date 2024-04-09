Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110241327E9
	for <linux-cxl@vger.kernel.org>; Tue,  9 Apr 2024 15:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712676237; cv=none; b=Rvrxg9RCDtlEREu3oJDKarfxcg6fpVhwPST01pE3Vm32jYjgxD0/2j5F5/QFMbvf2Bm8JdFrAeh9ZLF2295m45JTF6zfBiTKmjiAOmT4vumMWZ7c7YaqWLUlZbxxiThfd2ttR5IHYiJ2n4SRQBXsQhRjcZvXW9ALAmPn5IoiZVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712676237; c=relaxed/simple;
	bh=x5DyZ4iuvW02nZAgp16WuUPELP5zCsM8ekGCxpzsYOU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=grda1YLdevchY7wgwoPLtl7ZpcaYNOJcytXUCKdUuLPidcWWUWsay3p3YFfkyMKHVhM77Q9h+SId67wlHOfJdlsgmsay4ecCfKMIDwJ7IvQoX3uffwoef5PkTZZoZ4cn4gPvqwL1v+lDvrvllAQQYquBvTPg1tapmqVVzFMrj+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wfVNM7nx; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wfVNM7nx"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-516d47ce662so7392054e87.1
        for <linux-cxl@vger.kernel.org>; Tue, 09 Apr 2024 08:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712676234; x=1713281034; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=akSPS8/YlbSYkjb2CsC0dc+xHGAwntHL6xTWsAJYL5g=;
        b=wfVNM7nxIdSTis//mIPARoxgy4wBt3/OAwJvzt/QZZP263WyLG0z1ze32qhW3bTV3T
         95BYxCtEmSYQcQXTCDpJxnw+To34M0ABuUjgveMQYvag2Ane8Dozmdubpa27cKZtomnR
         FxDNXsELIJyMOkEGri/Uwuc0Manj94fqTubX1aoXy4ha9g0OjzDl4HgQ+JHbQNaryFcQ
         1hJEyYBUTAyyPIE+r4YP4CFUea4G0+/dQHKvd4pX+ygnlPuzv185LhmNrVx3SkowAvAl
         k6OtnsmxBblGTE9+sTKtxa9rQD2a4/dSynioPu3UWHqxp7tbkgTOBFuZGVPbHJyc8Jbw
         wa8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712676234; x=1713281034;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=akSPS8/YlbSYkjb2CsC0dc+xHGAwntHL6xTWsAJYL5g=;
        b=p/1dOij/g2CtEHi/CJWMc7gXLA1r/w8kvDB/xbFpKL5Q8MOEoxhjXY8jBGLd65Y9LD
         NgSZpq8KMEKdeg575lHHKgE8mMDVJ6WUyvl9u3OQ/uGMKfGyuGYCQaen7rFQo3ASoJxm
         dhcTBuovh793vjbEluilu5cKiw3e9qXbl+MM09156JQGcamo+XIX28wj5z0ND8AxM8Jd
         FvWkf3aL4HNGYxB5AiQOIhTPFqiJy4/XD1EAEibtHfdfGbSdJ6f9L1OXR0GtAaz13M+l
         I7l333o27P+72mmXPmw7MpVF3m8SF+4BMR3hx0/yajXOXxXvKdlkQDXMOkhXR2aXMpG+
         uM8A==
X-Forwarded-Encrypted: i=1; AJvYcCVOqsGRlmcnow4B+kEg8qWx2YTXZ7SecpcmrF90pDA0Q6n2XCusCZcABOkM4K8/WbPalzoADlYBb5+rqL5AkSw4aSPzCINmHw+2
X-Gm-Message-State: AOJu0YyUY80Z1FWAsl/iJTnvA2gV/4Q+64rcrxix5rPCcANvCRE3EUgv
	q51m8K/E1qLWrQXGPgzcUr8UybLWBjBoQ/7zcQeBbu0vjITVRnvTQtiKIwoymfQ=
X-Google-Smtp-Source: AGHT+IG1cEryIykr9IaqCAOkKG6bRzknf3oKYuxCfbfHgi1O7XGAw/AA/3prwFs+dSZT4vI+HoCsaA==
X-Received: by 2002:a19:a416:0:b0:513:ca40:fafc with SMTP id q22-20020a19a416000000b00513ca40fafcmr10061867lfc.11.1712676234248;
        Tue, 09 Apr 2024 08:23:54 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.160.134])
        by smtp.gmail.com with ESMTPSA id e9-20020a17090618e900b00a4655513f0bsm5802694ejf.88.2024.04.09.08.23.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Apr 2024 08:23:43 -0700 (PDT)
Message-ID: <c1cc9fac-f227-434e-a0b5-d4826f26c9a5@linaro.org>
Date: Tue, 9 Apr 2024 17:23:27 +0200
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/9] target/i386: Preserve DisasContextBase.insn_start
 across rewind
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Jorgen.Hansen@wdc.com,
 Jonathan.Cameron@huawei.com, linux-cxl@vger.kernel.org
References: <20240406223248.502699-1-richard.henderson@linaro.org>
 <20240406223248.502699-6-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240406223248.502699-6-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/4/24 00:32, Richard Henderson wrote:
> When aborting translation of the current insn, restore the
> previous value of insn_start.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/i386/tcg/translate.c | 3 +++
>   1 file changed, 3 insertions(+)


> @@ -3123,6 +3124,7 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
>           /* END TODO */
>           s->base.num_insns--;
>           tcg_remove_ops_after(s->prev_insn_end);
> +        s->base.insn_start = s->prev_insn_start;
>           s->base.is_jmp = DISAS_TOO_MANY;
>           return false;
>       default:
> @@ -6995,6 +6997,7 @@ static void i386_tr_insn_start(DisasContextBase *dcbase, CPUState *cpu)
>       DisasContext *dc = container_of(dcbase, DisasContext, base);
>       target_ulong pc_arg = dc->base.pc_next;
>   
> +    dc->prev_insn_start = dc->base.insn_start;
>       dc->prev_insn_end = tcg_last_op();
>       if (tb_cflags(dcbase->tb) & CF_PCREL) {
>           pc_arg &= ~TARGET_PAGE_MASK;

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

