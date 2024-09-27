Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A2C170854
	for <linux-cxl@vger.kernel.org>; Fri, 27 Sep 2024 16:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727454144; cv=none; b=MOYoCNOZElWTzKUbKTZXnhZEw2UTWG2MNHDH6mPi5NWEnD9n1dbHaR11F/y+TyjDd0rHietH2PWx2wbNjWpGtOFP4hp6VAuh8oKfEuuybgqZC0tYRxCb5ziS3m9OF4Jf83F9zALJFiMuVJf8vQLfgHjbjxdxwBNfmYpDAZXZcOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727454144; c=relaxed/simple;
	bh=ywJYDl4qmNt/AeIYKIruKiAbsEwSsiYrfDHn1yqFjNE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FkpZ5kKf6FF0khre8G/RvIV4DBcyeMPy+/5m4gO0TskYt2jrVmaUHu4yepWnYT+zOWVfXS16SHdGRX8A5BQ+FQBw5D9ded7UCtbkjD2YmvoTV1RbbmMDg3tzFuUP2bvqhta3RNcsGQrbQkPeqbG5STC7Ab3swjwmxyFg1SWUG+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=h3leJjgX; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="h3leJjgX"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5356aa9a0afso3759463e87.2
        for <linux-cxl@vger.kernel.org>; Fri, 27 Sep 2024 09:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1727454141; x=1728058941; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=p9myqxISAiZujJdBvBYKeb4wnqksDlngJ3uEOl6wlpE=;
        b=h3leJjgXcv8r7al6xMH+ePQ09S6CAdlCGAsbakg0N1qu6n0wE4eR/L4CYL+oF4lNyO
         n9BeqTs09Bttm5xFRPA2rA1B3AJM3j3ORG+puM2XfwQ3gchMZ85k1rVRFtJMpEhc30gR
         QvNENQ7mdqcOXaznWbyb66YyBHuruK1MuqQSY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727454141; x=1728058941;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p9myqxISAiZujJdBvBYKeb4wnqksDlngJ3uEOl6wlpE=;
        b=O6i1zYGHhSMOdRhcNs6v3sCXOK4pY1WO6bthVidm/0TJwqVetwJqmR3wHgXoZHHLzH
         t/QOtFcFagZoKqyiac4UAdmTOfpanqNUfRebvsgx2NGRrCWUk+gO994G3SVXALwW78w0
         gyKdCLwSpzvdoppKtwsGE/f9/6NXkdFHhMa44kUmNGHzb90zrZQlR85pOvYRIMThSUSa
         DFRhPYWHJXRtr8DSO/Q4oJkNiAIOUCqyLYxJjhFOZPKlJc/Azi5KFcyXtdvlBNOq6XNM
         VVIhtohuR9GXpE02WwrNHMfvHa0t5EqihJK/Afn2Epv8W3RDiFLWhDu4uWLvO9jpeC/u
         smmw==
X-Gm-Message-State: AOJu0Yxcwbrs84qWuJMNOt1Rhx3ZQEylLP7ewiVztZF/q9kLc0iqg3zF
	gIBG86e9swQGLvfvDWJEQ+kZXInxnalhQZooWiAQ3cIyT4doBh+vFceD8fkfXJC+W1P+7gL+xgC
	+20twQw==
X-Google-Smtp-Source: AGHT+IHHzwOmAKJiipFLuz1x3RFNEz2ckFM1s5z/SV/x/peC9ZsvAiX5pI+I2gUu8OY6MlsN9n9PLw==
X-Received: by 2002:ac2:4f01:0:b0:533:71f:3a3d with SMTP id 2adb3069b0e04-5389fc4690amr3994376e87.24.1727454140708;
        Fri, 27 Sep 2024 09:22:20 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53989e1b4f2sm220420e87.176.2024.09.27.09.22.19
        for <linux-cxl@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Sep 2024 09:22:20 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5356aa9a0afso3759412e87.2
        for <linux-cxl@vger.kernel.org>; Fri, 27 Sep 2024 09:22:19 -0700 (PDT)
X-Received: by 2002:a05:6512:3c8f:b0:535:6aa8:dc49 with SMTP id
 2adb3069b0e04-5389fc3441bmr3822536e87.9.1727454138653; Fri, 27 Sep 2024
 09:22:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <9c4d4de9-5c24-4644-ba41-875bf19da10b@intel.com>
In-Reply-To: <9c4d4de9-5c24-4644-ba41-875bf19da10b@intel.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 27 Sep 2024 09:22:02 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiDV8FZ1orKBAXt9dV5iCQUY6_APGajH8ta94burg9KEQ@mail.gmail.com>
Message-ID: <CAHk-=wiDV8FZ1orKBAXt9dV5iCQUY6_APGajH8ta94burg9KEQ@mail.gmail.com>
Subject: Re: [GIT PULL] Compute Express Link (CXL) for 6.12
To: Dave Jiang <dave.jiang@intel.com>
Cc: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, Dan Williams <dan.j.williams@intel.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Davidlohr Bueso <dave@stgolabs.net>, 
	Alison Schofield <alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 27 Sept 2024 at 07:03, Dave Jiang <dave.jiang@intel.com> wrote:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git cxl-for-6.12

No such tag.

I see the top commit you reference in the 'next' branch, but I think
you forgot to push out the signed tag.

               Linus
