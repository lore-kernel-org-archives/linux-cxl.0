Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6346A78F5E
	for <linux-cxl@vger.kernel.org>; Fri, 13 Jun 2025 16:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749830923; cv=none; b=EkvvfS13LFUY7iisdQ+qPNyU+Nr+Xgtr/qpB65jPEk1JntyVgGLrmW0nBdEL1vhQGHwQ/qjRvqO9iyII5juzMw7uzS/MVeJ02yjaodiIRuI+CxwkKdHYDZ+dccXDQz0MWogLUm2Tz9+UzchgD9ajAbxiW/V7zsLpXU4ESWnYaKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749830923; c=relaxed/simple;
	bh=q0AGVEj3qEhFG+8N5hRJQD66tcaORTK0Qv/mJVuZYFI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WMD2U907JiJQ1PqOVqmhfVj7cMlN4Q2fdt/5OCvdJ86FTQuVzs4WgOHlLwXHwfMbr/fBChv8GIT1u/Vj8OLyR8VNouqfr+eBi1csCPFDU3uDr+lTbqGJfCN1TzH+uiqWy2qKxhDOgtbItOBkHB0yCx/PxKqFA7Z7GFVUC30HrLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mgbgi2lW; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mgbgi2lW"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-70e447507a0so17148937b3.0
        for <linux-cxl@vger.kernel.org>; Fri, 13 Jun 2025 09:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749830920; x=1750435720; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=q0AGVEj3qEhFG+8N5hRJQD66tcaORTK0Qv/mJVuZYFI=;
        b=mgbgi2lW17DFlLCGjLaImvxLHsHoHhh6Ow40uHldlOjfGTt90Yd0mjcJrH0U76Tmeu
         BKV6sDVRgh/B4z9IFR3boVT3qbHEnEgHN7F/9wYR6O7MaumOUPuve3JY92SMnTCxr181
         CtKShX4HuGSHGobKdy9rvg+PmHseiZmMap2LrelxkCmVGQ4rcbedGurBJAT+/D8oCUSh
         VX/rrbV7MrqJGcni9FWuDAno3UI9gqqxNqs+ns4LQMDn4rj4KLWlPXbT3IextxdJeu35
         mVOmkLMEU8JIg305s5C5+3hG5hoxU6QFxZTwRqeWtxrym2XCP6Gs43b14jJGCnzdUuRU
         dSFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749830920; x=1750435720;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q0AGVEj3qEhFG+8N5hRJQD66tcaORTK0Qv/mJVuZYFI=;
        b=LLS0GYrOZYS5K9Rcbhsa9WSwvjQLC8K9VIIuojJZan8pEKVuoI677HhNrDDu/oEKqF
         aIGKA24vYDXQlKuTbgo63MrpnUnPqAiy+TYACKir9y3Bs79z9+TCSCZIvunzInauax0I
         kf7V6DFEEYmtnikNfqBfTPEfK4g5TOR37zkHmYhYw8T3pXQrJsT9LzM0847aA5RBYED6
         CoMJ9jjRQpyS/OtTbhDE91qpeAY3ssnkpaR+j6sWRq1DsofBGg8kQfufF04ceddfzALx
         WrDTeGlDpUuyZv9YLZX8JVbkd47bePmy76sok07VuzgSk6XJlV9hgjg8hPkmzCca4sxA
         hpow==
X-Forwarded-Encrypted: i=1; AJvYcCWt8NGdWwpCdmtRub+LRi+uxFCL3ugwyz1TYkwd8mirUK5piwdrKbpOgl1kqCEg6sZnv9nkHEYSGVM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyjplbhk3okVxFEWi0XbKV3ADphKVZ8m8FRTV9PCjVC55GhvfwD
	RrZVgVcGCfsu2J0LTAuD1/cdywjXReqcYbkGXU+ZWVkOT9qFQu0S9Zc146+9qrd1J3M4v9CVAOF
	vjUJo9vtMoLSlLp2PwRRZx3RC9m3M3O/XzGU+bAy2PA==
X-Gm-Gg: ASbGnct82fgom4si2WyLwmMB8lM5yhCSH+SHdejYF0GQxvHPzhocJIkmjP9X3JA/D0a
	WxeKByosdV6A78MFOwouJo8NzpdyTrgROXd2PIV8/IYVb2FaEZEckj9booEnw2FmE4ZaQ/h1+uW
	yOFrsMszRBp3y+2RcvvS2QfzzS+i7iw3q6JxDeAZ6xKyO6
X-Google-Smtp-Source: AGHT+IHElaU3RUXZGp1oeZWJCJPSrUK/n0tHMa2uBoZHgT+aAWen+V+PnRFJAoQg0vBu1VZiHvd4z51Hi6eHefpTBI4=
X-Received: by 2002:a05:690c:dc1:b0:6fb:1e5a:fcdd with SMTP id
 00721157ae682-711637ab1e3mr54822697b3.17.1749830920354; Fri, 13 Jun 2025
 09:08:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250612134338.1871023-1-Jonathan.Cameron@huawei.com>
 <20250612134338.1871023-3-Jonathan.Cameron@huawei.com> <CAFEAcA8eC9TpGyrMARRUWs4q1o7LACD03zLAwPnTRU+m98LrWQ@mail.gmail.com>
 <20250613140954.000013f5@huawei.com>
In-Reply-To: <20250613140954.000013f5@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 13 Jun 2025 17:08:28 +0100
X-Gm-Features: AX0GCFtBfo3kmQAF6wwgQG8QxEjF53UX0ugXUJJfukHAY7fltSOjcRO4-bqAPPo
Message-ID: <CAFEAcA_ZbAnUS4Ufa+jsOgj6aeRS5JHJP=scw6d0qXd3NNtqdA@mail.gmail.com>
Subject: Re: [PATCH v15 2/4] hw/cxl: Make the CXL fixed memory windows devices.
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: qemu-devel@nongnu.org, Fan Ni <fan.ni@samsung.com>, mst@redhat.com, 
	Zhijian Li <lizhijian@fujitsu.com>, Itaru Kitayama <itaru.kitayama@linux.dev>, linuxarm@huawei.com, 
	linux-cxl@vger.kernel.org, qemu-arm@nongnu.org, 
	Yuquan Wang <wangyuquan1236@phytium.com.cn>, 
	=?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
	Alireza Sanaee <alireza.sanaee@huawei.com>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 13 Jun 2025 at 14:10, Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
> For these specific devices (the fixed memory windows) there isn't
> any state as they are representing fixed configuration of the system.
> The state is all in the host bridges and beyond. I'll add
> a comment as you suggest.
>
> Currently CXL emulation is completely broken wrt to migration and
> there are some known issues for reset as well. Both are on the list
> of things to fix. Migration is less important as the only current use
> for this stuff is running software stack test cases and for that
> migration isn't currently of interest - that will change for some
> of the virtualization related work that is just getting started.

That's OK as long as something somewhere is registering a
migration-blocker so there's a useful error message if the
user ever tries it.

-- PMM
