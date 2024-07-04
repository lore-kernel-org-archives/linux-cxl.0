Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E9E2F23
	for <linux-cxl@vger.kernel.org>; Thu,  4 Jul 2024 06:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720073873; cv=none; b=QLuYJAoGrHAqPfdDh3mz+DeHKeOtlb3l92txf77SWbH4y6GXGxuJDHiB+LSJjdeDRe6NIUm5lPgNwC6CuoWwa/6UgyEX9W6J8bqqWpz8mBzXsR+SxG83rVkoR+oHxA5lY1Hsb+X2VH1mEw22fuot7jqEZ8e0wYCuQIs/4CFejtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720073873; c=relaxed/simple;
	bh=tIoIFIuVtGWmcIxY4zT7aQym89zCBej5DDe7j7nrZh0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CkIPpZufXmk73yJJVCVJ3cX+RJubIrYKa5Kyogy3A1LkH++XHS9u8GqeNa8wycoGLEL14xZKaomaDjb2kdgg/0jr3AO4S/c6xljja94EJEsOADMrdex6ZiRCI9A9aUVhnBKCh5YpqTTuS/fbz+nJSkmOHNTfaIu4oROOQr4os8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=C9LCPTe9; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C9LCPTe9"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52e9a920e73so229486e87.2
        for <linux-cxl@vger.kernel.org>; Wed, 03 Jul 2024 23:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720073869; x=1720678669; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8d10IcpAzYXVQD0pAR7omm2jt8iBA4V9wulewUkpkms=;
        b=C9LCPTe9m6JbYnp5x92c/RXbX1Z4Pmmh3BWdlhqjvi6lEcB4y7zDc1OH8jwD7OXKPP
         vBvVMQHuOvEkGN92Ch/mPxpxPSt1jUSZ6eM0UxHadAFydVScsS0BeyHZBbjmqNLFriJG
         imNmbZKYNHhNWJEM3VIOwSrLhaOKISRG4jog+7PmQCzU9zuWxcS3A2u+xpswgzwUEnHu
         U6WRINNtY6/UCELU+jtPKxl3YTwu9QbCBwZu+n0kFE6zv1rSwpr2pfQPCPh0cf0GvnfO
         k1jRbY0bXOGcCjtRf7BQEAlkzo6G4lpL6biUx5MEHCqybqILByEsapNkHgiSkJhsdOk6
         DaLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720073869; x=1720678669;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8d10IcpAzYXVQD0pAR7omm2jt8iBA4V9wulewUkpkms=;
        b=hqzQWB55+N+NvH+Wd3vaI7qJQP1k9aY7T9EEKQFrdJIBF0sMvNftVof7lhxMwDA3yD
         ILtgZX6K3VNgvQgbfS6KhcuM34HT9iRVa3ozR7nBgtSra/yuHbajLm4XHz3fNDvy3eJ0
         qVwEsq67zQxtDw4t2Rd2mVyk0wFDK/9RKK8Xt0D+wvIwCTrdz8MvuwTCWVoYp6XIv3wA
         HpqFqweq4DO92/ljbjcnzeQp/dL40PvkSSUAmYqo4ONn2byeckjfUWVLufqA9FofoD3E
         FMPIdsZoEW9ybw4N67/EBy+s8BBVhYqCXlQ66VyB83FozYrtJQKhIZ1CrBiYW4pgb62q
         17pg==
X-Forwarded-Encrypted: i=1; AJvYcCUtBe7Jn3JxdgYrD3kZvL0XXWsWmAlvnlaPmdgEx8Ak7PuEbfJBcfUGkhj0jZEVXodtojlfp+ukmh3yDGP+RsNCrst+p4HmJTAT
X-Gm-Message-State: AOJu0YxzJSZo2mh9wn28j1/UEKz9ovSozQ6QstW0djJE9aF5Y0zXE2tx
	PIZkyQlNymK20j8cqzQ5mPLJq/re6GqguyTmLWnM6U0GxFIEzK9y2z5RjKPdA+Y=
X-Google-Smtp-Source: AGHT+IFnh2TC8Yqy/VZnGtLWvX37QrA6MmWBGG/L7hu0wumlnpmcoDWqzSqqakjWAqpjZkXNURA5wQ==
X-Received: by 2002:ac2:5b83:0:b0:52e:9ba5:9853 with SMTP id 2adb3069b0e04-52ea062de5cmr381853e87.24.1720073867264;
        Wed, 03 Jul 2024 23:17:47 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a2519b6sm10184105e9.33.2024.07.03.23.17.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jul 2024 23:17:46 -0700 (PDT)
Message-ID: <1b45247a-1dcf-46a2-9270-4fd3a0b0da22@linaro.org>
Date: Thu, 4 Jul 2024 08:17:44 +0200
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/acpi: simplify returning pointer without cleanup
To: Dan Williams <dan.j.williams@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240703083055.95864-1-krzysztof.kozlowski@linaro.org>
 <668577378cd31_4fe7f29441@dwillia2-xfh.jf.intel.com.notmuch>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <668577378cd31_4fe7f29441@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 03/07/2024 18:07, Dan Williams wrote:
> Krzysztof Kozlowski wrote:
>> Use 'return_ptr' helper for returning a pointer without cleanup for
>> shorter code.
> 
> No, thank you. For CXL, I am not a fan of macros with hidden 'return'
> statements.

Sure, maybe the macro is not helpful in the first place.

Best regards,
Krzysztof

