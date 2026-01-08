Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48BEA333740
	for <linux-cxl@vger.kernel.org>; Thu,  8 Jan 2026 21:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767906917; cv=none; b=ecYZOd9Pnmrlh7HsJmD0stpE6A0ET4uUzLDQRcPzMmDKDrFrymHfFWHyoU3SMJ3cnlQB8f0OStf3+RQhY6LBdvRwMriB1sQjB/fU+702/gg/gzw+2ax1JVB28Kl27RbrSjKi6lRWsJPPwd43VdJy4/WuL8dB8aV2tg+iwus3Czk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767906917; c=relaxed/simple;
	bh=zyL37NBSU8pN3eAlVPiisOgzpo5IWY8Zuk439n6/CTc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=avdc3c5UUggzxVDqRcBlvi2mpdtdLJ5/uCHpv5It94qIzZWeq883MTwy5GWXmauvbv5+nQPf2tm9JO/+ORoZRPik5rlhMXmjvFV258Dv9cv9Ia55hrh5/jOiC6+NbXywQb4s5VAa4MRckbv5RWEOPvTEpECWa1v7FQLFLaC9Ep0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JUz/QHPg; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JUz/QHPg"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-3ec6c10a295so1595594fac.0
        for <linux-cxl@vger.kernel.org>; Thu, 08 Jan 2026 13:15:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767906914; x=1768511714; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tAcE7cKJ6r47wCUmKYPiPBxGZ+Ab7WHLD5tStOo4vtQ=;
        b=JUz/QHPgQrys22mKysCSeIGCf7c6o5uxeMlwTutwoVy102OwY9Tb4f8ccH7RxP5kRy
         /3Q0BuigQUrdOZtYAJvhvzV6dSPmGZxQqlBi9a+qnTbew5JJ04h3ETdH862T1Gvkxcr8
         uSEj2y0oCR0/ZINkE/W4yLde06kRgA4bhBpjOiNAgDf15tXWIBQAvYIrHRL4JTcaQZWu
         w18bpiKQi6efEjBhanHFjFq5pZr1TJVaGXzB1M3BSfRCaaeN97AqpHqWsRd76FKldcKY
         r9bbrwoN32qgXVo3SL2huzJYK6wPlnQPPHvVqxCEb0uWLw+OGJck33HpQFVOTaSvx8tH
         hSzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767906914; x=1768511714;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tAcE7cKJ6r47wCUmKYPiPBxGZ+Ab7WHLD5tStOo4vtQ=;
        b=gkf2aY5YnVM0F1BzzulxxInub0aLX3asP98ZKvXbDqR3q3b0O+8zA4Xdh1vmBj7j2U
         aoRqIUGbcR7I04iACtZnUMkGUfmV9RdfrO8AHhvgoVHqyM49+HAIOFzx0hdFzJqOgn78
         046wX8neABat98/Zaxtb4KGiP+cdMsw2zqu1PbMwU3m07oXlnCdo6Y+uwEJzCHb6QCTJ
         ZZGh5UnbUqiNqulB28id7cdHxKxFb7N0wLtaNcRBV7wuD4UBoxgy7JNux1C80lrfcvjF
         QUpaIxtZPNVCeOlOVCx07vpofThsC+cJeMetWQcygGKVu7ju5M3wQb19dk5hcDYRJb1m
         BghQ==
X-Forwarded-Encrypted: i=1; AJvYcCWgq3GA5GDQGZuVIpcNxyvEHL2cVhz/zPlncGgqt5VzITmiVqPqtdpnnblU4jQokKVmzeBJM9rcS3o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbNBwP5KYFjOFBksdyiNKde3ObCZEbjhGF2W8wO8p/ljge518x
	ISJbTtK+VCtA4z8EzQlJHv/iWq/UiMrN+gVM+5YQkR5WY7Q9q+eRXh1Z
X-Gm-Gg: AY/fxX5XWoYijwvsMP5Tq9Od1cX7TqM2aFwrG6PwdVHeUjNv7p8tHxTEy6jegidfY2R
	kd2SRqp5DXDTWIO9+Qlw5b9Jf7dxEkuTDvIaqr5hW4gZutKoBI+A8t73JytSaiNm4VzRS2r/EEJ
	kMWoAiWvqlz8bDgaxdHknPdv4rwSe984CutobNY7NhrNgtril3QB0J+mxkEHAHhNQIVQmzZ5xG5
	6l7ZW38XuhckzDNIuSCuvI//wKsjm6PnSPhO7k0cW8VwmOzf73TKGk3IEOWqcpqQfs0hq/Xxq7p
	ZLxgAkTZNWIFdpNx3DHjEsRkgn6FZ0LkaHqn7xX9wlKCe6jMk7Le4eQWV11/N7ZQg3Zx/eKKTUF
	MMNZ66r8WlAQmCuGgQaIoHhh05FW+57OrlOu/ObbH8p4mikMID9buArowDFu7FAMH54vRQTlDoF
	EHdODMRgLsXvPrN8/aEJB9cdkFRLB54w==
X-Google-Smtp-Source: AGHT+IEqQm0iIHbXfFBFh7Rp/Y8kcmmT2Pnrl2hOBonEjMW99uNoChuzt5MPuGUGaUk9Fml8af2DQg==
X-Received: by 2002:a05:6870:a70f:b0:3ec:4137:47f8 with SMTP id 586e51a60fabf-3ffc0befd70mr3739946fac.46.1767906912603;
        Thu, 08 Jan 2026 13:15:12 -0800 (PST)
Received: from groves.net ([2603:8080:1500:3d89:902b:954a:a912:b0f5])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3ffa4e38b60sm5496047fac.6.2026.01.08.13.15.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 13:15:12 -0800 (PST)
Sender: John Groves <grovesaustin@gmail.com>
Date: Thu, 8 Jan 2026 15:15:10 -0600
From: John Groves <John@groves.net>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, 
	Dan Williams <dan.j.williams@intel.com>, Bernd Schubert <bschubert@ddn.com>, 
	Alison Schofield <alison.schofield@intel.com>, John Groves <jgroves@micron.com>, 
	Jonathan Corbet <corbet@lwn.net>, Vishal Verma <vishal.l.verma@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, David Hildenbrand <david@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, "Darrick J . Wong" <djwong@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Jeff Layton <jlayton@kernel.org>, 
	Amir Goldstein <amir73il@gmail.com>, Stefan Hajnoczi <shajnocz@redhat.com>, 
	Joanne Koong <joannelkoong@gmail.com>, Josef Bacik <josef@toxicpanda.com>, 
	Bagas Sanjaya <bagasdotme@gmail.com>, Chen Linxuan <chenlinxuan@uniontech.com>, 
	James Morse <james.morse@arm.com>, Fuad Tabba <tabba@google.com>, 
	Sean Christopherson <seanjc@google.com>, Shivank Garg <shivankg@amd.com>, 
	Ackerley Tng <ackerleytng@google.com>, Gregory Price <gourry@gourry.net>, 
	Aravind Ramesh <arramesh@micron.com>, Ajay Joshi <ajayjoshi@micron.com>, venkataravis@micron.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev, 
	linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH V3 02/21] dax: add fsdev.c driver for fs-dax on character
 dax
Message-ID: <5hswaqyoz474uybw33arwtkojxrtyxrvlk57bdwnu2lnpao4aa@4vxygh226knw>
References: <20260107153244.64703-1-john@groves.net>
 <20260107153332.64727-1-john@groves.net>
 <20260107153332.64727-3-john@groves.net>
 <20260108113134.000040fd@huawei.com>
 <6ibgx5e2lnzjqln2yrdtdt3vordyoaktn4nhwe3ojxradhattg@eo2pdrlcdrt2>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ibgx5e2lnzjqln2yrdtdt3vordyoaktn4nhwe3ojxradhattg@eo2pdrlcdrt2>

On 26/01/08 09:12AM, John Groves wrote:
> On 26/01/08 11:31AM, Jonathan Cameron wrote:
> > On Wed,  7 Jan 2026 09:33:11 -0600
> > John Groves <John@Groves.net> wrote:

[ ... ]

> > > diff --git a/drivers/dax/Kconfig b/drivers/dax/Kconfig
> > > index d656e4c0eb84..491325d914a8 100644
> > > --- a/drivers/dax/Kconfig
> > > +++ b/drivers/dax/Kconfig
> > > @@ -78,4 +78,21 @@ config DEV_DAX_KMEM
> > >  
> > >  	  Say N if unsure.
> > >  
> > > +config DEV_DAX_FS
> > > +	tristate "FSDEV DAX: fs-dax compatible device driver"
> > > +	depends on DEV_DAX
> > > +	default DEV_DAX
> > 
> > What's the logic for the default? Generally I'd not expect a
> > default for something new like this (so default of default == no)
> 
> My thinking is that this is harmless unless you use it, but if you
> need it you need it. So defaulting to include the module seems
> viable.
> 
> [ ... ]

On further deliberation, I think I'd like to get rid of 
CONFIG_DEV_DAX_FS, and just include the fsdev_dax driver if DEV_DAX
and FS_DAX are configured. Then CONFIG_FUSE_FAMFS_DAX (controlling the
famfs code in fuse) can just depend on DEV_DAX, FS_DAX and FUSE_FS. 

That's where I'm leaning for the next rev of the series...

John

