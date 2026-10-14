Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08E54DDB41
	for <linux-cxl@vger.kernel.org>; Wed, 14 Oct 2026 09:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791970850; cv=pass; b=Q9GWxTCsioA5Ivn3QWqn5Du/VB3L87wIm0IENgV11NSaHKGJdZIHNM+E/Id72byhpaZD42JCRTvzePrYFdCBSkehdi3qLcBMTLCWxfKTqVElA8sWxYqyfLQU633xc5PzOPmO817vuWodW/lNKTLXtpeWLcX5B+pz46FHl2zU7AM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791970850; c=relaxed/simple;
	bh=9/reRJ/j1yO6b6rjpq4fLoYRPvxibxm3mLaZMWghcMU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B3xfK9c4X5CvTv0u/gcsGU2PHbMZKfMzbvtKkMR0c5dB84A2Xk2aR1It5Dg3uggC+VIqBR7JvbFsVTu8JG9VSOoynJjlgaIbLnwdRYDvlLCAnU5TLpvB/SzePyajlFrNUyn+2jCDXkBHw5VUkGgz+zBc2U/vqMCz/hfMk1U9EWw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=fa1kl3g9; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="fa1kl3g9"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-53394bffe0fso9015361cf.1
        for <linux-cxl@vger.kernel.org>; Wed, 14 Oct 2026 02:40:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791970847; cv=none;
        d=google.com; s=arc-20260327;
        b=GuCBSxCYT/TAOxwzXgyhSJskk2l1FxBDaAEG/ItYTmHIwz8179XGgtYCVISEGSCX+M
         X7LLn3rxpcYPQHn+nlPlgWU0HXaSiM1Tt9Ym0Gbe9/LsIGLlbdWfAIAVoRZyVEkhj9mm
         ElcMvVMeZDG1NWTzPUy2y94AM14H290xD1VW2XEBabGzQiDCofQo3gRw6H1+3cS6mv4u
         6uqUe54pQv/8DsDu3PU1LFm+h5WsdVnP+UtwtU8YRU8XiRqrHHjabVAgBMdRAQ3mrocS
         TXO17aeqxOsu1YxV6kmM7/BGUySgtRPQLy7VtazIEgQnJHu6kGsWMTyKrgeRDdWLTbtx
         I7/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=83H04bxF6YUdzZlLQRh4TGz7SNPkoIlEwePAKgXPMOI=;
        fh=ZyYQKgFata/xWYPUvtQFwJGP5gwaNv1SA4WYBNWo3MY=;
        b=sZndKYXpBwlCwKh+pdgGa+IxDYyGsb2MvWIfUtBvFvTCCWHcVlWprUKxEmZ9QZ4lKx
         6FJYLGTtwY2bXbVD5tm2TkUc2VxxwgYVJSjZPLQ2MsyfOdZzkpNyB5rbLXR8s9jnww33
         yYumddslsR593QEm7xnZixG6Wo0TqLEIVtY5x4iE+nch6xGzFJpJ4vpw5YtVeotA0SkU
         4QzGICSsCZ+D/XUipa/weqMwsri4kaNb5lfwY7eQ/OWmGI5F89SFBGNWB0M8CTFYDb2g
         i2vIALlR/uVt8tQypMegZHkTqORTk5zx+e89qKQuGHaPhxFTidN9WoIpf+Mu07nkC2ER
         zBPQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1791970847; x=1792575647; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=83H04bxF6YUdzZlLQRh4TGz7SNPkoIlEwePAKgXPMOI=;
        b=fa1kl3g97eTcpvHqBZez3IUpWEPIYRH0gqMgWhAdsafutmaQj4qKemJl8QauaYKwas
         tbYD3dEQinYRmqKM8qJgSwXzs00bzPRlIUU4ESFSk+gAghWlZ/A6Nslannmdu2jPL/Et
         MW+XX6fVvLWLjRPJ1mt2AT4CeWeab0oW8uKR8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791970847; x=1792575647;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=83H04bxF6YUdzZlLQRh4TGz7SNPkoIlEwePAKgXPMOI=;
        b=vnJnW3E4ef4uhJ4Pnx+fAiZvXvpXH5Qje0T0eRceNdm+nNJmTtHRCulI4Ha4ZiSDKT
         1ZqlsxBtmY4eJk8UZa26Drrw3vBj4EICHJ9NXAr4xXVqzSp7rELzDftLETPMhf2khVvs
         cySCud6qP0bAqitDQHhV7q0UxzLus7Tks5oF4exsIPLCk6wK4Q0X1KSK8T59eXwAfcNj
         TvaVsalnyJ2ZxU+XIupGysjvikp00tXiHXhHoBM7x35Kr2o61c86J1bio+JYxehRu1QA
         lK7hD3Yj+BxnVkTRXnoVxXwmKkbmIFvt2NDZAtQcdu0ct5vTFDRZQsx0Wu+k3KFiyLkG
         dfoA==
X-Forwarded-Encrypted: i=1; AKwUvBwU9TRF/Vj2Pd2EhHDp9nbLfEjv/EmqrvryinSE7d3u9PqPVNHqGbcA8ezGcM4CcobVrzUP6xk7gMM=@vger.kernel.org
X-Gm-Message-State: AFq9FYLBb5ILO2NOir2dHBKtjMiBiz2WKsn9UBFUQgRcZhXH59K5Ugdf
	BwSuQbWdywe1yU+B+YjjNvIwL55b9FqnUpiM+kEGNbl+7fgDjt1Y4d6Wo2p0KsqBFGT8MTvP+mL
	tMfsIizkCLr3aifnyvgmUwKKfsrqtOK1W+3wSAJ9nf0qUIQhzVI5g
X-Gm-Gg: AYBFou3cAmik2gAQVLIFnKaWQ3p+6qqsos5g3vh18qZRG57iLTzXkYmRbfiPq1TjtVT
	hSpfVWyjRsxZi6Nw/NgbLHdES4pE8IbKEuI4K0jzBS3sbkSHaGzniVlzQDdWb+0BEfkxhv1rhWb
	alZXYv2An91b2Sdt37w2aAcSEsNtTCLvAdBaM+dAOialHj+Cl1KjbyXlel0VfG2zGUrk/Xj5MTo
	/hTMv1PytRdrMOZlFQXY4Bzg+SGpQjvdy+P7qrdKJ4J3wQSh1spV1WjWYRVPKBwmMqhN7R5OJ7+
	ymB3pVnE98zZLt9916me3WoyKiw+Yoo083TWG5h/FY1vhjXoozeouJjXPE3whca4K0+E3br2S1S
	D1lb8174il8jvCo3Fdg==
X-Received: by 2002:a05:622a:305:b0:535:f20:a051 with SMTP id
 d75a77b69052e-535a62041b3mr204309621cf.26.1791970847591; Wed, 14 Oct 2026
 02:40:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261008112004.1899560-1-mszeredi@redhat.com> <aswN-UprZHx9wU9y@groves.net>
In-Reply-To: <aswN-UprZHx9wU9y@groves.net>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 14 Oct 2026 11:40:35 +0200
X-Gm-Features: AclHuK-4wYzbPDth2dwaMOE-UcJ9Mlv56Q3DJCgmQBZqmD9Im9s183TZ-SA1hxA
Message-ID: <CAJfpegvDbGaoH5Er78M=XYwA6a7zj6DRqY0+F0cgiD7TfRK_Mg@mail.gmail.com>
Subject: Re: [PATCH v4 0/9] fuse: resolve extent maps in O(1) when possible
To: John Groves <john@groves.net>
Cc: Miklos Szeredi <mszeredi@redhat.com>, fuse-devel@lists.linux.dev, 
	Amir Goldstein <amir73il@gmail.com>, "Darrick J . Wong" <djwong@kernel.org>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Alison Schofield <alison.schofield@intel.com>, nvdimm@lists.linux.dev, 
	linux-cxl@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 12 Oct 2026 at 00:33, John Groves <john@groves.net> wrote:

> With this patch on top of v4 the famfs test suite passes; that tree is
> at [2].  The famfs userspace master branch [1] now works with v4.  If
> the next revision needs further userspace changes, please base them on
> that branch or send them my way so the two don't diverge.

Applied, thanks.

Please next time use a new mail thread, because linking to the old one
confuses b4.

Thanks,
Miklos
