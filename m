Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625CE2F24
	for <linux-cxl@vger.kernel.org>; Thu, 31 Jul 2025 14:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753971648; cv=none; b=a6i2vXAP/rrD4xUvgfvKvQ9HxcsTFpkATDDaB34tjkDJHRPrA6YJ31SVlvxflvI3WL7XHgYvd5qPSo759BIoYViVRG6veMRzBbPzbE2W+Sem92cLho5Xj+m6TZ3O3iSPsUUNWLM4MFAYN/yPdcP0kcjXuSnDbE9bndZkyDPksXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753971648; c=relaxed/simple;
	bh=Im5eujgMO2CBiq8OnVZ84e+stUrlYyqyDmDbbcF7eQ4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hbOI5OHIgc4xWGTE5O9Z1EKbkP6luDRuVBinoM2PawK9ZeOudH69Qp6mE3XXA6D2DIwxQvwGNod3jlmCCBmeVUwkLMUJCDnARA2KKaFQMNrKRhaBMPocgaIcJWcpeFVm91ytRcNluXDYjYEwXggC3nByQsVa8SbLFuACxGCOe78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4btB603yxfz6D9j0;
	Thu, 31 Jul 2025 22:19:04 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 2534A1402F2;
	Thu, 31 Jul 2025 22:20:42 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 31 Jul
 2025 16:20:41 +0200
Date: Thu, 31 Jul 2025 15:20:39 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Davidlohr Bueso <dave@stgolabs.net>
CC: <ira.weiny@intel.com>, <alucerop@amd.com>, <a.manzanares@samsung.com>,
	<linux-cxl@vger.kernel.org>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH RFC -qemu 0/2] hw/cxl: Support Back Invalidation
Message-ID: <20250731152039.00005fa2@huawei.com>
In-Reply-To: <20250729165441.1898150-1-dave@stgolabs.net>
References: <20250729165441.1898150-1-dave@stgolabs.net>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 29 Jul 2025 09:54:39 -0700
Davidlohr Bueso <dave@stgolabs.net> wrote:

> Hello,
> 
> The following allows support for component basic back invalidation discovery
> and config, by exposing the BI routing table and decoder registers. Instead
> of going the type2[1] route, this series proposes adding support for type3
> hdm-db, which allows a more direct way of supporting BI in qemu.
> 
> Caveats/RFC: Just as in Ira's series, there is the question about the whole topology
> allowing BI, not just the endpoint device. That series left the rest of topology
> (dsp, rp) non-BI capable, for which any kernel counterpart testing would fail
> when using type2, but at the same time is also consistent with flit 68B when not
> using a type2 device.
> 
> This series blindly enables BI capabilities for ports even when no type3 hdm-db
> is being used. While it is handy, it is inconsistent with the driver seeing 68B
> and the BI registers in such cases. I've been going back and forth with possible
> workarounds, but don't really have a good answer, and this will ultimately
> affect not only BI but all goodies that come with 256B flit. Any suggestions welcome.

Hi Davidlohr,

We probably need to make this work like link width. That would push the control
to the downstream port side and effectively 'trains' the link (really simple negotiation
of capabilities). I don't think we care about more capable device plugged into
a less capable upstream port, so a simple property for the type 3 device (and switch USP)
should do the job.  If we want to do the optimized flits we'll need a little more.

So in short, make RP and downstream port always BI and 256bit flit capable, but
'fake' the training so if they are plugged into a EP or switch USP they report
whatever that was configured for. 

So alongside your hdm-db property in patch 2, have a 256bit-flit property.
Both of those have to apply for type 3 and the switch USP.
Then we sanity check the combination works (i.e. hdm-db only if 256 bit flit)

I think we need this fine grained control because we want to poke the corners
where only parts of the tree are BI capable.

So, precursor patch to enable 256bit flit mode then this stuff on top.

Jonathan



> 
> Patch 1: is lifted from Ira's series with some small (but non-trivial) changes.
> Patch 2: adds BI decoder/rt register support.
> 
> Testing wise, this has passed relevant kernel side BI register IO flows and
> setup.
> 
> Applies against branch 'origin/cxl-2025-07-03' from the jic23 repository.
> 
> Thanks!
> 
> [1] https://lore.kernel.org/linux-cxl/20230517-rfc-type2-dev-v1-0-6eb2e470981b@intel.com/
> 
> Davidlohr Bueso (1):
>   hw/cxl: Support Type3 HDM-DB
> 
> Ira Weiny (1):
>   hw/cxl: Refactor component register initialization
> 
>  hw/cxl/cxl-component-utils.c   | 206 ++++++++++++++++++++++++---------
>  hw/mem/cxl_type3.c             |   5 +-
>  include/hw/cxl/cxl_component.h |  87 +++++++++++---
>  include/hw/cxl/cxl_device.h    |   3 +
>  4 files changed, 232 insertions(+), 69 deletions(-)
> 
> --
> 2.39.5
> 

