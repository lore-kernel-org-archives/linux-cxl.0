Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2F7204F73
	for <linux-cxl@vger.kernel.org>; Tue, 15 Apr 2025 16:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744734114; cv=none; b=Yr1b1KSsvefVfdQE1l9EkTEeHfub0sFtvB2A6zcXxIx/zny7prC5ixBYuUUAWlwttdys7XQiFMembM4CXboV0dNJpcXsR2waJbBtMJs2FHf9aMDc9QzZfyEU97SyInUfu6DuuNk706kD5oDb94NIK9wQPVFSc8OotaPsIDCLA68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744734114; c=relaxed/simple;
	bh=02aYtM6exL/KdngBmpVKVgS4Gznsq6lGYnX/4+lvBqM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mD+NJziD1DtjomzmoWw+JWMYTb34JfS2hxnGIxQJH6dIC60CyJc7Go4DACWmx5oLDRiRt7RZvlNa2pmxOzQIfB2sR2JDzFvIVeuGAPD2HCUHx8fpsRzDxZ1Pp2pzGrJ+PiVawZmDM0fnJ+1ll1OQs0hH15TNHFcfKpRsXEyrIYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZcTsV3G9mz6L4w3;
	Wed, 16 Apr 2025 00:20:30 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id D4EFB140144;
	Wed, 16 Apr 2025 00:21:48 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 15 Apr
 2025 18:21:48 +0200
Date: Tue, 15 Apr 2025 17:21:47 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: Gregory Price <gourry@gourry.net>, "Zhijian Li (Fujitsu)"
	<lizhijian@fujitsu.com>, Huaisheng Ye <huaisheng.ye@intel.com>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>, "pei.p.jia@intel.com"
	<pei.p.jia@intel.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>
Subject: Re: [RFC PATCH] cxl/core: reenable Mem_Enable bit of DVSEC control
 when RR decodes outside platform ranges
Message-ID: <20250415172147.0000406f@huawei.com>
In-Reply-To: <43967129-86ec-4dbc-a065-11269e311fed@intel.com>
References: <20250406112752.1261855-1-huaisheng.ye@intel.com>
	<02fbb2a7-3973-4c7f-8b7d-cfabbb379467@fujitsu.com>
	<Z_aAnzqR-UP9rmIY@gourry-fedora-PF4VCD3F>
	<43967129-86ec-4dbc-a065-11269e311fed@intel.com>
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

On Wed, 9 Apr 2025 08:13:48 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> On 4/9/25 7:13 AM, Gregory Price wrote:
> > On Mon, Apr 07, 2025 at 08:31:13AM +0000, Zhijian Li (Fujitsu) wrote:  
> >> [1] https://lore.kernel.org/linux-cxl/20240409075846.85370-1-lizhijian@fujitsu.com/  
> > 
> > After looking at this, I see why this hasn't been fixed in QEMU.
> > Basically QEMU doesn't implement the right reset mechanism.
> > 
> > ct3_reset calls
> > 	cxl_component_register_init_common()
> > 		ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_GLOBAL_CONTROL,
> > 				 HDM_DECODER_ENABLE, 0)
> > 
> > But it never resets MEM_ENABLE in the dvsecs.
> > 
> > I'm not sure it's sane for Linux to be trying to handle hardware that
> > doesn't itself reset correctly - and doing this fix just for QEMU seems
> > a bit too far.  
> 
> I agree. No need to twist Linux in a bunch for something broken on QEMU. Until there's actual hardware that does this deployed in the field, we should just leave the Linux driver as is.

It's not yet fixed in QEMU because the proposed fix stops the CDAT DOE working.
https://lore.kernel.org/linux-cxl/20240802174010.000025e7@Huawei.com/

We don't correctly handle reset today.  I'm thoroughly in favour
of fixing qemu, but we need to do it carefully and not break other.

> 
> > 
> > The correct fix here is building an accessor for the existing CXL dvsecs
> > and updating it during ct3_reset.

Yes. Will be something along those lines but needs thorough testing.

Jonathan

> > 
> > ~Gregory  
> 
> 

