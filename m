Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBFA84A8FE6
	for <linux-cxl@vger.kernel.org>; Wed,  7 Oct 2026 12:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791377697; cv=pass; b=WXiotaOJFUaLdOPCQd5N3qR4gbN179sU/HSYCYZNUBxd4/chhXxt+L3KWLUJOXEaI1GmWSnBNn1bu7kaTACmHZivnzcmxn/PkTpnUE8jne/mKt+wxL/KVdbRTTViBcNquWK7OEMKK0/NvzRxO30IIgNBynMdgyjUf9xTsirx5EE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791377697; c=relaxed/simple;
	bh=mZxD1Ygf+pj4Ki80fWTjetLEhLjuY+js/KB32uhXOlw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T9Y4Pk4FyjsO44qLEgpHSag4psEJvh1m3J9Y9tmJZo9St1eIDRifMRkdKYuXNUoLjcW/gqck5ZrzKynVoDG5voBow2CBz3LzVb/ySNQY0hAhRXvxM2Fu5CAJ1mkSEH44vT6xEQ0IWonwsvi9KRPpMDuAVlEWxTyZxKqLLlqUUUI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=ZTOizfrE; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="ZTOizfrE"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-5339381b46eso14989961cf.1
        for <linux-cxl@vger.kernel.org>; Wed, 07 Oct 2026 05:54:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791377687; cv=none;
        d=google.com; s=arc-20260327;
        b=Gs/SV369DEmhJ7mBn/9B2Tti4oJpNwM+3qK1JZDLRAfiYGL6CmRCLXcR/5gfspPCdN
         tbcJ+INwwJikM4OKd/1149ZgqSpVX1cAFV0VhY/t6OQ67Ffq9RFHI5CFbpvp+z+T/lOs
         qEeRbW2FiN6H996j8Lke3zXZ/oyIcEWTeF9V1oITQqRFTIgj6aIP+j+7VcS4iTG+hGCV
         RbPSydJkvCaYi2+DNwMeO2jvzUOOagbkt/I7zNb44ql3U+7zOTpjeAExzLX03oMySNkk
         R6x9HboE1VYVHToElrCFAddM3bvoMb7MO1JgTb50PWgj2CIZUUOmiYIWTcWW8+X91YXg
         NWpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=PgzrrYK6etiYHLS8TerK5hAVSfusAUIu6hnQPEz0+jc=;
        fh=/5MREp33QOAPECxX9IP096DG8ipOcplkQqwA2mshO8g=;
        b=SQIOnh5UAdkK/rEKpXRtE7LdGgQvaldyouWsRpTurhx+j/3Y7HfIheXfATpCh0ROmT
         ZGJfP5RpZi4gctvZ32Yj5qHovvHw9NBRXh24c6FmFknJS2kji8p/cTRNzMpn9SLG+K1t
         UsAjVqyKOvjR33kCQGJW2v69xghr7mSj1WGMNpWsy7rR/QXx2ubq/QSRFDmgsrmC5Dl5
         2elrcEcJQCkhdLCs8cJE1qbLlJ4iUNAOWsAtVXkfxjag5aWDThsR3JzCVWXPZmOVfz5I
         Zr3fxosBumYAf3TKRB18HuNjdiId3pINZnbKHLxd4sIuAs3rN3K1T+XwX9OM0/Ky+Hqj
         Fs5A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1791377687; x=1791982487; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PgzrrYK6etiYHLS8TerK5hAVSfusAUIu6hnQPEz0+jc=;
        b=ZTOizfrEPV7Mlhn0oqYT/MxGRGhZIaSpC1Y1eIHgTffxaCN9OFx+1LcmzIKbOh5S6m
         z1/912MM1e468Roq4TozOYYPM9etHGGcQg7c2X4TSJ74VZRYYQymEITfbwedGO6ZXO+g
         dEpzE6dZVOOas9BblwmfY/+91hIJtHjfTlG+g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791377687; x=1791982487;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=PgzrrYK6etiYHLS8TerK5hAVSfusAUIu6hnQPEz0+jc=;
        b=db6GwfB8ncUM8vqUVvFZqXe61KOQkVmFT+6g7nD3qk8FGFSmEuj8Wkdj89DfBmN9XC
         3v+rpl53ELIH4/OJrMaFOYhYTU4NbacrHwK5uAGbY0GwO/Y0SiZVYJ6Biz+KaO2sHXuN
         pBJcGiN0GXtwLhK+adYGrb4GMfSy8HxvmitdcxnHZkGpQPBq/nS2cTwt1T5R6ZqgL8l1
         C7n/ftNASwl9sInB8wBqpGWtN/fPkE2J2jturvZW/oOHTV/NeS5q8mdYoRaoKAyP9xRu
         aUuq8zaaEpIQ587mWHkDq6Spg/O77KrjzJ2y5rREZ8bPD1cnNJ1a+O1Z/inktKo3Www1
         TNjw==
X-Forwarded-Encrypted: i=1; AKwUvBy2pdBnQG6nbQYjCeURg27UREJLDnC5aG/axrKGi1bWU8JZQ+OADM46QIQCzVLcj0bsqBZY5HeipK0=@vger.kernel.org
X-Gm-Message-State: AFuF++kjQsMdT32FLIV6EXtpTaAMmk2514EaL79MryH7Lh/OTxLorct3
	m1ZiS2wOhbTXQBW6jgBwLH5HQYgulj9D7UQADa9Ts7Ua4BkZg23cmT+qUXik605qBkQHNp5H4vM
	yfLT9QaaHXFLxftx0NAmPY/2fihjdteKaRIk0oBXZug==
X-Gm-Gg: AYBFou3Wj6+gVUoyRbRFLZkwPN/ntaDUJ3jX2LVst69Obvy+uHlc3SBn48+tPHhiWF9
	SLHg6TDjQApjzd8hK9EI3Wiuz3uOmSMJKpdgiBjfSTk9kyLYG4drbJwZueIkhFLcVkW+eKy3mQ8
	X03q/a7+7c7WJm2svXpJq+CxzYvBT131bdCbhXHiAWrQcpswCyUUhxeRi6hhIXr89RlgxU+zGvd
	d+qJOv4R6IA2FAeduLZpTET8C/FMJQIKXlzaFjWkEXq4tLPsFTNnnkRiTjZAgPb+UAM1ovBeAxN
	aciFQpt8yWXQ00ma8xwno61JJ8FAn83vmLF1wNjZiJlTCMJUuplJAluxdmv5u9Al97pc58zIP/d
	YhHetGPsGBULi
X-Received: by 2002:a05:622a:955:10b0:535:863a:7cd5 with SMTP id
 d75a77b69052e-535863a7d68mr329801cf.41.1791377687608; Wed, 07 Oct 2026
 05:54:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261006180115.1425232-1-mszeredi@redhat.com> <20261006180115.1425232-5-mszeredi@redhat.com>
 <CAOQ4uxjRAgNKEKOj3yrh0fp_uBdQ-G=5C55G6M8vyjWgp2zvoA@mail.gmail.com>
In-Reply-To: <CAOQ4uxjRAgNKEKOj3yrh0fp_uBdQ-G=5C55G6M8vyjWgp2zvoA@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 7 Oct 2026 14:54:35 +0200
X-Gm-Features: AclHuK-2JR3jF5vhr6-2N836D1tWhMAXJTWcwxFUH5uC3YviT4HdxQEL0a7ZY6w
Message-ID: <CAJfpegsK3ydDW4Hy+yKxxnHsx7nPSSuC1aqOnOPjkD=g33jY_A@mail.gmail.com>
Subject: Re: [PATCH v3 4/9] fuse: support 64 bit, server allocated backing ID
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <mszeredi@redhat.com>, fuse-devel@lists.linux.dev, 
	John Groves <john@groves.net>, "Darrick J . Wong" <djwong@kernel.org>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Alison Schofield <alison.schofield@intel.com>, nvdimm@lists.linux.dev, 
	linux-cxl@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 7 Oct 2026 at 00:12, Amir Goldstein <amir73il@gmail.com> wrote:

> #define FUSE_PASSTROUGH_PARAMS(max_backing_stack_depth, flags) \
>              ((max_backing_stack_depth & 0xff) + 1) | ((flags & 0xff) << 8)

I don't think that beast belongs in a public header.   That alone is a
reason not to go this way.

> It also avoid the unneeded questions/documentation/awkwardness
> regarding FUSE_PASSTHROUGH_V2 with/out FUSE_PASSTHROUGH

"If FUSE_PASSTHROUGH_V2 is set, FUSE_PASSTHROUGH is ignored"

Thanks,
Miklos
