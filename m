Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA72C1A3172
	for <linux-cxl@vger.kernel.org>; Wed,  1 Apr 2026 01:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775008112; cv=pass; b=QWNTBZT9cRhuvINEC4PKm7fvgxrsHVfHfHqGqtU0ul1AohVOu6ZMFgLZEg5L5mibjBA+89rhqyDSTMuiSXsE+wVSa/nH89Rtkwg6+7ph/XEYXdNIyoZsO0P9paxCcYh5xazLPJYkUu36Y+SeMSuNIqt5XkRpD9R1SKQevXOojhk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775008112; c=relaxed/simple;
	bh=4HZTJ/K0tXpJ59NwQFrVHgQrpFf581z+InFkKZjHpxs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OZAYZ+GTbabYXQT3w21zPcfR2/Uu82ieQ6PwI1qZ6df62JeXD+J2/F1HwNzXrwgz7SWG4X+lA6zjK1OBmLoaK4qOlvb8EsKEFUT6AAiaUlJWJxRwdMtdoijTFxQ+Oz+rOcNfjYSt3e0A+svQKvDyyQmmjOJ1q97hJvx3ICjOegs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZCgme1dX; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZCgme1dX"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-66a9a2187a5so10029511a12.0
        for <linux-cxl@vger.kernel.org>; Tue, 31 Mar 2026 18:48:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775008109; cv=none;
        d=google.com; s=arc-20240605;
        b=G/L94Nf8s9nAMhwatVB0Inu7ODGzLNxfY3Wf4Bnvmy/Sl29iZxhLpBsb3RRhZgAf9b
         ex/7+Qm7WesiL3J1JNHN+Czzx5u2NlkSMWoAtCOKZdMmoSXXvGDS4Jdzrj+55KllQ9bj
         Y4GhvSXE2lxegA0oL8npnfjWS14Mn1QnFdS9qnM+tRhTsPD2CtVEY3dPqgC/MKfSdkde
         E7t8whd9bDkXavfeCsFvLTNucdSfP9ISfP+MK+pGI43cncV/lEuj/FmJcLsT+H8daZnR
         jFfZV7v6N5DDH6+Ed3YtCgj/Jc+KCstuVVVCvRXmnpbIJScKgZ6Vl91ggDH0alcWQV2S
         2szw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4HZTJ/K0tXpJ59NwQFrVHgQrpFf581z+InFkKZjHpxs=;
        fh=ijdInz1chBcFmFD7Rq6EyqbF9O2MZxV8/pzUdCRxP1c=;
        b=ZcHQFQwEL2ALG7Z5wwHBBBDszwZnkYdQVV+/IH4EFsVsvuwB5R3SuA5GaT5hwjoamv
         5tAHSMuyiAoe0YNeMdBqSV5aLs0clULzwyKZci3wcnE/0E33DHUT0asW8p1VTrbLOUKY
         WzF71cVVQrbMTHLM9+m/6rtrarhgk3IvjB/6fIMKEkS+fU60eacup4CTsTq5iOyMJTIr
         JTxz3pzQywh5PYEtunurZxSmZ/js4kwVOVkHg5KmTVduHoEnLCJk8sLPVVxo+cceugqc
         1/kRnIqxXwIKPd5d89Q0mrwi7dMROqD7w17GtD8HG2TahoSDrLWG64tQt5hRRsFFG1iv
         aG3w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775008109; x=1775612909; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4HZTJ/K0tXpJ59NwQFrVHgQrpFf581z+InFkKZjHpxs=;
        b=ZCgme1dX9AyJySVRw0PgeaWcSiMrEGEV93Qgoxz7uOY2YLbX2EBWLzTiYaWOXSCKpk
         OWXyTz/P/97MrnWAOyqVxhMKZK9XbGfwa4HvaR9JPRv++U4FVT0MqaZx9V611Md/JMN7
         7ibtOoGaE/FQV/UsqNxcb81AsjM3wTnBRJsQ05cidHUngE8XgkX9fhSRd9+sXyVfilkl
         V1FxanHPYk62rHAWJY7kN5tMFUV8suhIZRadgvEgGf5U1MJzGr4z71UxcUzAFsB8JP5C
         cf1rhKluqfVC5KGMShgV8G3+lJnzb5+pmZZJPv2I+AzoTphrob0wZLtGQlKtHbckXm2i
         zy3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775008109; x=1775612909;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4HZTJ/K0tXpJ59NwQFrVHgQrpFf581z+InFkKZjHpxs=;
        b=UioruFuOOKvC1xoyMJ5ISlnhjf7LO2cDgijvdlo1qvdSsAiBgqWqb/w/8b/W+v10LP
         8/GJrvnweYvI/bI654lrmHbH+1pkSkmznGDM7hp8FRdYr/Nd2Zs26OzwegMVsUJrAAPN
         NMQzivK5coQw6a+cAy5ZnUWd/d8zeNyaYvZfdaQO6gr5Ys643hhG+uW0fgnxkrgnMaHW
         rZuB/ffq1gFmvLr2D6hWYE6vrRCmvLj5cSkXEwvgvPM1D/2wMgB36Bb4XFqgQwITj40E
         srrXfXdIpX8KxNuDis+35ztc3YHGzNgeuOUoOhruPJRSIneaW46ktwoBvfvhNwXqQgAd
         05gw==
X-Forwarded-Encrypted: i=1; AJvYcCVzCaIXegj4I4Ur2iRvdBWk8l0+tUPVbFRN4xJkjS7jx/FgZOfhYyfMkXM2RSdo8icYvp2lVN98Ad8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs9XZMXGb0roMpwELG+ZiFa6HvHAxqCfJQJfmDkXjME+C+CM62
	fljyHSksGaNsAI+xglMq1WzHRLC5oez6WAj7f/KG5jqEBZ3DdG8AnSYSSrTBSEGcFvt50gcIvDs
	+utgz287+N5IzzEmxd8zFooQJVP1h6DU=
X-Gm-Gg: ATEYQzzhkg+eGLeZo9R6c+lT0yz/2DUnAW+mD492m6mWAB+Mrz5tz3IC/q13fD8sCMn
	baU4xzfFrwjsHGqw7zhPfRZk5CLjk/2wgmMePd1Dvp8KuYx5T+H14V+xRIhGeze5K8e4MULQaRi
	h0+jyQH6oyphtsH7eJOfeZGJcPgBPjK/wLwHMzdOBs+cY/WwbNhYS8CqiBy5luAbcg+PGfi6ntI
	eRGuMPx5bb9/YIYR1QrLDXQRPcptbPfLu2pjnSieago6LEpPpjACjD9F4O1oE0tdrdK2ILnjrkX
	mE+0gRn8y9cUFjhW+ZRQ9QyrsXBLFMjZhIy5Zw==
X-Received: by 2002:a17:907:160f:b0:b97:98e9:1b17 with SMTP id
 a640c23a62f3a-b9c13b5bb0fmr102635666b.28.1775008108998; Tue, 31 Mar 2026
 18:48:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260211032935.2705841-1-alistair.francis@wdc.com>
 <20260211032935.2705841-23-alistair.francis@wdc.com> <20260303150040.00007458@huawei.com>
 <CAKmqyKM6CBucDEo0aKZVWrKtozbT_ddk0PaZFtHyEMMMx558JA@mail.gmail.com> <CANiq72nOt1E8=GYdh2T5BWNvG7J8sZRF+60taghoxKm8fkadHg@mail.gmail.com>
In-Reply-To: <CANiq72nOt1E8=GYdh2T5BWNvG7J8sZRF+60taghoxKm8fkadHg@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 1 Apr 2026 11:48:02 +1000
X-Gm-Features: AQROBzBOwFmUEqf32on5JrU8aXHIhvBHljtpfJBqW29uemU4k1ri6P4DAEIz0EI
Message-ID: <CAKmqyKPa5fDmo1A6OzF0ROn7iTrBrhV1Q2L=1Wkb=o27f5fDSQ@mail.gmail.com>
Subject: Re: [RFC v3 22/27] lib: rspdm: Support SPDM certificate validation
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>, bhelgaas@google.com, lukas@wunner.de, 
	rust-for-linux@vger.kernel.org, akpm@linux-foundation.org, 
	linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org, 
	linux-kernel@vger.kernel.org, alex.gaynor@gmail.com, benno.lossin@proton.me, 
	boqun.feng@gmail.com, a.hindborg@kernel.org, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, tmgross@umich.edu, ojeda@kernel.org, 
	wilfred.mallawa@wdc.com, aliceryhl@google.com, 
	Alistair Francis <alistair@alistair23.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 31, 2026 at 8:11=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Tue, Mar 31, 2026 at 5:30=E2=80=AFAM Alistair Francis <alistair23@gmai=
l.com> wrote:
> >
> > Yep, same thing. My way is the Rust-y way to do it
>
> Hmm... In what way? I would say it is the other way around.

I think it's Rust-ier as it uses the fact that
 * if statements can be used as expressions, which is a cool feature of Rus=
t
 * Rust is explicit about comparisons being bools (no `if (value)` for exam=
ple)

So I find the if statement expression returning explicit bools very
Rust-y and easier to read

Alistair

>
> Clippy should be flagging this, too.
>
> Cheers,
> Miguel
