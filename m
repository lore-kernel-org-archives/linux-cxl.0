Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2508379FE
	for <linux-cxl@vger.kernel.org>; Mon,  8 Apr 2024 06:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712557102; cv=none; b=Sya/3BCGmf5cs9pEXiz+xDdyNdWY+HMe/mnRIQ6fH6ifUR0kvmr9VMet8GOweO1AWAMN/+zpMFI8no1VMaGh2p8cnr1Ma91Ql6aqbB4Lb7AjAXBRSLelMcnnrucoLr7Vp+J8thiXSv6yshHcX1jEK0FCxhFN4tQ4jrI9euCXUtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712557102; c=relaxed/simple;
	bh=FkvYhL6CrT0mtKUfvIRpIDAlHJPgBt6FC95gSzyaryc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fID3pY1+uAiIg9PnwbFUVaapRi0fpFuCEGo1RF1IaOglCMMq+oRC3L5R9dxawj1N9fhwOypYTT0UWK9/OJrI+raA4okoNiefC/zyhAV2fVeJdGVmLbIiwsxtBmEBKnTqzE/mq1sfRfO7zFbCmWaIm4Tp+Tft95J/LSHTgkPB/2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=c94GGAvP; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c94GGAvP"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-56bdf81706aso5377944a12.2
        for <linux-cxl@vger.kernel.org>; Sun, 07 Apr 2024 23:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712557099; x=1713161899; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RSz/bbwofYl8koEtD5rjk3a44YqnQg5S+o0qyBDryo0=;
        b=c94GGAvPJKq33l33lq0KhiWwAXSpgv0+SNQvLsdbeDP23rUohOb6ahN/cI1f902u6U
         W/roJ4vrcdXjaMFl31zFPLmFsp6uTosfZKMtf3wZ4pRhDMRRngMMmOrwc08sLnxls1bZ
         661C0xl2/KRv1diY+C+q55AN07oCt6U33QS+oQ3NbOfMawBipd3K6sbDmA5UC43kiLJ5
         WGu31icGf8Yzfz2EVIimsHVpbQ1sGrmVHBOP3jdEeGEDvIM+c69yCj0pR2ci8hOV6FC5
         o0NDJ12DUj6wMW7nXZ8/MEwtjBL96lH4HvSZZEaZ5k/eo06ElYbNezXDgairfmfrW3eB
         a0og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712557099; x=1713161899;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RSz/bbwofYl8koEtD5rjk3a44YqnQg5S+o0qyBDryo0=;
        b=HUiocBfVuzApOLyPVroVaqdtMG30gJ+tD/YLv1aut6qsg3FoGVVYWX7QxP6cNeBdKz
         UO0OijmIOko8TbMxG8dO9/1lzlNZpl/DheaRPmAax6a8I/jR13aXRVOLRZM86Bi5eOkY
         YOZwnVlXuTvjZSyB7yt4Gx3cROluNXNLKFNZk23Ky7tS+e/brCptFq2nPwelP75vG0sT
         e43oaFY0gLUN2I88QaWP7GAUgdgmR4GqtnlZ0yJi52x17FYg0suyvE9RL1maAddmRRKq
         vGtxSQs4zmQ9Grz9dCFSXRdy33hbPx5Pg2Uz+P2OrUgQAyDHew88PEkadQ0PCWm905BZ
         9s6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWNU6uPhm9I2bBRxlaI6k1mUzRK3p6uq+HZNcs9Jnh6nd2BtCwWmh2eUZGifLDCGwLNKyFF2i+X+Et5hUf3lH+wN5D3H6TF99IY
X-Gm-Message-State: AOJu0Yws118/fzXZtHG6KNRR1kS4cKr9LLguioZhBbT0cwb3URkXiEGS
	2gEUdoX8xYYG+PGH6ff19Kkpnx3y/glA4haCHB49Rh0IjlrtOCLR/qKDKM+ZpcE=
X-Google-Smtp-Source: AGHT+IETS8WZKmRrI77KEzZDdSBPY7aYd9ZsTXNHdLJrXwem3diozYwBpsJ+OHfjGt/LGy1PLEKSeQ==
X-Received: by 2002:a17:906:fd89:b0:a51:b917:3036 with SMTP id xa9-20020a170906fd8900b00a51b9173036mr3932065ejb.17.1712557099667;
        Sun, 07 Apr 2024 23:18:19 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.144.67])
        by smtp.gmail.com with ESMTPSA id sa2-20020a1709076d0200b00a474ef94fddsm3991001ejc.70.2024.04.07.23.18.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Apr 2024 23:18:19 -0700 (PDT)
Message-ID: <21f16b2d-3c87-4f43-adf2-3f07b23f5c40@linaro.org>
Date: Mon, 8 Apr 2024 08:18:17 +0200
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/9] accel/tcg: Add insn_start to DisasContextBase
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Jorgen.Hansen@wdc.com,
 Jonathan.Cameron@huawei.com, linux-cxl@vger.kernel.org
References: <20240406223248.502699-1-richard.henderson@linaro.org>
 <20240406223248.502699-3-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240406223248.502699-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/4/24 00:32, Richard Henderson wrote:
> This is currently target-specific for many; begin making it
> target independent.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/exec/translator.h | 3 +++
>   accel/tcg/translator.c    | 2 ++
>   2 files changed, 5 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

