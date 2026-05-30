Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412D1233920
	for <linux-cxl@vger.kernel.org>; Sat, 30 May 2026 06:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780124231; cv=none; b=u3ks7p5A3wDR13lQjob9JSthDXHkYfSpUuKtrvrRFDbteqxSDmIUkvEO3Tx8RgbmrXPegVnsFoN5XkQXnpG2LMWE63tzHHAZMtlPT3KS3YzbzuHanQBghZfjGnfFT7yklFWTZAEpOG1Ww25iYUb2FedqO17lNJwBJRqoeD3wiBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780124231; c=relaxed/simple;
	bh=ptOJ2M0UZQKXLgtWO06fAWLNwj8RGsAUYc3Mni54jMk=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RPToDFQvQtEpnoSsslaHziJ/MNUdIPcOdfquU/2t/qoATdl61FSFaSa+rkke3fyUFngWY3sI9rimDtkW2Ju5OeWQjOWn/460mUU2TvRt5A1z7n9vjfquErQP3y7/JkN1KjrYScZpsZVENcg2Ct+U81EVXdVwrOizlKYEick8Ot8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LpyLsVyW; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LpyLsVyW"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-304d555293aso2445054eec.0
        for <linux-cxl@vger.kernel.org>; Fri, 29 May 2026 23:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780124228; x=1780729028; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vNqX6axv+OwYZf8pJ3sGM9wZCTdhSmLjoPecyaFqaUQ=;
        b=LpyLsVyWv9R9gM/HbpUxEw1y/ua0ANX//9/lqoa+u8G0YOnL3yVb2TOzvrn1HUhy1+
         Mg705mNcQ1E+qgtth10bExJlHk/Ln6ueOBODvkaRwM9hO31sEUzWGObydyH7DyJ3mH1B
         m+oQBshE3S1DAVex9qNMnH7MqHuHBzzzMBDaI/mWNXdswxmUMwi5PdJ3zkKrWLrjQco7
         tQFXKgYTEwDkoKMGFtQu6qOdKNwg7Nfx5zkdtkNE7geWoNeY80tkdF7Qt1AoR1VPaVqp
         BXvo+Xvnux+0d0QplfCD/hWq+29gKWxaWfW2rWGVBaVerWo0IAtEosnf5mykvCsYuaKV
         30DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780124228; x=1780729028;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vNqX6axv+OwYZf8pJ3sGM9wZCTdhSmLjoPecyaFqaUQ=;
        b=IqCO2hhe0QYoDOhBB+sfrdmebewF4khJFSEQ4h4jTAHWmfLhlvr5RMA8ob1nBPrMzO
         U+QAWzwvDhf6dy4Jb6itgKwTGTkBCk6UHoG23+4LzXj7xZJFbqU8Up7IKC1uIPw3e6Cp
         daynpLLBKttHCHltriA8ShcuyrYAqgBkCV1OctNJFg7jTnyv54P9I6VB0FaACT8ZM6vJ
         8BzoAPCBPdW5vi62x6sVnmxyULc0XLqUfL0NgBmrUFHO68gBodDkutB8kvTAu0e/n+DC
         O7hetEwsWI7fdaVD7aWXUd+SQ691cuPn7bSH6iPuZB8+0zsWaPckHX+7RnipyuqLY/uQ
         UwSQ==
X-Forwarded-Encrypted: i=1; AFNElJ9OdVrdVbcF8SQI7XyL1SGvrTxTAwRnenpSuUDVLzd9eqKAY9fymJMZx+PCxw4m7po1LVnHJkn6ce8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWTHuzvDCyVM2Eu/69cOcZ5yK5tMW0nwHvr6VmJuPwmXTqG0TR
	wsfZNZhDoB79qttCSZQojJTfMUxQPvKP7O98XK8+YVvaaz3pEZl+m9yL
X-Gm-Gg: Acq92OEA+rzc+3P7aeZtL8X5MMSZX9FvVRxhXhbArTrU8/GAheYe3TUtqNyqt+QG8Iw
	hO8L8zzx521taNyYyox+tgdeQD8OfW+eGWpFG/vka+4hk5w/sSnslPV6Ci3RkbBDijA+oGuRcqS
	x7Uu/VxO7KStlGwmrIizERGtGJZp/BKo1PTnV8k5XzPWB+T+qpzhXGPGtPX1VunG5luKZKFULPr
	wvyX2HLQmE5ZaPfP0dl4wgzZDtCdcmU7kLlUzI1iArTIkFhsRGVQ4w58266hoYnJQaX+1HTS5fL
	IaOaOlYy0cpCsm8ZwMeCWOAE2I/rNseOWljLrU9hjTTqqjJmxxK2f5YFSUbDblFR44J5Ye34T/N
	mChnRIJUWzj7t7om78mCn5eSHRZohNaWVLstoDoQkVzRPdGNXgmvdGTVnFsLlgMJxfd7WPjJacP
	gGmCfY560wAE+CTy5xO7yi4RfxJ5g2KnOvsE/CtUe791WVPAv5MPGPSLMgBg0te8xfjxps8gety
	GqZjk2dqjMMpxxBXg==
X-Received: by 2002:a05:693c:8859:b0:305:56a:c38f with SMTP id 5a478bee46e88-305056ac792mr367592eec.26.1780124228282;
        Fri, 29 May 2026 23:57:08 -0700 (PDT)
Received: from AnisaLaptop.localdomain (c-73-170-217-179.hsd1.ca.comcast.net. [73.170.217.179])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304ed2c312csm3568826eec.6.2026.05.29.23.57.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 23:57:07 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
Date: Fri, 29 May 2026 23:57:06 -0700
To: Dave Jiang <dave.jiang@intel.com>
Cc: Anisa Su <anisa.su887@gmail.com>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev,
	Dan Williams <djbw@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>,
	Alison Schofield <alison.schofield@intel.com>,
	John Groves <John@groves.net>, Gregory Price <gourry@gourry.net>,
	Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH v10 04/31] cxl/core: Enforce partition order/simplify
 partition calls
Message-ID: <ahqKQm87k0Z4MLSQ@AnisaLaptop.localdomain>
References: <cover.1779528761.git.anisa.su@samsung.com>
 <22ae445b8a99d26299520e2429c5bf4e64b0d9e6.1779528761.git.anisa.su@samsung.com>
 <c1f55b99-31d2-4c5f-9f22-05f363e31e5b@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c1f55b99-31d2-4c5f-9f22-05f363e31e5b@intel.com>

On Wed, May 27, 2026 at 04:37:11PM -0700, Dave Jiang wrote:
> 
> 
> On 5/23/26 2:42 AM, Anisa Su wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > Device partitions have an implied order which is made more complex by
> > the addition of a dynamic partition.
> > 
> > Remove the ram special case information calls in favor of generic calls
> > with a check ahead of time to ensure the preservation of the implied
> > partition order.
> > 
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > 
> > ---
> > Changes::
> > [anisa: rebase]
> > [davidlohr: core/hdm.c: return -EINVAL instead of 0 in cxl_dpa_setup
> > if partitions are out of order]
> > ---
> >  drivers/cxl/core/hdm.c    | 11 ++++++++++-
> >  drivers/cxl/core/memdev.c | 32 +++++++++-----------------------
> >  drivers/cxl/cxlmem.h      |  9 +++------
> >  drivers/cxl/mem.c         |  2 +-
> >  4 files changed, 23 insertions(+), 31 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> > index 28974adaab75..7a5812971f8f 100644
> > --- a/drivers/cxl/core/hdm.c
> > +++ b/drivers/cxl/core/hdm.c
> > @@ -464,6 +464,7 @@ static const char *cxl_mode_name(enum cxl_partition_mode mode)
> >  int cxl_dpa_setup(struct cxl_dev_state *cxlds, const struct cxl_dpa_info *info)
> >  {
> >  	struct device *dev = cxlds->dev;
> > +	int i;
> >  
> >  	guard(rwsem_write)(&cxl_rwsem.dpa);
> >  
> > @@ -476,9 +477,17 @@ int cxl_dpa_setup(struct cxl_dev_state *cxlds, const struct cxl_dpa_info *info)
> >  		return 0;
> >  	}
> >  
> > +	/* Verify partitions are in expected order. */
> > +	for (i = 1; i < info->nr_partitions; i++) {
> > +		if (cxlds->part[i].mode < cxlds->part[i-1].mode) {
> 
> I think we need to check info->part[i].mode and not cxlds here. cxlds mode is assigned later in this function.
> 
fixed!
> DJ
> 
Thanks,
Anisa
> 
> > +			dev_err(dev, "Partition order mismatch\n");
> > +			return -EINVAL;
> > +		}
> > +	}
> > +
> >  	cxlds->dpa_res = DEFINE_RES_MEM(0, info->size);
> >  
> > -	for (int i = 0; i < info->nr_partitions; i++) {
> > +	for (i = 0; i < info->nr_partitions; i++) {
> >  		const struct cxl_dpa_part_info *part = &info->part[i];
> >  		int rc;
> >  
> > diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> > index 80e65690eb77..71602820f896 100644
> > --- a/drivers/cxl/core/memdev.c
> > +++ b/drivers/cxl/core/memdev.c
> > @@ -75,20 +75,12 @@ static ssize_t label_storage_size_show(struct device *dev,
> >  }
> >  static DEVICE_ATTR_RO(label_storage_size);
> >  
> > -static resource_size_t cxl_ram_size(struct cxl_dev_state *cxlds)
> > -{
> > -	/* Static RAM is only expected at partition 0. */
> > -	if (cxlds->part[0].mode != CXL_PARTMODE_RAM)
> > -		return 0;
> > -	return resource_size(&cxlds->part[0].res);
> > -}
> > -
> >  static ssize_t ram_size_show(struct device *dev, struct device_attribute *attr,
> >  			     char *buf)
> >  {
> >  	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> >  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> > -	unsigned long long len = cxl_ram_size(cxlds);
> > +	unsigned long long len = cxl_part_size(cxlds, CXL_PARTMODE_RAM);
> >  
> >  	return sysfs_emit(buf, "%#llx\n", len);
> >  }
> > @@ -101,7 +93,7 @@ static ssize_t pmem_size_show(struct device *dev, struct device_attribute *attr,
> >  {
> >  	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> >  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> > -	unsigned long long len = cxl_pmem_size(cxlds);
> > +	unsigned long long len = cxl_part_size(cxlds, CXL_PARTMODE_PMEM);
> >  
> >  	return sysfs_emit(buf, "%#llx\n", len);
> >  }
> > @@ -424,10 +416,11 @@ static struct attribute *cxl_memdev_attributes[] = {
> >  	NULL,
> >  };
> >  
> > -static struct cxl_dpa_perf *to_pmem_perf(struct cxl_dev_state *cxlds)
> > +static struct cxl_dpa_perf *part_perf(struct cxl_dev_state *cxlds,
> > +				      enum cxl_partition_mode mode)
> >  {
> >  	for (int i = 0; i < cxlds->nr_partitions; i++)
> > -		if (cxlds->part[i].mode == CXL_PARTMODE_PMEM)
> > +		if (cxlds->part[i].mode == mode)
> >  			return &cxlds->part[i].perf;
> >  	return NULL;
> >  }
> > @@ -438,7 +431,7 @@ static ssize_t pmem_qos_class_show(struct device *dev,
> >  	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> >  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> >  
> > -	return sysfs_emit(buf, "%d\n", to_pmem_perf(cxlds)->qos_class);
> > +	return sysfs_emit(buf, "%d\n", part_perf(cxlds, CXL_PARTMODE_PMEM)->qos_class);
> >  }
> >  
> >  static struct device_attribute dev_attr_pmem_qos_class =
> > @@ -450,20 +443,13 @@ static struct attribute *cxl_memdev_pmem_attributes[] = {
> >  	NULL,
> >  };
> >  
> > -static struct cxl_dpa_perf *to_ram_perf(struct cxl_dev_state *cxlds)
> > -{
> > -	if (cxlds->part[0].mode != CXL_PARTMODE_RAM)
> > -		return NULL;
> > -	return &cxlds->part[0].perf;
> > -}
> > -
> >  static ssize_t ram_qos_class_show(struct device *dev,
> >  				  struct device_attribute *attr, char *buf)
> >  {
> >  	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> >  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> >  
> > -	return sysfs_emit(buf, "%d\n", to_ram_perf(cxlds)->qos_class);
> > +	return sysfs_emit(buf, "%d\n", part_perf(cxlds, CXL_PARTMODE_RAM)->qos_class);
> >  }
> >  
> >  static struct device_attribute dev_attr_ram_qos_class =
> > @@ -499,7 +485,7 @@ static umode_t cxl_ram_visible(struct kobject *kobj, struct attribute *a, int n)
> >  {
> >  	struct device *dev = kobj_to_dev(kobj);
> >  	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> > -	struct cxl_dpa_perf *perf = to_ram_perf(cxlmd->cxlds);
> > +	struct cxl_dpa_perf *perf = part_perf(cxlmd->cxlds, CXL_PARTMODE_RAM);
> >  
> >  	if (a == &dev_attr_ram_qos_class.attr &&
> >  	    (!perf || perf->qos_class == CXL_QOS_CLASS_INVALID))
> > @@ -518,7 +504,7 @@ static umode_t cxl_pmem_visible(struct kobject *kobj, struct attribute *a, int n
> >  {
> >  	struct device *dev = kobj_to_dev(kobj);
> >  	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> > -	struct cxl_dpa_perf *perf = to_pmem_perf(cxlmd->cxlds);
> > +	struct cxl_dpa_perf *perf = part_perf(cxlmd->cxlds, CXL_PARTMODE_PMEM);
> >  
> >  	if (a == &dev_attr_pmem_qos_class.attr &&
> >  	    (!perf || perf->qos_class == CXL_QOS_CLASS_INVALID))
> > diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> > index cee936fb3d03..10175ca3b7ee 100644
> > --- a/drivers/cxl/cxlmem.h
> > +++ b/drivers/cxl/cxlmem.h
> > @@ -383,14 +383,11 @@ struct cxl_security_state {
> >  
> >  #define CXL_MAX_DC_PARTITIONS 8
> >  
> > -static inline resource_size_t cxl_pmem_size(struct cxl_dev_state *cxlds)
> > +static inline resource_size_t cxl_part_size(struct cxl_dev_state *cxlds,
> > +					    enum cxl_partition_mode mode)
> >  {
> > -	/*
> > -	 * Static PMEM may be at partition index 0 when there is no static RAM
> > -	 * capacity.
> > -	 */
> >  	for (int i = 0; i < cxlds->nr_partitions; i++)
> > -		if (cxlds->part[i].mode == CXL_PARTMODE_PMEM)
> > +		if (cxlds->part[i].mode == mode)
> >  			return resource_size(&cxlds->part[i].res);
> >  	return 0;
> >  }
> > diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> > index fcffe24dcb42..f19e08279ec7 100644
> > --- a/drivers/cxl/mem.c
> > +++ b/drivers/cxl/mem.c
> > @@ -114,7 +114,7 @@ static int cxl_mem_probe(struct device *dev)
> >  		return -ENXIO;
> >  	}
> >  
> > -	if (cxl_pmem_size(cxlds) && IS_ENABLED(CONFIG_CXL_PMEM)) {
> > +	if (cxl_part_size(cxlds, CXL_PARTMODE_PMEM) && IS_ENABLED(CONFIG_CXL_PMEM)) {
> >  		rc = devm_cxl_add_nvdimm(dev, parent_port, cxlmd);
> >  		if (rc) {
> >  			if (rc == -ENODEV)
> 
