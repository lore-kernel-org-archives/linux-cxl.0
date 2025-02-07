Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196D71624E3
	for <linux-cxl@vger.kernel.org>; Fri,  7 Feb 2025 03:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738898293; cv=none; b=N9+nQ8em4DwkOPZgylZL/K1+baYDG+OMLJppeucXPP3UZk2nVGt8SxOzIr4mdkhRAKBGWTXP273QtTv9ZOXtrV4hshhBgIeN+aMZYfPclkoc/z7XjKd3cr7wVPBYYqNMkAyHrvILZ/WlO4zAex7d8ulaTMFl74Zp/jnwj3auKho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738898293; c=relaxed/simple;
	bh=vqL7xw8jlNr58XR+Bz0Kdoo+ACYUYOxJBFCw2VuheYI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XDXJeTBJuavoGMXBHqtSkr1wOBY7DKgaAE1hPv6sNMt0KK+ggauwxNlGIto24qIGudysnKQsC8jk4ROOstli5qP4u19cGdb0Q5gsgMqdqxDX04DZW0VsL3QCsygOFi/Vw0+6/tYddJ2A9U1z9pzY5Jc+oOuIW2ythKyZHzHzwaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=NLhQ4+Rk; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="NLhQ4+Rk"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-38dcab4b0e1so154626f8f.0
        for <linux-cxl@vger.kernel.org>; Thu, 06 Feb 2025 19:18:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1738898289; x=1739503089; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3lm/AB3lty+Hlch8L0p4a3FVB4h5zLJbB7JP8TUeaKU=;
        b=NLhQ4+RkjCkH2lbGFXbz6nQiafbFK4GaH1+tFJM1JNR5MJqdc8YNFugDkROAUi+G2T
         YsZwD4fuORjt9Moue1Zngb373d1LBMjKlo8LEYEE7ZsZ8EY2oYQ6gcok1AYZEgQNzZq5
         1N7ObEhZkh9D9vUOGSx3LPZxf9Q+DI5MZ4duU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738898289; x=1739503089;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3lm/AB3lty+Hlch8L0p4a3FVB4h5zLJbB7JP8TUeaKU=;
        b=QLBC4AKZ0bMsaYdoTQt6ssDWdIMV+vHxWQDE1yEr+BfneRzucSV3G57uk3Kc6rB4mc
         L5Z/qvGB9T7v7sGzWovAzUNBAJv9oDC6TtJTaUP7pMvbdnLShZBlmmJsn3yERNu061i3
         pPRNAD5lZG6LbBn9P5jUNou6CeSN7ZfojCZK2Dx2Nj9onHZolVTHI8cIlHvM5x0CzP2/
         tQGG5tNKfd3THUEmP62SPa4mSK8J1mLKYkR9DSyhDhR7+epAjPmlHy8YE90M/61OpacY
         dEymx6IH2gvugfddxe1NSUpx2aK2EcYuNG0M1PUS/7EXUVAeabUilg4orkZPb289R855
         wqzA==
X-Forwarded-Encrypted: i=1; AJvYcCVOgBHkwV/2L1xzjmM0mrepJHxYgapTNl1gKPCaaXsASp7+0vod5mbyPjnu7EeyRhcvN2mUu9m6i7g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9Y4sHJgMZwClSbeO1nUp0LywVqwgB8oBwCzqlAeV3zItuUpGL
	bkESUJIZ+Df/op4Br1bWFWxMnTvU9JaqReEcIfPdhpz3mEh616dPmtrmYn2B+FQ/HwW0meP/E91
	8yEX6E5dtVXCP94BORTfXSFPAtZtNY1QuN8Rb
X-Gm-Gg: ASbGnctbCnlt1r7hiQ4c7YikXhFBeOLmEB50dJGRYG53v1XN1pWWhQcPB3l0Zf8Ih4O
	VOeoCmxEWVKJ4vDj5xiuc+l7tG4A8cqzkANy2AfGBHHF7YII1U+CHdlqCiJNRl2whOadXWpzG
X-Google-Smtp-Source: AGHT+IGgbufJoZgaw1aufBoiKaHbppw2L/63RQ7Kbg9CLe7VMVFZtWxoIcfYaDn8o0UPK8J6+CyQ5pO1U8PPRBCJQyI=
X-Received: by 2002:a05:6000:4010:b0:385:faf5:eba6 with SMTP id
 ffacd0b85a97d-38dc8d9b92dmr694333f8f.1.1738898289266; Thu, 06 Feb 2025
 19:18:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0-v4-0cf4ec3b8143+4995-fwctl_jgg@nvidia.com> <10-v4-0cf4ec3b8143+4995-fwctl_jgg@nvidia.com>
 <20250206164449.52b2dfef@kernel.org>
In-Reply-To: <20250206164449.52b2dfef@kernel.org>
From: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Date: Thu, 6 Feb 2025 22:17:58 -0500
X-Gm-Features: AWEUYZnWk6trO8wL0uhorILjdXFks8iTPAcYKElY2-JZ81kkM7gTCevOLbdyxOk
Message-ID: <CACDg6nU_Dkte_GASNRpkvSSCihpg52FBqNr0KR3ud1YRvrRs3w@mail.gmail.com>
Subject: Re: [PATCH v4 10/10] bnxt: Create an auxiliary device for fwctl_bnxt
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Aron Silverton <aron.silverton@oracle.com>, 
	Dan Williams <dan.j.williams@intel.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, 
	Dave Jiang <dave.jiang@intel.com>, David Ahern <dsahern@kernel.org>, 
	Andy Gospodarek <gospo@broadcom.com>, Christoph Hellwig <hch@infradead.org>, 
	Itay Avraham <itayavr@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Leonid Bloch <lbloch@nvidia.com>, 
	Leon Romanovsky <leonro@nvidia.com>, linux-cxl@vger.kernel.org, linux-rdma@vger.kernel.org, 
	netdev@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>, 
	"Nelson, Shannon" <shannon.nelson@amd.com>, Michael Chan <michael.chan@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 6, 2025 at 7:44=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Thu,  6 Feb 2025 20:13:32 -0400 Jason Gunthorpe wrote:
> > From: Andy Gospodarek <gospo@broadcom.com>
> >
> > Signed-off-by: Andy Gospodarek <gospo@broadcom.com>
> > Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
>
> This is only needed for RDMA, why can't you make this part of bnxt_re ?

This is not just needed for RDMA, so having the aux device for fwctl
as part of the base driver is preferred.
