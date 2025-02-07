Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7854F194C6A
	for <linux-cxl@vger.kernel.org>; Fri,  7 Feb 2025 21:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738963183; cv=none; b=ILWU7dP3Rhr2zr7Gnz9AQrolqPSWFYS2XT9RYjqpuN9dxv7lHu+kdgXzTWhtAjHD5bKcWZQ8pcS9Q8Bdlh6gJQBoKfkdBWp8ZqSdqXcgFm6z8ArhG+vHfbiKoaAp1ClFQKvtsz+FzLXX92woAGoU1PhBOcZ5k2IoL8h8hjwv2LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738963183; c=relaxed/simple;
	bh=EQ6JfKDSU+/vOUYStDh+fXccuVee+bZgtIgkdJHS3GY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RplHI36A3/fqwnDQRvXCKlyREShdKWm3wKUqaxARwFrT8FoGqFLNlVTO08hFUOKr35MJ9mMoQvQIc6sLSXO/Kd1gdPMM2RMGQ3B2Ivhu6IZJj80wtOstzDlVR6rr/xBsUSPuJmPJbDlO3pugQdnc6CI4oaasG6hk6I5EWDtT/WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AZHw4Hb9; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AZHw4Hb9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738963181; x=1770499181;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EQ6JfKDSU+/vOUYStDh+fXccuVee+bZgtIgkdJHS3GY=;
  b=AZHw4Hb9OGxvmwO+AdNljhrDawYxlhyiDr+bftX1NOjRY8UKwfkAWGcP
   9lfdbuK5ef3oPsX18DQwfuPt3fiFLZxTFL/fZmh5vhJjY4mruUPJG6HZh
   aZHr5Je2RLSWbOJQJgdnXsm2NMi+ntDqEwo7qca8UiLZcrfcBxvIA6+s4
   P2oue+R0HttVi/UMPV87/HcyopQ+AzJslvtVS8eLxsaTuhRO/Oie2WmoR
   nPH8zK1BQTlWwwWZa6ToA89QFDv4wHqA39vSTVPZBL8p8smVwSTUSETEM
   1MCUO+d+CpEeiVoI4LKRoFbIa4GALeL245Z2agIUkosTulaZvNr8TzDGh
   g==;
X-CSE-ConnectionGUID: kUzCUdu6So+Q1/MlqNFSjA==
X-CSE-MsgGUID: nPvtq/9CS2qNgja7Z61axg==
X-IronPort-AV: E=McAfee;i="6700,10204,11338"; a="42458639"
X-IronPort-AV: E=Sophos;i="6.13,268,1732608000"; 
   d="scan'208";a="42458639"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 13:19:40 -0800
X-CSE-ConnectionGUID: kd1SdDOzT3azqA+V9PgYLQ==
X-CSE-MsgGUID: r3NmmlHVSMyUEb039HJxRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,268,1732608000"; 
   d="scan'208";a="111403911"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2.lan) ([10.125.111.82])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 13:19:40 -0800
Date: Fri, 7 Feb 2025 13:19:38 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>, linux-cxl@vger.kernel.org
Subject: Re: [PATCH] cxl/mbox: Check enabled_cmds before sending
 SET_SHUTDOWN_STATE
Message-ID: <Z6Z46ua77FuWRi_p@aschofie-mobl2.lan>
References: <20250207193427.1711233-1-alison.schofield@intel.com>
 <67a667af363d5_2d2c29477@dwillia2-xfh.jf.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67a667af363d5_2d2c29477@dwillia2-xfh.jf.intel.com.notmuch>

On Fri, Feb 07, 2025 at 12:06:07PM -0800, Dan Williams wrote:
> alison.schofield@ wrote:
> > From: Alison Schofield <alison.schofield@intel.com>
> > 
> > The CXL specification defines CXL_MBOX_OP_SET_SHUTDOWN_STATE as
> > optional. Check the enabled_cmds bitmap before sending to device.
> 
> Table 8-126 defines it as mandatory for devices that support PMEM, see
> the "PM" in the "Mailbox" column.
> 
> > This appeared with cxl-test where mock support for this command
> > is not present and -EIO is returned, leading to a WARN_ONCE()
> > stack trace and dev_warn()'s on every cxl_nvdimm_probe.
> 
> Davidlohr and I talked about this here:
> 
> http://lore.kernel.org/679430b145dc0_20fa2947b@dwillia2-xfh.jf.intel.com.notmuch
> 
> The plan was to follow up with mock device support... oh, that came in
> on Tuesday, I need to go take a look at that:
> 
> http://lore.kernel.org/20250205040842.1253616-1-dave@stgolabs.net

Ah, I see it now. I saw the GPF patch in cxl/next and didn't want
to dilly-dally! Should've dillied a bit.

I'll try out your cxl-test patch David.

--Alison


> 
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > ---
> > 
> > Not sure what we actually want to do when not supported.
> > Most cmds just return 0, like I did here, but maybe for
> > this functionality something more is warranted.
> > 
> > wrt cxl-test support, also not sure if this feature wants some
> > round-trip testing support via cxl-test mocking. I do like the
> > -EIO from cxl-test as a loud reminder when running cxl-test 
> > that something new has come in that cxl-test doesn't know about.
> 
> Have a look at that follow-up series and see if it addresses the
> concerns.
> 
