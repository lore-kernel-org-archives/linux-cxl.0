Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.179
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792667624;
	b=B9m/WD/CKJoMCE2BCfnVELsVEFMHqbUwzhxy6PR2YWll/8mYoe+S1AHYV0xD7o2ekosh
	 s8VGwBXtib5v/ePIlQfiEVAsdvPbNysYj15tNqsNzm0PQrcu0rX183NX3fPw1q79x5Cws
	 svYS0axstlHIwsBIOI0e1OaJXV6I4b5GTPuBt213XZUztEv8HOoKzMssa8cvy5qFm+Vd9
	 VLfiedSFNppX1C5lHFe/E3lrpg2Sl17NgIXfZBUvedGm1jmiriaWkK0m3nnHJA26Y7FJO
	 kerXUcjRe6Ddt5TPUfs7HjMHoAORByXf18yjJBZEEr7KEctKOagS1dhNxxqeJFe9fqw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792667624;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=R8rZRziw5q/fRuMqRbAHHvpJXFcm/wFSyNjqHk2EOSU=;
	b=5H9JWu6hu3lW0HMuo7GZ5rkvG2ZudcTHwD6ltkXGseqEt4tke/5Znf/Etd0vaWE3po6R
	 mtIzL1Gy+LEyiKMGrxZbLqv3tYHaJl+mxyF7POyyTDqAumcP/epIUCY+4S8Vdedbbi0kl
	 edzGQyvpGhnhhrmjsINYU1fO/nIiVWyH79VAwVJVkuic/Cbo0q2on3ug42+ekddzpahD7
	 1ZG8liOuFt/fd53akWOHciWb/v+P6u7SXm918MkJUShimK373lsL0TZW6q6MTKCluH9ov
	 YESEVZQIgz0XhfM5VaW28evEkMWe88wtufOWySQ9VFN8+pdAVShhLo682IpG37W4Umw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XzcsCzOK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90557606A31D
	for <linux-cxl@vger.kernel.org>; Thu, 22 Oct 2026 11:13:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90557606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XzcsCzOK
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-360236b6c3cso183392eec.2
        for <linux-cxl@vger.kernel.org>; Thu, 22 Oct 2026 04:13:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792667624; cv=none;
        d=google.com; s=arc-20260327;
        b=WbjwZF+WCJLpa3wrGutCeOUWgsba3Fj+D5NowkUQieZpKlw4zCPF3x/Tes64QE5tRR
         YZH22PLvCj0oQg6iM69jhCBOkO9/So6H631usir1LgIbGy0IvYk777eq90sKQfFSnVR0
         u8lBOpv/uDgQNfI4WgZD7pxL4MCyQIRybFASPbVK3Du05TI4GAXGejzVEdL6mvjj8qTl
         D3yjDBl+LpBnzAfrm4wclocAOgKLkHfRCSgAK0IVlVDCHOA2DleP9wTT9Pdf74bOmsih
         hVgDD5ufkEGxOw2q9vP1EqjnnDzm0aM+eNPDPmjgMNGIuJzlMOdLN2yELUEuR16YqumR
         d7IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=R8rZRziw5q/fRuMqRbAHHvpJXFcm/wFSyNjqHk2EOSU=;
        fh=xe6szICIZGEGENHBqynk4HwKcsAOOjxYgXwJ4Y97NEU=;
        b=WpTBDD0aMjCx0bHoL+LIUt0soKnHi8J71k7LS2Psfoou7BomCmAM1zH/ZEmpdEG8e2
         nFwt3jfhj+r9Pi92bW+e7PhBV7R/VGK80B1hPd5gF3Yv10wf0LW+THmsu5KBocx2GN/0
         wBB2zCHqR2TuQwLa7UZjTgmdS9IJWrs3vwpCDqZRPgOf4LMhcgo8c+7jPFmDmFxjffBO
         k5wJZ1YS9dPepbmCt7rqhWjui37IBfMTwU+60vf12V3gAGJ14g1UdhUnUJexEYYSHw5Z
         igBf4kabeFrn3HuQlFDKIlvHqZrSEuAAoeeyUJRg1X+nCYzsJN5ubSzhEtzoMA5rIDSI
         HoCA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792667624; x=1793272424; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=R8rZRziw5q/fRuMqRbAHHvpJXFcm/wFSyNjqHk2EOSU=;
        b=XzcsCzOKIM1dH7X3ne5kpMLOkyW/kS/lF37y0oepZqm1lgSq0khIYNbARTOd93oqMU
         TfXjKrpV5RZBx81RtZXBePBatu/+IAWU3v4339o0MHOYOStsXtZ1gZg+ftfhrJJ97o9X
         jqknYd4gvq1/exI/EqLx798hDLeSye599FMXrfnHhM0GvQ2yXwCcnFwSF9N9+LTzHkyh
         vFCD63AmEY3JMAQwK+XD8g1FJcFNszVqG2czhj24/nSh5TVzQtFFLGhnadtrjVjEoHGV
         b5OBD27hWUq70n97TAknRmxcqTPS8aubwZjUdzwNgjSOnK0TLvQ6uQ6EHWUf7qS8H1w3
         NK9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792667624; x=1793272424;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=R8rZRziw5q/fRuMqRbAHHvpJXFcm/wFSyNjqHk2EOSU=;
        b=M956KX3g/Pzs2srNKL/yGs2CVe7pNYitH0RNheLFMfhAm7EFvRjoA18fJj/zeEAn7q
         j9Ihn6cH5xhUavqQ8CdvuBv5gWHwepMIcFBGUeCs2aJqcQMLXAnhI8D2dhmcaJDMRi6K
         iU0oms8mxdQJIVCBoAVXmdeIBk91lID6M0253eEaqLIJ/+7fZlQvJ0dQJsxiQ4I3+J8T
         oY0CiYkXo8ItVkobBeUGLuaC1oArBf2R/O8ev6tAuau55tSNUs6ArDei2yxU0iwcrvwi
         0mlntAv/eZb0Ge/LLwACzUoml0aq9m9ZK03PFAUbf7tr/ntB4enC4dvNxW2Wp2jbUn4r
         qxcg==
X-Forwarded-Encrypted: i=1; AKwUvBw/1b8HlLCTwW5/zHV9eVM/bqMmJADRV0Kk6wftHqfHqLwm7VOp+wCgZmhyox7yI71Pijf6oQ8Sics=@vger.kernel.org
X-Gm-Message-State: AFq9FYKfnGq1Rqx97zn5RJOjtQJt/7M1GkEKO8uzpvNzIeviSsGK3i/9
	HgvY2rxClwIFupigXbLHij3d/rPUazoWUgSR7Jw1t8hD1vL7UPgIp3wRh1H7GJpucrjtZqC/26C
	cYv9myqCcIeUd3DGAKg3UfOhQYtMHdzs=
X-Gm-Gg: AYBFou2Q+o5EgWN1JO79dJMROdxPKAI4UIbvoIfvbPsWKmcMF01K3dh9EFBR1IBYNai
	YKKeKWzxowkJhpvoNSnt4PtcH2EzQqWB/E02lzUU1SCsTGODj/WXUv5eG3hUweRZ6ncJrBOxjLU
	PdA08ou6iqQnAvFv4gGhQ6wzq8rzN3D+ERaCfpmcEzBK/bmC1DATfBPiZsHoQU0Wmrxwwag9TcU
	yvOJKz0TthriN745cdAwB+t/ZELP9UNskyLoZKOXJh/MT1z8C6ZMdRnEysTThfeu54u3Dfqylgf
	sv4NTCqGKDhn6hS6q6GA1Df+SwA8vRXgXpoQFCOETtrfktwdm3vAoJaQBWsHgwnpMHke2QwPfbU
	6ErwPIKsULVZuJ3P1OpEHL8RjfmHXQYWUtdVN5gz3PDOvWW3AmcXTnr01BWQMzkHzs8eCmC1Yl2
	Zm/CdvZ0GR+z2JWlnvKhr4MlEraGyOUAsnuQHVwFWAcR+LoOeV8S3+6qAM65aloAwqzdMpuEDwf
	UWglIgDV19gYyFCufWYNsBx9bX97yqBQhX0
X-Received: by 2002:a05:693c:42d6:b0:368:5521:612f with SMTP id
 5a478bee46e88-3685522022emr5207256eec.0.1792667623553; Thu, 22 Oct 2026
 04:13:43 -0700 (PDT)
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
 <as_r8n7p_wdbChuQ@google.com> <CAKmqyKOkmwompJqaP2k-oJicmXmqHY4E0wuLcrvkHLx+oauQ2Q@mail.gmail.com>
 <DM596TT7E841.1U05OKY9N6I6C@nvidia.com> <CAKmqyKMbs_N6C8MAKGUU11DW1y5nJRWPqnUcrVZoyi0SDjsv3g@mail.gmail.com>
In-Reply-To: <CAKmqyKMbs_N6C8MAKGUU11DW1y5nJRWPqnUcrVZoyi0SDjsv3g@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 22 Oct 2026 13:13:30 +0200
X-Gm-Features: AclHuK8IRxRyOadDqQczFV7IA6tccuepCRvhA3-QGnHUz-1woYEjtN6EKSEPPVw
Message-ID: <CANiq72kWv2HHniM3HXM=DkTbaNWSHsqfA_dKQNihfAdmA_sgnQ@mail.gmail.com>
Subject: Re: [PATCH v4 00/22] lib: Rust implementation of SPDM
To: Alistair Francis <alistair23@gmail.com>
Cc: Alexandre Courbot <acourbot@nvidia.com>, Alice Ryhl <aliceryhl@google.com>, lukas@wunner.de, 
	linux-cxl@vger.kernel.org, akpm@linux-foundation.org, 
	Jonathan.Cameron@huawei.com, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jic23@kernel.org, bhelgaas@google.com, 
	alistair@alistair23.me, djbw@kernel.org, linux-pci@vger.kernel.org, 
	wilfred.mallawa@wdc.com, a.hindborg@kernel.org, gregkh@linuxfoundation.org, 
	alex.gaynor@gmail.com, benno.lossin@proton.me, boqun.feng@gmail.com, 
	bjorn3_gh@protonmail.com, tmgross@umich.edu, gary@garyguo.net, 
	ojeda@kernel.org, Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 22, 2026 at 6:34=E2=80=AFAM Alistair Francis <alistair23@gmail.=
com> wrote:
>
> Oh! That is a great idea. I have added that locally and it's pretty
> nice. I'll tidy it up a bit more and then send a v5

Yeah, to clarify, abstractions do not need to be complete. In fact,
they should only cover whatever you as a user need, since the kernel
does not want dead code anyway.

In general, though, we also avoid adding them locally and we involve
the subsystem maintainers etc.

Cheers,
Miguel
