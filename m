Received: from sgoci-sdnproxy-4.icoremail.net (sgoci-sdnproxy-4.icoremail.net [129.150.39.64])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8363D205ACF
	for <linux-cxl@vger.kernel.org>; Thu, 13 Feb 2025 07:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.150.39.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739430598; cv=none; b=txVoEYuQOxYiqmLNQ0Fd+KjYk3gtjHGbf8O2s2C0Rw8J+RzU8zNjwE6auni2la8DEA75bzSPIgEdals8z1UJJmxFR+c57VAqAYYgVJPwFF0t2C0I8eOywPWmYJlCF5mN2sXdZ/dusDsE5Rg/JPdA9hbq/TeLN4jLzTdFM01LYLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739430598; c=relaxed/simple;
	bh=gZn8cgGBgz+vT0PXaMAf+tVk60yBhGRXxWqEtQiB2Yw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q+IzxL6QrebD6nV2/iAJkrGFgWJc4be47r3qIx40k3afv11hkLh0g/ueHpJrpm+MxjW6tSqtt7jgugRN3EAroiA/ERlQSh/3RUYjYYPY89FFJCYOenSF3TEZa4VUyPKOd2oi7pjhNlCMMNNJWEBhoa8AtEMJe7KvL650nQRkB4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn; spf=pass smtp.mailfrom=phytium.com.cn; arc=none smtp.client-ip=129.150.39.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytium.com.cn
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
	by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwDn76e2mq1nKaTDAg--.17385S2;
	Thu, 13 Feb 2025 15:09:42 +0800 (CST)
Received: from localhost (unknown [123.150.8.50])
	by mail (Coremail) with SMTP id AQAAfwDX3Ymhmq1njoYlAA--.50148S2;
	Thu, 13 Feb 2025 15:09:32 +0800 (CST)
Date: Thu, 13 Feb 2025 15:09:05 +0800
From: Yuquan Wang <wangyuquan1236@phytium.com.cn>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: fan.ni@samsung.com, qemu-devel@nongnu.org, chenbaozi@phytium.com.cn,
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH 1/1] mem/cxl-type3: Add a default value of sn
Message-ID: <Z62akRdahoGqHN5x@phytium.com.cn>
References: <20250211022413.80842-1-wangyuquan1236@phytium.com.cn>
 <20250211022413.80842-2-wangyuquan1236@phytium.com.cn>
 <20250211092655.00004310@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250211092655.00004310@huawei.com>
X-CM-TRANSID:AQAAfwDX3Ymhmq1njoYlAA--.50148S2
X-CM-SenderInfo: 5zdqw5pxtxt0arstlqxsk13x1xpou0fpof0/1tbiAQAAAWes-icCNgAFsj
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=wangyuquan
	1236@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxJw18KFW7Ar48AFWUAF4ruFg_yoWrWFykpr
	WxtFy5GFs7Ar13JrZ2vw15Xr1rZa1fGFWUCryvkw1rZF90vr9Iqr18Kr4FkFyDZrZ2yw40
	ya12qa4a934j93DanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
	DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
	UUUUU

On Tue, Feb 11, 2025 at 09:26:55AM +0000, Jonathan Cameron wrote:
> On Tue, 11 Feb 2025 10:24:13 +0800
> Yuquan Wang <wangyuquan1236@phytium.com.cn> wrote:
> 
> > The previous default value of sn is UI64_NULL which would cause the
> > cookie of nd_interleave_set be '0' and the "invalid interleave-set
> > -cookie" failure in label validation.
> Hi Yuquan,
> 
> Maybe we should harden the nd_interleave_set code to fail
> to set the cookie in the event of no serial number. That is a
> device not compliant with the spec, but none the less it is not
> implausible with test devices etc.
> 
Thanks for your suggestions :)

I have send patch 'cxl/pmem: debug invalid serial number data' trying to
fix this problem. Welcome more comments to guide me!

link: https://lore.kernel.org/linux-cxl/20250213064008.4032730-1-wangyuquan1236@phytium.com.cn/T/#t

Here I have another question about labels. It seems like current kernel
only deals with nvdimm namespaces labels and leaves cxl region labels to
do. Therefore, for some dynamically-created cxl pmem regions, users have
to re-create these regions manually. Does it means CXL drivers could not recover
a cxl region by cxl region lables now?.
> > 
> > As many users maybe not know how to set a unique sn for cxl-type3
> > device and perhaps be confuesd by the failure of label validation,
> > so this defines '1' as the default value of serial number to fix the
> > problem.
> 
> That magic value is specifically chosen to be 'undefined' to trigger
> clean handling of the failure and not provide the serial number
> capability. 
> 
> If you have multiple devices and provide a 'valid' default then
> there are circumstances in which the device will be seen as a multiheaded
> single device attached to two places in the PCI topology.
> 
> So I'm not keen to change this.  Ideally we'd have made this a required
> parameter from the start, but we didn't and doing so now would result
> in a backwards compatibility problem.
> 
> So I think this is kind of a 'won't fix' situation on the qemu side.
Ok, I see.

Maybe we could modify the Example command lines in docs/../cxl.rst to remind
users to add this parameter. Is this feasible?

> 
> Jonathan
> 
> > 
> > Signed-off-by: Yuquan Wang <wangyuquan1236@phytium.com.cn>
> > ---
> >  hw/mem/cxl_type3.c | 17 ++++-------------
> >  1 file changed, 4 insertions(+), 13 deletions(-)
> > 
> > diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> > index 0ae1704a34..a6b5a9f74e 100644
> > --- a/hw/mem/cxl_type3.c
> > +++ b/hw/mem/cxl_type3.c
> > @@ -310,12 +310,6 @@ static void ct3d_config_write(PCIDevice *pci_dev, uint32_t addr, uint32_t val,
> >      pcie_aer_write_config(pci_dev, addr, val, size);
> >  }
> >  
> > -/*
> > - * Null value of all Fs suggested by IEEE RA guidelines for use of
> > - * EU, OUI and CID
> > - */
> > -#define UI64_NULL ~(0ULL)
> > -
> >  static void build_dvsecs(CXLType3Dev *ct3d)
> >  {
> >      CXLComponentState *cxl_cstate = &ct3d->cxl_cstate;
> > @@ -856,12 +850,9 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
> >      pci_config_set_prog_interface(pci_conf, 0x10);
> >  
> >      pcie_endpoint_cap_init(pci_dev, 0x80);
> > -    if (ct3d->sn != UI64_NULL) {
> > -        pcie_dev_ser_num_init(pci_dev, 0x100, ct3d->sn);
> > -        cxl_cstate->dvsec_offset = 0x100 + 0x0c;
> > -    } else {
> > -        cxl_cstate->dvsec_offset = 0x100;
> > -    }
> > +
> > +    pcie_dev_ser_num_init(pci_dev, 0x100, ct3d->sn);
> > +    cxl_cstate->dvsec_offset = 0x100 + 0x0c;
> >  
> >      ct3d->cxl_cstate.pdev = pci_dev;
> >      build_dvsecs(ct3d);
> > @@ -1225,7 +1216,7 @@ static const Property ct3_props[] = {
> >                       TYPE_MEMORY_BACKEND, HostMemoryBackend *),
> >      DEFINE_PROP_LINK("lsa", CXLType3Dev, lsa, TYPE_MEMORY_BACKEND,
> >                       HostMemoryBackend *),
> > -    DEFINE_PROP_UINT64("sn", CXLType3Dev, sn, UI64_NULL),
> > +    DEFINE_PROP_UINT64("sn", CXLType3Dev, sn, 0x1),
> >      DEFINE_PROP_STRING("cdat", CXLType3Dev, cxl_cstate.cdat.filename),
> >      DEFINE_PROP_UINT8("num-dc-regions", CXLType3Dev, dc.num_regions, 0),
> >      DEFINE_PROP_LINK("volatile-dc-memdev", CXLType3Dev, dc.host_dc,
> 

