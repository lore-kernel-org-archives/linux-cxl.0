Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14D229D294
	for <linux-cxl@vger.kernel.org>; Mon, 12 Jan 2026 22:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768258208; cv=none; b=GLFzFofzzepill5ymQNOUOcxAjR7KJl5fIdToIB4Y/USr0FTNnqaRmB5xMa6/6az46JBfWn/D7RQSPnUsA9SLs7aC68DrvRi4Z5vvbCnQTyfpttBGbgdPBq7MurgUE01NuDhd1cXjjZMasOnq8rkv3yVGSZfOi4Bqgq1XE0LK4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768258208; c=relaxed/simple;
	bh=wPQCsYsplNq7W8lcS6RbSSpNYL39KwErD9z0BktBwvY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zg7+NfEZZGPka3VEn6Y6S+IgWN0thEI13hjuaq+MSayaeorS9gM6uyu9y3cAP1V7450jbaT8udp9V6XHtpugmCI9OKvb+1EHS3htO5a7tJuAgbUY9eRVxJ1tmJvpa1FZhSq8vayqJVKG36IZWAyLwzUQLHjhyJlCdUJWvsAejc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mxwuqj6M; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mxwuqj6M"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-7927541abfaso21790267b3.3
        for <linux-cxl@vger.kernel.org>; Mon, 12 Jan 2026 14:50:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768258206; x=1768863006; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Bh+YLR01MVCpD8wIuOotbTVzyhesWYuvCKIvf0TgqtI=;
        b=Mxwuqj6MMrhp4Hj/s3u+RrdFkRNCZ/Jf+TMCLjiZGTGXeMac9O8d8FaqqQA5uD24Zm
         R7xRI+kAX3lAMp4xSdeQM5+eDfVdTYGIV6pLIp3VXIrQ/x6huTN3Rwk9JKW9GyLEjrWg
         x80tDUnCE+jdtXUv/1mBHw0fXZBrpDU9fBBLR65zGnunIpZU453iA5gsUWp4ssN8bodW
         3DLvA8PeH5YOzLavJ9deKLZqSw7Gq94Ze8oRePnTXORE5Rk/GCpriAGa8eJHLhli6/nG
         HG5BICQDDqWOEwMqxrqlMyGiN4VaSuO5XdjqLqm/UKT2EndqBkuAxkV6fZ5pn600H9lz
         rx1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768258206; x=1768863006;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bh+YLR01MVCpD8wIuOotbTVzyhesWYuvCKIvf0TgqtI=;
        b=arFjERtPqFk2u8MD2swx+6EE99guBywsiZgoejcGmceje5PUtjx5UZfD8VbVAy4UP1
         Sw/qLJm6cNAr/rkwCcWoneudz+LpG5Jz8jC+Lpq5rU0WXWiXNZeIo+naKy3pvUmIuLmI
         cVKrIMmJ8oUTfax75cPyOUe4VPCA7vdIpXAYIBvBlSXSw636QLboj0Qt8y2l/+Dn/4Pn
         5yNBPD5c1DosjZhhBORK1MrrSjgFXFG4RK7DnnRR+qUc5d2kvMGh8ntnKkxiaUuL1w9W
         C6XFFL2MFHJaRAMYYoasdRg43XCQeSGlleU0sHHm7hapkzLFby/IZLhYryQhVBfx5Vic
         +vVg==
X-Forwarded-Encrypted: i=1; AJvYcCW68hVF/CLA07Q5Kj2QNvn2Hr+rghFz2G9BZSvac8NJDGUFNEF2Qhan20KT1tJ8Kt10eyQq6JoDDCQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoMtnwvWCpfc5B1IgNZgRUMinH/Q68Cd2c8wdtuPr2rXhm9rxh
	9NvBzFpesfnxHptO4/gLeGRjbScNsmiVi96KaxivLPqQzqVCD7RRojgi
X-Gm-Gg: AY/fxX5eRoMMEd+sWHwXehPnTlUpvIrTf43RIak7ZP/HbUixwbqydXh71gGfDhIhSIi
	PaioISA8zeoj+IC9rh7YgynXcmaPqsa+z357J+kYCSpEu/50E0fZBNvhfuY/A+kRMf9kOdvN4Gk
	gO+qYnBYd5A7/4F4SAPwWh17I2aoyu96GutomuZL/t6MMhuMJz0SMOOfrKGNRBCyeRQymzQRaKO
	RkLg55dcH3d0ZfVmE4s26Cq++kIH2dcczaApCViWrF5V4tutkp966+5P2Uhvn/TY/tpAKCUK8fk
	PQ5Pyv4w3vzd2DpTsNMtRgs5/SiVgDAxor9Xas1UhZu8Dkvoyf6zsZHv8UdG44i2hv55Wo3dqWx
	1Uh86U6IGy9gyDeB8XYc27hpZvv8vMOWZY36y4j2NMzbWpQhbRLEXRaPoz8rb3s/Y3MmozK6wWr
	mP+k1Hd90n1YLcn2tDkbC+k9q1YxTQkg==
X-Google-Smtp-Source: AGHT+IFOXp+XFLyVh4g4H+9xfCU5wrxY/VgPCE6y5+Ou7V/HPXZMIcVrrF6kH8h6Bo2ZpeYswNBQSA==
X-Received: by 2002:a05:690c:3749:b0:788:c21:b05c with SMTP id 00721157ae682-790b57eed37mr161811857b3.63.1768258205775;
        Mon, 12 Jan 2026 14:50:05 -0800 (PST)
Received: from 4470NRD-ASU.ssi.samsung.com ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-790aa6a4d00sm74136887b3.41.2026.01.12.14.50.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 14:50:05 -0800 (PST)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
Date: Mon, 12 Jan 2026 14:50:01 -0800
To: dan.j.williams@intel.com
Cc: Anisa Su <anisa.su887@gmail.com>, Ira Weiny <ira.weiny@intel.com>,
	dave@stgolabs.net, linux-cxl@vger.kernel.org, nifan.cxl@gmail.com,
	dongjoo.seo1@samsung.com
Subject: Re: [RFC PATCH 0/3] Add Support for Multiple DC Regions
Message-ID: <aWV6mZYxGdpGnkWJ@4470NRD-ASU.ssi.samsung.com>
References: <20251203203540.1091827-1-anisa.su887@gmail.com>
 <6931c4c85a526_43de3100bb@iweiny-mobl.notmuch>
 <aTsyJXKnL0SA1hl-@deb-101020-bm01.eng.stellus.in>
 <693cdf385657a_2e71710083@dwillia2-mobl4.notmuch>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <693cdf385657a_2e71710083@dwillia2-mobl4.notmuch>

On Sat, Dec 13, 2025 at 12:36:24PM +0900, dan.j.williams@intel.com wrote:
> Anisa Su wrote:
> [..]
> > > Unfortunately none of the details presented in this cover letter really
> > > show why the kernel needs this additional complexity.
> > > 
> > > Can you go into more details on the use cases of multiple partitions?
> > > 
> > From what I understand, the motivation for DCD as a whole has always been a
> > blocker for the entire series. However, this year we've seen multiple vendors
> > demo memory pooling/sharing at SC,25[1], as well as the development of a 
> > controller that supports "memory pooling and sharing across 
> > multiple hosts" from Montage[2].
> > 
> > The flexibility and control provided by multiple partitions is
> > an important capability of DCD for enabling composable memory 
> > infrastructures. IMO, adding multi-partition support back in from v8 or
> > picking up this patchset would strengthen the series.
> 
> Can you explain the use case for multiple partitions per-device?
> Describe it in terms of what Linux loses if it never entertains this
> aspect of the specification. It significantly complicates the ABI for a
> benefit to Linux that I am unable to articulate.

Let me backtrack a bit here :( I was too hasty trying to push for
multiple partitions.

However, can I ask for some clarification on what a sufficient use case is
(with just a single partition)?

Then I'll (try my best) to demonstrate how this series can accomplish it
so I can help land the single partition stuff first. Does that sound fair
to you? Or am I misunderstanding the core problem?

Thanks,
Anisa
