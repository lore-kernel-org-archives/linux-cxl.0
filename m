Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118A32FE048
	for <linux-cxl@vger.kernel.org>; Fri, 23 Jan 2026 12:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769171092; cv=none; b=YW1L4RrQNReUH2IpJ8lk9CeSP58/91PaMDohjsku5RQV3JNI7Bcknd3G2p1VyGmgEYptPN0RDYewHLzu4dTkb9vCBuEgZUzLiSZ05bwCBtEqxZO42utBq9/NT8h3jkA2hrvHM+fvqKpQKwojZPNAqIbXlZo3UloWDoVzgLyF5jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769171092; c=relaxed/simple;
	bh=xmbwYnbHsz0Z1riddrWMWsExVmgYL2ONBKTfHDX9GI8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YFbH148Ply4HUXzN847fp3Uye7pm9qISnCpHlD/PWyloibpvhPrYG1Cg5QGGBJoHSBBJjyi5Cabm3g26gzYzkd6eo20VzLNk0eYdK3pHw3EFNs25kxT6f000LxhQRxp4D0NU3bjsGOcEdxbvxWfD+PunqregTW13BScx7DtcuDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dyHD87466zHnH69;
	Fri, 23 Jan 2026 20:24:08 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 9CD2540086;
	Fri, 23 Jan 2026 20:24:46 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 23 Jan
 2026 12:24:46 +0000
Date: Fri, 23 Jan 2026 12:24:44 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <ira.weiny@intel.com>, <terry.bowman@amd.com>
Subject: Re: [PATCH 3/9] cxl/port: Cleanup dport removal with a devres group
Message-ID: <20260123122444.00001606@huawei.com>
In-Reply-To: <20260123121441.0000240b@huawei.com>
References: <20260122033330.1622168-1-dan.j.williams@intel.com>
	<20260122033330.1622168-4-dan.j.williams@intel.com>
	<20260122115945.000062e6@huawei.com>
	<69728bf84936_309510070@dwillia2-mobl4.notmuch>
	<20260123121441.0000240b@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500012.china.huawei.com (7.191.174.4) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Fri, 23 Jan 2026 12:14:41 +0000
Jonathan Cameron <jonathan.cameron@huawei.com> wrote:

> On Thu, 22 Jan 2026 12:43:36 -0800
> dan.j.williams@intel.com wrote:
> 
> > Jonathan Cameron wrote:  
> > > On Wed, 21 Jan 2026 19:33:24 -0800
> > > Dan Williams <dan.j.williams@intel.com> wrote:
> > >     
> > > > In preparation for adding more setup actions like RAS register mapping,
> > > > introduce a devres group to collect all the dport creation / registration
> > > > actions. This replaces the maintenance tedium of open coding several
> > > > devm_release_action() calls in del_dport().
> > > > 
> > > > Signed-off-by: Dan Williams <dan.j.williams@intel.com>    
> > > Whilst nice, there is some logic buried deep enough that it might surprise
> > > anyone trying to grasp flow in __devm_cxl_add_dport.
> > > 
> > > I like the cleanup.h stuff but here I'm wondering if it is appropriate.
> > > Maybe just use a goto in __devm_cxl_add_dport()
> > >     
> > 
> > It is several gotos, I have a hard time ever writing goto again.
> > 
> > Maybe if you can clarify your "inappropriate" feeling. To be clear I
> > have heard this from other maintainers that are not ready to let go of
> > goto, but I feel this is rapidly approaching the reverse-xmas-tree level
> > of local maintainer preferences.  
> 
> I'm an enthusiast for the cleanup.h stuff. This was very much specific
> to this case. I thought I wrote more on this in original mail, but seems
> I deleted the comments before sending!  Sorry about that.
> 
> Main thing I was a bit dubious about in this very specific case was about
> overlapping semantic meaning of the group and the the dport (which are
> the same address, but we only pretend that in some paths).
> 
> That is necessary so there is 'one' thing for:
> 
> DEFINE_FREE(cxl_dport_release_group, void *,
> 	    if (_T) devres_release_group(dport_to_host(_T), _T))
> 
> Which is fine but then the meaning is broken out in
> static void cxl_dport_close_group(struct cxl_dport *dport, void *group)
> 
> + I'd have preferred we were explicit in the group being temporary and
> hence passed NULL as ID which we can't do if group and dport need
> to be the same pointer.
> 
> That in combination made me think perhaps it wasn't worth applying here.
Ah. That discussion was in the next patch.  Temporal slip ;)

Anyhow, it was a bit of musing rather than a strong request to not use
cleanup stuff here.

J
> 
> > 
> > [..]  
> > > > + * Upon return either a group is established with one action (free_dport()), or
> > > > + * no group established and @dport is freed.
> > > > + */
> > > > +static void *cxl_dport_open_group_or_free(struct cxl_dport *dport)    
> > > 
> > > Can we put something in the name to hint this is devres stuff?
> > > Group could mean too many things :( Even
> > > cxl_dport_open_dr_group_or_free() avoids sounding too generic.    
> > 
> > I was on the fence with making it more clear it was devres, was just
> > waiting for a tie breaking shove. Shove received, "dr_group" it is.
> >   
> > > > +{
> > > > +	int rc;
> > > > +	struct device *host = dport_to_host(dport);
> > > > +	void *group = devres_open_group(host, dport, GFP_KERNEL);
> > > > +
> > > > +	if (!group) {
> > > > +		kfree(dport);
> > > > +		return NULL;
> > > > +	}
> > > > +
> > > > +	rc = devm_add_action_or_reset(host, free_dport, dport);
> > > > +	if (rc) {
> > > > +		devres_release_group(host, group);
> > > > +		return NULL;
> > > > +	}
> > > > +
> > > > +	return group;
> > > > +}
> > > > +
> > > > +static void cxl_dport_close_group(struct cxl_dport *dport, void *group)
> > > > +{
> > > > +	devres_close_group(dport_to_host(dport), group);
> > > > +}
> > > > +
> > > > +/* The dport group id is the dport */
> > > > +DEFINE_FREE(cxl_dport_release_group, void *,
> > > > +	    if (_T) devres_release_group(dport_to_host(_T), _T))    
> > > 
> > > Reorder so this can use the typed del_dport()?    
> > 
> > Yeah, that is cleaner.
> >   
> 
> 
> 

