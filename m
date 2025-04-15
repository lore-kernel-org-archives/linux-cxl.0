Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B7C2260C
	for <linux-cxl@vger.kernel.org>; Tue, 15 Apr 2025 16:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744735645; cv=none; b=juQV26b0msJKWxmdYRsfpvbNy240H+fP2p6BVJxs8qiHYVB6XfTKWXpj797Z4p3+bI1/N0KvY1LvIz6pmFFiebhgYbuRsDwkrB78zbjgKd9qz2d4nZoALVXRIXRF70qPwl1E7CN1Lgq9m80bc4ptFk0DDX0B7KT3bsl0njzfHZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744735645; c=relaxed/simple;
	bh=QqxeQ7UuN0S2oEYnthn+pvA22+3YyJYo4YKVdbtJZNQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EKDhM8+TJFsaWqhebNbvFYMbPX7EMkaMBomdUi1rEz4/w/KD75pDnapN4Ri+i6Thvot5EfZFVaotGsWZUB5w8nPXjFkiXvARl+hlnAQ1g7gJvu9+uTb/TTRrzjPxqOsxf6WmevDpudjcXOl1OEe5+E5wP5Xm+KiN1s4YJ/mXkbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZcVMs6yZjz6M4Mm;
	Wed, 16 Apr 2025 00:43:21 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id B6450140144;
	Wed, 16 Apr 2025 00:47:19 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 15 Apr
 2025 18:47:19 +0200
Date: Tue, 15 Apr 2025 17:47:17 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Fan Ni
	<fan.ni@samsung.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH] hw/pci-bridge/pci_expander_bridge: Fix HDM passthrough
 condition
Message-ID: <20250415174717.00001509@huawei.com>
In-Reply-To: <e2933a3b-7600-4f84-bfa9-d7b59dafb939@fujitsu.com>
References: <20250323080420.935930-1-lizhijian@fujitsu.com>
	<e2933a3b-7600-4f84-bfa9-d7b59dafb939@fujitsu.com>
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
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 7 Apr 2025 02:59:20 +0000
"Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com> wrote:

> Ping

Sorry, I wrote half a reply but then lost it before sending
- was still in my drafts :(

> 
> Only if (dsp_count==1 && hdm_for_passthrough==true), the QEMU shouldn't implement
> the HDM decodder for the Host-bridge.

HDM for pass through means that we do have decoders even for pass through
not that we do not.  The name could be better and the code flow
perhaps simpler.

> 
> But previous code didn't follow this.

> Thanks
> Zhijian
> 
> On 23/03/2025 16:04, Li Zhijian wrote:
> > Reverse the logical condition for HDM passthrough support in
> > pci_expander_bridge. This patch ensures the HDM passthrough condition
> > is evaluated only when hdm_for_passthrough is set to true, aligning
> > behavior with intended semantics and comments.
> > 
> > Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> > ---
> > 
> > This change corrects what appears to be a previous mistake in logic
> > regarding HDM passthrough conditions.
> > ---
> >   hw/pci-bridge/pci_expander_bridge.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expander_bridge.c
> > index 3396ab4bdd..25f8922d76 100644
> > --- a/hw/pci-bridge/pci_expander_bridge.c
> > +++ b/hw/pci-bridge/pci_expander_bridge.c
> > @@ -307,7 +307,7 @@ static void pxb_cxl_dev_reset(DeviceState *dev)
> >        * The CXL specification allows for host bridges with no HDM decoders
> >        * if they only have a single root port.
> >        */
> > -    if (!PXB_CXL_DEV(dev)->hdm_for_passthrough) {

This makes us only check the number of ports if we are not
providing hdm decoders for passthrough ports.

If we are providing HDM Decoders anyway we don't care how many
ports there are so the 0 value is fine.

> > +    if (PXB_CXL_DEV(dev)->hdm_for_passthrough) {
> >           dsp_count = pcie_count_ds_ports(hb->bus);
> >       }
> >       /* Initial reset will have 0 dsp so wait until > 0 *  

