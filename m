Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D18A3EB0F3
	for <linux-cxl@vger.kernel.org>; Thu, 15 Oct 2026 05:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792043694; cv=pass; b=Zon8hVh9VRpG6upNxWuYPOncDmSMWvHK/iXcw9iUSw53tdNtv4TDnHewDVHEF8pUa+GpdRelFOsr/ni8qLLyaaVrB6NKzVLdywBaYeHjV71dUMrHtOCrKfuYz40CnKpKpVpquEGGtXSbch4buT30CNO86I22mXiYOBQe7EOSE/o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792043694; c=relaxed/simple;
	bh=CS/WlN4e7LCvLKWGXjb8Z6prVrP9B4xMbuN4Lt91l2Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GuHstvK0O7BV4eV4+IimH5rqPiLFsNMv8BTs30yAnncWqLiw3w6Q8QzyOtAvk3YE/g1fimdgU4E5zGZLf+Fdbc3/fiyTyhCaDmIqNtJm/aFObsGsoT3iK/d4Dd9JKpEciv6lR7RZR0gnyHDPuvLbhGOwcYhXEFKiQmtahQBhWZM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FPuxM6S9; arc=pass smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FPuxM6S9"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5be41a7aba4so4535e87.0
        for <linux-cxl@vger.kernel.org>; Wed, 14 Oct 2026 22:54:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792043691; cv=none;
        d=google.com; s=arc-20260327;
        b=p5YiiC2rMp6Wn1TOjCTJPI6345MV7BaJSqDw7KKmYbzBd4TB58Z/Paz2xARM5Pt3jh
         rGb6gm2ZTv0iI4yzlcaEHnp/QGOOjQFsObj54TGnbM9Zwar1f8RVy2mFaaGLD10LIpAM
         HlRI34xtDOY+v+3I24tkpL9ksUCFkgAsgfmbe73IBfY4qkVDOmobceiuC8+PJEWXtA4q
         y3cKRavuTx3qIn6S3+UAEiwDJE/T01VkBgOnJVveeTBPs7yU+yVi8RNRKX7Q8E7W+Nbe
         OVxuIAJjCPVyWhsSBbqSI+Rufy9LhkaxHI1+fpuDVkaupzNl9ckpPTjldjgrS590gtUJ
         j10g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CS/WlN4e7LCvLKWGXjb8Z6prVrP9B4xMbuN4Lt91l2Q=;
        fh=uBHvqw8OTUzSnYCt7wrR82lEhRDs3ZdDhfb64DJv6fk=;
        b=LtQMJCInw/BGTKuvBfhf7otDUtbBc3MDpltQqm/aK1C4STt6+ocOf3SnlA1+Dk0/JH
         LaDORO8K5NCCpyoX1IqPCtExgljxHpPd1O0q8m/We3Y1gFKJ3VrDvJVtqiR+IPQLdq/B
         T6LkeagXtbA4Xp2iSsjCWGLxwB4RxBpBnn9aFIwzwaefI3M+EW8GPuQfYGkrMjVfon8I
         9AmtMK5GsazCoES5dRSPvb3QcXg24ZGi/uHapdd9rO/LK/jLsBx7xlq8Ufy73KFXJbDz
         iY5JQuAU5jBGVq+nOWvsrxhAlFsETLxGWuPRcL6YO61jDvtGqPOAhAR6qMqXMK4+sFdB
         mZEg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792043691; x=1792648491; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CS/WlN4e7LCvLKWGXjb8Z6prVrP9B4xMbuN4Lt91l2Q=;
        b=FPuxM6S9p2v8n3MuLy5LbCmvh3M/e4BYOVO3lYHGE7sDQYqB4AJV5d775id9IxWoQ7
         2iPd08e1ZlcOExL+wk34LR1qgzwJlqHIh2bY9i4dDwN9WxQ5n1c1ODb4l2W9et1Nnvq5
         67tw/nmX9GG/4VaH08gNR6JlZER1uQaBCKbFvYRxen/4DQhvMUNZSg3zZbT89zUJTomB
         aFcc56JH6a1xK6eGkBViLmdDd4Qa9Ak3aEAfnnGHGY/vYD4kAInzFFnWMx2s+/O3JaI0
         Iyx+Vf5+WH7zZ2YAmf1rlWuKHrrXgl+GZAkFZbFIEAWT941+VYn0PmJxF+D2bLjNYtbK
         Qb+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792043691; x=1792648491;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CS/WlN4e7LCvLKWGXjb8Z6prVrP9B4xMbuN4Lt91l2Q=;
        b=F7cvZx9qBEAHqXWyww1HtQdeoEs+sW3MeQrh0OVQaW45VRIEDNou66qJzIviGSIY+m
         m3QugweZlhHyKh3d6GunFqxHtNp0eug/pCzTHLtdUi7jL7rnVY4/0DyGcRg8YrSJiifw
         i5O6CjPT6qqAm09Cg6lCStzgriRMRP93IYO3/QHcCJFX6hVuQaWFsOhLCsD45SxdKUmV
         kDvvlypk7qaKiDN96OhxhZ64Z5tWgEj4SeGhNryz3h9+4fJsNy1tRMdeABtCJnQSh8bf
         s60YFESXnN7upq+QxC38E4sJjcGsNOZs9UoMrgkxmSy0ZjwUECIaZ1ychTflsuul0WqD
         sMTg==
X-Forwarded-Encrypted: i=1; AKwUvBzfeA1p62Btlb76PEHYPpTopuLsDfj7wVDNCb6TPPPddyHQ/Cr8g+ivrCyu2rWQWv5m1W467tXciKc=@vger.kernel.org
X-Gm-Message-State: AFq9FYKDnZsZT65lu91HxCCgrC5hPsf3UY3Hl0xLdbAg3TemJ2raB1GL
	qFVwNi+Wr7CPXB/vtkhTFSxz/PPc66oj1U4lv2E6W4WNk/mxmGq/j6YQcb7oHygc3puYSv/rqjS
	EUEW2XNBth9wUArP8QSTWnPZq8pK0nmQ=
X-Gm-Gg: AYBFou0IpHzV1rU6QYSnyz6BpAiHwYHIUKJmRtu706Zzu5nkhhzkTL/mZ2x/LIMLKC4
	fo+VkLw402Lq3roOsytkJsyDNey9k2uPJhXA05aT6zpjjoemLW+T3s4dkzLCsodSWPNyHTyLLWF
	kbdrJZWpUmMWIP8j4ibF7U8pnGrLLcd6nnYYEU5tZe01exeDF7JuJmhT/FRNZsbTcxbyPrryQTf
	jOKdrVgExiDodHRDpi6A3jQ1oZB0FYHb1UBXC9EVoINNO8EoTLP0nLc/igZGSIodzbVph3qxCJP
	CzJomxFbmlAJmTT+QEnL9PIWiMd81vfuT7Jur9YW/buRZu/2sslRVmXAlCNJwQNChkh+zA2iLN2
	j90in2dsWnhflNTt2Ty/GN0w8oXmtoeOMY2opXDWXo3n9xJa8ycF5wb6bWblcWfI5+lRKKVWgoX
	qMJcoMDxVTdLUruK6TJllxCbnFvBxCradyaCc6njbuSfu7Lwe//5c=
X-Received: by 2002:a05:6512:39c6:b0:5be:3f94:ab0c with SMTP id
 2adb3069b0e04-5be3f94ab5cmr192058e87.5.1792043691116; Wed, 14 Oct 2026
 22:54:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928011123.450800-1-alistair.francis@wdc.com>
 <as_r8n7p_wdbChuQ@google.com> <CAKmqyKOkmwompJqaP2k-oJicmXmqHY4E0wuLcrvkHLx+oauQ2Q@mail.gmail.com>
In-Reply-To: <CAKmqyKOkmwompJqaP2k-oJicmXmqHY4E0wuLcrvkHLx+oauQ2Q@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 15 Oct 2026 07:54:34 +0200
X-Gm-Features: AclHuK9vg-7Cq6bGY2mpKNcgjuHSAWaQMnCCX0Z82MCYQeI0nb3RkBYX20rXqpU
Message-ID: <CANiq72kP=BpWL5-X3iGARu6ekW52Lt0uCxd+efa+ME02mUbSJg@mail.gmail.com>
Subject: Re: [PATCH v4 00/22] lib: Rust implementation of SPDM
To: Alistair Francis <alistair23@gmail.com>
Cc: Alice Ryhl <aliceryhl@google.com>, lukas@wunner.de, linux-cxl@vger.kernel.org, 
	akpm@linux-foundation.org, Jonathan.Cameron@huawei.com, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	jic23@kernel.org, bhelgaas@google.com, alistair@alistair23.me, 
	djbw@kernel.org, linux-pci@vger.kernel.org, wilfred.mallawa@wdc.com, 
	a.hindborg@kernel.org, gregkh@linuxfoundation.org, alex.gaynor@gmail.com, 
	benno.lossin@proton.me, boqun.feng@gmail.com, bjorn3_gh@protonmail.com, 
	tmgross@umich.edu, gary@garyguo.net, ojeda@kernel.org, 
	Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 15, 2026 at 7:23=E2=80=AFAM Alistair Francis <alistair23@gmail.=
com> wrote:
>
> I was trying to avoid adding crypto and X.509 bindings in this series,
> as that's a few more subsystems this ends up touching. We need to add
> PQC as well, so crypto bindings are next on the todo list once this is
> merged.
>
> Is this going to stall on adding crypto bindings?

The general rule is to add safe abstractions first, and their
dependencies (i.e. other safe abstractions), then finally the users.
That is, adding code that calls C bindings directly without a proper
abstraction is generally not allowed.

Exceptions can be made, of course, but they need to be justified, i.e.
there are cases where the kernel may really need some code to land,
but one needs to argue why -- it is definitely not the default.

Cheers,
Miguel
