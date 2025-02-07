Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2806199EAD;
	Fri,  7 Feb 2025 17:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738950707; cv=none; b=PCWW2eNs0kJq2LrpEIyspRs9ZqSS7EOmiUNDhcFYAQV3GeTazGSXgH0VnqyhiTFFLsUPXJD8f1X17Omi0Bug9Qe8Hqzdq1gUZFMod2MmISuxJKcLTIYRcy+xblovLKAvT4KugvAPr+oEG5hA/F68px9LU7hzzlpfVdx+EQfxq48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738950707; c=relaxed/simple;
	bh=rkkvhqtEzofwzaBkz7yI6KzMgFVV2iQuryfGF1GTSx4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dLR+DuJy1Aqny+cRu20rmAVp6uiqirH2VNo2l+k3h5+urRYj7N367uTJCRFZ//UDQMiRBTiB0bWuQugb4JdeWf9QJLOpT4/N0i6sYi6iJ92PztudP7v2qfx0iJI1LmL+dJQlQT4tDduMxUKwJXUR/UPXaw94NT+Oswpl5zOF4Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YqM0z14y4z6M4JK;
	Sat,  8 Feb 2025 01:49:23 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 1AF6B14034D;
	Sat,  8 Feb 2025 01:51:42 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 7 Feb
 2025 18:51:41 +0100
Date: Fri, 7 Feb 2025 17:51:39 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Robert Richter <rrichter@amd.com>
CC: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Dave Jiang <dave.jiang@intel.com>, "Davidlohr
 Bueso" <dave@stgolabs.net>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gregory Price <gourry@gourry.net>, "Fabio M.
 De Francesco" <fabio.m.de.francesco@linux.intel.com>, Terry Bowman
	<terry.bowman@amd.com>
Subject: Re: [PATCH v1 28/29] cxl/region: Show message on broken target list
Message-ID: <20250207175139.00007ad6@huawei.com>
In-Reply-To: <Z6UoXDqmh3ARH_10@rric.localdomain>
References: <20250107141015.3367194-1-rrichter@amd.com>
	<20250107141015.3367194-29-rrichter@amd.com>
	<20250114111641.00001cf5@huawei.com>
	<Z6UoXDqmh3ARH_10@rric.localdomain>
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
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 6 Feb 2025 22:23:40 +0100
Robert Richter <rrichter@amd.com> wrote:

> On 14.01.25 11:16:41, Jonathan Cameron wrote:
> > On Tue, 7 Jan 2025 15:10:14 +0100
> > Robert Richter <rrichter@amd.com> wrote:
> >   
> > > Broken target lists are hard to discover as the driver fails at a
> > > later initialization stage. Add an error message for this.
> > > 
> > > Signed-off-by: Robert Richter <rrichter@amd.com>
> > > ---
> > >  drivers/cxl/core/region.c | 7 +++++++
> > >  1 file changed, 7 insertions(+)
> > > 
> > > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > > index 775450a1a887..2af3b6c14f46 100644
> > > --- a/drivers/cxl/core/region.c
> > > +++ b/drivers/cxl/core/region.c
> > > @@ -1870,6 +1870,13 @@ static int find_pos_and_ways(struct cxl_port *port, struct range *range,
> > >  	}
> > >  	put_device(dev);
> > >  
> > > +	if (rc)
> > > +		dev_err(port->uport_dev,
> > > +			"failed to find %s:%s in target list of %s\n",
> > > +			dev_name(&port->dev),
> > > +			dev_name(port->parent_dport->dport_dev),
> > > +			dev_name(&cxlsd->cxld.dev));
> > > +
> > >  	return rc;
> > >  }  
> > This function would benefit from some __free() magic dust.
> > Then we could return in the good path in the loop and not need the if (rc)
> > check here.  
> 
> That does not really simplify the code. It would just this one
> indentation. On the other side there is a central exit for the code
> and we just need only that one put_device(). Plus, I like to have the
> 'success' code path returning at the end of block.

Seems simpler to me to return early on finding a match.

static int find_pos_and_ways(struct cxl_port *port, struct range *range,
			     int *pos, int *ways)
{
	struct cxl_switch_decoder *cxlsd;
	struct cxl_port *parent;

	parent = next_port(port);
	if (!parent)
		return -ENXIO;

	struct device *dev __free(device) =
		device_find_child(&parent->dev, range,
				  match_switch_decoder_by_range);
	if (!dev) {
		dev_err(port->uport_dev,
			"failed to find decoder mapping %#llx-%#llx\n",
			range->start, range->end);
		return -ENODEV;
	}
	cxlsd = to_cxl_switch_decoder(dev);
	*ways = cxlsd->cxld.interleave_ways;

	for (int i = 0; i < *ways; i++) {
		if (cxlsd->target[i] == port->parent_dport) {
			*pos = i;
			return 0;
		}
	}
	dev_err(port->uport_dev,
		"failed to find %s:%s in target list of %s\n",
		dev_name(&port->dev),
		dev_name(port->parent_dport->dport_dev),
		dev_name(&cxlsd->cxld.dev));

	return -ENXIO;
}

I don't mind that much though.  I'd also suggest returning -ENXIO
doesn't seem the right choice for failing to find something.


> 
> -Robert
> 
> > 
> > Otherwise looks fine.
> > 
> > Jonathan
> >   
> > >    
> >   
> 

