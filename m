Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701283655EA
	for <linux-cxl@vger.kernel.org>; Tue, 23 Jun 2026 18:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782241099; cv=none; b=F58MaMmTaRr3ygeQ0d+alDYXxSUD5RPPqCOkt/wHrl6U8dms41SrozWZWaBfxJRr73RygIhgNokfmEb3tnaK7mUhx9e+6ueAv9b0Ww2bVYSznKJSmcob4bufhJeQNHfNEiA6HL9fm+72eFdUsPLP9GIryqP6Z7GY2VLdpZ3ICnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782241099; c=relaxed/simple;
	bh=6sizoAgwRLvjCh7zqg/EnqZzQNrUHjNmth2MBnONupo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kb4ygNUdsSFwMuqpe5pQp8n47xqxG/M+Gk0TYNYSL34wpX9D/wgwcQFg0wR1lT4uRB53kECrKt6ehOrncdllLd2YUvhg4FKg30hDUYCEZAI/wKuGlWUTse+mQEvhX9P8d8/ixnvdSE9lkYx2v7kUErK6x2741RWpBpMm7a71jo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OBFa+vr7; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OBFa+vr7"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-462bb734793so155838f8f.1
        for <linux-cxl@vger.kernel.org>; Tue, 23 Jun 2026 11:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782241097; x=1782845897; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=2fiFg69bZvG7eLHGu12BMJgm2iLA1vS/lgB2cc2WLrE=;
        b=OBFa+vr7LV6XYWQs/BbCkXg61dyzgwY+FE7mroZoDqF9yRQ/XL27w7KC1MfwLmwr4p
         Ea9zjNSSrVTbiC4BL72Chf/hrlMUcFYZ33j0+aaDmHkymxJiCZm/529O2rnuB/4/WRAh
         JapYutkIavZBvhIARtAvlr4rWPltl1dAdMEEJ7ClA6U9/iP2fLxf6GnUXpUxO8+VoeDt
         o4IyThWskguQKptwuwQKDRsK4e4l23oEv826UyCykbq4Vu0/nOQRpwPfXVYyJNNEWinU
         1kqelNVu2gVPWUBRjHpvEF37rCi7wQ9UB8dy4c9KllrZGo8XbmLq7zcIW5WAbt5zfGcV
         4bjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782241097; x=1782845897;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2fiFg69bZvG7eLHGu12BMJgm2iLA1vS/lgB2cc2WLrE=;
        b=N9bkfSxFbBYHKzkOH9BmE6ISdfbuS4nb8c7Z3OJIZztb/9QVDkFNpMe5GIlb58cooO
         NlhyxkuLkOwzN6MGnid3smDlqB9FkLiDv7oVqChOCAJHaW2kk68R66g0FuYQdJkw/yjE
         oHuy6GlEhhJibDjjjv7MkZdVC7Jy0IlQgXQr4y39MTnYKjvmJwCA1oFzo8qMT+xT5G1k
         WqH7RzV3F6H1+lFJSERZQFQpTU4pWPvVu/yXGTmjYjHrSFSlLaHCwY1SnhXGyQX2oxeh
         C6fE42EPa8cywIVjwAF+dqSWudLDlGV16+b+3v6wepW0ZFThKsvYyXrKCFKVZdSPktH6
         MgPg==
X-Forwarded-Encrypted: i=1; AHgh+Rp231/YkhvpNZFe3yBjNih/i4HHCidMdBmot3oO1euYF3ikl26fkC65EjZ4jMsJAksufCgogfvlYLI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2VVN/VUhyADqKjmtFXBQq0CXqtMc83BZGrkuj07ichQdMxjy1
	CVc3IAsZAod2YoBgSZKYSk+6QPzuU7cXUtsR1wbCChvwlUwUfxU4c8j/
X-Gm-Gg: AfdE7cm5CqlPvgAZRCAmJwXQ0oOOlB/fSWOMRPWqYAb6ZD/dRJ/+A3x5t54I17lp/eX
	AsCx017ChC4Q+r8wJ9hDsRyGlrpga7NeP/EfLEbryCtmJasoNRPgCot9iocBf7p6xia3/+cFiBX
	6gxGciovuVcQ1pZBEc/1NJJXc37z0JFKQoVJQVnlVPscYd/ZQQwCNZZG+vfXgb6aJE4KA1nY7Tn
	J+A8uUgVDvpN59jdH2XgrgujYqyUBVyrJio+JlI23Oj66fAkHUgJ08kKqfyp6PJsx7K7NFTwnYe
	qSzmCk2BYXhXMB0VcuYi9Xz1/rBwD5Sc68uz8j8VnxbRxgjk0RF1gyxZ+I0edlMiMjq0LkTTlPe
	Mdz42NLbWYHwuiFVRnzgYLwoH6F+aJUiMnGT1eBfLeQFQe93cZ/I1X9opxIJOxHXNtbNWWUWIIW
	zaWnfA1Kv+Mmk2Mj3NaeCGMZOD50zzWSetjYnKykD/gDtTPE7CTb3ok8BgQhSgzNuSR61CVIroA
	v/asMj6
X-Received: by 2002:a5d:5f91:0:b0:462:1a7a:9846 with SMTP id ffacd0b85a97d-4666074429emr23730834f8f.8.1782241096893;
        Tue, 23 Jun 2026 11:58:16 -0700 (PDT)
Received: from [10.128.11.131] (195-23-151-163.net.novis.pt. [195.23.151.163])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46666c57ba0sm38525006f8f.32.2026.06.23.11.58.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2026 11:58:15 -0700 (PDT)
Sender: Julian Braha <julian.braha@gmail.com>
Message-ID: <e48a5c7f-2d9d-4202-be59-2e84120dfe11@gmail.com>
Date: Tue, 23 Jun 2026 19:58:14 +0100
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/21] lib: rspdm: Initial commit of Rust SPDM
To: alistair23@gmail.com, akpm@linux-foundation.org,
 rust-for-linux@vger.kernel.org, linux-pci@vger.kernel.org, jic23@kernel.org,
 bhelgaas@google.com, lukas@wunner.de, alistair@alistair23.me,
 linux-cxl@vger.kernel.org, djbw@kernel.org, linux-kernel@vger.kernel.org,
 Jonathan.Cameron@huawei.com
Cc: boqun.feng@gmail.com, benno.lossin@proton.me, a.hindborg@kernel.org,
 bjorn3_gh@protonmail.com, gary@garyguo.net, wilfred.mallawa@wdc.com,
 aliceryhl@google.com, ojeda@kernel.org, alex.gaynor@gmail.com,
 tmgross@umich.edu
References: <20260623045406.2589547-1-alistair.francis@wdc.com>
 <20260623045406.2589547-10-alistair.francis@wdc.com>
Content-Language: en-US
From: Julian Braha <julianbraha@gmail.com>
In-Reply-To: <20260623045406.2589547-10-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Alistair,

On 6/23/26 05:53, alistair23@gmail.com wrote:

> +config RSPDM
> +	bool "Rust SPDM"
> +	depends on RUST
> +	select CRYPTO
> +	select X509_CERTIFICATE_PARSER
> +	help
> +	  The Rust implementation of the Security Protocol and Data Model (SPDM)
> +	  allows for device authentication, measurement, key exchange and
> +	  encrypted sessions.
> +
> +	  Crypto algorithms negotiated with SPDM are limited to those enabled
> +	  in .config.  Users of SPDM therefore need to also select
> +	  any algorithms they deem mandatory.
This patch introduces an unmet dependency bug when the user enables
RSPDM without enabling ASYMMETRIC_PUBLIC_KEY_SUBTYPE:

WARNING: unmet direct dependencies detected for X509_CERTIFICATE_PARSER
  Depends on [n]: CRYPTO [=y] && ASYMMETRIC_KEY_TYPE [=n] &&
ASYMMETRIC_PUBLIC_KEY_SUBTYPE [=n]
  Selected by [y]:
  - RSPDM [=y] && RUST [=y]

- Julian Braha
