Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3173312B75
	for <linux-cxl@vger.kernel.org>; Mon,  8 Apr 2024 06:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712557527; cv=none; b=YpVnRTzk0MEZZEvWyf+r7vuudOflN2qIthnSi8DjWGhN/XHrBqDwk1Yd40hhdCKqAiAb8cKKqvQ8IpBVY+y6FeCKewBdWxBv0ozFsi9gK7hX0zx37rcIPHIig+mnBLqUsKo8nMgeCkVC8BlmFd2jzAJJTnFgXkH1SgbBNTcqP8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712557527; c=relaxed/simple;
	bh=7gdtqbO6kjRxeAYToxo8m5t42/eB1mCfyiuMehChjiU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qnEMxmiMuxwvKtUPlQD6nnmiRY8CaWS9VBh9rQ5f4KvDVhRzMOEdJvDE0gHtwYPj+9+6Q8UFS6QKIj28nWwgxTf30LE/RPEmHxD1Kb3PscQbtAD0YO/hqa68mZTqdr5SIQPTLjpfVc4j3FJJT7knAkB54X6FAfeCOV5n2WILPCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ehh/ZjKS; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ehh/ZjKS"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a46ea03c2a5so683134466b.1
        for <linux-cxl@vger.kernel.org>; Sun, 07 Apr 2024 23:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712557523; x=1713162323; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Mrm1/b5OpHMFSR2CNHhxxzPYHyFuhaTIqvcttXXJv/I=;
        b=ehh/ZjKSN8qJ2grMUVuOeJBBfgXlUZd8ICyUvY3wD1IYqltDOfRwrcdR/DG5jdtYqH
         DzoC8tcSGrUcjXTQhSi60GGdWgtuJ/4wUl9sjMNQ6GAk0oWN9z1SaeiEVVeJDxsWjGH9
         6KH1X5vJ6ghVuSGN5uGy/L/3W/MvaPWYrCDSOnmzXPzem/b7ixlP9nOoW0rEqybk/gff
         O6ZpqxppbYX1bVAscDFGuh9AzUIIXUOd7gkqBTwfWccF0e+N7uLtSc+YqSDsZ11jDjvU
         eirAzBqw6zUUVU77cHTKHHdA+cD+KB2TKKl2+uh3D8t0Sds2vGxVEl/oUkdG7Vh/u8x/
         XtqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712557523; x=1713162323;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mrm1/b5OpHMFSR2CNHhxxzPYHyFuhaTIqvcttXXJv/I=;
        b=xCQiQe4Wo8s7UuwJLXWp04ZBmMlQexKSaHL1eKbjff/ZtlBKFyj/xzJZ19bspfzn3F
         DOVa/kDGDXUfvR1FBhU+aeBm305Uimo9pajU70ud58Lwf48iDZR9LZGmSt2fIz09bSeP
         3brvBX2t6tNqBSP4lJpGzdJYSHGs7fk6mB/GujxRPbMFtMR/gub++xJ+5xz+2azvb7gz
         OGo0ywtQHQT6o52vQNOLiq0RChNjMUCqwjEMCP49Azzu2ChhAo4PjHEaTsd3QIGIkGT3
         0FBVxoN4QwfWW/e6NX5eHtrZWPZJKkWn2Iy+w63Twm5I55YxM10BfoKVhm6udlbl7v6L
         olAw==
X-Forwarded-Encrypted: i=1; AJvYcCW+460F1cSOxi1OA5rQzqWisEofY1eoql6teOZnB3A50Q5hCfqzYiECi+sZWomlo0llPcwaFCazCbrkDPPlO8sfZP6VXQK9Bcg8
X-Gm-Message-State: AOJu0YzhCwbL8sNDOLZQ0qTA3W2OGkJMYqMhXA5e59U8g91WuClce9ST
	Q3Ho52l7AsHp7CuCEF4HNcNc5LBrLYuZBrR0YSgjz7KiQmxyJO401LW7RQ1Dzlg=
X-Google-Smtp-Source: AGHT+IF3NsEUS26WcV/epzRtzl13htGE4Akhfrtz7Hmh2RgQY4G1UjZ9PZvQHHJ+dlJhdG8vLpVRaQ==
X-Received: by 2002:a17:907:94c7:b0:a51:d4b1:cf56 with SMTP id dn7-20020a17090794c700b00a51d4b1cf56mr2040712ejc.10.1712557523471;
        Sun, 07 Apr 2024 23:25:23 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.144.67])
        by smtp.gmail.com with ESMTPSA id sa10-20020a1709076d0a00b00a4e6582edf8sm3974219ejc.102.2024.04.07.23.25.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Apr 2024 23:25:23 -0700 (PDT)
Message-ID: <086c539c-e2e2-4639-8baa-607225bc450f@linaro.org>
Date: Mon, 8 Apr 2024 08:25:21 +0200
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 9/9] accel/tcg: Improve can_do_io management
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Jorgen.Hansen@wdc.com,
 Jonathan.Cameron@huawei.com, linux-cxl@vger.kernel.org
References: <20240406223248.502699-1-richard.henderson@linaro.org>
 <20240406223248.502699-10-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240406223248.502699-10-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/4/24 00:32, Richard Henderson wrote:
> We already attempted to set and clear can_do_io before the first
> and last insns, but only used the initial value of max_insns and
> the call to translator_io_start to find those insns.
> 
> Now that we track insn_start in DisasContextBase, and now that
> we have emit_before_op, we can wait until we have finished
> translation to identify the true first and last insns and emit
> the sets of can_do_io at that time.
> 
> This fixes case of a translation block which crossed a page boundary,
> and for which the second page turned out to be mmio.  In this case we
> truncate the block, and the previous logic for can_do_io could leave
> a block with a single insn with can_do_io set to false, which would
> fail an assertion in cpu_io_recompile.
> 
> Reported-by: Jørgen Hansen <Jorgen.Hansen@wdc.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/exec/translator.h |  1 -
>   accel/tcg/translator.c    | 45 ++++++++++++++++++++-------------------
>   2 files changed, 23 insertions(+), 23 deletions(-)

Nice!

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

