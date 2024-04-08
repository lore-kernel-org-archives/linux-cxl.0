Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5C81427B
	for <linux-cxl@vger.kernel.org>; Mon,  8 Apr 2024 06:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712556975; cv=none; b=EyTAkCPJnm+cjx3CZWNM7TMn69nbk65b4EQhsnHiDNTLM/Q3tpoQdNnRbWeJk4kYI+hPjRcYgeNz5hbamuws7LeWRV4ZgTIaj5eGaq6IeV98r1X2iJM7pbsYXX/BREnYNMIbDYJZ7HjU/VJZVvcHJvZPKhXulQlzf75v5GivmZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712556975; c=relaxed/simple;
	bh=nExz9x70ykEiEn72C7LwXcLVv0npjCfgXXQE3bG0kP0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PeMvQaEJOygjeXolUYWnWi/Vi4soobSMdk/Qgv0iZywQNPOeHXWmC6+FojfYZqkmHX6zSt8GqW7jFriTFjR+tcvbCdHSUGidohwBTb0ceblatLRco5yT9+9ywlzML1MoRNbUMu97oHUwFfVaEhKszzofadvJVAvbTAbka7X73fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TsBtpwcS; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TsBtpwcS"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a519e1b0e2dso377048766b.2
        for <linux-cxl@vger.kernel.org>; Sun, 07 Apr 2024 23:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712556972; x=1713161772; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BP3T5zLQvx9D9wEUd+ieh23y29+UA/ohzfRqaFA2kCc=;
        b=TsBtpwcSeyHWJirtHodsrH8qYnN1m+j77EQmi8n/mmB25KnI8+R+NH02utuvBJ62Hj
         rGuC4lFkLnPig9lp6xgpsUPX2+SkSzjTPkxwC/S2TrPG44XPknLE6xRccA7YCkqOXnp5
         jaRTXBL/n9GOekGRpMmQBjqCId3IzfJbwr3sQ5w3MmeCDSfo/IdX4bvsXOZNClKgb8Zc
         HHj+g1MPLui1N4lINuVlT6hdOCDkM+jjyjaWBg1BoZqRTcDpVw1rRJk51b2KVge+WfWf
         bHnimk8xwSggzvDtFxe5xl/iHv7Td5h/fbEGSNTBWU5jeVzQIrf0Dl4Cx96dVfuTn10d
         1Xrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712556972; x=1713161772;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BP3T5zLQvx9D9wEUd+ieh23y29+UA/ohzfRqaFA2kCc=;
        b=D+/x1IESLlqdU9V/M6AU6YvcIDD3B9iF8bMCEPHKtCqE+i/D0w+L4Z8yX7bYBXmMcd
         mHiU89T0JmojdRV5YDXEOmEtvAyd7U2tHeQcs45mdGAt3IQFXEbhPUYJjz/FfIYFTV+r
         uvEcNnCZdyQ4rygfydc0Wtyks/TPcZnPYBnF/YNKb5CSvSGxAy6etq5QuTRSa+d45iO8
         TKydlfFpm84CtG+NDkWPsktQxb2ckPbsgovwhWA7ueOKDybGHr6Arn2Jnu4dBewlu4Kt
         AMlrmiBqRsrHHs0P8LtIP+CkQAZKZPDzUwQkDrZpACaHRGa66Gb40a6YByvJ5LfefVi3
         Z1WA==
X-Forwarded-Encrypted: i=1; AJvYcCVV6TJ2WZu5+VHLmCTgCQRAp1b+if40QEaWBGi08u32IY2J8EJt10vqTXSrC9ld5XLyiajyAazyH7e6vjG0pAflJOzAj/YGfQwG
X-Gm-Message-State: AOJu0YzIOTSmhw3tOc6mQARBlwN8bM3C7Vci8a4zJ7KAIkztfIJcZQd9
	zYzsxM4pmFm+tEF8M/lnl1t0UOfWfOG5B7jRJswNQn44bEo6nyr/6zJ22PzSNhI=
X-Google-Smtp-Source: AGHT+IF+A87cOu+9L+HMSFwGXGp7NkMUxtfDHrU9kE9Rcy7VZKOFMm3QegAyxQgOMPJCbmMUiNp7WA==
X-Received: by 2002:a17:906:f584:b0:a51:dd18:bd21 with SMTP id cm4-20020a170906f58400b00a51dd18bd21mr587988ejd.16.1712556972078;
        Sun, 07 Apr 2024 23:16:12 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.144.67])
        by smtp.gmail.com with ESMTPSA id og15-20020a1709071dcf00b00a47423b4c33sm3991025ejc.128.2024.04.07.23.16.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Apr 2024 23:16:11 -0700 (PDT)
Message-ID: <c50e346f-1cfa-44b5-a1da-34a0e190162f@linaro.org>
Date: Mon, 8 Apr 2024 08:16:09 +0200
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/9] target/arm: Use insn_start from DisasContextBase
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Jorgen.Hansen@wdc.com,
 Jonathan.Cameron@huawei.com, linux-cxl@vger.kernel.org
References: <20240406223248.502699-1-richard.henderson@linaro.org>
 <20240406223248.502699-4-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240406223248.502699-4-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/4/24 00:32, Richard Henderson wrote:
> To keep the multiple update check, replace insn_start
> with insn_start_updated.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/tcg/translate.h     | 12 ++++++------
>   target/arm/tcg/translate-a64.c |  2 +-
>   target/arm/tcg/translate.c     |  2 +-
>   3 files changed, 8 insertions(+), 8 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

