Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857FD2EAB7D;
	Thu, 26 Jun 2025 14:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750948129; cv=none; b=NL3b5JprQDKxGugWPk4J+f3k76fZq11zdjGnIHZ8gppVCWU86vvxBsFwSrla6Uty8Obkt3kzI0Zph8ETaFNfNRLZMqgamIISPI5TLqW50gj/ViNrw5pJReiZVK4m54VX5ZBLr6PSxu609Nq+028Wm8/iLm0ln6A/6jaEp6jBI40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750948129; c=relaxed/simple;
	bh=cO0dIqHpbTc6DvsuyXubTVueJiquRK7Muf6WQvl1NBM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F5sApm5+V+M5gHyJCUi4iXWU8DxgZ4ppQ22rO8TfrqZ5Yv4rgB1e71R/nv9Vr9kAo+axYfueBo/ko1iF8VOCEnE9Y/7Fh7xWDHxchaUZtVc/+wV1VkpiF2RWTBst2FRxsbNzW+I9hZLHC5p63kWN3KbQXRiYsDpiBEROkgaV0qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RQ4iumFl; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RQ4iumFl"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-32b8134ef6aso10671481fa.0;
        Thu, 26 Jun 2025 07:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750948126; x=1751552926; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cO0dIqHpbTc6DvsuyXubTVueJiquRK7Muf6WQvl1NBM=;
        b=RQ4iumFlAebnPamXBq+PEscEcS2pEJL1IlQA/hAtERspSff9fVmAxTzeWKo6ztuTjF
         w26aU7eweVQ7ZKstdKSkl8RB61t7doZCOdGfWO3oiECokk2scZKNwuMFjGXQuZWR4+uY
         Eeh2F8Qxc22UAgP3hLeaevH1zU2bsSpvDOIUixfCeux1QPustWAWNhHQc888hlBdS54h
         +bX36YXS424t1MueYdWk9MNh1tJh9W3//hU5MEzyJ0/eqQ/TZ1zGC/XYuaGo/VD2q600
         w5n5sOi6sf2BuTUJJBK3VvDhpRON2qKgoIjMxOHQhnX3yatSgzj5ljyZzmeivDOEFL4x
         JvtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750948126; x=1751552926;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cO0dIqHpbTc6DvsuyXubTVueJiquRK7Muf6WQvl1NBM=;
        b=BXyq7PPMH4mF24yvmgOkzUdnv/WDBkWFtHIrbMQDmFdADO4D2z4gZyxjGlNtbM+gte
         xQUMl6K+AdUsCmM6Q2G4H9y8CCUdOH/+oT3v0tv7eR31hTgYL4aPKctvvax6s4iQgwX8
         iTMuWeqjGNW+3RtCHZI/i7QBH0jUa+Raws/XaweXULQHtuZxKIHAV76sfuvFqlPgCImL
         PIAfF/5ROX3hcDTqbW/FLlPk5C2Toz/FL4ydN+yzl74HDIi9Vzyqdue8atauqNsKMt76
         Kv+McjqnCFUUYtG5AZ/ktJ/3977j1p030UlaZvco4PH0EYzSeNI6SlyAq6iYvROCRoT1
         JNoQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqsBSIG8jxdfh8mY1oTOI//+I6tKxFrFI35DogwFr8XkgKKtjPC1VaQ0JSLXWB46RNpOzwxiu4cuw=@vger.kernel.org, AJvYcCX+3dqCXo4duz14/XxeFPch6UN8VPD0lEVvK5e+mw0ppMac0tBcMxOg6P/RFVIa4mEOVbnFPxVqLde01Yf3@vger.kernel.org
X-Gm-Message-State: AOJu0YyB8peOvduV/lmzFa5vFQmbvPhFo5hEdvtTiEVX9Hph9dGk3RWE
	B6+UqmH3wjNYa2OgRCMdalNBxPP40naGqrvQnApYyv063FGvbYkZ6Pe/7HGbVE3q98I2+cqdmbX
	s7CksAuifbm55nOFqkNGeesSqVI4N9zY=
X-Gm-Gg: ASbGnct5/icBFyq+jEQGyVCiXjwyDM9BdybOmsS+YQeojyYam08VHGWhNBkBxgW1nv8
	jpqn4mVIc28XrX8ulgJMyYa2ZlgGvy8rNYIHEtKIQcmqHa5vgcnFt999+1sA7JyiSyCrsKadzF9
	cs4Q2inFAFLVpwOxqZnSQwJ33KCBHA8hjcI9Us+f8G0Iwr9okx4kp+e1MYIxH6iH1IIZiIM3xg6
	+WxWg==
X-Google-Smtp-Source: AGHT+IHwWc9v0nriRWmfxkaR6ErrKPjoGINPW/jmv4lNFaYYTGCtUBrIKjRtDfii7JIle46/WTToulmBo+DV+GFcw9o=
X-Received: by 2002:a05:6512:1256:b0:553:349c:6465 with SMTP id
 2adb3069b0e04-5550b4da73fmr6523e87.33.1750948125353; Thu, 26 Jun 2025
 07:28:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250623091929.366357-1-pranav.tyagi03@gmail.com> <685adc4d1487b_1608bd1009b@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <685adc4d1487b_1608bd1009b@dwillia2-xfh.jf.intel.com.notmuch>
From: Pranav Tyagi <pranav.tyagi03@gmail.com>
Date: Thu, 26 Jun 2025 19:58:33 +0530
X-Gm-Features: Ac12FXwMes5vqgDVPQbqpvCV1-G1XfDIGUvHwA0zRSSmnY8QkXO5IKPoZKr4VsM
Message-ID: <CAH4c4jLH2XoqfVOx-7JxTw-fX8Xbc2zhGmCh31e4v2gQc7xMoA@mail.gmail.com>
Subject: Re: [PATCH] cxl/port: automate cleanup with __free()
To: Dan Williams <dan.j.williams@intel.com>
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com, 
	alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com, 
	ming.li@zohomail.com, rrichter@amd.com, jeff.johnson@oss.qualcomm.com, 
	peterz@infradead.org, linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, 
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 24, 2025 at 10:42=E2=80=AFPM Dan Williams <dan.j.williams@intel=
.com> wrote:
>
> Pranav Tyagi wrote:
> > Use the scope based resource management (defined in linux/cleanup.h) to
> > automate the lifetime control of struct cxl_endpoint_decoder. This
> > eliminates the explicit kfree() call and makes the code more robust and
> > maintainable in presence of early returns.
>
> I do not want to review small standalone conversions of individual
> functions for no other reason than vague claims of improvement. The
> reasons to convert an existing function to cleanup.h helpers are:
>
> 1/ to fix an actual bug
>
> 2/ in the course of refactoring the code for other reasons
>
> 3/ to eliminate goto trickiness and bulk
>
> This patch does not make the code "more robust and maintainable", it is
> just churn given how easy it is to verify that the kfree() is correctly
> paired.
>
> One quick way to identify code churn is when the diffstat does not
> result in a net reduction in code lines:
>
> This patch is "3 insertions(+), 3 deletions(-)" =3D=3D "churn".

Thank you for the feedback. I understand your concerns and completely
agree with your reasoning. Please pardon my misjudgment in sending this
patch. I am still a beginner with kernel development and learning to
better assess what makes a meaningful contribution.

Regards
Pranav Tyagi
