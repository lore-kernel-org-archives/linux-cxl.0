Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526993B0AFC;
	Mon, 23 Mar 2026 17:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774288729; cv=none; b=T6XU+j4LpKPY/m+jO9vWTf87Xz+mK2T3e+xVXrUaiUViGYbyzlrNRat5vwqMJ/nyL3jzLjqH5oizLZnfHW9eJtyVtaouyeJiAG/XOoBs93IkOeW4QzFwhCcBvlJGVC/fWGKk/xLUI90E6pEy79W9QasWK2O5cILiAR2L0CZ6sIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774288729; c=relaxed/simple;
	bh=Mb+SIuW9Fa+ejB1UnS6CSc1tTM3N4xMZSXDq6VHHDfc=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gbrJElsV6a6c/AquEAk7vVKSTP40/0UkvFD+lQ6y53z/Xqx1eUHwJGpHUQsH2wL9t1HAKK0pTxd3GadzZ78EFhCsfJGkB1fr1g+ci7A0XWuW3NWVYBq20HZGVM0qt3o6cditgJIcR/WRe1Jk2opSRvwcUctg5/78lLOdyPovy/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4ffgrw5DsNzJ468G;
	Tue, 24 Mar 2026 01:58:40 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 5692F4056A;
	Tue, 24 Mar 2026 01:58:46 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 23 Mar
 2026 17:58:45 +0000
Date: Mon, 23 Mar 2026 17:58:44 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Gregory Price <gourry@gourry.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<kernel-team@meta.com>, <dave@stgolabs.net>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>
Subject: Re: [PATCH v4 1/3] cxl/core/region: move pmem region driver logic
 into region_pmem.c
Message-ID: <20260323175844.000073cf@huawei.com>
In-Reply-To: <acFgpwOgw5glyHsY@gourry-fedora-PF4VCD3F>
References: <20260322131638.3636725-1-gourry@gourry.net>
	<20260322131638.3636725-2-gourry@gourry.net>
	<20260323150847.00002e6a@huawei.com>
	<acFgpwOgw5glyHsY@gourry-fedora-PF4VCD3F>
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
 dubpeml500005.china.huawei.com (7.214.145.207)

On Mon, 23 Mar 2026 10:47:51 -0500
Gregory Price <gourry@gourry.net> wrote:

> On Mon, Mar 23, 2026 at 03:08:47PM +0000, Jonathan Cameron wrote:
> > On Sun, 22 Mar 2026 09:16:36 -0400
> > Gregory Price <gourry@gourry.net> wrote:
> >   
> > > +	scoped_guard(device, &cxl_nvb->dev) {
> > > +		if (cxl_nvb->dev.driver)
> > > +			rc = devm_add_action_or_reset(&cxl_nvb->dev,
> > > +					cxlr_pmem_unregister,
> > > +					cxlr_pmem);
> > > +		else
> > > +			rc = -ENXIO;  
> > As an example. If we happen to take this path... Where is the device_add() undone?  
> 
> In many other parts of the code, device_add is not rolled back either
> "for reasons", and - depending on who you talk to - this is
> intentional... for debugging?
> 
> I dunno, but the "hanging objects on failure" thing is common throughout
> cxl/ - :shrug:

If it were consistent maybe, but in other paths in this function it is cleaned up...
So I call bug even if it's one that is relatively unlikely to actually happen.

J
> 
> ~Gregory

