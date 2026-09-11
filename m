Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524032E4257
	for <linux-cxl@vger.kernel.org>; Fri, 11 Sep 2026 00:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789088034; cv=none; b=DW/MkTezUQOkvotfKiOygtsbZCT0VudPbUPLdZJfkrD4cDbWDaJ2w4JdE75/hdLzJR8jzc/uZSE9Fd38szOb1mvxnx5yg6/XSXEB0qCSKZeeYZriQqShEm5bxqm5SoYrbqD0uIjgmgZrg8MgI4BUs0pIRNRKOC8n5f2XU9Od7X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789088034; c=relaxed/simple;
	bh=+8gJnqdKZagrx1hhcuOdTbMgMxU+WkJi+Dx6ykynnak=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VryAjK2NpwKDFropuFYHkwS+2T58W0DzD1K3FjwTxTkZ1t/v+Yl6f+oRzgQvorHWNgGWXhn7teWlnBWwrRm1GNFHSvkEDOFRrkyxKyj1hibAx7EI8MoP5nGCQkztU0Z4zaCxAQ5aMTOBcSMwltQ+3oJqiO4kUjzjQNFDpMbeHls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LR1tOXRm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LR1tOXRm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85A4F1F000FF;
	Fri, 11 Sep 2026 00:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789088032;
	bh=AInLmVHoBJDktnLyCE7snPElFSOR/W1RNn2P70VivGE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=LR1tOXRmIsUv+vonBQtXZOStieQ+jzi240hD8tTeDs3sf7GOu/Tsgw4zRUbw4CeBH
	 mnE23W4YY/YHExlIx0FynH2g1lTG2G3vsTer5GNo6SxscCqyud7dtmaj/oobHLChjh
	 2ANJZ+iHna5ZwOusg96M4RjKkaYgTzMtta6XDMlF0DOgFt07ucNaScDhmK1VK0vkXy
	 s4Xu1bfhcKYSDge1O4SK43m1jKGEQzlU1d2O6oPqjT4E4jY+gyifVhKlCe6Nvr/5je
	 CMMNZlPr+FYxtFgojjBhdx5xhkUclLyQmsC1BoMpC/0SoTjYti+QcEK9Ss0ZmMf+JL
	 wrIQaVby0Ai/g==
Date: Fri, 11 Sep 2026 01:53:48 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Anisa Su <anisa.su887@gmail.com>
Cc: linux-cxl@vger.kernel.org, alison.schofield@intel.com,
 dave.jiang@intel.com, gourry@gourry.net, icheng@nvidia.com,
 ming.li@zohomail.com, vishal.l.verma@intel.com, dave@stgolabs.net,
 benjamin.cheatham@amd.com, Ira Weiny <iweiny@kernel.org>, Wonjae Lee
 <wj28.lee@samsung.com>, Junhee Park <jh9934.park@samsung.com>, Heesoo Kim
 <habil.kim@samsung.com>
Subject: Re: [RESEND PATCH v13 2/8] cxl/mem: Read dynamic capacity
 configuration from the device
Message-ID: <20260911015348.6c45319f@jic23-hlaptop>
In-Reply-To: <aqNDoqRyMiTP3aNz@cxlqual>
References: <20260908102124.2231730-2-anisa.su@samsung.com>
	<20260908102124.2231730-4-anisa.su@samsung.com>
	<20260908214310.2f9abccb@jic23-huawei>
	<aqNDoqRyMiTP3aNz@cxlqual>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

...

> > > +	/* A DCD reports between 1 and 8 partitions */
> > > +	if (dc_resp->avail_partition_count == 0 ||
> > > +	    dc_resp->avail_partition_count > CXL_MAX_DC_PARTITIONS) {  
> > 
> > This strikes me as a compatibility issue waiting to happen.  Today the spec
> > supports 8, but maybe in future it will support more and I'd not consider
> > that a backwards compatibility break (which this would make it).  I'd clamp
> > to CXL_MAX_DC_PARITIONS and maybe print with dev_info() if you see something
> > bigger in the wild.
> >   
> I see... I did the below and moved it to the caller
> cxl_dev_dc_identify() so the dev_err/dev_info messages are only printed
> once, since the current function is called in a loop.
> 
> 		avail = dc_resp->avail_partition_count;
> 		if (avail == 0) {
> 			dev_err(dev, "Device reported no DC partitions\n");
> 			return -EIO;
> 		}
> 
> 		/* More than Linux handles is not a reason to refuse DCD */
> 		if (avail > CXL_MAX_DC_PARTITIONS) {
> 			dev_info(dev, "Device reported %u DC partitions, reading the first %u\n",
> 				 avail, CXL_MAX_DC_PARTITIONS);
> 			avail = CXL_MAX_DC_PARTITIONS;
> 		}

Given you don't do anything with most of them I'd just do

		avail = min(avail, CXL_MAX_DC_PARTITIONS);

and not print anything.

Thanks,

Jonathan
