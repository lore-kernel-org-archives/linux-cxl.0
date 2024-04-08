Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC358820
	for <linux-cxl@vger.kernel.org>; Mon,  8 Apr 2024 06:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712557034; cv=none; b=g0Yn8O5NbSDhDd4Uaq9iGkQ3lmtxbhgNd6B9+O41bHJt0ZVd+ACn55wBZyLDKRLp5Q3ux8xXkDBOxFIcAaKLonF1K0DpVYOkoXUquIvKg2067HqcCs1jWtK8pIqTOU5z2O1GKDV6M40ddD92RwBGj5ZmeFu3U5ce1sqL5vEKohg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712557034; c=relaxed/simple;
	bh=sMrjRzy/b/JoSaabLfu67xA+4iY7rGucBIMUe3tPTYs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dd7YhrYgMlYnIa0AOjQfvAL+oIOtM1FVN3EWzffQj1iFNrQgk1XUN6uiNO62WWzGiGHApdgVZFWGOrmmZqN9E+NqXKJ4xOEX3Q8Pcdiuz24xfbw/uXFLCxckYyLeWqsWB+2XHRhyNtmQQ0egaK0gKl7IKKIpqqnp46T5VhmmiR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vvmueDaL; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vvmueDaL"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a51a7d4466bso283034766b.2
        for <linux-cxl@vger.kernel.org>; Sun, 07 Apr 2024 23:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712557032; x=1713161832; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xoNnDsmSFmjeDPz+LlGMu+Of6wJcXPoQLD7hQ57Rd7E=;
        b=vvmueDaLo+PAPiggr2rcfscu/Wxrkxyu5gY+7uopn849HTYhcCNd+HMc/g5QdMW5wb
         it6CUVEuf5pPB+ZP9OG41nu/moymO+qb/EQLkPx3B0reS6GWha3k8nyKiHZyLWDcTTjI
         yDtRWriQBg8DX2zgk041p9mmNgRpTeQsVK6coNygQUd9V50g7WUehx/vbhZ1dv4PW5Mn
         LRdCyRkSVa2YpLymN0zyOaVw5zBdS+0Yzq7W/cekSzpvbupjX4NLtGLXQh3+3BS8Ugey
         ts2pVUftgXtZiPpQHZv5m+dhBds4kQX5uLB1wg1j+W/OUteCuVfq895Z19d9IQ7ECF/Z
         LucA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712557032; x=1713161832;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xoNnDsmSFmjeDPz+LlGMu+Of6wJcXPoQLD7hQ57Rd7E=;
        b=W7odtDNxu+l9qG0XPE3tFQeWUvnLRjhWW/mHK5MM+TK8+ncJb2qXYml/o4zQ8XFCZY
         TiLnrSXIwBt5NnyP5XUFpSsf7ZH8kDiG0jGDy/WO63CmWf5/VmvTjsvD5EXDvI4FBbLB
         N/Ps9LefyXjEADzGPHIMgwruuJWB7xHWkbRZaEt2AS97oedoZJMmKrXegxp7vVHg0PTp
         nVUxWhmJJcn8gM58jYtCfK/ET+DMQmP9ApBnpeMXvA76KLnwq7gfeBBqBBqhcMCgKbqN
         +o5JZ/UiqEUnM92jy9I+1gsBamphXiJTRS1sI0mU8mSiRePRCcBw95Q7ZpbRloAJ2DWF
         XoNA==
X-Forwarded-Encrypted: i=1; AJvYcCVUlEfjHMqwRY8NOz6ckCpxehPTSx2EmU/FV8BXKi0guOKk76xcbENAIm2zn9mCr5j03Era+cEsK5yrjju/oUPGTVPxUOnAOsmK
X-Gm-Message-State: AOJu0YxJvM2IL7EouYo0hRpFOra25W95oRM0o/EPSqS/3QrwkD9x40ri
	gf8UFUU+lWi9z8SbKciFELfm7bR2fDFb2rpU/T545Zjkjm3WCgcj2t57GawX4jY=
X-Google-Smtp-Source: AGHT+IF/Y57aeHjuHxSHmOb6VVb/24LQqbscN+6q0qrLXAsGl+f1OE0cnXDfhEdNy7qA4bz6Aex/Hg==
X-Received: by 2002:a17:906:f1ca:b0:a51:d716:5e8b with SMTP id gx10-20020a170906f1ca00b00a51d7165e8bmr794869ejb.29.1712557031434;
        Sun, 07 Apr 2024 23:17:11 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.144.67])
        by smtp.gmail.com with ESMTPSA id qx27-20020a170907b59b00b00a4519304f8bsm4076466ejc.14.2024.04.07.23.17.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Apr 2024 23:17:10 -0700 (PDT)
Message-ID: <5ad1503d-dc17-40f9-b70a-e593f3614ad4@linaro.org>
Date: Mon, 8 Apr 2024 08:17:09 +0200
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/9] target/hppa: Use insn_start from DisasContextBase
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Jorgen.Hansen@wdc.com,
 Jonathan.Cameron@huawei.com, linux-cxl@vger.kernel.org
References: <20240406223248.502699-1-richard.henderson@linaro.org>
 <20240406223248.502699-5-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240406223248.502699-5-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/4/24 00:32, Richard Henderson wrote:
> To keep the multiple update check, replace insn_start
> with insn_start_updated.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/hppa/translate.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

