Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6772797AF
	for <linux-cxl@vger.kernel.org>; Wed, 20 Aug 2025 08:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755680145; cv=none; b=UZFOJi8Q231QWPwS70tee3dZ7MP17eLqTDIFMK1xvWjNl4V8LY59HA4qI6vg2lTFPsrYU0fbxqdGA2dyRnhwT6dmGXIMY/SRLQ/c4NB4ynel+JN9G0JZ7sol0OqZXph0Mdr659RRWw4IS7lFmNzk5tR/FaEifhcIUrrW6aSZg3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755680145; c=relaxed/simple;
	bh=c82gNOJJ/2r5pJVQAh3Akhg1A67xs/yZJKNChzLcsrs=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cTF830AqYXIgi23fQq4er9DJhhraF7LY0kwGE/80IlbW4YETyzPcqJ8YD/UixPUyA2urKg7qKG8WRBPwxz9wcEihLOFoEHntjOo/1tUVPpk+riOExJcyWqZHOSxriPLykHZeeuFFA5cqZIXG46sfg03y0Wu1IN6LUwIz+ZQuVwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4c6KzL5v0Xz6GD5p;
	Wed, 20 Aug 2025 16:55:26 +0800 (CST)
Received: from frapeml500003.china.huawei.com (unknown [7.182.85.28])
	by mail.maildlp.com (Postfix) with ESMTPS id 89AA51402FF;
	Wed, 20 Aug 2025 16:55:39 +0800 (CST)
Received: from localhost (10.203.177.99) by frapeml500003.china.huawei.com
 (7.182.85.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 20 Aug
 2025 10:55:37 +0200
Date: Wed, 20 Aug 2025 09:55:34 +0100
From: Alireza Sanaee <alireza.sanaee@huawei.com>
To: Ben Cheatham <Benjamin.Cheatham@amd.com>
CC: <linux-cxl@vger.kernel.org>
Subject: Re: [RFC PATCH 15/18] cxl/cache: Implement Cache ID Decoder
 programming
Message-ID: <20250820095534.00001f2f.alireza.sanaee@huawei.com>
In-Reply-To: <20250819144445.00000b1b.alireza.sanaee@huawei.com>
References: <20250812212921.9548-1-Benjamin.Cheatham@amd.com>
	<20250812212921.9548-16-Benjamin.Cheatham@amd.com>
	<20250819144445.00000b1b.alireza.sanaee@huawei.com>
Organization: Huawei
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 frapeml500003.china.huawei.com (7.182.85.28)

On Tue, 19 Aug 2025 14:44:45 +0100
Alireza Sanaee <alireza.sanaee@huawei.com> wrote:

> On Tue, 12 Aug 2025 16:29:18 -0500
> Ben Cheatham <Benjamin.Cheatham@amd.com> wrote:
> 
> > The CXL Cache ID Decoder capability is an optional capability
> > present on CXL downstream switch and CXL-enabled PCIe Root ports.
> > This capability is required for having multiple CXL.cache enabled
> > devices under the same port (CXL 3.2 8.2.4.29).
> > 
> > Implement cache id decoder programming. Validate the configuration
> > in the case BIOS already programmed the id(s).
> > 
> > Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
> > ---
> >  drivers/cxl/cache.c     |   4 ++
> >  drivers/cxl/core/port.c | 109
> > ++++++++++++++++++++++++++++++++++++++++ drivers/cxl/cxl.h       |
> > 14 ++++++ drivers/cxl/cxlcache.h  |   3 ++
> >  4 files changed, 130 insertions(+)
> > 
> > diff --git a/drivers/cxl/cache.c b/drivers/cxl/cache.c
> > index f123d596187d..fa3223165a18 100644
> > --- a/drivers/cxl/cache.c
> > +++ b/drivers/cxl/cache.c
> > @@ -163,6 +163,10 @@ static int
> > devm_cxl_cachedev_allocate_cache_id(struct cxl_cachedev *cxlcd) rc =
> > map_cache_idd_cap(dport); if (rc)
> >  			return rc;
> > +
> > +		rc = cxl_dport_program_cache_idd(dport, cxlcd);
> > +		if (rc)
> > +			return rc;
> >  	}
> >  
> >  	return 0;
> > diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> > index f491796f6e60..3606ad557bfb 100644
> > --- a/drivers/cxl/core/port.c
> > +++ b/drivers/cxl/core/port.c
> > @@ -1080,6 +1080,115 @@ int devm_cxl_port_program_cache_idrt(struct
> > cxl_port *port, }
> >  EXPORT_SYMBOL_NS_GPL(devm_cxl_port_program_cache_idrt, "CXL");
> >  
> > +static int cxl_dport_commit_idd(struct cxl_dport *dport)
> > +{
> > +	unsigned long timeout, start, end;
> > +	u32 cap, ctrl, status;
> > +	int i;
> > +
> > +	cap = readl(dport->regs.cidd + CXL_CACHE_IDD_CAP_OFFSET);
> > +	if (!(cap & CXL_CACHE_IDD_CAP_COMMIT))
> > +		return 0;
> > +
> > +	ctrl = readl(dport->regs.cidd + CXL_CACHE_IDD_CTRL_OFFSET);
> > +	if (ctrl & CXL_CACHE_IDD_CTRL_COMMIT) {
> > +		ctrl &= ~CXL_CACHE_IDD_CTRL_COMMIT;
> > +		writel(ctrl, dport->regs.cidd +
> > CXL_CACHE_IDD_CTRL_OFFSET);
> > +	}
> > +
> > +	ctrl |= CXL_CACHE_IDD_CTRL_COMMIT;
> > +	writel(ctrl, dport->regs.cidd + CXL_CACHE_IDD_CTRL_OFFSET);
> > +
> > +	status = readl(dport->regs.cidd +
> > CXL_CACHE_IDD_STAT_OFFSET); +
> > +	i = FIELD_GET(CXL_CACHE_IDD_STAT_TIMEOUT_SCALE_MASK,
> > status);
> > +	timeout = 1 * HZ;
> > +	while (i-- > 3)
> > +		timeout *= 10;
> > +
> > +	timeout *= FIELD_GET(CXL_CACHE_IDD_STAT_TIMEOUT_BASE_MASK,
> > status);
> > +	start = jiffies;
> > +	do {
> > +		status = readl(dport->regs.cidd +
> > CXL_CACHE_IDD_STAT_OFFSET);
> > +		if (status & CXL_CACHE_IDD_STAT_ERR_COMMIT)
> > +			return -EBUSY;
> > +
> > +		if (status & CXL_CACHE_IDD_STAT_COMMITTED)
> > +			return 0;
> > +
> > +		end = jiffies;
> > +	} while (time_before(end, start + timeout));
> > +
> > +	return -ETIMEDOUT;
> > +}
> > +
> > +static int cxl_cache_idd_alread_programmed(struct cxl_dport *dport,
> > +					   struct cxl_cachedev
> > *cxlcd) +{
> > +	struct cxl_cache_state *cstate = &cxlcd->cxlds->cstate;
> > +	u32 ctrl, status, cache_id;
> > +
> > +	status = readl(dport->regs.cidd +
> > CXL_CACHE_IDD_STAT_OFFSET);
> > +	if (!(status & CXL_CACHE_IDD_STAT_COMMITTED))
> > +		return 0;
> > +
> > +	/*
> > +	 * The decoder is probably already committed by BIOS,
> > validate
> > +	 * the configuration
> > +	 */
> > +	ctrl = readl(dport->regs.cidd + CXL_CACHE_IDD_CTRL_OFFSET);
> > +	/* TODO: Check for 68B flit mode */
> > +	if (dport == cxlcd->endpoint->parent_dport &&
> > +	    !(ctrl & CXL_CACHE_IDD_CTRL_ASGN_ID))
> > +		return -EINVAL;
> > +
> > +	if (dport != cxlcd->endpoint->parent_dport &&
> > +	    !(ctrl & CXL_CACHE_IDD_CTRL_FWD_ID))
> > +		return -EINVAL;
> > +
> > +	cache_id = FIELD_GET(CXL_CACHE_IDD_CTRL_LOCAL_ID_MASK,
> > ctrl);
> > +	if (cache_id != cstate->cache_id)
> > +		return -EINVAL;
> > +
> > +	if (!!(ctrl & CXL_CACHE_IDD_CTRL_TYPE2) != cstate->hdmd)
> > +		return -EINVAL;
> > +
> > +	return 1;
> > +}
> > +
> > +int cxl_dport_program_cache_idd(struct cxl_dport *dport,
> > +				struct cxl_cachedev *cxlcd)
> > +{
> > +	u32 ctrl;
> > +	int rc;
> > +
> > +	rc = cxl_cache_idd_alread_programmed(dport, cxlcd);
> > +	if (rc)
> > +		return rc < 0 ? rc : 0;
> > +
> > +	ctrl = readl(dport->regs.cidd + CXL_CACHE_IDD_CTRL_OFFSET);
> > +
> > +	if (cxlcd->cxlds->cstate.hdmd) {
> > +		ctrl |= CXL_CACHE_IDD_CTRL_TYPE2;
> > +		ctrl &= ~CXL_CACHE_IDD_CTRL_TYPE2_ID_MASK;
> > +		ctrl |=
> > FIELD_PREP(CXL_CACHE_IDD_CTRL_TYPE2_ID_MASK, cxlcd->id);
> > +	}
> > +
> > +	/* TODO: Check for 68B flit mode */
> > +	if (dport == cxlcd->endpoint->parent_dport)
> > +		ctrl |= CXL_CACHE_IDD_CTRL_ASGN_ID;
> > +	else
> > +		ctrl |= CXL_CACHE_IDD_CTRL_FWD_ID;
> > +
> > +	ctrl &= ~CXL_CACHE_IDD_CTRL_LOCAL_ID_MASK;
> > +	ctrl |= FIELD_PREP(CXL_CACHE_IDD_CTRL_LOCAL_ID_MASK,
> > +			   cxlcd->cxlds->cstate.cache_id);
> > +
> > +	writel(ctrl, dport->regs.cidd + CXL_CACHE_IDD_CTRL_OFFSET);
> > +	return cxl_dport_commit_idd(dport);
> > +}
> > +EXPORT_SYMBOL_NS_GPL(cxl_dport_program_cache_idd, "CXL");
> > +
> >  DEFINE_SHOW_ATTRIBUTE(einj_cxl_available_error_type);
> >  
> >  static int cxl_einj_inject(void *data, u64 type)
> > diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> > index 04fde1a994d0..9c475d8c1573 100644
> > --- a/drivers/cxl/cxl.h
> > +++ b/drivers/cxl/cxl.h
> > @@ -178,6 +178,20 @@ static inline int ways_to_eiw(unsigned int
> > ways, u8 *eiw) #define   CXL_CACHE_IDRT_TARGETN_PORT_MASK
> > GENMASK(15, 8) 
> >  /* CXL 3.2 8.2.4.29 CXL Cache ID Decoder Capability Structure */
> > +#define CXL_CACHE_IDD_CAP_OFFSET 0x0
> > +#define   CXL_CACHE_IDD_CAP_COMMIT BIT(0)
> > +#define CXL_CACHE_IDD_CTRL_OFFSET 0x4
> > +#define   CXL_CACHE_IDD_CTRL_FWD_ID BIT(0)
> > +#define   CXL_CACHE_IDD_CTRL_ASGN_ID BIT(1)
> > +#define   CXL_CACHE_IDD_CTRL_TYPE2 BIT(2)
> > +#define   CXL_CACHE_IDD_CTRL_COMMIT BIT(3)
> > +#define   CXL_CACHE_IDD_CTRL_TYPE2_ID_MASK GENMASK(11, 8)
> > +#define   CXL_CACHE_IDD_CTRL_LOCAL_ID_MASK GENMASK(19, 16)
> > +#define CXL_CACHE_IDD_STAT_OFFSET 0x8
> > +#define   CXL_CACHE_IDD_STAT_COMMITTED BIT(0)
> > +#define   CXL_CACHE_IDD_STAT_ERR_COMMIT BIT(1)
> > +#define   CXL_CACHE_IDD_STAT_TIMEOUT_SCALE_MASK GENMASK(11, 8)
> > +#define   CXL_CACHE_IDD_STAT_TIMEOUT_BASE_MASK GENMASK(15, 12)
> >  #define CXL_CACHE_IDD_CAPABILITY_LENGTH 0xC  
> 
> Hi Ben,
> 
> This looks like some styling issues.

Hi Ben,

Sorry I misread this.
> >  
> >  /* CXL 2.0 8.2.8.1 Device Capabilities Array Register */
> > diff --git a/drivers/cxl/cxlcache.h b/drivers/cxl/cxlcache.h
> > index d28222123102..60563b391844 100644
> > --- a/drivers/cxl/cxlcache.h
> > +++ b/drivers/cxl/cxlcache.h
> > @@ -32,4 +32,7 @@ int devm_cxl_snoop_filter_alloc(u32 gid, struct
> > cxl_dev_state *cxlds); int devm_cxl_port_program_cache_idrt(struct
> > cxl_port *port, struct cxl_dport *dport,
> >  				     struct cxl_cachedev *cxlcd);
> > +int cxl_dport_program_cache_idd(struct cxl_dport *dport,
> > +				struct cxl_cachedev *cxlcd);
> > +
> >  #endif  
> 

