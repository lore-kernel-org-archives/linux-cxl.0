Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5AD423F413
	for <linux-cxl@vger.kernel.org>; Tue, 29 Apr 2025 15:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745941866; cv=none; b=iR0IfHpmRH4dNWJC+h/h0Gr5Na54cjShsudfw+COUziHFz+RF271n/g9H8R+WYvsPn8eX6L/y7DL6wLj+sunxfTbZOfcwvZ/0pdqcI/tITYfcG3kJcZw0jkla5BJ3rq50MO44liBFSqcjkUwkP9zINffj1xw85JxpSX5FSMGhLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745941866; c=relaxed/simple;
	bh=gnmLWyqR8zwDLVndmFxKWPmGHrVOTaG9SxHlrXo1p98=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KB3alrycU52HNPZ9l8SHn4jjvFg+u5c+hlZ5uxIZbAjFxHvD9Amurt8nVeorduomKN5QUMznzA5rC5/sVvGYuRZJBJzaatAL/skAIYJz+16qS5hlrwwESt9cO7l1ODlbAijhYON2CHIbRr19DRrHb84p8NoZeA589yf2FoEgyOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Zn4S12Y0nz6M4GB;
	Tue, 29 Apr 2025 23:46:41 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 149701404F4;
	Tue, 29 Apr 2025 23:51:00 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 29 Apr
 2025 17:50:59 +0200
Date: Tue, 29 Apr 2025 16:50:58 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Fan Ni
	<fan.ni@samsung.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH] hw/pci-bridge/pci_expander_bridge: Fix HDM passthrough
 condition
Message-ID: <20250429165058.00003804@huawei.com>
In-Reply-To: <06c02571-8abc-4304-81e3-9413c47a0bf4@fujitsu.com>
References: <20250323080420.935930-1-lizhijian@fujitsu.com>
	<e2933a3b-7600-4f84-bfa9-d7b59dafb939@fujitsu.com>
	<20250415174717.00001509@huawei.com>
	<06c02571-8abc-4304-81e3-9413c47a0bf4@fujitsu.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
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

On Tue, 29 Apr 2025 01:11:01 +0000
"Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com> wrote:

> Hi Jonathan,
> 
> 
> I apologize for the delayed response; I have just returned from vacation.
> 
> 
> On 16/04/2025 00:47, Jonathan Cameron wrote:
> > On Mon, 7 Apr 2025 02:59:20 +0000
> > "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com> wrote:
> >   
> >> Ping  
> > 
> > Sorry, I wrote half a reply but then lost it before sending
> > - was still in my drafts :(
> >   
> >>
> >> Only if (dsp_count==1 && hdm_for_passthrough==true), the QEMU shouldn't implement
> >> the HDM decodder for the Host-bridge.  
> > 
> > HDM for pass through means that we do have decoders even for pass through
> > not that we do not.  The name could be better and the code flow
> > perhaps simpler.  
> 
> I got you, I did admit that I misunderstood it before.
> the word *hdm* in hdm_for_passthrough means "Host-managed Device Memory" which was missing *Decoders*
> So it though of it was an option to enable the pass through feature

Good point. That parameter name is less than ideal but we are stuck with it :(

> 
> Per CXL SPEC "8.2.4.20 CXL HDM Decoder Capability Structure",
> I read it as "zero capability structure instance is optional, so it should disable by default",
> while the QEMU implemented it as enabled by default.

It is optional whether to have the structure in this case, but not whether to program it if
it is there.  The spec talks about when you must have it (multiple downstream targets).

There is no case of disabled by default.  A host may or may not implement it in the laid
out cases.

> 
> This annoyed me when I tried to implement provisioning HDM decoders(the guest will construct
> CXL region by them) in QEMU.

Faking a firmware configured setup?

Jonathan

> 
> Thanks
> Zhijian
> 
> 
> >   
> >>
> >> But previous code didn't follow this.  
> >   
> >> Thanks
> >> Zhijian
> >>
> >> On 23/03/2025 16:04, Li Zhijian wrote:  
> >>> Reverse the logical condition for HDM passthrough support in
> >>> pci_expander_bridge. This patch ensures the HDM passthrough condition
> >>> is evaluated only when hdm_for_passthrough is set to true, aligning
> >>> behavior with intended semantics and comments.
> >>>
> >>> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> >>> ---
> >>>
> >>> This change corrects what appears to be a previous mistake in logic
> >>> regarding HDM passthrough conditions.
> >>> ---
> >>>    hw/pci-bridge/pci_expander_bridge.c | 2 +-
> >>>    1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expander_bridge.c
> >>> index 3396ab4bdd..25f8922d76 100644
> >>> --- a/hw/pci-bridge/pci_expander_bridge.c
> >>> +++ b/hw/pci-bridge/pci_expander_bridge.c
> >>> @@ -307,7 +307,7 @@ static void pxb_cxl_dev_reset(DeviceState *dev)
> >>>         * The CXL specification allows for host bridges with no HDM decoders
> >>>         * if they only have a single root port.
> >>>         */
> >>> -    if (!PXB_CXL_DEV(dev)->hdm_for_passthrough) {  
> > 
> > This makes us only check the number of ports if we are not
> > providing hdm decoders for passthrough ports.
> > 
> > If we are providing HDM Decoders anyway we don't care how many
> > ports there are so the 0 value is fine.
> >   
> >>> +    if (PXB_CXL_DEV(dev)->hdm_for_passthrough) {
> >>>            dsp_count = pcie_count_ds_ports(hb->bus);
> >>>        }
> >>>        /* Initial reset will have 0 dsp so wait until > 0 *  
> >  

