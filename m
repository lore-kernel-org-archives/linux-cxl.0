Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93023A1BB
	for <linux-cxl@vger.kernel.org>; Tue,  9 Jan 2024 16:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4T8bfK5Vqbz6D90c;
	Wed, 10 Jan 2024 00:16:41 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 1A14D140B2A;
	Wed, 10 Jan 2024 00:18:59 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 9 Jan
 2024 16:18:58 +0000
Date: Tue, 9 Jan 2024 16:18:57 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: Shiyang Ruan <ruansy.fnst@fujitsu.com>, <linux-cxl@vger.kernel.org>,
	<dave.jiang@intel.com>, <vishal.l.verma@intel.com>
Subject: Re: Some thoughts and questions about CXL & MCE
Message-ID: <20240109161857.00003363@Huawei.com>
In-Reply-To: <659c659e938cf_127da22943b@dwillia2-xfh.jf.intel.com.notmuch>
References: <46c10608-fd28-45a6-90bd-28c1b9678af6@fujitsu.com>
	<65958f44d67b7_8dc68294c7@dwillia2-xfh.jf.intel.com.notmuch>
	<20240108123749.0000027f@Huawei.com>
	<659c659e938cf_127da22943b@dwillia2-xfh.jf.intel.com.notmuch>
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

On Mon, 8 Jan 2024 13:14:06 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> Jonathan Cameron wrote:
> [..]
> > One other wrinkle I'm working through is the control of CPER vs normal reporting.
> > Current thought is we do what ACPI allows and start in firmware first, until the
> > _OSC call.  If that requests native handling we go back to what we currently
> > support (native only emulation).
> > 
> > However, there isn't a convenient way to mess with what Linux asks for which we'd
> > want to make it easy to test the handling once the driver stack is up.
> > 
> > I'm not sure anyone would be keen on a pci_aer=no-ask,cxl-mem-error=no-ask type
> > kernel boot parameter to instruct the kernel to never ask for control.  
> 
> I just expressed a similar lament to someone else asking about this, and
> claimed that is up to the BIOS to say "no", not for Linux to skip
> asking. It turns out that the Linux pci=noear knob predated _OSC:
> 
>    7ece14175376 PCI/AER: Remove aerdriver.forceload kernel parameter
> 
> ..., so there was legacy to carry forward. Otherwise, in a post _OSC
> world it's the OS responsibility to ask and the firmware responsibility
> to optionally say, "no".

PCI Firmware specification rev 3.3 Section 4.5.1.
(right at the end of page 48)

"System firmware must only mask a Control Field bit to zero if it has explicit
knowledge that the feature will not work properly under native operating system
control, due to platform errata or other incompatibilities."

Meh, I guess I could add a 'native-aer=broken' parameter to the qemu boot -
I'm sure that will sail through reviews :)

> 
> > I also don't much like a qemu parameter which basically says 'report aer as
> > broken so the OS can't grab it'. Anyhow those are details.
> > 
> > Ah well. Getting the _OSC handshake to save what was negotiated on qemu side was
> > fiddly but I got that working on Friday so I have all the pieces for protocol errors
> > done (ARM only for now - I need to look at notifications in ACPI on x86 + enable
> > HEST in general on qemu-x86).  Will post an RFC for ARM shortly.
> > 
> > Bare metal will be burried in bios config most likely.
> > 
> > Jonathan
> > 
> >   
> > >   
> > > > I don't fully understand the CXL spec yet (it's difficult for me), so 
> > > > the above ideas may be immature, but I really want to figure out how we 
> > > > can make CXL & MCE work.  I'd really appreciate it if you could help me 
> > > > on this!
> > > > 
> > > > [1] 
> > > > https://lore.kernel.org/linux-cxl/20231220-cxl-cper-v5-0-1bb8a4ca2c7a@intel.com/T/#u    
> > > 
> > > Following this work from Smita and Ira is the right path.  
> >   
> 
> 
> 

