Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793216708;
	b=H1zA6XMeKl4yyuPO/SbBT4zxxzkKZzzkdYJoEYfjV/oqUT8gg/FQWlDufHKUgAcc30YL
	 BJQ7kXFVCuvm8NG0dcTyGf0haOvYgWzXA2FL2bWfgWuX4XUSurQ0wqWt6nScHSyqkDGq/
	 HH28fxBaQIf6LjWq1NNDM0VCl7/nkNfJNWVPmfe3rzbhkjaRkCz6/gYUFsB4H61wVkqG+
	 r+oHYZeOG4eWFsFBaf9YEibfIhfj00aUy4Jny7enPThE4QGW3c/622QDH0LMgGU+m3thl
	 Ihu5yexr85Pi7ARecJPriDmdkPePzNgefTBdhyNtzZpQSHv/Kp5aEy7Hb+Xn6q2/OpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793216708;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=uHazdlEqe5IFRWvz2i4I2Ak+hY9HZ6HGVO6thNU7tPI=;
	b=08u9imZejAaBQcHCjY21sjhXL7pc4HJo1dcYFaema/VGIJenLC3kHZ6+LsugwGaswUyn
	 hDnCgpmvne4lMgjHBJSSRxpKDpBEUHrAB+2fnZwEHnrtRmds+XyNIbytJikyrnSkuirr2
	 /DSaWpMggegm5cefCpbeAZaoiT39PHa/CodFYlfvZaxUx8K6kAdELRrMsa2MzpjpVjqDV
	 S0HE/P195RmE2Ht6O7JsO+mpY8tctgdYIS0zsh8XO35OIduqd9uJ9YtFvbJod3XrSrXvA
	 sn3usOImrCj9MTKd5tjb9Q2YVlmdqXtoIJ5QXo5zI2pFIcbFa737PUl5XroEUnokjZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=F1rWIbMg;
	arc=none smtp.remote-ip=209.85.218.43
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8F3606A321
	for <linux-cxl@vger.kernel.org>; Wed, 28 Oct 2026 19:45:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C8F3606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=F1rWIbMg
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c414e5d282eso183412566b.1
        for <linux-cxl@vger.kernel.org>; Wed, 28 Oct 2026 12:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1793216706; x=1793821506; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=uHazdlEqe5IFRWvz2i4I2Ak+hY9HZ6HGVO6thNU7tPI=;
        b=F1rWIbMgoSRFHqMXkEr+ww2nM0R/0wMoyIeBRUWYbiC951h/zJZGTuG1hMT+f4TaBs
         a3e95lqjkoVC/h3mlHcXrskhj1gbStc6+ePPkss+QTK5xs/eyyEKxO0QNErPwX0pFcq/
         fBBykrB9L6rh48zp5r/F7SmZXi503fdLo40Vp9U8cWxExT2qnqjSjRZ2OssWYokniS1T
         gRnXfoIfNCa8CbBww7aSnnc+WH5Z5qdUqA0mh4H7I+MTrNQc7KG41H8zmaNFFCyAasJk
         Dg4U9z4TjpjVDCOFJb0/5GnhbtB4FVziobCWAP9I9F/IaCoO62OJuf6vuRAgZR4obZuN
         oopw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793216706; x=1793821506;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uHazdlEqe5IFRWvz2i4I2Ak+hY9HZ6HGVO6thNU7tPI=;
        b=Llfv/6w3+wFSLnp577CWettdYT0H8/U+dklnS6H5k2pNjDS1XsGCRu4g19c34+zxxE
         QHnfD4kr6KzhEwwQMDGIdbIITeCLdY88Bj+Qjqvqi/1ocnNQDl60vmfXQn1KLVU8WE4x
         FeG6ec+/f2LUstKdfDmev7kozcpdFDvyqEj8wfMb7DhStl3w+CV86x39ve8qUemW2Tg4
         8zVcJydZtkU8Qut8UA4lQOX+6exg48ejGEO4adYwXJMPDsBlUjn+uWS5V64j2bpMyWkP
         Ym2Mfd6a8SZFV8WUlri2DCViuLeJj8yVqI/lcU67LTaRaG7XGts02RC4r87Z/mBVtKCN
         wMpw==
X-Forwarded-Encrypted: i=1; AKwUvBwRQtMb1mU56M+rhycHoyCWSvGkRWcs4Er5BMyIDhvI0PQPLuTjlEGkRJmyuzxVgD3OV8NY9Xwc+6M=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ6yGfDGKoowUKzqu8zp7l6NVvzmLKaUUhFy4ppU20W86o+2iVq
	9RfUy1kO6szHln8us3n+mrN3b/DmVAL+YOC/cvq6pMFALVKyEWGF+C07e6hZEvx15V7QkdYw5B/
	SZF6Vk7c=
X-Gm-Gg: AYBFou33vcB0yTX+ra9KiT83GogB5E3sZ2mDXcpeIZa8Bf8OQ7QNA3uqheyEt4EbHLN
	2D6G393S/v/qUfRKKsQPcSCk8Lhtc7exT3NXlXwNhdV386iULihhRTIK4hUrqAnI3TylR+tx0Un
	fZnQfiaZ3l320tmi1H34PsQmVWp/3DQvy9znidnYRG9ZTl3/OUNfe4NSbWtdWRcvfBoMGEyk5Fp
	roTcBSTmn/Zi12i1bEqNlH403sjtYaQulUTjSUahg45EdN30xDEYIcHmOvZ/n0YG9yoV3vpoT1q
	Y3ZzkNIpNWvxdO5Wvxm1cTNDLD8VSM/vLRqRLkTdqerZDtGz5mFYB0BW0GVbiaKJ7Q3ccfderD3
	IpblXN4Zez+esGVM4GR+QXyxdKK07bQCLvxibYVwvgPzNvntSCkJpWJFZGuL6sBVkKKJmkK9aEY
	ku/cj57OogvnzR8jv1g0CaPD3WWon4uyMPkNM7BfPabXxppXs3d1/eb5FAH2zdGlwLp+mODhguA
	8K2dKxxTGuXdGhTALTF89R2LufOyKjgAt8fTmgwsDA1qjY4DISbzZjLy1c4rb2kqGgjq4rO+UAB
	AkMNv9sLj8iolZtqB9hPJA==
X-Received: by 2002:a17:907:2dab:b0:c48:ddac:7eb1 with SMTP id a640c23a62f3a-c49be042430mr290009866b.45.1793216705514;
        Wed, 28 Oct 2026 12:45:05 -0700 (PDT)
Received: from localhost ([2a03:2880:32ff:4c::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c46bd66bd3asm646335266b.56.2026.10.28.12.45.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 12:45:05 -0700 (PDT)
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [ndctl PATCH 4/4] test/daxctl-create.sh: count memory blocks
 across dax mappings
From: Gregory Price <gourry@gourry.net>
To: Alison Schofield <alison.schofield@intel.com>
Cc: nvdimm@lists.linux.dev, Gregory Price <gourry@gourry.net>, 
 linux-cxl@vger.kernel.org
In-Reply-To: <55162d83dfab6101fca10df09b6baacac1834b17.1792695259.git.alison.schofield@intel.com>
References: <cover.1792695259.git.alison.schofield@intel.com>
 <55162d83dfab6101fca10df09b6baacac1834b17.1792695259.git.alison.schofield@intel.com>
Date: Wed, 28 Oct 2026 12:45:03 -0700
Message-Id: <179321670319.1001257.10248433152118734594.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-10-22 12:56 -0700, Alison Schofield wrote:
> Existing tests use single-range devices and cannot detect incorrect memory
> block accounting across discontiguous mappings. A two-range device exposed
> this bug by reporting only one of its two blocks.
> 
> Create a device with two separated mappings and verify its memory block
> count against the expected count from both mappings.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>

I think this misses an over-count scenario:

   A=dax0.1   create 512M
   B=dax0.2   create 512M
              destroy A
   C=dax0.1   create 1G  -> hole before B + space after B

140...15ff...  dax0.1
160...17ff...  dax0.2
180...19ff...  dax0.1

Not sure if you want to extend the test to add that or not, or if it's
out of scope.  But the test as-written otherwise seems ok.

Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>

-- 
Gregory Price (Meta) <gourry@gourry.net>
