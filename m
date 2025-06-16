Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F202D023
	for <linux-cxl@vger.kernel.org>; Mon, 16 Jun 2025 14:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750082578; cv=none; b=BKM1133tRn175G03Tn8rQ1u7S7SHkjXRIM9UH/7ZczqMzMVAjinpPd22NeYb9z0orzNY7hqaQ+4/NXs8XMd+o43K92Rjj+iGoU5gmUg6rgz9bwFyGxhnQxBnH1H0LjlaMIiooP4ugR85KoI7VrFQQGyEmB0C441VcnLEQuEO4Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750082578; c=relaxed/simple;
	bh=M9iPmr/hd9Ggp7c2g4TZVex3t2dAViOX8F17mzyQZUM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I92TmNYfkXMrrBap59pCADI/6xWWhtSho6/V1sE1X/wBiCrN3FLZcHPUxn9B93uOZAmpsutQ2FbR95dKXtFicH/2kFA6TbZpUcf8tmbQfe2FQg3Us/CrsRkN9Pdq0ZIo2yg2wPn5P07MlqH+/IpP8Jz152Hmeva0qADdOv5uvVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1tKiH8QS; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1tKiH8QS"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-453066fad06so34221465e9.2
        for <linux-cxl@vger.kernel.org>; Mon, 16 Jun 2025 07:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750082575; x=1750687375; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FeI7dVZjAypUtlg/sBYp2OboqNhum0d3l9RmKtS5z54=;
        b=1tKiH8QSVPTm2a3j7uY6nsdM6L9QMy92M1AIsyTl2sim/nRQ71muIwqIkYLCA0n/wa
         8m86KMrMD29ZwdUIMDSkYRoKXWW775BqHxgoa3BZIllmYanC3TiWw79GH4JH+6rRkRtG
         /Woq+jVyYiWhQhB7sOdB3Ys9AmIyRI7KXcHCc0Qj2mPx+vstrXw9hFv3my+nQmesr8Rf
         n+D+yJxbSBNvELdh5S1fk8e42xGYpm8Xlc5VZUIr6UYITbs+ONXsAOxhvihfv9FDKXdl
         62voh4/KB7c2ZeL3IOlN63c4Ln7/INpWwQZxwxhsK2Vh1adg+QuWGT6OwQ+gy8sAVFIX
         OPYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750082575; x=1750687375;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FeI7dVZjAypUtlg/sBYp2OboqNhum0d3l9RmKtS5z54=;
        b=K7Wev8+rT9dLbnBY5fgSeNE68b1214570nHu39pYue2VC1GcrEoMqJFSm6HjbHvVOz
         HQKHgoX4g+iq/awyICT44zaP8PMbDgFOj3UubikTd4qOsJhwdEmrsQO25fw7LLLhZmDw
         dF0C2J2MKhY4AWpRbqxKpI4PKEWI+vCq0KDb8sMrENJXd+yFxIuVx0uJB0pNrcdnaEED
         VB9CUVij8OH19F/moaeiY3EbCcE3AHMLl7quLYI5s4z4SVumCr6ElBXTBngLh7k7YGzN
         xNdLvZvqcaKwEP6HJtwTWUwkxNO5TkP0djA5UH16fowzAyJpN71mAGOrKTwAU1Hk5cup
         3ayQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3tPZrjIrOLHQg0sHJUHmfiwPjqLhO3Om70zr7BHxHuod7+sNtm2rThIZvjh28TULbc6/Hld8GA0k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz5X3ayfVxAJi3tm0qoi/2VQOGFAwE5ki+UqizEhe7jG6FMZ5v
	THfW1vwEfMAViqewP02kJvzbZ3e5hiV3j2Ph9wYXqnoXcyYRzALTXmeJSmMKVBhoqRnGa1CYztj
	h0AnqQEzpEfZWDu7iYRePFBI2Ugzd3p86S+NyZZQs
X-Gm-Gg: ASbGncuZ36ku6kP7c7rkz2MupXq66ORKjWq9n9JUpusfzzvvuZ5TNSHKeqz+SzOZdpW
	DSX2/ilzRZK6pbPMxB45NNGpsQZcltymmsV0uD9OoeEeuKmo+yWkqUbusaUI9xcwWd4LOP34iib
	cqj6bWaCTL0ad3ERrHmY3XdtuDnRiOg7EiJxNWAEf5rfZO
X-Google-Smtp-Source: AGHT+IG6mhibxRmrcpXyyVWbs6Zi/EB3mKvbkPCAzyyW7ZMRYgcWpCLi07Oq9F9r3b2+3Uf4STjRbMPp9QJZxFXkpB4=
X-Received: by 2002:a05:6000:4203:b0:3a3:6cb6:defa with SMTP id
 ffacd0b85a97d-3a5723ae1b5mr7662579f8f.40.1750082572895; Mon, 16 Jun 2025
 07:02:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2025061313-theater-surrender-944c@gregkh> <20250614105037.1441029-1-ojeda@kernel.org>
 <2025061446-wriggle-modulator-f7f3@gregkh> <a3a08e5d-bfea-4569-8d13-ed0a42d81b2a@linux.intel.com>
 <2025061546-exile-baggage-c231@gregkh>
In-Reply-To: <2025061546-exile-baggage-c231@gregkh>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 16 Jun 2025 16:02:41 +0200
X-Gm-Features: AX0GCFsVDhmmW3g26qu_6PoP9y5f0Lj5YfUuf6wjtzXOaEVtlzvaf6PEfRuyuhc
Message-ID: <CAH5fLgg2aPtnWDqoZ8wi1OGge4PBB_Y0LSM9TSviowquEQXCVw@mail.gmail.com>
Subject: Re: [PATCH] driver core: faux: fix Undefined Behavior in faux_device_destroy()
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Marc Herbert <marc.herbert@linux.intel.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Benjamin.Cheatham@amd.com, Jonathan.Cameron@huawei.com, dakr@kernel.org, 
	dan.j.williams@intel.com, linux-acpi@vger.kernel.org, 
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rafael.j.wysocki@intel.com, rafael@kernel.org, sudeep.holla@arm.com, 
	Dan Carpenter <dan.carpenter@linaro.org>, Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 16, 2025 at 5:36=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Sat, Jun 14, 2025 at 07:53:34AM -0700, Marc Herbert wrote:
> > > the kernel relies on this not being "optimized away" by the compiler
> > > in many places.
> >
> > I think "undefined behavior" is the more general topic, more important
> > than null pointer checks specifically?
>
> Is this really "undefined behaviour"?  There are a lot of things that
> the kernel requires for a compiler to be able to build it, and this is
> one of those things, it can't do this type of "optimization" and expect
> the output to actually work properly.

My understanding is that -fno-delete-null-pointer-checks changes the
language semantics so that nullptr deref isn't UB anymore and instead
becomes a guaranteed crash.

Alice
