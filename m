Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145DC1C57BF
	for <linux-cxl@vger.kernel.org>; Tue, 27 Aug 2024 15:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724772442; cv=none; b=YJ9uzn+p+DcQtrGBJxHTf0/tgZdyBXE9hsKQSFWKflY2Omp1bKJmKNuiIUJZSadgtLskIUSSn/UnJuQenTId+epdAodZpyzKUzh1TfV/aTzseKkxK0oj7NoFovj4BFVSwcbf01z0tAY3T0Bs1CtU7Pq68PdrmeijAv8pjhnY1+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724772442; c=relaxed/simple;
	bh=nahhFxi1B23LnusRspuh+hcyWmI0Un3Hb+rnjOT1K7o=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h30QfiOI//hCCJdlHDXYBOgDz6P4pMqaN/nfOFRPZVDjoKnam3xYsxBJ+JU6HUyeybP3PeSJ1S1zx2vnYcx0+urM13cP3giXeiUYNwa7eININEsvenNR8LUY0Qi8ht58pB9l6X86VaJXfzcYhF9H20Vk227PVrL2eZt5AefhJ5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WtWX724YVz6J6gV;
	Tue, 27 Aug 2024 23:23:19 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id C3505140D26;
	Tue, 27 Aug 2024 23:27:17 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 27 Aug
 2024 16:27:17 +0100
Date: Tue, 27 Aug 2024 16:27:16 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <alejandro.lucero-palau@amd.com>,
	<dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>, <dave@stgolabs.net>
Subject: Re: [PATCH 1/2] cxl: Move mailbox related bits to the same context
Message-ID: <20240827162716.00001c2a@Huawei.com>
In-Reply-To: <01c6f57b-a969-444f-b409-e46e68d4850f@intel.com>
References: <20240724185649.2574627-1-dave.jiang@intel.com>
	<20240724185649.2574627-2-dave.jiang@intel.com>
	<20240815175745.000041cc@Huawei.com>
	<01c6f57b-a969-444f-b409-e46e68d4850f@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Thu, 15 Aug 2024 10:10:23 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> On 8/15/24 9:57 AM, Jonathan Cameron wrote:
> > On Wed, 24 Jul 2024 11:55:16 -0700
> > Dave Jiang <dave.jiang@intel.com> wrote:
> >   
> >> Create a new 'struct cxl_mailbox' and move all mailbox related bits to
> >> it. This allows isolation of all CXL mailbox data in order to export
> >> some of the calls to external callers and avoid exporting of CXL driver
> >> specific bits such has device states. The allocation of
> >> 'struct cxl_mailbox' is also split out with cxl_mailbox_create() so the
> >> mailbox can be created independently.
> >>
> >> Signed-off-by: Dave Jiang <dave.jiang@intel.com>  
> > Hi Dave,
> > 
> > Mostly good, but cxl_mailbox_create() needs another look.
> > Feels like a bit of cut and paste gone too far ;)
> > 
> > I'm not entirely convinced it shouldn't just remain embedded in
> > the parent structure with create replace with just an init()
> > function.  I don't mind that much though.  
> 
> I made it a pointer to deal with something like a type2 device without mailbox at all. So I feel like it needs to stand on its own.... but are you saying we should just keep it as an embedded struct in the device context whether a mailbox exists or not?

It can be optional for a given driver, so type 3 just embeds
it, a type 2 with the support also embeds and init() the mailbox.
A type 2 without doesn't embed it in the driver specific structures
and obviously doesn't init what it doesn't have.

So just like a mutex inside a driver specific struct
and similar things.
> 
> Also, probably need to start thinking about this. Once PCIe MMIO mailbox shows up, we will want to move the register pointer into the mailbox as well to make it independent and having a shared struct between CXL and PCIe. It'll probably end up looking like:
> 
> struct cxl_mailbox {
> 	struct mmio_mailbox mbox;
> }; 
Yeah. I'd expect a nest like this with container_of() magic used where
appropriate to get to the parents and probably a few callbacks
set in the mbox to tie everything together.

Jonathan

> 
> > 
> > Jonathan
> > 
> >   
> >> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> >> index 2626f3fff201..9501d2576ccd 100644  
> > 
> >   
> >> @@ -1408,6 +1454,34 @@ int cxl_poison_state_init(struct cxl_memdev_state *mds)
> >>  }
> >>  EXPORT_SYMBOL_NS_GPL(cxl_poison_state_init, CXL);
> >>  
> >> +static void free_cxl_mailbox(void *cxl_mbox)
> >> +{
> >> +	kfree(cxl_mbox);
> >> +}
> >> +
> >> +struct cxl_mailbox *cxl_mailbox_create(struct device *dev)
> >> +{
> >> +	struct cxl_mailbox *cxl_mbox __free(kfree) =
> >> +		kzalloc(sizeof(*cxl_mbox), GFP_KERNEL);  
> > This is not somewhere I'd use the __free magic, because
> > failure to create a mailbox is very likely fatal and doing
> > so requires the dance with devm_add_action_or_reset() to
> > just free a structure.
> > 
> > So I'd just use devm_kzalloc()
> > and rely on caller to fail probe() or if not to do manual
> > cleanup of the structure.
> > 
> > There aren't any failure paths currently where the auto cleanup
> > gets used anyway other than the devm_add_action_or_reset()
> > which is not using auto cleanup anyway.
> >   
> >> +	int rc;
> >> +
> >> +	if (!cxl_mbox)
> >> +		return ERR_PTR(-ENOMEM);
> >> +
> >> +	cxl_mbox->host = dev;
> >> +	mutex_init(&cxl_mbox->mbox_mutex);
> >> +	rcuwait_init(&cxl_mbox->mbox_wait);
> >> +
> >> +	rc = devm_add_action_or_reset(dev, free_cxl_mailbox, cxl_mbox);
> >> +	if (rc) {
> >> +		cxl_mbox = NULL;  
> > Non obvious as that's a suppression of what would otherwise
> > be a double free.  Having to do this rather defeats the point
> > of the simplification __free normally brings.
> >   
> >> +		return ERR_PTR(rc);
> >> +	}
> >> +
> >> +	return no_free_ptr(cxl_mbox);
> >> +}
> >> +EXPORT_SYMBOL_NS_GPL(cxl_mailbox_create, CXL);  
> 

