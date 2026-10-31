Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.248.84.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793479840;
	b=zQYrkeB+TIDh1lyCzYwjgp9IWGrU747aVTKziyI8c6xekxRjrFyexxI2XkwiSsXfo+h3
	 R0cEgRCaC//wtep200TdF5yV3U045ky3MrB3GI36BOFuMrEZsftZcszcrT8iN7jWVqMYf
	 sqyUivWWDLEcmPOycQfirQbPrz2/ON3tlNu95i/jAvRCZ9RQBvVki+kaubxNeT2i25Ie+
	 B2W9Kvw8lfsetdlJhimTUpIQUIEb84eZfFZTp9R3bNEQzh83Nsk674wjaY2JnfHXlkzWa
	 IzZl4S/fBAD6YFtoEigpFvPDK1oB21cPTQweuy2NoXdx9AvYBHSmhv2EjaBnqMjVgjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793479840;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=p4jrLfpxBlMGSQmHzoUVmPQbmzlY0z0Yqtc1/x/Xf3w=;
	b=DggEzg/OTv2Dp45+Jv1TKXnNpJCTic699h6qMZLPj/MDvkHfWo/tQnk5Xl/EKQ/1VWsJ
	 bGbjZVUuAfo/qErYLqfqhwssb82VpsrW9WHnMwVG4+v08M+lDr/J/8y9mS4O4afj7+27T
	 mS2ShyCpu8VA6Qi8fmkplndd2+jSQPtM2AuhM7nOJh9bRPJvw10rKAWzj7NN1Pey5uiJ6
	 RMUcLF+MUVkCf4TPCCFjcuvUlf+8WF6MLGldoUsRu1Uv6f+YFvKRRx37B4KgzozlEfDka
	 aq9oBwTYbhOBS467pzO5AgsyUxUd5nYE577Cs6h8yff2YcwccrL/y0Jb+90/bCa7xxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=tls.msk.ru;
	spf=pass smtp.mailfrom=tls.msk.ru;
	dkim=pass header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=ktAYtiNY;
	arc=none smtp.remote-ip=212.248.84.144
Received: from isrv.corpit.ru (isrv.corpit.ru [212.248.84.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B42606A31A
	for <linux-cxl@vger.kernel.org>; Sat, 31 Oct 2026 20:50:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7B42606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tls.msk.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tls.msk.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=ktAYtiNY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
	t=1793479825; bh=aWvHt17uMo64E+aJMbxlk1LmvKPP0d19UsYBc1/GfMA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=ktAYtiNYV/RUfevjHrqXGpWzrPCGP7alTsMgq545IAxqZnZMSxmJl97j/2hXxKLE0
	 T4KNVdBANaCxOdpPurB+ANHwyjy5i3whCmafwAgZ7oz8CQbVq76UghGDIfRDYat+IL
	 QHZtQVFGZw+Ao/D8ttTH5noFhzDGQJ7XZnw+kGZShVMls9sG/4PhPyU8LymK6TnJ2j
	 q060JS2BYMiYMz16JREcGemcRyahfqdv8gEbxeK57mLcuZHjImFVtaF/7oezxiuoz/
	 E8ToiAoHLy5BWMqsaZN6EePDC+pG8i/Htu2n/0Z+TM7x9q8HBSsh8zgU5HF+DQghKP
	 KSv0aYQn3df3w==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
	by isrv.corpit.ru (Postfix) with ESMTP id 4B4331E2CF4;
	Sat, 31 Oct 2026 23:50:25 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
	by tsrv.corpit.ru (Postfix) with ESMTP id D8AE944FC7F;
	Sat, 31 Oct 2026 23:50:24 +0300 (MSK)
Message-ID: <0dccaee9-4294-4645-9432-e17142c7b0d9@tls.msk.ru>
Date: Sat, 31 Oct 2026 23:50:24 +0300
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/7] hw/cxl: fix Type-3 device reset resource leaks and
 convert to three-phase
To: Junjie Cao <junjie.cao@linux.dev>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, jic23@kernel.org,
 philmd@oss.qualcomm.com, linux-cxl@vger.kernel.org
References: <20260729144645.1552511-1-junjie.cao@intel.com>
 <379a2300-b1af-4b32-9d10-7a8347c22476@tls.msk.ru>
 <20261030124431.1066454-1-junjie.cao@linux.dev>
Content-Language: en-US, ru-RU
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20261030124431.1066454-1-junjie.cao@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/30/26 15:44, Junjie Cao wrote:
> Hi Michael,
> 
> On 30/10/26 14:35, Michael Tokarev wrote:
>> This patch series has been Cc'ed to qemu-stable@.  It is interesting how
>> it's been Cc'ed, and I think there's some error here.  From whole series,
>> only patch 2 (destroy primary CCI before re-initialization on reset) is
>> tagged for-stable.  Patch 1, which is a fix, is not tagged, and not Cc'ed
>> to qemu-stable@ either.  The rest - patches 3-7 - has been Cc'ed to the
>> qemu-stable mailing list, but are not tagged for-stable.
> 
> Thanks for pointing this out. Only patches 1 and 2 were intended
> for stable; I copied qemu-stable@ on the whole series. I'll keep
> the stable Cc limited to the relevant patches in future.
> 
> Patch 1 carries the tag both on the list and in 259b877eac, and you
> already have it as 4a39c7d61e in 11.1.2.  So for 11.1.x patch 2 is
> indeed the only one left.
> 
>>  From this list, I'm only picking up patch 2, and only for 11.1.x series.
>> The other active stable series, 10.0.x, - apparently it's not needed there.
> 
> Neither applies to 10.0 as-is since cxl_destroy_cci() only exists from
> 10.1, but the leak is there too: ct3d_reset() re-runs cxl_init_cci() on
> all three CCIs, allocating a new timer each time.  I've just sent a
> 10.0 version, "[PATCH stable-10.0] hw/cxl: free the CCI background
> timer on Type-3 reset and exit".
Thank you very much for the explanation and for writing the fix for
10.0.x.  I thought the prob actually doesn't exist there ;)

/mjt
