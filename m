Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADDE41C84DE
	for <linux-cxl@vger.kernel.org>; Mon, 20 Oct 2025 14:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760969954; cv=none; b=Ti8eUpXHQPVJIjUQt231v8EumHnVjFcoLa4RQkIQ0NKjfz2+q9vMOvrw0YPCzsqAOS+RunSgy33dnp9na8hZZBJRtEbAhxoR1rTAfjE+JbpZu2c/NeXxBxS16kDWNsAzZbNr5PkbZSaAXozQhuPi2pFkQIIKEAznJiboHiJ406c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760969954; c=relaxed/simple;
	bh=2npudKn3M3pGuvcNhStzzobNKAnWlVCYEMk+IX+Cn00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uhtvg8C2YdsBDKbJvFw7qs2Ep76Pdpjdt+UCBEDoCKnYsQHgtQrsrjGKGiB9Sq/0kChOmCvB6Ld80ljed6WwhlL0Dgbgp6GApGp1g2Htg2NOr7WjFsTRVtvE7zMeVlKWYn6eyAWfwzMwiGCG/sHGbsAMTYSjxtfNZyIc13sHWx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=HLRQmwV3; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="HLRQmwV3"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7f04816589bso705506985a.3
        for <linux-cxl@vger.kernel.org>; Mon, 20 Oct 2025 07:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1760969951; x=1761574751; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+qpyUIh0Tk7malHtrxqPktm9KOxI8snDhlaveespDlU=;
        b=HLRQmwV3ChxvDcup/Z2+kAXm2ea9QBwL3R3+TcXkrOk7+FGDaTGQaK0OhpVt3opVWC
         4jX3i5tVr3ObVn3s9AmgUE/fbwOj17wuWTvzpe+/WfNM+ZfypXURbLDpphy6U2qOyQL7
         itjHOXZFnHnkuAcEaPHT9oY87gQJ1U9Vuc5q6NlJROIKPrbLQrE8hTLwuLAl6wp5+r0u
         dwSV7PUL3js/7aHgWGcXvzxscfkh+L50DqgCJiYRWpHjtY1JdIiHq6CSbR20OR15bja4
         uZP9ej1+oTMJrjmPiV/8Y4YJMhfvjDyXz5go9H19XCtvm0JjNDuK0/76Q96C4j1kJxxl
         ATBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760969951; x=1761574751;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+qpyUIh0Tk7malHtrxqPktm9KOxI8snDhlaveespDlU=;
        b=B8OwVTXdy2aGi2qWwVNdmezNCMk3oDuisaEhVmDQ+OGoQpjv8Jz3qb65tJbo46SFQE
         RX65lwCGgiiOsmC8OZfFlcThWjgG1ovWiXPnDVKNNr1+/iNB3175h50EwFuTXRhCpLgF
         SVNzS/KQ7XTiTN9RTh9S9seQziC57lkVDSgxabv6Ia2GB5UNG7ANI3/vRyx57F2FQnll
         9+e8SCqPeskry4ClceOIgyN656BS3/PQrmyUltllDFarOVJaHrXmhiPe7jua+BaHd11R
         IHPgMwFxUhD1AQ01g/kOAE94SFX2jwQo3bf+rSEF6FuX+3y/O39LLyyHS2krmhTV5TNp
         k6LA==
X-Forwarded-Encrypted: i=1; AJvYcCUkiESBZajDMaWqEjyGlDJE9Z8WqJvN937oWHxXHWLiWgUqMg8oDfaGkDcylTSRdjn1Jtbxlehq8pA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaC4n2pGiuwKMtpg2chInld4YmUumHZeLKkqUcRm7dkIbCHgLX
	lfPn3KZBSfjuMbM2uAVoEh9F7xeshHs+YQBG7x4Q1Xl9A81+deIKfJjIu9e/QCSYyaI=
X-Gm-Gg: ASbGncsv8d4kD9pwdAL4fORtFHPSDBBvigjXCn+jd3rs2ZuKsVtUy8rQrQqKEfXYLiz
	onRRMA7w5smrB8r0vOntdWUhbuDliz4w1rk+/ntYVaWqDy6FvEtkNCJkDpv9Mg7dgw2ds1Jk/Nr
	y+JxNIeKzMmyBFxqJWUNnZsQzCghM+ATU52MzmF1MD5rFTD04CuF1fsr4Aw69w8L7u2PdJubPDn
	5PFtOetzyDjPLfdqNojPdaHMF4ZwgTmQfMHs1eWR4c2Qvetk3l382aU5s+ga9vhTm6GFtwmYvEB
	2567j9tcoV3oQIp49gx+JauBTSSHU0NYJ60F8AADyVk4iTOOE7X4VrxiQmDhidhVNkTdaKizT69
	ty3mncJ2ddgv9xycU0d7EkZQeOD63wYpI/3mphluMja1ZomXievoAUkA5cDc6IY7yrDRYySEYdJ
	QJ/ARs1DIzElsqVlZjzSlPQ83327v3pNx7Ja9S8nqn6rg/dEHKN6Sr5FN/cQZ9BvL+qALDqQ==
X-Google-Smtp-Source: AGHT+IHRCRqY4YjVP7KDo2gTi6tLoUYXho+CWMkf+1VAhi9o3M4Tof/3oq0+LXyeXxZiWLuh71yZog==
X-Received: by 2002:a05:620a:40c1:b0:891:6891:5668 with SMTP id af79cd13be357-891689161b5mr1432264685a.63.1760969951455;
        Mon, 20 Oct 2025 07:19:11 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-891cf58eec0sm565840285a.45.2025.10.20.07.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 07:19:11 -0700 (PDT)
Date: Mon, 20 Oct 2025 10:19:09 -0400
From: Gregory Price <gourry@gourry.net>
To: Alison Schofield <alison.schofield@intel.com>
Cc: Vishal Aslot <vaslot@nvidia.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Li Ming <ming.li@zohomail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	"open list:COMPUTE EXPRESS LINK (CXL)" <linux-cxl@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 1/2] cxl_test: enable zero sized decoders under hb0
Message-ID: <aPZE3Spas-IvHmfd@gourry-fedora-PF4VCD3F>
References: <20251015024019.1189713-1-vaslot@nvidia.com>
 <20251015024019.1189713-2-vaslot@nvidia.com>
 <aPXgLp1Em6wKlx0t@aschofie-mobl2.lan>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPXgLp1Em6wKlx0t@aschofie-mobl2.lan>

On Mon, Oct 20, 2025 at 12:09:34AM -0700, Alison Schofield wrote:
> > This patch updates cxl_test to enable decoders 1 and 2
> > in the host-bridge 0 port, in a switch uport under hb0,
> > and the endpoints ports with size zero simulating
> > committed zero sized decoders.
> 
> Decoders 1 & 2 - those are after decoder 0, the autoregion.
> That's a problem ATM, when we try to teardown the autoregion we
> get out of order resets. Like I asked in the other patch, if there
> are rules about where these zero size decoders may appear, that
> may make the solution here simpler.
> 

I think this is going to require a quirk-doc like other deviations.

A committed decoder must have a base address, and with 0-size subsequent
or previous decoders would also have an address that covers that address
as well.  This is on top of the ordering issue if the 0-side decoders
come after a programmable decoder.

I'm not convinced this even makes sense as a security thing if you can
reset the bus and re-activate everything (after a graceful teardown).

Seems easier to just report the decoders as unavailable and then not
probe them.

~Gregory
