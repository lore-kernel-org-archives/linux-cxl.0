Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCDF31283C;
	Tue, 11 Nov 2025 14:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762873160; cv=none; b=hBGbwmkm1GJ7ZQbwbX/EH/dHe3rWqVpDDEWXTsA5xigaMRrwOQ2yeBeUlCtQpgXqivlzx8UD5kG7toVsFMekMcqZZPzdFMccVRNMcbpfgkH/j/9yQP1ESxswC3P/70ZK7KD78RkpTgpwGWTQOkV4NG8RNln0/EtzGDVBsET4yMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762873160; c=relaxed/simple;
	bh=ganulytfVevWoNALREGDT/exp+f7xs416BOmNYO3gCo=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tw+yLpItpOht1LRWjNdGe79sol4CKqmQrj81Ou4XxYKaHRJbCSIrzjbMz3MNwo+8GVEFyDnjW5ME38yapDsPXXv8NFGv2B+zemSVtpBLqKKRpbdIFh3jqhXSve/pSWUfXEPTd5jNJBFZ2K1Zrwe2Rkw6CeashH+uguPze2NCT60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4d5V6T640VzHnGh6;
	Tue, 11 Nov 2025 22:58:57 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 229D7140136;
	Tue, 11 Nov 2025 22:59:15 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Tue, 11 Nov
 2025 14:59:14 +0000
Date: Tue, 11 Nov 2025 14:59:13 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Robert Richter <rrichter@amd.com>
CC: Dave Jiang <dave.jiang@intel.com>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gregory Price <gourry@gourry.net>, "Fabio M.
 De Francesco" <fabio.m.de.francesco@linux.intel.com>, Terry Bowman
	<terry.bowman@amd.com>, Joshua Hahn <joshua.hahnjy@gmail.com>
Subject: Re: [PATCH v4 06/14] cxl/region: Separate region parameter setup
 and region construction
Message-ID: <20251111145913.00007174@huawei.com>
In-Reply-To: <aQ4XXcxRidI3-kjI@rric.localdomain>
References: <20251103184804.509762-1-rrichter@amd.com>
	<20251103184804.509762-7-rrichter@amd.com>
	<d34130ca-83fb-4f9d-b724-007b549f6f34@intel.com>
	<aQ4XXcxRidI3-kjI@rric.localdomain>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Fri, 7 Nov 2025 16:59:25 +0100
Robert Richter <rrichter@amd.com> wrote:

> On 03.11.25 15:05:28, Dave Jiang wrote:
> > 
> > 
> > On 11/3/25 11:47 AM, Robert Richter wrote:  
> > > To construct a region, the region parameters such as address range and
> > > interleaving config need to be determined. This is done while
> > > constructing the region by inspecting the endpoint decoder
> > > configuration. The endpoint decoder is passed as a function argument.
> > > 
> > > With address translation the endpoint decoder data is no longer
> > > sufficient to extract the region parameters as some of the information
> > > is obtained using other methods such as using firmware calls.
> > > 
> > > In a first step, separate code to determine the region parameters from
> > > the region construction. Temporarily store all the data to create the
> > > region in the new struct cxl_region_context. Once the region data is
> > > determined and struct cxl_region_context is filled, construct the
> > > region.
> > > 
> > > Patch is a prerequisite to implement address translation. The code
> > > separation helps to later extend it to determine region parameters
> > > using other methods as needed, esp. to support address translation.
> > > 
> > > Reviewed-by: Gregory Price <gourry@gourry.net>
> > > Signed-off-by: Robert Richter <rrichter@amd.com>  
> > 
> > Just a small thing below, otherwise
> > Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> >   
> > > ---
> > >  drivers/cxl/core/core.h   |  9 +++++++++
> > >  drivers/cxl/core/region.c | 32 +++++++++++++++++++++-----------
> > >  2 files changed, 30 insertions(+), 11 deletions(-)
> > > 
> > > diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> > > index 1fb66132b777..2bc37f3aee21 100644
> > > --- a/drivers/cxl/core/core.h
> > > +++ b/drivers/cxl/core/core.h
> > > @@ -19,6 +19,15 @@ enum cxl_detach_mode {
> > >  };
> > >  
> > >  #ifdef CONFIG_CXL_REGION
> > > +
> > > +struct cxl_region_context {
> > > +	struct cxl_endpoint_decoder *cxled;
> > > +	struct cxl_memdev *cxlmd;  
> > 
> > cxlmd may not be needed.
> > 
> > struct cxl_memdev *cxlmd = cxled_to_memdev(cxlr_ctx->cxled);
> > 
> > which you used later on in this patch to init the cxlmd member :)  
> 
> This was on purpose to eliminate an unnecessary frequent call of
> cxled_to_memdev() while holding the context. There is at least a
> 3-level pointer chasing to get to cxlmd.
> 
> Maybe it's wort to add it to struct cxl_endpoint_decoder.

This isn't high performance code and the helper is there so I'd just
use it as Dave suggested.

Jonathan

> 
> -Robert
> 

