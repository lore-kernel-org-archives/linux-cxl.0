Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E417492
	for <linux-cxl@vger.kernel.org>; Fri,  5 Jul 2024 01:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720144779; cv=none; b=rmVKRzGmonUJUXJU48Ctme7vIvGkG3Bn0954t/PqXCm3qAETvoP+cxBNGC4fQWftWn6OjWSg2Oe5K7cPa/HMGJa+aAUU4AIh0Nn8Yr9twhd7f26vVN2W7Qkq5d56aNq7zDhmpy6osSDVYGMLj2BX1Sz1XU6kG88d9aiHlNYTU/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720144779; c=relaxed/simple;
	bh=H5aKULNt4WSucCpS33VBoTqFB2U+MngO5Rz+nQDfDew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WExxWgng/v+1qKI1o+RQAb0OuQD0DnfARcrNtCzmJtWPCOFNNok6U7C4Jql/yFTTh0x/SJIXV8Ut6HtEyuvlmhHPxSvRr0FcWdb6rVMgTvKSIiKW0TCTGKHRq+M3MvTIVWZfluAW88AmYiSHs8YMs5Tr5X0L+gFkiHqlji+jS8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G8jz4ZHC; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G8jz4ZHC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720144778; x=1751680778;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=H5aKULNt4WSucCpS33VBoTqFB2U+MngO5Rz+nQDfDew=;
  b=G8jz4ZHCGbmOUw9UmGriMaiZD3pucQA+hVTBP6IPCMLMXa4eI9vLpurN
   pXM/gkIsfFc47UKvs2cI+XUqqEXRLhE3yocJAcqjn5+0Brz5qwnuTwcDu
   NVetxeOm7BjSdn0c/wzHJb/TimESBpZM7aGJel78sItrHQR2ZlbJNP4uk
   M+ScW6sOh9tKbXTp61wtjFVv4eMF0Z48iJ860ZVtsdP/8GiNPHgTitcsh
   bx1KwdT9G2i8eAB8RRj0xZTUbdeNBxS5Fmur3OObbHGy/3iyVU264LWEI
   41mGuywy/K6jBYx2QzA/mhH4ZpcfeCxUh7HKqtELrxYj8GxsYwV/ZGH+d
   Q==;
X-CSE-ConnectionGUID: jm0vZur8St2gMFkWXY0IlQ==
X-CSE-MsgGUID: C+Zm0+mqTimov39SOobquw==
X-IronPort-AV: E=McAfee;i="6700,10204,11123"; a="28820683"
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="28820683"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2024 18:59:37 -0700
X-CSE-ConnectionGUID: v/fgd0WsTXKYXpSlhOVeNA==
X-CSE-MsgGUID: 73xskWlKTLid94cGL7iGvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="51695204"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost) ([10.239.160.36])
  by orviesa005.jf.intel.com with ESMTP; 04 Jul 2024 18:59:34 -0700
Date: Fri, 5 Jul 2024 10:15:12 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"mst@redhat.com" <mst@redhat.com>,
	Markus Armbruster <armbru@redhat.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"linuxarm@huawei.com" <linuxarm@huawei.com>,
	Zhao Liu <zhao1.liu@linux.intel.com>
Subject: Re: [PATCH 1/3] hw/cxl: Get rid of unused cfmw_list
Message-ID: <ZodXMPef9bIROG5u@intel.com>
References: <20240702143425.717452-1-Jonathan.Cameron@huawei.com>
 <20240702143425.717452-2-Jonathan.Cameron@huawei.com>
 <5ffea576-0b87-46c1-b4dc-e09bd253805e@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ffea576-0b87-46c1-b4dc-e09bd253805e@fujitsu.com>

On Fri, Jul 05, 2024 at 01:04:51AM +0000, Zhijian Li (Fujitsu) wrote:
> Date: Fri, 5 Jul 2024 01:04:51 +0000
> From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
> Subject: Re: [PATCH 1/3] hw/cxl: Get rid of unused cfmw_list
> 
> Jonathan,
> 
> 
> There is a new user for cfmw_list now
> https://lore.kernel.org/qemu-devel/20240704093404.1848132-1-zhao1.liu@linux.intel.com/
> 
> So I think we should drop this patch.

Hi Zhijian,

I'm not a "real" user and that bug was originally found by code reading.

So that fix won't block your drop. :-)

And I think the fix is worth being laned before cfmw_list gets dropped,
for being able to port backwards to stable QEMU.
 
> On 02/07/2024 22:34, Jonathan Cameron wrote:
> > From: Li Zhijian <lizhijian@fujitsu.com>
> > 
> > There is no user for this member. All '-M cxl-fmw.N' options have
> > been parsed and saved to CXLState.fixed_windows.
> > 
> > Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> >   include/hw/cxl/cxl.h | 1 -
> >   hw/cxl/cxl-host.c    | 1 -
> >   2 files changed, 2 deletions(-)
> > 
> > diff --git a/include/hw/cxl/cxl.h b/include/hw/cxl/cxl.h
> > index 75e47b6864..e3ecbef038 100644
> > --- a/include/hw/cxl/cxl.h
> > +++ b/include/hw/cxl/cxl.h
> > @@ -43,7 +43,6 @@ typedef struct CXLState {
> >       MemoryRegion host_mr;
> >       unsigned int next_mr_idx;
> >       GList *fixed_windows;
> > -    CXLFixedMemoryWindowOptionsList *cfmw_list;
> >   } CXLState;
> >   
> >   struct CXLHost {
> > diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
> > index c5f5fcfd64..926d3d3da7 100644
> > --- a/hw/cxl/cxl-host.c
> > +++ b/hw/cxl/cxl-host.c
> > @@ -335,7 +335,6 @@ static void machine_set_cfmw(Object *obj, Visitor *v, const char *name,
> >       for (it = cfmw_list; it; it = it->next) {
> >           cxl_fixed_memory_window_config(state, it->value, errp);
> >       }
> > -    state->cfmw_list = cfmw_list;
> >   }
> >   
> >   void cxl_machine_init(Object *obj, CXLState *state)
