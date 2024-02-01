Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157BA5F476
	for <linux-cxl@vger.kernel.org>; Thu,  1 Feb 2024 13:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706793157; cv=none; b=Af1yjTtmmwWlCG1YvzA7di5N4W0LUqW5rASepDKj4EDxYQOoWZZERehCaw5Y5YBz6r4cFFKsyUVgTK+6FxRG057yIUNPDGj1EeTjGws4N7av39en+W1HZTSNRuGadpttsqzwYQR7b02dv9lDPEV2k+QGvNclPRqGIo9iLW9Nr2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706793157; c=relaxed/simple;
	bh=IEOCIMWL3VuVKDjq1KTj5OqvLS5MqW+zEmHNDqgSKCU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QZqf6Q13dnjdWNN9imYBEqwnGa4QZ290Ir9X9ke1KZPw8BLFSEyUeTHK6TSGGykQrzlNWnUAFn/7Es9nwNe/DCBHVr2fdLAaSckRbiBetIRaz6VaPesy7zDZPIpdElZwuBYNaqcbvYAsBtUQRKjambOPUQpDcdA7zokANx3KFX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sRtlUqrS; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sRtlUqrS"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-557dcb0f870so1394575a12.2
        for <linux-cxl@vger.kernel.org>; Thu, 01 Feb 2024 05:12:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706793154; x=1707397954; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IEOCIMWL3VuVKDjq1KTj5OqvLS5MqW+zEmHNDqgSKCU=;
        b=sRtlUqrSbE1O1I+UnCQu87rPKNbtQtoBhCnKZB/CrLVYtM0HHxujmmV/klukNwNA8I
         8g9EyyiDN7jLkHxtXfZywcjoJ5xTWfQSn++UrxVoMS8VLm577HpLIOPA4dI3/uWHR+38
         UT64TzUDcPhDRTxNiQb6odUJxqZd/223p1erIPHe2Pm5vVaW3Rc3PfzZrIi3tgfQWHRK
         H9wBdj8ByEoCp6EPhteAuL/iY5f+wbXwBvjjvhwkkEZt1jb/jDVqXqvbr+IASUfGr1Wm
         PebeHW/BsSam2Ap3sKtjGsqdZHy3kvniebaAP3uFp5Vhc5CD4JyIhMUpgeXiO8Bqsg7d
         7CGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706793154; x=1707397954;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IEOCIMWL3VuVKDjq1KTj5OqvLS5MqW+zEmHNDqgSKCU=;
        b=ChdFVrzmbS7uSgsJT7W+17FOKA7GGfRY3CADCiu8t9+NnxuKocWOPYbtd1x56+keeo
         0y2ONpJxvCI0EUAyMdAsDastaXIRRLkU4x+rTkMc8jWcb5OSEgweb9z6stOgTsvAwAPr
         as+d5TNIVhPZ4FJsjSWSbmAmGbq85aH/E6upLhY53lpZOFt4ujiuvrUkh284Sq79s8S3
         wbHZ+N8eW9IMo9a1lCkp1qhu8FOYgR68NPsiCScVIDEUQ3zh6SXdLHmTGYfDo4JQWUhL
         hmKELpRPK/Cm82FALiEYcJ4MTms+T2TqBw7svOy2OPjuVY6n1rGlSU/zYts2e/7BZYhe
         mibg==
X-Gm-Message-State: AOJu0Ywxy/xVLuvOcbhuo2RmhElMNm3UcKYzDF/YUEdQUDz9/2qbxZN6
	q5A8+X3Dq4gECiR2pZrSxf8YTpBc/s1w1qMNMdfOrnATR/0mOHsj5dxoBxFHJluhkRbYHyK627W
	m78sYcKD/NIl3RzSZVAp9osEwK9VtOoHDhJ3hFw==
X-Google-Smtp-Source: AGHT+IFXWxcE59UUQSIEJDGfdMaqYilACqhVAhjyscDVyUldv5RCgxzgprhevI2+oVE7leD1F/Ewef4JRFmR5yxVr24=
X-Received: by 2002:aa7:c156:0:b0:55f:cc6d:9d02 with SMTP id
 r22-20020aa7c156000000b0055fcc6d9d02mr503960edp.25.1706793154180; Thu, 01 Feb
 2024 05:12:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAg4PaqsGZvkDk_=PH+Oz-yeEUVcVsrumncAgegRKuxe_YoFhA@mail.gmail.com>
 <CAGEDW0fWCfuG3KrNSwDjNVGAZVL9NJgF26Jqyd840HfQdNGLbA@mail.gmail.com>
 <CAAg4Pard=zh_5p650UcNdQEoQWZLM6G7KRqdPQHLmaR4oZMJ3w@mail.gmail.com>
 <CAGEDW0dVEk-QXuL=DPVvSP4t5cafz6N-r_SrCxgFnBfFOsixSA@mail.gmail.com>
 <CAAg4PaqgZcTXkWuys7FZjQdRChTkKj-ZnJQCdxpTMCxy4Hghow@mail.gmail.com>
 <20230823175056.00001a84@Huawei.com> <CAAg4ParSB4_2FU2bu96A=3tSNuwHqZwK0wCS18EJoPAq9kYEkw@mail.gmail.com>
 <CAAg4Pap9KzkgX=fgE7vNJYxEpGbHA-NVsgBY5npXizUbMhjp9A@mail.gmail.com>
 <20240126123926.000051bd@Huawei.com> <ZbPTL00WOo7UC0e6@memverge.com>
 <20240126171233.00002a2e@Huawei.com> <CAAg4ParQKj9FUe0DRX0Wmk1KT0bnxx2F7W=ic38781j7eVz+OQ@mail.gmail.com>
 <20240201130438.00001384@Huawei.com>
In-Reply-To: <20240201130438.00001384@Huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 1 Feb 2024 13:12:23 +0000
Message-ID: <CAFEAcA-rgFmaE4Ea7hZ-On4uyaqjWoo-OwwfNrUOdp=+Q5ckXA@mail.gmail.com>
Subject: Re: Crash with CXL + TCG on 8.2: Was Re: qemu cxl memory expander
 shows numa_node -1
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Sajjan Rao <sajjanr@gmail.com>, Gregory Price <gregory.price@memverge.com>, 
	Dimitrios Palyvos <dimitrios.palyvos@zptcorp.com>, linux-cxl@vger.kernel.org, 
	qemu-devel@nongnu.org, richard.henderson@linaro.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 1 Feb 2024 at 13:04, Jonathan Cameron via <qemu-devel@nongnu.org> wrote:
>




> root@localhost:~/devmem2# numactl --membind=1 touch a
> qemu: fatal: cpu_io_recompile: could not find TB for pc=(nil)

Can you run QEMU under gdb and give the backtrace when it stops
on the abort() ? That will probably have a helpful clue. I
suspect something is failing to pass a valid retaddr in
when it calls a load/store function.

thanks
-- PMM
