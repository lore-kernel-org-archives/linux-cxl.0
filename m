Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF09D21CC4A
	for <linux-cxl@vger.kernel.org>; Fri,  7 Mar 2025 20:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741378325; cv=none; b=D8WF8/yaQD+kEcpho6E4l+V36YNJC9n7kRXzHCgbqv/V15mQSGOpdAH7/eHLkvzscTA1lkxD3+QxeLi0Lkyi35GN4ZcYMnJaZmF3O2l5EFfUUAyEeDwnoyMWgCeqTwkElgXuMNRV+cI4VA7GGHf3nRXcU5IGXNBlpiSmfUhP0dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741378325; c=relaxed/simple;
	bh=dnm1QBuAs7SySeCvJC80RNrVkv/9VleFxX0sUHFeMiw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KqaICUy8kmU14nwCQqXVU5X6vQEOYs/4CEa/AidtF1tj0HiphaKX8BB1ApZVQtViGi1MX86CH1VtZvCZz6Cwqyc7MO9O1RhSfZ41ly9yd6hfGk9g2VeQzSthDSDWBXt5DO/q6C366SL3x/hQ62yAg0CVIXUjQUYjYXUqthZTu9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C4tG5gOt; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C4tG5gOt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741378323; x=1772914323;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dnm1QBuAs7SySeCvJC80RNrVkv/9VleFxX0sUHFeMiw=;
  b=C4tG5gOtLs4y0Qgg4dzpd6Zm/pcWbPe9YNZ9OBh08EDl5i8KU3RwrnFr
   y8efOJVDOG/v6PvhTtrLWVMkzyVO30GlTV6Uqtk5lLVajiq9gVj2BIjNt
   5cXgj7RtUF5tr5s9ZPbNGe42pgt56701wlOPMixt7KO4X4mrkrfy+9bND
   ATAxALTwTPnO/UCq1KfhbvV5iR7WgHvYYkLc0nXOvtD+pdICBPdEIO8Ew
   p19NpM99cFc/6Wn6bGewStYj+qzFQRO5g/omG9tArtZtfAvkGrjxWSY+k
   IItkHe+/eIdukPzkciK3NbKwvBCNVtoRWudsW+U8uDv9dR1vsWyKf196V
   A==;
X-CSE-ConnectionGUID: shKw3DMeT462vUsk8/GL3Q==
X-CSE-MsgGUID: Bgj3dYIuS+2CKXFOg9ZNyw==
X-IronPort-AV: E=McAfee;i="6700,10204,11366"; a="59995092"
X-IronPort-AV: E=Sophos;i="6.14,230,1736841600"; 
   d="scan'208";a="59995092"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 12:11:58 -0800
X-CSE-ConnectionGUID: nKHL/Wv7RM2kfvsmIOBWoQ==
X-CSE-MsgGUID: dxYbmsklTj2KyOZw18pnZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="150365453"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2.lan) ([10.125.110.159])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 12:11:57 -0800
Date: Fri, 7 Mar 2025 12:11:55 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Gregory Price <gourry@gourry.net>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Subject: Re: [PATCH] cxl: Restore opcode order in enum cxl_opcode
Message-ID: <Z8tTCzP2ih3Aje9C@aschofie-mobl2.lan>
References: <20250307181214.2624147-1-alison.schofield@intel.com>
 <Z8tQjmjseVgEyFCd@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8tQjmjseVgEyFCd@gourry-fedora-PF4VCD3F>

On Fri, Mar 07, 2025 at 03:01:18PM -0500, Gregory Price wrote:
> On Fri, Mar 07, 2025 at 10:12:10AM -0800, alison.schofield@intel.com wrote:
> >  	CXL_MBOX_OP_GET_LOG_CAPS	= 0x0402,
> >  	CXL_MBOX_OP_CLEAR_LOG           = 0x0403,
> >  	CXL_MBOX_OP_GET_SUP_LOG_SUBLIST = 0x0405,
> > -	CXL_MBOX_OP_GET_SUPPORTED_FEATURES	= 0x0500,
> > -	CXL_MBOX_OP_GET_FEATURE		= 0x0501,
> > -	CXL_MBOX_OP_SET_FEATURE		= 0x0502,
> >  	CXL_MBOX_OP_IDENTIFY		= 0x4000,
> >  	CXL_MBOX_OP_GET_PARTITION_INFO	= 0x4100,
> >  	CXL_MBOX_OP_SET_PARTITION_INFO	= 0x4101,
> > @@ -551,6 +548,9 @@ enum cxl_opcode {
> >  	CXL_MBOX_OP_UNLOCK		= 0x4503,
> >  	CXL_MBOX_OP_FREEZE_SECURITY	= 0x4504,
> >  	CXL_MBOX_OP_PASSPHRASE_SECURE_ERASE	= 0x4505,
> > +	CXL_MBOX_OP_GET_SUPPORTED_FEATURES	= 0x0500,
> > +	CXL_MBOX_OP_GET_FEATURE		= 0x0501,
> > +	CXL_MBOX_OP_SET_FEATURE		= 0x0502,
> >  	CXL_MBOX_OP_MAX			= 0x10000
> >  };
> >  
> 
> [04, 05, 45] seems like the right ordering for an enum, is this
> based on spec ordering?

No - just ignore this. Adjusting my eyeglasses.


> 
> ~Gregory
