Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE896275105
	for <linux-cxl@vger.kernel.org>; Tue, 20 May 2025 11:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747740421; cv=none; b=lMVtlQ2lVUzbG079dbf+i1KsdRmIn72qfUXbgtcosWKVY3ngMOVzwKwulfRiltEhWpZdXHWslYy/YgzWzacfbTHDn5WPwV176ot3Sh3/QjsvcnAYuShEICVXkpnU1d9sAd5NLxcl6CWEBeD0OytUPUflo0b7yEzFgV29JlXngww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747740421; c=relaxed/simple;
	bh=NEIXHskhpbqvF8dzmzBWXtEEnCUadi0jJ/OkRO2Qde8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aXfQQtDi3DabUKxxeUC40ixIn/ApKL91A+SrkLOfKjoQ28oxafYHmy5UOgHOWm2xlY3OSLnWVQ7fTiNrEdrBlC+OKSsZdKU+QEu6hj4AWHbd56iviOMUBKQ9XQ7NQ/vdcwccN/SS3LBvDEJrIRFPouB0cMG9hqxNdQKa4e3UTdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4b1sb20M2wz6M4sR;
	Tue, 20 May 2025 19:22:06 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id E2ADF1402FF;
	Tue, 20 May 2025 19:26:55 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 20 May
 2025 13:26:55 +0200
Date: Tue, 20 May 2025 12:26:53 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: Gregory Price <gourry@gourry.net>, <linux-cxl@vger.kernel.org>, "Dan
 Williams" <dan.j.williams@intel.com>, <dave@stgolabs.net>,
	<alison.schofield@intel.com>, <ira.weiny@intel.com>, <rrichter@amd.com>,
	<ming.li@zohomail.com>
Subject: Re: [PATCH v2 05/10] cxl: Defer hardware dport->port_id assignment
 and registers probing
Message-ID: <20250520122653.00007e7d@huawei.com>
In-Reply-To: <4ab4a497-e1e2-4e64-90dd-08c489cc52a7@intel.com>
References: <20250507004310.3536991-1-dave.jiang@intel.com>
	<20250507004310.3536991-6-dave.jiang@intel.com>
	<aCNopruv5rUV2PBr@gourry-fedora-PF4VCD3F>
	<4ab4a497-e1e2-4e64-90dd-08c489cc52a7@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500012.china.huawei.com (7.191.174.4) To
 frapeml500008.china.huawei.com (7.182.85.71)

  
> >> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> >> index a35fc5552845..4d840a6ef802 100644
> >> --- a/drivers/cxl/port.c
> >> +++ b/drivers/cxl/port.c  
> > ... snip ...  
> >>  	/* Cache the data early to ensure is_visible() works */
> >> @@ -69,24 +68,7 @@ static int cxl_switch_port_probe(struct cxl_port *port)
> >>  	if (rc < 0)
> >>  		return rc;
> >>    
> > ... snip ...  
> >> -	return -ENXIO;
> >> +	return 0;
> >>  }  
> > 
> > 	return devm_cxl_port_enumerate_dports(port);  
> 
> This was actually done on purpose. devm_cxl_port_enumerate_dports() returns the number of dports enumerated. So usually the return value is greater than 0. in drivers/base/dd.c, call_driver_probe() throws the return value into a switch() where any value not 0 are errors. So the probe() call would fail. Here we are intercepting the return value and return a 0 if it's positive. I got bitten here during this series's debug. I should add a comment and explain why.  

I'll ask a 'silly' follow up.  Why does devm_cxl_port_enumerate_dports()
return the number.  From a quick look does anyone use it?  If not
just change that as a precursor patch and allow this
tiny bit of code improvement.

> 
> 
> > 
> > 
> > ~Gregory  
> 
> 

