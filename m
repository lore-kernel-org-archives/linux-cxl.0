Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949992E7F25
	for <linux-cxl@vger.kernel.org>; Wed,  7 Jan 2026 21:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767821453; cv=none; b=qlRyqOmFWUwoqsx40MXWTb8yiW8yc/KuG3mUfjXdDQP2ibSF5R65HFASlCu0n8gdIyaRyIds1f66gu18dDAL0DwCnXxnvwZtPAYZ4N4pX7ffF2dJi2IgHZTCXK/Ii0FDIlFzYcnkXCb56G93MBiRTyagSoXAtyVYy7QkAZNgLLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767821453; c=relaxed/simple;
	bh=hJBhEZEn2IW0Qs8Ce9poSTsX2HFP1recNbm+Qx+TfOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bJoxeixpOFAmEZilgLaUtKbyDewg5UjVuzbUQvKyqfSTz+FtY+7/uZg595sU7MfpuOflhJRA5O3+vgnsPcZATDfxI1I6cS/M4Ein3J2XcJ5UYB/J9GLLsXSgqRxZjMe3ijjL6Y7mB5iE8WIGhJSkHbLxZVgPQoKrSHJbwgpfEJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k620oX6k; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k620oX6k"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-3fe9d6179efso784678fac.1
        for <linux-cxl@vger.kernel.org>; Wed, 07 Jan 2026 13:30:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767821449; x=1768426249; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PgyJxKcUhgy66+q0k0EwvKHt6dTWi7O1SwlvNA4nT9c=;
        b=k620oX6kftWHDnDeRjmIEer/+zMgkbptqwQN/iMdDylr09K3ufPyVnfXo4YiSIh1uA
         37Q7ccohaGiHSeMyJPY3HpkSMeabsbyia9fxbcPZWbXYa/y057+G/CU/usYGfIr3LwHU
         v94gAyZs2dUGI4cUoKL1DEcP/6HZVRLfPR8BJ5ItqNThR2onBRZnfnAr4W4uilFDuPQB
         yXd2El8PgA7qNs1hZTkDtPIUjd3G3MnWRpUTzgB0CxiRDfTSYRl2OF03yjawJkIqQ/MC
         lV91klAR4LJVkvTetxZv5qeSxSngJBJBhwgskucop3zv5gS0gqh2PlEWbsshAVOq9KUI
         IRyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767821449; x=1768426249;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PgyJxKcUhgy66+q0k0EwvKHt6dTWi7O1SwlvNA4nT9c=;
        b=b2gmzEbE8cXAqVl1fO7hhsT4QVpH3AfNU13MLqMoCZFT2LEMddlEHSwC0RoZAl6TQg
         a+Uw+Up7xTa/+DS9KFCUWPIjrRHHkwZ0iiTBsQ2jWq0vhG+unZyuHByIzt5tnGTQ1GEs
         34LeUyA+t9an60pAjeX6pEPXp4mtQRsTR5XjiESWNwRlyeqnbLHjlxtMcuxlF8e/PhkR
         MRwHKA6uA+OPkIDVJDcgD3O6RiZGcHUKoRTqJaLeuy1w05HGRkoeA3JvaFRVMtBFX6ZM
         xsgRofXTO7vPeeaRZgLsIkMQS37Chs0MIkCopdj5Gu9khPhO5hOUnViVDtn6OVDxxBa2
         gY6g==
X-Forwarded-Encrypted: i=1; AJvYcCVPh7hSl+tmjXplMJ7xxy5hFYCwrn4VSNbYNVkHS+6V9Dgjrcq2aP2Zh5Zdoc9Wxssz6n+Tk9vNvvY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnfX4JxwQiNe1aLh5Jr/0J550xxEm5S8BuxmaMirFUoE8SBi0Y
	wJ5TGv6P/M0/UuqscVwMNQPkapSv9QRTF8F5Ug+tXTWhfGiHBmoChFmV
X-Gm-Gg: AY/fxX7Y8MXMS6pHFNlGjOLwZIQENEXkTXxWBZtLftCzmNAHYDW60vTR1skccQjBTC9
	xUjtd1ux7usVJapZl6+w0f+7Vi+dt8upSwEZhoXgbs1Z6BcD79WEpWUICYRHNayKv17XWGQ79xq
	WCEraefX3z4vqNqTrnfRlKzrsb4iDaDnJ/Ywr3Sr8j1XGGpJvJnRg0NulHBzhJE7jNd6FB0zhGv
	iRYKlWMeVqkb7n6hgOch9ioB/Z27/lxHY9TbnOJyJ+gRBmRmiWxkLAZiYk41oMqh/09NNYocNwl
	zbrNxkBhJ+IB77W4DONw3lwCm8r3Q4x6TlQ8WxBFlPqmihOpLoYOul+MxtnsaiTVvZiqL9+zqV6
	4hTdj2A7iARJpyyhDeYmdxaDgdLRHsXP21MqS4M8cZMRTz5wvnUvW0DTcobG9Vnd8VV2sJWBEKx
	HGEsFwXvGODLlR2aWS7vYSoKGIazvN0yCG9JoA1zn4
X-Google-Smtp-Source: AGHT+IGBpBXjThN1EPukRyzeQDjnIkWKrC19wevk+xy19Ke7HdDQYha50/3EOc1Su9/w3oCaFtcjKw==
X-Received: by 2002:a05:6870:4191:b0:3e8:92f2:caa2 with SMTP id 586e51a60fabf-3ffbed0d56dmr2067280fac.5.1767821449438;
        Wed, 07 Jan 2026 13:30:49 -0800 (PST)
Received: from groves.net ([2603:8080:1500:3d89:a917:5124:7300:7cef])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3ffa4e3e844sm3874317fac.9.2026.01.07.13.30.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 13:30:48 -0800 (PST)
Sender: John Groves <grovesaustin@gmail.com>
Date: Wed, 7 Jan 2026 15:30:46 -0600
From: John Groves <John@groves.net>
To: Miklos Szeredi <miklos@szeredi.hu>, 
	Dan Williams <dan.j.williams@intel.com>, Bernd Schubert <bschubert@ddn.com>, 
	Alison Schofield <alison.schofield@intel.com>
Cc: John Groves <jgroves@micron.com>, Jonathan Corbet <corbet@lwn.net>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, David Hildenbrand <david@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, "Darrick J . Wong" <djwong@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Jeff Layton <jlayton@kernel.org>, 
	Amir Goldstein <amir73il@gmail.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Stefan Hajnoczi <shajnocz@redhat.com>, Joanne Koong <joannelkoong@gmail.com>, 
	Josef Bacik <josef@toxicpanda.com>, Bagas Sanjaya <bagasdotme@gmail.com>, 
	Chen Linxuan <chenlinxuan@uniontech.com>, James Morse <james.morse@arm.com>, Fuad Tabba <tabba@google.com>, 
	Sean Christopherson <seanjc@google.com>, Shivank Garg <shivankg@amd.com>, 
	Ackerley Tng <ackerleytng@google.com>, Gregory Price <gourry@gourry.net>, 
	Aravind Ramesh <arramesh@micron.com>, Ajay Joshi <ajayjoshi@micron.com>, venkataravis@micron.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev, 
	linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH V3 15/21] famfs_fuse: Create files with famfs fmaps
Message-ID: <smqodjljwvhnssmq4ho3hicnomzyrpsawy65ykxhigrjl7yawu@xwtbxjamivk7>
References: <20260107153244.64703-1-john@groves.net>
 <20260107153332.64727-1-john@groves.net>
 <20260107153332.64727-16-john@groves.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260107153332.64727-16-john@groves.net>

On 26/01/07 09:33AM, John Groves wrote:
> On completion of GET_FMAP message/response, setup the full famfs
> metadata such that it's possible to handle read/write/mmap directly to
> dax. Note that the devdax_iomap plumbing is not in yet...
> 
> * Add famfs_kfmap.h: in-memory structures for resolving famfs file maps
>   (fmaps) to dax.
> * famfs.c: allocate, initialize and free fmaps
> * inode.c: only allow famfs mode if the fuse server has CAP_SYS_RAWIO
> * Update MAINTAINERS for the new files.
> 
> Signed-off-by: John Groves <john@groves.net>
> ---
>  MAINTAINERS               |   1 +
>  fs/fuse/famfs.c           | 355 +++++++++++++++++++++++++++++++++++++-
>  fs/fuse/famfs_kfmap.h     |  67 +++++++
>  fs/fuse/fuse_i.h          |  22 ++-
>  fs/fuse/inode.c           |  21 ++-
>  include/uapi/linux/fuse.h |  56 ++++++
>  6 files changed, 510 insertions(+), 12 deletions(-)
>  create mode 100644 fs/fuse/famfs_kfmap.h
> 

[ ... ]

> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index 9e121a1d63b7..391ead26bfa2 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -121,7 +121,7 @@ static struct inode *fuse_alloc_inode(struct super_block *sb)
>  		fuse_inode_backing_set(fi, NULL);
>  
>  	if (IS_ENABLED(CONFIG_FUSE_FAMFS_DAX))
> -		famfs_meta_set(fi, NULL);
> +		famfs_meta_init(fi);
>  
>  	return &fi->inode;
>  
> @@ -1485,8 +1485,21 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
>  				timeout = arg->request_timeout;
>  
>  			if (IS_ENABLED(CONFIG_FUSE_FAMFS_DAX) &&
> -			    flags & FUSE_DAX_FMAP)
> -				fc->famfs_iomap = 1;
> +			    flags & FUSE_DAX_FMAP) {
> +				/* famfs_iomap is only allowed if the fuse
> +				 * server has CAP_SYS_RAWIO. This was checked
> +				 * in fuse_send_init, and FUSE_DAX_IOMAP was
> +				 * set in in_flags if so. Only allow enablement
> +				 * if we find it there. This function is
> +				 * normally not running in fuse server context,
> +				 * so we can do the capability check here...
                                         ^^^
Oops: this should be "can't" - we can't do the capability check here since we're not in
fuse server context. Will fix before merge...

[ ... ]

John

