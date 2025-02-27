Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9116F22ACFB
	for <linux-cxl@vger.kernel.org>; Thu, 27 Feb 2025 11:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740657137; cv=none; b=jL9x+9QVy5kj0iVrirxA59z3R8H9v3afBRHHh17a1CLdYgsYeDFOoRsTdRIWv2spq1YYSvEDBOCCMJn1BZKgjYuRezPA9kGeX6oi/c0szVR9vork/MLTI9BZrXq7GR9Td3DD/eAZHHOGdfMWEoAhVZrTazmN03RGdaWJtTV+vFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740657137; c=relaxed/simple;
	bh=ZaBaHlXpgISQnJ1vf38M4JccZJO/2KtLDXTAswU9l0I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sVSzBdX9I18aPhr/ESQAa+FgfgRmPsMswNZbPzElY7rPMRFKc/WLdba0nyCayINQKq1TqiBpxVLxZtCxswy2ywn5zVEAXHQqL0EuGVVlEH0LWM9s6j/5jyPYkzesxYMBXwHRShNG/9TWPyM+XjJp5zr4nxT/d5t/yQeHY/dnm0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Pke+xbY3; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Pke+xbY3"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43994ef3872so5636045e9.2
        for <linux-cxl@vger.kernel.org>; Thu, 27 Feb 2025 03:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740657134; x=1741261934; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CNdKucBFyLDnUpRRHMFpanrFUXUbOxjcG2NQFry4jEA=;
        b=Pke+xbY3dU3Sz7NC4QJSWHHHQj3b5pbIFPMJki/MA4nPqUHqTjrqDnKGPXdybYCqBH
         4ffqpIXT1KraM5jIs49Ij25xHYM2F+fbG4s803uzZ4UrkzZRhh8UR9Duph8Q+LTR5DY7
         noNSkU3zGyZtT2rsCXhNg23gcymhsRQTOTrgDhAegubmY6dZGJFJuzTD55567i8ayl34
         pOf/96ktJ/q9GIW1Re1aewCBusMkBcotxh89xlAei9qbuUvSkHaISquK0hu0BInSzy78
         hAXOigAoh+QpPDZ7AXb1U/Hd0AmgCGz/SLtSGH5lge7e+KN4PJycOjaCUPGNw9UQo0sb
         JKYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740657134; x=1741261934;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CNdKucBFyLDnUpRRHMFpanrFUXUbOxjcG2NQFry4jEA=;
        b=tWeR8uNJlZ3oqi/u+4Avvdri1jnNT13N6H5qQrDdp2DY8Io+e/e3j4qKs2j8nAZ4H+
         6mtMNK3wLixsjVYiMXJKpiVAhmGZNRYOYX6huSab/zxxWqju2cRtpGlhRZhaHZ8lfywB
         cdDw8J333VS4mSLwYthmkB3K9YiaEeMNsekEyD8EzCzBCUxpmN+RqBxgF+lGgGC+KqRf
         wxjrw0wCZrHyFQ4rCajGcaq1lJ9s4gr3xyRg9vKTchdsgfC+YXKpDhhqs1zSNFKeNu6C
         mH76kWNFE9s9kU0z08yG+bx8bTmMeMCy7OrvoypGM3hUyp1JOAD1chRKg8N20HpFFCAH
         XTqg==
X-Forwarded-Encrypted: i=1; AJvYcCUahSCIfwzOtE+rMP71pS+wKO7srf+1VpbMx6HEYqyL3fDRbEmDyrhKsLgEw8VVsxbEAhbrgnu03yY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/QTFMlnABwgXSWW3ppPKmkDxuYljiNI95Gw7e1tbkosgmvLoW
	W++noLvbBYP/x/G3I2bRIl1sG53EvoqzxwvHDRslmE9xi+V4KVngO0X73eXJbs1rZLjSwLDQTq2
	Kelisk1bsUOqlM3aY1QS5qY/+Q/4LWJhiAHzY
X-Gm-Gg: ASbGncs+6goKlhOU0AThndoekDX72mVwp/pe8QaBNtCoDR6BmQuQfNoyNmemPNoh51X
	yrhjAT8D3nKiQlpXAI6QjRv4oXqZ643huw56aUI4HxKiWIdmQuVJs893mSHNrjmVxg/hrR0rPCe
	FM5aSeYZwvmkj+/iGvu01cIoL8NSXTfJAaQElmdw==
X-Google-Smtp-Source: AGHT+IHFMCQU8NgWs1giXV4C3CXCYYEUJ/IZnhwhrgrkeisTz7Mc7yeRf4H7WaocW1dgWF/I8OCXnBza7JsyX98bFDQ=
X-Received: by 2002:a05:6000:1864:b0:390:d954:5e7c with SMTP id
 ffacd0b85a97d-390d9546117mr6217650f8f.38.1740657133802; Thu, 27 Feb 2025
 03:52:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250227030952.2319050-1-alistair@alistair23.me>
 <20250227030952.2319050-10-alistair@alistair23.me> <2025022717-dictate-cortex-5c05@gregkh>
In-Reply-To: <2025022717-dictate-cortex-5c05@gregkh>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 27 Feb 2025 12:52:02 +0100
X-Gm-Features: AQ5f1JoXfYkoxQb4CZpqnD2kagTNPR0-RQG81bynqiWx3iUDZjKaVI-kJG8xNSA
Message-ID: <CAH5fLgiQAdZMUEBsWS0v1M4xX+1Y5mzE3nBHduzzk+rG0ueskg@mail.gmail.com>
Subject: Re: [RFC v2 09/20] PCI/CMA: Expose in sysfs whether devices are authenticated
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Alistair Francis <alistair@alistair23.me>, linux-cxl@vger.kernel.org, 
	linux-kernel@vger.kernel.org, lukas@wunner.de, linux-pci@vger.kernel.org, 
	bhelgaas@google.com, Jonathan.Cameron@huawei.com, 
	rust-for-linux@vger.kernel.org, akpm@linux-foundation.org, 
	boqun.feng@gmail.com, bjorn3_gh@protonmail.com, wilfred.mallawa@wdc.com, 
	ojeda@kernel.org, alistair23@gmail.com, a.hindborg@kernel.org, 
	tmgross@umich.edu, gary@garyguo.net, alex.gaynor@gmail.com, 
	benno.lossin@proton.me, Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2025 at 12:17=E2=80=AFPM Greg KH <gregkh@linuxfoundation.or=
g> wrote:
>
> On Thu, Feb 27, 2025 at 01:09:41PM +1000, Alistair Francis wrote:
> > +     return rust_authenticated_show(spdm_state, buf);
>
> Here you have C code calling into Rust code.  I'm not complaining about
> it, but I think it will be the first use of this, and I didn't think
> that the rust maintainers were willing to do that just yet.
>
> Has that policy changed?
>
> The issue here is that the C signature for this is not being
> auto-generated, you have to manually keep it in sync (as you did above),
> with the Rust side.  That's not going to scale over time at all, you
> MUST have a .h file somewhere for C to know how to call into this and
> for the compiler to check that all is sane on both sides.
>
> And you are passing a random void * into the Rust side, what could go
> wrong?  I think this needs more thought as this is fragile-as-f***.

I don't think we have a policy against it? I'm pretty sure the QR code
thing does it.

Alice
