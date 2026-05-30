Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFBD12F7F0C;
	Sat, 30 May 2026 14:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780150794; cv=none; b=FzmKBE5NhWaSjzUbyXBINnLvlGmp77C9pkJm7eVtUUT5wJ1gKJ+KPyMDtd5LoCdMAMKjMBjdLMq7FQcrx5cKMH3kDb0EJ/rX4myDfn42ss+VF56PWJV9W3kk+ME3D2q4N6TWo4CoHcvOpjitjfss/TSvY1otW7vSYX8ANbgJVlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780150794; c=relaxed/simple;
	bh=ovJ+u6fwSOe1GDsoFp38Au5AsVn8LYK7/27gIrphViI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ARm7srZlbczaTggGYjZz7eXtZHI4QblhY6OZHUhUPxS+P5x3mCaveLvFiwiRU0gUJZlKnDAXvmvYCG6OhEjjb6RVo3n9nbJE3gfau94SDGFQsqq9A3eVKNR4U1y9mX00XBXt4wKmZ6KNQTDAhzBCu0InI5VZegSWKDwF4/5eqqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net; spf=pass smtp.mailfrom=groves.net; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=groves.net
Received: from omf09.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 15D968D4D4;
	Sat, 30 May 2026 14:19:44 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: john@groves.net) by omf09.hostedemail.com (Postfix) with ESMTPA id 333BA2002B;
	Sat, 30 May 2026 14:19:40 +0000 (UTC)
Date: Sat, 30 May 2026 09:19:39 -0500
From: John Groves <John@groves.net>
To: Dave Jiang <dave.jiang@intel.com>
Cc: John Groves <john@jagalactic.com>, Dan Williams <djbw@kernel.org>, 
	John Groves <jgroves@micron.com>, Vishal Verma <vishal.l.verma@intel.com>, 
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Miklos Szeredi <miklos@szeredi.hu>, Alison Schofield <alison.schofield@intel.com>, 
	Ira Weiny <iweiny@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
	"nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>, "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH V2 6/7] dax: replace exported dax_dev_get() with
 non-allocating dax_dev_find()
Message-ID: <ahrwrBuEzQaFQ66i@groves.net>
References: <0100019e511fb82e-1a444df3-8310-40ed-8380-72e1373d5da9-000000@email.amazonses.com>
 <20260522191925.79227-1-john@jagalactic.com>
 <0100019e5120f45c-f2183035-0304-4601-87bc-85d933ce51e7-000000@email.amazonses.com>
 <a7ea31ac-8aca-4ff5-adf1-7b3941eba5b4@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a7ea31ac-8aca-4ff5-adf1-7b3941eba5b4@intel.com>
X-Rspamd-Queue-Id: 333BA2002B
X-Rspamd-Server: rspamout06
X-Stat-Signature: tnf5hpk1twpbisuwnz74jkzqokem8nkz
X-Session-Marker: 6A6F686E4067726F7665732E6E6574
X-Session-ID: U2FsdGVkX1/cbclOGp/4YCBOkL/U8GN6Af8YJI6gzTE=
X-HE-Tag: 1780150780-204390
X-HE-Meta: U2FsdGVkX18CfHLcNUievtWWWy3GXluH3CBgrVyAoI6c1IGNkS4sNjdsvho4B8YTGhF9F+OMnFY9uminw5vILU5fH10EY0TcZr524ywxYZHD4KBt+KvOvdwRzmO02Ag5oJHO7uhVAlXJDkrOlDRsh9pfSjfjMi+CfR4+qOWbJdfYN3EOHGvOwtgosb+2dd1aEhgdM9HnLmfRUacOE5DKBMhyWUX7OwwwcPzs9GCHGeXfwFtRP4nMCYHO9HcXBxPHcW5QZh3eW9sQKirLABXPbVRMhVWvEkHAnbuA8HVL5EcdxpO0ZX+I7M37FTwgx/V9AXZ9teLiyP+YqKfu/Eyr40lqA/buwnkc3IEXNQI6zD0+lVhxMg5EQZ5B/+e8cngHAntPXEp86hXxvmcr03fdIg==

On 26/05/26 05:28PM, Dave Jiang wrote:
> 
> 
> On 5/22/26 12:19 PM, John Groves wrote:
> > From: John Groves <John@Groves.net>
> > 
> > This fix is in response to a Sashiko review, and some subsequent
> > analysis.
> > 
> > dax_dev_get() uses iget5_locked() which creates a new inode if no
> > matching one exists. This is correct for the internal caller
> > (alloc_dax), but dangerous for external callers that look up devices
> > from user-supplied or metadata-supplied dev_t values:
> > 
> > 1. A new inode is created with DAXDEV_ALIVE set but no backing driver,
> >    no ops, and no IDA-allocated minor number.
> > 
> > 2. On teardown, dax_destroy_inode() warns because kill_dax() was never
> >    called, and dax_free_inode() calls ida_free() for a minor that was
> >    never ida_alloc'd — potentially freeing the minor of a real device.
> > 
> > Add dax_dev_find() which uses ilookup5() for lookup-only semantics:
> > it returns an existing dax_device with an elevated inode reference, or
> > NULL if no device with the given dev_t exists. It never creates inodes.
> > 
> > Make dax_dev_get() static again (internal to super.c for alloc_dax),
> > export dax_dev_find() instead, and update the two external callers
> > (famfs_inode.c, famfs.c). Also add the missing CONFIG_DAX=n stub.
> > 
> > Fixes: 2ae624d5a555d ("dax: export dax_dev_get()")
> > Signed-off-by: John Groves <john@groves.net>
> > ---
> >  drivers/dax/super.c | 27 +++++++++++++++++++++++++--
> >  include/linux/dax.h |  6 +++++-
> >  2 files changed, 30 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/dax/super.c b/drivers/dax/super.c
> > index fa1d2a6eb2408..79e5823d1010d 100644
> > --- a/drivers/dax/super.c
> > +++ b/drivers/dax/super.c
> > @@ -541,7 +541,7 @@ static int dax_set(struct inode *inode, void *data)
> >  	return 0;
> >  }
> >  
> > -struct dax_device *dax_dev_get(dev_t devt)
> > +static struct dax_device *dax_dev_get(dev_t devt)
> >  {
> >  	struct dax_device *dax_dev;
> >  	struct inode *inode;
> > @@ -564,7 +564,30 @@ struct dax_device *dax_dev_get(dev_t devt)
> >  
> >  	return dax_dev;
> >  }
> > -EXPORT_SYMBOL_GPL(dax_dev_get);
> > +
> > +/**
> > + * dax_dev_find - look up an existing dax_device by dev_t
> > + * @devt: the device number to find
> > + *
> > + * Returns a dax_device with an elevated inode reference, or NULL if no
> > + * device with the given dev_t exists. Unlike dax_dev_get(), this never
> > + * allocates a new inode — it is safe for external callers that are looking
> > + * up devices from user-supplied or metadata-supplied dev_t values.
> > + *
> > + * Caller must put_dax() the returned device when done.
> > + */
> > +struct dax_device *dax_dev_find(dev_t devt)
> > +{
> > +	struct inode *inode;
> > +
> > +	inode = ilookup5(dax_superblock, hash_32(devt + DAXFS_MAGIC, 31),
> > +			 dax_test, &devt);
> > +	if (!inode)
> > +		return NULL;
> > +
> 
> Claude mentions that dax_alive() check may be a good idea after grabbing the inode ref. Otherwise famfs may get a dax_dev that may be racing with a teardown. Do something similar that fs_dax_get_by_dev() or fs_dax_get() do WRT dax_alive() check perhaps.
> 
> DJ

I think that's right. Calling dax_alive() requires a dax_read_lock();
Adding that too.

Thanks!
John

<snip>

