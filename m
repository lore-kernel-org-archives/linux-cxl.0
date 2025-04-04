Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5561F2C56;
	Fri,  4 Apr 2025 13:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743774818; cv=none; b=jN/OggD3QKW6WkRv2q/Wb+Xbmfieu0rdhQMphjCrUyHzyp/He5Aw62rKBgoviU3hCKjokX0mrRrPi5/jm8WQCA9ixed52yT73zX45Cn9cPuIp0qgpBW1kpqDxKRvxHWp8clB0RDR8gtzuq1UKRuP/JWmBICJKY3bfKQw4hC+/Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743774818; c=relaxed/simple;
	bh=10U8NdtmwB1T4+mE7hjOFF0m9/uG3tbjwAiz9Gypt7Y=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o5XKynj09ORCLqYkr3jemhcotkn8chSnuK+1rmNY7N/C0ZJq0TKiVm1liRUXzPljfflo4DMEV8WBFCCg03lF6MRiPH7nOkpdKYNpD3nWCDpWsa2SnKXw6mt8OdmR9YCNIPBmp+e3IG9043NtawtWDclxhRA3g0kovfn5LI2KwAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZTg2l66Zpz6M4WH;
	Fri,  4 Apr 2025 21:49:51 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id B1E71140595;
	Fri,  4 Apr 2025 21:53:33 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 4 Apr
 2025 15:53:33 +0200
Date: Fri, 4 Apr 2025 14:53:31 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
CC: Dan Williams <dan.j.williams@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, Dave Jiang
	<dave.jiang@intel.com>, "Alison Schofield" <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cxl/acpi: Verify CHBS length for CXL2.0
Message-ID: <20250404145331.00001559@huawei.com>
In-Reply-To: <7bbf602d-6900-4179-9737-efeb40e1566f@fujitsu.com>
References: <20250326074450.937819-1-lizhijian@fujitsu.com>
	<67e4c9aaedd08_138d3294ca@iweiny-mobl.notmuch>
	<1ed912df-42c7-4319-8765-3167963df7b3@fujitsu.com>
	<67e5544237027_13cb29432@dwillia2-mobl3.amr.corp.intel.com.notmuch>
	<7bbf602d-6900-4179-9737-efeb40e1566f@fujitsu.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 28 Mar 2025 04:15:13 +0000
"Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com> wrote:

> On 27/03/2025 21:36, Dan Williams wrote:
> > Zhijian Li (Fujitsu) wrote:  
> >>
> >>
> >> On 27/03/2025 11:44, Ira Weiny wrote:  
> >>> Li Zhijian wrote:  
> >>>> Per CXL Spec r3.1 Table 9-21, both CXL1.1 and CXL2.0 have defined their
> >>>> own length, verify it to avoid an invalid CHBS  
> >>>
> >>>
> >>> I think this looks fine.  But did a platform have issues with this?  
> >>
> >> Not really, actually, I discovered it while reviewing the code and
> >> CXL specification.
> >>
> >> Currently, this issue arises only when I inject an incorrect length
> >> via QEMU environment. Our hardware does not experience this problem.
> >>
> >>  
> >>> Does this need to be backported?  
> >> I remain neutral :)  
> > 
> > What does the kernel do with this invalid CHBS from QEMU? I would be
> > happy to let whatever bad effect from injecting a corrupted CHBS just
> > happen because there are plenty of ways for QEMU to confuse the kernel
> > even if the table lengths are correct.
> > 
> > Unless it has real impact I would rather not touch the kernel for every
> > possible way that QEMU can make a mistake.  
> 
> 
> 
> Thank you for the feedback.
> 
> If your earlier comments were specifically about ***backporting*** this patch,
> I agree there might not be an urgent need for that.
> 
> However, regarding the discussion on whether this patch should be accepted
> upstream, TBH, I believe it is necessary.
> 
> 1. The **CXL Specification (r3.1, Table 9-21)** explicitly defines `length`
> requirements for CHBS in both CXL 1.1 and CXL 2.0 cases. Failing to
> validate this field against the spec risks misinterpretation of invalid
> configurations.
> 
> 2. As mentioned in section **2.13.8** of the *CXL Memory Device Software Guide (Rev 1.0)*,
> It's recommended to verify the CHBS length.
> 
> While the immediate impact might be limited to edge cases (e.g., incorrect QEMU configurations),
> upstreaming this aligns the kernel with spec-mandated checks and improves
> robustness for future use cases.
> 
> [1] https://cdrdv2-public.intel.com/643805/643805_CXL_Memory_Device_SW_Guide_Rev1_1.pdf

Just to check - are we talking hacked QEMU or some configuration of QEMU that
can generate the wrong length?

Jonathan

> 
> 
> > 
> > I.e. if it was a widespread problem that affected multiple QEMU users by
> > default then maybe. Just your local test gone awry? Maybe not  

