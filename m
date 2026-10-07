Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370CC492196
	for <linux-cxl@vger.kernel.org>; Wed,  7 Oct 2026 12:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791377385; cv=pass; b=VQMLNGWi0XtFy+z7lkzJCoYTTr+iOEMQZpdKMLDSIrez55O0zjqtGNH8U8lgPBuCvc/SAMKWVOS533atqOpqZJYfduyTZvI31E9RZftriJe3xGUKlSSHjepUk5+1ERK+5tE+1XIohjslyejPhuTJoZzjg3+WCSgSmYvH4fD+bvs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791377385; c=relaxed/simple;
	bh=mAgXxfJyyCw2IfTJGYnt6Q3vjMyFJUM/9cY0xhm0WzY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MkOohUVPcKfOMHbsZt9Mp/oqtNlB9O5wtYg4qEuSq8T7VijINyVXMjvOYqUCvZ1oLUtFJkICqE0PrMf6wIm9K9Kj+x6MrX1hdUaI7XzcwcJGE76Vd5yoM9+efu/XZb6iUGhxbUBMHGMfp0bvbzB5/9Ttoglel6N1jNRTpwKR0Ok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=LC4GZTAB; arc=pass smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="LC4GZTAB"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-533861a59b8so45983281cf.1
        for <linux-cxl@vger.kernel.org>; Wed, 07 Oct 2026 05:49:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791377377; cv=none;
        d=google.com; s=arc-20260327;
        b=sWWjRo1cISciRwxb7Lxot15PG58UzuhhJyEltbv6hYYkmJIFd68O12Dz54DPP1I86a
         39Pxhu5F2Nyx1xXJP9eIpPH0kOdgvBuPR52ffXRYY4l/UnxSrcR70iaKClr1iNdL8tkc
         PmYgz2PsK6/VLpxcJcug20bxTwR/dS2wccdTkbK2+QXGHW79iN3fDk5gL5yrlGS515jB
         DOrFT060Eb7JHQj4DNlm4SHsy9Y3HmsAib6WHlEhxBBVURNkMxX8hKOM8tC0PhsI+gDw
         uiVoe2cMdyBbCq1NuNDEVJSUuXMLG21w6iG3Loi0eNo6bE7/0KPenzwbKlb5aoEuyXl8
         Sk0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=uxDzaT2//lTPxw9qRyuCA3FIYAYiZrpJTXv/2HtipC4=;
        fh=HSK3j690JpqnM6aORsxvMWhExeR640/flhEOLMtyTZY=;
        b=iuJCEpZrtJGcflnOsK8tp0JTnFdCOd/+H5xED3lov6WI+VMQ/i6EheHIh96kStrDg8
         0wc26eJXYX9L0OkqI+g4xznMp9vh3vcVf7X1kQ1au/EWrHHjba0XeotU0tVPN29NPJCQ
         WFYiWvdxTxbJlaf8qfw8BgdNrdqpKolFms6k9TqA7JC4lb+2f2KRKv/81avn/GoY3Qzn
         XEEFJPfQhXoSDj9YSnpnyx+mc5guI+tTq4y5S3vT6iISACxQ6rF7dPZiQXpTyqeiN7bM
         op73zo2dSjN2aCsOA4a9VTq/ZHGyCXDbN+Psn/6N5PlxJw//Mz7wp9VAWw49riKps4q9
         UqPA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1791377377; x=1791982177; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uxDzaT2//lTPxw9qRyuCA3FIYAYiZrpJTXv/2HtipC4=;
        b=LC4GZTABfYy+YaQVS8j8fBt4rralmikO/MJ/FqrDPyvYQN4SP7+zD9XgkqXHZMXEvW
         WzyHyucjreBAYmI9oNYKBSS8dBeTCX6KUbrxNiDbSE5cb7w0osKQtpSMl/S84vSRCL2m
         VHHgwAB0efqD47bvTuYdWmYO1CrgsZFfFgrbA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791377377; x=1791982177;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=uxDzaT2//lTPxw9qRyuCA3FIYAYiZrpJTXv/2HtipC4=;
        b=vB5PBu42BkQyoqm9Rc0wzW+yR/5PP0Y7xxM3Ri9HQHRM/AWwaJsiyyRcPJcCM8qx+7
         WjgbSX0hw79I6OOOP/ZrLcXaRgqW0+BvFiWLWPQEFH8gMrfJI9nfKSL8bD6kgZJejfY0
         TWtA8rYOl6W75Y3daMnyXnDvV5ttyJUVPtxRZqNNjKP7WimFyTXUGKv5jluNAOpj0cf5
         qzWOmw5Z6I5J0wBw6nek2j3sU90rFfUbMEAVw++wNl+NHGyx+w1gC+azF0JZsmZ3djRZ
         Q0HLg5qVmrZmOmPVDG0FXc5EoJo7ojWYif6ZvPBU9URXOsavT7yzRBZ5fmSq4O469zLG
         UAKQ==
X-Forwarded-Encrypted: i=1; AKwUvByw/5treJqyDXg1WwTry6yPesmO0cPMYH5RsVxXJ0TEyOiZXFWRprn//SrEA6niPO+bCSyhb0TRj0s=@vger.kernel.org
X-Gm-Message-State: AFuF++nzaaJ/R52nGDYw4jM2DiiAWMulKCX/qORZD+23CkVYfVKfIXZr
	4LS8gTvUcHCfLFwq8RIvL1u0gooBhoO16Q5Uc3/PwsNyrdsL9P0fcvmEJSdMI+SSV/SJwf5OGxG
	F9tMUu8azJguiTJ0Xq2LOtexi3slOViaz0fcN8LHq6A==
X-Gm-Gg: AYBFou1cGVrjfd2JQmjSn9XYweL05bz4Duspvi9fCh50FYU4QKa+gWZeskbUC3b2NGk
	Lj5Q2pILU96PAgq/+QLHWpsZVVGuMSy5bnJDr3+06d8ObtVHOsWz+TPbA39T3pGqEBEWe9XkdRv
	njxw0DxGN9VersejgbR5kSs9CkzPQL9v7wQeSF3ubrbuN0HLaPpOYtagxT89lRZIXVOCKJrwwPY
	FHnp7dnCkxoQXkCQehfVibalp9GGEs4sw4vHLE5nM7/mzh9m8coh+C6dGvJ7tsmw91Y95KqAI68
	CR9Yg9BCA46CHM1/wutSN4jjMgr+TGwWCosLkySRYJEWSntqL3SIZYMJcer7MSudXY/DLeV23U9
	XtNH3cASN+Gpw
X-Received: by 2002:a05:622a:3d1:b0:532:c947:6e49 with SMTP id
 d75a77b69052e-5357556ee8dmr37063011cf.59.1791377377065; Wed, 07 Oct 2026
 05:49:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261006180115.1425232-1-mszeredi@redhat.com> <20261006180115.1425232-5-mszeredi@redhat.com>
 <6501a22c-f484-43d4-b109-5d8021cc3dc4@app.fastmail.com>
In-Reply-To: <6501a22c-f484-43d4-b109-5d8021cc3dc4@app.fastmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 7 Oct 2026 14:49:25 +0200
X-Gm-Features: AclHuK_YHztya3DDjK3LgyU2Etjp1vNeeb0RFji1-VAcGP52Hh_NQ1Uorppslkg
Message-ID: <CAJfpegsvnzcq==FHM1DRmr6LaA2daC4_NT05Qy-174O7oc2jxQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/9] fuse: support 64 bit, server allocated backing ID
To: John Groves <john@groves.net>
Cc: Miklos Szeredi <mszeredi@redhat.com>, fuse-devel@lists.linux.dev, 
	Amir Goldstein <amir73il@gmail.com>, "Darrick J . Wong" <djwong@kernel.org>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Alison Schofield <alison.schofield@intel.com>, nvdimm@lists.linux.dev, 
	linux-cxl@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 6 Oct 2026 at 22:12, John Groves <john@groves.net> wrote:

> This doesn't build with CONFIG_FUSE=m. Maybe do something like this?

I'll just add EXPORT_SYMBOL(fdget_raw).   There's no reason to not
export this if fget_raw() is exported.

Thanks,
Miklos
