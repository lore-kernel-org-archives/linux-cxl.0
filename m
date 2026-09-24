Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8752EEE99
	for <linux-cxl@vger.kernel.org>; Thu, 24 Sep 2026 00:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790211362; cv=none; b=ChdsXZZsjTe1v/EL/RVyIPCaH5rZ/ofM9i7qunGpOwus8oqnQqB/BEs/L9ASfDAqf1fLzeboxhD9p6QtnOFhz3UoGtjPhW9dd2Cb+MA99ad83LWqwDRSXpUEiWhH2Rcq8qDcik1WPGfd4hefnKDTr3+SI+R3xQU7JWAb9PHNSHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790211362; c=relaxed/simple;
	bh=hzZjlBb89jPp92ZSAYnoLT3hd944HsJiTo6L6NP0Erg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LKMRAqSv4VAVyWUHvYDbjngC1vxu4xOE34TYjk5m0nB4e6kp0cKTkJOTyZQLQz/9+NKmbRS9XZ2dzkPUZe7M0mhPAyDLkLth61jnpD9cdMJD/Paba0KDFusN4Zazb0ZxP/lnqdUSrhIG6Ab1RtdqZBT/Ks3uLeOcFLgpSJDzvSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aoWYJDUu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aoWYJDUu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 724D71F000FF;
	Thu, 24 Sep 2026 00:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790211359;
	bh=bgGKwOYpmrbs7jz+QvinR8oG4o0aEfm2dHUVMtG5STs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=aoWYJDUutdLyrmLcTnBlLANasTqnIqhc2KYZvjksIRmVP5hbDmLIBZQ8mdpWrLaoi
	 Dq2Gp8qqxAPf0Sa5DkGuSpWoE23QN4i8ai71WZrd51jDy1YdRkgGjc5KQtQm9duhlh
	 D4amU/S9UBiLUqOYsJAwB3ZLMv4JKbLrn/eoOhwa7MOEfZO3DLaZBxNrJgRBkrKS2d
	 72HkPzZ6/rxnSORgGJK3ULdYuCy3S1Oj5eleE/YVM5V4D1EbE2dUYFkPsCtCBvf+zB
	 72j30b/VptxWmD70YqbDF/JHdXuQilsNv8dKC9LFih1UOl7q2VFmomReWamP3N21ok
	 TSc5Mf6AbnThA==
Date: Thu, 24 Sep 2026 01:55:51 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Richard Cheng <icheng@nvidia.com>
Cc: Anisa Su <anisa.su887@gmail.com>, linux-cxl@vger.kernel.org, Dave Jiang
 <dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Li Ming <ming.li@zohomail.com>,
 Gregory Price <gourry@gourry.net>, Ben Cheatham
 <benjamin.cheatham@amd.com>, Ira Weiny <iweiny@kernel.org>, Anisa Su
 <anisa.su@samsung.com>, Wonjae Lee <wj28.lee@samsung.com>, Junhee Park
 <jh9934.park@samsung.com>, Heesoo Kim <habil.kim@samsung.com>
Subject: Re: [PATCH v14 2/8] cxl/mem: Read dynamic capacity configuration
 from the device
Message-ID: <20260924015551.02cf0201@jic23-hlaptop>
In-Reply-To: <arH3l77e_qQuyYWp@MWDK4CY14F>
References: <20260918203049.7273-1-anisa.su@samsung.com>
	<20260918203049.7273-3-anisa.su@samsung.com>
	<arH3l77e_qQuyYWp@MWDK4CY14F>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Sep 2026 11:44:16 +0800
Richard Cheng <icheng@nvidia.com> wrote:

> On Fri, Sep 18, 2026 at 01:30:11PM +0800, Anisa Su wrote:
> > From: Ira Weiny <iweiny@kernel.org>
> > 
> > Devices which support Dynamic Capacity (DC) are configured
> > via mailbox commands. CXL r4.0 section 9.13.3 describes the use of
> > the Get DC Configuration command in order to obtain DCD partition
> > characteristics.
> > 
> > Implement the DC mailbox commands as specified in CXL 4.0 section
> > 8.2.10.9.9 (opcodes 48XXh) to read and store the DCD configuration
> > information. Disable DCD if an invalid configuration is found.
> > 
> > Initial enablement for Linux only supports one dynamic capacity
> > partition. Read all the partitions the device reports but validate
> > only the first, and configure it as 'dynamic ram 1'.
> > 
> > The specification requires that volatile capacity starts at DPA 0 and pmem
> > starts at the DPA immediately following it, but DC partitions only need
> > to be 256MB aligned according to CXL r4.0 section 8.2.10.9.9.1 Table 8-347.
> > So a device could leave a gap between ram/pmem (static) capacity and its first
> > DC partition, or between one DC partition and the next.
> > 
> > However, Linux chooses not to support gaps between static and dynamic
> > capacity, and requires the first DC partition to begin at the DPA
> > immediately following static capacity.
> > 
> > Based on an original patch by Navneet Singh.
> > 
> > Signed-off-by: Ira Weiny <iweiny@kernel.org>
> > Co-developed-by: Anisa Su <anisa.su@samsung.com>
> > Signed-off-by: Anisa Su <anisa.su@samsung.com>
> > Tested-by: Wonjae Lee <wj28.lee@samsung.com>
> > Tested-by: Junhee Park <jh9934.park@samsung.com>
> > Tested-by: Heesoo Kim <habil.kim@samsung.com>
> > Reviewed-by: Alison Schofield <alison.schofield@intel.com>
> >  
> 
> Reviewed-by: Richard Cheng <icheng@nvidia.com>
> 
> I wonder if we can have comments in code explaining why linux doesn't support
> gaps between static and DC, otherwise this can be a bit confusing why
> the 1st DC partition needs to be immediately after the static part, at least
> for me.

Because we are lazy?  :)

Or maybe because the more we constrain the hardware that is supported
the less variations we have deal with and test!

Jonathan

