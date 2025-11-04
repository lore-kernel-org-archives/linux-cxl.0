Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9827E21C16E
	for <linux-cxl@vger.kernel.org>; Tue,  4 Nov 2025 16:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762273042; cv=none; b=XP1UYawyW67iC5UWqU86gCUnrBX/7vzlVT5FOudJ5C4a3etuM2pT1C0cR8zYFS60g7qP7Potr7t2w8Oa0fCt5wIxLh1ka4iXTKw+U0+xx0loYnzbmG01XtEiMozyCNRrNl8H+58n094xnbTKErnv7KhFLhsQXaEcfiEyrVwveOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762273042; c=relaxed/simple;
	bh=eUTPZwWTcB8Vi4XRFtSvBFZYJiNgzbMLeTVBr56RwI0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eii38u/R6Vo6KQp+EdqwQA8+LxpL4S/CkDpnedsMZ6hYvhpcvpTnNonclwUGE+YATL+pEmYXLFIANn9xUoCUb2eA4wJ5If2P27bUdUniDYQCk617DaL3i17d+StL1uAXPrMIOzG116e9C1y08oZT3K2bbHcoXJVToemZpL3Y/hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jP0A1Ink; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jP0A1Ink"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-786943affbaso12565237b3.0
        for <linux-cxl@vger.kernel.org>; Tue, 04 Nov 2025 08:17:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762273039; x=1762877839; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=N6nR/2K9cY3+SI3+cUdNzyMYZkm2xDvgsUkuGKj0bhk=;
        b=jP0A1Ink/YRug+E4LtTefyC5sYf3tLXoGEJ3wXaPyWUNuDoBUeG47gT+b0guUiaQIU
         xxWjCPQIwbymT11IPq6WNm6EZT8gDeVpg8kqTI0ebwfYjEXwFZUeq+m4RBOEXBySam5H
         VBoHyHWTFXElO9IB+Pk1spxYuIoQd9sl4X8p5gO8YWtU3E6dS4knI6bxo2s8KHvyT8RC
         6WP0PsUx9KHmui/SMt7KaQf8/BlsUQokHa0qnKqlRbnohRfxoaZqLEeKDCclRkcCtmQm
         EYiHTd7Qn7km6EfHXw7v7Ullh22YBQBrJ3llsWrGWLJ16jH9zUv3lxIeCcSzCY5VKPJM
         HmGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762273039; x=1762877839;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N6nR/2K9cY3+SI3+cUdNzyMYZkm2xDvgsUkuGKj0bhk=;
        b=h246GTwKcFhj47Rnmgd5MkS6G8Eh43ao2OiWyWiviiCMHK1eCWUct6JwYg99tEuGqq
         AGLHFuJYXCwbn0Fo/3tgwOtdQtk6yjsi+DC/VpVWMHFntNCU8vlCSfb9B70V4Yww2uHp
         SkwZyvrDSgc67mCATqbrGU5Jf2aqV0wiGD7TXOewZLU1VHfYFfgCWuFt60AlqsaivE+D
         muyvn27IlXTw9y5ei1N2FpRIh+CW9/dugU477q8KcpyBfxwmNzicgA7sNZKS+dzVhRR3
         2P+kdCQCli/aQ4ExsvI5d+BRzsvxdPNjeLwUw8/DFzW6MIDy8d0ewPuanozodd4FPaaP
         Q/UA==
X-Forwarded-Encrypted: i=1; AJvYcCU5Pk/JwNdW3VsruzP2v9Q1jAKkdR1KmeHeh/JalRQgyRwwfL/q1ZnSHFFIc1BbyW+7QxfkH+QEvxc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7GJoA3CCjMmhsNhUI/joV5lak0uye7iY1kBCNpd/5GdUkONI6
	IMiHI1kjG/8Y1Fdi7wIzug2YRQoaFhSvBHg3pzF2vX60k/iOumyL/DgNt6nSRXzsM5VvDa7DyBg
	lbjWLo1IKbEbuGbAzmuL4n8P/lTgmlnmyHkAlGQzJZA==
X-Gm-Gg: ASbGnct7bx0nXVZiyD0owpmQpwAi9zE3dXuO6515l+FaeVTf+b++VE0m5aCz6jqj6X+
	p2Qpz9B3NGGyuytl1f30GRZXWzT4CTJ30nNyBjw3htGcTseEad2+SIX+VtGlF3twRFAaFqoDFFN
	76doBbvdTPRWeamnnyCj7qNih0rrCvOjk08zibGG4RXobSGL2kJ5eIk71sp2j5R4GSQN1kCWq2s
	GCQnWtHHxMLEoGiouR59ilsMg8hFKLJrmQvShQ+0uv02oIB2LGLmo13A0mhhg==
X-Google-Smtp-Source: AGHT+IEQA/zz1OkKWAJjUZ/uTRsiM40/IdTiRWnDiL3N9O45E9ikBGJ4O/38yyKOW5BISftrMIgzR7W2yc4/v0LxT/U=
X-Received: by 2002:a05:690c:2081:b0:786:6383:658b with SMTP id
 00721157ae682-786a41d32b6mr113827b3.46.1762273039418; Tue, 04 Nov 2025
 08:17:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230228113926.11485-1-Jonathan.Cameron@huawei.com>
In-Reply-To: <20230228113926.11485-1-Jonathan.Cameron@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 4 Nov 2025 16:17:07 +0000
X-Gm-Features: AWmQ_bmnenLb1jgyqO-h8dScu_xe7WMIATgbA_sN_1Is8wPZVE4sP37SKfbNhok
Message-ID: <CAFEAcA_Dm89kafy028KWjbtxTRdCKLgc4KGCPJwxLdXf6monjg@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Add Fan Ni as Compute eXpress Link QEMU reviewer
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: qemu-devel@nongnu.org, Michael Tsirkin <mst@redhat.com>, 
	Markus Armbruster <armbru@redhat.com>, Fan Ni <fan.ni@samsung.com>, linux-cxl@vger.kernel.org, 
	linuxarm@huawei.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 28 Feb 2023 at 11:39, Jonathan Cameron via
<qemu-devel@nongnu.org> wrote:
>
> Fan Ni has offered to help out with QEMU CXL emulation reviewing.
> Add him as a designated reviewer.
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> --
> Thanks to Fan for stepping up after I requested help following Ben
> stepping down as co-maintainer. Fan base been active in testing
> and review recently so great to have Fan on board.
>
> Based on patch [PATCH] MAINTAINERS: Remove CXL maintainer Ben Widawsky
>
> Based-of: Message-id: 20230220212437.1462314-1-armbru@redhat.com
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7ea56c6ccc..838e1a91a4 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2633,6 +2633,7 @@ T: git https://gitlab.com/vsementsov/qemu.git block
>
>  Compute Express Link
>  M: Jonathan Cameron <jonathan.cameron@huawei.com>
> +R: Fan Ni <fan.ni@samsung.com>
>  S: Supported
>  F: hw/cxl/
>  F: hw/mem/cxl_type3.c

Hi; I noticed today that Fan's samsung email is now bouncing
with "550 5.1.1 Recipient address rejected: User unknown".
Do we have a altenate email for him, or should we remove
his entry from the QEMU MAINTAINERS file; and if so is there
anybody else we should add as a reviewer for CXL ?

thanks
-- PMM
