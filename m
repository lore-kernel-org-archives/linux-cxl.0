Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9CE120F09A
	for <linux-cxl@vger.kernel.org>; Tue, 15 Apr 2025 16:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744734623; cv=none; b=I6yq6hsBi4A7ZvRiTpvGGndr38q5C3ta5T97hI4DlTH5hE7uDkFMi9mWKa0zeYWFu5f/05UFNQdldMNPMAKDj/HSQzb5QK+N7pPXUHzZJ6PkVT9/hjllIMjHyPe+o6Th5BNYAVBBP3ZvCq/n+CVbsGEtyHEQo5qgQG2bsnz8S+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744734623; c=relaxed/simple;
	bh=Lokf8C3J3pogp4AHJ2D2HuzDD3O5qTpPiSckv11Ao2c=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eyaCSdTt7Ajdvqo1BEASVA8Ieuqw9GLyL1k3wdnBybZi09NKl9rrP1JpwHgVRdFLFRgyUKQl6a+CcQLS0x1+kj6H3D5em72BZ8GUyd5RImVC3b63YeMI58axegD8JRXpSQa5gkGLzjwA93icNXT+bRAN6PUt047yDqWK/uMqNHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZcTzy0JcGz6K9XH;
	Wed, 16 Apr 2025 00:26:06 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id D1E03140144;
	Wed, 16 Apr 2025 00:30:17 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 15 Apr
 2025 18:30:17 +0200
Date: Tue, 15 Apr 2025 17:30:16 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Gregory Price <gourry@gourry.net>
CC: "Ye, Huaisheng" <huaisheng.ye@intel.com>, "Williams, Dan J"
	<dan.j.williams@intel.com>, "Jiang, Dave" <dave.jiang@intel.com>, "Jia, Pei
 P" <pei.p.jia@intel.com>, "Du, Fan" <fan.du@intel.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: Re: [RFC PATCH] cxl/core: reenable Mem_Enable bit of DVSEC control
 when RR decodes outside platform ranges
Message-ID: <20250415173016.00001b42@huawei.com>
In-Reply-To: <Z_Z9yU_kWkWRp8YJ@gourry-fedora-PF4VCD3F>
References: <20250406112752.1261855-1-huaisheng.ye@intel.com>
	<Z_SWjQA4qb3OE6Dk@gourry-fedora-PF4VCD3F>
	<DS0PR11MB7458325CE975067CBD63ED3E9FB42@DS0PR11MB7458.namprd11.prod.outlook.com>
	<Z_Z9yU_kWkWRp8YJ@gourry-fedora-PF4VCD3F>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 9 Apr 2025 09:01:45 -0500
Gregory Price <gourry@gourry.net> wrote:

> On Wed, Apr 09, 2025 at 03:48:42AM +0000, Ye, Huaisheng wrote:
> > From: Gregory Price <gourry@gourry.net>
> > The phenomenon I observed here is that the content of RR is incorrect, as it is not within the hpa_range of the root decoder.
> > Here are the debug messages of dmesg from site scene. FYI.
> > 
> >  [    7.683508] cxl_dvsec_rr_decode: cap = 0x1e
> >  [    7.683535] cxl_dvsec_rr_decode: ctrl = 0x6		<-- which means CXL_DVSEC_MEM_ENABLE has been set by firmware (Qemu)
> >  [    7.683557] cxl_dvsec_rr_decode: range0 base = 0, size = 2147483648   <- endpoint's dvsec_range
> > 
> >  [    7.761781] dvsec_range_allowed: cxld->hpa_range.start = 11005853696  <- root decoder
> >  [    7.761782] dvsec_range_allowed: cxld->hpa_range.end   = 45365592063  
> 
> Are you interleaving like 16 2GB devices?  Because the RR here has 2GB
> of capacity, while the root describes 32GB of capacity.  Just trying to
> make sense of the configuration here.  If you can share your qemu
> config, tha would be helpful.
> 
> > I agree Qemu should fix this issue, it occurs probabilistically.  
> 
> Hm, Jonathan is it unreasonable to go off an clear the ctrl bits in
> ct3_reset?  I'm not sure what the warm-reset procedure is, but it does
> seem like we shouldn't cache decoder / ctrl bit programmings across
> reset.  Not sure if just re-calling build_dvsecs is sufficient.

We need to handle the difference between a warm-reset and a cold one correctly
I think + CXL reset ideally.  This particular thing was never a priority
for me but I'm more than happy to review patches from others.

If not I'll get to it eventually, but I suspect there is a bunch more to do than
just this and the build_dvsecs() in ct3d_reset was the thing that
broken the DOE last time.

Testing wise it needs someone to check the entire device configuration and
ensure the correct things have been reset.

Oh and on top of that move to the newer reset handling in qemu probably
docs/devel/reset.rst 

Jonathan



> 
> > And I think this patch would help CXL driver to dealing with various firmware situations.  
> 
> The question is whether this behavior is even feasible on real hardware.
> The issue seems to basically be that QEMU doesn't implement the right
> reset mechanism, because other
> 
> ~Gregory

