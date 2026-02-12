Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA54735CBBF
	for <linux-cxl@vger.kernel.org>; Thu, 12 Feb 2026 16:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770914033; cv=none; b=THUkXgFiQRaK9xu6iYlBcendALNJ5LkT34IK6v7Yt1OEpv+JRvNf67R/Dal34QvRB93Ir2h3YUulpL2w11OcGrgIaI0zcd9V0Fr1O0XKc2NEnVnaPHhixnuPc5ZDku66/1GNidcoymE/h6YMg/CmtzUe1OVN8cr5h3ZYApeVCwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770914033; c=relaxed/simple;
	bh=25opVHIv7SCRMY++47xY4pgZkKy1953wVdAJuD1SWmc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q1fvEUwhqn14E5j5dGNaXJ5QhHrRbrudHJuuyA/whTmTsgwV2h4WBZkGnryGQ/DEsvqVF43HpWW6Ct1OokI1wtm1y5sBhbgq0EJUO0r7mKsMDcOVbXWrokW+HcpFqjRB8CdrqAzG2dPNIJ10hKqFn2S9+Mbykvs2gRV0NYKN9Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=eCMzHIrF; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="eCMzHIrF"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8c6a50c17fdso6449985a.2
        for <linux-cxl@vger.kernel.org>; Thu, 12 Feb 2026 08:33:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1770914027; x=1771518827; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rXxVe4fRiyRXCoNbo+oc/BgJFQHLEBXNd+WUueWHuWk=;
        b=eCMzHIrFmXW65iJZw47f27gn1Y7Q4kfH6lzN19tlpFPxdhusvhFWHCVGeONXW4H3sG
         3cIpGkPQc0vdKJZTLV5ZEeVn/G6V+QVkMArj7OOM3bYDPYtBc82Ap9UAB2/WwArqtFsv
         IpHb+FW08TZO3tbFSUid6nbCt1YhceHpy1KF1O6N51yT9oKbK5WOgzZyWMOCd+vu03HW
         27/W7tMMGWiypNks8PeCP/pgWDnsmzWJT6hsFwehqRiGaatXA0po//DK8QLwYJ3hUJE9
         97265knnlrPVBjS7PepissFlf+0f7TCTw9IYjhJLYrB4Pc072cq/rENMcjBkERiETLzc
         czIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770914027; x=1771518827;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rXxVe4fRiyRXCoNbo+oc/BgJFQHLEBXNd+WUueWHuWk=;
        b=IqNsFw/pJx5IiTXfltdL3tVG724MeIRGNoIcKLfp3iHoexHromi4G0MvTnbv97Hfsi
         UNVXHzkeQ4iTEQPDdiKzecVzFRe3a+XQyYbsv5M41PER8Sw+CZP+Cvb1wRVPn8j6bqEG
         JEgFGTaNg6L+whXo3hsQmG88jGepxERfvjGlew6pMWFd95Gy3Q2Amu+qCfu8zJ6dsiVI
         bAB9G6K+PaX72RvyhaeSx/nGixXqmgSAgaKD2f+XEsT7iEQs8IoMH16qwDemEJxL5xWV
         YJ1xLSLysGnqqEuvvw51V8ApqGAmpp7gYi35EbF0XOjD5w2i1oS8jkNLC4INXPS98mfq
         SWew==
X-Forwarded-Encrypted: i=1; AJvYcCXENFf5ttmNvTmiHLAddFQ/xihTRZdEd74z4y4q2teCbNbn856yBRawUpirdW+2XptIyYuxofy9q7Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCngLFEwwMIarrj92do/kQ4JhzC12dLpBjRneYFbV9dQnPml5q
	ZcbLV7gjmVO72DFqjMiDrjqnTowYSfh9WUVZODf6m6YRegoSSwjcqnSw/4yTIqqnffM=
X-Gm-Gg: AZuq6aK2u38P+x52YFJmUpOS7q2qbwsub0/n9Qi/7BTkRUK2h0lEc4pp1+ajqSMFRiL
	j1DjVeoSO+F5R5cDipdAj2J5n8+4/5xjdSzPxYguPQGkkMgvym5yj1VfgL+9vlp6jVwRq76lucF
	MyGzg1pkyRKCV6FAFr1j/+G6rH2h4zXcDaB+Gtabn5I26AUIbdJJUoCW6pgkgq8pPmsuxBH0TH8
	i8on+4mIGzZA8JKDTo+jweCcR4Su/v5uGGTJdR6CtF9qVgKFLGSsAMgsG52tjUsuCfD5XEo4V5w
	s5eeMS41ytXOhQMbLU9SR06zdeHhBmx3N+aJHILtAsOjjE8TO0yw8ApmJrsRiAQExz2jHPPLCgY
	mZksA+6+YipMudjaXsP64vXLM0/Au002IhPOG0Sc4zbPbYzY7wtblN3kTc1SaiZq7mADxS33Zcf
	PKjxm/tjltbEbHBrktVffM3GnZdVsMskp2VIAoGBloJgSWtrfbO1AJCXiGvS6j6fxvUJ48MScMh
	CiE7/XP8g==
X-Received: by 2002:a05:620a:bc9:b0:8b2:ed29:f15f with SMTP id af79cd13be357-8cb33090e29mr430636985a.21.1770914027457;
        Thu, 12 Feb 2026 08:33:47 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb2b20f5desm372226785a.41.2026.02.12.08.33.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 08:33:46 -0800 (PST)
Date: Thu, 12 Feb 2026 11:33:44 -0500
From: Gregory Price <gourry@gourry.net>
To: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Cc: linux-mm@kvack.org, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	david@kernel.org, osalvador@suse.de, gregkh@linuxfoundation.org,
	rafael@kernel.org, dakr@kernel.org, akpm@linux-foundation.org,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
	rppt@kernel.org, surenb@google.com, mhocko@suse.com,
	Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: Re: [PATCH] mm: name the anonymous MMOP enum as enum mmop
Message-ID: <aY4A6CgqvVKyCw5H@gourry-fedora-PF4VCD3F>
References: <20260211215447.2194189-1-gourry@gourry.net>
 <35db57ae-64cd-40ed-8353-7d3b64069471@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35db57ae-64cd-40ed-8353-7d3b64069471@amd.com>

On Wed, Feb 11, 2026 at 04:18:45PM -0600, Cheatham, Benjamin wrote:
> On 2/11/2026 3:54 PM, Gregory Price wrote:
> >  
> > @@ -77,7 +78,7 @@ enum memory_block_state {
> >  struct memory_block {
> >  	unsigned long start_section_nr;
> >  	enum memory_block_state state;	/* serialized by the dev->lock */
> > -	int online_type;		/* for passing data to online routine */
> > +	enum mmop online_type;	/* for passing data to online routine */
> 
> Comment looks unaligned.
> 

Ah yeah was already unaligned. Bleh.

Probably not worth a full v2 unless Andrew prefers that.

~Gregory
