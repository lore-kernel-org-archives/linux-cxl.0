Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1AB6CC0A
	for <linux-cxl@vger.kernel.org>; Thu, 29 Feb 2024 17:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709227589; cv=none; b=KVn+YcJqLs8TX3qP4QWIg/M9OhYSky9S4V/+X8Zu+XlssSk+Gd3RBzgYx4WPa2soc/omtxB535yHMvzBPwDheBCmNxhDdkLZUofUobVvQWPk/yX80D5fi+l6QPWK/HrZjSqsxFcqy8oEhfzOkli0sLr93bawf0g39+GVMc8FZlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709227589; c=relaxed/simple;
	bh=denkJb/Q1M7SrfW/OMeZnqtS9NiFDp1ZdS59ZCyYtkw=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kd3TCd3/vbKPfSIcFK+cpT3sX8oOpHskxBNCbhoBhp66OXFpARksBwfoReef1Lc3dE8y6zwtSSXILHrfCUTl/4JoNKJk2VJHOSq1bdVJ1/Fuy2mmyX3v1rhLU0n2qTamH0Fc6bVXw60E2sW0oa6WdB3aI380MDasc867x93PN8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Tlyhp6cpKz67KdR;
	Fri,  1 Mar 2024 01:22:34 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id C3D97140CF4;
	Fri,  1 Mar 2024 01:26:02 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 29 Feb
 2024 17:25:48 +0000
Date: Thu, 29 Feb 2024 17:25:47 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <dave@stgolabs.net>
Subject: Re: [PATCH 2/2] cxl: Add checks to access_coordinate calculation to
 fail missing data
Message-ID: <20240229172547.0000344e@Huawei.com>
In-Reply-To: <65dfd36d990b6_1138c729463@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240229002542.634982-1-dave.jiang@intel.com>
	<20240229002542.634982-2-dave.jiang@intel.com>
	<65dfd137a1406_1138c7294dd@dwillia2-xfh.jf.intel.com.notmuch>
	<9a20ce22-5910-418e-b13a-2312880e2400@intel.com>
	<65dfd36d990b6_1138c729463@dwillia2-xfh.jf.intel.com.notmuch>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed, 28 Feb 2024 16:44:29 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> Dave Jiang wrote:
> > 
> > 
> > On 2/28/24 5:35 PM, Dan Williams wrote:  
> > > Dave Jiang wrote:  
> > >> Jonathan noted that when the coordinates for host bridge and switches
> > >> can be 0s if no actual data are retrieved and the calculation continues.
> > >> The resulting number would be inaccurate. Add checks to ensure that the
> > >> calculation would complete only if the numbers are valid.  
> > > 
> > > Similar comment as patch1. This smells like a fix, is this an urgent
> > > thing to get into v6.8, i.e. most configurations are busted without
> > > this, or is a nice to have fixup for a QEMU effect that may or may not
> > > show up in physical systems?  
> > 
> > This would only be an issue if the switches do not supply a proper
> > CDAT and/or if BIOS does not provide proper ACPI tables. I think it is
> > only experienced on QEMU currently. I'll add a fix tag if you think it
> > should be a fix.  
> 
> No, but please add that relevant clarification of impact to the
> changelog. It would have made it clear this is a nice to have thing for
> v6.9, nothing to worry about for v6.8.

Not seen in wild, but it might show up with a BIOS that reported
CXL root ports via Generic Ports (via a PCI handle in the SRAT entry)
rather than CXL Host Bridge (via an ACPI Handle int he SRAT entry).
The code doesn't yet support this case (which is fine) but it should
cleanly not support it rather than giving wrong numbers. There
are other fun corners like embedded CXL switches in the host where
the reporting will also be more 'creative'. I expect we will see
these eventually but not in first generation or two.

I 'think' this would be a reasonable system choice as there is nothing
to say that a CXL hostbridge doesn't have a bunch of root ports
(potentially on different dies) that have different host initiator
to port exit latency and bandwidth characteristics.

Whilst no known hardware. I don't think this is a FW bug case only.

Not a rush job though, fixes tag + 6.9 will be fine.

Jonathan
