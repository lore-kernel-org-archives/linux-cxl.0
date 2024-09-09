Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701981B372E
	for <linux-cxl@vger.kernel.org>; Mon,  9 Sep 2024 10:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725876323; cv=none; b=iUkaSmabbZia5n5TSIfyYntb/2pj8rU40jaWEj8Z7rCo9SnpM1CReLkOmTuzsu0t3wWiWiiitfHtK0LErRMeuWBN4RFFw2XykMR+mq7hNWCKRBkczrDDPaH+SDUagdbTUTWOeTNZ3Ii764c/Gjrg8Xr8Bkrr1w620LqgkOCJ54Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725876323; c=relaxed/simple;
	bh=fQRRV9XHkx3tMNN8719ykfM0W/FhqpXbLztozDp3MKA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NwFUowM2JJkUgdJ1Kru9WZWjnOzNRwAY99JYRKdoQM0wzB8Sifm+m/S0/BL9yge7ZqdTloyTEgTrmAjVxrMbqgUkXE1wXhFOdC6iir0phAhOZuIlBiqNLbeX53Fj8buVPzwgk0csW9/CxReKlY9u+ah6GsqM+h+NUFgLJuFG4/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DQZN7eU3; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DQZN7eU3"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a8d60e23b33so69860466b.0
        for <linux-cxl@vger.kernel.org>; Mon, 09 Sep 2024 03:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725876320; x=1726481120; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UDW7Y/FkHlm7foc3nBKUG2Quqbrny0XbGq22zLlogVQ=;
        b=DQZN7eU3hEcF9WMS4Pj85SVFMlZ/QeOL62tOsj1lQjCW9cDYhEJv4KdtXoKhjg53Ux
         SsQtDdBNwz48CeJ/Et3Sv9WvGugwqSY/Ie5YzG0KXkJwGJOI8rLbBDsSWpg6vjH53hiv
         aU1zuzbC4/3AejmXMgjtNGXIMPJx94CWTZZaXjrboGC6VVLdgGStHnbBy71qFhGM8lUp
         2b3Ha2fGL7F9fU/Etu80kDGcWcKl0oxbJbX3HtdwywevxVKRP8llBWJTRolmcWZvNJW6
         OiVRgEO7yZCZBGsVYG0lZZOpeeGnNLCIda6oNcOt6OqN9uQ4NmnpMblZJ9TzAV3ur633
         yQDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725876320; x=1726481120;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UDW7Y/FkHlm7foc3nBKUG2Quqbrny0XbGq22zLlogVQ=;
        b=FOXW3rk7uVNgl+eWvBSZR2AVOamxdoxOonTmorp2LcQkwwbu5+u/UM5RaJ4JaPkJCL
         D5n/zuFGynVV/cSJ+/ZY7EUqjeNySirR9NJnLeAfiXyq1v1sof/EqS9nWJYhP/gWzeFr
         xZXVL3bIfqmqWKJu97BIBr4eyLvA5oo/z0AJ0yVivfwE4cXn/n72KtoMx9JyMgmBpazT
         LtYY6hogfw2NjCFKc2g6VBRKtaQIn2Vm2rw41KpSB+T3NEurY8ehoqfMLtLsZF/MVlbI
         nlrCavHvema82vXsS0eKLi73CCLTTGwh0lkQqxsLaMX3UM2Asp5UKNGspvgBSSlrcPUm
         3pDg==
X-Forwarded-Encrypted: i=1; AJvYcCXWRUpheLTpP9AvD4EXxVE+DxRiiF5XrRg+aiMVk6YB0p7xI9qNqSZLKPGTmZVowdVdQ/J7o7EPP1Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyG2sthFPKGl8kJJYbDW88D1vjurDKfbLEsjW8qiG++OBd2MVFp
	0X6hnjnIkSQtYDY//+M119cZu5pyOJEdUsGjx4QeEh0G4+Hu3KD1zQ7bETiFdgk=
X-Google-Smtp-Source: AGHT+IE6lyWp5zqxevMPsQzugYFaDvJXsjA+BJH/vPHmgVDm/0MzkLQWUx6FwpKR8cMYtv9YXiHHPg==
X-Received: by 2002:a17:907:801:b0:a77:b4e3:4fca with SMTP id a640c23a62f3a-a8a885bfbe1mr1131892566b.9.1725876319229;
        Mon, 09 Sep 2024 03:05:19 -0700 (PDT)
Received: from [192.168.200.25] (83.11.24.101.ipv4.supernova.orange.pl. [83.11.24.101])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25c61258sm317749066b.116.2024.09.09.03.05.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Sep 2024 03:05:18 -0700 (PDT)
Message-ID: <e632758d-893f-4a44-b081-9fdd92c19548@linaro.org>
Date: Mon, 9 Sep 2024 12:05:17 +0200
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] hw/arm/sbsa-ref: Enable CXL Host Bridge by
 pxb-cxl
To: Yuquan Wang <wangyuquan1236@phytium.com.cn>, Jonathan.Cameron@Huawei.com,
 quic_llindhol@quicinc.com, peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, linux-cxl@vger.kernel.org, qemu-arm@nongnu.org,
 chenbaozi@phytium.com.cn, wangyinfeng@phytium.com.cn, shuyiqi@phytium.com.cn
References: <20240830041557.600607-1-wangyuquan1236@phytium.com.cn>
 <20240830041557.600607-2-wangyuquan1236@phytium.com.cn>
From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Content-Language: pl-PL, en-GB
Organization: Linaro
In-Reply-To: <20240830041557.600607-2-wangyuquan1236@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30.08.2024 06:15, Yuquan Wang wrote:
> The memory layout places 1M space for 16 host bridge register regions
> in the sbsa-ref memmap. In addition, this creates a default pxb-cxl
> (bus_nr=0xfe) bridge with one cxl-rp on sbsa-ref.

With this patchset applied I no longer can add pcie devices to sbsa-ref.

-device nvme,serial=deadbeef,bus=root_port_for_nvme1,drive=hdd
-drive file=disks/full-debian.hddimg,format=raw,id=hdd,if=none

Normally this adds NVME as pcie device but now it probably ends on 
pxb-cxl bus instead.

Also please bump platform_version.minor and document adding CXL in 
docs/system/arm/sbsa.rst file.
