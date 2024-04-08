Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF719250EC
	for <linux-cxl@vger.kernel.org>; Mon,  8 Apr 2024 06:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712557058; cv=none; b=Eq+WVzudJSGPP05QoMUO4j3Hp6AyzkCYR5m8uAzfgd3eAgpvNMieS7H4yUb3bfHx26OslFBDBim0DRBTylnXWRfXxQDXJ8qPR7/5sjjXLUHowAo0mYpuVwDb9JMp6KNhvvhATrXZztudsXcOivjTmQ40L2yhNNzlmpz7HOYE17I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712557058; c=relaxed/simple;
	bh=EJPzqH5qoLPzuSptRV5IW0Ufynx4R8DuEW+nGHYkIgc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tuntNei5CDRZbBTDqMa6Dvtb7dxoNnfKIjDY6wDyGLnIGm9YqUtQvcaCHP9iv4S7Vll1s+eaiE67ThaGb4L7QXy8qnoZBaUt8cecKKkKEqBW/x3vgRNpSgdzd63wQfN5tGjWcfeO0onPho3ZJzMkgdmhjkGosbE2QHh4PXmXSxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RsJTeJNN; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RsJTeJNN"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a450bedffdfso559572766b.3
        for <linux-cxl@vger.kernel.org>; Sun, 07 Apr 2024 23:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712557055; x=1713161855; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZIrRvs1aIE/8shAMEAS1ZklgR4ayR9BEDUAx+mQnyLs=;
        b=RsJTeJNNXJh8mwjkAjQY6z8e7EVpQoepxL4+nb3fiw0nUtuCmkdFsJqOKNxP/AhhvJ
         Ekd/5JufpcSbbHt9llhptR28/cFcxD10uc7ijwPSXpg8mh7XNPFvlgPuyUhVg/Eoe257
         hh3KqJK/v030o864sjKV6UB+iagfOE4+TXTu6z9CsL9pxNw6IMUBBMw+SGOrTvnuhztS
         wq5msw96GYFurgH+J6nLK9BoH35jdGtNbNRl20YbavIGkMNYtvvlfMEXAZ5oNWndO+2s
         a2dnGJ8FDvYkuh6nh/0ffSlytiwiHcuT6roKQi4aPwntlKdiJC5MqG9VvUGD/AtPepK5
         XQCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712557055; x=1713161855;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZIrRvs1aIE/8shAMEAS1ZklgR4ayR9BEDUAx+mQnyLs=;
        b=buU3DqoLhPTpYHXe7rY1Tp3vv+p6sfJo8Q2sqInnQh22tccCVq2M4zYk3KXMCXRrCG
         R2xtI0vCuUSqoIosKEXGndSlY5QkryNVeYNQH+nvFh3E6sJpIIlMfiqlOTcsNLtLXzf6
         hJJ8GgnUqz655ltg9VlTQsZePsz5Gt6nvjLalO+ut8Rl3lFi/tFWSSuW/MtF8b5+kEoV
         Qmovr1bwYp1LF8onWBoYY+lsuPupSOvnjrpl24VdxiKVg++9DFksENsg0ffSm5S0gQ6c
         xZUd1ogxX5tAm/x47AosZzj3YgyJSAxzH22OVIYR01heDWiAVBL8fUhmceAzCWSObCQD
         NrKw==
X-Forwarded-Encrypted: i=1; AJvYcCVxm5tsbVvF+p90hWzyMBr1jBZGKlIgQVaZEbGJPbI4KrV3rVSmsvzHR6en1ZNejNqoHn5P8P6oL0n2L6Ig4KXEix45lxjWBa9h
X-Gm-Message-State: AOJu0Yw8HMLiZk7/RIW6vCGMDAO61lWmBWnspqzHRphsNcCf0jvCSJiv
	DUXXPKkfrp/eEni3pve20NOSEUsfw2eyUQmsGTgb7dQwXfI+Ctd6nQkkjvz19J4=
X-Google-Smtp-Source: AGHT+IHCx1CeaSFEJmDklmq3jEzroAPjnOyDGblSuYj0igcXlEpjqsrY9MxqvXhQxwOjORroUnJJaA==
X-Received: by 2002:a17:906:fb10:b0:a51:d611:c6b9 with SMTP id lz16-20020a170906fb1000b00a51d611c6b9mr874864ejb.59.1712557055409;
        Sun, 07 Apr 2024 23:17:35 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.144.67])
        by smtp.gmail.com with ESMTPSA id hd19-20020a170907969300b00a51bd3b432fsm2572098ejc.115.2024.04.07.23.17.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Apr 2024 23:17:35 -0700 (PDT)
Message-ID: <818c0c29-caf6-4c70-92d6-f051a7624e22@linaro.org>
Date: Mon, 8 Apr 2024 08:17:33 +0200
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/9] target/microblaze: Use insn_start from
 DisasContextBase
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Jorgen.Hansen@wdc.com,
 Jonathan.Cameron@huawei.com, linux-cxl@vger.kernel.org
References: <20240406223248.502699-1-richard.henderson@linaro.org>
 <20240406223248.502699-7-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240406223248.502699-7-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/4/24 00:32, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/microblaze/translate.c | 8 ++------
>   1 file changed, 2 insertions(+), 6 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

