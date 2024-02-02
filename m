Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A5D1482F8
	for <linux-cxl@vger.kernel.org>; Fri,  2 Feb 2024 16:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706892993; cv=none; b=imJ0c4aWj3ojhG5KJYmN9iqg0ddL1si3imq806htj4VtzE4t4L245fkF6t1+YU7SrlTelh+6qncTJ3OcAa+YUsPmAxQal0bqw7DizJBEOVhDE0HYj0Ce32rVGwtx7LWJlOyVx6FyWW87jEDmEofRBjIxKn1Kf5gG1Y4jb9sWoYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706892993; c=relaxed/simple;
	bh=v/mBgZHM3ILTIRHoTb2obipzytY1xvYLZLRD4NSt/6g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nLHUyOjysB/4zMuNKFNz1YPcooyO+AdFPl2GauXYdIqG4es5/D0Lifk/AwP/M7VWlenVRLlyn+FCphwl29fPHZr58B6itDwuYOSgd84x+cn26KMytYRFlKqGKhdp+hG+ugXa6uyozcmQygN+wL0eK5x0sz+hB/VxiNxZlnrg2aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UjXvRqnp; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UjXvRqnp"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-55fb4b22da8so2510551a12.2
        for <linux-cxl@vger.kernel.org>; Fri, 02 Feb 2024 08:56:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706892990; x=1707497790; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=v/mBgZHM3ILTIRHoTb2obipzytY1xvYLZLRD4NSt/6g=;
        b=UjXvRqnp5+yaepYI4eSrqpw1m32Lbemab62RQHvdYiZPDl5zQxDIYxQpHoyAsukmV8
         RqnBfR/37bnok78hh4x6/5C0PMcqEv5c86DJgX1SJ3zWmw+9LvhWRFtANNaUkFR/zZr9
         X2qu0Ejohcsazj0qSHmPKSVH5Y2Oo8nsH5vYwz/45J8eP6HK3QPjdiEKaF19zKhmo78y
         IpOml8L6Bjpr5EHWE375LlWDJG9gRNMTKS/WXKBGqfotdJ0j++wgmSOTHgQK27zvWfya
         chvx2iikbhFgBPx395rGHuUIHTiKlnoo9VmtPyTKwG0eOcpMBbGNwLmMph4tiqHjlQY2
         owWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706892990; x=1707497790;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v/mBgZHM3ILTIRHoTb2obipzytY1xvYLZLRD4NSt/6g=;
        b=KYUAUm6EqEXQ2XMbDUCuKLXRVMimKpSgrBEQTqV5kr8iFs0gPLKrvgMvehkQxqmEce
         UTmXDEJ9BVP56AiSPj1Pu03ZmSZGrXAS8u/6ny/jPioOm4axyQounRhY705V5UjDYe2v
         SPk/oyhmE4jHB9ug/neR7z3mMl2KxwL6opMbJYtwRD5VSHbTZj6AGPkI22g05TT/MYjF
         oNULoILmCpWi9Mq+NIb7juLXNw9ad+BD8ulrIi5v3wTOsMfa7arMJ9XOmvrhVsH9H+RB
         yFD4p2RD1KluqZf3DG1ftweEqPW/Nc6j55UMsZgMYrW2MpLG3n1yhkc4YSdAOTAxd3vs
         /YIg==
X-Gm-Message-State: AOJu0Yy8xV9t7Ou3YQlt1+fC/14kS38xFwuas1XuesQ0YTi/PR/JB96D
	MsGXqvYadJSvfppPiwENkm73yX+rFdHpYKkpFbbb0dYQRHK3cMTrzJHO4Z6YOWUJilJzDp4MaAB
	Asi1OqX/tEC+8G1sjBtGWUHgU3m93BPJyOd5hjg==
X-Google-Smtp-Source: AGHT+IEL0XWtFgZhD/Jz0arEQzzrMMUynuAuUj0I7gaTn4qJ4asToe23hFDj3SLqkcGAHaU/gKBOW0NKKieaY2JoQjI=
X-Received: by 2002:aa7:d059:0:b0:55f:f692:90d6 with SMTP id
 n25-20020aa7d059000000b0055ff69290d6mr173985edo.23.1706892989900; Fri, 02 Feb
 2024 08:56:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87msskkyce.fsf@draig.linaro.org> <CAFEAcA_a_AyQ=Epz3_+CheAT8Crsk9mOu894wbNW_FywamkZiw@mail.gmail.com>
 <20240201162150.000022cf@huawei.com> <87h6iskuad.fsf@draig.linaro.org>
 <20240201170822.00005bad@Huawei.com> <87r0hwjdvl.fsf@draig.linaro.org>
 <CAFEAcA_xDH=rZzXnjNMQTKGJ+-E4Q=A_bEtKLgYYx6x04h0Jkw@mail.gmail.com>
 <ZbvpSaOXzZkqDd6c@memverge.com> <20240202162633.0000453c@huawei.com>
 <CAFEAcA-32--EmbzewL8WfAPanoWQ-eRpkjKuDLc5uV04wpOCpw@mail.gmail.com> <Zb0dXy72lyglchJa@memverge.com>
In-Reply-To: <Zb0dXy72lyglchJa@memverge.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 2 Feb 2024 16:56:18 +0000
Message-ID: <CAFEAcA9KG9mF2KRS_Z2XdfD6b-aaNssZ7HCL_JKymyRkCJMq0A@mail.gmail.com>
Subject: Re: Crash with CXL + TCG on 8.2: Was Re: qemu cxl memory expander
 shows numa_node -1
To: Gregory Price <gregory.price@memverge.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
	Sajjan Rao <sajjanr@gmail.com>, Dimitrios Palyvos <dimitrios.palyvos@zptcorp.com>, 
	linux-cxl@vger.kernel.org, qemu-devel@nongnu.org, 
	richard.henderson@linaro.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 2 Feb 2024 at 16:50, Gregory Price <gregory.price@memverge.com> wrote:
>
> On Fri, Feb 02, 2024 at 04:33:20PM +0000, Peter Maydell wrote:
> > Here we are trying to take an interrupt. This isn't related to the
> > other can_do_io stuff, it's happening because do_ld_mmio_beN assumes
> > it's called with the BQL not held, but in fact there are some
> > situations where we call into the memory subsystem and we do
> > already have the BQL.

> It's bugs all the way down as usual!
> https://xkcd.com/1416/
>
> I'll dig in a little next week to see if there's an easy fix. We can see
> the return address is already 0 going into mmu_translate, so it does
> look unrelated to the patch I threw out - but probably still has to do
> with things being on IO.

Yes, the low level memory accessors only need to take the BQL if the thing
being accessed is an MMIO device. Probably what is wanted is for those
functions to do "take the lock if we don't already have it", something
like hw/core/cpu-common.c:cpu_reset_interrupt() does.

-- PMM
