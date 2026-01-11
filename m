Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F56234D3BA
	for <linux-cxl@vger.kernel.org>; Sun, 11 Jan 2026 18:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768155878; cv=none; b=DE5ZiiojXshaf1WfNtUaHRxRJf74GL/jXkIE/65HFbh0b5NMml7/SZZ15I1hBnTq8/2IwHyw/hGUTFR1SQpzzwhUaqbYD6S8T13f6C6QQvVmOi+gckfpZB5bZgVR9Hn91DuerOm2g2dfyoGKPutWxRG9sYKfbIvoPi3et0f/7bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768155878; c=relaxed/simple;
	bh=wuZGY6SRlUzNFhhRYK2DoKN94QfIw6eNulOP0xDDvY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tzvwW1Nt9nwxGIRcM48dKr6oF9wJ9UfrEbxbnGyobed6+zDPnC/qlBfPsObiXRqF3SGwWOKEeMk3TPTpLgtxfZhU/+lThDrtXfMGMDzztESJT2z3y6TY4WvIjlnqvR3Fc26EEF8KOMQRR6FdqSIeMThlWwoPi/fBgAjxLxGjYtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fD6DZ4g7; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fD6DZ4g7"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-3e3dac349easo5065408fac.2
        for <linux-cxl@vger.kernel.org>; Sun, 11 Jan 2026 10:24:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768155872; x=1768760672; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R+GSc2GBWlyyKLR953NpzcUC6v/+T5KZ51y3NFrwZfA=;
        b=fD6DZ4g7gNAjBngOltJ00A8QVXfV02G58R55KJB/NEcXZw738j6DJIKDDzlr1wVvdi
         0S2wcMcX1vEiRATRpyEVPjF2tn277Zqrw8+342E8rm+WlXB1mQ45dwujuTfdHcGonnc1
         L1L8LGOQDBH5rnrEzH5WfPv1NM+RtPKoTOmf1n3zIOFzv7NDjstCDKveuMSHaYkIGf+G
         JJmDwh/qXfqHwtHr/v+/r1zfKJIYNfwJ2XgmBD+QndIxpQe8ioSAtz3ezVwDkrRNHRDW
         wOEY1V73tcV+gpWguNsaSMGS9nVNOB00tcki+vp7YnYvYv53kIglsl0FMsmdHVIOeuZV
         jFKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768155872; x=1768760672;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=R+GSc2GBWlyyKLR953NpzcUC6v/+T5KZ51y3NFrwZfA=;
        b=hU7nDE0g8ynN9Ay/y0WhbZTiyiDKjhuDEByWljURFgXJNEE/nHH9JZKFcP55Xo3BT+
         ACgflHvZXCXiruHD4q6d2uvH6IP/Ht3Fy4SIN/eZMdXW+WSpcURN364c3d+suD42H6Og
         HI2VEq0yf0h2+MKKv9S5p/VYeVlzYdTVBUvnrTfV160aX/h5jRqtk9SUk2951aHqM5C0
         0UqRF+lguahazvljIMj8dHpUAd3nzWUwjxsnWs1IiCeFG1g1bnkwoQ2YAmO2vOcmp4Fd
         iU717VzYTBg4rY2Q0t4/s48tlfjbWS8YTu6aV7e5otxYPOwyidIWEluVK0qjPNNkyt2Z
         An6g==
X-Forwarded-Encrypted: i=1; AJvYcCWkRzbQbiURWJ6aTTi9fZkU6j4jbPmB/cEhpeDfE6ZoLFkcvaBcrCmtAi6gucfgN7gmnG6l8WHZoCY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc2vqhMHu7GjW1TK2cONeuUpXY+mPaMw//VGQw6wy4fraRVC2I
	naCrEUcCXk3eaf4aIG3kJ2+YkxFLVaVLp2mladYYBXPSA1UsTCdmz/2+
X-Gm-Gg: AY/fxX7DHaJHvW3MaUC4sq3qtwGuqjWlEFrJMc1WD6BvvPuKOMLiexA9Y6v3IEmriwg
	QDB2ZnRVrMDamIyESPHV9Dpdlz3bDGLJIg2c290D5JRqGgu+Hk4aWpZRO/2R8ilzBs32DLpWRv8
	LoG653DYAbNSEDn012neDeLwSrqUt9XFeXjFFze/jRVsZ5lwtLcoNFr3fSHCWZN7zBAJPJm/Nq+
	j760KTBPP3PK+mXlKZovArpbUHGdeFmT2+bWO6TmY1y/oL/m2PTEb2o/ZGez776eSIJnlW9Mc1R
	hnAoOzQTDbQB6t2NTyQ57Niy3shToVIyZZ2uzc9NUWJi7VVSQPbc8E25s1o+W7QWcYkiH+I6Wqc
	fCiVze1zs8g3R/2o2wyIGjyKKTG5cnMdgYTzzbD4TM3mzGsN5oFT1ymbSrmMQh2otjEQsmodSbL
	TwmcFnqsM38gOtnTe/MUEySDBLqE935A==
X-Google-Smtp-Source: AGHT+IEvvggI2mJmOtqFQTAS39y6eV7fvRie7hl/ldDRYe8R5GovPjr7x7SyKxaIKesqgZD+L7TFNA==
X-Received: by 2002:a05:6820:1694:b0:65f:6601:b342 with SMTP id 006d021491bc7-65f6601cbd8mr5456330eaf.7.1768155872287;
        Sun, 11 Jan 2026 10:24:32 -0800 (PST)
Received: from groves.net ([2603:8080:1500:3d89:cc0c:a1b0:fd82:1d57])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-65f48bbc0desm6567999eaf.2.2026.01.11.10.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 10:24:31 -0800 (PST)
Sender: John Groves <grovesaustin@gmail.com>
Date: Sun, 11 Jan 2026 12:24:29 -0600
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
Subject: Re: [PATCH V3 4/4] fuse: add famfs DAX fmap support
Message-ID: <2mr7vou7zeauqypqq3xay6wdmc6g2havk2e33cfphwylu7dnit@qk32hbe7zgy3>
References: <20260107153244.64703-1-john@groves.net>
 <20260107153443.64794-1-john@groves.net>
 <20260107153443.64794-5-john@groves.net>
 <20260108153148.00001e63@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260108153148.00001e63@huawei.com>

On 26/01/08 03:31PM, Jonathan Cameron wrote:
> On Wed,  7 Jan 2026 09:34:43 -0600
> John Groves <John@Groves.net> wrote:
> 
> > Add new FUSE operations and capability for famfs DAX file mapping:
> > 
> > - FUSE_CAP_DAX_FMAP: New capability flag at bit 32 (using want_ext/capable_ext
> >   fields) to indicate kernel and userspace support for DAX fmaps
> > 
> > - GET_FMAP: New operation to retrieve a file map for DAX-mapped files.
> >   Returns a fuse_famfs_fmap_header followed by simple or interleaved
> >   extent descriptors. The kernel passes the file size as an argument.
> > 
> > - GET_DAXDEV: New operation to retrieve DAX device info by index.
> >   Called when GET_FMAP returns an fmap referencing a previously
> >   unknown DAX device.
> > 
> > These operations enable FUSE filesystems to provide direct access
> > mappings to persistent memory, allowing the kernel to map files
> > directly to DAX devices without page cache intermediation.
> > 
> > Signed-off-by: John Groves <john@groves.net>
> 
> 
> > ---
> >  include/fuse_common.h   |  5 +++++
> >  include/fuse_lowlevel.h | 37 +++++++++++++++++++++++++++++++++++++
> >  lib/fuse_lowlevel.c     | 31 ++++++++++++++++++++++++++++++-
> >  3 files changed, 72 insertions(+), 1 deletion(-)
> > 
> > diff --git a/include/fuse_common.h b/include/fuse_common.h
> > index 041188e..e428ddb 100644
> > --- a/include/fuse_common.h
> > +++ b/include/fuse_common.h
> > @@ -512,6 +512,11 @@ struct fuse_loop_config_v1 {
> >   */
> >  #define FUSE_CAP_OVER_IO_URING (1UL << 31)
> >  
> > +/**
> > + * handle files that use famfs dax fmaps
> > + */
> > +#define FUSE_CAP_DAX_FMAP (1UL<<32)
> 
> From the context above, looks like local style is spaces around <<

Fixed, thanks!

[ ... ]

John

