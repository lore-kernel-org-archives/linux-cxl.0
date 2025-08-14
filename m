Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C311C311C16
	for <linux-cxl@vger.kernel.org>; Thu, 14 Aug 2025 13:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755179953; cv=none; b=PRmi2HfW/jZbmB3XxfolEQ1RlPX79F2hMbWzwsk77ZUVZgjl7R5sPkQ8zQMOo+6gJf9gTtUVn80MU+AK3yo9zrDyTthXMlPKKfmdqY36XgfcinCHwfS4TrIpm5GFvn07Nc5rSqh4nQBLLZfrc3dqJOREqvx+xuYGVZcqba4XgQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755179953; c=relaxed/simple;
	bh=4ExxKGDx0fgiOXw8CTywAcBsJ8ogwJcpwNnL1i5YNn4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lEqAgw+4xUjiZeaBr6KontaHut9DCriuGZUwiZL+IvrcXlunBfpLaz9q2EIsuyI1P/62at6bpCap2V0hBQgZ+HgBJq1ctFv0ijHoOoB3G+U6gwaAdiZyWFMaih2q/5Yb4IYwtSBbp0HGcZHxuPD3T8+PvbWdiOAWEqnOY5kGuvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=N9PzrbPR; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="N9PzrbPR"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7e8706ac44eso136906285a.3
        for <linux-cxl@vger.kernel.org>; Thu, 14 Aug 2025 06:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1755179950; x=1755784750; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4ZZu0s3S5A8+/SIi2GUbQjh84N2xIaZ27oBHRZEOGZ0=;
        b=N9PzrbPROtxWyZbVaEBxCJ+BwqqrykRK9dMm5PlCwrgj52BJTh0yaIKl6U+TBukioz
         BPxbfO2yXzEC2/eypvErSF9CJUW2sfKkMpg9uPwPErqosswfRFh3t0BTbhDI54npUagA
         lilmlNGdIvGBEGMnLDjZnPV+IPwZ9Rp6Swc0c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755179950; x=1755784750;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4ZZu0s3S5A8+/SIi2GUbQjh84N2xIaZ27oBHRZEOGZ0=;
        b=s5hksVoYiFN/1/9t3d+p8Bkq3EQnietveNNECdTH7+kMxb+cgE4N0N64f/GclFrA6j
         4VIUf10A/etaduoxSrzfvds4gcOVPJUyghFQKTc92nwZhZ+Cjd9JfCC+DjUTlXgll0tI
         BYJHyduu9girV8tyQ9fcLRp4eOtt95dyvO3q3vxiC9IwJDp0Bb+IgbRzAbkYkeq9m9oU
         lhL1kxqq0SGRMgpjEUy5kB2NRUuy7PbQK2DINpwjuKT+oFkX0CE3Fb5nvWFEptTioYdG
         Vd0MYHE/EktEAGQg5KmCoF0tfAjoDhvQHJZqPCXrExssfANc/rs1OnxXAV0KI0Goaypa
         qE5A==
X-Forwarded-Encrypted: i=1; AJvYcCV0mqSq4MmZr8Z32GkKbK4/TWJjNLrG8YdMBy7xxbcHDq2W8F7Em7f0hz0y/ODKtwOjZg0EU48NkDc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2QcKWAM5pY8V1BWb6cslc2D67VjOLE2mVSyel5rqGtWAuNaX2
	nWMYAqaehRKtcyw+fKO7nfezm/zgrXvuZ2TKIc96SKNv0wLNbxS+J09YpR7mZ4B8OnXTOxX8fiI
	ceCz7TKPG50vc5Ex7HFw2yzxMr24ZzvAJMBwwTg2MRA==
X-Gm-Gg: ASbGnctDoxG/3T8d7DFgveuthaVKxORYgRTNwtCNNXbznuKCWNxfFG2Qh/c1Vezb+EU
	0zLl4EhovANs9bQOvYHMa0+qYKLZ4tTzJe0bfLy889daIBNoNWVlhyrP9ObPbYpePO1AxKQUB4h
	piOkmKee70RKhijtthvN6cLtMruiPrFnng7y41I3ggK5oWF2HS0b2YGqF4Nxpqs7Yu3deYpfoSl
	X6p
X-Google-Smtp-Source: AGHT+IHDCZisldsHFROueT1mDv+N2w5BriAS/91vOctNmeG6Etw7NNZmRk8u6yHZ87xrdPA7iktx621LgwaHh85teV4=
X-Received: by 2002:a05:620a:e0a:b0:7e6:8545:5505 with SMTP id
 af79cd13be357-7e8705a2a88mr419769985a.55.1755179950579; Thu, 14 Aug 2025
 06:59:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250703185032.46568-1-john@groves.net> <20250703185032.46568-15-john@groves.net>
In-Reply-To: <20250703185032.46568-15-john@groves.net>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 14 Aug 2025 15:58:58 +0200
X-Gm-Features: Ac12FXxPrNeYbLt2gO4V6U2nB86--yn65EeQtUloUgMUUdsnzFSb_AaNjXQhYqI
Message-ID: <CAJfpegv19wFrT0QFkwFrKbc6KXmktt0Ba2Lq9fZoihA=eb8muA@mail.gmail.com>
Subject: Re: [RFC V2 14/18] famfs_fuse: GET_DAXDEV message and daxdev_table
To: John Groves <John@groves.net>
Cc: Dan Williams <dan.j.williams@intel.com>, Bernd Schubert <bschubert@ddn.com>, 
	John Groves <jgroves@micron.com>, Jonathan Corbet <corbet@lwn.net>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	"Darrick J . Wong" <djwong@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Jeff Layton <jlayton@kernel.org>, Kent Overstreet <kent.overstreet@linux.dev>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Stefan Hajnoczi <shajnocz@redhat.com>, 
	Joanne Koong <joannelkoong@gmail.com>, Josef Bacik <josef@toxicpanda.com>, 
	Aravind Ramesh <arramesh@micron.com>, Ajay Joshi <ajayjoshi@micron.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 3 Jul 2025 at 20:54, John Groves <John@groves.net> wrote:
>
> * The new GET_DAXDEV message/response is enabled
> * The command it triggered by the update_daxdev_table() call, if there
>   are any daxdevs in the subject fmap that are not represented in the
>   daxdev_dable yet.

This is rather convoluted, the server *should know* which dax devices
it has registered, hence it shouldn't need to be explicitly asked.

And there's already an API for registering file descriptors:
FUSE_DEV_IOC_BACKING_OPEN.  Is there a reason that interface couldn't
be used by famfs?

Thanks,
Miklos
