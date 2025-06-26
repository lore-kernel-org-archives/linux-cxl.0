Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75312E7F10;
	Thu, 26 Jun 2025 15:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750950758; cv=none; b=WJiJtAcXobrVypn2KHkE/xhuTmJuh0Bh9Rq7Y9u1uydE2sHCVwwEym/P1c+TJz5BnPjIj3oeGfzwEzZ3nEnmXaijoLLgnLKYwdrkhxYlmK+aqoEOJTTG1nEMGftpXi0bu4bbDvl6QS08XYxafVAGK/2+dXUD6eQmjXtH0Osj0xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750950758; c=relaxed/simple;
	bh=kAS/IOSk7LsBnAUgqtwuX4g9he1Zg4oVAbf4qm4DPmk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sEFip7XSQdBliJxBDzbmUxd65hmYzuFZsRt/B9nFHHgyxkFyNnqHputWlTNgnDi+XTjTnCGujtgBqH2hdc6+CLrMQMpzjCBnUCMPr8VHzn3+gLPL9NNHgm+pXPTN+S0EBkNcSCx54ETge3snhtZAU1nuwOQjnwEEMT6eEqo14HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V+WYSSUg; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V+WYSSUg"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-32b5226e6beso9621611fa.2;
        Thu, 26 Jun 2025 08:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750950755; x=1751555555; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kAS/IOSk7LsBnAUgqtwuX4g9he1Zg4oVAbf4qm4DPmk=;
        b=V+WYSSUgmywH5PkCiD0tdj0zYyT43StEKji/WblfZVRdG4okPL6vjC2kzbL2HVgCmM
         /cA+N4YaFCexyg9ls4sOGRY2U82p68aSXV/ZZB9cz9nADX5ZKj3ovmLWIL1ZshjtoSDP
         dkOAQiz5ZJGVbXC1gcRqg5Oj707ITUdE74Sa5OoiEVo+Lp18yN3DNv1I1hOxFT0udONg
         OyuQ0sDLGvX69M0IVyui7n//yzBrmXxnlRykUwtYxGPr1g4OBoxQOP3uC5IuJfUeBpn/
         avHj56WFrUITN5xZWx9gU4jCHPlnHRjc3uprgxL6Y9iY1PQYy6ZPd3A1T/GtjcCIJZfj
         jXMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750950755; x=1751555555;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kAS/IOSk7LsBnAUgqtwuX4g9he1Zg4oVAbf4qm4DPmk=;
        b=ghxTc3eRTKUkPyPpSR9qcVqf51Q1+jUaedr3RX48Vu7l5Zq1pg8/XgDxZC3BrarhoK
         ZKLdvo5CH3rz/WaOw5rZe10MCz1VOW3AsU38tAMkPT8wf/3OY5mlehCzms5VmQz3fHAB
         NcqovT4Aa1NRVv5yzzHxi6bZKvgL9AWHu7E/WX4Wc+f5EyaTenRVZ+WZa2Z2CvoSOBBa
         QiMK5t2N093xswcGaOCyINFlmKJOkFK7RrcHqjVDQvkWC+ilZAj1HG5yrU8c+QZDjNzr
         IjIX4DwH2ZCsXVGhZYgBhfOCMcd0G4D68OMrh5o6hV9uDGJTMD3juZZ5oRGj1GT4prxc
         yGVw==
X-Forwarded-Encrypted: i=1; AJvYcCVEbBneTYx8gkMwgmr3geYXio92pws2XkmR/82fbneNb5Jg3hDdwH7slirQdq/8T2JO4iCAbz4VGzU=@vger.kernel.org, AJvYcCVjDj4k+NCQJmV7wAm1GnQ8gqAam56s0GO1qzH/GsMFvY/RdN8kOZVWw3f6nlyiEXzHcmk82HXlXcIaliaz@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1WFXPb26m/iMzkuNyJTTyVQJabPCnFXfmmpxEfnux4TqwpmLx
	DTzOpwXLLis3s59mJyjmofN5W4I3ihstADet5rBW9fuLX3YP0SGaVHSLL88/G21hteVh1sJOJ/4
	jjh4WMeIuv6gkzYgWSG9Ol52Bhz9uIX4=
X-Gm-Gg: ASbGnctRyLcPWa7rh3pP2crGeVKwHNoULnvqCQXHtGarb/OOxzVzqLn+wiE3yMdvIqt
	wSo9nAPnhj3Jhn9YkJbJNI0oQYx4R8wswoG3w01GLfC66MrZ17zUBNt/kfzytR10xy+Cfinzsg6
	5TWHaDSYQAoZqplDiLa1TBTb+un0rvtjAkh422u5Ir+TL6IkIod2xOEln3dMnUjo8TJhCtnpsz2
	718DA==
X-Google-Smtp-Source: AGHT+IFDKoSkD2CJiWyVaF6kz2z7E/EJqhlSUVFS6EzXhXgn9q6Iom3W+1bxFqxhEyMbXQMlarVbh+wES6zPUtiA2VQ=
X-Received: by 2002:a2e:8543:0:b0:32c:a006:2a36 with SMTP id
 38308e7fff4ca-32cc658247emr22139451fa.20.1750950754606; Thu, 26 Jun 2025
 08:12:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250623083841.364002-1-pranav.tyagi03@gmail.com>
 <aFrBeCn-j_AB1yzv@rric.localdomain> <CAH4c4jLAfMTn6wN3wJSOQZ3mAoYC3uhswDu6c+c6v-wv8mSifQ@mail.gmail.com>
 <2025062615-footpath-plank-b84f@gregkh>
In-Reply-To: <2025062615-footpath-plank-b84f@gregkh>
From: Pranav Tyagi <pranav.tyagi03@gmail.com>
Date: Thu, 26 Jun 2025 20:42:22 +0530
X-Gm-Features: Ac12FXwJLCSX-KjqBQhvdKlckWb8pRkvIb6E3hyGEXP7zXlxzlU_QTkv3i_OQzM
Message-ID: <CAH4c4j+ahO6yREWAQbm3ZXykASmjyEh2dzPGE0Jhj+j71qT5vw@mail.gmail.com>
Subject: Re: [PATCH v2] cxl/memdev: automate cleanup with __free()
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Robert Richter <rrichter@amd.com>, dave@stgolabs.net, jonathan.cameron@huawei.com, 
	dave.jiang@intel.com, alison.schofield@intel.com, vishal.l.verma@intel.com, 
	ira.weiny@intel.com, dan.j.williams@intel.com, linux-cxl@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ming.li@zohomail.com, peterz@infradead.org, 
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 26, 2025 at 8:26=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Thu, Jun 26, 2025 at 08:02:10PM +0530, Pranav Tyagi wrote:
> > Thank you for the feedback. I understand your concerns and completely
> > agree with your reasoning. Please pardon my misjudgment in sending this
> > patch. I am still a beginner with kernel development and learning to
> > better assess what makes a meaningful contribution.
>
> I suggest you start in drivers/staging/ which is specifically designed
> for beginners to get involved without having to bother other maintainers =
:)
>
> thanks,
>
> greg k-h

Hi Greg,

Thank you for the suggestion. I=E2=80=99ll start looking into
drivers/staging/ and focus my efforts there. I appreciate your
patience and guidance.

Regards
Pranav Tyagi
