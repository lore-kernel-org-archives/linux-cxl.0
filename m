Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331E418633
	for <linux-cxl@vger.kernel.org>; Mon,  5 Feb 2024 11:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707131730; cv=none; b=K4FFDoB9g0wOBm9cl8g4hnavhNnFqdTcYJq3+bCqx8gocf2PkfFGY/N/vSJydQWJJ7U9Oj+XQn+KAOrGeidExarH8Wg2WEG0L/0+dzUnW6/bnl1LsKx5EqhumapWSmdUXTi7tEl/mTfF5ALf/jNd+C+8TN9XVHmGcYAQVdkRFFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707131730; c=relaxed/simple;
	bh=5oeyr0Mzue+fnF3ztIGbVsoRGcGRaq0+Awda4qkGC4I=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BXXLd7i0Bg08fScv10dQD3RaZkdTL5NnRoWax+FoRUy0u1zQ9IxUJuVXYvOCKQco+YujhqSUTpQVrwDqrABXOeMzJgomgwRlkvu42wy5Ui+D8rqUy912pxz5K7eZTs7oGz1t5W54Z64Ok0OAifRIEDePdMX7Q3qmVp4xKvdW5+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TT3cX1ZHJz6K9LX;
	Mon,  5 Feb 2024 19:12:12 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id B7225142117;
	Mon,  5 Feb 2024 19:15:25 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 5 Feb
 2024 11:15:25 +0000
Date: Mon, 5 Feb 2024 11:15:24 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: Dan Williams <dan.j.williams@intel.com>, Wonjae Lee
	<wj28.lee@samsung.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "ira.weiny@intel.com" <ira.weiny@intel.com>,
	"vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
	"alison.schofield@intel.com" <alison.schofield@intel.com>,
	"dave@stgolabs.net" <dave@stgolabs.net>, KyungSan Kim
	<ks0204.kim@samsung.com>, Hojin Nam <hj96.nam@samsung.com>
Subject: Re: [PATCH v3 1/3] cxl: Change 'struct cxl_memdev_state'
 *_perf_list to single 'struct cxl_dpa_perf'
Message-ID: <20240205111524.00005a5e@Huawei.com>
In-Reply-To: <d9e09c9b-837b-41ed-a0a5-be740ea5481e@intel.com>
References: <20240201214731.1297389-1-dave.jiang@intel.com>
	<CGME20240201214822epcas2p3062089e1281f483fb26eea3c80a71475@epcms2p3>
	<20240202042140epcms2p3c6f0708e85374e958df2f58416dde705@epcms2p3>
	<65bc7d62d42e5_65b26294dc@dwillia2-mobl3.amr.corp.intel.com.notmuch>
	<fe311247-ba59-4e42-8e7a-e49abfb9cc3d@intel.com>
	<d9e09c9b-837b-41ed-a0a5-be740ea5481e@intel.com>
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
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Fri, 2 Feb 2024 08:51:01 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> On 2/2/24 08:40, Dave Jiang wrote:
> > 
> > 
> > On 2/1/24 22:28, Dan Williams wrote:  
> >> Wonjae Lee wrote:  
> >>> On Thu, Feb 01, 2024 at 02:47:29PM -0700, Dave Jiang wrote:  
> >>>> In order to address the issue with being able to expose qos_class sysfs
> >>>> attributes under 'ram' and 'pmem' sub-directories, the attributes must
> >>>> be defined as static attributes rather than under driver->dev_groups.
> >>>> To avoid implementing locking for accessing the 'struct cxl_dpa_perf`
> >>>> lists, convert the list to a single 'struct cxl_dpa_perf' entry in
> >>>> preparation to move the attributes to statically defined.
> >>>>
> >>>> While theoretically a partition may have multiple qos_class via CDAT, this
> >>>> has not been encountered with testing on available hardware. The code is
> >>>> simplified for now to not support the complex case until a use case is
> >>>> needed to support that.
> >>>>
> >>>> Link: https://lore.kernel.org/linux-cxl/65b200ba228f_2d43c29468@dwillia2-mobl3.amr.corp.intel.com.notmuch/
> >>>> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> >>>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> >>>> ---
> >>>> v3:
> >>>> - Add to commit log about simplification (Dan)
> >>>> - Remove check for dev->driver (Dan)
> >>>> - Remove check for invalid qos_class (Dan)
> >>>> ---
> >>>>  drivers/cxl/core/cdat.c | 81 ++++++++++++-----------------------------
> >>>>  drivers/cxl/core/mbox.c |  4 +-
> >>>>  drivers/cxl/cxlmem.h    | 10 ++---
> >>>>  drivers/cxl/mem.c       | 28 ++------------
> >>>>  4 files changed, 33 insertions(+), 90 deletions(-)
> >>>>  
> >> [..]  
> >>>> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
> >>>> index 6fe11546889f..55b82dfd794b 100644
> >>>> --- a/drivers/cxl/core/cdat.c
> >>>> +++ b/drivers/cxl/core/cdat.c
> >>>> @@ -293,24 +270,25 @@ static int match_cxlrd_qos_class(struct device *dev, void *data)
> >>>>   return 0;
> >>>>  }
> >>>>
> >>>> +static void reset_dpa_perf(struct cxl_dpa_perf *dpa_perf)
> >>>> +{
> >>>> + memset(&dpa_perf, 0, sizeof(*dpa_perf));  
> >>>
> >>> Hello,
> >>>
> >>> I think you meant dpa_perf instead of &dpa_perf, right?
> >>>
> >>> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
> >>> index 5c93bf9d5253..7091619f12a9 100644
> >>> --- a/drivers/cxl/core/cdat.c
> >>> +++ b/drivers/cxl/core/cdat.c
> >>> @@ -272,7 +272,7 @@ static int match_cxlrd_qos_class(struct device *dev, void *data)
> >>>
> >>>  static void reset_dpa_perf(struct cxl_dpa_perf *dpa_perf)
> >>>  {
> >>> -       memset(&dpa_perf, 0, sizeof(*dpa_perf));
> >>> +       memset(dpa_perf, 0, sizeof(*dpa_perf));  
> >>
> >> Good catch!
> >>
> >> ...or even better kill this function and just do:
> >>
> >>     *dpa_perf = { 0 };  
> > 
> > We need to reinit the qos_class to -1 as well. 
> >  
> 
> 
> This should do it right? The rest should be zeroed. 
> 
> 	*dpa_perf = (struct cxl_dpa_perf) {
> 		.qos_class = CXL_QOS_CLASS_INVALID,
> 	};
> 

yes
