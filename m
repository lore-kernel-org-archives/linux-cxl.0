Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1233A5E87;
	Fri, 27 Mar 2026 14:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774620440; cv=none; b=YpFSvT2OIWg3zntm+de3/XBcaZOdrznYho6TUtT1XD8uwunDYfBI5HqMeS7WotdsHRs/YLFsGHACIM57gBMvMrExJ5pX2c950l8FFfx11pSWtwWokLoB66kXGVrxwyEYYVIVmbEBUcbRH+DvJvSKbkEoXFSlkAqhrVZfa3a/ThU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774620440; c=relaxed/simple;
	bh=AggJWbzXgAJW8nJRhQGxWDobjA7ATMqWYFMZpxSl+TA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EeOLm3ztkI/xhaP/T4Cfe5txkqUICeO7v2MKXD69tVdjuxA+22RD/tD+5rZjuNt+LXW77uw7eXTPnB5V02Lg/Q/Voh/lT42Mxq1qIXR3cHXd/M7hhqAYouY0rbOHx+UNwH8QZCBHuBuVkk9E0ZqZeudbce5Vb7J18/cU7OvqVHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net; spf=pass smtp.mailfrom=groves.net; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=groves.net
Received: from omf06.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 1FF49E0F30;
	Fri, 27 Mar 2026 14:07:08 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: john@groves.net) by omf06.hostedemail.com (Postfix) with ESMTPA id D41B82000F;
	Fri, 27 Mar 2026 14:06:55 +0000 (UTC)
Date: Fri, 27 Mar 2026 09:06:53 -0500
From: John Groves <John@groves.net>
To: Dave Jiang <dave.jiang@intel.com>
Cc: John Groves <john@jagalactic.com>, Miklos Szeredi <miklos@szeredi.hu>, 
	Dan Williams <dan.j.williams@intel.com>, Bernd Schubert <bschubert@ddn.com>, 
	Alison Schofield <alison.schofield@intel.com>, John Groves <jgroves@micron.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Vishal Verma <vishal.l.verma@intel.com>, Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, David Hildenbrand <david@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, "Darrick J . Wong" <djwong@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Jeff Layton <jlayton@kernel.org>, 
	Amir Goldstein <amir73il@gmail.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Stefan Hajnoczi <shajnocz@redhat.com>, Joanne Koong <joannelkoong@gmail.com>, 
	Josef Bacik <josef@toxicpanda.com>, Bagas Sanjaya <bagasdotme@gmail.com>, 
	Chen Linxuan <chenlinxuan@uniontech.com>, James Morse <james.morse@arm.com>, Fuad Tabba <tabba@google.com>, 
	Sean Christopherson <seanjc@google.com>, Shivank Garg <shivankg@amd.com>, 
	Ackerley Tng <ackerleytng@google.com>, Gregory Price <gourry@gourry.net>, 
	Aravind Ramesh <arramesh@micron.com>, Ajay Joshi <ajayjoshi@micron.com>, 
	"venkataravis@micron.com" <venkataravis@micron.com>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>, 
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH V9 5/8] dax: Add dax_operations for use by fs-dax on
 fsdev dax
Message-ID: <acaOzmCYOZHr_Ia1@groves.net>
References: <0100019d1d463523-617e8165-a084-4d91-aa5e-13778264d5d4-000000@email.amazonses.com>
 <20260324003851.5045-1-john@jagalactic.com>
 <0100019d1d47e459-48f2a4e6-edab-4002-bde3-2ba642deccaf-000000@email.amazonses.com>
 <593b2b5c-779b-4e29-8b03-12ce743b10b4@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <593b2b5c-779b-4e29-8b03-12ce743b10b4@intel.com>
X-Stat-Signature: 7dqy4jynbesstz9697ot4cz4cexh86pu
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: D41B82000F
X-Session-Marker: 6A6F686E4067726F7665732E6E6574
X-Session-ID: U2FsdGVkX19u88rI/RZbOnBIHfsRi86A2mDPG8VKxsA=
X-HE-Tag: 1774620415-652695
X-HE-Meta: U2FsdGVkX1+FrBjZnrpIbH0kvez85SGTcc2xxECCcDS+nAaDETophnfrphfd5mO9QQhYEdXOx92QLbEWRoJ9nDerbKGHUDtoN6YOsp7jWLzV7JSuDVRjE9A0MCbpn2Khfo5hWKqQiiTbEVX6AdSqGR2bRTk7OUuaByYUZz87MIOrwNJOhx0cn4b79EikkIiwmb+rJrYWJzPe5qRFV23oiY2dfKw1Anv3CmCHgBuMsQ/u4t5n5dwjt5d6SGNbPQTtnGHdoaSqLW6mO4xqMEAMhO3CFDaqGw3eQWKEQUX4xUcyefn0zqY+lXxLNiuUeL1+MpKiV07znBajEkTfCZ37KHMxl5M/SKjM4wW8yo1/nxVslThUrFIeDiyokY3c/6GG

On 26/03/25 02:28PM, Dave Jiang wrote:
> 
> 
> On 3/23/26 5:39 PM, John Groves wrote:
> > From: John Groves <John@Groves.net>
> > 
> > fsdev: Add dax_operations for use by famfs.
> > 
> > This replicates the functionality from drivers/nvdimm/pmem.c that
> > conventional fs-dax file systems (e.g. xfs) use to support dax
> > read/write/mmap to a daxdev - without which famfs can't sit atop a
> > daxdev.
> > 
> > - These methods are based on pmem_dax_ops from drivers/nvdimm/pmem.c
> > - fsdev_dax_direct_access() returns the hpa, pfn and kva. The kva was
> >   newly stored as dev_dax->virt_addr by dev_dax_probe().
> > - The hpa/pfn are used for mmap (dax_iomap_fault()), and the kva is used
> >   for read/write (dax_iomap_rw())
> > - fsdev_dax_recovery_write() and dev_dax_zero_page_range() have not been
> >   tested yet. I'm looking for suggestions as to how to test those.
> > - dax-private.h: add dev_dax->cached_size, which fsdev needs to
> >   remember. The dev_dax size cannot change while a driver is bound
> >   (dev_dax_resize returns -EBUSY if dev->driver is set). Caching the size
> >   at probe time allows fsdev's direct_access path can use it without
> >   acquiring dax_dev_rwsem (which isn't exported anyway).
> > 
> > Signed-off-by: John Groves <john@groves.net>
> > ---
> >  drivers/dax/dax-private.h |  1 +
> >  drivers/dax/fsdev.c       | 84 +++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 85 insertions(+)
> > 
> > diff --git a/drivers/dax/dax-private.h b/drivers/dax/dax-private.h
> > index 7a3727d76a68..ee8f3af8387f 100644
> > --- a/drivers/dax/dax-private.h
> > +++ b/drivers/dax/dax-private.h
> > @@ -85,6 +85,7 @@ struct dev_dax {
> >  	struct dax_region *region;
> >  	struct dax_device *dax_dev;
> >  	void *virt_addr;
> > +	u64 cached_size;
> 
> Just caught this. Need a kdoc entry.
> 
> DJ

Thank you! Added for v10

John

