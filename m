Received: from zg8tmja5ljk3lje4ms43mwaa.icoremail.net (zg8tmja5ljk3lje4ms43mwaa.icoremail.net [209.97.181.73])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC139475;
	Tue, 18 Feb 2025 03:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.97.181.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739847718; cv=none; b=eNn+FTKUm5/tR6WtZGdNbTnH1RH6Xl+fqba6QZiezZ82lQ6kzCMCZjsnc7nJL+T02k0FgCvy53OG0GyTi5mNVagtAma6RFh367/eudHA0FJ393osHs8u27gzh34+rrBSi1DRTeIJlkLPhV5291+tNYI+xpReLKvcpF6vEU6NHK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739847718; c=relaxed/simple;
	bh=uKs5IpAUzXE3MGe8SGxKsjxPHf9hQPm4P80golM4VoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jHYAR1cSFbEZ8EPgI4UcZf7MthOW/tEdkaIseqf9v2VEloPurePZkNd3xHRvZMsPDInCyUwa1ODmo61G/diu9inF4D6DZFDONKa8aI2/pUo/SJJgnqPLIBnXIHeJEq5ExiMn2kN+wjIE59dA7VpQNIWuHp+esih690lVVm8qWJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn; spf=pass smtp.mailfrom=phytium.com.cn; arc=none smtp.client-ip=209.97.181.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytium.com.cn
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
	by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwAnLAwW+LNnd8lzAw--.13203S2;
	Tue, 18 Feb 2025 11:01:42 +0800 (CST)
Received: from localhost (unknown [123.150.8.50])
	by mail (Coremail) with SMTP id AQAAfwBHS4cT+LNnTbQqAA--.16562S2;
	Tue, 18 Feb 2025 11:01:39 +0800 (CST)
Date: Tue, 18 Feb 2025 11:01:23 +0800
From: Yuquan Wang <wangyuquan1236@phytium.com.cn>
To: Fan Ni <nifan.cxl@gmail.com>
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, dan.j.williams@intel.com,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	chenbaozi@phytium.com.cn
Subject: Re: [PATCH v3 1/1] cxl/pmem: debug invalid serial number data
Message-ID: <Z7P4A+3hfRdNnMM3@phytium.com.cn>
References: <20250218014746.166565-1-wangyuquan1236@phytium.com.cn>
 <20250218014746.166565-2-wangyuquan1236@phytium.com.cn>
 <67b3ee67.a70a0220.21e7fd.0285@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67b3ee67.a70a0220.21e7fd.0285@mx.google.com>
X-CM-TRANSID:AQAAfwBHS4cT+LNnTbQqAA--.16562S2
X-CM-SenderInfo: 5zdqw5pxtxt0arstlqxsk13x1xpou0fpof0/1tbiAQAFAWezlaEBBgAAsi
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=wangyuquan
	1236@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW7WrW3ZFW5Kr15ZF13uF1DGFg_yoW8tw1Dpr
	W8ta4YkFW5JF47Zw4Iva40qF1Fgw1vgrW8Gr90qw15urnYyFnaqF4xta1Yya4fCa95tw4S
	v34jvayUuF47X3DanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
	DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
	UUUUU

On Mon, Feb 17, 2025 at 06:20:18PM -0800, Fan Ni wrote:
> On Tue, Feb 18, 2025 at 09:47:46AM +0800, Yuquan Wang wrote:
> > In a nvdimm interleave-set each device with an invalid or zero
> > serial number may cause pmem region initialization to fail, but in
> > cxl case such device could still set cookies of nd_interleave_set
> > and create a nvdimm pmem region.
> > 
> > This adds the validation of serial number in cxl pmem region creation.
> > The event of no serial number would cause to fail to set the cookie
> > and pmem region.
> > 
> > For cxl-test to work properly, always +1 on mock device's serial
> > number.
> > 
> > Signed-off-by: Yuquan Wang <wangyuquan1236@phytium.com.cn>
> > ---
> >  drivers/cxl/pmem.c           | 8 ++++++++
> >  tools/testing/cxl/test/mem.c | 2 +-
> >  2 files changed, 9 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/cxl/pmem.c b/drivers/cxl/pmem.c
> > index f9c95996e937..73787afe1b9d 100644
> > --- a/drivers/cxl/pmem.c
> > +++ b/drivers/cxl/pmem.c
> > @@ -383,6 +383,14 @@ static int cxl_pmem_region_probe(struct device *dev)
> >  			.position = i,
> >  		};
> >  		info[i].offset = m->start;
> > +
> > +		if (cxlds->serial == 0) {
> > +			/* include missing alongside invalid in this error message. */
> > +			dev_err(dev, "%s: invalid or missing serial number\n",
> > +				dev_name(&cxlmd->dev));
> > +			rc = -ENXIO;
> > +			goto out_nvd;
> > +		}
> 
> Should we do the check earlier in the code? 
> For example, right below if (!nvdimm) {}
> 
> Fan

I agree. This would removes unnecessary struct value assignments
and make the code easier to read. Jonathan, what's your opinion?

Yuquan

> 
> >  		info[i].serial = cxlds->serial;
> >  	}
> >  	ndr_desc.num_mappings = cxlr_pmem->nr_mappings;
> > diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
> > index 8d731bd63988..9e098cf06603 100644
> > --- a/tools/testing/cxl/test/mem.c
> > +++ b/tools/testing/cxl/test/mem.c
> > @@ -1533,7 +1533,7 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
> >  	mds->event.buf = (struct cxl_get_event_payload *) mdata->event_buf;
> >  	INIT_DELAYED_WORK(&mds->security.poll_dwork, cxl_mockmem_sanitize_work);
> >  
> > -	cxlds->serial = pdev->id;
> > +	cxlds->serial = pdev->id + 1;
> >  	if (is_rcd(pdev))
> >  		cxlds->rcd = true;
> >  
> > -- 
> > 2.34.1
> > 

