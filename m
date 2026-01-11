Received: from mail-oa1-f66.google.com (mail-oa1-f66.google.com [209.85.160.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3095C34F461
	for <linux-cxl@vger.kernel.org>; Sun, 11 Jan 2026 18:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768157608; cv=none; b=uHz86Aph4xVCiovrIEsOE7Y5yBHafdfJRs+xc79ZR1wKhFvf6p9irHTu+Z1vZDlkAsyR/nSvzySEjPgtvjE1scYqPxzK7qSvQudcTqf3SCrvCucksqNXaAfS7EnF2AxCIrE1CEHtoV1Yuf7xJh2SQansomEcChtetcIsmIg1F9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768157608; c=relaxed/simple;
	bh=bjkXAEN8Y+D7IMRxZaq/hvH2dXf/omJq+KCOtFcy/ws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YEA8CZSqLw3ep1AgSYP06YLTkJcCPpGIyIBtbGBuocoSGykcDZB3gOG6In48MIzc/OP1kqC8sglQvNJJVuXuzIEctE/rNY+glrnJpqDErSiFdVy7twMJTTLXH5TXksaiJI0df0Sa+eJWngc8RpfwhhF2AR4W25cLNpPzL4t8hlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F63BRgnI; arc=none smtp.client-ip=209.85.160.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F63BRgnI"
Received: by mail-oa1-f66.google.com with SMTP id 586e51a60fabf-3ec47e4c20eso3603671fac.1
        for <linux-cxl@vger.kernel.org>; Sun, 11 Jan 2026 10:53:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768157604; x=1768762404; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vTBNax6FoYZ8tcOGsMgyI0isYvrnMxJ74iIpUsR2X1Q=;
        b=F63BRgnI+OUmaOB+0+k1IxNZ3TWWLFmBQlF7fxrgy6Znr2JbqRJG3Kblt1RQxBBzql
         PCYWGSFEtrqc+luf+2yh1ZrIlGwgkK+aeMUL0iWTEHZy0iQq82WqHCdBMuqOLctTZRbw
         8hfPztQY3xwKs0a3QyBmF9wtKfW6k+IYhltm2JMhk/Mm9UeT6BLOQ0VRy0pgPyAHV6TM
         GuCt4hDnLTewylGhWscOFSylfWBkMTgTC69xcSYsEF94qOdK3E4Jm0R/Vb4XQIXwqdTj
         pyOay13vf52fwuAX5UT/iavS70M8CEWbgqu2EBm2piRf8NX6Ek5ibiSC5vV/curN9Is/
         jBng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768157604; x=1768762404;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vTBNax6FoYZ8tcOGsMgyI0isYvrnMxJ74iIpUsR2X1Q=;
        b=c212ENWBEjT+VNmJ+yT6OJfk+hHqkN5WySWJqxaFaWrh5Nasw6RalJCbj2Nar29ofn
         WhHt4CN8HjHVU3O2n/zgmam31pvwBZ+gJVn6oZgCGDkG8hfEjgoixfGgCtBPZL/z5CCH
         QZXtJ0XRJXAOvTC+MrxWn4QacJaMb3DdHBWCBTB5sjHbziwHEubZnxHwRQ4eMmo6ugWg
         c3mhBs5foqPinOecGiUOPuR20H6+nkSqhr1U8A8emOanEVmIAAMd5I7/KUyU8XKzDjC9
         tu8XTvQT9xv7Lk1wpWZ4d3Qm5C9SDYd0GrcKkBf5W1zMXcvnZR3hnaSoS48IscGXe/8p
         yabQ==
X-Forwarded-Encrypted: i=1; AJvYcCWO4WNMqJIWmMSo+s+a2kM2aTBvrMFCvlBODnqRG3r1CGi2n6y549zhHDEc09w1IKceXJYUMTN6qF0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyM6TvhsnHd/K/CNe+bxhVtz+XUN4YR5jrH6ZHwUETDxmj0QDLh
	10BWtXmrmBwzkZw0y+r2VNAdp4ocmrWiMR3fYAmsM8o0zORzRF10ADjt
X-Gm-Gg: AY/fxX5N8eUoyLNwRzFKJzoGfl3u8mUiiIzXY54UwjHXm+oTh0ZnWKWbD6NgzuSoxi6
	0e697nBZTqL5ccnB6/wSDCsPfPjWNZ/SdEb0S5mMcN00bbaTNk++cjh9eP3r3eXhmlVo9M+/h4z
	4hxxvGtLdF8woAFMP3Abk68mcondrkq+AWSHg4KnAmZtAjBTpDhe+N6cJDRkRm+LkWRWjJ1/USN
	8C5ELf0kdOYyDx7vK0kwVYsgR/v2jaZ9VFqPzJUYLZnTPGwn1cktYFai0Mbpm3jXydHK2OrYVdf
	MT9YsD1f9teNQLj7Z9Jn3TybCQTdKX1s10G/yOwMTGFpsHQx+z0y/6xjjVvXkp3m8J2T3TURkQu
	+AFoJub5Zr64lBChNyMbawRT2JG4ot/ya6plTzd76TTeUb/0522fRpdakp00vRLdqWyfaqHL/Sp
	jpMIvSFkgLNbgG5cROzSEi2taKZPsCQHS4lNkl28lK
X-Google-Smtp-Source: AGHT+IFCDAYjOU7Tv/QzCofEX4QjQQf7VTkE0/1bWiSzEnwsQJCLaG0COOECS73BVhT6La3jE2HlAQ==
X-Received: by 2002:a05:6870:b525:b0:3d3:5ea0:5dd3 with SMTP id 586e51a60fabf-3ffc08f67c1mr8587303fac.10.1768157603977;
        Sun, 11 Jan 2026 10:53:23 -0800 (PST)
Received: from groves.net ([2603:8080:1500:3d89:cc0c:a1b0:fd82:1d57])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3ffa516150fsm10835406fac.20.2026.01.11.10.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 10:53:23 -0800 (PST)
Sender: John Groves <grovesaustin@gmail.com>
Date: Sun, 11 Jan 2026 12:53:20 -0600
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
Subject: Re: [PATCH V3 21/21] famfs_fuse: Add documentation
Message-ID: <2v2f3kfrbjolx3gaeo3273beah4msor6vpojusrf5ekd4rg7rf@tgnvcuxh3sgo>
References: <20260107153244.64703-1-john@groves.net>
 <20260107153332.64727-1-john@groves.net>
 <20260107153332.64727-22-john@groves.net>
 <20260108152713.00001b42@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260108152713.00001b42@huawei.com>

On 26/01/08 03:27PM, Jonathan Cameron wrote:
> On Wed,  7 Jan 2026 09:33:30 -0600
> John Groves <John@Groves.net> wrote:
> 
> > Add Documentation/filesystems/famfs.rst and update MAINTAINERS
> > 
> > Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
> > Tested-by: Randy Dunlap <rdunlap@infradead.org>
> > Signed-off-by: John Groves <john@groves.net>
> > ---
> >  Documentation/filesystems/famfs.rst | 142 ++++++++++++++++++++++++++++
> >  Documentation/filesystems/index.rst |   1 +
> >  MAINTAINERS                         |   1 +
> >  3 files changed, 144 insertions(+)
> >  create mode 100644 Documentation/filesystems/famfs.rst
> > 
> > diff --git a/Documentation/filesystems/famfs.rst b/Documentation/filesystems/famfs.rst
> > new file mode 100644
> > index 000000000000..0d3c9ba9b7a8
> > --- /dev/null
> > +++ b/Documentation/filesystems/famfs.rst
> 
> > +Principles of Operation
> > +=======================
> ....
> > +When an app accesses a data object in a famfs file, there is no page cache
> > +involvement. The CPU cache is loaded directly from the shared memory. In
> > +some use cases, this is an enormous reduction read amplification compared
> > +to loading an entire page into the page cache.
> > +
> Trivial but this double blank line seems inconsistent.
> I don't mind if it's one or two, but do the same everywhere.

This doc is identical to the the previous series, becuase I kept the Reviewed-by
and Tested-by tags from Randy. I'm happy to remove the extra blank line if he
or somebody from the doc team thinks I should.

> 
> > +
> > +Famfs is Not a Conventional File System
> > +---------------------------------------
> 
> Nice doc.
> 
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

Thanks Jonathan!

John

