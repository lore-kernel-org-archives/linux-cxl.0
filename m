Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048F73A4F22
	for <linux-cxl@vger.kernel.org>; Tue, 31 Mar 2026 10:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774951877; cv=pass; b=FHMdbRA0LsNu3ktSTexb1qhidxfJNwh8IYEVj0V0pApXGS07CGBFxZPfxJ5uha2L15xPTTu8lJeHWKAiUpwkVRJ6Kom8DRBGPSMwpcjHw9JyriAO3FDxoXg3yV4tn8plzKsNvtjsvtX9ykWxPvz46XFFK4Vr/rWHnt2BvNf2vmc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774951877; c=relaxed/simple;
	bh=BuB9OAdchbjZ2fJnCBi8+LXdUDK8kDhBZoLPIaO+/7o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jgWuRjkooqnwOD+k/JChz0mquhlDe3G5hTUooqLRfcpxAB4AAOgvE0ZiBHDzTx3sDooWhxVnAhydR6A19hSgqZs2vBT2TA7pl2OTL6naIu/d5WmFzBmRsE/n8a5V2Ap+saYSVlHfQLPzTHsjuTnvnV/ejNkgDHgTtSbpOQwAeng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gLPAX4bZ; arc=pass smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gLPAX4bZ"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-127148c2112so441846c88.3
        for <linux-cxl@vger.kernel.org>; Tue, 31 Mar 2026 03:11:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774951875; cv=none;
        d=google.com; s=arc-20240605;
        b=LifN6UDwSzbOyLKaXTubffyiVB7CGpE8LRDxAY02D5jaIafqcedAQhwVTYFzklWode
         G2c8NnkXw+ZPBkhwNOFNqyek+m4Qu6toaVEv/Lz7KLXvPzQ6c2qaSSgDVAan+lhQgwD6
         3AMPOPPT0U61GZ52Fzb0pXzUr/xpPyxT2bOmf87kqCa/GyRq8uP883q/fvXnsdtF9wD9
         1ackTdO+blvS+P1zoUw/K43Ut1SkpQzFr0HGA2aEDfC+nDDugTnYqmnkH6BHFrh9XEns
         BxZgVPHAuCLxdBIg7LkuIYrSelTe65rsX3MMrC7p0tynIUOxmEMgtVN9N1waJPPdKsad
         W1xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BuB9OAdchbjZ2fJnCBi8+LXdUDK8kDhBZoLPIaO+/7o=;
        fh=/4SWhv3cUmbXbGyiCn+lZ+pdDLFTQFB28DhrU/yH580=;
        b=FevdisC+xzZaNvjzItLH1wJpV72F8Ngs7SYDFbd3GQ0d8Sgel7/OeL7SfWYrvhDf0H
         F2DxOcxYjPEO6a04HPEVgadYUZuET3cNRMfQjgZ+bCtXV/M90eIYngTRGNRpwQ24Z/av
         IdovlbRKeP1XXGzPi5UM7Ru8uHJWmwhUmJ+q1cKYQ0gW559prpit+r0xGFIMKd12nJd/
         dZglS4yaOlntwwiYgBGQEEjYVUDZZ3pLOEfaY0LNQzr2nAtqKRo5N77LQ9tUJg58Bj33
         +9VSKHhi6afDCsJtyfujhKaKb4/EJSYuHAs6mdnqaWBQmxJOY4g9Rqnu9RuEkTAaciLX
         Sdsw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774951875; x=1775556675; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BuB9OAdchbjZ2fJnCBi8+LXdUDK8kDhBZoLPIaO+/7o=;
        b=gLPAX4bZLbFDe3BIjvh5WgrKtT0qiVHFwz77EYihWbT+/wS88EkaOi/k9qahFqDuuy
         +/lG8jZqDIRN1FLDJKrp3gwNmxeI/YuhDW3ZDQEaqGHNnZC+rV5xPMfXl1ERodmAPrmt
         wzXyZKtRY4IibVuRmGYKAFbGKxSVYVo/3DfCA/rPYisZPFgB6A0AbpmUvjO6+teO32zK
         91vhUc4uH5zxJP+vtaudDq5bRBG0CRsHV085wicgYmOi+R1AuBBxT34kRcVgkpCown1V
         psxK+v/3/BDxFMMpsuPhfVW/WDNsp8Z0SQIFg9vyc/VeeiVfNv/fOv29JbZen0cNP7xO
         3iEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774951875; x=1775556675;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BuB9OAdchbjZ2fJnCBi8+LXdUDK8kDhBZoLPIaO+/7o=;
        b=d3CTOQzceTReImTY+P7nbXu9tKd61IwFvY35XUKJ/i2BBom9WSI53cs9y2hXueVY7u
         JdySfKpfUXhDj9tGLRsbc97Ylv6cR6oa3HUIC8dKq/A4Tk/Lq9gIumhVLpxqaEVL7+ip
         6n1P9u0faxlPl4uDyL5qpeYanQeLlTrq4EdGrP/nre8wmRRGakFaS4aWT/rWDv10MAIu
         Tw0AMBtaEKiLN7euOWV0RFiWJE79Cw6rzMwnVRUX65zBywlSefNBcbrCIpmVywehZdfO
         MZYzXiQT4C0s/IQ+1n1MQrOXo7SKBvRBKiClF8zaN5ZGA4q1WvDLPRuvpGQI73q+F7/M
         X2Gg==
X-Forwarded-Encrypted: i=1; AJvYcCW1r7aw4NbIcTqrrHF9WLRDe1xohd/e3kZoMUgRXk4WOx019O/Iz+yJm44Ksy5RuUde9LdILRUC4ns=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj7vC2daqHjggrk/1+yLDRueN26QjNXYon2QGfk7Aw0Tk5UbFr
	sJD+LmZrW7ioCa8cxKzDutbdw0gKIB5SAK7wmlUAC4fXh/x/Htz9dyJEs4F9iuWFZ3YJfTKU70C
	/r0hGKT6yTofS3DKpAW0c/MQUstBCcQI=
X-Gm-Gg: ATEYQzzodwuWDy47nKMiOjCgfioQHI+1Q4kbP8MxmTRDI8D0sKZT1V2TgLX9zwp21Dy
	wJu2SqWI2zSjS1QV5whsq/FbIk2T5LG8cHvSt68+hVH8+WOPD1oR/Kbl6j7fg2TljYvuveyYbc3
	aP+ySP2pXHpxuqBsVThIGEADq/CWPdyj39oZcg6CzdmZMNlAhvRc5TLvHzm0npLciWIrZWxoiSz
	E84WHbPQCeVoe99Tou5BVuzvxzRmQWgD4KKd6fI4LE67bEXtb+QqRBQ9me1o1VYqqr9JY60nhtl
	R7Ba+vnVHNlTN2kGx8kf27GcqsmkbXFiVzz9Y416c3Tm2Z2kq5r7gY4SyULyR984fjLkDEo825P
	YLxURbHSL6+inxJ5Tg9SB3tM=
X-Received: by 2002:a05:693c:3008:b0:2be:298c:a11 with SMTP id
 5a478bee46e88-2c185edf989mr4029939eec.3.1774951874996; Tue, 31 Mar 2026
 03:11:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260211032935.2705841-1-alistair.francis@wdc.com>
 <20260211032935.2705841-23-alistair.francis@wdc.com> <20260303150040.00007458@huawei.com>
 <CAKmqyKM6CBucDEo0aKZVWrKtozbT_ddk0PaZFtHyEMMMx558JA@mail.gmail.com>
In-Reply-To: <CAKmqyKM6CBucDEo0aKZVWrKtozbT_ddk0PaZFtHyEMMMx558JA@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 31 Mar 2026 12:11:02 +0200
X-Gm-Features: AQROBzDcDwr7GVEqtGjVwGa12fqkwc3LQ0Ho8hFkYoop4Cj9bvScGclhoV9SimU
Message-ID: <CANiq72nOt1E8=GYdh2T5BWNvG7J8sZRF+60taghoxKm8fkadHg@mail.gmail.com>
Subject: Re: [RFC v3 22/27] lib: rspdm: Support SPDM certificate validation
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

On Tue, Mar 31, 2026 at 5:30=E2=80=AFAM Alistair Francis <alistair23@gmail.=
com> wrote:
>
> Yep, same thing. My way is the Rust-y way to do it

Hmm... In what way? I would say it is the other way around.

Clippy should be flagging this, too.

Cheers,
Miguel
