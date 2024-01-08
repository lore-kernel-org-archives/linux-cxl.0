Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E9720DC8
	for <linux-cxl@vger.kernel.org>; Mon,  8 Jan 2024 11:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4T7sds0BfCz680ZP;
	Mon,  8 Jan 2024 19:43:45 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id EB49C140A86;
	Mon,  8 Jan 2024 19:45:58 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 8 Jan
 2024 11:45:58 +0000
Date: Mon, 8 Jan 2024 11:45:57 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>, "Robert
 Richter" <rrichter@amd.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>, <dave@stgolabs.net>
Subject: Re: [PATCH] cxl: Clarify root_port cleanup routine for
 cxl_qos_class_verify()
Message-ID: <20240108114557.00000efc@Huawei.com>
In-Reply-To: <65970c97b2b6c_8dc68294ca@dwillia2-xfh.jf.intel.com.notmuch>
References: <170438448564.3436708.17525645430052031684.stgit@djiang5-mobl3>
	<65970c97b2b6c_8dc68294ca@dwillia2-xfh.jf.intel.com.notmuch>
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

On Thu, 4 Jan 2024 11:52:55 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> Dave Jiang wrote:
> > The current __free() call for root_port in cxl_qos_class_verify() depends
> > on 'struct device' to be the first member of 'struct cxl_port' and calls
> > put_device() directly with the root_port pointer passed in. Add a helper
> > function put_cxl_port() to handle the put_device() properly and avoid
> > future issues if the 'struct device' member moves.
> > 
> > Suggested-by: Robert Richter <rrichter@amd.com>
> > Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> > ---
> >  drivers/cxl/core/cdat.c |   12 +++++++++++-
> >  1 file changed, 11 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
> > index cd84d87f597a..d6e64570032f 100644
> > --- a/drivers/cxl/core/cdat.c
> > +++ b/drivers/cxl/core/cdat.c
> > @@ -345,11 +345,21 @@ static void discard_dpa_perf(struct list_head *list)
> >  }
> >  DEFINE_FREE(dpa_perf, struct list_head *, if (!list_empty(_T)) discard_dpa_perf(_T))
> >  
> > +static void put_cxl_port(struct cxl_port *port)
> > +{
> > +	if (!port)
> > +		return;
> > +
> > +	put_device(&port->dev);
> > +}
> > +
> > +DEFINE_FREE(cxl_port, struct cxl_port *, put_cxl_port(_T))  
> 
> I don't think there are other cases where a port reference is acquired
> at runtime, so this should be root specific, i.e. put_cxl_root().
> 
> This also merits a NULL check to skip calling put_cxl_root() if the
> pointer is already NULL:
> 
> 	DEFINE_FREE(put_cxl_root, struct cxl_port *, if (_T) put_cxl_root(_T))
> 
> ...for example if someone used no_free_ptr() to return the found root
> port.
Hi Dan,

Sorry for late reply - been distracted and only now playing catch up.


I'm curious on this mostly because I got similar review feedback on another
case without the if (_T) and conversely yet another review asking me
to drop it as pointless (totally unrelated bits of the kernel ;)
Why do we care given put_cxl_port() has that check? It's clearly harmless
but also at first glance pointless. 

Jonathan

