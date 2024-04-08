Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88ADA125DB
	for <linux-cxl@vger.kernel.org>; Mon,  8 Apr 2024 06:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712557078; cv=none; b=ouNbat4Ez6fqU4izoTsyWbNgOMU3w5KaW75/RFXcpAr+BB9Ifx7vh81bf3XWcZLHkhGFkjyqGzT4EEFN6c5brYYydYrirY8h58+VTt5WwWwFA46tNfrzc3xngatRRX0tSqqOhxmPIOO1pTC93etHdxmzQc0H/3XCeTSD+SisXtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712557078; c=relaxed/simple;
	bh=8JqPMHS5mJsIHXKWIxUzoad9WR8APDx+VgoS2kdoN00=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GMKs8zNbiPaNZo2XIWnPQqK5NcYPpOMG4WaWbkbKHV/95XJc+ZvEVZGJZYv9aRITKaKNG/IAj2b8/o7SIXgfKG1ne9slCg08GSR5Zi9W1nEY4EHtBLSTQOxSVUV3c/DRPZZHUKaGWVpq2A/XvZrMZHQ+0aEI2PsQ7yFMaCqz+uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vX5oyFgQ; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vX5oyFgQ"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a46ea03c2a5so682287966b.1
        for <linux-cxl@vger.kernel.org>; Sun, 07 Apr 2024 23:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712557075; x=1713161875; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zGYrNQCJFqg8tYtGpRnhZx4PA9z4hLrPFSSPf9gp9LU=;
        b=vX5oyFgQUKtG8eOLmqz7WzB6mC1FWVnXaQnfFPpE1CVMjG8S6jm4XwbIPs9Tbgkov0
         7yQGGphjbWiytarQul90Y9I38tRGEaeDwp+GqRshnxTBeH+H2lkaL6cG2Nufpcf2rk1b
         czAvBnOt4BdavmzpFw0n5IdF4bktskPgC6x4AsNWbVf2WeBQ3SxFWyKVWoeVfYMX8JAb
         PVgk9r4zBH4Lcph2J+4Zm/kUuNv8NKU/uh+Znhzr2hY+ZfxHY9Qcr588aVY+9wFu0B4g
         I1c/dRy38wXttYjqvpYyrjdyEeCIA8dFSfnPjbhMAtZSCVg8P4F22RjqpaSxSGMZVR4Q
         0g9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712557075; x=1713161875;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zGYrNQCJFqg8tYtGpRnhZx4PA9z4hLrPFSSPf9gp9LU=;
        b=wPBnXsaXvq9LJnZpj1R6yPzv9aJTxhqPTjcEwjO05iIleRlz3/Ciq0asSkK8zp4tTS
         KOO7FUJLzH4vn2SIfznP3mP4tfnaUXDh9iW6GN2BsNkMKZyoJUpBFRH7b2WlwEf/mF21
         ndLXgnCuZsvvWx7FxRi4M3jz2KpSkmo07AiqXRpFihegp6tCrSOiI6CiWi775ML3oPz8
         VMKd+AvEhM5xMISSSb3LEpBmFOE6LIqjRWsC9DJe1pDPXhAhgr8HO4M4UjNhMkPDWywi
         OuvLfXP1fFa3mk/CVwktc0SUtgD5NfZnhjxAciVvKLhbDKcXG5i9z2O47f+SxByyW5Kn
         VqgA==
X-Forwarded-Encrypted: i=1; AJvYcCWqXxegdk4m4RgtHtg4YicEKdG1OKyHGTPFv04a5lmJUWj8vMSIonG0c4uDXRex80nEYoqP6zrDaYf/Ab/frD4WQ6xFjeQtZkbC
X-Gm-Message-State: AOJu0Yz0OBXfF4mwazAQ1z+Gq0yw1c0qAC4LJl+KFI7ff5jwizrqw+2v
	HCOGnp97HXHHYiZgCM4gmsyFXZNg680KNgb3IW55UQKY9FYu6ImRO9bm3OkJUvY=
X-Google-Smtp-Source: AGHT+IFDcYRnyQ0SfHRLka7x0ISHnmyr54p4U2S9AGhaCqMd3jyH9c5jJ6cfzGcY+YD1M2xNvyoAFw==
X-Received: by 2002:a17:907:971f:b0:a51:affc:ad66 with SMTP id jg31-20020a170907971f00b00a51affcad66mr7355107ejc.12.1712557074966;
        Sun, 07 Apr 2024 23:17:54 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.144.67])
        by smtp.gmail.com with ESMTPSA id h22-20020a1709067cd600b00a4739efd7cesm4033053ejp.60.2024.04.07.23.17.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Apr 2024 23:17:54 -0700 (PDT)
Message-ID: <4a2e59bc-5061-46f5-aac0-791d87ab5259@linaro.org>
Date: Mon, 8 Apr 2024 08:17:52 +0200
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/9] target/riscv: Use insn_start from DisasContextBase
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Jorgen.Hansen@wdc.com,
 Jonathan.Cameron@huawei.com, linux-cxl@vger.kernel.org
References: <20240406223248.502699-1-richard.henderson@linaro.org>
 <20240406223248.502699-8-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240406223248.502699-8-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/4/24 00:32, Richard Henderson wrote:
> To keep the multiple update check, replace insn_start
> with insn_start_updated.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/riscv/translate.c | 11 +++++------
>   1 file changed, 5 insertions(+), 6 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

