Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB6412C7FB
	for <linux-cxl@vger.kernel.org>; Thu,  8 Aug 2024 19:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723143746; cv=none; b=mIGYpxsbgNUJWLU9eg0WsAcJlDjTQWRVH5Zc+OIxHOFyo3Ot5d76KYrei+9r6p0VL+r2cqohq5KDJts2dwa1oyPhMyOAf6yKczmgB09LXRKzw7TLme7DL9CLYpOx/lmm7vpK3j3tXypwG54WOCodyZm5kGq665k8P7NRNIZmBmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723143746; c=relaxed/simple;
	bh=Y65uf6qqSRpIHJ9WMhbwfu83kOfz3UXQcvs4i5JT3n4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TXpxMBuvEjpORw3VTho81WG64NUhY+UawRCK08V0dHJ+IDc51Q/K8+PKK7JQT1jQrBtrDa7Zkcpl1jER0kaXQYFeoAwAs0Tgt47IU+gTcE37gR4B2Jekjie5BD8kjFNGdeMlA7Tgu5D3wDMr0czw5humruj19uCGuUkERHZTLCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=nfTYu4hZ; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="nfTYu4hZ"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-44ff6dd158cso7602871cf.3
        for <linux-cxl@vger.kernel.org>; Thu, 08 Aug 2024 12:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1723143744; x=1723748544; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y65uf6qqSRpIHJ9WMhbwfu83kOfz3UXQcvs4i5JT3n4=;
        b=nfTYu4hZnfFfUGWky2YK78XbUXlSvJb/1z1AjDVDVh8s0rtD049OBx1WHvV6bF5NVf
         B9VsJkcSob8UFSDdAGsq2H+0RgLPssBItONQN05gmtS+kcfoqtqgYHxKy9bY5d61H4uF
         qPXDjnLT2jXsus2rV1Qs6kviDvE4qRCfQ9td9G9A6lmznqjZ+1QQnu8CgLfEXwL+A3U6
         5bHzzlWOXOwRA1cN/WdXdIktAt+KJvrSQAoRrrVft/MqD3j10sRuWz0m2V+4m+xUmbzC
         WxSbfhN25Umvnughuxfem/ur9qDHIXnTx7ioxvQWdI7a/z2g6P88RF6ZR56Hj1rDPq+P
         onlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723143744; x=1723748544;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y65uf6qqSRpIHJ9WMhbwfu83kOfz3UXQcvs4i5JT3n4=;
        b=BeVYpNcu45etWi9DVigyzkOPpqx8iyVWfZunmyqtEOSTu4mFR6KDqYjgAKEuORTkTc
         h4B431b7dzvWVNUfAFPZGNq0istQRbQwQXqyIyHV7Opa57ixCv7ajQ68QkznwMRmZgPK
         tv62eAIX3MbT9MUETEQIFpsZ5AhpAjVAYQtgldKwIAgD9IT03Hwql0ppMkxJ7E6Waa/s
         RPvwABP2NnY8ZZ/oe0A10fkSAVVTfjpsY0G5ukPpyIhQmF4WRyCm+ZdXTnE4X3JqiSNM
         xQTRd6QVj5F6WyVG2pZ3je8r5EFCEI50rbjyAPdNyQHhNOIwtLc5T3dTF2x3fua7pccL
         9CYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnjlIE5OTlsw1Jwd5Rdgkz6kwX7bIA9khWXucwO0URQYhg5k+5ZCyonYJESbZhRsGo9Jz9w+jo6l1rKmh2Jt12pxktUTTT9Oq6
X-Gm-Message-State: AOJu0Yzt4ftOoJzSfr+Gj45lQAwYJK9Kcil++NHbXusZtuneecjTV3yv
	Iyvoo/WFFISnm07ifkbRLU5QHTPKawSvwJ86lzh0mIBvT07B84Ik6QlNjgmJxU4fuWlNXSosBcl
	WYvudJdcMBqn5lC8PKdlLfwVcz/roqL4z6rW4yg==
X-Google-Smtp-Source: AGHT+IExI0OeHf48EBthOwkTI3aIjxBBaA3Ik679zCw1G8yDECFvltEArNPD+bABqbdLjI6o0QR2sTPYH07apAlR/WI=
X-Received: by 2002:a05:622a:4a0d:b0:447:eb33:410d with SMTP id
 d75a77b69052e-451d421cefcmr36717101cf.18.1723143743702; Thu, 08 Aug 2024
 12:02:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240808154237.220029-1-pasha.tatashin@soleen.com>
 <20240808154237.220029-4-pasha.tatashin@soleen.com> <9cf6cbc1-67c0-4ae5-ae5e-5033631e61b6@redhat.com>
In-Reply-To: <9cf6cbc1-67c0-4ae5-ae5e-5033631e61b6@redhat.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 8 Aug 2024 15:01:46 -0400
Message-ID: <CA+CK2bD-8W7AP+Oedm0m9EROQZ4euLjZBhqaZJARLW02HWd6iw@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] mm: add system wide stats items category
To: David Hildenbrand <david@redhat.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-cxl@vger.kernel.org, cerasuolodomenico@gmail.com, 
	hannes@cmpxchg.org, j.granados@samsung.com, lizhijian@fujitsu.com, 
	muchun.song@linux.dev, nphamcs@gmail.com, rientjes@google.com, 
	rppt@kernel.org, souravpanda@google.com, vbabka@suse.cz, willy@infradead.org, 
	dan.j.williams@intel.com, yi.zhang@redhat.com, alison.schofield@intel.com, 
	yosryahmed@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 8, 2024 at 2:20=E2=80=AFPM David Hildenbrand <david@redhat.com>=
 wrote:
>
> On 08.08.24 17:42, Pasha Tatashin wrote:
> > /proc/vmstat contains events and stats, events can only grow, but stats
> > can grow and srhink.
>
> s/shrink/

Thanks, fixed.

>
> I think we discussed exposing this in /proc/meminfo. There, it would be
> much easier to simply have a global variable, print it, and be done with
> it. Like we do with TotalCma.

Originally, Sourav had proposed adding per-page metadata stat to
/proc/meminfo, but it was decided against, because all the other stats
in /proc/meminfo are part of MemTotal, but memmap allocations are not
always part of MemTotal which makes things confusing.

This is why it makes sense to keep nr_memmap only in /proc/vmstat.
