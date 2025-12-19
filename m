Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E655833E36F
	for <linux-cxl@vger.kernel.org>; Fri, 19 Dec 2025 17:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766166797; cv=none; b=WJtWpDczSjEet4eFXHPblaPNl2jDWTLibgZOQYW1VXiDpGsC2AkC6+/JTxYLx64fWrLQvaj7sylQNftsHtMHbplsCRuU10ym4s/s98ojoeaxI73y8M2WRpELemNaZq87SfxqUA5t3RuRM2lMKNr/b9f+QBFVi166oTtPh5qc1PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766166797; c=relaxed/simple;
	bh=rbYZ8pVUnhXhAoRGIVc9T9yXvL9D/UFIlfEka33m0Jo=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cCYY+NELpypvHw7TSqFJFPlSjrQAUZVmDPgKH+bEy99TpA2/0PIZx0bFLamo9M33EqwU/y+cYR3iXy9bLzYprhaCZdmY5RrMSf7reJUXJhv3VRT9vwWfFDxKKQoKZaLTyru5hAI0f7PyP29Mh9b1AzWqWHAmP0y/2XakWqqn0GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dXw9Q111dzHnGd2;
	Sat, 20 Dec 2025 01:52:42 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id AB9B440571;
	Sat, 20 Dec 2025 01:53:11 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Fri, 19 Dec
 2025 17:53:11 +0000
Date: Fri, 19 Dec 2025 17:53:09 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Markus Armbruster <armbru@redhat.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, <ira.weiny@intel.com>,
	<alucerop@amd.com>, <a.manzanares@samsung.com>, <dongjoo.seo1@samsung.com>,
	<mst@redhat.com>, <marcel.apfelbaum@gmail.com>, <linux-cxl@vger.kernel.org>,
	<qemu-devel@nongnu.org>
Subject: Re: [PATCH 3/5] hw/cxl: Allow BI by default in Window restrictions
Message-ID: <20251219175309.000009b1@huawei.com>
In-Reply-To: <873457aii2.fsf@pond.sub.org>
References: <20251103195209.1319917-1-dave@stgolabs.net>
	<20251103195209.1319917-4-dave@stgolabs.net>
	<87wm2ki1wm.fsf@pond.sub.org>
	<20251218154832.00000159@huawei.com>
	<873457aii2.fsf@pond.sub.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Thu, 18 Dec 2025 16:59:17 +0100
Markus Armbruster <armbru@redhat.com> wrote:

> Jonathan Cameron <jonathan.cameron@huawei.com> writes:
> 
> > On Thu, 18 Dec 2025 10:18:17 +0100
> > Markus Armbruster <armbru@redhat.com> wrote:
> >  
> >> Davidlohr Bueso <dave@stgolabs.net> writes:
> >>   
> >> > Update the CFMW restrictions to also permit Back-Invalidate
> >> > flows by default, which is aligned with the no-restrictions
> >> > policy.
> >> >
> >> > While at it, document the 'restrictions=' option.    
> >> 
> >> I'd split the patch.  Up to you.  
> > Hi Markus,
> >
> > As you note below the interface hasn't been in any release anyway and
> > is part of the long backlog I'm carrying and slowly getting
> > upstream. Bringing this in from the start with that restrictions
> > control should be fine.
> >
> > However, backwards compatibility does need addressing
> > as this changes the default for things we do create today (with
> > no restrictions).
> >
> > In this particular case, I don't think we care because there are no
> > BI capable devices before this series - so there can't be anything
> > using this feature for the host memory range it describes.
> >
> > As such, the only result is the ACPI table says we have an extra
> > flag set which no one will care about.  Will need to update
> > the ACPI table tests though. I'll check.
> >
> > Migration of CXL topologies is horribly broken currently anyway
> > so that's not a problem here. Given current usecases are strictly
> > software stack verification fixing that isn't a priority (yet).  
> 
> Good to know.  Work into commit message(s)?
> 
Will do.

I'll shuffle things around a bit whilst adding this to my staging
tree and first of all update the default (before the configuration
interface patch) to include this.  That patch will have some info
on backwards compatibility etc + ACPI tables updates (usual 3 patch
sequence to do that).

'll squash this patch into the generic restrictions configuration
interface patch.  That can then run separately wrt to
getting things upstreamed. It's a somewhat ugly interface at the
moment so that might needs some more involved discussion than
the BI support itself.

Jonathan

