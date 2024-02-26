Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E40127B4B
	for <linux-cxl@vger.kernel.org>; Mon, 26 Feb 2024 14:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708956753; cv=none; b=ft4qMyWCqBjNGbErcrsl27OhxZv6eMOcy/PprgBiDvNUqSfZo2xEUqwTlR5jVBhdK4HEGkh/IguYW4ejSQTbaVNdTDfkJjZL76/hcg3qiL/RjSu6L86f84P86XGhTJKM/0XUJ/hZotBekxSQ4vAAAfI+Aa08R9GPSC6ImR3gqe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708956753; c=relaxed/simple;
	bh=gjCci5g3m1cdPDY+ARHKmFFSrEMmQtPvDpFEpLERfQE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r9uNZFxyDPKBkqPT0+zCvYuw56fteh1pWmYrNue9tEhiAGPlZppNaHIERW/Fre+H+PdxPIwSXuiLp5a8xS5XPBsFlkZ9MnxRK4Qsu37wP6WwUCuiWYpYwzUQ9wPYvYvRPNrELZCriQdwIXvA9/dcvbu24ui2vp81yO33lFTSgwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SGrcCgZq; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SGrcCgZq"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-563f675be29so3224500a12.0
        for <linux-cxl@vger.kernel.org>; Mon, 26 Feb 2024 06:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708956750; x=1709561550; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gjCci5g3m1cdPDY+ARHKmFFSrEMmQtPvDpFEpLERfQE=;
        b=SGrcCgZqjqtOnKIi5mOsBIQopBnhL6t/VD2YhCt3Rql4GZdsDXFA2K05QL3yw/XaX5
         57SGSyyFl4N85DDcpKHwyVpTOxiXSdyUQhyamfDl5TU8oCPI2kq8S1wtXbBO4oWJgL+N
         l/wDMhA3e7qtJ3/38hCBM5xpK2ZhuvuEHXBCg30p3qVtaSQrAqsoLyHZNqPhgL5EA1Ge
         Z4hI8E3G9eTxI31bwjdybKNnsW5gtQ0Pm3mCv/1os6Cq1ATI9YO6lYf2aI8/Hr7eAfxD
         YVHMuehdhDx8FyhtgOyfvqwFkeQvb5f1rRJX43G/lmt9hRM1RIVVbsnRR/at/oCg4ILH
         E3ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708956750; x=1709561550;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gjCci5g3m1cdPDY+ARHKmFFSrEMmQtPvDpFEpLERfQE=;
        b=BSI4oCpMgfMjQ8E7VkeHHV8gYxmN+CwdDMwtUYHqNkKRg4Ibkxw7yZpVcBHgtQQTUV
         auoNKAfv5DfB1xwVDpKq7X93pa16ayf8gfOm/X6BFQDMyO09YqD/dQgxBh4gzjNSR/iU
         r2pelwLh22dGJvRwb3NYlGfxR27XagNpVm5rTA4poj/5yxt/DL5iG7Q9umpps+kwrykf
         KkgsuPJV7aMYx4JJq1T+VcR7ggE8UCdSbO2/bntzgPm7QBPFB+rM19Cd8aex0RFXxEdI
         hYKNHdzxGSqS+iFguzZaHWxtFIDgns26HTJZI8rsVcSloYvH2YwXVlrqr+5WrJm56aUW
         Q6MA==
X-Forwarded-Encrypted: i=1; AJvYcCUuiJcU1CkH2IEMzN4beVLamd+W6KbYY3HAz4++dOiM14dHZgLvqqoUnh1hxyAhK5r0AFaT8QtDhEXscQgJcpvY9sIawhIlvQRa
X-Gm-Message-State: AOJu0YzCDNLeJ5tIdBQgPaqcDS/bb0vFk1N0hkVfr1lRM5dtbvYDV3ci
	6UkbLB3KjW4OPp7gcfaoZ0jHzYeGB4Z9m4mvVErf+DYyTGPsR+zbqnIt6MOCRwxwC76OsLD1BSq
	Pmn/6oU76OuH0KLIi5DxJ0/rgZyg3j1s8JtdPug==
X-Google-Smtp-Source: AGHT+IGughasO44d2xK82G4ryMlpdtXPRJMNaeLmZri/kuytdaeETHB8NhO9xCLNvnfEw/fQt6EGab9gQuF+oVff6wo=
X-Received: by 2002:aa7:c3c8:0:b0:565:f90c:1263 with SMTP id
 l8-20020aa7c3c8000000b00565f90c1263mr1549811edr.9.1708956750102; Mon, 26 Feb
 2024 06:12:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240223180102.7657-1-Jonathan.Cameron@huawei.com>
In-Reply-To: <20240223180102.7657-1-Jonathan.Cameron@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 26 Feb 2024 14:12:18 +0000
Message-ID: <CAFEAcA9X9Mvz4CL2-yFJN4a04eoODn6Yr_VcD-O6P-PJ1ioSKw@mail.gmail.com>
Subject: Re: [PATCH v3] arm/ptw: Handle atomic updates of page tables entries
 in MMIO during PTW.
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: qemu-devel@nongnu.org, Gregory Price <gregory.price@memverge.com>, 
	=?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
	richard.henderson@linaro.org, linux-cxl@vger.kernel.org, linuxarm@huawei.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 23 Feb 2024 at 18:01, Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> Seen testing of CXL emulation on arm64 (currently out of tree).
>
> CXL interleave occurs at subpage granularity so is emulated using an IO
> Memory Region. The memory is general purpose and as such may contain page
> tables. FEAT_HADFS using atomic accesses from the page table walkers to
> update accessed and dirty bits.
>
> Note that disabling kernel support this ARM 8.1 feature avoids this issue
> as the PTW no longer does an atomic update of the page table entries, but
> that is a nasty workaround beyond its use in root causing this issue.
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---



Applied to target-arm.next, thanks.

-- PMM
