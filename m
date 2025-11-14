Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7034670814
	for <linux-cxl@vger.kernel.org>; Fri, 14 Nov 2025 12:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763123104; cv=none; b=ro/5PLfGuXVwFUhYYDd5BV88hRWXO3JBXWD6QserSDKc4e9tU00foU86uGdR/QtlLaZ6ce/B5AVHULKv9gJCHKkKBhKy7agbi5SunO/bfmQhTijJATswLINFp6HgKLmAA0sOIgjggDpejBNxgnWB7OFudq8DMnabueeqnoKfoHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763123104; c=relaxed/simple;
	bh=D7DC5uL4Z2X8dZSOZq44ppvBWzR1P9VrOwHfckJIB74=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t+rKFmZNUKBRNZICu/TjKCP4384nlxdKxCzsPMbdzWk+w4CBJx+DVLG6mZgBkMEa3gUuGZ2VPAqMfmvqvh1Zh5dOmOvZJ/tyyiUgg2GuGOTELeyfOo2rOKT84NikuMo/8k02N1gQkAw+UaBzNNY/5JKhSelzbwl6z2oG9RVRNtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4rfJKASM; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4rfJKASM"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-643165976dcso6997a12.1
        for <linux-cxl@vger.kernel.org>; Fri, 14 Nov 2025 04:25:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763123101; x=1763727901; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CnqGkWyuyOdPpbsRCorGUws6JHDjFj9s2aEZUULAgcI=;
        b=4rfJKASMyUhwMI+XBC85LSa5GRJNlNRPKpeYeOqCBDHo83fK8L8qRIi6BaSizjgj7t
         4PVtsjvvMojYEfKnpdM4tpoDZUn3WFk3u0dyUeyQqhMWvl/TE82bTPO/w2HAMl0EYyAE
         eMCp5wZ6WdOLQEeI6ao7jvxfWNME3ekWxe+cERJsf9SQG5sZADLd2mEL9kQLBJmzYD1q
         BORcAD8E8sSu5HW5mIq7UtMMLcoZrVVq9WOJuVAHIU3a3//+olegiJ0BQZdX1cB7gbqN
         1nhrzp28Clrr3z6gLmUWSOUiTnl7n2np3nBBrPUa2g9/dqS/tl0OwubtWCdJQlxAqBci
         1PSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763123101; x=1763727901;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CnqGkWyuyOdPpbsRCorGUws6JHDjFj9s2aEZUULAgcI=;
        b=swDHqGiQXchh95XPy6AXymrcqDgTtorSYXPpwKHtYaLILr5YDBa2rvGD5/T9uybg9g
         FDuTRyqEMbg/F8Am/VCLHAd/eLMYlvMhut2N/yH236O+PRBHWBXXLJr137rYxoudSY4g
         DnEx8qO4SMzT5x2xIYRMDQRTb3zkEUgns6SNzrkdnGAkeFA60Q1ywscmafH1mPbiX2oI
         TzdrIafK9fORLllcyo6fgcHai2hC/ARAtt4o9mcd9cftDDoaijS/bgIl4FEFCevbXFxI
         +kprKSLDc3A9p23DcuWqMIjslG4F8iuqLaOQW+J4JrjnwHTaZVjN8iiCuzdTclZc+8Ix
         4P8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVxuIjdpv7oxYQEhLT+B1QTu1P32KOor9Fu8YEQ2DmUea5e37tLV6OKmcVvbpDNEj9or8Y5RqWzoPQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEZgtXVs6nePV0YSauBPZubnPEMaITWuSs0iupEPwpWDfLTPHt
	10ag7ZhJsncV+Qz8VAiaV4aLVKhKhHJfAnZrGpxdAhmsuCMJGNiSsoOquSIuHpbf9RXG/dzI2sD
	GzFEVCVLbUiH12fx7jWPkuOmRAIpDwBRSHBlE2xDG
X-Gm-Gg: ASbGncu13KiVpg5qXG1dhXFJ9W7Chu61nA4hGKD+ymv+3gwfsrjoaBmEoMEcdoQ5LmB
	5EdY0tP2D3CTRg4zX4eybqQPDLEgTuB9UZ2e7KakF+2gpmClGq5U7Okeit4M3VClT9rMXS+42lp
	H5raJQKCzkGo3sOewQrOxDL8WXczA2ukWEYl5gLtEpICilUTnWslO4/flAvChQSO8VkM/beCjf6
	Uwy+huOZk4G6y4grrZDBhQ4hA9iRWjgQn8teu6Lnu9ISFSjcmXr6QTX3oM9y/X/R69uAC/IZcSj
	UZZ1jYOb5/l21yEE8NFxDfi+P+LWbads4/4u
X-Google-Smtp-Source: AGHT+IH5irDABmMGZpAhpnUvlVYenFsVwXZ6X2xmt7hHD2N3QUeeQ21yBa4LfJ9O3U3wPXL+fECXsccLV9IYfniWJJI=
X-Received: by 2002:aa7:c4d1:0:b0:624:45d0:4b33 with SMTP id
 4fb4d7f45d1cf-64355121feamr44767a12.7.1763123100641; Fri, 14 Nov 2025
 04:25:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251024210518.2126504-1-mclapinski@google.com>
In-Reply-To: <20251024210518.2126504-1-mclapinski@google.com>
From: =?UTF-8?B?TWljaGHFgiBDxYJhcGnFhHNraQ==?= <mclapinski@google.com>
Date: Fri, 14 Nov 2025 13:24:49 +0100
X-Gm-Features: AWmQ_bl8jW_docsBVraFMSwYLTTq5hk31EtHqWGFvt8QiGs4Z3vqGdZ08ivlenU
Message-ID: <CAAi7L5dWCNiD2WOfowdaca09_i6Z2-8xFqatOpjPjA335puuVQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] dax: add PROBE_PREFER_ASYNCHRONOUS to all the dax drivers
To: Dan Williams <dan.j.williams@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, linux-kernel@vger.kernel.org, 
	Ira Weiny <ira.weiny@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 11:05=E2=80=AFPM Michal Clapinski <mclapinski@googl=
e.com> wrote:
>
> Comments in linux/device/driver.h say that the goal is to do async
> probing on all devices. The current behavior unnecessarily slows down
> the boot by synchronously probing dax devices, so let's change that.
>
> For thousands of devices, this change saves >1s of boot time.
>
> Michal Clapinski (5):
>   dax: add PROBE_PREFER_ASYNCHRONOUS to the pmem driver
>   dax: add PROBE_PREFER_ASYNCHRONOUS to the kmem driver
>   dax: add PROBE_PREFER_ASYNCHRONOUS to the cxl driver
>   dax: add PROBE_PREFER_ASYNCHRONOUS to the hmem drivers
>   dax: add PROBE_PREFER_ASYNCHRONOUS to the dax device driver
>
>  drivers/dax/cxl.c       | 1 +
>  drivers/dax/device.c    | 3 +++
>  drivers/dax/hmem/hmem.c | 2 ++
>  drivers/dax/kmem.c      | 3 +++
>  drivers/dax/pmem.c      | 1 +
>  5 files changed, 10 insertions(+)
>
> --
> 2.51.1.821.gb6fe4d2222-goog
>

+Ira (you're not listed as a maintainer of drivers/dax/ in the MAINTAINERS =
file)

Is there anything else required from my side or can this be merged?
