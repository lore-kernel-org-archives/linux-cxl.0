Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B44500950
	for <linux-cxl@vger.kernel.org>; Fri,  9 Jan 2026 21:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767992425; cv=none; b=KX4yT0gUr6eN2TYUeHI7ct7lnwWM4sNkwX0rOOlqdaJAuxXw0ytrkkGX5oYh/bESCU36iFzTLGc0nUuc5f2apbUwFi5dTx/cWQiRlCvMsEHptv2NOsE0h6mOtmAtifTZ4L91wvltCm/u8KHeTmPWJfNo51S9ZaGkDe+FuPxjP4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767992425; c=relaxed/simple;
	bh=Lnqx2IsjK6GGMeXoPLfF8Q/0waslPMIHDLq8xmDBOWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vERo6WEfHPO83w8pGn5VZEdbDPqptbT38KK1URxPJsiFLsAzUurAzLEJakz+8a/dbTtfNaZKmn2qRwSvIvMTobvbbwgN8NhbpIQtPjL+gHKN05SVzEyGZe8qDQvHB7jWjyYg6REfCVrcwcgR35AJPyE0lmIpV1/jphYrN35Hlew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OyjCfkll; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OyjCfkll"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-45a3145faddso1556868b6e.2
        for <linux-cxl@vger.kernel.org>; Fri, 09 Jan 2026 13:00:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767992422; x=1768597222; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v4M8PfdySXBuLCXo+RLzMIyIY7QrHbUdCMkagyIMvnE=;
        b=OyjCfkllnk+dEHpzz5FgtnAg7Rkugxv9vFlk9Td+hwLC/lC9XD81dUV8Ck/s44Q+F5
         O67jGoBUxpwFFf1aA1UM6vRAbXBlsFY6upEMpt+oUAM6ydKFLgeBwpbqZaA1Ozk9UGqe
         ehhsz9V0MqF9pMp68ica4oBkLLp2W3kugI5lxD5dqKX1jxNszCVYiBNET51866YKKbuc
         mnxUIJq+NAB6J+cFgQenzIOb0U+vt+1FkCgFYaidGJTOUUMKACxjpQh19liPw5wZkJxp
         OfrEnlrJoyCVLAL0Uvz50jfPZwRR5QlzRQ+CwaEKAKlWy2kbTgc5KBagYVP/MJ88x9+l
         fqTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767992422; x=1768597222;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=v4M8PfdySXBuLCXo+RLzMIyIY7QrHbUdCMkagyIMvnE=;
        b=Wd4WrbYVtaHPDNkFL1MxCNHuTT+NsA1XavB8xBrD/3WG/G+eiUxQSZ1TEYuu9LT4rp
         C90bylUgFoEfD/lCLwnuea0ezPnMhiF7oRKLh8ZlSvPZhYFVZrmyEwjeVyRfwJYvUTg/
         x3k2eyi7qNksOUtLCVXWENfaKclns9AuLekY5szX6+PBiH+Zv5PjoxjAcTVTUC5tDCan
         lu5/mRnBtnN5gcWdTJCXxjAA2YyB8epccWzKerE5nmOhPvNbBZ83dxesIKTjUJF7Cc4B
         e7/hTDCw6tyr/cVKJirJNknvLSFEGF0ECPFN82hOfoXaud6oo+LwONqerTdr9qafIy/u
         XOPw==
X-Forwarded-Encrypted: i=1; AJvYcCXpEF304AN+5q4DvFO4gDhTv/o7A2HOEs5FopnxHMSEBhS0SQOr/d9ireNW3OEATc4FlGxRe1l8HAM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPCq78yFCYYAaiMTRlOzH4YD+rMZ1qQ3z/xdzIfogc8XuF5cNk
	sbrXznbXUyWhjijIZqQLHaBq5A87svT9gVDMAqm8dK1N7G/eJ3x2cXX6
X-Gm-Gg: AY/fxX6VH4gIdfUEpwyIV/9Q/zKXJcSoZ5cCCY/Iu61SgVF0X30oC3EIsZiGCMXwYp2
	NWYFZKNQQUEnnENh4SlmtDrUUVcnRWRJBQ8graEkfe7TE0UJPLYgp+QebrsJmviAI7+2YD2DEK5
	S1VHc0G7nw4VCqxNfKb90vBitLivReVl+Ee6ot54eiWUIUau+nJYfXRbJ4farXLHHi2m0LQ6lWl
	tDDIDtLCzhZsuc1uFf7sskSCWbpHkiNjZfjjW3ZWDSwDm911nzzz5V0i3ZdlAREs8a6zAKfwddn
	8VRTnWoeQQZBSdYEwR2yuTgUDUEhZATIV5bnb4FpQXl50x2OXQ+Ft4jUtEcauQxIqIV1r5FZrCB
	K/CraTpKpCKT9RGLia0Nd/rU6ayM0IaGVGnpfG2Z34XIcedqUunDDSueileMiqeUqIS8uVqBYuz
	Okz/DFyx5xTq7jSUrcNkaakwTvK3b/Cg==
X-Google-Smtp-Source: AGHT+IGxLlZof8Jy1wQwdG6wIDxdZkGz6jddwYKP+0ZxEiU+0KGp2+NJH27YNyDn7lRSc6+JT5iBCA==
X-Received: by 2002:a05:6808:c1a9:b0:442:522:41a3 with SMTP id 5614622812f47-45a6becae03mr5521861b6e.60.1767992422011;
        Fri, 09 Jan 2026 13:00:22 -0800 (PST)
Received: from groves.net ([2603:8080:1500:3d89:184d:823f:1f40:e229])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-45a5e288bc7sm5503964b6e.12.2026.01.09.13.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 13:00:21 -0800 (PST)
Sender: John Groves <grovesaustin@gmail.com>
Date: Fri, 9 Jan 2026 15:00:19 -0600
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
Subject: Re: [PATCH V3 18/21] famfs_fuse: Add holder_operations for dax
 notify_failure()
Message-ID: <bonriy66ocy6plo66nryagupftobhlnzjr235fukdx7d6vdyku@gzmq25kktdrb>
References: <20260107153244.64703-1-john@groves.net>
 <20260107153332.64727-1-john@groves.net>
 <20260107153332.64727-19-john@groves.net>
 <20260108151733.00005f6e@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260108151733.00005f6e@huawei.com>

On 26/01/08 03:17PM, Jonathan Cameron wrote:
> On Wed,  7 Jan 2026 09:33:27 -0600
> John Groves <John@Groves.net> wrote:
> 
> > Memory errors are at least somewhat more likely on disaggregated memory
> > than on-board memory. This commit registers to be notified by fsdev_dax
> > in the event that a memory failure is detected.
> > 
> > When a file access resolves to a daxdev with memory errors, it will fail
> > with an appropriate error.
> > 
> > If a daxdev failed fs_dax_get(), we set dd->dax_err. If a daxdev called
> > our notify_failure(), set dd->error. When any of the above happens, set
> > (file)->error and stop allowing access.
> > 
> > In general, the recovery from memory errors is to unmount the file
> > system and re-initialize the memory, but there may be usable degraded
> > modes of operation - particularly in the future when famfs supports
> > file systems backed by more than one daxdev. In those cases,
> > accessing data that is on a working daxdev can still work.
> > 
> > For now, return errors for any file that has encountered a memory or dax
> > error.
> > 
> > Signed-off-by: John Groves <john@groves.net>
> > ---
> >  fs/fuse/famfs.c       | 115 +++++++++++++++++++++++++++++++++++++++---
> >  fs/fuse/famfs_kfmap.h |   3 +-
> >  2 files changed, 109 insertions(+), 9 deletions(-)
> > 
> > diff --git a/fs/fuse/famfs.c b/fs/fuse/famfs.c
> > index c02b14789c6e..4eb87c5c628e 100644
> > --- a/fs/fuse/famfs.c
> > +++ b/fs/fuse/famfs.c
> 
> > @@ -254,6 +288,38 @@ famfs_update_daxdev_table(
> >  	return 0;
> >  }
> >  
> > +static void
> > +famfs_set_daxdev_err(
> > +	struct fuse_conn *fc,
> > +	struct dax_device *dax_devp)
> > +{
> > +	int i;
> > +
> > +	/* Gotta search the list by dax_devp;
> > +	 * read lock because we're not adding or removing daxdev entries
> > +	 */
> > +	down_read(&fc->famfs_devlist_sem);
> 
> Use a guard()

Done

> 
> > +	for (i = 0; i < fc->dax_devlist->nslots; i++) {
> > +		if (fc->dax_devlist->devlist[i].valid) {
> > +			struct famfs_daxdev *dd = &fc->dax_devlist->devlist[i];
> > +
> > +			if (dd->devp != dax_devp)
> > +				continue;
> > +
> > +			dd->error = true;
> > +			up_read(&fc->famfs_devlist_sem);
> > +
> > +			pr_err("%s: memory error on daxdev %s (%d)\n",
> > +			       __func__, dd->name, i);
> > +			goto done;
> > +		}
> > +	}
> > +	up_read(&fc->famfs_devlist_sem);
> > +	pr_err("%s: memory err on unrecognized daxdev\n", __func__);
> > +
> > +done:
> 
> If this isn't getting more interesting, just return above.

Right - simplified.

> 
> > +}
> > +
> >  /***************************************************************************/
> >  
> >  void
> > @@ -611,6 +677,26 @@ famfs_file_init_dax(
> >  
> >  static ssize_t famfs_file_bad(struct inode *inode);
> >  
> > +static int famfs_dax_err(struct famfs_daxdev *dd)
> 
> I'd introduce this earlier in the series to reduce need
> to refactor below.

Will mull that over when I further mull the helpers in fuse_i.h that are
hard to rebase...

> 
> > +{
> > +	if (!dd->valid) {
> > +		pr_err("%s: daxdev=%s invalid\n",
> > +		       __func__, dd->name);
> > +		return -EIO;
> > +	}
> > +	if (dd->dax_err) {
> > +		pr_err("%s: daxdev=%s dax_err\n",
> > +		       __func__, dd->name);
> > +		return -EIO;
> > +	}
> > +	if (dd->error) {
> > +		pr_err("%s: daxdev=%s memory error\n",
> > +		       __func__, dd->name);
> > +		return -EHWPOISON;
> > +	}
> > +	return 0;
> > +}
> 
> ...
> 
> > @@ -966,7 +1064,8 @@ famfs_file_bad(struct inode *inode)
> >  		return -EIO;
> >  	}
> >  	if (meta->error) {
> > -		pr_debug("%s: previously detected metadata errors\n", __func__);
> > +		pr_debug("%s: previously detected metadata errors\n",
> > +			 __func__);
> 
> Spurious change.

Derp. Reverted out

Thanks Jonathan

