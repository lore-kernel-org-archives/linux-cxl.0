Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA921A294
	for <linux-cxl@vger.kernel.org>; Tue,  9 Sep 2025 15:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757430502; cv=none; b=Wfe+EI1VwPYe4qIaZTLK4tj1eFTGl3/2cHaNq7uY1SvBfsJGcPtLPPyh60nE8gtpefmSQPhzc++88vA9j0YfNKpGfsw4QZzCmaNakXMKM8CCeSxttPB/ynhQ6xbNn5c2+K+RC4iSWgvUcN99uSaMz/pbxFNImwYXQKAT5b+MRtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757430502; c=relaxed/simple;
	bh=Pk6BrZVvdJEM/jn6US2oaU7Rs+WokLALJMI1/rSlWFY=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bfr+GhlAGhnAdxmJEoM4ElE8Sh3RXMaKn+mwrjx7t1F4mqC5Ry0W6HGmsSThzyy9+6+D7HdUGuFOO98ZWikJo13IOaFkPWUrDsNaQoobuEAFuXseqKksIktSPP4kdUMMsPX6DAxUbnL6vITuC5jr4VqcDgnOEPS3/VZB7nWVV6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cLnC53YBDz6FH48;
	Tue,  9 Sep 2025 23:03:45 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 106E6140279;
	Tue,  9 Sep 2025 23:07:53 +0800 (CST)
Received: from localhost (10.203.177.15) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 9 Sep
 2025 17:07:52 +0200
Date: Tue, 9 Sep 2025 16:07:51 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Arpit Kumar <arpit1.kumar@samsung.com>
CC: <qemu-devel@nongnu.org>, <gost.dev@samsung.com>,
	<linux-cxl@vger.kernel.org>, <dave@stgolabs.net>, <vishak.g@samsung.com>,
	<krish.reddy@samsung.com>, <a.manzanares@samsung.com>,
	<alok.rathore@samsung.com>, <cpgs@samsung.com>
Subject: Re: [PATCH v3 1/2] hw/cxl: Refactored Identify Switch Device & Get
 Physical Port State
Message-ID: <20250909160751.000025e3@huawei.com>
In-Reply-To: <20250908134856.2fexpkb2m4ztxwcn@test-PowerEdge-R740xd>
References: <20250904131904.725758-1-arpit1.kumar@samsung.com>
	<CGME20250904131933epcas5p2ab29fa060d8a7df32a222aad740fedc6@epcas5p2.samsung.com>
	<20250904131904.725758-2-arpit1.kumar@samsung.com>
	<20250905165953.00006c3c@huawei.com>
	<20250908134856.2fexpkb2m4ztxwcn@test-PowerEdge-R740xd>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 8 Sep 2025 19:18:56 +0530
Arpit Kumar <arpit1.kumar@samsung.com> wrote:

> On 05/09/25 04:59PM, Jonathan Cameron wrote:
> >On Thu,  4 Sep 2025 18:49:03 +0530
> >Arpit Kumar <arpit1.kumar@samsung.com> wrote:
> >  
> >> -Storing physical ports info during enumeration.
> >> -Refactored changes using physical ports info for
> >>  Identify Switch Device (Opcode 5100h) & Get Physical Port State
> >>  (Opcode 5101h) physical switch FM-API command set.
> >>
> >> Signed-off-by: Arpit Kumar <arpit1.kumar@samsung.com>  
> >Hi Arpit,
> >
> >A few minor things inline.   Biggest one is making sure
> >to namespace the defines which is quite challenging to do
> >here without a really long name.
> >
> >Jonathan
> >  
> Hi Jonathan,
> Thanks for the review! Will update the changes in next 
> iteration v4 of the patch-set.

> >> -        port->connected_device_cxl_version = 0x2;
> >> +        memcpy(&out->ports[i], &(pp->pports.pport_info[pn]),
> >> +               sizeof(CXLPhyPortInfo));
> >>      }
> >> -  
> >
> >That's a stray change that shouldn't be here.

I wasn't clear enough. I just meant that final line removal, not the rest
of the code! Sorry for confusion.

> >  
> Correct me if I am wrong but the current initializations for the ports are
> moved to cxl_set_port_type(), hence this might appear stray in this case due
> to eliminations but this is with respect to the response payload of
> cmd_get_physical_port_state() so seems apt.
> However, one change required would be to move: out->num_ports = in->num_ports; after
> the below for loop as it validates the port_id's:
>      for (i = 0; i < in->num_ports; i++) {
>          int pn = in->ports[i];
> 
>          if (pp->pports.pport_info[pn].port_id != pn) {
>              return CXL_MBOX_INVALID_INPUT;
>          }
>          memcpy(&out->ports[i], &(pp->pports.pport_info[pn]),
>                 sizeof(CXLPhyPortInfo));
>      }


