Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2194033A6EB
	for <linux-cxl@vger.kernel.org>; Wed, 17 Jun 2026 17:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781716678; cv=none; b=X1h0tkCMmC+rOwp45kgotXk/DsnjGPRsLi2W6Cx0sq7X1pbfM7V/h1mM4Z/JSszxuTa5cvXyFvUhO365UXeWSqn6cbgLxerVcDamkyFqdYJDpE95ycIDEfJslL6FDKVCsJLrlOx71+jnv/andl4KtKYgY2GMq2aOgQFpVYGZ4vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781716678; c=relaxed/simple;
	bh=V3CcxOLia9CY0H8zjb+ZTGSXWDv/g65LFKetUF1X0Sg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Be3m7z+z6gM4OoULgHa/IQKr3hYoROC2fJvvD72mRT0xuQvlhCyLfhBEw6FSodzKR0i43dhu3u9qBe8uH66Lhu1BU5OaJU8t94ajJ3extwox+IC5oEEZjMu7WOUCjyq97X6HaUuV9xH1d8djkd+m1w/xLbUiFL9ovWaC8IrOcGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fQrtBGsN; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fQrtBGsN"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-490a76757e5so43818925e9.2
        for <linux-cxl@vger.kernel.org>; Wed, 17 Jun 2026 10:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781716673; x=1782321473; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=DHkZUMk1sAqmgYkyu6MiPiSjqHXH7Sbq1n0RCyPRFfc=;
        b=fQrtBGsNkl8jfhmhK2liKOfbaXsrqWGRmKfHP/5/oXW0UD7hJ3oahOR7qLAeo0OpBe
         2e6X/h8jQJOlMdK45XemxG1KXwmVmdOdKR/3HW11AMVUuy2FDKhx6t1kO60FJocpgZDF
         evkBG3W7V5BZARoJSX0atoEmHPrefGTeO35FOicNCIG5aM9OA1ql0InW0OLMoRJ8YDk5
         F4FnkE0SVPSi73SuQwgeOTPBhIBLWh4kel/JQ82o5Kh0CRc9f/rmAmRv1x7q+mcCAL7K
         8/0Be+VLTgQ+SA5VSHT4hBla88HOCJYiOJO6Jm6SRXG3FLP9Do007JkkLXKlE+Yr5EpJ
         mzuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781716673; x=1782321473;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DHkZUMk1sAqmgYkyu6MiPiSjqHXH7Sbq1n0RCyPRFfc=;
        b=g3qsmD380DJ0uobYSELi1VC2trfyIqebBuTlFq3ajf8ellHp1/dSdFNHzu+HUzu/Zi
         h+NmJwyK1Le/mX87qGYW4WDRbjrw05U6hrfA1U0QXBCk20IogeLJO9hd5sHW03ieosRZ
         EzVwUgWkXq71ZX3vLvAGYyzlvSbCQbUYjoU5q+/sL0kTwG7DSO3Nr1QpF9ZYyMUPfWv4
         i8xczuMbT6kNtEC5swVYKu9jOTZMSg99vHf//Ub72jCEBZnGbGLpCBczfX2FSPRQ5mjV
         x4wreWWI7ynNV7x6dywHQ/pGKMaOM5Q3/6luJn4Ab1mE8tujMzSa9R6cU7Ng2WflvoRW
         9vOg==
X-Forwarded-Encrypted: i=1; AFNElJ/2Ey7FLS18RDZe0VW9eJ1yZH6irxT5/mkoicreouZ8VlX020eLRfiYXb3oIlCVHgBFe1WvDtyhgB4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/gi2M+jV8jqu6BOtlpyUKaHnbatcz43wItTsXFHwEXtrfSDZ9
	Aup7axZkHNoMkuxNDhoTSfIY4OHvrLbag7wcQs74eUkOhoK5IoWJqofU
X-Gm-Gg: Acq92OF9LeoVvlYWHcTLAwnHwgkFMIR4J1kg/fEZnsGbAWpp2gFm3p8D9dYj02aYwQp
	tGhcHAtxCrn4WwusL/1JFJbLoTvUng3UlB6ZO5Ut05i/9XXnbMjVOCWvN3kKXC6FdfaO+wCMd0q
	O7ETIHNyxkhN4ZRQ2Q0e7bSD5yFs1sORmUET2yk/09OqJQfjUWo+aGIVLAr5Vjw9/paezLSyIIc
	0O8F+A/Q0cJEQ1D9viXyJv7n8rbtO6T4nEtGzxzJ0MGoleK8buh2mobewQFJPCae3s1Ik9ikA0s
	eiiK52iU8nIkPx079V2jpaqNTMASi04anVvIegsya8qjKiM5fy+HqN/3x2Lxr2NLwwVBJ40YrPK
	KAr7qatBpWPwMqlHBldkv4NR2Ms7YpKODVjLyg1mA8v64Q6C1yI/fRTMFOfiU3J7bAPGbXKkD8x
	FWA0GKLTycW/V6Duy5cDOpb3uAzPWZqC8SfTij8+fxk7UGSNIIUrV9G0ieCkmndiY/QHP7cm+pm
	RQj9Z0=
X-Received: by 2002:a05:600c:1394:b0:490:b8e6:be40 with SMTP id 5b1f17b1804b1-4923821bef1mr5753465e9.21.1781716672843;
        Wed, 17 Jun 2026 10:17:52 -0700 (PDT)
Received: from [10.128.11.42] (195-23-151-163.net.novis.pt. [195.23.151.163])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f2dbfb1sm58928836f8f.35.2026.06.17.10.17.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2026 10:17:52 -0700 (PDT)
Sender: Julian Braha <julian.braha@gmail.com>
Message-ID: <58f7163f-2fce-41e9-bc35-d1d8e6f4a298@gmail.com>
Date: Wed, 17 Jun 2026 18:17:50 +0100
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 07/10] ACPI: APEI: introduce GHES helper
To: Ahmed Tiba <ahmed.tiba@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
 Hanjun Guo <guohanjun@huawei.com>, Mauro Carvalho Chehab
 <mchehab@kernel.org>, Shuai Xue <xueshuai@linux.alibaba.com>,
 Len Brown <lenb@kernel.org>, Saket Dumbre <saket.dumbre@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
 Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <djbw@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 acpica-devel@lists.linux.dev, linux-cxl@vger.kernel.org,
 devicetree@vger.kernel.org, linux-edac@vger.kernel.org,
 linux-doc@vger.kernel.org, Dmitry.Lamerov@arm.com
References: <20260617-topics-ahmtib01-ras_ffh_arm_internal_review-v6-0-91f725174aa0@arm.com>
 <20260617-topics-ahmtib01-ras_ffh_arm_internal_review-v6-7-91f725174aa0@arm.com>
Content-Language: en-US
From: Julian Braha <julianbraha@gmail.com>
In-Reply-To: <20260617-topics-ahmtib01-ras_ffh_arm_internal_review-v6-7-91f725174aa0@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Ahmed,

On 6/17/26 14:54, Ahmed Tiba wrote:

> +config GHES_CPER_HELPERS
> +	bool
> +	select UEFI_CPER

This config option should probably also depend on ACPI (could just move
it into the if ACPI..endif block), or at least have a comment that
selector options ensure ACPI is enabled.

- Julian Braha
