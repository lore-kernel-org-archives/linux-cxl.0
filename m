Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1B53A5E94
	for <linux-cxl@vger.kernel.org>; Mon, 30 Mar 2026 13:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774878816; cv=none; b=uKN3+j8yG0+jBWf4kdFEADisdI42zQxmM5km2NNhK56UhnP6GzGo5KfkO05R1tjHAWCvk2NChdtsk+Fv4+UJwJpj5x4SXZMfDHXlX0dGLWK7rhg9g5Q0F5a0gzFfpWpcZwFlVEJ4wYVMSXHr+ycKoRRaFl2QC5Xeez2T+dehbEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774878816; c=relaxed/simple;
	bh=xwl2wvmpLFqYRffPQxNL26mBjggzJSbkOmLrL6ckK6U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mEDDbNVMksgQpqHsWTa9Cv8cXwvIAnSPM8cEqWXkU/dxmPPOXD2PJkA/kmJMWuAVmk3aKA2SbthiqrTbVDeMUol6j16+vfLIrtKxGU0sa3g0v4Xo29xIn1kym1BjGJg4qPh4xkhkb02Mv8cx8lVclfUVSZ2HaaPyULNOGJKkEj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L0DlGmiI; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L0DlGmiI"
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-41c420d1460so1727131fac.3
        for <linux-cxl@vger.kernel.org>; Mon, 30 Mar 2026 06:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774878813; x=1775483613; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l78p31yEoZ3arnxGyYF6VPRhnCnmHLaaS+hRioFyojM=;
        b=L0DlGmiIAhqUVBxH0AhO3HmXIYbw6tETboAks6pC+CNNiAmgWr5Gr5RJIEXmL1jNHx
         5Ycz6O4Q+fpK9qOFiEmLqJ+qICFzCWqWrsNwjZ7apRUCwHGwXuoclVmJcYFnpToWNNdM
         oH2sRTcghUr+6AyzC00X4EGoDNoLG6FlBJdEfImRVHUsK59HVpBreio4PLDs9EoNWkR9
         JuCPnuUfVc5qzK8+dHbp9JgsQKaVCS2g2+lpKTlFKOOmWH7aD432Tu3Ln9WKZdTesqkn
         RiwnWEsCToK+r9aBQEA7s3kDMiydBGhxe2D9T4bdnjyLpy5znovIgXCGaO0tR1NpoCih
         PqIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774878813; x=1775483613;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l78p31yEoZ3arnxGyYF6VPRhnCnmHLaaS+hRioFyojM=;
        b=C3kcAMXU1RBVMAcymVa7si5I9Q7djAi5pj9TDRRjMmZPyP4u2JQiDRbFb4EH/2W7Il
         W5TaEDErRgDishgvoBldn4VgLmKoQK534k7Kf6Iyst3e37rEeckMYRhqerEEvufFY09I
         2Vz/l79UuD5CUvoxLonKJMT/M8nA7ySnGaNfWJLEwFELNESFXE9I4qMiOBq56F9T8G19
         bbJxPk3v5PscdHZwcRpRz95OIrSrK4/wNC/8vyWBklwmPj49fZH/UOsjf6Vth3FVok0M
         vGd67F64kCz8my/5TVC9Nz0IbiV6L+msK7RTx94Bddt4kMOMJWYw1ogKBaCoRuhCF6ta
         elvw==
X-Forwarded-Encrypted: i=1; AJvYcCUodgmQYBxQzmlTxdwjXIPCNYO1gIHIyEHRAkMZonllrLfxmRHkSdBsZoudYLruC8GxFlsGK4PF7dI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrooOXbf3jVz/DLgWKiZM6qFRlDvIhQI/lLc1jYCOy2rampQ9H
	U/vhl+sxV9c0KZbWgt9FR2cjt7TJew4Fb3D0DAP6VaHHqJrmw0UbKGkU
X-Gm-Gg: ATEYQzx62ZVgj1sWyCzkQGXivXjfIP85rDFZuZSRFxTM17UZjMLgG6GoIQU/7Cevau2
	gJuR8qEglyAD9pMpXXPVZGCBtW133FZEWKlCm9yimh3bI/v3bMlJ7GoaVHVKkLlLpBxQve4Fmw2
	/wbx47mClmErCjFlKYoid18vPVkXGFYZaXuoAHx5kNuyWQJ4fo2LO3GJAgDo5QP4eBmXNodymU0
	A/xptVstwbHvYEoXnuBgodt2ZEI05/trWpggaVQ2b+yp+2nNpYrkZEKdJ0uW1INffhow3xRllDb
	mvaV0megUOeOd3hOKLuoy5APVJfgtBGY1OjfoJj2ZoLkQVGeQ71dNRE1sbxkPhs5sVLoF1TcoHi
	6RaoZGwrOkuR+U3TYhRgwB4gWnbrImKxSs5SIWK2nCW0rl30LQlJPLA7JvV+vtUrliEGxHsm1Qo
	QkSNLKLR0vvAgLc1LIgUEnQw==
X-Received: by 2002:a05:6870:d376:b0:417:9244:d180 with SMTP id 586e51a60fabf-41cec375cc6mr6655147fac.46.1774878813034;
        Mon, 30 Mar 2026 06:53:33 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:5a::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-41d04cf9ceesm5252471fac.15.2026.03.30.06.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 06:53:32 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Hao Li <hao.li@linux.dev>
Cc: david@kernel.org,
	osalvador@suse.de,
	akpm@linux-foundation.org,
	vbabka@suse.cz,
	harry.yoo@oracle.com,
	joshua.hahnjy@gmail.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH v2] mm/memory_hotplug: maintain N_NORMAL_MEMORY during hotplug
Date: Mon, 30 Mar 2026 06:53:30 -0700
Message-ID: <20260330135331.2948804-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260330035941.518186-1-hao.li@linux.dev>
References: 
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 30 Mar 2026 11:57:49 +0800 Hao Li <hao.li@linux.dev> wrote:

> N_NORMAL_MEMORY is initialized from zone population at boot, but memory
> hotplug currently only updates N_MEMORY. As a result, a node that gains
> normal memory via hotplug can remain invisible to users iterating over
> N_NORMAL_MEMORY, while a node that loses its last normal memory can stay
> incorrectly marked as such.
> 
> Restore N_NORMAL_MEMORY maintenance directly in online_pages() and
> offline_pages(). Set the bit when a node that currently lacks normal
> memory onlines pages into a zone <= ZONE_NORMAL, and clear it when
> offlining removes the last present pages from zones <= ZONE_NORMAL.
> 
> This restores the intended semantics without bringing back the old
> status_change_nid_normal notifier plumbing which was removed in
> 8d2882a8edb8.
> 
> Current users that benefit include list_lru, zswap, nfsd filecache,
> hugetlb_cgroup, and has_normal_memory sysfs reporting.
> 
> Fixes: 8d2882a8edb8 ("mm,memory_hotplug: remove status_change_nid_normal and update documentation")
> Signed-off-by: Hao Li <hao.li@linux.dev>

LGTM, thanks for the new version Hao! I hope you have a great day : -)

Reviewed-by: Joshua Hahn <joshua.hahnjy@gmail.com>

> ---
> Changes: simplify the code. (Thanks Joshua and David)
> ---
>  mm/memory_hotplug.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index bc805029da51..05a47953ef21 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
