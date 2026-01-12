Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E0336BCC5
	for <linux-cxl@vger.kernel.org>; Mon, 12 Jan 2026 16:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768236416; cv=none; b=PTa3gSoHbDLM51LBDNTnLBeS3nC0erMreuThrkuRG9tJg2i2O/y1bM8Qgra6RB2bhFdq6e/PKP4WyCsunpvh7TjCAHuEzsqjysml+JS2TTCjEPQoQyq3l5X4P2OQuys/jqNrTSpslGLslZ6sPTfebjIGavPpz8DCLufGHYEC/Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768236416; c=relaxed/simple;
	bh=8lgp9tnyFzGocHb8jl6w1NG/N7Zcs3J+oUbbLZskDQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W2tHS/698QZYU0o0tlq9s8fRJoM48qvcAcMf99xWdJy01Pslh5mOfwavryhnfh4lTZoEs5pXOu7Yw/pp/pxn1VcY1HdG+APq33t5AimFwOnbelC+h5nylJPZ0G2/uevjhf7564LSnCcGpxFh/S3Q9bklXS2Is2JvGpaJA+yeQJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FVNtrd9w; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FVNtrd9w"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7c6dbdaced8so5498954a34.1
        for <linux-cxl@vger.kernel.org>; Mon, 12 Jan 2026 08:46:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768236405; x=1768841205; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n6deLDrT44WMlKVvRfzJXPGGgj/xg0j1HG9++H6LUz0=;
        b=FVNtrd9wO5lp/y8ML5TJtEg2LVNoKpMuvXUTY8BKHqCPebt7zyvkOdNSz2l9+PqKFo
         g1dosaCKVbNh7nUAtxpC2VtVFARScgjWXE5Pz+6Uo/4nrd/IExc7v7gWNOC22kbRMvAU
         U36Y+xhtUulxquh0ORokEYUGuGNP+XSQOzgVwv9S9ON1yGVWuBmbCV7ALcPPYMWtjDwP
         sNHUg7roftqLGiWVbgqkQVdPdaZMytBn4QK+AXfgkuR72v2is+0n0Gcco/vlTwyt/XVd
         EelSYEx3zxMxi1BNWTzDtUiWRxiu+YdbC+09h3mMg5fQItDlIRyxROasaNCaV6pVlHwE
         Gj3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768236405; x=1768841205;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=n6deLDrT44WMlKVvRfzJXPGGgj/xg0j1HG9++H6LUz0=;
        b=ai5P9KOPQ2c+vB8h0kGJXRNlMGb3D3tFKvWMCFG2VoJdwlWlZ9OckSqw/ukWNL+s6R
         CAxpwZVN+HI9wINDLJoEu+B5zMwADxFad2dfEkxwRrlHBhyW7T9I4guFOTOlheLbrfUu
         6fE0yf6u+51vfQdq+l8d4Qp6Yv/M3bNANowtLbLkFMXlTqs2AsPan9yPed/+K/9sR4VG
         QiKd+1fawfHFB2f7IiU2ZuoEBs5R4yf1/bIoCDm1MlYFqf32neiMmQCSo5gKgMfwxNPo
         GXmfv1k/Cl8bsrRU84r2K+Ihi+j+YmuXzVUYO2O5NN7LbJRCrDUhenoAJ/mTOv2hOhTO
         3/4A==
X-Forwarded-Encrypted: i=1; AJvYcCVOOG9Ec/EtkBaj9OnzxwJqfo7I3CFdtOTCurWBJnJmk83MJQVLvADOb3TANpuSMSuPDBKZE+5xTFg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLOYRuUguIjVrw/fUu/U2zryeDFtjWdtFsPi79iDpSfCweUmpN
	R6pJPDpwIhOo9MtXJp/gj8iqa9VX7uy+Sd5z94ZPJgRk5tjckkx64ngi
X-Gm-Gg: AY/fxX5/lrqLrRueMqi+8gO75YI++Ek7eh8DhmF1Iae4FXE2X3IHgMFQMeJnsWsukOY
	Xt1wvvbpYRDOoYroO1//l8QzjpfK2imL0YBAxpsKWucZ/Sn3QEf8Btck1WRAKAvj1DHEc5oaqV0
	ge1Jf4eBIs8UMu1DOHrecz9hbZ0rHZtiiw/i7aBmTnFY5103KSr2BmyujcudJX5qqqfexvECetJ
	6jTBr71UfXYYYel+5/r9Etop6XoKwIaj5zNSQNyUkJFiiLnmYszuQzcB2hUXBZCW5eqLl1YDclj
	GGCnXZNOyg/kt9MeQe0LlOKvzUCPecMhqiGCtU8XSbJ1LB7bOr6UzwD70UR2aswEY9KBSxJFG6d
	dKqyO32tFSAKEMNY9stN9cR+/n0ZcZ7A9fdaylJTeAME2xCFzkTNBEocQRDxmUs1YcyyHR5XUHi
	4VnAS8XRbQO+ELg17nLXAln0eqZDXB7w==
X-Google-Smtp-Source: AGHT+IGkPS/NCs2Mk5Oq2bbD5I5Nrr2IjEdlrsoDxvBDNYRoKgitfj+LmMDnnes+e1yquAKJv+M8AA==
X-Received: by 2002:a05:6830:2e07:b0:7cb:1270:1255 with SMTP id 46e09a7af769-7ce50932573mr13073106a34.16.1768236405392;
        Mon, 12 Jan 2026 08:46:45 -0800 (PST)
Received: from groves.net ([2603:8080:1500:3d89:b02d:f13b:7588:7191])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ce4781c286sm14241471a34.8.2026.01.12.08.46.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 08:46:45 -0800 (PST)
Sender: John Groves <grovesaustin@gmail.com>
Date: Mon, 12 Jan 2026 10:46:42 -0600
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
Subject: Re: [PATCH V3 10/21] famfs_fuse: Kconfig
Message-ID: <26sfkgpuqdle2nmj4kcv7j2bgnrlpfo3wglfzqiuagjucnufx5@b4ggxnalmcwr>
References: <20260107153244.64703-1-john@groves.net>
 <20260107153332.64727-1-john@groves.net>
 <20260107153332.64727-11-john@groves.net>
 <20260108123638.0000442e@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260108123638.0000442e@huawei.com>

On 26/01/08 12:36PM, Jonathan Cameron wrote:
> On Wed,  7 Jan 2026 09:33:19 -0600
> John Groves <John@Groves.net> wrote:
> 
> > Add FUSE_FAMFS_DAX config parameter, to control compilation of famfs
> > within fuse.
> > 
> > Signed-off-by: John Groves <john@groves.net>
> 
> A separate commit for this doesn't obviously add anything over combining
> it with first place the CONFIG_xxx is used.
> 
> Maybe it's a convention for fs/fuse though. If it is ignore me.

I've squashed this into the first commit that uses FUSE_FAMFS_DAX,
which is 2 commits later...

Thanks,
John

