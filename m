Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6BA3D3D16
	for <linux-cxl@vger.kernel.org>; Fri, 20 Mar 2026 17:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774027553; cv=none; b=jnEI6Hb6/liOFMEzF2qdZFa/cgEzq8lsdIxZwUGU2ibRj022Jz9iUc+4SgdCJLhQkPPlsNeB8oE7cPUXmszanqxMwFt40bViBARtlGtwZiRBeaP/sn6NS2J3rJlIm2veVGOgZlRR5pCTSNpINJlSXAoq/YZ+gCAhNgq/6k69+NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774027553; c=relaxed/simple;
	bh=3fSdDJFbX/UF8TqIOccS25W+2cGMSyCwQsxne17PRds=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rCcPb73ch13hqRptyk+OxBYQzKhImun266HFJWzp4TR1Pk2kJs9tkjs6/FCn+vct+caOHcNy7lr54HP9vIrdXnIYzDD/2lhcLb7MmTuww8tAsdwmp4y+bDu5dWr7acQVixc2sEU6AbJMZCmDXAtck5e4IqHqHLzQpp5WCrfPkEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b0eT+yAR; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b0eT+yAR"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-486fb112c09so6911545e9.1
        for <linux-cxl@vger.kernel.org>; Fri, 20 Mar 2026 10:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774027546; x=1774632346; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+viBsL1LV1syQJtwyDa3wbaYzbuA8qNDXpLw2O2MudU=;
        b=b0eT+yARBY5tuL7RVI5ITvbIS37WOgNa2bMOUZsSVNDRmT7rp31tHH31kFIl9uG8hS
         Ooo5sBiy+2NPtYgWtZ119RNKdTJLTtfpinI4Dzs9sBT4CnKaVbv6sgzxrfwJk59meTyc
         wThRdd0t6CUdfkzJ4hVUggA8ljFonO8KO8geTh6836OARZOJnBknaXC6jWVTRKyMiPAL
         h6clRPKsqPGF5smDrXjRieooBbiBDeuQdGwRyh7WEjNRkKUEUo/ahAkYUj7ljvi6VVvU
         laIE9qITs/JPga/0CLWr+UDXbND9dUDDkKdXG9H7uzH8vl1SeC6WQ5pXBIIPc7Vrrrsx
         WBaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774027546; x=1774632346;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+viBsL1LV1syQJtwyDa3wbaYzbuA8qNDXpLw2O2MudU=;
        b=RgvR6KDaKfqB73DETXqS1ltSR1IGp5THiJR9Qr0nMM25t+QNXiGHKkS3dzRbt/qn8c
         G6YmImVqEvGKLn6XAymLmsVrP5yILScsdoi7FZ3/3PtBt4N0brQJK58Ya+571a5394ZQ
         0KaIgggmp0u88IYfgoSK2VjCLukQhdkmbADm7a0thQsR5qyLH1s2rPYPIoFoAMFSU2Xi
         yitCDUBUgvl7ri/f2xpwMpsExDq37H2PmH5EI7KSzhT+JV0ECvMmI2seo3Buh67ky23L
         GqLgQhFC0SsUEke6nrT2nWvaQ29kxY+O5wzksnu7fe8M0RJyUMqma+kBu2Ca5sT55vLY
         8cvQ==
X-Forwarded-Encrypted: i=1; AJvYcCWh92n+XFotXIy9foNEoHRf5DNn9EDVoZKFfssr6RKFT8WnLmvfJ1EUEKiyUTX8anXydoNzlveYdNw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyY6tPCRev/rBgduBJHHNJkKw1OwEv9Wixd8XKV0A5MZ+pd+QgM
	JGXmM/Lvuo0fRo1tFeV2YkG6qSu+zKqV+6m6dirKmxI2mCiRDds1FPIW
X-Gm-Gg: ATEYQzxu8N9xn7OkmtSwdl/seB1Dbi65qTKXUQwrSkQDnlzlR7/vtPXtDe1ZA/0fj3z
	7zitGQNh+rm/Yof6sVN/qgqscAQGcsDx4coVAYTc3I22c/A6yPcvYOqE9mCqhgjB4LLWDNLFmZc
	zza5bJ9vhKPIZXL2yv7ejMdJAy0h+nOVvbOwCvM2zkyrmD18M3Zy0K7YwK4tYW4mmUbMtblzyC3
	nLoGGkAZVFMy4QA8nAGIDDVZ2UcoJbCN7iG+s0w0AIMCAo6KaH1gVppTnjQDqeLqvMJJTrALSCh
	4150m7go2B2Sc6TbwhYGzDZ5FsLZRrIUC2aMGaF5DXTmwB6XiUSpNDaxnKzxsNZohKkRcv4Q5DM
	ELJmfUZ1PrYrF1qIKqfk0qIg+pZAs6CqxGhtcw3+L/hQIbdTdIivQsvdW9M8KsZqYNRodx7JPiD
	cFR5PyTwDyBsNzW758Wt9d6g7GyLq/dW8peL6tz505N3nkAzjxG3sdqbAyNsR0+pJmBzSidTm50
	UZHoKCbhwueIpDzxKxFvIR4
X-Received: by 2002:a05:600c:a43:b0:486:f8e9:add5 with SMTP id 5b1f17b1804b1-486fee0fbcemr52991765e9.19.1774027546346;
        Fri, 20 Mar 2026 10:25:46 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486fe032a55sm140067275e9.7.2026.03.20.10.25.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Mar 2026 10:25:46 -0700 (PDT)
Message-ID: <4abd7d64-2973-436b-8eb4-ea3b92e38167@gmail.com>
Date: Fri, 20 Mar 2026 17:25:45 +0000
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v23 11/22] sfc: obtain decoder and region if committed by
 firmware
To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, dan.j.williams@intel.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, dave.jiang@intel.com
Cc: Alejandro Lucero <alucerop@amd.com>
References: <20260201155438.2664640-1-alejandro.lucero-palau@amd.com>
 <20260201155438.2664640-12-alejandro.lucero-palau@amd.com>
Content-Language: en-GB
From: Edward Cree <ecree.xilinx@gmail.com>
In-Reply-To: <20260201155438.2664640-12-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 01/02/2026 15:54, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Check if device HDM is already committed during firmware/BIOS
> initialization.
> 
> A CXL region should exist if so after memdev allocation/initialization.
> Get HPA from region and map it.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>

Acked-by: Edward Cree <ecree.xilinx@gmail.com>
