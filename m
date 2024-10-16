Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED13209F59
	for <linux-cxl@vger.kernel.org>; Wed, 16 Oct 2024 14:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729090055; cv=none; b=ZO1ZAXLHDzwCYFxC2714NwIOrBkZrecF7d1wpXpF6CQ43v6aVYjkvn+iYQiuwGA9v4QoMMtRNaw0bgJAsqGagbTjjPLYflJEe3r1dBa3HVsbXEEVJVzi9bmSEMCgreroBSfcJAmpp1RFx35tc2zlmttIQtVIgb/7e3gQh2gh8bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729090055; c=relaxed/simple;
	bh=G6DYu+Ut6uImgxARAoTes7kQVehZ74s8+h6WJb1ZxhE=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uvyCyZ6LndV2L72+oAC4sPn0pry31s3zdk7S+38RTE/T4Estz68Wdy6dJk0Knzo037PcsI/8y3n37zRVPMi58YAuSrzQfxLgxHgrPZckntEmmp/KcjuogK3yC75nfBEaERihbsZvZl3hLd1U9obCl5LyySBp6bcRvj12pfbP/aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XTDGV6jthz6D9BK;
	Wed, 16 Oct 2024 22:42:58 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 0D6E71400DD;
	Wed, 16 Oct 2024 22:47:29 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 16 Oct
 2024 16:47:28 +0200
Date: Wed, 16 Oct 2024 15:47:27 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Alison Schofield <alison.schofield@intel.com>
CC: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>,
	<alejandro.lucero-palau@amd.com>, <dan.j.williams@intel.com>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>, <dave@stgolabs.net>,
	<fan.ni@samsung.com>, Alejandro Lucero <alucerop@amd.com>,
	<shiju.jose@huawei.com>
Subject: Re: [PATCH v4 2/3] cxl: Move mailbox related bits to the same
 context
Message-ID: <20241016154727.000027f8@Huawei.com>
In-Reply-To: <Zw1kr5-99J_nKPyl@aschofie-mobl2.lan>
References: <20240905223711.1990186-1-dave.jiang@intel.com>
	<20240905223711.1990186-3-dave.jiang@intel.com>
	<20241014155154.00001d5a@Huawei.com>
	<Zw1kr5-99J_nKPyl@aschofie-mobl2.lan>
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
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 14 Oct 2024 11:36:31 -0700
Alison Schofield <alison.schofield@intel.com> wrote:

> On Mon, Oct 14, 2024 at 03:51:54PM +0100, Jonathan Cameron wrote:
> > On Thu, 5 Sep 2024 15:35:46 -0700
> > Dave Jiang <dave.jiang@intel.com> wrote:
> >   
> > > Create a new 'struct cxl_mailbox' and move all mailbox related bits to
> > > it. This allows isolation of all CXL mailbox data in order to export
> > > some of the calls to external kernel callers and avoid exporting of CXL
> > > driver specific bits such has device states. The allocation of
> > > 'struct cxl_mailbox' is also split out with cxl_mailbox_create() so the
> > > mailbox can be created independently.
> > > 
> > > Reviewed-by: Fan Ni <fan.ni@samsung.com>
> > > Reviewed-by: Alejandro Lucero <alucerop@amd.com>
> > > Reviewed-by: Alison Schofield <alison.schofield@intel.com>
> > > Link: https://patch.msgid.link/20240724185649.2574627-2-dave.jiang@intel.com
> > > Signed-off-by: Dave Jiang <dave.jiang@intel.com>  
> > 
> > LGTM.
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > Note this is currently being carried in Shiju's RAS features set
> > as well.  What is the merge plan?  My preference is an immutable branch
> > that Borislav could pull into the EDAC tree and on which we can base
> > other stuff in CXL 
> > That is a branch based on 6.12-rc1 directly with an appropriate tag
> > that Shiju's patch set can refer to.  
> 
> 
> This set was merged in 6.12.
Ah. Shiju, seems you have an old base.  Fix that for next version of the
RAS features

> 
> > 
> > Thanks,
> > 
> > Jonathan  
> 
> 

