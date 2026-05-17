Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCCCE2F7F09
	for <linux-cxl@vger.kernel.org>; Sun, 17 May 2026 08:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779005388; cv=none; b=F+FbNpjtaNTgYa1iFJZY/ogPvBOD0hFclRyJfapJkkm0KTLoOfLjPYisoNH/8CPjZVFB5niZqTY7mhk0jVIMF7e+VIoUuE315oLkYhay9JPwMPinkFVrk+a9s3gS6kNPlGyMxJQoQ1wZ8YFeyG8RAXsBCZ5fF3hNqE6fE4G3baM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779005388; c=relaxed/simple;
	bh=kbwBJp1YaFiYMYBQ5HwtsOteGWjAla/XSzKeMhwGk5w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eqn9wf59xfBd8WngW7PBjOUvo7krkJpR8UGcn7oO8bD4ahwD0L38kRdCqM33u7J6+1gQ1dkIbj4/jJqqXfvRRGwi0aks6AQT1FYyPayqxe1KBi/e9gcWYWsYI1lrJnQRc673kkEZOM/tYeo3qc3v1/iZw/yBfkkcvWQ/boZ/wVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cXNv6QfN; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cXNv6QfN"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4891e86fabeso16388255e9.1
        for <linux-cxl@vger.kernel.org>; Sun, 17 May 2026 01:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779005385; x=1779610185; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QI5AguO9/rJalyHGNSvMkm5DR7zkmggq523vj4QHofA=;
        b=cXNv6QfNNKhCJ/GaC162/O/R/3rHvwJf1EI2oOAGvBamjyPtbFBN0S7+MS5F68gihU
         31skrCVj5uU1F0YlhEOvpYLfPmQGUauj2L/VTeZlXd7a7gR23UV84bTrANwhB76orSV4
         j/ViflO3SVA+PT6knPyaCuQIqNbWOeQXs2fXccNaTrlwHBgyFGbmyjPPuC8MjwgftILG
         TjhkkUOouqhP+brRA4TKQ38Pr+pFoc8Hv/GnzZ/sQB0PYa0J/hYATi29rS3OAfbqNBHO
         ojbqL8aAknzTq8y2lIqypy0Yc6e8a4p6e3/e1n0wPzTloCVGGKsnwf+qXEwqtteueOrL
         7o1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779005385; x=1779610185;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QI5AguO9/rJalyHGNSvMkm5DR7zkmggq523vj4QHofA=;
        b=RbAMn3z5oKzyVu9B/AWocjpCH34HyfR2f5pzuFHLcfDChNKfBzr0ZlRLacdRb6+EOV
         3LZijxiCvhkQUb/rXRfYqXOkTUZc1mpZrKECqC7yfgLAgLjsiYuleNranFEOYggvuhVA
         0rcC5uRESStLYHWYkDEetAKWZLvlnt06bEx0kz7re1wjT8EhfvJY579q1b/rqp56Y/3Q
         pUhLBWTc72hm8XgkXQNu0g5ICzm7Ctog1r3EDBLDo3SiBKxUk73CjlvOGw/i1cgEk3iX
         OdyOJSaEUYA3negzw9Wsk1km9bitwhCM+98+YpMqfaqgXLpUiHVIU6rv7NdIhr0I8fd9
         rcGw==
X-Forwarded-Encrypted: i=1; AFNElJ+gs2PCqhPyneHl9tfL5lvkXNNGM5HNX7lqxl/dx5wc9BSFufLQgqmx4tFGGWZrat0v1jBIP3pQwoM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc5f2sPO3ky9BnPwULmary/xG0VnoqZF350/ewtWg6dE+PtiSt
	YNA9VButXRfJDpq8NT95ceVKcvooLd9BCZq2yTxbS8N9dsHL3RB+Nils
X-Gm-Gg: Acq92OGSIer3xLz2gkg3VCNDBVpDzINGmudU4oq0emQqPGQT+aG/RDKHgFzLG+F020P
	9Gvd35QnuD3CHIu5IFsxb294z89LnSylNX8k/Dv/3bzQhY8BGMRYI6Ptl0BYFB50Wa+uqm5IRQm
	a/3K6S0romTh4YX6nXxvfQdvOCHu5sIACJwjAOxHpppKSs5BbAC5aXiCLsKoRx+4K5Im0Yv/X3a
	dAaO9v/OmUiR7mBWp7yvF4AkDl3nATkWvVDIQ8NTS3wF3i0fH2x071VqZgrnfx0ykdFyqiyc2Fz
	MrHpKIR/K5CGT1JupTNKiPNnRWcNyo+UAdsYQYi0tcbaRF4F/Td9IkO00Q6hZqJuUcxboW+Q6wM
	efVY+E6ivlh+9Pe6sCAl2/PpHAiEgn9NUmZHbDOcn3HEo+TasQlNoIED26M6DwiLeKrEauDKkWM
	txd0I3bhK/yHgBPerLbNA0Ys3RhZEr9mZ91FS00fIjCxfNaSqsZDYJGpnSY9HP5Y9NZ7h28U8Vo
	DH6KJYGo+89lMTG+8fh0z+QjEOPYBW2o8M9XY+5/OktPyxm+6ku2M1VmQ==
X-Received: by 2002:a05:600c:4455:b0:48e:8dec:19ad with SMTP id 5b1f17b1804b1-48fe60ea94emr143018005e9.12.1779005384814;
        Sun, 17 May 2026 01:09:44 -0700 (PDT)
Received: from ?IPV6:2003:df:bf18:1100:dd94:6a85:70a7:b48d? (p200300dfbf181100dd946a8570a7b48d.dip0.t-ipconnect.de. [2003:df:bf18:1100:dd94:6a85:70a7:b48d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0fe0f72sm30335649f8f.25.2026.05.17.01.09.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 May 2026 01:09:44 -0700 (PDT)
Message-ID: <23e1bcba-da88-4cc6-83ca-b77bcdaa9d2c@gmail.com>
Date: Sun, 17 May 2026 10:09:42 +0200
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/18] lib: rspdm: Support SPDM challenge
To: alistair23@gmail.com, alistair@alistair23.me,
 linux-kernel@vger.kernel.org, lukas@wunner.de, Jonathan.Cameron@huawei.com,
 bhelgaas@google.com, rust-for-linux@vger.kernel.org,
 akpm@linux-foundation.org, linux-cxl@vger.kernel.org, djbw@kernel.org,
 linux-pci@vger.kernel.org
Cc: alex.gaynor@gmail.com, wilfred.mallawa@wdc.com, gary@garyguo.net,
 bjorn3_gh@protonmail.com, benno.lossin@proton.me, aliceryhl@google.com,
 boqun.feng@gmail.com, a.hindborg@kernel.org, tmgross@umich.edu,
 ojeda@kernel.org
References: <20260508031710.514574-1-alistair.francis@wdc.com>
 <20260508031710.514574-19-alistair.francis@wdc.com>
Content-Language: de-AT-frami
From: Dirk Behme <dirk.behme@gmail.com>
In-Reply-To: <20260508031710.514574-19-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08.05.26 05:17, alistair23@gmail.com wrote:
> From: Alistair Francis <alistair@alistair23.me>
> 
> Support the CHALLENGE SPDM command.
> 
> Signed-off-by: Alistair Francis <alistair@alistair23.me>
> ---
...
> +impl Validate<&mut Unvalidated<KVec<u8>>> for &mut ChallengeRsp {
> +    type Err = Error;
> +
> +    fn validate(unvalidated: &mut Unvalidated<KVec<u8>>) -> Result<Self, Self::Err> {
> +        let raw = unvalidated.raw_mut();
> +        if raw.len() < mem::size_of::<ChallengeRsp>() {
> +            return Err(EINVAL);
> +        }
> +
> +        let ptr = raw.as_mut_ptr();
> +        // CAST: `ChallengeRsp` only contains integers and has `repr(C)`.
> +        let ptr = ptr.cast::<ChallengeRsp>();
> +        // SAFETY: `ptr` came from a reference and the cast above is valid.
> +        let rsp: &mut ChallengeRsp = unsafe { &mut *ptr };
> +
> +        Ok(rsp)
> +    }
> +}

Just as reference, there is some discussion about this in

https://lore.kernel.org/rust-for-linux/2026051610-flint-compound-810f@gregkh/

Dirk
