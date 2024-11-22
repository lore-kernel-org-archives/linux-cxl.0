Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B4C79FE
	for <linux-cxl@vger.kernel.org>; Fri, 22 Nov 2024 14:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732285055; cv=none; b=gTVY8T/G6TxwKoo+fAEROSh7/e3cK40rxMeemUbIiTnJAbC+jz0sNGuSjpclEfaYIJ5IasMM+4kE53FdN7ztOsyG3a/4IMRDntnHtMId8ihv16591vDOHEFLEiINlpKE1vSr/PIcpd1kfEj97jhvNGH4PwHAUAkXpKwQM0ecBQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732285055; c=relaxed/simple;
	bh=EDfXSJJHCkqcR7MTFoa/jAkAApLT+RR8BFq9lAhBoWc=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PRyxWHeE93w47Tg1jNXvjdur2y0zLEDDI6Aaw5HICCajvwMO77SItELYZZct/AtZ5h3Tr+G73lLp4FPS7xc9dlJRK/3OskRD3SblZ3OyhK9yws2PPDKdDlOtlh6oTIjhIWdQgC9cm52NWMsKlKRBFP7MtZ6vEEW+jcdRDblEXx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XvxxX6rv6z6L71V;
	Fri, 22 Nov 2024 22:17:04 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 83091140447;
	Fri, 22 Nov 2024 22:17:30 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 22 Nov
 2024 15:17:29 +0100
Date: Fri, 22 Nov 2024 14:17:28 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <dave@stgolabs.net>, <jgg@nvidia.com>,
	<shiju.jose@huawei.com>
Subject: Re: [RFC PATCH v2 07/20] cxl: Add Set Feature command support for
 user submission
Message-ID: <20241122141728.000062e7@huawei.com>
In-Reply-To: <9e3afbf8-80dd-480b-9735-ce8dcf8bbc75@intel.com>
References: <20241115212745.869552-1-dave.jiang@intel.com>
	<20241115212745.869552-8-dave.jiang@intel.com>
	<20241121174935.00003e2b@huawei.com>
	<9e3afbf8-80dd-480b-9735-ce8dcf8bbc75@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500009.china.huawei.com (7.191.174.84) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 21 Nov 2024 11:08:44 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> On 11/21/24 10:49 AM, Jonathan Cameron wrote:
> > On Fri, 15 Nov 2024 14:25:40 -0700
> > Dave Jiang <dave.jiang@intel.com> wrote:
> >   
> >> Add enumeration of Set Feature mailbox command for the kernel to recognize
> >> the command being passed in from user space.  
> > 
> > This looks unwise to make available on the ioctl.   
> 
> Do you mean the current memdev char dev ioctl? Maybe we can introduce a restricted_commands mask to block that on the legacy ioctl? Trying to make the two ioctl paths co-exist is a bit of a pain right now.
> 
Yes - I'd rather we didn't introduce new commands on the legacy ioctl
at all, but if we do keeping it to the definitely safe ones (GET_xxx etc)
would be better.

Another mask is a way to solve this, though feels like opt in is
going to be easier to maintain long term than opt out.
Mind you we can modify how exactly it is done later as not
critical yet.

Jonathan

> DJ
>  
> >   
> >>
> >> CXL spec r3.1 8.2.9.6.3 Set Feature (Opcode 0502h)
> >>
> >> The feature requested is identified by specific UUID.
> >>
> >> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> >> ---
> >>  drivers/cxl/core/mbox.c      | 1 +
> >>  include/uapi/linux/cxl_mem.h | 1 +
> >>  2 files changed, 2 insertions(+)
> >>
> >> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> >> index 4b9abf9a5b2b..739444d34130 100644
> >> --- a/drivers/cxl/core/mbox.c
> >> +++ b/drivers/cxl/core/mbox.c
> >> @@ -69,6 +69,7 @@ static struct cxl_mem_command cxl_mem_commands[CXL_MEM_COMMAND_ID_MAX] = {
> >>  	CXL_CMD(GET_TIMESTAMP, 0, 0x8, 0),
> >>  	CXL_CMD(GET_SUPPORTED_FEATURES, 0x8, CXL_VARIABLE_PAYLOAD, 0),
> >>  	CXL_CMD(GET_FEATURE, 0x15, CXL_VARIABLE_PAYLOAD, 0),
> >> +	CXL_CMD(SET_FEATURE, CXL_VARIABLE_PAYLOAD, 0, 0),
> >>  };
> >>  
> >>  /*
> >> diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_mem.h
> >> index 90dcb9723997..469dd481795f 100644
> >> --- a/include/uapi/linux/cxl_mem.h
> >> +++ b/include/uapi/linux/cxl_mem.h
> >> @@ -52,6 +52,7 @@
> >>  	___C(GET_SUP_LOG_SUBLIST, "Get Supported Logs Sub-List"),	  \
> >>  	___C(GET_SUPPORTED_FEATURES, "Get Supported Features"),		  \
> >>  	___C(GET_FEATURE, "Get Feature"),				  \
> >> +	___C(SET_FEATURE, "Set Feature"),				  \
> >>  	___C(MAX, "invalid / last command")
> >>  
> >>  #define ___C(a, b) CXL_MEM_COMMAND_ID_##a  
> >   
> 
> 

