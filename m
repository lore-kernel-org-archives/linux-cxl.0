Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF09BA932;
	Sat, 29 Mar 2025 22:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743286414; cv=none; b=VP+D8CflKLgz8SYf6iru/4HlxVgnjuIfW5s2lfxRmXcEbTyYthk9GcuUzsIT7J3NamVrlNxxSjiiVfaYW1UqUQ/rf/Pn2SjKNN14sOzrQ0os4fWKpAOxGFbZQdOleoRhDfZ5/UNgUeNR05fnqtulgmxr8Se3U5y2TapKoDkQCA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743286414; c=relaxed/simple;
	bh=UNcrhMVK9+6ggiDuG4lotXX9rn+JtIXO2R2M7+oyDsg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r0kwAa7sDvedjWocewg254nTs4R3GQtF8gWzp8gqPYjPPUbL07ugUax6Sb8fO29wqK+wKDkoX45frXKiDJDCYapSfRaIlThHR+9L34rF84KDSWs0F7zHVKmnnxHj7WGY2cN6M5c5NjnHN6ZPFE8BXLjL2KBUpWyJkfVG4rYaEec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BQr6n6PV; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BQr6n6PV"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6df83fd01cbso15761606d6.2;
        Sat, 29 Mar 2025 15:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743286411; x=1743891211; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UNcrhMVK9+6ggiDuG4lotXX9rn+JtIXO2R2M7+oyDsg=;
        b=BQr6n6PV7+I7JBHR7hZEXv7ItgzFPDnG5HHmrrG160bSVuxopQ1YUoOAsfiX3Rvujc
         vdBEy4Vf2hbNmuR/WNzZ7gt64UfAr3138t0ARa0IcqVGY4LOZpmlwz3FfUpT951zYRxq
         qWf93Bs6SGKK/yxzwbzyOl+lonCB9pSIIryoonh4JOTrWh3rLjSyldDYh78l9In1lFv/
         XbBn+Uk+EPZy2ikQfJPf7rEWkFLlhNbsPQ0USC370Sp0Pmq7VMncUG06jRes7ueP+lkp
         5W0mj8j5DdoXogKbFncBJ2Yej5azG2uG1DRYVI4PozUQYgAaIuiB6wl0GkA2bj/cMMn9
         hZ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743286411; x=1743891211;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UNcrhMVK9+6ggiDuG4lotXX9rn+JtIXO2R2M7+oyDsg=;
        b=CrV3ZVBYngQKCbfVCVGE02w6Wf903JiE/xLFddiQD/yzmP0Sx9BJYTxFofJHcTrtZc
         0KmBKCp4zd1gY485fzBC8cMKfh7vAmB1/xjD4p6t9fuUk1FENYF9j25Cxt1rs++8Hcjl
         Uun6U8ry5GoQo2ENpVD/8TklQlZlTqtvkCHjOkpVgR8x7ymq0CIT6F84wGlktXkGWD42
         sh0jFWYHDj2twkA2Yn4dLFFRdV9EiXTJWVS7ejwjVw6aN/KHOHF+lgfTkr5TrknExG5I
         vM70Rn5/gQXsBGZooN3UtaOC2tBAoPAqaF5fVYoadgMdlTwx0uSXdifAE5AuTMymablt
         ym+g==
X-Forwarded-Encrypted: i=1; AJvYcCX6NKFWmufb0kv7Ds1LNXenVVb5fG5bKsWw0lYSS6pr5t9UBHKKPnMLko3h6WT1mSB6SuX0veEtxaM=@vger.kernel.org, AJvYcCXOvhGy8jFB3vzBJJMEMcXAHuFzpq5Fz9aCNdkyz4oEK2ohE6KR/iqx2MP2IgOAq26E3PXqETQGJyYT6mX6@vger.kernel.org
X-Gm-Message-State: AOJu0YwXBgzym0QRw5dGp0YypIT9ILTXNRzHGcb5A5WHoE8nLB+f5Els
	ZW311TkMFjTwxf1/08BflafKRzXw+voHs2DkDpsnhTMWU4xfFMp6Sl/qqGFNw8wTP2SALiu2G/a
	Y4m0+HvJL1eWf1JLBoJATWoFV1bU=
X-Gm-Gg: ASbGncsZE3yFrihCNeaZWLYBEMhjS8QVag0mIwhq4m0ym5tcguU5dEfztx64C5PXSbY
	5GWZC6BIVaiD0piYqgF3zdQiYcm6zhTKbU9sft10GJVEacFvnZAaBRanhVzyAwMMdK6joumRhM8
	dKPKW2gJzK4ohoIse+SPidMxJlSXQFXqnWwpo3dF+Rd3EY1e3B+ivrrYOGTRea
X-Google-Smtp-Source: AGHT+IE1GhbaiFupNzncNjral4X+Qq2nlO15G8JOuDDqzfK9PWWFHI6anDeFzMZMXwuRiR2eJqZrYIo2+LUfw5pZjpY=
X-Received: by 2002:a05:6214:1d2f:b0:6ed:12b0:f181 with SMTP id
 6a1803df08f44-6eed5f9c369mr52180446d6.14.1743286411543; Sat, 29 Mar 2025
 15:13:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250329110230.2459730-1-nphamcs@gmail.com> <2759fa95d0071f3c5e33a9c6369f0d0bcecd76b7@linux.dev>
In-Reply-To: <2759fa95d0071f3c5e33a9c6369f0d0bcecd76b7@linux.dev>
From: Nhat Pham <nphamcs@gmail.com>
Date: Sat, 29 Mar 2025 15:13:20 -0700
X-Gm-Features: AQ5f1JoFtT9vRL_SzGvf34p_JQN2uIMkBVhEuTZsO1Din3fxRh7P9rjpu-oQRZ0
Message-ID: <CAKEwX=OVRaUcD8A4HkCZWisNPH+Q9VzOGMJeHnOi40AnHsjjjw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] zswap: fix placement inversion in memory tiering systems
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, hannes@cmpxchg.org, 
	chengming.zhou@linux.dev, sj@kernel.org, kernel-team@meta.com, 
	linux-kernel@vger.kernel.org, gourry@gourry.net, willy@infradead.org, 
	ying.huang@linux.alibaba.com, jonathan.cameron@huawei.com, 
	dan.j.williams@intel.com, linux-cxl@vger.kernel.org, minchan@kernel.org, 
	senozhatsky@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 29, 2025 at 12:53=E2=80=AFPM Yosry Ahmed <yosry.ahmed@linux.dev=
> wrote:
>
> March 29, 2025 at 1:02 PM, "Nhat Pham" <nphamcs@gmail.com> wrote:
>
> > Currently, systems with CXL-based memory tiering can encounter the
> > following inversion with zswap: the coldest pages demoted to the CXL
> > tier can return to the high tier when they are zswapped out,
> > creating memory pressure on the high tier.
> > This happens because zsmalloc, zswap's backend memory allocator, does
> > not enforce any memory policy. If the task reclaiming memory follows
> > the local-first policy for example, the memory requested for zswap can
> > be served by the upper tier, leading to the aformentioned inversion.
> > This RFC fixes this inversion by adding a new memory allocation mode
> > for zswap (exposed through a zswap sysfs knob), intended for
> > hosts with CXL, where the memory for the compressed object is requested
> > preferentially from the same node that the original page resides on.
>
> I didn't look too closely, but why not just prefer the same node by defau=
lt? Why is a knob needed?

Good question, yeah the knob is to maintain the old behavior :) It
might not be optimal, or even advisable, for all set up.

For hosts with node-based memory tiering, then yeah it's a good idea
in general, but I don't quite know how to have information about that
from the kernel's perspective.

>
> Or maybe if there's a way to tell the "tier" of the node we can prefer to=
 allocate from the same "tier"?

Is there an abstraction of the "tier" that we can use here?
