Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.178
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793107210;
	b=XQLk8dFCm9sSBVb5QMRN63pBp9FX/3iAHHylMZ/3qnQqHbrwBJFnSGbi94MrQ1Vocxq/
	 DpJTuUJqoKbsx7FzDqWtmYKnKfIaaZN//us1ypC3Pjcg2pNiLI50xU9b7l4LcYgzRyRDI
	 gVfAt0UyGB/Mbrm5DomF3qxo1Eq3jbfeKKChGB8Lr+e6l4mXNtQ1+yYL3+XGjAgTxmJKM
	 /aGVNUf4nqSKjHdZmhkUC4tN489axtxab4tFGUQxu+4Uh/o/1v/9aqe7o/P5NKTFL6wPV
	 HpDgQTwpx84NFl6rigXfpY3Vw3iI0n4sPU1FA5D7TDhz97Ufvg2nBOCDwd3/qo3wpmQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793107210;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=b4XlHG69rykZdY7UFDMMd4dGaLAt8RQaxs8vJ62P5ng=;
	b=XbVhm5s3oPMUp90H6JcOzd0dU683BQtWUom7wQeCOB92yZD3JOJVvXKx5wHUWl9kICmK
	 vOlal2/39RepxZZmET8TgyR/NJ1AndBfQYNHxtn8j+KMORix2mgJ2IorZWYKDoyL3U3X7
	 /OjlYUWgNwYFUJxnfRwOU3voTyKUuss+81xkQ195qwZCb1OY4tsoOcovzjnTjcs0aj/kZ
	 4KdnIqUmTUa54trUoY7Y63U9YJZ64VfbNHmRRqLALvQRVTUqT7+hVUdMQsLI7AgGhrY//
	 RKaeaPHeElsTDOOEa/VoxMVofiRolJLFJXeAgsnudniIIYYFgKp6fhmjLXEe6RFLldg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=KwmXxI7Q;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F15606A31D
	for <linux-cxl@vger.kernel.org>; Tue, 27 Oct 2026 13:20:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68F15606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=KwmXxI7Q
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-36a10095f3aso134127eec.2
        for <linux-cxl@vger.kernel.org>; Tue, 27 Oct 2026 06:20:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793107209; cv=none;
        d=google.com; s=arc-20260327;
        b=RwJYZrM3GbRZ+0komxDN3tUzlaPLUNopRtdyVDYufYLIjK1xH4lD0f4XbjeBm5IqeE
         /eATEcFHuEKAhnR6dRbwW6NtVThr0BaPPdAvNVb5A2HliP9J/lt9sD9q0Rudim8XzDBr
         ujCJ+pW84QBO7awzL0E7fFDs6OvIIeBoBNkLxgk6imxtHx9bkyRrP0ja+baCCAH1LOJ1
         30rJ9Y5egZfbiL7aBwsLMuCVXnPeRAeXxqc8+T8n9eDgsCjygQNrDKS8ijpsv/oqre/d
         ehPktuJAoL9/x1/0lqxzKVnZmxdz7MJ1uo8Vrtd1f9jg96bgv4q6ckpR7lT2rS5EIsR4
         Xonw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=b4XlHG69rykZdY7UFDMMd4dGaLAt8RQaxs8vJ62P5ng=;
        fh=Tol+RF3oMVUUZnuNHwgFZ3/L288jdK0hzcEBlGB3F38=;
        b=rCGotLSqcwjwI41SbPWDwaONfhkLEVulzc3/mh9RL6wAK6vOr93CuCgDPV4uwSkWxY
         q3kNWaa/gxoDKcmMxqVI4mHt66ManWjXThTjAUSNpKrVTNT4etI0jK2K8w+VOh+SkBsn
         mFPYrlGtaZcEzrTddXxeDmCTYLG/ewsUmW9XnoIE/ZRHMiEp35w5KMxQ/MvFYnjXYqg2
         wY9NKiBXnPnQ0hUeDpdbul24Kq7Vx9YIVcVhb8sE4Gk8YQrXfNFHRFZjkdJFw2Kcs+9p
         qJ4Dl4Kr5eYz4AN0Tyy4XNVwYQrexJ+8phO52BIWJpvsD+MooQd6yfDw8JliGyvdZE7u
         UBEw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793107209; x=1793712009; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=b4XlHG69rykZdY7UFDMMd4dGaLAt8RQaxs8vJ62P5ng=;
        b=KwmXxI7QR3rV0LwEuF7BShBsVedgcPi8hai8PBobx3gkqKirVpQcBTCe4X9ZHRjS8t
         M14IQzNGZsu4ZztRoW39NVUxZXvcM5bs7xFhcfttkxagYdJMJG2NmsNxEqs/yqY7YQc/
         ImZwrvRUFoNCML37bPj7ZRCT2eT6g/M0tRhDr3GbRwirXSjVr3Kr9Ia5BU98BgeZ2SkG
         epPhWGp0UIHP0ktg328MhtG183M5XggsEaNwijx6cOirBfhy9UAS2wyTCzeBzE5pCmsR
         RPjhQWPw/SH1q+rzEVMGeKdQfE5nMr/gDetewjQmFhLg1zBP+icxHKGYp81oc3aKNDiH
         YnLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793107209; x=1793712009;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b4XlHG69rykZdY7UFDMMd4dGaLAt8RQaxs8vJ62P5ng=;
        b=dKBgSXs+PHoGOPNCyWrCc5H5Yp6cc3O/txjCb9zWcvS+/GIOAlGv7B9TkgYuw63J/J
         RuptwqnbPZbEGVg11HEZKGvM+8oxqaATm+OHd72u92qdldMaVfs7PefGePv44j4TMlkK
         4Q7unB2ACSmMDZ2w+ZVELeCE8cLtiOdKJLYeVXlI7NCSWY4lxaXAJI2XTDoWa9eu7M/Z
         pO83TWzvatmOb93JJAz+TKg+zY/gpksXwvGLUGGMB5eg6oUWxSWHkvrwJwHOkoEWMYIG
         jzRTshUjP2foX+vN6g8beCvSUsmoheb9LIZ4Q0ztHBYFPMoQId0nTOC0bk0NF2vgvmrN
         J1lw==
X-Forwarded-Encrypted: i=1; AKwUvBxO2Eggf6GySKziC3MaTl9kOX8geLOLBUl1P7H007qD1kMQDdKUzU2gBY97DtoKIWdXLTRzAY6vJSM=@vger.kernel.org
X-Gm-Message-State: AFq9FYLPPpzw7MIcqBO98+alQICXOfbaxG7tpZPCf4ag+UuYxAokbhwO
	0NXLyIPey6QG0K58OQYTnUg3b536rrTQ1TAv4HkBN/x3Ru71cH8nBLgk1zH2n3lxE8Jdp6w+oVu
	jOG3SzNA6+HLTjh65wnJQxzf6BfufHcs=
X-Gm-Gg: AYBFou2rX1Vbr/CRlHZRdxZkEnhxWnlgf5N1yo99g+5tzcb+/5fFpAdevPyPOv+YcfS
	OZjnN9TZkInZV/ottpeBVj41cAH41KOIZsihmmrFUnw05c/5THeZUyv2WX9jMJhq1joK9TVCp41
	Eplm3ztJAmvVTW64Tq24oisHPLNAx4VqzW/5Guyi1AgMqQfH7OMD32iO3J4FKZ1nkbDmAiJV/Fh
	2U8fRi4vuj2XRs0jEV5hnZVKJQpCbQgV/tnXXhwiYBBQfavaFtmTXFVnWwip8feCZR16sYx8+uK
	apm8ye4pAh84gU7ff2k6BXvLOtGxuIYpalua8NyqQWRqRFWa4EhMm3U1mjCeBaEJxKXK/bgKCT9
	3BclB20HVrmir/0X/RU6ijfR0CPTne7pn9zqFVizAyOU5r3s0ErslW5xBUm5GM2lEL4OBliScF2
	fB4KZiTGC2DGx/Q/TeiJF/PRwYNNnnOGoWa9g5SODIbzrDKPT5up6mdgBQo2S5jMBhubc3lcGNJ
	tTOEB4qJ9sb9fkZK4aTystVpJcz+/RY99Ya
X-Received: by 2002:a05:693c:8817:10b0:36a:143d:98db with SMTP id
 5a478bee46e88-36a143d9df6mr3896465eec.1.1793107209313; Tue, 27 Oct 2026
 06:20:09 -0700 (PDT)
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260928011123.450800-1-alistair.francis@wdc.com>
 <20260928011123.450800-11-alistair.francis@wdc.com> <DM4NT7TFX4X9.1GFI128LI5ZQ4@nvidia.com>
 <CAKmqyKNEup=x+bwmPD_8x0s4ssPkqFnQtSGqJ_82z9oDP=A6cA@mail.gmail.com>
 <DM58HRC3DHSS.1YC0E53ZXANT4@nvidia.com> <CAKmqyKPwirjmeBQvXgheY8Lh-M-RRq5pdbv=5mB4duhw9aCbGA@mail.gmail.com>
In-Reply-To: <CAKmqyKPwirjmeBQvXgheY8Lh-M-RRq5pdbv=5mB4duhw9aCbGA@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 27 Oct 2026 14:19:55 +0100
X-Gm-Features: AclHuK8O_cUPC_NV8nLehaHvClvws6tvszHDrs0qLddmTGSO7twgLKCazt9sU5Q
Message-ID: <CANiq72n=eqh6W+iNWPdM+rrc+HujtZVRtVg=JB03OMS8rc5hiQ@mail.gmail.com>
Subject: Re: [PATCH v4 10/22] lib: rspdm: Initial commit of Rust SPDM
To: Alistair Francis <alistair23@gmail.com>, Andreas Hindborg <a.hindborg@kernel.org>
Cc: Alexandre Courbot <acourbot@nvidia.com>, lukas@wunner.de, linux-cxl@vger.kernel.org, 
	akpm@linux-foundation.org, Jonathan.Cameron@huawei.com, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	jic23@kernel.org, bhelgaas@google.com, alistair@alistair23.me, 
	djbw@kernel.org, linux-pci@vger.kernel.org, wilfred.mallawa@wdc.com, 
	gregkh@linuxfoundation.org, alex.gaynor@gmail.com, aliceryhl@google.com, 
	benno.lossin@proton.me, boqun.feng@gmail.com, bjorn3_gh@protonmail.com, 
	tmgross@umich.edu, gary@garyguo.net, ojeda@kernel.org, 
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 5:19=E2=80=AFAM Alistair Francis <alistair23@gmail.=
com> wrote:
>
> That was kind of the goal with `SpdmState`. The issue is all of the
> drivers calling this (PCIe, NVMe, SATA and SCSI) are C drivers and
> won't be Rust for the foreseeable future. So there aren't any Rust
> users.
>
> I have improved things a lot with v5, let me know if you still want a
> Rust API. It just feels a bit silly to add one that will probably
> never be used.

I mean, it is true that we don't want dead code, but in general we
would also want more Rust callers in the future -- so I guess it
depends on that "probably" you mention, i.e. how likely it is. So
could you please elaborate? i.e. why is it that you don't expect
future Rust callers? Would the NVMe Rust driver want to use this
eventually if merged? (Cc'ing Andreas)

Cheers,
Miguel
