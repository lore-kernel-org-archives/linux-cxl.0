Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41CAA3A1DB
	for <linux-cxl@vger.kernel.org>; Wed, 21 Feb 2024 20:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708549196; cv=none; b=dNbEP0Agywnovdu0rayVdYzb7jhLUeJm3S5NI047radTT8FHu8oGbhJdVkSaqGqSqkuGGbcNp9ZpXmZnKUNUlN3/xp8r1dc0vrtaV8NsPLcXLJAm1XwqXI3tf0jIEuLnhxcxEUxO7fsv+BJJ+A2WP4N3vFBay7gx+bQPRY7GqVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708549196; c=relaxed/simple;
	bh=4sH1tF2/+L68Q+Yl9WJ6fO6RMFF46fPFLYnCNPPLv/8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L4l781/J3NITjEocT69By97IcrKBj4l0F7iShGFg+avXYq1/W279OEIeK208mPR4w9kzpDdyfWG7kTPgsKSXixK4/OeCQzasFBYQ1uwsmr2e36THBjI9U0WQ8BB5UP15gMphzJ8cIVHHkmZ3yA14GCvpWPjwznFf1aJ/6DFNpD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mggvXVdV; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mggvXVdV"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-33d6f1f17e5so1337263f8f.3
        for <linux-cxl@vger.kernel.org>; Wed, 21 Feb 2024 12:59:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708549192; x=1709153992; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TJHUmTcTe52nfZvKCbbOOWWrx0DcS8/ew3ywUAipXKk=;
        b=mggvXVdV8Sa8F0stHzhP/OF0molSH9tw3FQKj9KJqx8tu7jEe1as1y/c5ksRR0WfmL
         wj//gJFQS0IcqheSUurlyjVOChFNNKa6k2Sff50Ebww6o8H+G//Ij0mD1iKhT0rOinmy
         beFGwaWulx+QCvQsKKlzlBKuP9LLLtLwDyL7cK+UAjWsLzcksy6/wGNnuJTTO5bTaNES
         2MU9ZgiSPsZJwEVNiw5l+xhpGyAWhtMbGXw9uvsrF4n03AoZK9rSTN35NI7MVQm8Ehkk
         jwI6uKt+zwUgPfZ5aot3ugclbhP9X664Gx2gRENnt0/pmBMnRc4qgNM6NEh+RtEjdcgD
         O7/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708549192; x=1709153992;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TJHUmTcTe52nfZvKCbbOOWWrx0DcS8/ew3ywUAipXKk=;
        b=bPxNQeBnZn9jvnRzRY5NE5U3nHN6IwooViEozeq7+AWMvEo3PAFXlvfBTNPpmJXx1a
         Z6lW0h969edyxMeStKJOUKObylPLyHZ74I3S4gG36yFwgjrLUr3PXR1I7qwJhwPrQ6bA
         LdOgV6/JFOFhOD82pwz9qrtgmyEFkCbEIXCPu8rh7eSbV45Wop6TVsN7AImhvjpmSaln
         A5E1MfjFsmFdtx8R5vS3PMXLFnKXvVUjm+3TIA2QBmzSkbDKvsBEpNfZXF9LjMWpqqqF
         Q0x66mp8+gnth90R7a4NffHbUFWJOOt2rj3i3Knfh+CmP8KwtX0TBnpb2KdBoed/HoDc
         JqpA==
X-Forwarded-Encrypted: i=1; AJvYcCWN9WydOrJStw4Mo4/Az6eR6BMKi9LMTCZU2xwrYOTPac1ATNVVffYSJHbTq1Nj0IoP8HN5xR9k5rUm+dyKj7Ud20I8CisUcN7F
X-Gm-Message-State: AOJu0Yx27J/7wcNTT/VJNIMgF5wCb70FQ8mjGqAl46cpam7UgSYDTDK/
	bgLjctvq5dUgLWIvuh/MiuVVUGC/A0DlnQ6lAwS49/jaNqwjYyo7qC3WUoa5bdQ=
X-Google-Smtp-Source: AGHT+IEiwwvhL1jXvLVKdXVU6B4j4XAUExgqOwCKBOvJE8vc3ySuGqaoZB9bupwOs63okZUYurmhSA==
X-Received: by 2002:adf:a488:0:b0:33d:15d7:1164 with SMTP id g8-20020adfa488000000b0033d15d71164mr10188002wrb.25.1708549192424;
        Wed, 21 Feb 2024 12:59:52 -0800 (PST)
Received: from [192.168.69.100] ([176.187.211.34])
        by smtp.gmail.com with ESMTPSA id bt21-20020a056000081500b0033d1f25b798sm18164842wrb.82.2024.02.21.12.59.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Feb 2024 12:59:51 -0800 (PST)
Message-ID: <5c0bbc43-b5bb-41b8-8c4c-3d58efb687ce@linaro.org>
Date: Wed, 21 Feb 2024 21:59:49 +0100
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/cxl/cxl-mailbox-utils: remove unneeded mailbox output
 payload space zeroing
Content-Language: en-US
To: nifan.cxl@gmail.com, qemu-devel@nongnu.org
Cc: jonathan.cameron@huawei.com, linux-cxl@vger.kernel.org,
 gregory.price@memverge.com, ira.weiny@intel.com, dan.j.williams@intel.com,
 a.manzanares@samsung.com, dave@stgolabs.net, nmtadam.samsung@gmail.com,
 jim.harris@samsung.com, Fan Ni <fan.ni@samsung.com>
References: <20240221185425.1088766-1-nifan.cxl@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240221185425.1088766-1-nifan.cxl@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 21/2/24 19:53, nifan.cxl@gmail.com wrote:
> From: Fan Ni <fan.ni@samsung.com>
> 
> The whole mailbox output payload space is already zeroed after copying
> out the input payload, which happens before processing the specific mailbox
> command:
> https://elixir.bootlin.com/qemu/latest/source/hw/cxl/cxl-device-utils.c#L204

Since "latest" isn't stable, this link won't be accurate in 6 months.

Please use the current release:
https://elixir.bootlin.com/qemu/v8.2.1/source/hw/cxl/cxl-device-utils.c#L204

> 
> Signed-off-by: Fan Ni <fan.ni@samsung.com>
> ---
>   hw/cxl/cxl-mailbox-utils.c | 7 -------
>   1 file changed, 7 deletions(-)

