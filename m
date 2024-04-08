Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593AA8475
	for <linux-cxl@vger.kernel.org>; Mon,  8 Apr 2024 06:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712557092; cv=none; b=lox+9f7MXREJDq4cGTH2rMAxJB87E/TJdQx6yBjTUXnD0+6UEUwigWo6Bsfcx2G1/Hn9pJk0IWtkQwVWeG4RIYZU8cMQbkazwaPpqM0qCc1NkAF6QA+8rRHJa9hDfw+ZQhKuD/8Yt8I6FnwpQ0UVh3Dl60/jyGE9o4aCCWRkLJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712557092; c=relaxed/simple;
	bh=Dj7NRgIgBl/Z1b+YbgOftVRA7NgfVm5qkZxKDT9kVn4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XGThCCUE0ZpDkfwWQqeNjDshGQuqonsLvL7CweGQsc3ALNkH5sbdYZWJ3MP7l4b9+vZHdzmLv1chiw5WeWaQbHjZ87iL/8u50HJLVMa+xOWlItVDcsq4cxraXQ/gi0d2SDMStCBfOsQhuiEETB9DNZSY0oXWqdTCmdaYJMljuHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fd97p8mj; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fd97p8mj"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-56e4a148aecso1127787a12.1
        for <linux-cxl@vger.kernel.org>; Sun, 07 Apr 2024 23:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712557088; x=1713161888; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jXT+u91YzwnYisHkGtQ7RMNE8T/27Hhc7IWGPE+hJUk=;
        b=fd97p8mj8f+3qxbQvPMZfZ0p1/EhGnMnqI+QfVqSCXUE2uk62VLZ4Wc9rWYc1jEDrN
         gq0cpYKm7uSS8RuN4qkWJScOc5QoSVPa9IUWgxJVbL3+RFNz7WIDnoeD3uGLdMUBzgk9
         GnYFV95SVcPXT5Zajs799hZPKJnfqQmhjB52hSazDAiSPGhL08lcAVGO0oriQO5nCR73
         bFOpYHCgB2KL4dJ/Fe3kZwQXJJxtDLx6ZKKhiTvfNmIRoewn4/hJzk4G0Urar+d3yqEq
         x3ZOjkVCJCSsTxUX0Ae+UGEcw17lTGJawnez/1prgQiK7x21O+dePsNVpKQoPtMtMBBy
         HGog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712557088; x=1713161888;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jXT+u91YzwnYisHkGtQ7RMNE8T/27Hhc7IWGPE+hJUk=;
        b=MfKjF7CX83LNWGzd+krhw0TOQh2EBnC5n3sNST+NBKESYxT7xwnnqwHneO8RYhLau2
         9GzZ25zMVp0KZ4xJPTNGaGUythZSQOZkKyaZ+YdKltm7RZHyDYGChcU8V2oLydxCcZFY
         rViJc6wSQ8zsDS829sYl/Dm2YkblgZYb4ZB93ZsAdYm/qKSvp/is0c1q79Wk3aM4NbTO
         T/e1/VVVMu/t8VPOo8LkUUoSrVD2k0B+EBFdARFHbW6m30ITntNWTgi2grwjFy3qJi5q
         zuCs4NstwsJXLT5lvdVQjOHnLeGZjuOGPbhPKkPlzm1cfVIN/9RUTrIC56cukuo9wBqy
         YNFg==
X-Forwarded-Encrypted: i=1; AJvYcCV/0dYB/0x9WVxnJUN8A1H6c7XVjgNlfxPVnC54RET60LW/vmjODyPEoxwrTvsqc9hvoT08Dv28vDgiQpZKuhxsAjap5MMI0ddj
X-Gm-Message-State: AOJu0YwhlaOWZpvUNwwqT335BQmOsq2z8qYD8oRFORfJPCVvPCU11hZV
	m/1A7wRhALRi0XjA7GBB/BMkcY2u7B1HbO+wGRht620tlrhkY9g51RkRxzXss8o=
X-Google-Smtp-Source: AGHT+IE8G9FpbuiFt9N94IrkmybyxwuXdQpcHdFJjNKBkNE/AuE8zdWhQVkv8X+AFRyuXYXSlr4TXA==
X-Received: by 2002:a17:907:6d16:b0:a4e:2e25:75b5 with SMTP id sa22-20020a1709076d1600b00a4e2e2575b5mr7169015ejc.55.1712557088770;
        Sun, 07 Apr 2024 23:18:08 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.144.67])
        by smtp.gmail.com with ESMTPSA id e27-20020a1709062c1b00b00a4650ec48d0sm4029273ejh.140.2024.04.07.23.18.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Apr 2024 23:18:08 -0700 (PDT)
Message-ID: <625affbb-c883-4624-8c30-893f37ecbabb@linaro.org>
Date: Mon, 8 Apr 2024 08:18:06 +0200
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/9] target/s390x: Use insn_start from DisasContextBase
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Jorgen.Hansen@wdc.com,
 Jonathan.Cameron@huawei.com, linux-cxl@vger.kernel.org
References: <20240406223248.502699-1-richard.henderson@linaro.org>
 <20240406223248.502699-9-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240406223248.502699-9-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/4/24 00:32, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/s390x/tcg/translate.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

