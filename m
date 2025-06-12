Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B862F4317
	for <linux-cxl@vger.kernel.org>; Thu, 12 Jun 2025 16:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749744286; cv=none; b=TkAMRQJXgLnEKQzgED8H9xkXGF3BZHoGd88DmDEyqlKaSPzs8GUInkmrMoij3vcSuGGt162gYa8sR6ugLMISQqg0S8s5jcpIYUu5/uIPT9Ot/aJYD3HR66HoQaJQ3g8s/0zyabmdSZXrBCkUdYS863kykwST93ikZNjCIs7M2UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749744286; c=relaxed/simple;
	bh=74HlUB2oFeuUYSSOugXT6kNy62cj1dC5X1cHOYad6C0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IGCWSuvaII5Mflsp5Ijy8O3A1cXTJYUwvRSU6l6KQXIk+z2r2T4TpjwTdoTP9k6Ey98Hbyit8/0Uk5sgauel+74yOJUvS/q/79xPj6jO6fIRW4LN68lfuedsuTsv++UBfAlixljvi3oX+iSoZVVUVGN0mq9fPZDrSNNl5xd3/gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YbG7uvhX; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YbG7uvhX"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-710e344bbf9so10117157b3.2
        for <linux-cxl@vger.kernel.org>; Thu, 12 Jun 2025 09:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749744283; x=1750349083; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EefkG4AutVpnBM/hBmoXMzaEp175aj32Sbgg3k63XCY=;
        b=YbG7uvhXBmS/e9HFbAufubKoq174UGrd8BsWZY5iJtFbXYlCrSsKEkMp1C8ngXLLAB
         GW79rH/39ooR0MaeJ1/8qo1hdYjrF3EIpo6vH2CoeBmN7cAxO84S0XTb6I7eOvDy0UBL
         ljrMeMPrH9xVVCaawyw06oM/BTE7bq4mE4XF8dwL+z14BkCiLfHE0p1FxkGfXaNk3n62
         9Amo8xOjWLKuk0zgV3+V9B6HGPa1b/tT+6dqkcO38oQzMaZ8Vkl0fzr0Luk0yKlnB665
         JW0P3T8ozCaJVcVkgoG8VXyONSO+dpDOzcSIyCvy+rkSonRNb1TOa7A1YcCJe1A426hS
         dbIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749744283; x=1750349083;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EefkG4AutVpnBM/hBmoXMzaEp175aj32Sbgg3k63XCY=;
        b=qy0mlc8UjRhbw3sRl58/gUbc30Tx57EFeaZKRpQxHldSFwhNWnn4qMsRZkNvs2eljh
         qfg6dd08Rsoo1b4h9yAfw8DaZm5Hv3MYFzdKKyUzRpAFxoivzPOOMHQj9AMNWubc57o2
         OkoRkRdZC5tCErfWJL+sE+LoXbwDDdTiP52nyR5t0Z5X3b0DM/jMPQ6F8ldxpLGdqi6/
         v8IgCW244/Fu/FfUrlCncsIDVZZCxC4/n7kG9QMZhGAaKZgQbh7WkoviimMnz5afF3vs
         UNrSk/waLb6Oj3hO3MppiXx6OKZhmTe+b1LzR2a4jxwcjuv1MYBzEK7vY+DYXEezUuat
         jvTg==
X-Forwarded-Encrypted: i=1; AJvYcCUlO/uZkrVR3jXUA1f2kexQaPMq3hNNTqGpfDsIraRHG/RsFYXIrd2m5Qj5GH0aGJRVGc3mNdQoKA0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAtHwdFlZ5TRNC8ak4Ba1vySUFYu3l0e5dC82+enE5XEznNHGy
	BM98dt7U/+k/xVE3cQcaOYe40AplXDF86F/pjARK7uKN1jIbkmoNXKKGuJl5tSuKJHKelPzUHFN
	mfSBJr73DQZz1GMTw+k1rnwsLpNlYXmEA+KDVLIhYxQ==
X-Gm-Gg: ASbGncsIvzgznZb7oH5kd3LUQ/xFRKpMo9bTaHm2oBb6w0NYarmWW/986XXDuOEuAdT
	9JJY+KooEwKNHWJyg2x84I/sJcodL8tzb0nxgltMKRkQVj3XT/J1833+dIsxNu9VIaKCgPismjz
	ZEp48pim1BEmwPaEOPCOBFqZtjmFPrk367kUgmQderhVqaxXOM613TYS4=
X-Google-Smtp-Source: AGHT+IG/sKTyln7/Rh9ZAyvgO3cTqV7x3+t7YPsMib12hMamHWC1vsfheBF6RN59okgSiPTyIy/EYdtm8QgDURCe6mQ=
X-Received: by 2002:a05:690c:46c6:b0:70e:7663:8bb4 with SMTP id
 00721157ae682-71161f3b72dmr6621557b3.25.1749744283371; Thu, 12 Jun 2025
 09:04:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250612134338.1871023-1-Jonathan.Cameron@huawei.com>
In-Reply-To: <20250612134338.1871023-1-Jonathan.Cameron@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Jun 2025 17:04:32 +0100
X-Gm-Features: AX0GCFsVkhB-NNCIPuW5Ihp7pcwAXu-4Z1zJIMp9UK--qP27Z1yH3-eqLOzVB4c
Message-ID: <CAFEAcA9CuQWL2b63+XCe+vZCGR7hRSx8SkTR0LDa+Ra1Z5ur7w@mail.gmail.com>
Subject: Re: [PATCH v15 0/4] arm/virt: CXL support via pxb_cxl
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: qemu-devel@nongnu.org, Fan Ni <fan.ni@samsung.com>, mst@redhat.com, 
	Zhijian Li <lizhijian@fujitsu.com>, Itaru Kitayama <itaru.kitayama@linux.dev>, linuxarm@huawei.com, 
	linux-cxl@vger.kernel.org, qemu-arm@nongnu.org, 
	Yuquan Wang <wangyuquan1236@phytium.com.cn>, 
	=?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
	Alireza Sanaee <alireza.sanaee@huawei.com>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 12 Jun 2025 at 14:43, Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> v15:
>   - Split the address map calculations and mmio setup into separate
>     functions in patch 2, allowing v14 patch 3 to be dropped as not
>     x86 and arm make the same calls.  Note I felt this was a sufficient
>     change to trigger dropping tags. (Zhijian Li)
>   - A few other minor tweaks.
>   - TLB issue mentioned in v14 now fixed upstream so dropped reference
>     in this cover letter.
>
> Thanks to Itaru Kitayama and Zhijian Li for testing + reviews.

Hi Jonathan -- I forget where we are on this. Do you think this
series is OK to go upstream at this point, or is there still
stuff you're iterating on here ?  (Put another way, should I
review it and consider queueing it?)

thanks
-- PMM
