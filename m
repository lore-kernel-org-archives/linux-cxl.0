Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F18533CEBC
	for <linux-cxl@vger.kernel.org>; Thu,  8 Jan 2026 23:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767914745; cv=none; b=LVEv+a0OpUCaXqotdSl0zPlgDeTAiw8iyoQyrqVOsEVR+KZbJbRs7qgVb46AkI4YZ4G9mbYi0F15c1Rdx5aUYMqyzhcrwDGYZbPPln7svHp029j+UNPbZU1d/64uBfJnAx9YjVpe37sZC2OtvsnDEuTFpxfZevvotobpG93yjfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767914745; c=relaxed/simple;
	bh=obLYyhrFsoB9oBqm7xL6fDhdB8wxBGKxiOySCPXnFrI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cXxETk1u1TFx465c1+tr1kr8G++a7gSZetrRnpcCqy90/B/vO85wRNyR5BiaWsVs644lk5DA90F8uOAIx2QA55B5JWfAnxObh866a1sS+m/MT5X3byQ03QQOcYhhYiNcNq2aRlCEQv/cwu0HN2R9EtyM+Lpqxaw0s3FRr7Ul4CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=jzSeMPKY; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="jzSeMPKY"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-88a26ce6619so36588226d6.3
        for <linux-cxl@vger.kernel.org>; Thu, 08 Jan 2026 15:25:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1767914741; x=1768519541; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=055cXnB91pz5e1+jow3wyxxEvRh6YPpDHe6f2UW3p44=;
        b=jzSeMPKY3rCpFqvzX79jd1jMCr1j1i5WwNHfa7dCqNQLbt+yEWIOJLKUznHAsbWMLu
         21oyoEs4p12FZMXFkKAI8Fsec+X2NQfiNdN7Cuvjj6cDwjrZnog5g80W0CJ/YZ0Oj5Bf
         f7b+RtP/phsREFUXsrfbNnA6NB1VhnWHZFaFRoAiiRTBcyijNPFuXpjaRdLSJXL0YV/2
         fjetK3dfjmvm79EpW9DYI64r3DbEE5BhN07L6SvsFwkinLLBv33SXz9D7Q3IaYBQtCrW
         acgw9oqkis7F8T9K7uJGbe3Lv8ZW+Ek3QbulZu0VUP/pikT067JStRKEskChNs42/vvZ
         F+vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767914741; x=1768519541;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=055cXnB91pz5e1+jow3wyxxEvRh6YPpDHe6f2UW3p44=;
        b=vik52YCeRa4fglUoay1U4o69faPyq4EQSzqa+nIkppF6oGTfhdpYR3T3WnQSmOIVKo
         9nRMs+Im+isI3iZdazlBW6EvLJ7LgHsyx8bTk+YsrcBnNqRuYq19qIXyhKiPT3DxFnw6
         cZtGlqy0oAStWAGw66l8Mpjs8P534hycoEAk1stlVqJz5xaSfbILbK/Hmqik99aq4GYT
         AOapXzbWER6ldZGsJ9wN3sGksyZICCjqNASXuMgin4HPNqxxjNubTvGdW7QxwvgeoI2w
         pu3RmvG4GZv4tzpKa2eHUfbSR25Heju6RADsp0pe5s64lcYAl7E6ulH+IegrBRLkghHl
         aWPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUduQn2iAyoBJxw85588zksAijpSEtBDqH1/rMM5+ubKqq78T10IYOkaUB8vDBzHJsv19UZEX2xlq8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwESgsbnRjIgwNs3tzEo9M7AhfZwsUzR2bUwTRefIHkiMqMAKXD
	zALA73pC4vCg9Up5srXxixqjHQ/OuiXSX/Vhd4k7YfSPV3NlMvzvSKXI6KSYt5Y1rtw=
X-Gm-Gg: AY/fxX5HPJHrxrfqcvILpHWA+iJUcWpIxJxaJ3LvSskPXBoOP32M9VAg7JnCQ/NQyDV
	jXVh3CRfCzNobxBuZwfm14v5xpZDb+mYQBtrDhzgxqHYK3F1HiJoI+N0l4LGSKfLLBL52nbGvv6
	QNbo1DmZ4L7SuBflSddu3eBxRzTk+oMdz+BQnCvU8Bqw0Tl/SKwtd6048/RC2BSLfKHUUEX6n7U
	PY1wbo7LYFhymvE/spgE+bucb2tKx8rp5Uvj+apc28FrpqNNabZ71i4WqCZYGUhhYNOrRhekB3X
	YbloPHwVtg0JLuWEAl7ddWP7o0Ob8SivmysGiOAwjtd3rwNomgm3HAbupFUYqsLkZ3XdMQ4f1Wh
	2TrDqdZ7CRKxc5ELWJrLY45hcltcYXyIun55dEJ617N8XkGCVoQ5lRypFnmGaC2Y8nwDgitXxEY
	b0sbPIwdXnQ3/xm+eg1h8KvItQrwXU+v2b457+50lLLMlgb1yWSXuyxV3EyPtrRXkO2UrhcA==
X-Google-Smtp-Source: AGHT+IH58K2fkRuNeCFONQo5PN3X5lTd6kkVRVrUL8HrgTghUwX32Msen1mn/KH+JIVLSLRjRmPpIQ==
X-Received: by 2002:a05:6214:d0f:b0:88a:342f:32a with SMTP id 6a1803df08f44-89084185ec7mr128066396d6.14.1767914741275;
        Thu, 08 Jan 2026 15:25:41 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-890772346e2sm66493856d6.33.2026.01.08.15.25.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 15:25:40 -0800 (PST)
Date: Thu, 8 Jan 2026 18:25:05 -0500
From: Gregory Price <gourry@gourry.net>
To: John Groves <John@groves.net>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Dan Williams <dan.j.williams@intel.com>,
	Bernd Schubert <bschubert@ddn.com>,
	Alison Schofield <alison.schofield@intel.com>,
	John Groves <jgroves@micron.com>, Jonathan Corbet <corbet@lwn.net>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	David Hildenbrand <david@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Stefan Hajnoczi <shajnocz@redhat.com>,
	Joanne Koong <joannelkoong@gmail.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Chen Linxuan <chenlinxuan@uniontech.com>,
	James Morse <james.morse@arm.com>, Fuad Tabba <tabba@google.com>,
	Sean Christopherson <seanjc@google.com>,
	Shivank Garg <shivankg@amd.com>,
	Ackerley Tng <ackerleytng@google.com>,
	Aravind Ramesh <arramesh@micron.com>,
	Ajay Joshi <ajayjoshi@micron.com>, venkataravis@micron.com,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH V3 02/21] dax: add fsdev.c driver for fs-dax on character
 dax
Message-ID: <aWA80edCywOLw0li@gourry-fedora-PF4VCD3F>
References: <20260107153244.64703-1-john@groves.net>
 <20260107153332.64727-1-john@groves.net>
 <20260107153332.64727-3-john@groves.net>
 <20260108113134.000040fd@huawei.com>
 <6ibgx5e2lnzjqln2yrdtdt3vordyoaktn4nhwe3ojxradhattg@eo2pdrlcdrt2>
 <5hswaqyoz474uybw33arwtkojxrtyxrvlk57bdwnu2lnpao4aa@4vxygh226knw>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5hswaqyoz474uybw33arwtkojxrtyxrvlk57bdwnu2lnpao4aa@4vxygh226knw>

On Thu, Jan 08, 2026 at 03:15:10PM -0600, John Groves wrote:
> On 26/01/08 09:12AM, John Groves wrote:
> > On 26/01/08 11:31AM, Jonathan Cameron wrote:
> > > On Wed,  7 Jan 2026 09:33:11 -0600
> > > John Groves <John@Groves.net> wrote:
> 
> [ ... ]
> 
> > > > diff --git a/drivers/dax/Kconfig b/drivers/dax/Kconfig
> > > > index d656e4c0eb84..491325d914a8 100644
> > > > --- a/drivers/dax/Kconfig
> > > > +++ b/drivers/dax/Kconfig
> > > > @@ -78,4 +78,21 @@ config DEV_DAX_KMEM
> > > >  
> > > >  	  Say N if unsure.
> > > >  
> > > > +config DEV_DAX_FS
> > > > +	tristate "FSDEV DAX: fs-dax compatible device driver"
> > > > +	depends on DEV_DAX
> > > > +	default DEV_DAX
> > > 
> > > What's the logic for the default? Generally I'd not expect a
> > > default for something new like this (so default of default == no)
> > 
> > My thinking is that this is harmless unless you use it, but if you
> > need it you need it. So defaulting to include the module seems
> > viable.
> > 
> > [ ... ]
> 
> On further deliberation, I think I'd like to get rid of 
> CONFIG_DEV_DAX_FS, and just include the fsdev_dax driver if DEV_DAX
> and FS_DAX are configured. Then CONFIG_FUSE_FAMFS_DAX (controlling the
> famfs code in fuse) can just depend on DEV_DAX, FS_DAX and FUSE_FS. 
> 
> That's where I'm leaning for the next rev of the series...
> 
> John
>

Please do that for CXL_DAX or whatever because it's really annoying to
have CXL and DAX configured but not have your dax device show up because
CXL_DAX wasn't configured.

:P

~Gregory
