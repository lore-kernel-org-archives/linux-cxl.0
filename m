Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC792575B
	for <linux-cxl@vger.kernel.org>; Mon,  8 Jan 2024 11:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4T7sp64fkmz6K9TG;
	Mon,  8 Jan 2024 19:50:54 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 876FA1404F5;
	Mon,  8 Jan 2024 19:53:27 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 8 Jan
 2024 11:53:27 +0000
Date: Mon, 8 Jan 2024 11:53:26 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>, "Robert
 Richter" <rrichter@amd.com>, Ira Weiny <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>, <dave@stgolabs.net>
Subject: Re: [PATCH v6 0/5] cxl: find_cxl_root() related cleanups
Message-ID: <20240108115326.00006844@Huawei.com>
In-Reply-To: <65988422aafa8_127da2294dd@dwillia2-xfh.jf.intel.com.notmuch>
References: <170449229696.3779673.18384234151739803343.stgit@djiang5-mobl3>
	<65988422aafa8_127da2294dd@dwillia2-xfh.jf.intel.com.notmuch>
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
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Fri, 5 Jan 2024 14:35:14 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> Dave Jiang wrote:
> > v6:
> > - Fix breakage in previous series for device_find_child() (Dan)
> > - Move DEFINE_FREE() for put_cxl_root() to first patch (Dan)
> > - Don't touch put_device() until final cleanup. (Dan)
> > - Add review tag from Ira.
> > 
> > This series provides a number of small cleanups to make fix_cxl_root()
> > and related code more readable and safer.  
> 
> Looks good, Dave! Thanks for the spins.
> 
Subject to Robert's note on removing the root variable in patch 5 as it
now appears unused, this series looks fine to me (and I guess Dan can
probably just fix that up in the tree)

FWIW given this is already queued in in cxl/next

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
