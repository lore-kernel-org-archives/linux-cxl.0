Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793202504;
	b=RWhXygsIf3NUJLPYW0JpvzsvarO3VNeEj62P/UAlaWatrNYT2+bHdYJP10AgJ29Nafz/
	 I4odw/lEGs4GxcfwQ4+raqOxEiCZ5kJcWd3FXgVl5oRP4QZAf3dTAwFtu3ZmIhDNsReeL
	 wT93+HkNVP4nFADNupXBSCQMTjIvRWmrSbZYya4nUZLivjNwnqCsxY4cbGpLTpk++i7zs
	 RAW0p5j6PPoif6xuMWsFDGcYCaW6b2HTCsxffruICXiDkpWjGBUyZSTXQcvZNv9InQA99
	 xmhxaO1fOGNgPc8Rb+PXvsLtjqtSURrm0TLzq2zVtJldqXlenIro4ngnX/g4TZhvXVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793202504;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=195IjFRuPfqTqT/b0yTQoHpHUjVdw6NRNCX9zfuEHAk=;
	b=cSnsV9M73k5wryDvuhFxV1EIDe2mfzH8hXVZhGJh/q0kl0SDxVtPEi/2ztwCWV4Y1slh
	 gUuEtRg28PaPwEa2zEqYXTRGNJEaveyU/DWZ25pCuNjE8MccUjvS2eDkyE7Zg4x1dIcmS
	 ncYY0Cms7BQuAu3PdsFwV/bchQb8CISolqWLfRcFAuNo6AnNdx2cVFqJ2Za3ht0IjX/KA
	 GZmrQ9GpaHLzFc5D9nuS2Q442xPQPX6qsMgOobEud1Q63gfn+J6fn9alh46WX71JhyGLd
	 MOLxUcmEcXvlvrUXbHIaMCOG5P8XayodnqRfJ5JaxddTgeBdpANOa7Kz3yQRQz+LMLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=tllR2ugJ;
	arc=none smtp.remote-ip=209.85.208.43
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781B0606A321
	for <linux-cxl@vger.kernel.org>; Wed, 28 Oct 2026 15:48:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 781B0606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=tllR2ugJ
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6b1d8944cb0so2032415a12.3
        for <linux-cxl@vger.kernel.org>; Wed, 28 Oct 2026 08:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1793202502; x=1793807302; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=195IjFRuPfqTqT/b0yTQoHpHUjVdw6NRNCX9zfuEHAk=;
        b=tllR2ugJ7/IaiXflShSREUGMy0PqSQrcWaUuCzyKZsVWCS7X90wW7h5NrUeOElOgvJ
         G60ogrdEONUug2MPINX0AND71Y8hVjolgp57gmAH1m+PFP9Zk5wEFC06nSzwU1cofEXK
         KnyIjsOXEUPxcUdhYFju4B2y7eLoW85yt9in1CIWnxDw3jN6g3OrlI+roU9LLGyqaEgU
         kOMG/LPuweEz0ZrIni4C7QAMDq8YP9xoGq2ndC8IR836Yo8hs9xiZRlxVtA4+mtU4in4
         icstucwr4XuQYXDnLGqqzDILLBT6hAegOmshvuCPOZXHMGXcISy1KbzDzJe28se5HYG9
         8aNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793202502; x=1793807302;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=195IjFRuPfqTqT/b0yTQoHpHUjVdw6NRNCX9zfuEHAk=;
        b=vyQiK5zQwefxscGUDO3Fs1iDJiig3hxx9KjH/MoZMtM48PXO9T1DGofGCgM8lSajgS
         NuH1iUkQOaWDUDPanQzrWTNstnMKf3yXYi2UIB/fQcXQk6vc1XVQY+eXaDyVe3ahRqgD
         t+e6TBGIvlwZFbnLiakaMUzgsFT3OBqtJ9uJpd4G5f9oSuj7EtfKH4QKhslHxxXn7Nbj
         DUdmwR2wtl7WvyEckHL/vRIAZpOabZa7AnCTrevLlhxlcUOtNp6f9GLTfJutf5gg/SfB
         4nGA7X8ecJfX2ECJEiRIdtRFW3xqTZrjUCuHJGBrRIL/taLm89Qq5mGtl3w2mXXC9y4b
         KqdQ==
X-Forwarded-Encrypted: i=1; AKwUvBwm0UvBvbmHQcARu8ZO3HWQxDWb9LXMyuL5zQYMHCWHndVPkH0xItCTSNh17BTZfshJ65CKTCsOQmk=@vger.kernel.org
X-Gm-Message-State: AFq9FYIcGA4jf7HHqNsMi51Nb9nZCaG0TpiV4XN/xqR5u12Xq/oCTNX2
	tzCAGYKgW4FSCq95p3CE0P7g43WHfxWD6Tu3GwyrMQ7qGZi4UyPZexas7VfckiZjhRc=
X-Gm-Gg: AYBFou1zR8pnTnCP+TY4naGpm1izXg0Pfaul7LyeLreb7isbdpVkDzh6WCgKMACzgKI
	6OIS8Iz7daT1RmWkW06QPrdO3DYM3M85hqCdfankH1AZHV4s8njWxOD5VzkuDU/xjpJNAayhAGV
	XS6K+9LO4tGJ9QyDZU+Embzwov0E88ZDMYIcYi6Bo/BXmkT0dGOWQmA5LrlEmJxT3b6IbKIekSk
	iDixQaGRo5e3yeaEu42vlzK0WqlKtGPx6cJycWsSJDz9yeLhG+HyPNFl5Cq5d3HUej8A4nb5F/K
	vx0U24TOnchPsiqIUAZelU+rXCZIsxIIvMN1uxpa1nv2SguJwXHkS0VVyfPqRoBeYxWbQ8aqQVO
	cdv3Qmp3VzfpuOZBnjUN3ham4F90M63CxX+kEUAHs2338ap3e9QvXvvPi+BDuy1+RowoaiigRta
	zDbN2WwqZ5Mo3lnpbw6DldyD+HR15vZ3xJLWyT9nXDXMgOebYsShRk/Lu34gbBSlRe+VTyRQv3/
	WYKHMMdwJU381FdDIHwRr7dvYCudl8DwYUTSDR6nZAaiv11ueO4ogS1f0fh3EuicURBoeuCzDeF
	3tqxS0Evu0gVjpl6LAPnkw==
X-Received: by 2002:a05:6402:2753:b0:6a5:fbc6:cad1 with SMTP id 4fb4d7f45d1cf-6b49cbcebc1mr1982963a12.7.1793202501767;
        Wed, 28 Oct 2026 08:48:21 -0700 (PDT)
Received: from localhost ([2a03:2880:32ff:4e::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b4964203bcsm1672508a12.23.2026.10.28.08.48.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 08:48:21 -0700 (PDT)
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
Subject: Re: [ndctl PATCH 1/4] libdaxctl: handle mapping initialization
 failures
From: Gregory Price <gourry@gourry.net>
To: Alison Schofield <alison.schofield@intel.com>
Cc: nvdimm@lists.linux.dev, Gregory Price <gourry@gourry.net>, 
 linux-cxl@vger.kernel.org
In-Reply-To: <7737e1406eb60677979d3b6b090d52ee124ebaa7.1792695259.git.alison.schofield@intel.com>
References: <cover.1792695259.git.alison.schofield@intel.com>
 <7737e1406eb60677979d3b6b090d52ee124ebaa7.1792695259.git.alison.schofield@intel.com>
Date: Wed, 28 Oct 2026 08:48:19 -0700
Message-Id: <179320249973.768545.15663374040316123591.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-10-22 12:56 -0700, Alison Schofield wrote:
> A failed sysfs read can silently truncate a device's mapping list, leaving
> callers with incomplete range information and potentially incorrect memory
> block accounting. An allocation failure also causes an infinite loop,
> hanging the caller.
> 
> Distinguish the end of the mapping list from read failures, reject
> incomplete lists, and discard partial results on error. The mappings
> describe the device's constituent ranges, so validate that their combined
> size matches the device size. Return -ENOMEM on allocation failure.
> 
> Fixes: 5a31bf710399 ("libdaxctl: add mapping iterator APIs")
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>

Nothing stands out to me, this lgtm. Did a bit of testing as well.

Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
Tested-by: Gregory Price (Meta) <gourry@gourry.net>

-- 
Gregory Price (Meta) <gourry@gourry.net>
