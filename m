Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C473398E
	for <linux-cxl@vger.kernel.org>; Thu,  8 Aug 2024 19:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723143972; cv=none; b=RU1olz7Tc7p3cWupNH07ZmN4vXZXLXzLPXRaZaSdvCSJ+N91q6ZG25fISmDvuyWn6tgsA//cCwiN1pspwOeF81jN/UMQMbxMqFNelFSKnf5dPYhc0UUEbpapIxTnnCN5QS4UTj/hm+zOZPNuFwMVKoZArVVtpnAZR28izJVeOsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723143972; c=relaxed/simple;
	bh=7A+R6yMU9d6rQjFJ5o1iuGrbrwZ+/nqdudiFO+Vr3EM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Uw47nIrXlFBEm6eR8jT0wuXYnOCg/ql/F5hd9Fl74DVZvfLHI2p4pLk2U2RLJRyxdrSnNdD853fWMd2AezB8+a+exyJVlqKAEAMlUsZF+uguOgKOjy+PTgx0zEUpcNecCyDeJob80GHTZoh6/KXXut7JfqnJCD/2Nyb28pcwh2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=3BYWlPcu; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="3BYWlPcu"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7a1e4c75488so82917485a.0
        for <linux-cxl@vger.kernel.org>; Thu, 08 Aug 2024 12:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1723143970; x=1723748770; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7A+R6yMU9d6rQjFJ5o1iuGrbrwZ+/nqdudiFO+Vr3EM=;
        b=3BYWlPcuUiu4MJybLy3Fliluz2VjfYLv5zELQ+EQvTKAcJ+hCVX2Ar1EisJmO8HfON
         Mfk4JyWxnT80Q2a4f8HOXGyqztLFzvIU1uefNA+oTiiqK4Y0MnvPDWBIgxn/rELjLcAI
         txHUq1YQ1+4frKRK2kN8xraiEKIcuiY1x/yu7rD3ERrZoyWGWfPbGTBy7vyYIeG4bDRK
         76pY0MsMTYlYo9+CMcCYhLppE+vHBJ/NOgrygOQWrNhsUcI9lhLXA+gxCXXhjeg4GsMc
         639Es8sp/IEfWdVmUYwa0w8OYVPRhz1vwphvbZiyj8/0qBCaUfCerr0l2PYOXehaW/rd
         96bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723143970; x=1723748770;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7A+R6yMU9d6rQjFJ5o1iuGrbrwZ+/nqdudiFO+Vr3EM=;
        b=BtPoGCf1EjNFdEApAVCw7wOY1cpN+dWOUp27uJ2mp5uqt6lwmge7Gws4uWdr1oGuzK
         gfNDL3KazX5ONbxcPz9zuKGFJpVnEtmHkRLxoMK2yKPoYeF3U2O5dNb0zuYnG+DEgwRe
         Kbl7PkHZsuBrWdDYDKQMn8or2uDkvkbhrTZFi+9qusWZnCmK9nvnhY84w5z06Fv3cPvx
         3vo3z1YMUczs7GUPIkfg+jCc52Oo8189vkZIXiJ8kf7KOFc1J9PRIKkSk16uo8MjyrX7
         gdqWlBE6tCeKr0lLdxaqPRp7XcR44z10DcOMPvrhGyhbIg/dRh/CQJe0ee6dh6xpnM4I
         JoHA==
X-Forwarded-Encrypted: i=1; AJvYcCVDenITHFDiYTs/62jVOkX3X3wm5o1gZExo2jba1ZlvumikosSSOnkH12S7p/3I4CiRsML6nAameQsSpA3exbU2L5/gyTqnoRoF
X-Gm-Message-State: AOJu0Yy1Jw2fvR0khMvy+7D6jUwDBGso+mPUfRYHQl1Ztrdq2uE+RYA5
	h6XJRdWdrYUpGI71layNmjOEB+A7SCErVY8vnVVRv+QNZJTcTvsj93a0Vl1/5Mn3sL8Ol6+QW2m
	tYLW+nLoqx8aisf0S6Ke/tQTo5xsKlBMPrqtkVQ==
X-Google-Smtp-Source: AGHT+IGCNR6tOOc7zjRc+Z6edE+0iR8kbni5q1QhFVJ5IjBamDJUsGTUSZ80r6e+xP9C/Z5Z3E87bJ+J0HUI7bU8HDE=
X-Received: by 2002:a05:620a:4445:b0:7a3:56dc:d414 with SMTP id
 af79cd13be357-7a381872973mr296729185a.49.1723143970021; Thu, 08 Aug 2024
 12:06:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240808154237.220029-1-pasha.tatashin@soleen.com>
 <20240808154237.220029-5-pasha.tatashin@soleen.com> <ZrUUnm/pEpPS9ltC@aschofie-mobl2>
In-Reply-To: <ZrUUnm/pEpPS9ltC@aschofie-mobl2>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 8 Aug 2024 15:05:32 -0400
Message-ID: <CA+CK2bD6wMh2svqf3vhj=53=EUWYtQJmJXyTRkLBm49q7KJFtg@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] mm: don't account memmap per-node
To: Alison Schofield <alison.schofield@intel.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-cxl@vger.kernel.org, cerasuolodomenico@gmail.com, 
	hannes@cmpxchg.org, j.granados@samsung.com, lizhijian@fujitsu.com, 
	muchun.song@linux.dev, nphamcs@gmail.com, rientjes@google.com, 
	rppt@kernel.org, souravpanda@google.com, vbabka@suse.cz, willy@infradead.org, 
	dan.j.williams@intel.com, yi.zhang@redhat.com, david@redhat.com, 
	yosryahmed@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 8, 2024 at 2:55=E2=80=AFPM Alison Schofield
<alison.schofield@intel.com> wrote:
>
> On Thu, Aug 08, 2024 at 03:42:37PM +0000, Pasha Tatashin wrote:
> > Currently, when memory is hot-plugged or hot-removed the accounting is
> > done based on the assumption that memmap is allocated from the same nod=
e
> > as the hot-plugged/hot-removed memory, which is not always the case.
> >
> > In addition, there are challenges with keeping the node id of the memor=
y
> > that is being remove to the time when memmap accounting is actually
> > performed: since this is done after remove_pfn_range_from_zone(), and
> > also after remove_memory_block_devices(). Meaning that we cannot use
> > pgdat nor walking though memblocks to get the nid.
> >
>
> How about directly include the failing cases and user visible impacts as
> reported in the Tags appended below.

Do you mean adding panic backtraces or repro steps to the commit log?
