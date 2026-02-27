Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456B78462;
	Fri, 27 Feb 2026 13:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772198642; cv=none; b=lJoAd6ZifEOomYpj4X4eMDZpZI83ReK1A8emE1acDg5JVMZ5qMYc3FbinAevc6tUIGWynWe1sXdw3SlRMPi5wSSs5s7OJiSvHNV9Q7tPTLT5vz3VBH3EFpXkS7VLZw/33rhQh3gA73CsQLMciOoyafU7ytMKToxt8D+JjiID5TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772198642; c=relaxed/simple;
	bh=isgjJ4LDMWU37geIAUnqw4AK5tQqZR2Dy+soG2mGPBo=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d3/qd6m5ZEM+HhwFZZPPSA/RAPCWIkkBEr//U0Poyhro716gO75RRBVyLhlC6DfGTBtwA/Qkt9XBVBaSes8Pch1lq5zk+mupFusPWhTDdYRG6aGk27oaEufkRCDtasxFgvj/EM135cmSBPGarepsB2gqTuygIOhoslsFEfEImp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fMpt82xZBzHnGj1;
	Fri, 27 Feb 2026 21:23:12 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 52F8740572;
	Fri, 27 Feb 2026 21:23:58 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 27 Feb
 2026 13:23:57 +0000
Date: Fri, 27 Feb 2026 13:23:56 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Alison Schofield <alison.schofield@intel.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, <dan.j.williams@intel.com>,
	<vishal.l.verma@intel.com>, <dave.jiang@intel.com>,
	<akpm@linux-foundation.org>, <nvdimm@lists.linux.dev>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Ben Cheatham
	<benjamin.cheatham@amd.com>
Subject: Re: [PATCH v2] dax/kmem: account for partial dis-contiguous
 resource upon removal
Message-ID: <20260227132356.00005c94@huawei.com>
In-Reply-To: <aZ_TlK4r41P0xBDO@aschofie-mobl2.lan>
References: <20260223201516.1517657-1-dave@stgolabs.net>
	<aZ_TlK4r41P0xBDO@aschofie-mobl2.lan>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Wed, 25 Feb 2026 21:01:08 -0800
Alison Schofield <alison.schofield@intel.com> wrote:

> On Mon, Feb 23, 2026 at 12:15:16PM -0800, Davidlohr Bueso wrote:
> > When dev_dax_kmem_probe() partially succeeds (at least one range
> > is mapped) but a subsequent range fails request_mem_region()
> > or add_memory_driver_managed(), the probe silently continues,
> > ultimately returning success, but with the corresponding range
> > resource NULL'ed out.
> > 
> > dev_dax_kmem_remove() iterates over all dax_device ranges regardless
> > of if the underlying resource exists. When remove_memory() is
> > called later, it returns 0 because the memory was never added which
> > causes dev_dax_kmem_remove() to incorrectly assume the (nonexistent)
> > resource can be removed and attempts cleanup on a NULL pointer.  
> 
> Do you have a failure signature w Call Trace to paste here?
> If not, maybe just insert the expected signature for grepping:
> "BUG: unable to handle kernel NULL pointer dereference"
> 
> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
