Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8DE1C876F
	for <linux-cxl@vger.kernel.org>; Tue, 19 Nov 2024 11:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732016511; cv=none; b=i492+AfFWtFJEXxGL6db5xjYzDukemroxbgENqjLn+wjoIerquAtOl2jFf7XjeHekpQ5hXpBYjHRUmjcYxUNAQJ6mkh/5DatYuECudcayz3q6ycQiH4IQX/IVfho24WLpgWuktAQeW9LBK0rlnxEQa7NPULAM3nVnS9EpWa27QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732016511; c=relaxed/simple;
	bh=+6lVw5fwdIMLqmPLToLC6DxFxua7ewSgSy7hUS8piTQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uU5NpdLQ/SXSfEoTc5bRGo1j11ZNC3dTGYF5MDVethnPhuXDtm/D1c6svadyINmTpm1iPyUQhhxgMTUTMh2giLacbF6ELkoNKzUyaZb23x249Xz1TqWWKW6EwtKNoEq9+CwEGsq8rjgPPkSOilC9mPU1v5++s0UO0ZuOqojmWBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Xt2Yh4dtwz6K7KQ;
	Tue, 19 Nov 2024 19:38:16 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 95307140C72;
	Tue, 19 Nov 2024 19:41:44 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 19 Nov
 2024 12:41:43 +0100
Date: Tue, 19 Nov 2024 11:41:42 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <dave@stgolabs.net>, <jgg@nvidia.com>,
	<shiju.jose@huawei.com>
Subject: Re: [RFC PATCH 10/13] fwctl/cxl: Add support for fwctl RPC command
 to enable CXL feature commands
Message-ID: <20241119114142.0000392a@huawei.com>
In-Reply-To: <240c2264-b0f2-4e8b-b6e5-89c4317d0ba0@intel.com>
References: <20240718213446.1750135-1-dave.jiang@intel.com>
	<20240718213446.1750135-11-dave.jiang@intel.com>
	<20240729122907.0000540a@Huawei.com>
	<240c2264-b0f2-4e8b-b6e5-89c4317d0ba0@intel.com>
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

On Wed, 13 Nov 2024 08:41:15 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> On 7/29/24 4:29 AM, Jonathan Cameron wrote:
> > On Thu, 18 Jul 2024 14:32:28 -0700
> > Dave Jiang <dave.jiang@intel.com> wrote:
> >   
> >> fwctl provides a fwctl_ops->fw_rpc() callback in order to issue ioctls
> >> to a device. The cxl fwctl driver will start by supporting the CXL
> >> feature commands: Get Supported Features, Get Feature, and Set Feature.  
> > 
> > I'll come back to this in reply to the cover letter, but this is
> > problematic because some of those features will almost certainly be
> > covered by standard kernel drivers and if Set Feature is enabled
> > those drivers will need to be hardened against the state mysteriously
> > changing under them.  
> 
> Do we need to have an exclusive_features mask just like exclusive_cmds to block kernel managed features like RAS? That may be the best way to deal with things happening behind kernel's back.

Agreed. Something along those lines should work.
My understandin is we are fine 'breaking' backwards compatibility in
FWCTL interfaces if we decide later that something isn't safe for it to access.

Mind you we can probably make a reasonable starting guess + restrict anything
in the non-vendor ranges that isn't yet defined.
Things get messier for defacto standards if any of them surface as we may
have kernel support upstream for those in the future but not initially.

> 
> > 
> > This corner is the bit that worries me most about fwctl in general.
> > Anyhow, one for the cover letter / policy discussion not deep
> > in the patch series.  
> 
> Need to add a documentation patch and maybe we can put policies and rules in there?

Even better.

Jonathan

