Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC26EED6
	for <linux-cxl@vger.kernel.org>; Mon, 25 Nov 2024 18:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732558012; cv=none; b=boDDOI8gC9fgNUhalfjlTe68WqeNLigqVTfm9mf1dwL5TSiycaM1y1RQsnR/HPODLZqSc9na+ANTCvSot71ESOtVDRjUO6zLqQF0GXhqWDf50WC+ajnmkY8aCM/vqEuT1Dk8R3V5jhAsJ1DViIIIiHAcxrTDBq+CfiOmlYSIaWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732558012; c=relaxed/simple;
	bh=89YKiLFmRFN/2f1CDualZ23GVvdkZLXHWm4XxnBFNLQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=njzw9iF2/VqifaaeovANoGyg9AlnuZACw7bHnSnqKeMUPWaIF2G0H+7Kg2W2HDtVQLdzuzkbWTiOZbpzUHAwbYfCUO9IjgavwPHikM+SfOvhlgU3PTajiJIstZTQP5nztZWG5TgSsy2nFq6CM9M+kGts3Huwk4P8zxwagFolF00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Xxtpp6Yhhz6K6FS;
	Tue, 26 Nov 2024 02:02:58 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 59B0E1400CB;
	Tue, 26 Nov 2024 02:06:46 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 25 Nov
 2024 19:06:45 +0100
Date: Mon, 25 Nov 2024 18:06:44 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <dave@stgolabs.net>, <jgg@nvidia.com>,
	<shiju.jose@huawei.com>
Subject: Re: [RFC PATCH v2 10/20] fwctl/cxl: Add support for get driver
 information
Message-ID: <20241125180644.00007122@huawei.com>
In-Reply-To: <98274806-3d5e-47c9-be84-52035cb3ffd5@intel.com>
References: <20241115212745.869552-1-dave.jiang@intel.com>
	<20241115212745.869552-11-dave.jiang@intel.com>
	<20241121181157.00006eee@huawei.com>
	<98274806-3d5e-47c9-be84-52035cb3ffd5@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100010.china.huawei.com (7.191.174.197) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 22 Nov 2024 16:22:25 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> On 11/21/24 11:11 AM, Jonathan Cameron wrote:
> > On Fri, 15 Nov 2024 14:25:43 -0700
> > Dave Jiang <dave.jiang@intel.com> wrote:
> >   
> >> Add definition for fwctl_ops->info() to return driver information. The
> >> function will return the number of device mailbox commands supported by the
> >> fwctl char device.
> >>
> >> Signed-off-by: Dave Jiang <dave.jiang@intel.com>  
> > Few minor things inline
> > 
> > Jonathan  
> >> ---
> >> v2:
> >> - Change driver info to report number of commands supported by the driver and device.
> >> ---
> >>  drivers/cxl/core/mbox.c  | 46 ++++++++++++++++++++++++++++++++++++++++
> >>  drivers/fwctl/cxl/cxl.c  | 23 ++++++++++++++++++--
> >>  include/cxl/cxl.h        |  2 ++
> >>  include/cxl/mailbox.h    |  1 +
> >>  include/uapi/fwctl/cxl.h | 22 +++++++++++++++++++
> >>  5 files changed, 92 insertions(+), 2 deletions(-)
> >>  create mode 100644 include/uapi/fwctl/cxl.h
> >>
> >> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> >> index 12758e763650..f464eb42f08a 100644
> >> --- a/drivers/cxl/core/mbox.c
> >> +++ b/drivers/cxl/core/mbox.c
> >> @@ -118,6 +118,14 @@ static u8 security_command_sets[] = {
> >>  	0x46, /* Security Passthrough */
> >>  };
> >>  
> >> +#define FWCTL_CXL_MAX_COMMANDS 3  
> > 
> > Use this to size the array? Will let us know if it gets
> > out of sync.
> >   
> >> +/* Command set that is allowed with FWCTL-CXL */
> >> +static u16 fwctl_command_sets[] = {
> >> +	CXL_MBOX_OP_GET_SUPPORTED_FEATURES,
> >> +	CXL_MBOX_OP_GET_FEATURE,
> >> +	CXL_MBOX_OP_SET_FEATURE,
> >> +};
> >> +  
> >   
> >>  static void *cxlctl_fw_rpc(struct fwctl_uctx *uctx, enum fwctl_rpc_scope scope,
> >> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> >> index 6bfd7942a3f7..d0939e3bcbc0 100644
> >> --- a/include/cxl/cxl.h
> >> +++ b/include/cxl/cxl.h
> >> @@ -3,6 +3,8 @@
> >>  #ifndef __CXL_GLOBAL_H__
> >>  #define __CXL_GLOBAL_H__
> >>  
> >> +#include <linux/device.h>  
> > 
> > Why in this patch?  
> 
> I got a 0-day report with this patch complaining about missing 'struct device' definition on some weird arch. May be a current issue that needs a standalone fix.


Hmm. struct device only needs a forward definition but not so much for
struct device_driver.

Pull this back to patch 8 I think.

>  
> >   
> >> +
> >>  struct cxl_driver {
> >>  	const char *name;
> >>  	int (*probe)(struct device *dev);  
> >   
> 
> 

