Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACDD51DED40
	for <linux-cxl@vger.kernel.org>; Thu, 17 Oct 2024 15:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729177495; cv=none; b=sEbcfuYncN5PsBwOmrR48630PbDP8yBcewb4FPxr8yNh8zq0gFwkSI+dgBzXATt05YJqoixD2EjACKGogKIS0d/a4qbRPxUE6s6MvbuN36g5gxAHirJ382dVkHWDh/bwHu2Up36qepdZfNB/RtyqNeJakzWKcHYxlty1MgtzGRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729177495; c=relaxed/simple;
	bh=w6CoNt2t2NYZOdPdyRYiE/ZY904SAxRM3GDo3adSPDI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pTWzDBT/CQYaqpIk1wD9OPGgbwP9B//HKnyrg7VbD3jkPC/7vRSgiiy9LxKaXL+i7OZlpDST1qwnMDOiFb7e55yM6V0vr2CH/S3xTwb78Ee9DWXoVdbxmTdX3rJIk8Aupt+qhsTFqpcVq63O0NUsSDRfhZSeFoR221GXUe+E0oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XTrgB68nnz6FGPh;
	Thu, 17 Oct 2024 23:03:02 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 41B371400F4;
	Thu, 17 Oct 2024 23:04:47 +0800 (CST)
Received: from localhost (10.126.174.164) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 17 Oct
 2024 17:04:46 +0200
Date: Thu, 17 Oct 2024 16:04:45 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: Dan Carpenter <dan.carpenter@linaro.org>, Li Ming <ming4.li@intel.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [bug report] cxl/port: Use scoped_guard()/guard() to drop
 device_lock() for cxl_port
Message-ID: <20241017160445.00005c50@Huawei.com>
In-Reply-To: <671044082f7de_3ee22945a@dwillia2-xfh.jf.intel.com.notmuch>
References: <2a19289b-0bcf-42c4-82a9-268a922535f2@stanley.mountain>
	<671044082f7de_3ee22945a@dwillia2-xfh.jf.intel.com.notmuch>
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
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 16 Oct 2024 15:54:00 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> Dan Carpenter wrote:
> > Hello Li Ming,
> > 
> > Commit 7f569e917b78 ("cxl/port: Use scoped_guard()/guard() to drop
> > device_lock() for cxl_port") from Aug 30, 2024 (linux-next), leads to
> > the following (unpublished) Smatch static checker warning:
> > 
> > 	drivers/cxl/core/port.c:1591 add_port_attach_ep()
> > 	warn: re-assigning __cleanup__ ptr 'port'
> > 
> > drivers/cxl/core/port.c
> >     1542 static int add_port_attach_ep(struct cxl_memdev *cxlmd,
> >     1543                               struct device *uport_dev,
> >     1544                               struct device *dport_dev)
> >     1545 {
> >     1546         struct device *dparent = grandparent(dport_dev);
> >     1547         struct cxl_dport *dport, *parent_dport;
> >     1548         resource_size_t component_reg_phys;
> >     1549         int rc;
> >     1550 
> >     1551         if (!dparent) {
> >     1552                 /*
> >     1553                  * The iteration reached the topology root without finding the
> >     1554                  * CXL-root 'cxl_port' on a previous iteration, fail for now to
> >     1555                  * be re-probed after platform driver attaches.
> >     1556                  */
> >     1557                 dev_dbg(&cxlmd->dev, "%s is a root dport\n",
> >     1558                         dev_name(dport_dev));
> >     1559                 return -ENXIO;
> >     1560         }
> >     1561 
> >     1562         struct cxl_port *parent_port __free(put_cxl_port) =
> >     1563                 find_cxl_port(dparent, &parent_dport);
> >     1564         if (!parent_port) {
> >     1565                 /* iterate to create this parent_port */
> >     1566                 return -EAGAIN;
> >     1567         }
> >     1568 
> >     1569         /*
> >     1570          * Definition with __free() here to keep the sequence of
> >     1571          * dereferencing the device of the port before the parent_port releasing.
> >     1572          */
> >     1573         struct cxl_port *port __free(put_cxl_port) = NULL;
> >                                   ^^^^^^^^^^^^^^^^^^^^^^^^
> > We free port when we exit the function, fine.
> > 
> >     1574         scoped_guard(device, &parent_port->dev) {
> >     1575                 if (!parent_port->dev.driver) {
> >     1576                         dev_warn(&cxlmd->dev,
> >     1577                                  "port %s:%s disabled, failed to enumerate CXL.mem\n",
> >     1578                                  dev_name(&parent_port->dev), dev_name(uport_dev));
> >     1579                         return -ENXIO;
> >     1580                 }
> >     1581 
> >     1582                 port = find_cxl_port_at(parent_port, dport_dev, &dport);
> >     1583                 if (!port) {
> >     1584                         component_reg_phys = find_component_registers(uport_dev);
> >     1585                         port = devm_cxl_add_port(&parent_port->dev, uport_dev,

> >     1586                                                  component_reg_phys, parent_dport);
> > 
> > This port from devm_cxl_add_port() needs to be undone.  

devm cleanup should sweep that up if we suceed here but fail on one of the remaining calls.

> 
> I also think the bug originates in:
> 
> dd2617ebd2a6 cxl/port: Use __free() to drop put_device() for cxl_port
> 
> ...where the wrong port is cleaned up, but I want to revert the
> scoped_guard() conversion first to make that cleanup easier.
> 
> In general for CXL I want to say that no function should be converted to
> use cleanup helpers unless all gotos are removed at once, and if the
> conversion needs to reach for scoped_guard() reconsider even attempting
> the conversion. I.e. scoped_guard() is a leading indicator for needing
> code refactoring.

I don't think it's a bug and ultimately Dan C didn't say it was.
It's ugly but a simpler path to resolve it logically is to
stop using the variable port for two purposes.


struct cxl_port *port __free(put_cxl_port) = NULL;
	scoped_guard(device, &parent_port->dev) {
		if (!parent_port->dev.driver) {
			dev_warn(&cxlmd->dev,
				 "port %s:%s disabled, failed to enumerate CXL.mem\n",
				 dev_name(&parent_port->dev), dev_name(uport_dev));
			return -ENXIO;
		}

		port = find_cxl_port_at(parent_port, dport_dev, &dport);
		if (!port) {
			struct cxl_dport *yadp;

			component_reg_phys = find_component_registers(uport_dev);
//rename (yet another dport :)

			yadp = devm_cxl_add_port(&parent_port->dev, uport_dev,
						 component_reg_phys, parent_dport);
			if (IS_ERR(yadp))
				return PTR_ERR(yadp);
//port is correctly null. We haven't found one yet, so all the auto cleanup is fine.


			/* retry find to pick up the new dport information */
			port = find_cxl_port_at(parent_port, dport_dev, &dport);
			if (!port)
				return -ENXIO;
		}
	}

Whilst I don't like the code, I'm not sure a revert is the best way out.

Jonathan

> 

