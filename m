Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A267235B657;
	Mon, 15 Jun 2026 13:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781529409; cv=none; b=CM3U9G6OUdElFMrjPYowcndrqNIqbIAOawXTxrNGQyc0NXo4Wr/0RHucFbRv73OQUdtH1fBtuFb+s2P/hNYaIfx5mwH2uoKxHvVid2wl506aGseM4roXXjs6l8oWc4byFJP6E/xLC/KCJodHyAjcwogsxWs0xQ7DIzbSnnlY/6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781529409; c=relaxed/simple;
	bh=pMREYlYHGc5Tkh4427Y9bIHLMo21yJ3BiQqtR+Ik0DU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TuMICR8LaW8whHQUMDm5lQayUBJhJXTkdcJkqleCTfM4SB0KpVnQaFPwRbGuA0frAjYNfjrMy5SElYKS7SYBy3N7Jucv5f411NJ4Y1f7YaCxX//xw5IfK65ziiG4H9lkeVNW4RwG9F/9JsUhpQHhp35pzQLLNsKzHGHgLG8ONVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net; spf=pass smtp.mailfrom=groves.net; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=groves.net
Received: from omf20.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 7B6301A0A43;
	Mon, 15 Jun 2026 13:16:39 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: john@groves.net) by omf20.hostedemail.com (Postfix) with ESMTPA id 4B67020025;
	Mon, 15 Jun 2026 13:16:35 +0000 (UTC)
Date: Mon, 15 Jun 2026 08:16:34 -0500
From: John Groves <John@groves.net>
To: Richard Cheng <icheng@nvidia.com>
Cc: John Groves <john@jagalactic.com>, Dan Williams <djbw@kernel.org>, 
	John Groves <jgroves@micron.com>, Vishal Verma <vishal.l.verma@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Miklos Szeredi <miklos@szeredi.hu>, Alison Schofield <alison.schofield@intel.com>, 
	Ira Weiny <iweiny@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
	"nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>, "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH V5 3/9] dax/fsdev: clear vmemmap_shift when binding
 static pgmap
Message-ID: <ai_63hJ1pVP15nbc@groves.net>
References: <0100019eb7bcda4b-3f8edae9-d7a4-4bfa-aaea-fcef77fdbbc3-000000@email.amazonses.com>
 <20260611173202.65935-1-john@jagalactic.com>
 <0100019eb7bdc5a7-f15b011c-0aee-411f-8d7c-2996345048e4-000000@email.amazonses.com>
 <ait0jiPmYrpwdEBW@MWDK4CY14F>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ait0jiPmYrpwdEBW@MWDK4CY14F>
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 4B67020025
X-Stat-Signature: bceddahxhdzmsy1ywk9uaa1bs1jhxk8y
X-Session-Marker: 6A6F686E4067726F7665732E6E6574
X-Session-ID: U2FsdGVkX180S01DUCi5FDR/O4kT1psh/9MvNKg99Gw=
X-HE-Tag: 1781529395-294135
X-HE-Meta: U2FsdGVkX1/yRQ3MVlQ8eTLP5Ts9BmNqPWWY2fNZ+FUtpXs1kVZ6A6CfA1mpsWl53a4KdsjiWoICOlSM6DVZ3IlMvcf5mhBIHVZykPnx/IjqIkM1QLn+iPXwX3NWjU/fmUl7n77sqW23ZS7ig/h+hKcM4uJo9vU1SpmVAhFcNTFch+2MnkwfzhypiMrPcnNAAw/najyhBXV6B6AwwnPSAKLfnqME/E+Y632/KTC9BOVGjH/8IEtXOu2a2IOJWYsaDlTWzMd2c8Q9ba/Q7qI+OVTTpYnhSsNLiw1++6+zFS2XpoGdTBDNZWzXtGNag2gxz5+JLzEGSBuLBPBAcx6przZ4NZIL/bhtIRuvVTivSFHn+zJxr6JNmpuYfj6jpFlP4bxk/2Wbr9zBuMS4X04Onw==

On 26/06/12 10:56AM, Richard Cheng wrote:
> On Thu, Jun 11, 2026 at 05:32:07PM +0800, John Groves wrote:
> > From: John Groves <John@Groves.net>
> > 
> > Clear pgmap->vmemmap_shift for static DAX devices. When rebinding a static
> > device from device_dax (which may set vmemmap_shift based on alignment) to
> > fsdev_dax, the stale vmemmap_shift persists on the shared pgmap. Explicitly
> > zero it before devm_memremap_pages() so the vmemmap is built for order-0
> > folios as fsdev requires.
> > 
> > Fixes: d5406bd458b0a ("dax: add fsdev.c driver for fs-dax on character dax")
> > 
> > Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> > Reviewed-by: Alison Schofield <alison.schofield@intel.com>
> > Signed-off-by: John Groves <john@groves.net>
> > ---
> >  drivers/dax/fsdev.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/dax/fsdev.c b/drivers/dax/fsdev.c
> > index 2c5de3d80a618..52f46b3e245ea 100644
> > --- a/drivers/dax/fsdev.c
> > +++ b/drivers/dax/fsdev.c
> > @@ -237,6 +237,7 @@ static int fsdev_dax_probe(struct dev_dax *dev_dax)
> >  		}
> >  
> >  		pgmap = dev_dax->pgmap;
> > +		pgmap->vmemmap_shift = 0;
> 
> 
> Hello John,
> 
> I would suggest also clearing pgmap->ops and pgmap->owner on teardown.
> fsdev also writes them but never clears them. memuunmap_pages() leaves the
> descriptor intact and kill_dev_dax() only NULLs dev_dax->pgmap for !static case.
> After fsdev unbind the stale ops survive.
> If we do rmmod later a HW failure dispatch pgmap->ops->memory_failure.
> 
> --Richard

Good catch, thanks.

Adding a patch for V6 ("dax/fsdev: clear pgmap ops and owner on unbind")
-- a devm action that NULLs both on unbind, symmetric with setting them
at probe. It matters for the static case where the pgmap is shared and
long-lived; otherwise a later rebind or rmmod could dispatch
memory_failure through the stale handler.

John

