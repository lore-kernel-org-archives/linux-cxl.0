Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B455436DA1A
	for <linux-cxl@vger.kernel.org>; Tue, 24 Mar 2026 15:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774366366; cv=none; b=sxN8RhynxlzvXTFhqCdFwXFRykOu8r7NvhPqgvyBTORu3cyOYjx6XULcmevU2kOnYB41Fo5E+tAtELOP8oTm9BMyXPJ1RSLb3AYQolXT+FQrcluxn4u/FL7ZDxHVYr74ka3M5+w6Ex5jtJRGdWqOGeA6X9SdY6pVPMkBvAtobf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774366366; c=relaxed/simple;
	bh=hkD+hiqTWTHAJlUWjQomJq+j97kzfgKQd9Ia4HKf97o=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AZ5OPBEGdmmQi153HoBpsal2iYnYEY0bA60cuol1BX1uhA+PQnI0bRgLcEJ1/vlMhVW+sGm5xd+UT8b/KEhFFCFTcpP+M1iueQOpxwl4LaG/cSCcaRwyT/8u6cLQ5RFidl3QtT/XQH8T5rRMuu5+Ty1PKfJHSYaMjBCxSO7dCoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fgDYs67wgzJ46F1;
	Tue, 24 Mar 2026 23:32:33 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id E94814056E;
	Tue, 24 Mar 2026 23:32:40 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 24 Mar
 2026 15:32:40 +0000
Date: Tue, 24 Mar 2026 15:32:38 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Davidlohr Bueso <dave@stgolabs.net>
CC: <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>,
	<dongjoo.seo1@samsung.com>, <anisa.su@samsung.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [RFC PATCH 0/1] cxl: Media Operations
Message-ID: <20260324153238.0000750e@huawei.com>
In-Reply-To: <20260323204013.4010634-1-dave@stgolabs.net>
References: <20260323204013.4010634-1-dave@stgolabs.net>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500010.china.huawei.com (7.191.174.240) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Mon, 23 Mar 2026 13:40:12 -0700
Davidlohr Bueso <dave@stgolabs.net> wrote:

> Hello,
> 
> This implements support for Media Operation cmd. It is marked RFC because of these
> noteworthy points:
> 
>  (i) Sysfs interfaces. These changes implement 'security/zero' and multiplex
>      'security/sanitize' to allow dpa, len pairs for the range (no impact for
>      current usage as whole-device). This breaks the 1 value per file "rule",
>      and would be a first for drivers/cxl/*, so am I open to suggestions.     

Value is a vague sort of term.  It's one thing (an range) so seems fine to me.

>   
>  (ii) Background cmd handling semantics. Media operations are synchronous,
>       which for raged zeroing operations makes sense and for range sanitize

ranged

>       differs from the current async handling for whole-device, so user response
>       differs significantly, something I am not crazy about. Another downside
>       of this is that it exposes lock hold times to be user-controllable, but is
>       no different than what we do for fw. Fundamentally, users have the
>       responsibility to break up the work into sane ranges.

We could apply a limit on this and make that discoverable via another sysfs attribute.
So let userspace request in say 1Gig chunks.  Would have to check that the device
supports that granularity though.
I don't think there is anything in the spec today to let us query how long
something takes (which would be a better way to bound this).


> Further, this is
>       without considering abortable bg cmds[0], which, per-spec, are unsupported
>       today for media operations.
> 
> Tested with qemu + fixlets (https://lore.kernel.org/all/20260319184256.3762391-1-dave@stgolabs.net/)

I think those all landed upstream today and are getting pulled into qemu stable as well.

> 
> Applies against latest 'next' from cxl.git.
> 
> [0] https://lore.kernel.org/all/20250617193611.564668-1-dave@stgolabs.net/
> 
> Thanks!
> 
> Davidlohr Bueso (1):
>   cxl/mbox: Support Media Operation
> 
>  Documentation/ABI/testing/sysfs-bus-cxl |  31 +++-
>  drivers/cxl/core/mbox.c                 | 235 ++++++++++++++++++++++++
>  drivers/cxl/core/memdev.c               |  45 ++++-
>  drivers/cxl/cxlmem.h                    |  59 ++++++
>  drivers/cxl/pci.c                       |   4 +
>  5 files changed, 369 insertions(+), 5 deletions(-)
> 
> --
> 2.39.5
> 
> 

