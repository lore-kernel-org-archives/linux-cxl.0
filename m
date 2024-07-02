Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ACB026AE4;
	Tue,  2 Jul 2024 15:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719935638; cv=none; b=q8Kqdhn8CHeLETk5LfxxurOU3jAGGL5AwTq+EZWzhonkXkTeSOyfqIh7szp+GJqJDDDUkJrplOJb4zxw0eTYqXdPyC/VM9ObEuav6ywFT4FtpgMAQl+JD+CPxqIEhsjtUhFkzthjWlqXlG1tTtGJTHjB7jOEDh9C4i2STF0n+2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719935638; c=relaxed/simple;
	bh=tbEB5y4YiyR4kUelXRyJ2OIV+l3q1HZubohZF3UN4T4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qyu419p+SBUgg7J4u2vUNyR5WYKAGFr3a7a5+RWbBECiCiGBYXwhI1YqGZMAEbG5YysOZgedRmZlwDa87UxRRQc/73NYf72jxOyOnUQy7XdsdyeFlAsH6z/i0bYqIElizleb8nDilVC1JsBzWUbsOvuvq9sIqvDYNbsnbCQHfDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WD6r42R60z6J6jS;
	Tue,  2 Jul 2024 23:52:52 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 4349C140B55;
	Tue,  2 Jul 2024 23:53:53 +0800 (CST)
Received: from localhost (10.203.174.77) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 2 Jul
 2024 16:53:52 +0100
Date: Tue, 2 Jul 2024 16:53:51 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Terry Bowman <Terry.Bowman@amd.com>
CC: <dan.j.williams@intel.com>, <ira.weiny@intel.com>, <dave@stgolabs.net>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>, <ming4.li@intel.com>,
	<vishal.l.verma@intel.com>, <jim.harris@samsung.com>,
	<ilpo.jarvinen@linux.intel.com>, <ardb@kernel.org>,
	<sathyanarayanan.kuppuswamy@linux.intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <Yazen.Ghannam@amd.com>,
	<Robert.Richter@amd.com>
Subject: Re: [RFC PATCH 6/9] cxl/pci: Add trace logging for CXL PCIe port
 RAS errors
Message-ID: <20240702165351.00004abb@Huawei.com>
In-Reply-To: <550358f7-66d0-441c-abd9-f8edce9a5eb1@amd.com>
References: <20240617200411.1426554-1-terry.bowman@amd.com>
	<20240617200411.1426554-7-terry.bowman@amd.com>
	<20240620135332.000053f5@Huawei.com>
	<550358f7-66d0-441c-abd9-f8edce9a5eb1@amd.com>
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
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon, 24 Jun 2024 10:53:51 -0500
Terry Bowman <Terry.Bowman@amd.com> wrote:

> Hi Jonathan,
> 
> I added responses inline below.
> 
> On 6/20/24 07:53, Jonathan Cameron wrote:
> > On Mon, 17 Jun 2024 15:04:08 -0500
> > Terry Bowman <terry.bowman@amd.com> wrote:
> >   
> >> The cxl_pci driver uses kernel trace functions to log RAS errors for
> >> endpoints and RCH downstream ports. The same is needed for CXL root ports,
> >> CXL downstream switch ports, and CXL upstream switch ports.
> >>
> >> Add RAS correctable and RAS uncorrectable trace logging functions for
> >> CXL PCIE ports.
> >>
> >> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> >> ---
> >>  drivers/cxl/core/trace.h | 34 ++++++++++++++++++++++++++++++++++
> >>  1 file changed, 34 insertions(+)
> >>
> >> diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
> >> index e5f13260fc52..5cfd9952d88a 100644
> >> --- a/drivers/cxl/core/trace.h
> >> +++ b/drivers/cxl/core/trace.h
> >> @@ -48,6 +48,23 @@
> >>  	{ CXL_RAS_UC_IDE_RX_ERR, "IDE Rx Error" }			  \
> >>  )
> >>  
> >> +TRACE_EVENT(cxl_port_aer_uncorrectable_error,
> >> +	TP_PROTO(struct device *dev, u32 status),  
> > 
> > By comparison with existing code, why no fe or header
> > log?  Don't exist for ports for some reason?
> > Serial number of the port might also be useful.
> >   
> 
> The AER FE and header are the same for ports and the logging 
> needs to be added here.
> 
> There is no serial number for the ports.
Why not? At least for switch USP there might be (actually
I believe there can be for pretty much anything but there
are rules on them matching in switch funcitons).

J

> 
> Regards,
> Terry
