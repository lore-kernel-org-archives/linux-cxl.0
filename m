Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9F9282F34
	for <linux-cxl@vger.kernel.org>; Fri, 13 Mar 2026 05:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773381248; cv=pass; b=GjAsSI0bg2hz74/VhoqYldmhCYpN+spiSG16rQ4HxmOwmndaJllCXqeL7u0CixjxqA6BZPn9gAQCLY/eENS4KSz59RhYriydLles3zRFiCJJOGP7B9buRua2CD4nkIr61bXMsachHQQVFw+fGZlQYUoGx76uip3zvAgO/3kQYC0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773381248; c=relaxed/simple;
	bh=1O5JC40mgWM5zVrjpeth08KNuSHWy6NaWB4eNtTtZrM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GCW21z9gyqEuOl+D0f78RGL2donSQZt6oClN57pqjb8IRu2FVGgsqv70JkWmAwivmP3TSrz5nei3vXxE/7EtuPkrWbLSds/7heeCu8T1AqrdWZvSNwFTo135m9xfK0rqaF8DvyB/grB+Qu2vmlrs7NywtmUSJNDG5GJtNZQtWeg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c13GKxI9; arc=pass smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c13GKxI9"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2be2ce5b538so160766eec.1
        for <linux-cxl@vger.kernel.org>; Thu, 12 Mar 2026 22:54:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773381246; cv=none;
        d=google.com; s=arc-20240605;
        b=XGjukBVF7bTTJWZ7TaxwX2S9M0YQasvIUhhpwaljxVgyH0SR7UJXvuHAbkCscnKB9f
         KNW72zgnsw2AmF6M4DrnQmB7cKb1cyyhE72Z/IPB375+IbBBbL692TBGDbeEiOOIsopW
         rTUQmKVc65DGiJF+MA+uPshekkhb2d7Vgth45SZw0hz1V7Rv7POeQj+xUzgS/aKmvLXo
         phOEUdEi0o9LZZMyg/QBsqYPKFLZMIqEH7dWEwnT5VJZtL2QzD+/HZ6Hnrf6hTtWmJDL
         Iv5n/jfcfiWlRPrL7iguh5j+rjovXQOgvzBbf/BwU8Ta/uaRT+fJ/Jvs9hysGXLqn2LD
         tbwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UE0N7OKJt0SzGyOmS75dVlvrQ3qOhY0fM26VXEgbq2M=;
        fh=tLA8233kvmsKhfF1OAaL8kCDkvOm+nJLif8uy2WqARo=;
        b=fa4015KBh3Z+mqb5wK8B1vl1EtTjYLx6l87b0lOniJXb1vX8THUdXLUN0Qjc5aYYcN
         Z/IS1OQ5/GI5pvRkwKNXSilZmeKtm2Es12NzEP6vSvf657R5kabNIDMX2go+35Kh9T2n
         XoKfl4coY2iDwQ7ZnKTH3c1PhAh6aG16AI2dGOnFMadz/M89ETUlq/l75P3vRyz4NMWo
         /hBS/xWF08d4vlL20GIRvpNir158cqlzAjC/mlfpemnwK580eyCCbiqtzxSNQD+bVuzh
         6BDjChX7xzYM8/PaLCTv707nj3hmFfJaK3Hhgz/OqDLsfgsC/4WGTV5vcI8jXADjz24P
         PHyg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773381246; x=1773986046; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UE0N7OKJt0SzGyOmS75dVlvrQ3qOhY0fM26VXEgbq2M=;
        b=c13GKxI9GPhGx5f2mVq/NSsD4UsMECuJHYhsYMWJyvf9tXK+6P5WTH+LX7vgSUfrhU
         z9siGXsWcnssQ87b8x3fXJIyaXeUnGQCIo/w97wpxgmv/b4Y/8LrWvuW+nBB5hsqRDmt
         ysbUSe6tnaG0C8y39BmAhfyqESVKA+ljT4hM8ntmAXozeThCVIP0+M0pZHzYi2XBpEcK
         Cf8rUWfTofpfVC6JJj7x44TqYhJ7GgZ6f7yw/tAZz27j0gHOy5NjJPp2aG68/cinajb6
         ccQezf4OYcYXEKPKQtKjBon2IWiNcJan4dXXBGZlqTW9v6u+1An2SoR7GWzS8bRvAzSQ
         o/rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773381246; x=1773986046;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UE0N7OKJt0SzGyOmS75dVlvrQ3qOhY0fM26VXEgbq2M=;
        b=piJXklFqPLA4KroihFfXXibDVVvCbU2M4CeI2HqS/ozNsVCk456opI3c9oY0JAzqnP
         eQHfSWVsPl+OzgD7emE0o/Z5Lahsp3SOdbIfVw5B/A9juZUDA4ptHwcS6nwpyF5KCbo/
         FmJGTf/blUNng9FBf7UBKx/LmfpE6AGylqc5Vs96/za4QQILXj4dRXE2xIPGIbH5eCf1
         KZM2NncWZGd0dqhaCAmvqaZtlWmyjXGxtKsH+e7SpVFjd68TFaib6IPLKNuI8eMpZCdM
         1x5wdRS04QrggLu4+Th18YG/HVnXsSVX7hUgZNs7wPGNNazz7aX77V/rotykK4NL6PxU
         k8PA==
X-Forwarded-Encrypted: i=1; AJvYcCWJ0ll7zyOZo3o1Z3EYalDelMgrludYgSF5mppu9yKeiBA6zug6G9OCrplyx8b8HeKb8isU06J/a7w=@vger.kernel.org
X-Gm-Message-State: AOJu0YztKqZwL+mXnMFMSjewCQVY0cUvUFp1tZ4HaR7E6GMUpG5RZUoI
	1r9BHlHaVp1Ov/HdLABZq2LXZE8CAw8sBkpa5P3cCsCCezPIr8hxh4cy76PMG+j2nQXgRiRaMeY
	+OuQ65WPfoGG1PY2W0AHE8WBaEE0gdDY=
X-Gm-Gg: ATEYQzwdbQb9RH57bRaz6F3Y8qlipiZoTXlJ6io5mhWCWY2xpoxY4HDHY68PIb8qPHt
	d9L67cBkO/pvo8P4Vc7k92ZiO7eISiJoBGXuUtr8kK3xRLWAMUcjT4LEdTHMtN+X0T3/1uAO134
	gsWyN71xKu284FlZsvd+89iOByseP5UHPQ1ppmWINBqVa6Tnjtfijem0b2hyK6su7KpCKxQghgr
	xgo1s88jloEu/BcBCh1pwTMFju8VxmpGo2x9f7Wh4K7ajUDn7Mh2PwgDOb7mX5b8J9SJF14i5ZV
	Cm4Ism5mRmSfjAhQnyN6hahLcYeM9Loj57kUqaylLY8vs8bxgv99u3jvNXk/KpybBQsPYmjEymq
	/bmT8VOBHJERs3pwJT+/T3erGyGMyXd+4DQ==
X-Received: by 2002:a05:693c:3008:b0:2be:a251:b3f2 with SMTP id
 5a478bee46e88-2bea553709bmr543412eec.4.1773381246439; Thu, 12 Mar 2026
 22:54:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260211032935.2705841-1-alistair.francis@wdc.com>
 <20260211032935.2705841-13-alistair.francis@wdc.com> <20260303113642.00005774@huawei.com>
 <CAKmqyKMUT__C=4Lo5BhjB_QoaGHHNHQvxLmL4xuB54U=Rm0nzg@mail.gmail.com>
In-Reply-To: <CAKmqyKMUT__C=4Lo5BhjB_QoaGHHNHQvxLmL4xuB54U=Rm0nzg@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 13 Mar 2026 06:53:54 +0100
X-Gm-Features: AaiRm52U2RRbXymw9sLKGMHCSPSFMUzzPE02drckpBuanNBmfgA91wq9hM2e7sA
Message-ID: <CANiq72npg6Cp8EfvP4H_PKhSaenq=hhOvV2VyMesc+rR3hB0DQ@mail.gmail.com>
Subject: Re: [RFC v3 12/27] lib: rspdm: Support SPDM get_version
To: Alistair Francis <alistair23@gmail.com>
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

On Fri, Mar 13, 2026 at 6:36=E2=80=AFAM Alistair Francis <alistair23@gmail.=
com> wrote:
>
> This is a public function that matches the C implementation, hence the
> arguments being fixed in the previous patch.

Since you have it in a C header and in `bindings_helper.h`, then you
should be able to use `#[export]`, which will do a typecheck that the
signatures match (it also does the `no_mangle`, so you can replace
it):

  https://rust.docs.kernel.org/macros/attr.export.html

> This is just how the linter formats it when I run ` LLVM=3D1 make
> rustfmt`. I don't really want to be manually formatting things

Please use the "kernel vertical style" for imports (it is done
automatically by `rustfmt` too by adding the `//`):

  https://docs.kernel.org/rust/coding-guidelines.html#imports

We have `size_of`, `align_of` and so on in the prelude, so you can use
those directly:

  https://rust.docs.kernel.org/kernel/prelude/index.html

I hope that helps!

Cheers,
Miguel
