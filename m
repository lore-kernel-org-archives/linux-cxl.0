Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA3C47C0F5
	for <linux-cxl@vger.kernel.org>; Wed,  7 Oct 2026 12:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791377203; cv=pass; b=LZsq/8h4RWzoIPKbngoVk9lryZ4zn+OfYRNgIuLZJ/ne4l9yd+RSxQSsaWzhIUsVnN2nOAz0/B52MA4RKLudsOw2VmVq44wp0grXt3RAqPxtXwpChCGTP1MLqWBt5eK6wprt/OtdOGqWcyk4SSHVH7JUASiNf9y1SzdbFErMAhY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791377203; c=relaxed/simple;
	bh=DQ66qo2LBVsMUtYcU8ALmcwIh6GNxRlKIPrYYWjh+QQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qWG15Eus+6uiiwp4s5crG9eIP1ad3LQvRxv41p4TSi0QLY4NSnla4DjuzUl741YKSMoIezI8MG49ITFJNx+HoXFPAkIJW0rrVS3XKopVA1VdE3L6wQnVeV8EgPWg24sRNQHFoIBgru4eob17Dtl8FMfTP3XxI3Y3hRtoyp5tQKE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=c8Rg7Hk0; arc=pass smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="c8Rg7Hk0"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-9178510f3bdso23184996d6.2
        for <linux-cxl@vger.kernel.org>; Wed, 07 Oct 2026 05:46:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791377193; cv=none;
        d=google.com; s=arc-20260327;
        b=GS+ZB1Av4BeIrFNwtEQN80nDsDpW7ldUb38KjyG8wTXUxwY2vMUl98DCZcehbgULit
         FY8AKU2bRBSzTVpcBITus7DMD5JeipvKdjX/4RWQMdBnQAdT8fT4mstDELrqBXCdbLVW
         cSlF6sZOBHzwtpNB+SBgZDYMnAe92R4d1rsNlSsqCRqXlRLbqGqD4vkpdlVrgFveLjhj
         OErVrHRvc8YFmZGPwhDXE/NVUvXn5/PWxHHlMOSy1sDiPpxUMGNvgTcc3jY59ybA563z
         rAQ36gcKSSOQzAZ7Ag9/vWaAZHmcToR6jJXo+umhyA/oStDE6IeURC6G0Tp6tfcd/FMm
         lW/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=dUNhGKEa9s44b6qdRqUnNpXSObQsUXKjp/BQgjN+C1k=;
        fh=PAdT1kx0CmHAJNrVaZDhf0KaY3ZVerDPg3C92Ml1P0k=;
        b=TyWRFKx5bGD3sYefdDKgV6RiQmmjn52eE0YwOSmEgNjBwdZHuGLIwNhSf4NZqtph5q
         Dq9x25yztbtRZwLkcaR/nE5yIOPgEWrkgSddHpipmB0Ka769IrdiKH/5++BNJ19T1CB0
         rkH139Z/PnE77H+4sPiHhOzklxNE8abxMTzcaOe+W6jq5bTs9TdvqD6sDOKseIVhRr/u
         JMMySwnGjxZhBmmDX7HX0X2kJjVLz6lrkD3C7nAmpFtLZ6nSSRxuG9qhObNeIxCN9P2e
         3OWzpxNe4/YBynNrcbTwDWhwbTG75WMvcQJ1l2NNRd7PRZQzGwQc4ZmJFmffUe8Zj5XN
         qzUA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1791377193; x=1791981993; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dUNhGKEa9s44b6qdRqUnNpXSObQsUXKjp/BQgjN+C1k=;
        b=c8Rg7Hk0qtl0fd+TnChCM263vq3ZhLbM7/Isa6IufiRatJCqbKty+GaQtW4IoRN5/C
         9tfuPRZbCzcorLbloa9i55gBo55QU75b1kPl289EMTXcY5lmZOPb+S7QGWWl+AeXpJk5
         vKr+kwUtwsG7MYUea6QljyZFHcET4frEol+ZM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791377193; x=1791981993;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=dUNhGKEa9s44b6qdRqUnNpXSObQsUXKjp/BQgjN+C1k=;
        b=vpsc7TBInIxsnWw87SEs3MBhJHZlSpffsVmMxSCr2ew50sprXTIakneaBv1uDKHftB
         ChgMxS8dCJVRlS9mL5Dm2Ct0vGxvKKpRZJSigKHol/xyktxciKDLxW88IJaBD9VRCMci
         0jNP94b0N6lAxjyZN8Jc/B3bfY54u5iPm+jmRjkEMloBxKt0jT9sPKR1U298ulxk8P2s
         O1EpHwJwcm3UZRgfGClkO8alkpD1yIFInYRfhCGckh7Ii7vZbC1eyPtpdbuV95hKLdvb
         PP2NChSEuzYaYKVGDS5GXxd7EqfokQ8iRfGQWLCVR+L5J0cAB8KV6cX1en3+J506NVMI
         TAEQ==
X-Forwarded-Encrypted: i=1; AKwUvBz1LBCjqfSV037NiUWGLnU7icYqqWU4z+8Atwq33fzWVZM9brUWS38G5BwabMOyVt5WI1rezqIFCks=@vger.kernel.org
X-Gm-Message-State: AFuF++lghZyqSVhjejM/huploWbVoVRT/JNTQB5LO4kK81PD5CcGr5VK
	sJz1dLxa/Bb1PZ/kTjPktLZi/+XkGCgDpsLqX1xG6bsKGSZ+FFnhcQx9UZrR0SFaEUprOOKz7Uq
	yNv27PpHu80XgyrasgLQQKDvHjweE4fGoOR5yEoH7qw==
X-Gm-Gg: AYBFou3wllvgOV1zJcbEHy507zczcqziqEUAJSHAWuGnhXn7e1WiTifOqAjR9S6rI6V
	qgT9RbdqM3XJY4zgX8wRhu8kx5ZhMFB+fmzaMv52kvLCINiaOIANlVElt7IAzA4Z4tc7B92E+Sg
	YzcINMVoDQQv9jKt6a8gB/BeX+gMfARSu6qayq60AE9wmwlYEpSEllOTf92g7YlAo+g7B28FZ/D
	S6/289utdPLVnetQo9/fCnEfOxdU3e9+yrEJJ7WF3S+HsTj8HGeMeLHaizUWGWwzSzG4DFCP/0O
	FfmUDMyvrr9jbgHqSvn8Cl3UMTr+46fgNP4GzQONwkTXhF1/CI3n8K7ylUM+hfzNfoA5dSnreiP
	fqIPRg0e0hSx2
X-Received: by 2002:a05:6214:5992:b0:912:5f4c:ad3b with SMTP id
 6a1803df08f44-919977eb9c7mr39837396d6.16.1791377193347; Wed, 07 Oct 2026
 05:46:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261001150935.655979-1-mszeredi@redhat.com> <20261001150935.655979-4-mszeredi@redhat.com>
 <CAOQ4uxjWCRs59Qpc4t+2=i67rdJkHt=+rH07ZXv7ZzAvTjTm-A@mail.gmail.com>
 <CAOQ4uxi1+WgHJdnRKMD3tp24EOyx7iPByzSKLn_siTVY3_sRDQ@mail.gmail.com>
 <CAJfpegttAHQAGhE61t-VZqfQv9Z==ovbyLY6qp3KOK_CvjBciA@mail.gmail.com> <CAOQ4uxj76PJiumvXLHoJUKx_=FAueg3WQjYd64=B_TXo581POg@mail.gmail.com>
In-Reply-To: <CAOQ4uxj76PJiumvXLHoJUKx_=FAueg3WQjYd64=B_TXo581POg@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 7 Oct 2026 14:46:21 +0200
X-Gm-Features: AclHuK_kiKb8PFtEuseEkzlQkRsY4kgMloE-Yk2LCuIBBYBmhlknL6iE41fdO20
Message-ID: <CAJfpegsKRX-sumEA5bjvfNwpkXp35HM_QPd8taMPooR0gHpKaA@mail.gmail.com>
Subject: Re: [PATCH v2 3/8] fuse: support 64 bit, server allocated backing ID
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <mszeredi@redhat.com>, fuse-devel@lists.linux.dev, 
	John Groves <john@groves.net>, "Darrick J . Wong" <djwong@kernel.org>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Alison Schofield <alison.schofield@intel.com>, nvdimm@lists.linux.dev, 
	linux-cxl@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 6 Oct 2026 at 23:24, Amir Goldstein <amir73il@gmail.com> wrote:

> Unless we gate _open() with fch->initialized, then it could fail on
> either one of these cases:
>
>                 if (!fc->passthrough || !capable(CAP_SYS_ADMIN))
>                         return -EPERM;
>
>                 if (inode->i_sb->s_stack_depth >= fc->max_stack_depth)
>                         return -ELOOP;
>
> Quite randomly.
>
> Maybe I am missing something.

No, you are right.

Thanks,
Miklos
