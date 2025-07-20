Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C9219644B;
	Sun, 20 Jul 2025 08:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752999449; cv=none; b=FetISIbVDR/yXInKDF4/2Tg09zCf1qflfVOZb+B7wtOD57AAkQu66llyyLaeHmJJG8jNShEYqd1s515Ki2ZiiA4Rq/eZCzpba7BesQKeD6iPWzKNq1jlLw+9b8n8H4iIISd4JCc2JdjJOLFgNACDQbx4ecFmAiiNlie9qSDlYGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752999449; c=relaxed/simple;
	bh=MmLkEzQKYtCU5dxP/5mDWFrowVL+z89sLLEDpomscCs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iUpuRnJNyFiIS+FRSJxy4/RRG2BcMnr2RSrJOsoj7vamtznK0ZfcWThADWkoKmL2xyMqTRSShUx0BvBKicJUoqAOIPCqqL5HUspO20uaEdVLMO0R0UvOgfAAJp7Zw9go+9xOt8FbNKwcI0wlGe4kU9rbv+zxhEAF5KkDlKIcf/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MVwViaru; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MVwViaru"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-32ce252c3acso15296121fa.1;
        Sun, 20 Jul 2025 01:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752999445; x=1753604245; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NozUcVTbZV8j7nUBx3qB+snic1Q8R5gg2JD9KsrC+dc=;
        b=MVwViaruhijm9bQtlhcypwdah8i+TpbsFntEd7PN4ArmOBADowiXk9unD+PupHCdn8
         fCcQdIKS9oSh4mUyByqcp4bFq/OISQa6Xdebz8WUqtPv4eCz5j0D7ewTaxmi2EOEyONq
         G2D1Nq1pwTgsmDx7cymMeyPEOvdWlgtSQoL3Vg8fZqOBaRYLvxWuG/Yw+AY2rX9vGgKw
         AP/doZNe+PxHCnvUtyW2pIbP4KnX5DvijGL4yfU0VU+MufBcdinbot+Kl7n4Qs0bM4UG
         EJAha+x95rMTxHFJCGKm7DE76uLjYI4LHravHuWraHuCrnD2QBAtc026VNIEP/EnZCud
         U/eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752999445; x=1753604245;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NozUcVTbZV8j7nUBx3qB+snic1Q8R5gg2JD9KsrC+dc=;
        b=v55+GZDqak8YxA0wEitK+oasEeM5jtt8BT1Dton2KNX0sRE8dET5X5wTG2ray1DVR+
         6u33m9G025+SM2VJ08Fdv80NpcvbFrvvOvdWgyGmJVLQtw+1dRugtcJ+Gq/oEXyEL6WJ
         FjDDDez5tFfdAnf2InLC/YPwT8/6HX1iBsOuxkYa+peK9bbjba6NZ3SyC/P6wseLr0nf
         UIUHIHQ4+Idr4MDNcyLen3i6p1P4EKAsuxsPaRjSTcgeZTdWjLjy7C4JvvURS8wEV2Ik
         6GFOJeb0AL2AZzD5zL/fHVrMQh7ULV3iKi4hbBdBEB4HKmQbDTmrH7r0lL3TeZeTZVGA
         RPqw==
X-Forwarded-Encrypted: i=1; AJvYcCWzYrBju9sl351CIzoRKjtrRBbMIAZRVG08VNKxE3ESi214l92AM2tYUGfy7Z6KlWoQr6NrNa7TDVE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZRu/T5vvq3vfBbT8aZ8aVs1TbAurDREEu/sgMYlMJo64cpNuK
	4LBwx3Eh8QXO2wDDnH1PaOLMeXYdE6cGXZiCvBwVofbUykDvieYYfWv+NCYghVc7/4ZOk7190XU
	xhO55+kQilTjsjlT3kO2oqotLrAxZIwBp73lt
X-Gm-Gg: ASbGncscPLwJiaNNK+EVXxhPYGWPOZuq2LxkS9uTs5NkxeX4Kj3HOMExwcL9oXkJZAM
	eGWUtAJbfI+1LGG4BAjEvZbNgNwonYGhmF+7mLZjZAT4ipJkZxFLXVSR9QBFFgYE8ohqkAYZqp9
	eldezhsDPPierzB+a9hqb2rRVR0E38Qb82hvtYZMcHLP6rjMTAIUa8FDuMbORLOjq/rwirG9+Tp
	6t5AcrAI7LA5VtYM7tKcZXh1kiRrhG/waA=
X-Google-Smtp-Source: AGHT+IH+yiVeNQlI+whz/fqk/x17mXHhPbftkEa/YBPfJgTyZK5++1Q4kOlxgAseobRnW9e2k5QUw9aGwmV+0Z9fthE=
X-Received: by 2002:a05:651c:4101:b0:32b:4932:d328 with SMTP id
 38308e7fff4ca-3308f62895fmr37225661fa.32.1752999445178; Sun, 20 Jul 2025
 01:17:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250719112604.25500-1-akinobu.mita@gmail.com> <20250719163144.7524cfec1fe2041742608f80@linux-foundation.org>
In-Reply-To: <20250719163144.7524cfec1fe2041742608f80@linux-foundation.org>
From: Akinobu Mita <akinobu.mita@gmail.com>
Date: Sun, 20 Jul 2025 17:17:13 +0900
X-Gm-Features: Ac12FXyMlLPKQKdS6jAd3trkeEUh0wdiHufYauXj4OrWxdyB_IxRwazen7Yxi-s
Message-ID: <CAC5umyi5ZwAR+nEPjn_5m2q7kjE0uyo=0pzv-s7uod560iGJEg@mail.gmail.com>
Subject: Re: [PATCH] resource: fix false warning in __request_region()
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2025=E5=B9=B47=E6=9C=8820=E6=97=A5(=E6=97=A5) 8:31 Andrew Morton <akpm@linu=
x-foundation.org>:
>
> On Sat, 19 Jul 2025 20:26:04 +0900 Akinobu Mita <akinobu.mita@gmail.com> =
wrote:
>
> > A warning is raised when __request_region() detects a conflict with a
> > resource whose resource.desc is IORES_DESC_DEVICE_PRIVATE_MEMORY.
> >
> > But this warning is only valid for iomem_resources.
> > The hmem device resource uses resource.desc as the numa node id, which =
can
> > cause spurious warnings.
> >
> > This change fixes this by restricting the warning to only iomem_resourc=
e.
> > This also adds a missing new line to the warning message.
>
> What are the circumstance which cause this warning?  Are real world
> users hitting this?  If so, should we backport this fix into earlier
> kernels?

This warning actually appeared on a machine with multiple cxl memory expand=
ers.
One of the NUMA node id is 6, which is the same as the value of
IORES_DESC_DEVICE_PRIVATE_MEMORY.

In this environment it was just a spurious warning, but when I saw the warn=
ing
I suspected a real problem so it's better to fix it.

Fixes: b926b7f3baec ("mm/resource: Move HMM pr_debug() deeper into
resource code")
