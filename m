Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C7817A309;
	Wed, 14 Jan 2026 18:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768414146; cv=none; b=acIL5XN0gVNFSlf5mMq9/U3oMjkyEbSfVKe2DKkv+db4FzWgH/ejMXc1VjDXQAKL36H69JDM/gZdIOBDTw1IHgccXRVejkdikxk9ybg1SqegxzdUqBMaDALAAVoqKcnaNsP0EvREaV5e6nk0Iuo1SFEgscfTIGTiO6nKDg+zJtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768414146; c=relaxed/simple;
	bh=9tQ6wL4oJwNtslVcmTb36U6Am2hUovfI85kIJ1XSyvs=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hP40D60Ejxm9bkqPjfATqpLsHmqiDh5CWO1W2hqPXwMCr0FX6/UD0YisnQDOplTNfYRAr1AfziexNvUaT1u37OEiBX83LnsAS77e2eAQCbuvskrh30s3ZbaXfN4531gpzdBD3S2xbsaC2aoi+S5CMtQ53dMlYSjnnJIHc1z4CeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4drvHy5xF1zJ468V;
	Thu, 15 Jan 2026 02:08:46 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id D149C40539;
	Thu, 15 Jan 2026 02:09:01 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Wed, 14 Jan
 2026 18:09:01 +0000
Date: Wed, 14 Jan 2026 18:08:59 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Ard Biesheuvel <ardb@kernel.org>
CC: Robert Richter <rrichter@amd.com>, Peter Zijlstra <peterz@infradead.org>,
	Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Dave Jiang <dave.jiang@intel.com>, Davidlohr
 Bueso <dave@stgolabs.net>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gregory Price <gourry@gourry.net>, "Fabio M.
 De Francesco" <fabio.m.de.francesco@linux.intel.com>, Terry Bowman
	<terry.bowman@amd.com>, Joshua Hahn <joshua.hahnjy@gmail.com>
Subject: Re: [PATCH v9 10/13] cxl: Enable AMD Zen5 address translation using
 ACPI PRMT
Message-ID: <20260114180859.00004623@huawei.com>
In-Reply-To: <CAMj1kXFhBdCPW_+xPR-TmU4M46Jr6DGwtjUtjDQ0EbgPGmL7vQ@mail.gmail.com>
References: <20260110114705.681676-1-rrichter@amd.com>
	<20260110114705.681676-11-rrichter@amd.com>
	<CAMj1kXHYTyxBcO3Jt97pukZiOTqL8U=zL5iari82sqMOen1cEQ@mail.gmail.com>
	<aWehZwXsK1IXRNU2@rric.localdomain>
	<CAMj1kXFhBdCPW_+xPR-TmU4M46Jr6DGwtjUtjDQ0EbgPGmL7vQ@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Wed, 14 Jan 2026 16:21:03 +0100
Ard Biesheuvel <ardb@kernel.org> wrote:

> On Wed, 14 Jan 2026 at 15:00, Robert Richter <rrichter@amd.com> wrote:
> >
> > On Wed, Jan 14, 2026 at 08:47:22AM +0100, Ard Biesheuvel wrote:  
> > > (cc Peter)
> > >
> > > On Sat, 10 Jan 2026 at 12:46, Robert Richter <rrichter@amd.com> wrote:  
> > > >
> > > > Add AMD Zen5 support for address translation.
> > > >  
> > > ...  
> > > > Do the following to implement AMD Zen5 address translation:
> > > >
> > > > Introduce a new file core/atl.c to handle ACPI PRM specific address
> > > > translation code. Naming is loosely related to the kernel's AMD
> > > > Address Translation Library (CONFIG_AMD_ATL) but implementation does
> > > > not depend on it, nor it is vendor specific. Use Kbuild and Kconfig
> > > > options respectively to enable the code depending on architecture and
> > > > platform options.
> > > >
> > > > AMD Zen5 systems support the ACPI PRM CXL Address Translation firmware
> > > > call (see ACPI v6.5 Porting Guide, Address Translation - CXL DPA to
> > > > System Physical Address). Firmware enables the PRM handler if the
> > > > platform has address translation implemented. Check firmware and
> > > > kernel support of ACPI PRM using the specific GUID. On success enable
> > > > address translation by setting up the earlier introduced root port
> > > > callback, see function cxl_prm_setup_translation(). Setup is done in
> > > > cxl_setup_prm_address_translation(), it is the only function that
> > > > needs to be exported. For low level PRM firmware calls, use the ACPI
> > > > framework.
> > > >  
> > >
> > > Does the PRM service in question tolerate being invoked unprivileged?
> > > The PRM spec requires this, and this is something we may need to
> > > enforce at some point.
> > >
> > > cc'ing Peter with whom I've discussed this just recently.  
> >
> > Interesting appoach, need to check if that works. I haven't tried that
> > yet. Though, that needs some rework of the kernel code as some high
> > priority code depends on the translation and that would cause kind of
> > priority inversion. E.g. an interrupt handler cannot wait until a
> > dpa-to-spa conversion is done.
> >  
> 
> This is not about running it in user space, but about running the code
> in an unprivileged sandbox. So scheduling wpuldn't really come into
> play here.

Hi Ard,

I haven't looked into the background yet, so a naive question:

Do we have a potential issue wrt to merging this as it stands and improving
on it later?  i.e. Is this a blocking issue for this patch set?

Thanks,

Jonathan

> 
> > For CXL it is only used for region setup in the init path and process
> > context. For tracing and error handling those translations are
> > disabled. See patch 13/13.
> >  
> 

