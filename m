Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530A313D246
	for <linux-cxl@vger.kernel.org>; Mon, 21 Jul 2025 02:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753065709; cv=none; b=Zt2roeOsNJG1EdwKz+fP92ZX/k23u/kgzkEnFidtzypE1SDfUY5vopsbOZ+4P0HKtsSAACg+v9yHRN2u0ETM2urFUMUQ9R8iVUhQqFSn2Z3upWM9tIZYjOiHdIYP049Cxs8LEqBNuMqyhR78++BUv9h+Z4RURxuCvQtDlYdwCBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753065709; c=relaxed/simple;
	bh=BxccSV+pDJegGP3WP1iTw0FJMK6oyOGMPa5Nlu+a08Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q66O52UMp1tOjF//mYFRExDRZF3XQ0XkR6wsbu1qPZbo/EE3qxgmDG1HwEiBpKn1JUTmh3eZhUEF+KMaSe5zRq67WYg4+GdTI7gGdoE8BI+Xcf+I+IbRqfshr5+8DlkTK5lSHAGwV+gFi0/rJk40a2vx2s4dPBWRwJDsqalcrhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=BUsC1Zp9; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="BUsC1Zp9"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7e29616cc4fso395956685a.0
        for <linux-cxl@vger.kernel.org>; Sun, 20 Jul 2025 19:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1753065706; x=1753670506; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OJpgc8VX8tyLAvcgFKV7KoLwULFjGxQ1sn9BritLQbo=;
        b=BUsC1Zp9QQJtNlxUkP62aX/tyTscIstY0FnFdFTsUVUzWtlCXtQwWc/rK4Fxhs83Hh
         0ieqbDNeQX2j3L6FKd4sjK0xStwJsmmxL0JMCM/Vn9OI4bJOLwDYgkw4X22c3fdjD4pr
         WGpSFXLKfWkvHYqGeS452z60V2oRhlrU20n9ijh/dvRqSb6bbbxfg2wLhZxv2MWWbCbP
         CCXPqHN1s7WbRJHimk+09+nXWkjBxEILqBd6kGIxjSim84W6+Y/ApbMylooZuyCM5g1y
         3tXNlXZPx24EainzhhaXuuE36ngAlHBSoIf1T+rgihJcq+OdkdgTEODhKtih/91QjH+f
         A7ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753065706; x=1753670506;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OJpgc8VX8tyLAvcgFKV7KoLwULFjGxQ1sn9BritLQbo=;
        b=ntGGRHqVZ66i91R5X2A9IA21wlMl2GTHiRtZwQAwqoIZbTQIbrlRH29tIyhs5dYWrr
         mLSqaGAhzoMxngtIMM18a25NufJz9Uh8nKpxgBYlMF+US7ZE7v9Fj+c1uCWYwxEuiS/3
         tKyZ3M37etMux+1FKpoEQSzQkxY8Mhk5BnChQYZqmZU4hrJ+0zZaQ13dkQjv78iGe6aJ
         qrRUtFRB71YXlNi4NfuRECNghUhzhGqkNV8p9iW6B4qWGxV2qy3+iCatCsQb15MRHD8X
         n0PdyBYow/86TpRzLrA0EoJpQ1xccsygcxVIUsHNzlsuMsRS3KOv7QTp+3euPcILoou7
         2Jcw==
X-Forwarded-Encrypted: i=1; AJvYcCXN8eyARQXu/vW6xXBOHehA9Ug12C1k3Tek7rMZBR5wG29KBCt9wNHM9rT/k6AXNMXQH5oeb5GB7cw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqZ3yp98F1n7p7+wHIg++MElGgGd3QsP0tRDWYfpvYDhw+LBr4
	mg73SaTVgCtfXqruvq5itWeBMx6gRzPOoPw68L5+dLTFXMAiyaEio0TvW0l3cS/fZd8=
X-Gm-Gg: ASbGncsygrxwtvJFbO4hbKX9OfWwBL4U0KpgWY3IsZX0PsNjKCk3tLakcFRl5Z13aF1
	Os1Ai5ZSPU0fyLDuwvNBJbkoimTLt1y/AqNfB/NaPANA97EmHnvfUFvOR8ZkozE7+UQHOGSkyA0
	I6qZvz9snx6tzzOt7T+HyKiU0kfSJJ7rLg3u3ZBI/wFURtaCso3Qd2R8QsaybAJCMZwiCuBjP6M
	CWuIW6fivHrdHP8ngmN4sCoOljoiT2jPTX3laB6MYHvyfzm4lwFg6EZnpaY5Uv/KOv98Jtdf6QZ
	XaVKddALmGzgx8XViI13qYBFNXjCWwyu45sjq2YAwwDX5WWLtKfky9n/eqk2cTjx29MJC/Urd7E
	lrnWi5/1UoAMlNs6rU4EFwgW9mkcujTosWnXUs98g3D3LOmCAPc+6zG+O129/IYoUYoMUz8U4sh
	21zQ==
X-Google-Smtp-Source: AGHT+IEeRc0l9oPOzXQSd38Y2atlisyrEffAh7PjM4aXcSaioF7+PnmbkPhU2l7lM/VmvXFU0SuWMg==
X-Received: by 2002:a05:620a:a102:b0:7e3:4413:e48f with SMTP id af79cd13be357-7e34413e8c9mr2287460885a.59.1753065706242;
        Sun, 20 Jul 2025 19:41:46 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-42.washdc.ftas.verizon.net. [96.255.20.42])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e356b4677csm356681785a.32.2025.07.20.19.41.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jul 2025 19:41:45 -0700 (PDT)
Date: Sun, 20 Jul 2025 22:41:44 -0400
From: Gregory Price <gourry@gourry.net>
To: "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>
Cc: 'Alison Schofield' <alison.schofield@intel.com>,
	"'dan.j.williams@intel.com'" <dan.j.williams@intel.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: Re: Question about Exact Match Requirement for Switch-to-Endpoint
 Decoder Mapping in CXL
Message-ID: <aH2o6A5gqeC0MW3v@gourry-fedora-PF4VCD3F>
References: <OS9PR01MB12421AEA8B27BF942CD0F18B19057A@OS9PR01MB12421.jpnprd01.prod.outlook.com>
 <aHhWnE3ETrl_rZjL@aschofie-mobl2.lan>
 <OS9PR01MB12421676B7FC8FF44F4F171D09051A@OS9PR01MB12421.jpnprd01.prod.outlook.com>
 <aH2ih0Rrz1qlCEV_@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aH2ih0Rrz1qlCEV_@gourry-fedora-PF4VCD3F>

On Sun, Jul 20, 2025 at 10:14:31PM -0400, Gregory Price wrote:
> On Thu, Jul 17, 2025 at 10:52:26AM +0000, Yasunori Gotou (Fujitsu) wrote:
> > 
> > ----------------------------------------------------------------------------------------------------------------
> > Decoder 9.0: HPA (Addr A)        ~ (Addr A + 128G - 1) | Decoder 10.0 HPA (Addr A)        ~ (Addr A + 128G - 1)
> > Decoder 9.1: HPA (Addr A + 128G) ~ (Addr A + 256G - 1) | Decoder 10.1 HPA (Addr A + 128G) ~ (Addr A + 256G - 1)
> > ----------------------------------------------------------------------------------------------------------------
> > 
> 
> If you're not expecting interleave, then firmware is just wrong to
> program endpoint decoders as described above - although TECHINCALLY
> it could still accomplish the job with the following relationships:

Mild clarification: according to the *specification* this is
"technically possible" - but according to linux you cannot do
the above unless the devices are interleaved.

~Gregory
