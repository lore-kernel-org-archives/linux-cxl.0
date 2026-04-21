Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191933D88FD
	for <linux-cxl@vger.kernel.org>; Tue, 21 Apr 2026 14:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776781818; cv=none; b=G5Z7c4LDoA99npMroI9z0Kyih8RnKLtHXgSPASfEYWC8twT+MUlC/gI5tLN9BTaA+FjHjwXKtt8YgGYD42VYlTv4G9Hqsl/vHj5dnz+yTrk/p9ixxYIAWDbDkDrMWhcMyOH7nBb9TI15jWbqKGPdYdUYrBQKKg6vN6YYEvdhadI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776781818; c=relaxed/simple;
	bh=OOpDos/Z9VaSP4OAHAzHjn2FVBZGB3TMPAJ8x0XR0vE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CvLHImTXS7oLOop2F7ADQTOn0h15LWumEcT+hief2ZXyLl7fW5xglt9zIHTQEPWvchwqUMKuVho3VT+PclFa3WYWoMp9XeGXUk4UDOXUeWu8zpktkMDERzrjPvudcSALH0PONdeohfoPIUazve8TcptL72cCbEjOI5mHQDnPTxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=nv6IqAge; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="nv6IqAge"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8ee9ec26edaso68895785a.2
        for <linux-cxl@vger.kernel.org>; Tue, 21 Apr 2026 07:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1776781816; x=1777386616; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=J5FC0V63oKQuJOmL33I9jXWd+zejUzRlce9wtAa95Fk=;
        b=nv6IqAgezxRTS03F5H2sfHbpNAFezFE5HRwGpJdZXknUntLjoOnrnLWK2wpn/ho25r
         yUaPIfOJOD8UJY7AhvMEVyAJTe9cM7Z6LldDkkBMEZokffMxWw8CUtbo3Aew8F2seGhj
         bhaXryGBdHCVZ7chQdqgdNZ2Def+5K5Jx6B6LFwC3qqv3KfLKAN8YYz22lFheeWhXpN0
         FGckTS646Uku4JjhwBpwRwEXGkhu++s7XPH0Mg9Fgcv4sUZHIPI3q8uy7zbSuQZ/ue79
         xv80KCl2EeWv3zBCci/7Qt0+iRV0Ugn6Ib/Hj8N0B7PiySIG5i1/2orqpWJj21Sd3SBq
         GLdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776781816; x=1777386616;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J5FC0V63oKQuJOmL33I9jXWd+zejUzRlce9wtAa95Fk=;
        b=F2ON5+8Rz6pWu6WuA8Rp8Pr5gBlcE+TKpqldnG0sbHo4ne5MlYeU2jY+clIIAW5Lkl
         PuIGFz598iHSODVFyla/Nlbak8UQLilLNJMSMyk2P5Hz3YThLBBc1aVE2MPOEe6yTiCC
         PwsuENaijUptNBynuzSZo1YgtXiypsJhLkb6zVGN6cwDNZG/oN9WJxhnLvgYDL/Nm8uz
         O2UOrQ15+rDxBjMPuLkAXS3jfg//u0u3JSp77IB/Ap0myJGBBq47qk5pPra9Mev8xagA
         x5e4Mx4sN3gkS3Giat8h8PjigmXVA2pdI9/tZNcAo8jHozjHFeyUAWz+qSwnmhVwcBi+
         R2Sw==
X-Forwarded-Encrypted: i=1; AFNElJ+ZCUINdKP7RfUeLsrGWYXDBwoniovVOs7zMNYlk4/RxYKZQwuRnF7vzhpB3cDqLWf9UW4UTwWosqo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8yCFD5bww+lIJesAWyKVekGuVrHbZ1nkYls5VaKo75uBiyGAd
	ldGd8gTknp33fboLy5NnbocLRalZe4zPTBY33BFq/WsQL9nK+0AdOm371U371ZKz7Xc=
X-Gm-Gg: AeBDievA7bu1iVMx4Z/dbUT5XlhYF+YjgVR+S8HE833zS5Ycr+CdBfyKs7JTHY13vsM
	t0N+TgroUMgHGAiwhzuDBPnelsPNWG6wAYGtONOAEHZw34FuQWv6hdBYpbmqT7YnldwXJgSJOaf
	IkCB2dbKXCYOt3sxJOUIHUzF3rmnwLPx7JEP5HFPfVg4muGS86s/ByaXwWQLOaWHejI1vI5b0yx
	wBSOjLkpVdRI/ecZBwk9eIjL3zel1//55fcowPnaiJXXTXL8h+kJvrTW78xoE1juXus+e5jPhRY
	of+83suxISfdHPIeBIMLfbObTk1qaO0KYQNtzRlEn1KcM9vuUJYRfGVPRFnLagNxJx1lgszBi4Z
	JX5A4FOPL6dhFYI1USF5m4UeC6qyMK8s9IzRISF8ZgMoo+fYORNqkM91H88prrQXr2x+nkmFvF6
	ncQdDjaIRJmA+tJI2opA/6Srz54loQBSz1Fh778C8iiHX3S10=
X-Received: by 2002:a05:620a:17a3:b0:8ee:e011:a77a with SMTP id af79cd13be357-8eee011add0mr229077285a.13.1776781814650;
        Tue, 21 Apr 2026 07:30:14 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F ([2607:fb90:a81f:533:271b:a845:9f29:eff0])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8eb19632130sm612607285a.41.2026.04.21.07.30.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 07:30:14 -0700 (PDT)
Date: Tue, 21 Apr 2026 10:30:08 -0400
From: Gregory Price <gourry@gourry.net>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: John Groves <John@groves.net>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Bernd Schubert <bernd@bsbernd.com>,
	John Groves <john@jagalactic.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Bernd Schubert <bschubert@ddn.com>,
	Alison Schofield <alison.schofield@intel.com>,
	John Groves <jgroves@micron.com>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Stefan Hajnoczi <shajnocz@redhat.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Chen Linxuan <chenlinxuan@uniontech.com>,
	James Morse <james.morse@arm.com>, Fuad Tabba <tabba@google.com>,
	Sean Christopherson <seanjc@google.com>,
	Shivank Garg <shivankg@amd.com>,
	Ackerley Tng <ackerleytng@google.com>,
	Aravind Ramesh <arramesh@micron.com>,
	Ajay Joshi <ajayjoshi@micron.com>,
	"venkataravis@micron.com" <venkataravis@micron.com>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	djbw@kernel.org
Subject: Re: [PATCH V10 00/10] famfs: port into fuse
Message-ID: <aeeJ8Lgg2z0X-NC_@gourry-fedora-PF4VCD3F>
References: <adlBcwJjLOQDAR65@groves.net>
 <CAJnrk1a06zkUmXW5EFiUmgAoFauwtzsYvnotaPH0ifVtyh7iDQ@mail.gmail.com>
 <CAJfpegvVTcV89=q3L326aGQjhduBcv7PVg5QKftGLjNZmCLmaw@mail.gmail.com>
 <ad4_jFsR951c2Mtn@groves.net>
 <20260414185740.GA604658@frogsfrogsfrogs>
 <ad69tTnx5YkD4Y9K@gourry-fedora-PF4VCD3F>
 <f254f6fc-dc06-4612-82d7-35bb10dbd32e@kernel.org>
 <aeUU8hMwPij2WvfF@groves.net>
 <aeVy2MzucnrLlOQx@gourry-fedora-PF4VCD3F>
 <CAJnrk1ZpPS9rOoBqOBRsqTu0Zgk=aoYzpYZ0mAVDCoeewtLhcg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1ZpPS9rOoBqOBRsqTu0Zgk=aoYzpYZ0mAVDCoeewtLhcg@mail.gmail.com>

On Mon, Apr 20, 2026 at 08:12:17PM -0700, Joanne Koong wrote:
> On Sun, Apr 19, 2026 at 5:27 PM Gregory Price <gourry@gourry.net> wrote:
> >
> >   struct fuse_dax_fmap_ops {
> >       char name[FUSE_DAX_FMAP_OPS_NAME_LEN];   // 16 bytes
> >       int (*dax_fmap_parse)(struct fuse_dax_fmap_parse_ctx *ctx);
> 
> Just a note for later, if the bpf approach gets pursued further:
> instead of making this a dax specific ops, I think this needs to be
> integrated interface-wise with Darrick's fuse-iomap work since he does
> the same thing. I think dax_fmap_parse() could be renamed to something
> like iomap_setup(), where userspace can use this to do any sort of
> generic setup, whether that's mapping related or dax related or not.
> In my mind, the dax vs non dax distinction is handled by the fuse
> iomap plumbing that chooses which iomap entry points to call,  but
> beyond that,  the callbacks and struct ops themselves should be
> generic enough to be shared between the two.
> 

I think this is reasonable.  I'm not a FUSE wizard either, but I would
presume the iomap_setup() process would just essentially be John's
existing GET_FMAP / GET_DAXDEV code bundled.

GET_DAXDEV happens lazily to save him the round-trips to userland if the
DAXDEVs have already been seen previously.  I think your proposal does
in fact save him further round trips, and it would probably solve the
performance impact he saw from porting to FUSE.

> > And otherwise, imap_begin() works exactly as Joanne proposed, but with
> > in-kernel cached data instead of the bpfmap.
> >
> >   const struct dax_simple_meta *meta = (const struct dax_simple_meta *)
> >                    bpf_fuse_dax_resolve_get_meta(ctx, 0, sizeof(*meta));
> 
> another note for later, if the benchmarks prove promising and after
> the LSF discussions we decide to go with this approach: imo we
> could/should repurpose this into a generic
> bpf_fuse_iomap_get_inode_meta() that returns a bounded pointer into
> whatever opaque blob was cached on the inode during iomap_setup(),
> where it'd be a generic kfunc serving both the dax and non-dax case
> for any kind of mapping layout
> 

Note that Christian Brauner just said he preferred not having dedicated
bpf storage in struct inode [1].

sans BPF, is there value in such a metadata blob existing?

If there was a generic format, then I suppose the blob storage would not
be BPF specific, it would just overload it (simple union).

[1] https://lore.kernel.org/linux-fsdevel/20260421-arsch-gelernt-e0b5bcd8a7ff@brauner/T/#m8fea90f5ed4a1b23bdc2563d978948b263b2030b

~Gregory
