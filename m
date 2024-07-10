Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F421799B
	for <linux-cxl@vger.kernel.org>; Wed, 10 Jul 2024 03:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720583239; cv=none; b=dAAf0zoMvelrFGIOK9nBlPKEp5UoV/pe6IPB/X+/OlpL2wYMeE10Xgz4CHwlbN5PON+EtC0F9xqy0qLvE0eQrIMfyIuTSKqZIuHct9WOZhI/gzFpknHthJWXmQJi+jeUoEqf+eL1+SipVEqor3c9cYZPljIGlycqvCqchXHkXkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720583239; c=relaxed/simple;
	bh=uVjJszHsaGhNwDoCFzLd9swPbQBN5RaiC2yiEGKoRCs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L1LrPswtsMmxZGFmPJc5Hyd1+Rhc3Qq/t33Lhn3TiSIlwedbAXVAPvIKpUmYaSlv4GwDo1gRHq44l7TDJl1bfWz5EoxI2XE9b23J8eC67gXKRgE449tTe5t3Twysp3ek6FolJrW/emX1zhO7XX1gehPO78jxzPwg6EtIfHoJNNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j1KZY9vD; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j1KZY9vD"
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dfdb6122992so5186290276.3
        for <linux-cxl@vger.kernel.org>; Tue, 09 Jul 2024 20:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720583237; x=1721188037; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PcoTak7/frFJBuSz4cHBc4keYcAWc+GYwaHoC1nltvI=;
        b=j1KZY9vDdWZI9F5ukuenlAOPkrFTD7UWAGEgwMc1alUGxsZC5BwknqCU7RWLUtWOrW
         xncx3rMKjZEYo8rr5+KiaxA69bLMP2HN8tHUzTHDYIcopcLAy09Jg2rIuanrbhJvHw2d
         PYyNk8NHbtY7sCaES4ZoH4QHPVTugFT9N3N5EmZDwsh9+5c7Eh+PddxAn0Ltr7xIHKZX
         ZmK3z6Z2ojAIVQFR4lJkIEYoNXxqnqI9As4CP5gxuHY0Hu4IPc4yJPFwsuTMpWw+1924
         6eO0cWp0fO4ql24ZLOzQzpNMSePvhv0DEAvuevNPhZhHDU2wWQcFo86RRapDXk/cl3Ws
         4s4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720583237; x=1721188037;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PcoTak7/frFJBuSz4cHBc4keYcAWc+GYwaHoC1nltvI=;
        b=ChKXJB4D60cwIp9YUarZJpmsaUtxe0enMSTpeY9nnPV0t3k+TeB7WwzImFJ6abGis3
         QBkpGntkRFL4dFVPWAxIbIndZ/mYAZ0RqmTNYS9fyCaC799P8CB+/LibxboHm/OkSjax
         qteqzL1p6ecId8Cel8dVsyDQKzRmnOCEC+klsNkVWSdT+kuR6S6Jg9h+x3BnGbVDFWdv
         iK1Oq6wlFIkfnfBXlh8gdk1zgtBklC6QaZ77w6GwHtrBJSLtCILnFmxJprNM8PsQLwrd
         oiqUw60+fmo4x9wWcs/gJ5VilF3XI+wm3ZjOUlkh7AWff/xiOYLchbEC8CBgQOljC2u9
         dTrQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9z44GLrEdc/ji8TirLHAlKPJID/GwmopOH87XLRHZUeh844tSKy1HnilgorwUwyiAC2Tcw0lCJC8UktmUU4k1iMaQibjs0+Ec
X-Gm-Message-State: AOJu0Yy47TA+hYBQHxBJ/yzqzJCTYipxY+4EqZmcQQli6XsbVZf9ujVl
	qCmWQ1jW2W8y0+XHwr0STS0tSCE/YYLKNY+CNHjrIl0xjgIJrSZsRvgh7IfLYViqU4UaHh5fACX
	oW3NFvPPFHGxLOIkfPcAflILhXlw=
X-Google-Smtp-Source: AGHT+IHnZavWM8jpkDW4Bzzu+R4xisQ4fVi7ApODTvvvwrNnUfqOfh/acAquJ/GD+EeP3+u6ME4UKNsGUAa7tK8D730=
X-Received: by 2002:a25:9010:0:b0:e03:227c:cf98 with SMTP id
 3f1490d57ef6-e041b07daffmr4765619276.37.1720583237312; Tue, 09 Jul 2024
 20:47:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALX8JfQ1F+DJ1woPP=gFvnEyy4qHqGkN+94CKG5ONQy+L3C5_A@mail.gmail.com>
 <668c877f86daf_102cc2941b@dwillia2-xfh.jf.intel.com.notmuch>
 <ZozTTpbMjff82vO0@infradead.org> <CALX8JfQwCFsF4AvCwiui_7J08j41jJiSTLMVCQTx++EseguEdg@mail.gmail.com>
 <ZozoWwm2v246szTu@infradead.org> <CALX8JfS5kpY4P0r3QUmDxwoST=d3yR8gzmxK6NSyXr6bRiBo7g@mail.gmail.com>
 <668d8becca6cf_102cc294a3@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <668d8becca6cf_102cc294a3@dwillia2-xfh.jf.intel.com.notmuch>
From: Yee Li <seven.yi.lee@gmail.com>
Date: Wed, 10 Jul 2024 11:46:41 +0800
Message-ID: <CALX8JfQMfTcjoip6+2-2rZG-UY_QFCDFG6EqWZ7jvcoyWtwwiQ@mail.gmail.com>
Subject: Re: Is there any plan to support CXL GPF in Linux
To: Dan Williams <dan.j.williams@intel.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-cxl@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dan Williams <dan.j.williams@intel.com> =E4=BA=8E2024=E5=B9=B47=E6=9C=8810=
=E6=97=A5=E5=91=A8=E4=B8=89 03:13=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi Yee, please refrain from top-posting [1]
>
> [1]: https://subspace.kernel.org/etiquette.html

Sorry, I will carefully read the mailing list etiquette.

> The Persistent CPU Caches flag is a performance optimization to avoid
> CPU cache flushing when the platform is trusted to take care of cache
> flushing at power-loss.
>
> Software can force "persistent caches" behavior by:
>
>     echo 0 > /sys/block/pmem0/dax/write_cache
>
> From a kernel developer perspective, I feel more comfortable with
> userspace making that "go fast at the risk of data-loss" decision. Maybe
> after the industry gets more experience with platforms that set that bit
> the kernel can default to trusting it, but given the slow roll out of
> CXL PMEM devices I think Linux is ok to take a "wait and see" attitude.
> At a minimum, if someone wants to draft a patch, it should be a build
> time configuration option to trust the FADT.

You are correct, exporting the dax flush to userspace is a comfortable
and safe method before we can trust the FADT flags.
Many thanks for your replying.
